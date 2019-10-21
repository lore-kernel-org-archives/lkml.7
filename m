Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABB82173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665128;
	bh=9zTk+/6AirHxca+SFYTmF8Jj/WkVIRpvwHNrewOn/sg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J4uBzRf2Ma7x7HJTCLxMc8w4ej3g2olc/c1tS5TuYkvPx+CLHeOGMk4OZJlcDYJmJ
	 O/JES83pQKu4eYSYaJcsTmDAfJmvEUArtP18x8hvlkhqgTuUKdWHHjU+ypBTadt4vJ
	 EXAi/cT1bASwzARo88QH+H2oPYY5ptrcuEuoDouI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfJUNir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfJUNiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B9620679;
        Mon, 21 Oct 2019 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665124;
        bh=9zTk+/6AirHxca+SFYTmF8Jj/WkVIRpvwHNrewOn/sg=;
        h=From:To:Cc:Subject:Date:From;
        b=Rj+Un3vhe6iRVjI1kc6MQDq965mQ0B3IfAElDdvKsi2A7edEHcpSFdz6aec/8H/2i
         bAxjsG+gnSceEwqTtpkoUP2lh4wHGUfe3Quq59lH7aVfFRzKvbD3kl8sBYukR+eB9U
         zLSYbsJgVtEhYCOD3I8uUanJ1h43nuOa7vszVzfI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon, 21 Oct 2019 10:37:37 -0300
Message-Id: <20191021133834.25998-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 39b656ee9f2ce41eb969c86525f9a2a63fefac5b:

  Merge tag 'perf-core-for-mingo-5.5-20191011' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-10-15 07:19:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191021

