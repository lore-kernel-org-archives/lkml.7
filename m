Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A4C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271D0216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455386;
	bh=h0m1Qaw+0Qi20bKxKYEpL/IfINwNTfMOuKYysM7P47w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GjAX/s2wvaGnKVSOlj4+6u7FA3i9VLEh8q1WO5Dpq+RJ8uxg+f3PQtqN04HdHJNP3
	 s/I2ehBYBePrIqfv3Y1BqdXK//e7QyVCATzXiqUlntls18aa1Af6tnqnERHhO/gSoz
	 BkI4NXKX/1NCoIUxq0D5Memq6pjn3mDaA3UQHFgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfG3C4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbfG3C4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:56:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB0C20578;
        Tue, 30 Jul 2019 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455380;
        bh=h0m1Qaw+0Qi20bKxKYEpL/IfINwNTfMOuKYysM7P47w=;
        h=From:To:Cc:Subject:Date:From;
        b=efeGOO/NLrwD1ySUxLIn/hm85DHCKJ5uEcA8rNMwndhYZVcFITmVcUy1dxwnAwyfI
         6u8mlhOBzGzuP4yzJie6DQEa3OFnedroBgsCLndsCsMeCMdmnYrKtMJnKl+n/FLbyK
         zPtIpu6CQV+rJ5zj87VAnOHzepNtoGRgvQjL1RwU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 000/107] perf/core improvements and fixes
Date:   Mon, 29 Jul 2019 23:54:23 -0300
Message-Id: <20190730025610.22603-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit b3c303be4c35856945cb17ec639b94637447dae2:

  Merge tag 'perf-urgent-for-mingo-5.3-20190729' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-07-29 23:24:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190729

