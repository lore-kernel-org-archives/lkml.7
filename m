Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DAC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C95206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564473848;
	bh=+zsdeJwPWYkapMJyixClyrXCQsz/2ttRKCWKDLOmwUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mbu8dTUFXTX2qdBdbSAD8zaXZ8UDqdvGgHR/Ok14ee4fjuapIFGiC0xeSUAyvgQa0
	 +bT+YCpGib8Q+Q5Eb1jIQ6DXjsMs3qIFp/wPa75blCaTUxEQ4lMRixzue73Vy/G1iK
	 kNhoB7lrlocMbeuqJ+qBmRUJdABEnqQgwoJCgGWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfG3IEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:04:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfG3IEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:04:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so64760024wru.0;
        Tue, 30 Jul 2019 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6pmTT3OOk61PvET0hwJkLVeROEndlYypFPOc3quf70=;
        b=YzkUkgNFYV4xzqnMtL28MKOwMSl8qsKp2EFmVdaetKX3KPFfSvcy6I8A4mvM7Pfz5d
         eupcW0K/u9HbxLwLAmEtA72ON2O4QoWcfeCKzpLPiRKqq7R2ZoGxZ7tbWif7pjcQFGUj
         i4lgDOSIg+cEQhEqBPrjs6rA3pZ/Jy08E5eM1Ubs0w+RGsbPgnUYF9FdjUpHUKsscK6H
         UDLLzC5wBRcUEdkMkUubXE0nE6Q0+GIRELKuU5jZ0RyfGHswh5lEasELmWbi2IMDgasS
         /8xSWzX8/nbfe1p1o6RYgAMI3VTsQlrYnaTOxXdYI9EVkIbK7aoCv9RWMBHPe0GLVvDE
         Gcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6pmTT3OOk61PvET0hwJkLVeROEndlYypFPOc3quf70=;
        b=hE9KunFaBlWmoEapyy0SunC5q48DhLHjYnzyJNXKKGiQRQwzTu5/oauO8P136ivViI
         YcyWHQ/aIDpDpR/aNgZKHwOWrHXwzmQeOzQxCEL2L3kR8ywRoKNnT6hd2h182bSGvfWe
         P2SaW+AdTi0kByY2/sxKXNjZwuEzqoet0a2tzDDrI2eMZYdLeG/T13H5wmuYnOK0TAki
         VdMhGtVwVskWJr8FoUv6h5rAAYzMyuma74MkFZL3/9STDeJNyzGQ3pdxrf6dY1huGmeK
         KmwTYi3iRfS2cFLZoXdhq8LQmqkhYgZ14YK/kQYjlY5g5AEXUklFBbmrL5dHWC0QaD/o
         kDkw==
X-Gm-Message-State: APjAAAUoAKt7P7dQ1gIUn0dTPtEAGrSMcCXFwXoXFUtrrpvEXSCnIZvq
        UlO+N0NuiiUghUMn/DxVqs4=
X-Google-Smtp-Source: APXvYqwerB0CXIA3O4zqT0EQVHZinvfS0apTYLt9w0eFenoyZZ+z3IhTnPZrU0AL9rxagCDFoo0iHA==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr42645247wrv.247.1564473841203;
        Tue, 30 Jul 2019 01:04:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g12sm93423715wrv.9.2019.07.30.01.03.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 01:04:00 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:03:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 000/107] perf/core improvements and fixes