for you to fetch changes up to 27198a893ba074407e7a87e346252b3e6fab454f:

  perf trace: Use STUL_STRARRAY_FLAGS with mmap (2019-10-19 15:35:02 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf trace:

- Add syscall failure stats to -s/--summary and -S/--with-summary, also works in
  combination with specifying just a set of syscalls, see below first with
  -s/--summary, then with -S/--with-summary just for the syscalls we saw failing
  with -s:

    # perf trace -s sleep 1

     Summary of events:

     sleep (16218), 80 events, 93.0%

       syscall     calls  errors  total      min      avg      max   stddev
                                  (msec)   (msec)   (msec)   (msec)    (%)
       ----------- -----  ------ -------- -------- -------- -------- ------
       nanosleep       1      0  1000.091 1000.091 1000.091 1000.091  0.00%
       mmap            8      0     0.045    0.005    0.006    0.008  7.09%
       mprotect        4      0     0.028    0.005    0.007    0.009 11.38%
       openat          3      0     0.021    0.005    0.007    0.009 14.07%
       munmap          1      0     0.017    0.017    0.017    0.017  0.00%
       brk             4      0     0.010    0.001    0.002    0.004 23.15%
       read            4      0     0.009    0.002    0.002    0.003  8.13%
       close           5      0     0.008    0.001    0.002    0.002 10.83%
       fstat           3      0     0.006    0.002    0.002    0.002  6.97%
       access          1      1     0.006    0.006    0.006    0.006  0.00%
       lseek           3      0     0.005    0.001    0.002    0.002  7.37%
       arch_prctl      2      1     0.004    0.001    0.002    0.002 17.64%
       execve          1      0     0.000    0.000    0.000    0.000  0.00%

    # perf trace -e access,arch_prctl -S sleep 1
         0.000 ( 0.006 ms): sleep/19503 arch_prctl(option: 0x3001, arg2: 0x7fff165996b0) = -1 EINVAL (Invalid argument)
         0.024 ( 0.006 ms): sleep/19503 access(filename: 0x2177e510, mode: R)            = -1 ENOENT (No such file or directory)
         0.136 ( 0.002 ms): sleep/19503 arch_prctl(option: SET_FS, arg2: 0x7f9421737580) = 0

     Summary of events:

     sleep (19503), 6 events, 50.0%

       syscall    calls  errors total    min    avg    max  stddev
                                (msec) (msec) (msec) (msec)    (%)
       ---------- -----  ------ ------ ------ ------ ------ ------
       arch_prctl   2       1    0.008  0.002  0.004  0.006 57.22%
       access       1       1    0.006  0.006  0.006  0.006  0.00%

    #

  - Introduce --errno-summary, to drill down a bit more in the errno stats:

    # perf trace --errno-summary -e access,arch_prctl -S sleep 1
         0.000 ( 0.006 ms): sleep/5587 arch_prctl(option: 0x3001, arg2: 0x7ffd6ba6aa00) = -1 EINVAL (Invalid argument)
         0.028 ( 0.007 ms): sleep/5587 access(filename: 0xb83d9510, mode: R)            = -1 ENOENT (No such file or directory)
         0.172 ( 0.003 ms): sleep/5587 arch_prctl(option: SET_FS, arg2: 0x7f45b8392580) = 0

     Summary of events:

     sleep (5587), 6 events, 50.0%

       syscall    calls  errors total    min    avg    max  stddev
                                (msec) (msec) (msec) (msec)   (%)
       ---------- -----  ------ ------ ------ ------ ------ ------
       arch_prctl     2     1    0.009  0.003  0.005  0.006 38.90%
			   EINVAL: 1
       access         1     1    0.007  0.007  0.007  0.007  0.00%
                           ENOENT: 1
    #

  - Filter own pid to avoid a feedback look in 'perf trace record -a'

  - Add the glue for the auto generated x86 IRQ vector array.

  - Show error message when not finding a field used in a filter expression

    # perf trace --max-events=4 -e syscalls:sys_enter_write --filter="cnt>32767"
    Failed to set filter "(cnt>32767) && (common_pid != 19938 && common_pid != 8922)" on event syscalls:sys_enter_write with 22 (Invalid argument)
    #
    # perf trace --max-events=4 -e syscalls:sys_enter_write --filter="count>32767"
         0.000 python3.5/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0dc53600, count: 172086)
        12.641 python3.5.post/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0db63660, count: 75994)
        27.738 python3.5.post/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0db4b1e0, count: 41635)
       136.070 python3.5.post/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0dbab510, count: 62232)
    #

  - Add a generator for x86's IRQ vectors -> strings

  - Introduce stroul() (string -> number) methods for the strarray and
    strarrays classes, also strtoul_flags, allowing to go from both strings
    and or-ed strings to numbers, allowing things like:

    # perf trace -e syscalls:sys_enter_mmap --filter="flags==DENYWRITE|PRIVATE|FIXED" sleep 1
         0.000 sleep/22588 syscalls:sys_enter_mmap(addr: 0x7f42d2aa5000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
         0.011 sleep/22588 syscalls:sys_enter_mmap(addr: 0x7f42d2bf2000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
         0.015 sleep/22588 syscalls:sys_enter_mmap(addr: 0x7f42d2c3f000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
    #

  Allowing to narrow down from the complete set of mmap calls for that workload:

    # perf trace -e syscalls:sys_enter_mmap sleep 1
         0.000 sleep/22695 syscalls:sys_enter_mmap(len: 134773, prot: READ, flags: PRIVATE, fd: 3)
         0.041 sleep/22695 syscalls:sys_enter_mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
         0.053 sleep/22695 syscalls:sys_enter_mmap(len: 1857472, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3)
         0.069 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd23ffb6000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
         0.077 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd240103000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
         0.083 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd240150000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
         0.095 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd240156000, len: 14272, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS)
         0.339 sleep/22695 syscalls:sys_enter_mmap(len: 217750512, prot: READ, flags: PRIVATE, fd: 3)
    #

  Works with all targets, so, for system wide, looking at who calls mmap with flags set to just "PRIVATE":

    # perf trace --max-events=5 -e syscalls:sys_enter_mmap --filter="flags==PRIVATE"
         0.000 pool/2242 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 14)
         0.050 pool/2242 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 14)
         0.062 pool/2242 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 14)
         0.145 goa-identity-s/2240 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 18)
         0.183 goa-identity-s/2240 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 18)
    #

  # perf trace --max-events=2 -e syscalls:sys_enter_lseek --filter="whence==SET && offset != 0"
         0.000 Cache2 I/O/12047 syscalls:sys_enter_lseek(fd: 277, offset: 43, whence: SET)
      1142.070 mozStorage #5/12302 syscalls:sys_enter_lseek(fd: 44</home/acme/.mozilla/firefox/ina67tev.default/cookies.sqlite-wal>, offset: 393536, whence: SET)
  #

