Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC2C206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhMVpHrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfCFToc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:44:32 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40565 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCFTob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:44:31 -0500
Received: by mail-wm1-f45.google.com with SMTP id g20so6996989wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=h36xFIozGiHBeWPManXroIsrCXbD3dCj6Uech9ROSF0=;
        b=XhMVpHrd20Em2ugeaqihEZiitIOzefdP2vajW15xmYWuqyJKDKbxN8aqPiDTMcdVWv
         00jX3+5zrwAPowdxucRjMPbplIFhcJcRGxYOLiA7iurlRm2AlobcIZX20gNuCqxVX+3p
         T8QzSAaLpSVTFWGAwxgfJBFSykumnkJ4952GSFc5MTvM2k1fIvoy+accz8UmrfsAogjT
         TzuOI74D8BnHce8wiJ7/+tMcGzPQTrjIUY7lhSN23ye0C4p6eD/3yiWMMgJmL4h7jZEY
         4iuqBhlAn/KYSaouqqZ29r1UNULJhaazhIVSYBXg0N57FTEhVleuj4M47sk5um3ajU5l
         UVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=h36xFIozGiHBeWPManXroIsrCXbD3dCj6Uech9ROSF0=;
        b=d+U7C0cXqd/PuARWt8EC5MTaK+eZJhONbNL2DnLLjDop63giO+5yS4x7aIKGN0t8TU
         rsy37vDgLXKf0+RqQ7KEUXhmshGuaZGSy1e5wiSIEEK7ag+61RNonpjJ+F9cR0zRKFYl
         QZoZy9flmkbIl6lSmQY2xYRygrYLVyLlMJTnQuxd7fDSSMiD58vbusXhTtFibdGKcZ6o
         JaLRKtl51mlUH3lu1bsAyl1ZdfqoXeyiQdyv569o5uJMS/D7P+lRwAPvdji0KIbLOHw7
         RZfzNizv0mTFQMNIz+ZufEcvurZX5xrCsF7dHEXIW0onni/Ob0t7bVL7a2DgLPkO8OvF
         4MHw==
X-Gm-Message-State: APjAAAVX38YKF1YdGqjjwpeGwv0kI9GHCA8zbIA5dGEZSNG/Qhtgooul
        KHSMLexBlPcXIw+QX4srIgo=
X-Google-Smtp-Source: APXvYqwXzh549oQz8BudpDYdc/5R0j8ksIKVfY821e8y6XU3oZadBqRw6g/SdjV/uPRZVX2howPYjQ==
X-Received: by 2002:a1c:eb17:: with SMTP id j23mr3316757wmh.86.1551901467928;
        Wed, 06 Mar 2019 11:44:27 -0800 (PST)
Received: from ?IPv6:2001:a61:2408:5d01:a331:dec4:9a86:23ff? ([2001:a61:2408:5d01:a331:dec4:9a86:23ff])
        by smtp.gmail.com with ESMTPSA id w4sm3077895wrk.85.2019.03.06.11.44.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 11:44:26 -0800 (PST)
Cc:     mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-5.00 is released
Message-ID: <a2fc27e0-8315-356c-d4d7-4724ed2a99e5@gmail.com>
Date:   Wed, 6 Mar 2019 20:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

After a long gap, the Linux man-pages maintainer proudly announces:

    man-pages-5.00 - man pages for Linux

This release resulted from patches, bug reports, reviews, and comments
from around 130 contributors. More than 600 commits changed near 400
pages. 3 new pages were added, and several others have been
substantially enhanced.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.00

A short summary of the release is blogged at:
http://linux-man-pages.blogspot.com/2019/03/man-pages-500-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.00 ====================

Released: 2019-03-06, Munich


New and rewritten pages
-----------------------

s390_guarded_storage.2
    Eugene Syromyatnikov
        New page documenting s390_guarded_storage(2) s390-specific system call

address_families.7
    Michael Kerrisk  [Eugene Syromyatnikov]
        New page that contains details of socket address families
            There is too much detail in socket(2). Move most of it into
            a new page instead.

bpf-helpers.7
    Michael Kerrisk  [Daniel Borkmann, Quentin Monnet]
        Add new man page for eBPF helper functions
            (autogenerated from kernel source files)


Newly documented interfaces in existing pages
---------------------------------------------

fanotify_init.2
fanotify.7
    nixiaoming  [Amir Goldstein, Michael Kerrisk]
        Document FAN_REPORT_TID
            fanotify_init.2: add new flag FAN_REPORT_TID
            fanotify.7: update description of member pid in
                struct fanotify_event_metadata
    Amir Goldstein
        Document FAN_MARK_FILESYSTEM
            Monitor fanotify events on the entire filesystem.
    Matthew Bobrowski  [Amir Goldstein]
        Document FAN_OPEN_EXEC and FAN_OPEN_EXEC_PERM

