#
# IPC.jl --
#
# Inter-Process Communication for Julia.
#
#------------------------------------------------------------------------------
#
# This file is part of IPC.jl released under the MIT "expat" license.
# Copyright (C) 2016-2018, Éric Thiébaut (https://github.com/emmt/IPC.jl).
#

__precompile__(true)

module IPC

using Compat
using Compat.Printf
using Compat.Sys: isapple, isbsd, islinux, isunix, iswindows

import Base: convert, unsafe_convert,
    lock, unlock, trylock, timedwait, broadcast

export
    CLOCK_MONOTONIC,
    CLOCK_REALTIME,
    DynamicMemory,
    FileDescriptor,
    FileStat,
    IPC_NEW,
    Semaphore,
    SharedMemory,
    ShmArray,
    ShmId,
    ShmInfo,
    ShmMatrix,
    ShmVector,
    SigAction,
    SigInfo,
    SigSet,
    TimeSpec,
    TimeVal,
    TimeoutError,
    WrappedArray,
    clock_getres,
    clock_gettime,
    clock_settime,
    gettimeofday,
    nanosleep,
    post,
    shmat,
    shmcfg,
    shmdt,
    shmget,
    shmid,
    shminfo!,
    shminfo,
    sigaction!,
    sigaction,
    signal,
    sigpending!,
    sigpending,
    sigprocmask!,
    sigprocmask,
    sigqueue,
    sigsuspend,
    sigwait!,
    sigwait,
    trywait

const PARANOID = true

if stat(joinpath(@__DIR__, "constants.jl")).nlink == 0
    error("File `constants.jl` does not exists.  Run `make all` in the `deps` directory of the `IPC` module.")
end

@static if VERSION < v"0.7.0-DEV.2562"
    # FIXME: This should be done by the Compat module?
    @inline function Base.finalizer(func::Function, obj)
        finalizer(obj, func)
        return obj
    end
end

include("constants.jl")
include("types.jl")
include("wrappedarrays.jl")
include("unix.jl")
include("utils.jl")
include("shm.jl")
include("semaphores.jl")
include("signals.jl")
include("mutex.jl")

@deprecate IPC_NEW IPC.PRIVATE

end # module IPC