perf annotate:

  - Fix objdump --no-show-raw-insn flag to work with goth gcc and clang.

  - Streamline objdump execution, preserving the right error codes for better
    reporting to user.

perf report:

  - Add warning when libunwind not compiled in.

perf stat:

  Jin Yao:

  - Support --all-kernel/--all-user, to match options available in 'perf record',
    asking that all the events specified work just with kernel or user events.

perf list:

  Jin Yao:

  - Hide deprecated events by default, allow showing them with --deprecated.

libbperf:

  Jiri Olsa:

  - Allow to build with -ltcmalloc.

  - Finish mmap interface, getting more stuff from tools/perf while adding
    abstractions to avoid pulling too much stuff, to get libperf to grow as
    tools needs things like auxtrace, etc.

perf scripting engines:

  Steven Rostedt (VMware):

  - Iterate on tep event arrays directly, fixing script generation with
    '-g python' when having multiple tracepoints in a perf.data file.

core:

  - Allow to build with -ltcmalloc.

perf test:

  Leo Yan:

  - Report failure for mmap events.

  - Avoid infinite loop for task exit case.

  - Remove needless headers for bp_account test.

  - Add dedicated checking helper is_supported().

  - Disable bp_signal testing for arm64.

Vendor events:

arm64:

  John Garry:

  - Fix Hisi hip08 DDRC PMU eventname.

  - Add some missing events for Hisi hip08 DDRC, L3C and HHA PMUs.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (2):
      perf script: Fix --reltime with --time
      perf evlist: Fix fix for freed id arrays

Arnaldo Carvalho de Melo (25):
      perf trace: Add syscall failure stats to -s/--summary and -S/--with-summary
      perf trace: Introduce --errno-summary
      perf string: Export asprintf__tp_filter_pids()
      perf trace: Filter own pid to avoid a feedback look in 'perf trace record -a'
      perf trace: Support tracepoint dynamic char arrays
      tools arch x86: Grab a copy of the file containing the IRQ vector defines
      libbeauty: Add a generator for x86's IRQ vectors -> strings
      libbeauty: Hook up the x86 irq_vectors table generator
      libbeauty: Add a strarray__scnprintf_suffix() method
      perf trace beauty: Add the glue for the autogenerated x86 IRQ vector array
      perf trace: Hook the 'vec' tracepoint argument with the x86 IRQ vectors scnprintf/strtoul
      perf trace: Show error message when not finding a field used in a filter expression
      perf trace: Introduce accessors to trace specific evsel->priv
      perf trace: Hide evsel->access further, simplify code
      perf trace: Introduce 'struct evsel__trace' for evsel->priv needs
      perf trace: Initialize evsel_trace->fmt for syscalls:sys_enter_* tracepoints
      libbeauty: Introduce syscall_arg__strtoul_strarray()
      perf trace: Honour --max-events in processing syscalls:sys_enter_*
      perf trace: Pass a syscall_arg to syscall_arg_fmt->strtoul()
      libbeauty: Introduce syscall_arg__strtoul_strarrays()
      perf trace: Use strtoul for the fcntl 'cmd' argument
      libbeauty: Make the mmap_flags strarray visible outside of its beautifier
      libbeauty: Introduce strarray__strtoul_flags()
      perf trace: Wire up strarray__strtoul_flags()
      perf trace: Use STUL_STRARRAY_FLAGS with mmap

Ian Rogers (5):
      perf annotate: Avoid reallocation in objdump parsing
      perf annotate: Use libsubcmd's run-command.h to fork objdump
      perf annotate: Don't pipe objdump output through 'grep' command
      perf annotate: Don't pipe objdump output through 'expand' command
      perf annotate: Fix objdump --no-show-raw-insn flag