io_submit.2
    Adam Manzanares
        Document IOCB_FLAG_IOPRIO

msgctl.2
semctl.2
shmctl.2
    Davidlohr Bueso  [Joe Lawrence, Michael Kerrisk]
        Document STAT_ANY commands

prctl.2
    Konrad Rzeszutek Wilk  [Michael Kerrisk]
        Document PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL

sched_setattr.2
    Claudio Scordino  [Michael Kerrisk]
        Document SCHED_FLAG_DL_OVERRUN and SCHED_FLAG_RECLAIM

socket.2
    Tobias Klauser
        Document AF_XDP
            Document AF_XDP added in Linux 4.18.

inotify.7
    Henry Wilson
        Document IN_MASK_CREATE

unix.7
    Michael Kerrisk
        Document SO_PASSSEC
    Michael Kerrisk
        Document SCM_SECURITY ancillary data


Changes to individual pages
---------------------------

clock_getres.2
    Michael Kerrisk  [Jens Thoms Toerring]
        CLOCK_MONOTONIC_RAW does not count while the system is suspended
    Michael Kerrisk  [Jens Thoms Toerring]
        On Linux CLOCK_MONOTONIC counts time that the system has run since boot
    Michael Kerrisk  [Jens Thoms Toerring]
        CLOCK_MONOTONIC does not count while the system is suspended

clone.2
    Michael Kerrisk
        Rework discussion of threads and signals
            The discussion is phrased in terms of signals sent using kill(2),
            but applies equally to a signal sent by the kernel.
    Jann Horn
        Pending CLONE_NEWPID prevents thread creation
    Michael Kerrisk
        Clarify the discussion of threads and signals
            And explicitly introduce the terms "process-directed" and
            "thread-directed" signals.
    Eugene Syromyatnikov
        Add information about clone and clone2 on IA-64

epoll_wait.2
    Michael Kerrisk
        Clarify the behavior when epoll_wait()-ing on an empty interest list
    Michael Kerrisk
        Note that epoll_wait() round robins through the set of ready descriptors

fcntl.2
    Michael Kerrisk
        Actual pipe capacity may in practice be less than nominal capacity
            The number of bytes that can be written to the pipe may be less
            (sometimes substantially less) than the nominal capacity.
madvise.2
    Michal Hocko  [Niklas Hambüchen]
        MADV_FREE clarify swapless behavior

memfd_create.2
    Marc-André Lureau
        Update hugetlb file-sealing support

mmap.2
    Jann Horn  [Michal Hocko, William Kucharski]
        Fix description of treatment of the hint
            The current manpage reads as if the kernel will always pick a free
            space close to the requested address, but that's not the case.

mount.2
    Michael Kerrisk
        Clearly distinguish per-mount-point vs per-superblock mount flags
    Michael Kerrisk
        MS_SILENT is ignored when changing propagation type
    Michael Kerrisk
        Attempts to change MS_SILENT setting during remount are silently ignored
    Michael Kerrisk
        Clarify that per-superblock flags are shared during remount
    Michael Kerrisk
        Mandatory locking also now requires CONFIG_MANDATORY_FILE_LOCKING
    Michael Kerrisk  [Simone Piccardi]
        Add MS_STRICTATIME to list of flags that can be used in remount
    Michael Kerrisk
        EACCES: note some reasons why a filesystem may be read-only

perf_event_open.2
    Vince Weaver  [Wang Nan]
        Document the PERF_EVENT_IOC_PAUSE_OUTPUT ioctl
            The PERF_EVENT_IOC_PAUSE_OUTPUT ioctl was introduced in Linux 4.7.
    Vince Weaver
        Fix wording in multiplexing description
    Vince Weaver
        Clarify exclude_idle
    Vince Weaver
        Document the PERF_EVENT_IOC_QUERY_BPF ioctl
    Vince Weaver
        Document the PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl
    Vince Weaver
        Fix prctl behavior description

pivot_root.2
    Elvira Khabirova
        Explain the initramfs case and point to switch_root(8).