Message-ID: <20190730080358.GA115870@gmail.com>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b3c303be4c35856945cb17ec639b94637447dae2:
> 
>   Merge tag 'perf-urgent-for-mingo-5.3-20190729' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-07-29 23:24:07 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190729
> 
> for you to fetch changes up to 123a039d0d54de6d5bafd551e7aa17569e13e315:
> 
>   perf vendor events power9: Added missing event descriptions (2019-07-29 18:34:47 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use BPF_MAP_TYPE_PROG_ARRAY + bpf_tail_call() for augmenting raw syscalls,
>     i.e. copy pointers passed to/from userspace. The use of a table per syscall
>     to tell the BPF program what to copy made the raw_syscalls:sys_enter/exit
>     programs a bit complex, the scratch space would have to be bigger to allow
>     for checking all args to see which ones were a pathname, so use a PROG_ARRAY
>     map instead, test it with syscalls that receive multiple pathnames at
>     different pairs of arguments (rename, renameat, etc).
> 
>   - Beautify various syscalls using this new infrastructure, and also add code
>     that looks for syscalls with BPF augmenters, such as "open", and then reuse
>     it with syscalls not yet having a specific augmenter, but that copies the
>     same argument with the same type, say "statfs" can initially reuse "open",
>     beautifier, as both have as its first arg a "const char *".
> 
>   - Do not using fd->pathname beautifier when the 'close' syscall isn't enabled,
>     as we can't invalidate that mapping.
> 
> core:
> 
>   Jiri Olsa:
> 
>   - Introduce tools/perf/lib/, that eventually will move to tools/lib/perf/, to
>     allow other tools to use the abstractions and code perf uses to set up
>     the perf ring buffer and set up the many possible combinations in allowed
>     by the kernel, starting with 'struct perf_evsel' and 'struct perf_evlist'.
> 
> perf vendor events:
> 
>   Michael Petlan:
> 
>   - Add missing event description to power9 event definitions.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (27):
>       perf include bpf: Add bpf_tail_call() prototype
>       perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !
>       perf evsel: Store backpointer to attached bpf_object
>       perf trace: Add pointer to BPF object containing __augmented_syscalls__
>       perf trace: Look up maps just on the __augmented_syscalls__ BPF object
>       perf trace: Order -e syscalls table
>       perf trace: Add BPF handler for unaugmented syscalls
>       perf trace: Allow specifying the bpf prog to augment specific syscalls
>       perf trace: Put the per-syscall entry/exit prog_array BPF map infrastructure in place
>       perf trace: Handle raw_syscalls:sys_enter just like the BPF_OUTPUT augmented event
>       perf augmented_raw_syscalls: Add handler for "openat"
>       perf augmented_raw_syscalls: Switch to using BPF_MAP_TYPE_PROG_ARRAY
>       perf augmented_raw_syscalls: Support copying two string syscall args
>       perf trace: Look for default name for entries in the syscalls prog array
>       perf augmented_raw_syscalls: Rename augmented_args_filename to augmented_args_payload
>       perf augmented_raw_syscalls: Augment sockaddr arg in 'connect'
>       perf trace beauty: Make connect's addrlen be printed as an int, not hex
>       perf trace beauty: Disable fd->pathname when close() not enabled
>       perf trace beauty: Do not try to use the fd->pathname beautifier for bind/connect fd arg
>       perf trace beauty: Beautify 'sendto's sockaddr arg
>       perf trace beauty: Beautify bind's sockaddr arg
>       perf trace beauty: Add BPF augmenter for the 'rename' syscall
>       perf trace: Forward error codes when trying to read syscall info
>       perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages
>       perf trace: Preallocate the syscall table
>       perf trace: Reuse BPF augmenters from syscalls with similar args signature
>       perf trace: Add "sendfile64" alias to the "sendfile" syscall
> 
> Jiri Olsa (79):
>       perf stat: Move loaded out of struct perf_counts_values
>       perf cpu_map: Rename struct cpu_map to struct perf_cpu_map
>       perf tools: Rename struct thread_map to struct perf_thread_map
>       perf evsel: Rename struct perf_evsel to struct evsel
>       perf evlist: Rename struct perf_evlist to struct evlist
>       perf evsel: Rename perf_evsel__init() to evsel__init()
>       perf evlist: Rename perf_evlist__init() to evlist__init()
>       perf evlist: Rename perf_evlist__new() to evlist__new()
>       perf evlist: Rename perf_evlist__delete() to evlist__delete()
>       perf evsel: Rename perf_evsel__delete() to evsel__delete()
>       perf evsel: Rename perf_evsel__new() to evsel__new()
>       perf evlist: Rename perf_evlist__add() to evlist__add()
>       perf evlist: Rename perf_evlist__remove() to evlist__remove()
>       perf evsel: Rename perf_evsel__open() to evsel__open()
>       perf evsel: Rename perf_evsel__enable() to evsel__enable()
>       perf evsel: Rename perf_evsel__disable() to evsel__disable()
>       perf evsel: Rename perf_evsel__apply_filter() to evsel__apply_filter()
>       perf evsel: Rename perf_evsel__cpus() to evsel__cpus()
>       perf evlist: Rename perf_evlist__open() to evlist__open()
>       perf evlist: Rename perf_evlist__close() to evlist__close()
>       perf evlist: Rename perf_evlist__enable() to evlist__enable()
>       perf evlist: Rename perf_evlist__disable() to evlist__disable()
>       libperf: Make libperf.a part of the perf build
>       libperf: Add build version support
>       libperf: Add libperf to the python.so build
>       libperf: Add perf/core.h header
>       libperf: Add debug output support
>       libperf: Add perf_cpu_map struct
>       libperf: Add perf_cpu_map__dummy_new() function
>       libperf: Add perf_cpu_map__get()/perf_cpu_map__put()
>       libperf: Add perf_thread_map struct
>       libperf: Add perf_thread_map__new_dummy() function
>       libperf: Add perf_thread_map__get()/perf_thread_map__put()
>       libperf: Add perf_evlist and perf_evsel structs
>       libperf: Include perf_evsel in evsel object
>       libperf: Include perf_evlist in evlist object
>       libperf: Add perf_evsel__init function
>       libperf: Add perf_evlist__init() function
>       libperf: Add perf_evlist__add() function
>       libperf: Add perf_evlist__remove() function
>       libperf: Add nr_entries to struct perf_evlist
>       libperf: Move perf_event_attr field from perf's evsel to libperf's perf_evsel
>       libperf: Add perf_cpu_map__new()/perf_cpu_map__read() functions
>       libperf: Move zalloc.o into libperf
>       libperf: Add perf_evlist__new() function
>       libperf: Add perf_evsel__new() function
>       libperf: Add perf_evlist__for_each_evsel() iterator
>       libperf: Add perf_evlist__delete() function
>       libperf: Add perf_evsel__delete() function
>       libperf: Add cpus to struct perf_evsel
>       libperf: Add own_cpus to struct perf_evsel
>       libperf: Add threads to struct perf_evsel
>       libperf: Add has_user_cpus to struct perf_evlist
>       libperf: Add cpus to struct perf_evlist
>       libperf: Add threads to struct perf_evlist
>       libperf: Add perf_evlist__set_maps() function
>       libperf: Adopt xyarray class from perf
>       libperf: Move fd array from perf's evsel to lobperf's perf_evsel class
>       libperf: Move nr_members from perf's evsel to libperf's perf_evsel
>       libperf: Adopt the readn()/writen() functions from tools/perf
>       libperf: Adopt perf_evsel__alloc_fd() function from tools/perf
>       libperf: Adopt simplified perf_evsel__open() function from tools/perf
>       libperf: Adopt simplified perf_evsel__close() function from tools/perf
>       libperf: Adopt perf_evsel__read() function from tools/perf
>       libperf: Adopt perf_evsel__enable()/disable()/apply_filter() functions
>       libperf: Add perf_cpu_map__for_each_cpu() macro
>       libperf: Add perf_evsel__cpus()/threads() functions
>       libperf: Adopt simplified perf_evlist__open()/close() functions from tools/perf
>       libperf: Adopt perf_evlist__enable()/disable() functions from perf
>       libperf: Add perf_evsel__attr() function
>       libperf: Add install targets
>       libperf: Add tests support
>       libperf: Add perf_cpu_map test
>       libperf: Add perf_thread_map test
>       libperf: Add perf_evlist test
>       libperf: Add perf_evsel tests
>       libperf: Add perf_evlist__enable/disable test
>       libperf: Add perf_evsel__enable/disable test
>       libperf: Initial documentation
> 
> Michael Petlan (1):
>       perf vendor events power9: Added missing event descriptions
> 
>  tools/perf/Makefile.config                         |    1 +
>  tools/perf/Makefile.perf                           |   31 +-
>  tools/perf/arch/arm/util/auxtrace.c                |    8 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |   82 +-
>  tools/perf/arch/arm64/util/arm-spe.c               |   24 +-
>  tools/perf/arch/arm64/util/header.c                |    6 +-
>  tools/perf/arch/powerpc/util/kvm-stat.c            |   12 +-
>  tools/perf/arch/s390/util/auxtrace.c               |   12 +-
>  tools/perf/arch/s390/util/kvm-stat.c               |    8 +-
>  tools/perf/arch/x86/tests/intel-cqm.c              |    8 +-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   30 +-
>  tools/perf/arch/x86/util/auxtrace.c                |   10 +-
>  tools/perf/arch/x86/util/intel-bts.c               |   38 +-
>  tools/perf/arch/x86/util/intel-pt.c                |   82 +-
>  tools/perf/arch/x86/util/kvm-stat.c                |   12 +-
>  tools/perf/bench/epoll-ctl.c                       |    7 +-
>  tools/perf/bench/epoll-wait.c                      |    7 +-
>  tools/perf/bench/futex-hash.c                      |    5 +-
>  tools/perf/bench/futex-lock-pi.c                   |    7 +-
>  tools/perf/bench/futex-requeue.c                   |    7 +-
>  tools/perf/bench/futex-wake-parallel.c             |    6 +-
>  tools/perf/bench/futex-wake.c                      |    7 +-
>  tools/perf/builtin-annotate.c                      |   16 +-
>  tools/perf/builtin-c2c.c                           |   10 +-
>  tools/perf/builtin-diff.c                          |   20 +-
>  tools/perf/builtin-evlist.c                        |    4 +-
>  tools/perf/builtin-ftrace.c                        |   18 +-
>  tools/perf/builtin-inject.c                        |   60 +-
>  tools/perf/builtin-kmem.c                          |   24 +-
>  tools/perf/builtin-kvm.c                           |   46 +-
>  tools/perf/builtin-lock.c                          |   30 +-
>  tools/perf/builtin-mem.c                           |    2 +-
>  tools/perf/builtin-record.c                        |   50 +-
>  tools/perf/builtin-report.c                        |   32 +-
>  tools/perf/builtin-sched.c                         |   96 +-
>  tools/perf/builtin-script.c                        |  167 +--
>  tools/perf/builtin-stat.c                          |  135 +--
>  tools/perf/builtin-timechart.c                     |   46 +-
>  tools/perf/builtin-top.c                           |   71 +-
>  tools/perf/builtin-trace.c                         |  619 +++++++---
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |  284 +++--
>  tools/perf/include/bpf/bpf.h                       |    2 +
>  tools/perf/lib/Build                               |   12 +
>  tools/perf/lib/Documentation/Makefile              |    7 +
>  tools/perf/lib/Documentation/man/libperf.rst       |  100 ++
>  tools/perf/lib/Documentation/tutorial/tutorial.rst |  123 ++
>  tools/perf/lib/Makefile                            |  158 +++
>  tools/perf/lib/core.c                              |   34 +
>  tools/perf/lib/cpumap.c                            |  239 ++++
>  tools/perf/lib/evlist.c                            |  159 +++
>  tools/perf/lib/evsel.c                             |  232 ++++
>  tools/perf/lib/include/internal/cpumap.h           |   17 +
>  tools/perf/lib/include/internal/evlist.h           |   50 +
>  tools/perf/lib/include/internal/evsel.h            |   29 +
>  tools/perf/lib/include/internal/lib.h              |   10 +
>  tools/perf/lib/include/internal/tests.h            |   19 +
>  tools/perf/lib/include/internal/threadmap.h        |   23 +
>  .../perf/{util => lib/include/internal}/xyarray.h  |    6 +-
>  tools/perf/lib/include/perf/core.h                 |   22 +
>  tools/perf/lib/include/perf/cpumap.h               |   23 +
>  tools/perf/lib/include/perf/evlist.h               |   35 +
>  tools/perf/lib/include/perf/evsel.h                |   39 +
>  tools/perf/lib/include/perf/threadmap.h            |   18 +
>  tools/perf/lib/internal.h                          |   18 +
>  tools/perf/lib/lib.c                               |   46 +
>  tools/perf/lib/libperf.map                         |   40 +
>  tools/perf/lib/libperf.pc.template                 |   11 +
>  tools/perf/lib/tests/Makefile                      |   38 +
>  tools/perf/lib/tests/test-cpumap.c                 |   21 +
>  tools/perf/lib/tests/test-evlist.c                 |  186 +++
>  tools/perf/lib/tests/test-evsel.c                  |  125 ++
>  tools/perf/lib/tests/test-threadmap.c              |   21 +
>  tools/perf/lib/threadmap.c                         |   81 ++
>  tools/perf/lib/xyarray.c                           |   33 +
>  .../pmu-events/arch/powerpc/power9/memory.json     |    2 +-
>  .../perf/pmu-events/arch/powerpc/power9/other.json |    8 +-
>  tools/perf/tests/backward-ring-buffer.c            |   18 +-
>  tools/perf/tests/bitmap.c                          |    5 +-
>  tools/perf/tests/bpf.c                             |   12 +-
>  tools/perf/tests/code-reading.c                    |   50 +-
>  tools/perf/tests/cpumap.c                          |   21 +-
>  tools/perf/tests/event-times.c                     |   81 +-
>  tools/perf/tests/event_update.c                    |   13 +-
>  tools/perf/tests/evsel-roundtrip-name.c            |   12 +-
>  tools/perf/tests/evsel-tp-sched.c                  |    8 +-
>  tools/perf/tests/hists_cumulate.c                  |   18 +-
>  tools/perf/tests/hists_filter.c                    |   10 +-
>  tools/perf/tests/hists_link.c                      |   10 +-
>  tools/perf/tests/hists_output.c                    |   20 +-
>  tools/perf/tests/keep-tracking.c                   |   44 +-
>  tools/perf/tests/mem2node.c                        |    5 +-
>  tools/perf/tests/mmap-basic.c                      |   28 +-
>  tools/perf/tests/mmap-thread-lookup.c              |    4 +-
>  tools/perf/tests/openat-syscall-all-cpus.c         |   18 +-
>  tools/perf/tests/openat-syscall-tp-fields.c        |   14 +-
>  tools/perf/tests/openat-syscall.c                  |   10 +-
>  tools/perf/tests/parse-events.c                    | 1220 ++++++++++----------
>  tools/perf/tests/parse-no-sample-id-all.c          |    6 +-
>  tools/perf/tests/perf-record.c                     |   10 +-
>  tools/perf/tests/sample-parsing.c                  |   14 +-
>  tools/perf/tests/sw-clock.c                        |   33 +-
>  tools/perf/tests/switch-tracking.c                 |   64 +-
>  tools/perf/tests/task-exit.c                       |   35 +-
>  tools/perf/tests/thread-map.c                      |   28 +-
>  tools/perf/tests/time-utils-test.c                 |    2 +-
>  tools/perf/tests/topology.c                        |    9 +-
>  tools/perf/ui/browsers/annotate.c                  |   16 +-
>  tools/perf/ui/browsers/hists.c                     |   54 +-
>  tools/perf/ui/browsers/res_sample.c                |    4 +-
>  tools/perf/ui/browsers/scripts.c                   |    6 +-
>  tools/perf/ui/gtk/annotate.c                       |    8 +-
>  tools/perf/ui/gtk/gtk.h                            |    8 +-
>  tools/perf/ui/gtk/hists.c                          |    6 +-
>  tools/perf/ui/hist.c                               |   16 +-
>  tools/perf/util/Build                              |    6 -
>  tools/perf/util/annotate.c                         |   42 +-
>  tools/perf/util/annotate.h                         |   28 +-
>  tools/perf/util/auxtrace.c                         |   28 +-
>  tools/perf/util/auxtrace.h                         |   24 +-
>  tools/perf/util/bpf-event.c                        |    2 +-
>  tools/perf/util/bpf-event.h                        |    4 +-
>  tools/perf/util/bpf-loader.c                       |   38 +-
>  tools/perf/util/bpf-loader.h                       |   30 +-
>  tools/perf/util/build-id.c                         |    2 +-
>  tools/perf/util/build-id.h                         |    2 +-
>  tools/perf/util/callchain.c                        |    2 +-
>  tools/perf/util/callchain.h                        |    2 +-
>  tools/perf/util/cgroup.c                           |   22 +-
>  tools/perf/util/cgroup.h                           |    6 +-
>  tools/perf/util/counts.c                           |   17 +-
>  tools/perf/util/counts.h                           |   34 +-
>  tools/perf/util/cpumap.c                           |  264 +----
>  tools/perf/util/cpumap.h                           |   54 +-
>  tools/perf/util/cputopo.c                          |   13 +-
>  tools/perf/util/cs-etm.c                           |   28 +-
>  tools/perf/util/data-convert-bt.c                  |   38 +-
>  tools/perf/util/db-export.c                        |   10 +-
>  tools/perf/util/db-export.h                        |   10 +-
>  tools/perf/util/env.c                              |    2 +-
>  tools/perf/util/env.h                              |    2 +-
>  tools/perf/util/event.c                            |   30 +-
>  tools/perf/util/event.h                            |   14 +-
>  tools/perf/util/evlist.c                           |  607 +++++-----
>  tools/perf/util/evlist.h                           |  215 ++--
>  tools/perf/util/evsel.c                            |  497 ++++----
>  tools/perf/util/evsel.h                            |  197 ++--
>  tools/perf/util/evsel_fprintf.c                    |   16 +-
>  tools/perf/util/header.c                           |  225 ++--
>  tools/perf/util/header.h                           |   24 +-
>  tools/perf/util/hist.c                             |   32 +-
>  tools/perf/util/hist.h                             |   38 +-
>  tools/perf/util/intel-bts.c                        |   22 +-
>  tools/perf/util/intel-pt.c                         |   94 +-
>  tools/perf/util/jitdump.c                          |    8 +-
>  tools/perf/util/kvm-stat.h                         |   22 +-
>  tools/perf/util/machine.c                          |   12 +-
>  tools/perf/util/machine.h                          |    8 +-
>  tools/perf/util/map.h                              |    2 +-
>  tools/perf/util/metricgroup.c                      |   26 +-
>  tools/perf/util/metricgroup.h                      |    6 +-
>  tools/perf/util/mmap.c                             |    4 +-
>  tools/perf/util/parse-events.c                     |  155 +--
>  tools/perf/util/parse-events.h                     |    8 +-
>  tools/perf/util/pmu.c                              |   15 +-
>  tools/perf/util/pmu.h                              |    2 +-
>  tools/perf/util/python-ext-sources                 |    2 -
>  tools/perf/util/python.c                           |   73 +-
>  tools/perf/util/record.c                           |   73 +-
>  tools/perf/util/s390-cpumsf.c                      |    4 +-
>  tools/perf/util/s390-sample-raw.c                  |    6 +-
>  tools/perf/util/sample-raw.c                       |    2 +-
>  tools/perf/util/sample-raw.h                       |    6 +-
>  .../perf/util/scripting-engines/trace-event-perl.c |   14 +-
>  .../util/scripting-engines/trace-event-python.c    |   40 +-
>  tools/perf/util/session.c                          |   81 +-
>  tools/perf/util/session.h                          |   12 +-
>  tools/perf/util/setup.py                           |    3 +-
>  tools/perf/util/sort.c                             |   60 +-
>  tools/perf/util/sort.h                             |    6 +-
>  tools/perf/util/stat-display.c                     |  112 +-
>  tools/perf/util/stat-shadow.c                      |   70 +-
>  tools/perf/util/stat.c                             |   64 +-
>  tools/perf/util/stat.h                             |   35 +-
>  tools/perf/util/svghelper.c                        |    7 +-
>  tools/perf/util/syscalltbl.c                       |    1 +
>  tools/perf/util/syscalltbl.h                       |    1 +
>  tools/perf/util/thread_map.c                       |  131 +--
>  tools/perf/util/thread_map.h                       |   58 +-
>  tools/perf/util/tool.h                             |    8 +-
>  tools/perf/util/top.c                              |   12 +-
>  tools/perf/util/top.h                              |    8 +-
>  tools/perf/util/trace-event-info.c                 |   14 +-
>  tools/perf/util/trace-event-scripting.c            |    2 +-
>  tools/perf/util/trace-event.h                      |    4 +-
>  tools/perf/util/util.c                             |   40 -
>  tools/perf/util/util.h                             |    4 +-
>  196 files changed, 5958 insertions(+), 4051 deletions(-)
>  create mode 100644 tools/perf/lib/Build
>  create mode 100644 tools/perf/lib/Documentation/Makefile
>  create mode 100644 tools/perf/lib/Documentation/man/libperf.rst
>  create mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst
>  create mode 100644 tools/perf/lib/Makefile
>  create mode 100644 tools/perf/lib/core.c
>  create mode 100644 tools/perf/lib/cpumap.c
>  create mode 100644 tools/perf/lib/evlist.c
>  create mode 100644 tools/perf/lib/evsel.c
>  create mode 100644 tools/perf/lib/include/internal/cpumap.h
>  create mode 100644 tools/perf/lib/include/internal/evlist.h
>  create mode 100644 tools/perf/lib/include/internal/evsel.h
>  create mode 100644 tools/perf/lib/include/internal/lib.h
>  create mode 100644 tools/perf/lib/include/internal/tests.h
>  create mode 100644 tools/perf/lib/include/internal/threadmap.h
>  rename tools/perf/{util => lib/include/internal}/xyarray.h (84%)
>  create mode 100644 tools/perf/lib/include/perf/core.h
>  create mode 100644 tools/perf/lib/include/perf/cpumap.h
>  create mode 100644 tools/perf/lib/include/perf/evlist.h
>  create mode 100644 tools/perf/lib/include/perf/evsel.h
>  create mode 100644 tools/perf/lib/include/perf/threadmap.h
>  create mode 100644 tools/perf/lib/internal.h
>  create mode 100644 tools/perf/lib/lib.c
>  create mode 100644 tools/perf/lib/libperf.map
>  create mode 100644 tools/perf/lib/libperf.pc.template
>  create mode 100644 tools/perf/lib/tests/Makefile
>  create mode 100644 tools/perf/lib/tests/test-cpumap.c
>  create mode 100644 tools/perf/lib/tests/test-evlist.c
>  create mode 100644 tools/perf/lib/tests/test-evsel.c
>  create mode 100644 tools/perf/lib/tests/test-threadmap.c
>  create mode 100644 tools/perf/lib/threadmap.c
>  create mode 100644 tools/perf/lib/xyarray.c

Pulled, thanks a lot Arnaldo!

	Ingo