Jin Yao (3):
      perf report: Add warning when libunwind not compiled in
      perf stat: Support --all-kernel/--all-user
      perf list: Hide deprecated events by default

Jiri Olsa (10):
      perf tools: Allow to build with -ltcmalloc
      libperf: Introduce perf_evlist__for_each_mmap()
      libperf: Move mmap allocation to perf_evlist__mmap_ops::get
      libperf: Move mask setup to perf_evlist__mmap_ops()
      libperf: Link static tests with libapi.a
      libperf: Add tests_mmap_thread test
      libperf: Add tests_mmap_cpus test
      libperf: Keep count of failed tests
      libperf: Do not export perf_evsel__init()/perf_evlist__init()
      libperf: Add pr_err() macro

John Garry (4):
      perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname
      perf vendor events arm64: Add some missing events for Hisi hip08 DDRC PMU
      perf vendor events arm64: Add some missing events for Hisi hip08 L3C PMU
      perf vendor events arm64: Add some missing events for Hisi hip08 HHA PMU

Leo Yan (5):
      perf test: Report failure for mmap events
      perf test: Avoid infinite loop for task exit case
      perf tests: Remove needless headers for bp_account
      perf tests bp_account: Add dedicated checking helper is_supported()
      perf tests: Disable bp_signal testing for arm64

Steven Rostedt (VMware) (2):
      perf scripting engines: Iterate on tep event arrays directly
      perf tools: Remove unused trace_find_next_event()

Thomas Richter (1):
      perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()

 tools/arch/x86/include/asm/irq_vectors.h           | 146 +++++++
 tools/perf/Documentation/perf-list.txt             |   3 +
 tools/perf/Documentation/perf-stat.txt             |   6 +
 tools/perf/Documentation/perf-trace.txt            |   4 +
 tools/perf/Makefile.config                         |   5 +
 tools/perf/Makefile.perf                           |  10 +
 tools/perf/builtin-list.c                          |  14 +-
 tools/perf/builtin-report.c                        |   7 +
 tools/perf/builtin-script.c                        |   5 +-
 tools/perf/builtin-stat.c                          |   6 +
 tools/perf/builtin-trace.c                         | 420 ++++++++++++++++-----
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/jvmti/Build                             |   6 +-
 tools/perf/lib/Makefile                            |   1 +
 tools/perf/lib/evlist.c                            |  71 +++-
 tools/perf/lib/include/internal/evlist.h           |   3 +
 tools/perf/lib/include/internal/evsel.h            |   1 +
 tools/perf/lib/include/internal/mmap.h             |   5 +-
 tools/perf/lib/include/internal/tests.h            |  20 +-
 tools/perf/lib/include/perf/core.h                 |   1 +
 tools/perf/lib/include/perf/evlist.h               |  10 +-
 tools/perf/lib/include/perf/evsel.h                |   2 -
 tools/perf/lib/internal.h                          |   3 +
 tools/perf/lib/libperf.map                         |   3 +-
 tools/perf/lib/mmap.c                              |   6 +-
 tools/perf/lib/tests/Makefile                      |   6 +-
 tools/perf/lib/tests/test-cpumap.c                 |   2 +-
 tools/perf/lib/tests/test-evlist.c                 | 219 ++++++++++-
 tools/perf/lib/tests/test-evsel.c                  |   2 +-
 tools/perf/lib/tests/test-threadmap.c              |   2 +-
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |  16 +-
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     |  23 +-
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |  56 +++
 tools/perf/pmu-events/jevents.c                    |  26 +-
 tools/perf/pmu-events/jevents.h                    |   3 +-
 tools/perf/pmu-events/pmu-events.h                 |   1 +
 tools/perf/tests/bp_account.c                      |  20 +-
 tools/perf/tests/bp_signal.c                       |  15 +-
 tools/perf/tests/builtin-test.c                    |   2 +-
 tools/perf/tests/task-exit.c                       |   9 +
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/trace/beauty/beauty.h                   |  19 +
 tools/perf/trace/beauty/mmap.c                     |   4 +-
 tools/perf/trace/beauty/tracepoints/Build          |   1 +
 .../trace/beauty/tracepoints/x86_irq_vectors.c     |  29 ++
 .../trace/beauty/tracepoints/x86_irq_vectors.sh    |  27 ++
 tools/perf/util/annotate.c                         | 196 ++++++----
 tools/perf/util/evlist.c                           |  34 +-
 tools/perf/util/parse-events.c                     |   4 +-
 tools/perf/util/parse-events.h                     |   2 +-
 tools/perf/util/pmu.c                              |  17 +-
 tools/perf/util/pmu.h                              |   4 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   8 +-
 .../util/scripting-engines/trace-event-python.c    |   9 +-
 tools/perf/util/stat.c                             |  10 +
 tools/perf/util/stat.h                             |   2 +
 tools/perf/util/string2.h                          |   3 +
 tools/perf/util/time-utils.c                       |  27 +-
 tools/perf/util/time-utils.h                       |   5 +
 tools/perf/util/trace-event-parse.c                |  31 --
 tools/perf/util/trace-event.h                      |   2 -
 61 files changed, 1307 insertions(+), 289 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/irq_vectors.h
 create mode 100644 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh

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