prctl.2
    Benjamin Peterson
        PR_SET_MM_EXE_FILE may now be used as many times as desired
    Michael Kerrisk
        Add some further historical details on PR_SET_MM_EXE_FILE
    Michael Kerrisk  [Jann Horn]
        Explain the circumstances in which the parent-death signal is sent
    Michael Kerrisk
        Rework the PR_SET_PDEATHSIG description a little, for easier readability
    Michael Kerrisk
        Add additional info on PR_SET_PDEATHSIG
            The signal is process directed and the siginfo_t->si_pid
            filed contains the PID of the terminating parent.
    Michael Kerrisk
        Note libcap(3) APIs for operating on ambient capability set
            (However, the libcap APIs do not yet seem to have
            manual pages...)
    Michael Kerrisk
        Mention libcap APIs for operating on capability bounding set

sched_setparam.2
    Michael Kerrisk
        Clarify that scheduling parameters are per-thread (not per-process)

setns.2
    Michael Kerrisk
        When joining a user namespace, it must be a descendant user namespace
    Michael Kerrisk
        Note capability requirements for changing PID namespace
        Note capability requirements for changing network, IPC, or UTS namespace
        Note capability requirements for changing cgroup namespace
    Michael Kerrisk
        Some text restructuring and reordering

socketpair.2
    Eugene Syromyatnikov
        Note that AF_TIPC also supports socketpair(2)
            Introduced by Linux commit v4.12-rc1~64^3~304^2~1.

syscalls.2
    Eugene Syromyatnikov  [Michael Kerrisk]
        Update syscall table
            Added: arc_gettls, arc_settls, arc_usr_cmpxchg, arch_prctl,
            atomic_barrier, atomic_cmpxchg_32, bfin_spinlock, breakpoint,
            clone2, cmpxchg, cmpxchg_badaddr, dma_memcpy, execv, get_tls,
            getdomainname, getdtablesize, gethostname, getxgid, getxpid,
            getxuid, metag_get_tls, metag_set_fpu_flags,metag_set_tls,
            metag_set_global_bit, newfstatat, old_adjtimex, oldumount,
            or1k_atomic, pread, pwrite, riscv_flush_icache,
            sched_get_affinity, sched_set_affinity, set_tls, setaltroot,
            sethae, setpgrp, spill, sram_alloc, sram_free, swapcontext,
            switch_endian, sys_debug_setcontext, syscall, sysmips, timerfd,
            usr26, usr32, xtensa.

            Uncommented: memory_ordering

            Renamed: ppc_rtas to rtas (__NR_rtas), ppc_swapcontext to
            swapcontext (__NR_swacontext).

vmsplice.2
    Andrei Vagin
        Note that vmsplice can splice pages from pipe to memory

wait.2
    Michael Kerrisk
        Add some cross references to core(5)

malloc.3
    Michael Kerrisk
        Add reference to glibc MallocInternals wiki