for you to fetch changes up to 123a039d0d54de6d5bafd551e7aa17569e13e315:

  perf vendor events power9: Added missing event descriptions (2019-07-29 18:34:47 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf trace:

  Arnaldo Carvalho de Melo:

  - Use BPF_MAP_TYPE_PROG_ARRAY + bpf_tail_call() for augmenting raw syscalls,
    i.e. copy pointers passed to/from userspace. The use of a table per syscall
    to tell the BPF program what to copy made the raw_syscalls:sys_enter/exit
    programs a bit complex, the scratch space would have to be bigger to allow
    for checking all args to see which ones were a pathname, so use a PROG_ARRAY
    map instead, test it with syscalls that receive multiple pathnames at
    different pairs of arguments (rename, renameat, etc).

  - Beautify various syscalls using this new infrastructure, and also add code
    that looks for syscalls with BPF augmenters, such as "open", and then reuse
    it with syscalls not yet having a specific augmenter, but that copies the
    same argument with the same type, say "statfs" can initially reuse "open",
    beautifier, as both have as its first arg a "const char *".

  - Do not using fd->pathname beautifier when the 'close' syscall isn't enabled,
    as we can't invalidate that mapping.

core:

  Jiri Olsa:

  - Introduce tools/perf/lib/, that eventually will move to tools/lib/perf/, to
    allow other tools to use the abstractions and code perf uses to set up
    the perf ring buffer and set up the many possible combinations in allowed
    by the kernel, starting with 'struct perf_evsel' and 'struct perf_evlist'.

perf vendor events:

  Michael Petlan:

  - Add missing event description to power9 event definitions.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (27):
      perf include bpf: Add bpf_tail_call() prototype
      perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !
      perf evsel: Store backpointer to attached bpf_object
      perf trace: Add pointer to BPF object containing __augmented_syscalls__
      perf trace: Look up maps just on the __augmented_syscalls__ BPF object
      perf trace: Order -e syscalls table
      perf trace: Add BPF handler for unaugmented syscalls
      perf trace: Allow specifying the bpf prog to augment specific syscalls
      perf trace: Put the per-syscall entry/exit prog_array BPF map infrastructure in place
      perf trace: Handle raw_syscalls:sys_enter just like the BPF_OUTPUT augmented event
      perf augmented_raw_syscalls: Add handler for "openat"
      perf augmented_raw_syscalls: Switch to using BPF_MAP_TYPE_PROG_ARRAY
      perf augmented_raw_syscalls: Support copying two string syscall args
      perf trace: Look for default name for entries in the syscalls prog array
      perf augmented_raw_syscalls: Rename augmented_args_filename to augmented_args_payload
      perf augmented_raw_syscalls: Augment sockaddr arg in 'connect'
      perf trace beauty: Make connect's addrlen be printed as an int, not hex
      perf trace beauty: Disable fd->pathname when close() not enabled
      perf trace beauty: Do not try to use the fd->pathname beautifier for bind/connect fd arg
      perf trace beauty: Beautify 'sendto's sockaddr arg
      perf trace beauty: Beautify bind's sockaddr arg
      perf trace beauty: Add BPF augmenter for the 'rename' syscall
      perf trace: Forward error codes when trying to read syscall info
      perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages
      perf trace: Preallocate the syscall table
      perf trace: Reuse BPF augmenters from syscalls with similar args signature
      perf trace: Add "sendfile64" alias to the "sendfile" syscall

Jiri Olsa (79):
      perf stat: Move loaded out of struct perf_counts_values
      perf cpu_map: Rename struct cpu_map to struct perf_cpu_map
      perf tools: Rename struct thread_map to struct perf_thread_map
      perf evsel: Rename struct perf_evsel to struct evsel
      perf evlist: Rename struct perf_evlist to struct evlist
      perf evsel: Rename perf_evsel__init() to evsel__init()
      perf evlist: Rename perf_evlist__init() to evlist__init()
      perf evlist: Rename perf_evlist__new() to evlist__new()
      perf evlist: Rename perf_evlist__delete() to evlist__delete()
      perf evsel: Rename perf_evsel__delete() to evsel__delete()
      perf evsel: Rename perf_evsel__new() to evsel__new()
      perf evlist: Rename perf_evlist__add() to evlist__add()
      perf evlist: Rename perf_evlist__remove() to evlist__remove()
      perf evsel: Rename perf_evsel__open() to evsel__open()
      perf evsel: Rename perf_evsel__enable() to evsel__enable()
      perf evsel: Rename perf_evsel__disable() to evsel__disable()
      perf evsel: Rename perf_evsel__apply_filter() to evsel__apply_filter()
      perf evsel: Rename perf_evsel__cpus() to evsel__cpus()
      perf evlist: Rename perf_evlist__open() to evlist__open()
      perf evlist: Rename perf_evlist__close() to evlist__close()
      perf evlist: Rename perf_evlist__enable() to evlist__enable()
      perf evlist: Rename perf_evlist__disable() to evlist__disable()
      libperf: Make libperf.a part of the perf build
      libperf: Add build version support
      libperf: Add libperf to the python.so build
      libperf: Add perf/core.h header
      libperf: Add debug output support
      libperf: Add perf_cpu_map struct
      libperf: Add perf_cpu_map__dummy_new() function
      libperf: Add perf_cpu_map__get()/perf_cpu_map__put()
      libperf: Add perf_thread_map struct
      libperf: Add perf_thread_map__new_dummy() function
      libperf: Add perf_thread_map__get()/perf_thread_map__put()
      libperf: Add perf_evlist and perf_evsel structs
      libperf: Include perf_evsel in evsel object
      libperf: Include perf_evlist in evlist object
      libperf: Add perf_evsel__init function
      libperf: Add perf_evlist__init() function
      libperf: Add perf_evlist__add() function
      libperf: Add perf_evlist__remove() function
      libperf: Add nr_entries to struct perf_evlist
      libperf: Move perf_event_attr field from perf's evsel to libperf's perf_evsel
      libperf: Add perf_cpu_map__new()/perf_cpu_map__read() functions
      libperf: Move zalloc.o into libperf
      libperf: Add perf_evlist__new() function
      libperf: Add perf_evsel__new() function
      libperf: Add perf_evlist__for_each_evsel() iterator
      libperf: Add perf_evlist__delete() function
      libperf: Add perf_evsel__delete() function
      libperf: Add cpus to struct perf_evsel
      libperf: Add own_cpus to struct perf_evsel
      libperf: Add threads to struct perf_evsel
      libperf: Add has_user_cpus to struct perf_evlist
      libperf: Add cpus to struct perf_evlist
      libperf: Add threads to struct perf_evlist
      libperf: Add perf_evlist__set_maps() function
      libperf: Adopt xyarray class from perf
      libperf: Move fd array from perf's evsel to lobperf's perf_evsel class
      libperf: Move nr_members from perf's evsel to libperf's perf_evsel
      libperf: Adopt the readn()/writen() functions from tools/perf
      libperf: Adopt perf_evsel__alloc_fd() function from tools/perf
      libperf: Adopt simplified perf_evsel__open() function from tools/perf
      libperf: Adopt simplified perf_evsel__close() function from tools/perf
      libperf: Adopt perf_evsel__read() function from tools/perf
      libperf: Adopt perf_evsel__enable()/disable()/apply_filter() functions
      libperf: Add perf_cpu_map__for_each_cpu() macro
      libperf: Add perf_evsel__cpus()/threads() functions
      libperf: Adopt simplified perf_evlist__open()/close() functions from tools/perf
      libperf: Adopt perf_evlist__enable()/disable() functions from perf
      libperf: Add perf_evsel__attr() function
      libperf: Add install targets
      libperf: Add tests support
      libperf: Add perf_cpu_map test
      libperf: Add perf_thread_map test
      libperf: Add perf_evlist test
      libperf: Add perf_evsel tests
      libperf: Add perf_evlist__enable/disable test
      libperf: Add perf_evsel__enable/disable test
      libperf: Initial documentation

Michael Petlan (1):
      perf vendor events power9: Added missing event descriptions

 tools/perf/Makefile.config                         |    1 +
 tools/perf/Makefile.perf                           |   31 +-
 tools/perf/arch/arm/util/auxtrace.c                |    8 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   82 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   24 +-
 tools/perf/arch/arm64/util/header.c                |    6 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |   12 +-
 tools/perf/arch/s390/util/auxtrace.c               |   12 +-
 tools/perf/arch/s390/util/kvm-stat.c               |    8 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |    8 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   30 +-
 tools/perf/arch/x86/util/auxtrace.c                |   10 +-
 tools/perf/arch/x86/util/intel-bts.c               |   38 +-
 tools/perf/arch/x86/util/intel-pt.c                |   82 +-
 tools/perf/arch/x86/util/kvm-stat.c                |   12 +-
 tools/perf/bench/epoll-ctl.c                       |    7 +-
 tools/perf/bench/epoll-wait.c                      |    7 +-
 tools/perf/bench/futex-hash.c                      |    5 +-
 tools/perf/bench/futex-lock-pi.c                   |    7 +-
 tools/perf/bench/futex-requeue.c                   |    7 +-
 tools/perf/bench/futex-wake-parallel.c             |    6 +-
 tools/perf/bench/futex-wake.c                      |    7 +-
 tools/perf/builtin-annotate.c                      |   16 +-
 tools/perf/builtin-c2c.c                           |   10 +-
 tools/perf/builtin-diff.c                          |   20 +-
 tools/perf/builtin-evlist.c                        |    4 +-
 tools/perf/builtin-ftrace.c                        |   18 +-
 tools/perf/builtin-inject.c                        |   60 +-
 tools/perf/builtin-kmem.c                          |   24 +-
 tools/perf/builtin-kvm.c                           |   46 +-
 tools/perf/builtin-lock.c                          |   30 +-
 tools/perf/builtin-mem.c                           |    2 +-
 tools/perf/builtin-record.c                        |   50 +-
 tools/perf/builtin-report.c                        |   32 +-
 tools/perf/builtin-sched.c                         |   96 +-
 tools/perf/builtin-script.c                        |  167 +--
 tools/perf/builtin-stat.c                          |  135 +--
 tools/perf/builtin-timechart.c                     |   46 +-
 tools/perf/builtin-top.c                           |   71 +-
 tools/perf/builtin-trace.c                         |  619 +++++++---
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  284 +++--
 tools/perf/include/bpf/bpf.h                       |    2 +
 tools/perf/lib/Build                               |   12 +
 tools/perf/lib/Documentation/Makefile              |    7 +
 tools/perf/lib/Documentation/man/libperf.rst       |  100 ++
 tools/perf/lib/Documentation/tutorial/tutorial.rst |  123 ++
 tools/perf/lib/Makefile                            |  158 +++
 tools/perf/lib/core.c                              |   34 +
 tools/perf/lib/cpumap.c                            |  239 ++++
 tools/perf/lib/evlist.c                            |  159 +++
 tools/perf/lib/evsel.c                             |  232 ++++
 tools/perf/lib/include/internal/cpumap.h           |   17 +
 tools/perf/lib/include/internal/evlist.h           |   50 +
 tools/perf/lib/include/internal/evsel.h            |   29 +
 tools/perf/lib/include/internal/lib.h              |   10 +
 tools/perf/lib/include/internal/tests.h            |   19 +
 tools/perf/lib/include/internal/threadmap.h        |   23 +
 .../perf/{util => lib/include/internal}/xyarray.h  |    6 +-
 tools/perf/lib/include/perf/core.h                 |   22 +
 tools/perf/lib/include/perf/cpumap.h               |   23 +
 tools/perf/lib/include/perf/evlist.h               |   35 +
 tools/perf/lib/include/perf/evsel.h                |   39 +
 tools/perf/lib/include/perf/threadmap.h            |   18 +
 tools/perf/lib/internal.h                          |   18 +
 tools/perf/lib/lib.c                               |   46 +
 tools/perf/lib/libperf.map                         |   40 +
 tools/perf/lib/libperf.pc.template                 |   11 +
 tools/perf/lib/tests/Makefile                      |   38 +
 tools/perf/lib/tests/test-cpumap.c                 |   21 +
 tools/perf/lib/tests/test-evlist.c                 |  186 +++
 tools/perf/lib/tests/test-evsel.c                  |  125 ++
 tools/perf/lib/tests/test-threadmap.c              |   21 +
 tools/perf/lib/threadmap.c                         |   81 ++
 tools/perf/lib/xyarray.c                           |   33 +
 .../pmu-events/arch/powerpc/power9/memory.json     |    2 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |    8 +-
 tools/perf/tests/backward-ring-buffer.c            |   18 +-
 tools/perf/tests/bitmap.c                          |    5 +-
 tools/perf/tests/bpf.c                             |   12 +-
 tools/perf/tests/code-reading.c                    |   50 +-
 tools/perf/tests/cpumap.c                          |   21 +-
 tools/perf/tests/event-times.c                     |   81 +-
 tools/perf/tests/event_update.c                    |   13 +-
 tools/perf/tests/evsel-roundtrip-name.c            |   12 +-
 tools/perf/tests/evsel-tp-sched.c                  |    8 +-
 tools/perf/tests/hists_cumulate.c                  |   18 +-
 tools/perf/tests/hists_filter.c                    |   10 +-
 tools/perf/tests/hists_link.c                      |   10 +-
 tools/perf/tests/hists_output.c                    |   20 +-
 tools/perf/tests/keep-tracking.c                   |   44 +-
 tools/perf/tests/mem2node.c                        |    5 +-
 tools/perf/tests/mmap-basic.c                      |   28 +-
 tools/perf/tests/mmap-thread-lookup.c              |    4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   18 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   14 +-
 tools/perf/tests/openat-syscall.c                  |   10 +-
 tools/perf/tests/parse-events.c                    | 1220 ++++++++++----------
 tools/perf/tests/parse-no-sample-id-all.c          |    6 +-
 tools/perf/tests/perf-record.c                     |   10 +-
 tools/perf/tests/sample-parsing.c                  |   14 +-
 tools/perf/tests/sw-clock.c                        |   33 +-
 tools/perf/tests/switch-tracking.c                 |   64 +-
 tools/perf/tests/task-exit.c                       |   35 +-
 tools/perf/tests/thread-map.c                      |   28 +-
 tools/perf/tests/time-utils-test.c                 |    2 +-
 tools/perf/tests/topology.c                        |    9 +-
 tools/perf/ui/browsers/annotate.c                  |   16 +-
 tools/perf/ui/browsers/hists.c                     |   54 +-
 tools/perf/ui/browsers/res_sample.c                |    4 +-
 tools/perf/ui/browsers/scripts.c                   |    6 +-
 tools/perf/ui/gtk/annotate.c                       |    8 +-
 tools/perf/ui/gtk/gtk.h                            |    8 +-
 tools/perf/ui/gtk/hists.c                          |    6 +-
 tools/perf/ui/hist.c                               |   16 +-
 tools/perf/util/Build                              |    6 -
 tools/perf/util/annotate.c                         |   42 +-
 tools/perf/util/annotate.h                         |   28 +-
 tools/perf/util/auxtrace.c                         |   28 +-
 tools/perf/util/auxtrace.h                         |   24 +-
 tools/perf/util/bpf-event.c                        |    2 +-
 tools/perf/util/bpf-event.h                        |    4 +-
 tools/perf/util/bpf-loader.c                       |   38 +-
 tools/perf/util/bpf-loader.h                       |   30 +-
 tools/perf/util/build-id.c                         |    2 +-
 tools/perf/util/build-id.h                         |    2 +-
 tools/perf/util/callchain.c                        |    2 +-
 tools/perf/util/callchain.h                        |    2 +-
 tools/perf/util/cgroup.c                           |   22 +-
 tools/perf/util/cgroup.h                           |    6 +-
 tools/perf/util/counts.c                           |   17 +-
 tools/perf/util/counts.h                           |   34 +-
 tools/perf/util/cpumap.c                           |  264 +----
 tools/perf/util/cpumap.h                           |   54 +-
 tools/perf/util/cputopo.c                          |   13 +-
 tools/perf/util/cs-etm.c                           |   28 +-
 tools/perf/util/data-convert-bt.c                  |   38 +-
 tools/perf/util/db-export.c                        |   10 +-
 tools/perf/util/db-export.h                        |   10 +-
 tools/perf/util/env.c                              |    2 +-
 tools/perf/util/env.h                              |    2 +-
 tools/perf/util/event.c                            |   30 +-
 tools/perf/util/event.h                            |   14 +-
 tools/perf/util/evlist.c                           |  607 +++++-----
 tools/perf/util/evlist.h                           |  215 ++--
 tools/perf/util/evsel.c                            |  497 ++++----
 tools/perf/util/evsel.h                            |  197 ++--
 tools/perf/util/evsel_fprintf.c                    |   16 +-
 tools/perf/util/header.c                           |  225 ++--
 tools/perf/util/header.h                           |   24 +-
 tools/perf/util/hist.c                             |   32 +-
 tools/perf/util/hist.h                             |   38 +-
 tools/perf/util/intel-bts.c                        |   22 +-
 tools/perf/util/intel-pt.c                         |   94 +-
 tools/perf/util/jitdump.c                          |    8 +-
 tools/perf/util/kvm-stat.h                         |   22 +-
 tools/perf/util/machine.c                          |   12 +-
 tools/perf/util/machine.h                          |    8 +-
 tools/perf/util/map.h                              |    2 +-
 tools/perf/util/metricgroup.c                      |   26 +-
 tools/perf/util/metricgroup.h                      |    6 +-
 tools/perf/util/mmap.c                             |    4 +-
 tools/perf/util/parse-events.c                     |  155 +--
 tools/perf/util/parse-events.h                     |    8 +-
 tools/perf/util/pmu.c                              |   15 +-
 tools/perf/util/pmu.h                              |    2 +-
 tools/perf/util/python-ext-sources                 |    2 -
 tools/perf/util/python.c                           |   73 +-
 tools/perf/util/record.c                           |   73 +-
 tools/perf/util/s390-cpumsf.c                      |    4 +-
 tools/perf/util/s390-sample-raw.c                  |    6 +-
 tools/perf/util/sample-raw.c                       |    2 +-
 tools/perf/util/sample-raw.h                       |    6 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   14 +-
 .../util/scripting-engines/trace-event-python.c    |   40 +-
 tools/perf/util/session.c                          |   81 +-
 tools/perf/util/session.h                          |   12 +-
 tools/perf/util/setup.py                           |    3 +-
 tools/perf/util/sort.c                             |   60 +-
 tools/perf/util/sort.h                             |    6 +-
 tools/perf/util/stat-display.c                     |  112 +-
 tools/perf/util/stat-shadow.c                      |   70 +-
 tools/perf/util/stat.c                             |   64 +-
 tools/perf/util/stat.h                             |   35 +-
 tools/perf/util/svghelper.c                        |    7 +-
 tools/perf/util/syscalltbl.c                       |    1 +
 tools/perf/util/syscalltbl.h                       |    1 +
 tools/perf/util/thread_map.c                       |  131 +--
 tools/perf/util/thread_map.h                       |   58 +-
 tools/perf/util/tool.h                             |    8 +-
 tools/perf/util/top.c                              |   12 +-
 tools/perf/util/top.h                              |    8 +-
 tools/perf/util/trace-event-info.c                 |   14 +-
 tools/perf/util/trace-event-scripting.c            |    2 +-
 tools/perf/util/trace-event.h                      |    4 +-
 tools/perf/util/util.c                             |   40 -
 tools/perf/util/util.h                             |    4 +-
 196 files changed, 5958 insertions(+), 4051 deletions(-)
 create mode 100644 tools/perf/lib/Build
 create mode 100644 tools/perf/lib/Documentation/Makefile
 create mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 create mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst
 create mode 100644 tools/perf/lib/Makefile
 create mode 100644 tools/perf/lib/core.c
 create mode 100644 tools/perf/lib/cpumap.c
 create mode 100644 tools/perf/lib/evlist.c
 create mode 100644 tools/perf/lib/evsel.c
 create mode 100644 tools/perf/lib/include/internal/cpumap.h
 create mode 100644 tools/perf/lib/include/internal/evlist.h
 create mode 100644 tools/perf/lib/include/internal/evsel.h
 create mode 100644 tools/perf/lib/include/internal/lib.h
 create mode 100644 tools/perf/lib/include/internal/tests.h
 create mode 100644 tools/perf/lib/include/internal/threadmap.h
 rename tools/perf/{util => lib/include/internal}/xyarray.h (84%)
 create mode 100644 tools/perf/lib/include/perf/core.h
 create mode 100644 tools/perf/lib/include/perf/cpumap.h
 create mode 100644 tools/perf/lib/include/perf/evlist.h
 create mode 100644 tools/perf/lib/include/perf/evsel.h
 create mode 100644 tools/perf/lib/include/perf/threadmap.h
 create mode 100644 tools/perf/lib/internal.h
 create mode 100644 tools/perf/lib/lib.c
 create mode 100644 tools/perf/lib/libperf.map
 create mode 100644 tools/perf/lib/libperf.pc.template
 create mode 100644 tools/perf/lib/tests/Makefile
 create mode 100644 tools/perf/lib/tests/test-cpumap.c
 create mode 100644 tools/perf/lib/tests/test-evlist.c
 create mode 100644 tools/perf/lib/tests/test-evsel.c
 create mode 100644 tools/perf/lib/tests/test-threadmap.c
 create mode 100644 tools/perf/lib/threadmap.c
 create mode 100644 tools/perf/lib/xyarray.c

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

This is with the following patches that are in the BPF tree:

  89bf23d6a1da libbpf: Avoid designated initializers for unnamed union members
  df538f1f4574 libbpf: Fix endianness macro usage for some compilers

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.3.0-rc2.tar.xz
  $ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.1.1 20190718 gcc-9-branch@273561, clang version 8.0.0 (tags/RELEASE_800/final)
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  19 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  20 debian:experimental           : Ok   gcc (Debian 8.3.0-19) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  21 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  22 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  23 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
  24 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  25 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  26 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  27 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  28 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  29 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  30 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  31 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  32 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  33 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  34 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  35 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  36 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  37 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  38 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
  39 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
  40 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  41 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  42 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  43 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  44 manjaro:latest                : Ok   gcc (GCC) 9.1.0, clang version 8.0.1 (tags/RELEASE_801/final)
  45 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  46 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  47 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  48 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190703 [gcc-9-branch revision 273008], clang version 8.0.0 (tags/RELEASE_800/final 356365)
  49 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  50 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  51 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  52 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  53 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  54 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  55 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  59 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  60 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  61 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  62 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  63 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  64 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  65 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  66 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  67 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  68 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  69 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  70 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  73 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  74 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  75 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0

  # uname -a
  Linux quaco 5.2.0-rc7+ #4 SMP Sat Jul 6 14:43:41 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  123a039d0d54 perf vendor events power9: Added missing event descriptions
  # perf version --build-options
  perf version 5.3.rc2.g123a039d0d54
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: time utils                                            : Ok
  60: map_groups__merge_in                                  : Ok
  61: x86 rdpmc                                             : Ok
  62: Convert perf time to TSC                              : Ok
  63: DWARF unwind                                          : Ok
  64: x86 instruction decoder - new instructions            : Ok
  65: Intel PT packet decoder                               : Ok
  66: x86 bp modify                                         : Ok
  67: probe libc's inet_pton & backtrace it with ping       : Ok
  68: Use vfs_getname probe to get syscall args filenames   : Ok
  69: Add vfs_getname probe to get syscall args filenames   : Ok
  70: Check open filename arg using perf trace + vfs_getname: Ok
  71: Zstd perf.data compression/decompression              : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
                 make_perf_o_O: make perf.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_util_map_o_O: make util/map.o
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_help_O: make help
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_demangle_O: make NO_DEMANGLE=1
            make_install_bin_O: make install-bin
                 make_static_O: make LDFLAGS=-static
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_no_gtk2_O: make NO_GTK2=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                  make_debug_O: make DEBUG=1
                 make_cscope_O: make cscope
             make_no_libnuma_O: make NO_LIBNUMA=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_clean_all_O: make clean all
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
                    make_doc_O: make doc
                make_no_newt_O: make NO_NEWT=1
                   make_pure_O: make
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