Clearlinux is failing when building with libpython, but that is not a perf
regression, will try to remove one compiler warning that is causing the problem
when building some of the glue code files in the python files, outside perf.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.4.0-rc3.tar.xz
  # dm 
     1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
     2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
     3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
     4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     8 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 8.0.1 (tags/RELEASE_801/final) (based on LLVM 8.0.1)
     9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
    10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
    11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
    14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
    15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
    16 centos:8                      : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3), clang version 7.0.1 (tags/RELEASE_701/final)
    17 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20190930 gcc-9-branch@276275, clang version 8.0.0 (tags/RELEASE_800/final)
    18 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
    19 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
    20 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
    21 debian:experimental           : Ok   gcc (Debian 9.2.1-8) 9.2.1 20190909, clang version 8.0.1-3+b1 (tags/RELEASE_801/final)
    22 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
    23 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
    24 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-19) 8.3.0
    25 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
    26 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
    27 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
    28 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
    29 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
    30 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
    31 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
    32 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
    33 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
    34 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
    35 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    36 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    37 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
    38 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
    39 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc31)
    40 fedora:32                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc32)
    41 fedora:rawhide                : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc32)
    42 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
    43 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
    44 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
    45 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
    46 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 8.0.1 (tags/RELEASE_801/final)
    47 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
    48 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 7.0.1 (tags/RELEASE_701/final 349238)
    49 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
    50 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190903 [gcc-9-branch revision 275330], clang version 8.0.1 (tags/RELEASE_801/final 366581)
    51 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
    52 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
    53 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
    54 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
    55 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
    56 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    57 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    58 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    59 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    60 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    61 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    62 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    63 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    64 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
    65 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
    66 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    67 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    68 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    69 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    70 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    71 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    72 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    73 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
    74 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
    75 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
    76 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
    77 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
    78 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
    79 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-8ubuntu1) 9.2.1 20190909, clang version 9.0.0-+rc5-1~exp1 (tags/RELEASE_900/rc5)
  #
  # uname -a
  Linux quaco 5.2.18-200.fc30.x86_64 #1 SMP Tue Oct 1 13:14:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  27198a893ba0 perf trace: Use STUL_STRARRAY_FLAGS with mmap
  # perf version --build-options
  perf version 5.4.rc3.g27198a893ba0
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
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_perf_o_O: make perf.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_util_map_o_O: make util/map.o
                make_no_gtk2_O: make NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_pure_O: make
              make_no_libbpf_O: make NO_LIBBPF=1
              make_clean_all_O: make clean all
            make_install_bin_O: make install-bin
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                  make_debug_O: make DEBUG=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_tags_O: make tags
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
                    make_doc_O: make doc
           make_no_backtrace_O: make NO_BACKTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
               make_no_slang_O: make NO_SLANG=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                   make_help_O: make help
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
              make_no_libelf_O: make NO_LIBELF=1
                 make_cscope_O: make cscope
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_install_O: make install
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