proc.5
    Michael Kerrisk  [Philip Dumont]
        Document /proc/[tid]
            See also https://bugzilla.kernel.org/show_bug.cgi?id=201441
    Michael Kerrisk
        Add an overview section describing the groups of files under /proc
    Keno Fischer  [Robert O'Callahan]
        Correct description of NStgid
    Lucas Werkmeister
        Document fdinfo format for timerfd
    Michael Kerrisk
        Document /proc/PID/status CoreDumping field
    Michael Kerrisk
        Add a few details on /proc/PID/fdinfo timerfd
    Michael Kerrisk
        Document /proc/meminfo KReclaimable field
    Michael Kerrisk
        Explain how to determine top-most mount in /proc/PID/mountinfo
            Explain how to determine the top-most mount at a particular
            location by inspecting /proc/PID/mountinfo.
    Michael Kerrisk
        Fix description of /proc/PID/* ownership to account for user namespaces
    Elvira Khabirova
        Describe ambiguities in /proc/<pid>/maps
    Nikola Forró
        Document /proc/[pid]/status Speculation_Store_Bypass field
    Michael Kerrisk
        Setting dumpable to 1 reverts ownership of /proc/PID/* to effective IDs
    Michael Kerrisk
        Document /proc/Meminfo LazyFree field
    Michael Kerrisk
        Fix kernel source pathname for soft-dirty documentation
    Michael Kerrisk
        /proc/[pid]/status VmPMD field was removed in Linux 4.15

capabilities.7
    Michael Kerrisk
        Fix some imprecisions in discussion of namespaced file capabilities
            The file UID does not come into play when creating a v3
            security.capability extended attribute.
    Michael Kerrisk
        Note that v3 security.attributes are transparently created/retrieved
    Michael Kerrisk
        Improve the discussion of when file capabilities are ignored
            The text stated that the execve() capability transitions are not
            performed for the same reasons that setuid and setgid mode bits
            may be ignored (as described in execve(2)). But, that's not quite
            correct: rather, the file capability sets are treated as empty
            for the purpose of the capability transition calculations.
    Michael Kerrisk
        Substantially rework "Capabilities and execution of programs by root"
            Rework for improved clarity, and also to include missing details
            on the case where (1) the binary that is being executed has
            capabilities attached and (2) the real user ID of the process is
            not 0 (root) and (3) the effective user ID of the process is 0
            (root).
    Marcus Gelderie
        Add details about SECBIT_KEEP_CAPS
            The description of SECBIT_KEEP_CAPS is misleading about the
            effects on the effective capabilities of a process during a
            switch to nonzero UIDs.  The effective set is cleared based on
            the effective UID switching to a nonzero value, even if
            SECBIT_KEEP_CAPS is set. However, with this bit set, the
            effective and permitted sets are not cleared if the real and
            saved set-user-ID are set to nonzero values.
    Michael Kerrisk
        Add a subsection on per-user-namespace "set-user-ID-root" programs
    Michael Kerrisk
        Rework discussion of exec and UID 0, correcting a couple of details
            Clarify the "Capabilities and execution of programs by root"
            section, and correct a couple of details:
            * If a process with rUID == 0 && eUID != 0 does an exec,
              the process will nevertheless gain effective capabilities
              if the file effective bit is set.
            * Set-UID-root programs only confer a full set of capabilities
              if the binary does not also have attached capabilities.
    Michael Kerrisk
        Correct the description of SECBIT_KEEP_CAPS
    Michael Kerrisk
        Document the 'no_file_caps' kernel command-line option

cgroups.7
    Michael Kerrisk
        Add more detail on v2 'cpu' controller and realtime threads
            Explicitly note the scheduling policies that are relevant for the
            v2 'cpu' controller.
    Michael Kerrisk
        Document the use of 'cgroup_no_v1=named' to disable v1 named hierarchies
            This feature was added in Linux 5.0.
    Michael Kerrisk
        Reframe the text on delegation to include more details about cgroups v1
    Michael Kerrisk  [Balbir Singh, Marcus Gelderie]
        Soften the discussion about delegation in cgroups v1
            Balbir pointed out that v1 delegation was not an accidental
            feature.

epoll.7
    Michael Kerrisk
        Introduce the terms "interest list" and "ready list"
    Michael Kerrisk
        Note that edge-triggered notification wakes up only one waiter
            Note a useful performance benefit of EPOLLET: ensuring that
            only one of multiple waiters (in epoll_wait()) is woken
            up when a file descriptor becomes ready.

feature_test_macros.7
    Michael Kerrisk  [Andreas Westfeld]
        Add more detail on why FTMs must be defined before including any header

namespaces.7
    Michael Kerrisk
        List factors that may pin a namespace into existence
            Various factors may pin a namespace into existence, even when it
            has no member processes.
    Michael Kerrisk  [Tycho Kirchner]
        Briefly explain why CAP_SYS_ADMIN is needed to create nonuser namespaces

pid_namespaces.7
    Michael Kerrisk
        Clarify the semantics for the adoption of orphaned processes
            Because of setns() semantics, the parent of a process may reside
            in the outer PID namespace. If that parent terminates, then the
            child is adopted by the "init" in the outer PID namespace (rather
            than the "init" of the PID namespace of the child).
    Michael Kerrisk
        Note a detail of /proc/PID/ns/pid_for_children behavior
            After clone(CLONE_NEWPID), /proc/PID/ns/pid_for_children is empty
            until the first child is created. Verified by experiment.
    Michael Kerrisk
        Note that a process can do unshare(CLONE_NEWPID) only once

unix.7
    Michael Kerrisk
        Enhance the description of SCM_RIGHTS
            The existing description is rather thin. More can be said.
    Michael Kerrisk
        There is a limit on the size of the file descriptor array for SCM_RIGHTS
            The limit is defined in the kernel as SCM_MAX_FD (253).
    Michael Kerrisk  [Felipe Gasper]
        Clarify SO_PASSCRED behavior
    Michael Kerrisk
        Explicitly note that SO_PASSCRED provides SCM_CREDENTIALS messages
    Michael Kerrisk
        If the buffer to receive SCM_RIGHTS FDs is too small, FDs are closed
    Michael Kerrisk
        One must send at least one byte of real data with ancillary data
    Michael Kerrisk
        Ancillary data forms a barrier when receiving on a stream socket
    Michael Kerrisk
        When sending ancillary data, only one item of each type may be sent
    Michael Kerrisk
        Clarify treatment of incoming ancillary data if 'msg_control' is NULL
    Michael Kerrisk
        Note behavior if buffer to receive ancillary data is too small

ld.so.8
    Michael Kerrisk  [Florian Weimer, David Newall]
        Document the --preload command-line option added in glibc 2.30

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
