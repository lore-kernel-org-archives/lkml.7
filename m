Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CE6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920122184E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279565;
	bh=WU8w/MK2iMYC+aOPEh/kF+5n12woimbSBelQhzs+Rbk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=07yscL3iXzFKum8NXyUFvKUB0XSA8kY5UqXWNc//Iu9OCn7d1yPrm83VssKcDmGAv
	 oUQiyJc0+JGmlxZoO4HG7OteYyGksixCxyzGppk3GNhMOOD2egRfYYwnfwcqbpU63m
	 rlx5VJuI5Z1SV24DBGsZMPsTrWR3zcjOa/6FHkIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbfFKS7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392179AbfFKS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292A3217D6;
        Tue, 11 Jun 2019 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279562;
        bh=WU8w/MK2iMYC+aOPEh/kF+5n12woimbSBelQhzs+Rbk=;
        h=From:To:Cc:Subject:Date:From;
        b=XfuElEOX6rrmhoYHlOWPmjN44f8C+cWu3p+8ff/p4IRAWYA97SrC0ybmjt565awPO
         2NROEiMNtMRtEEwH2oJgmV/H0ehSM4R2dP1Ydv1EIDUBJA8JZ2GvABlCPe2yFadkQV
         Ag9m0TB7lNO1IRgmD7DW1LdTXG4Eh2ErHYuGy9Z8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Song Liu <songliubraving@fb.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Tue, 11 Jun 2019 15:57:46 -0300
Message-Id: <20190611185911.11645-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Test results at the end of this message, as usual.

- Arnaldo

The following changes since commit 3384c78631dd722c2cdc5c57fbdd39fc1b5a9f2d:

  Merge branch 'x86/topology' into perf/core, to prepare for new patches (2019-06-03 11:58:45 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190611

for you to fetch changes up to 04c41bcb862bbec1fb225243ecf07a3219593f81:

  perf trace: Skip unknown syscalls when expanding strace like syscall groups (2019-06-10 17:50:04 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf record:

  Alexey Budankov:

  - Allow mixing --user-regs with --call-graph=dwarf, making sure that
    the minimal set of registers for DWARF unwinding is present in the
    set of user registers requested to be present in each sample, while
    warning the user that this may make callchains unreliable if more
    that the minimal set of registers is needed to unwind.

  yuzhoujian:

  - Add support to collect callchains from kernel or user space only,
    IOW allow setting the perf_event_attr.exclude_callchain_{kernel,user}
    bits from the command line.

perf trace:

  Arnaldo Carvalho de Melo:

  - Remove x86_64 specific syscall numbers from the augmented_raw_syscalls
    BPF in-kernel collector of augmented raw_syscalls:sys_{enter,exit}
    payloads, use instead the syscall numbers obtainer either by the
    arch specific syscalltbl generators or from audit-libs.

  - Allow 'perf trace' to ask for the number of bytes to collect for
    string arguments, for now ask for PATH_MAX, i.e. the whole
    pathnames, which ends up being just a way to speficy which syscall
    args are pathnames and thus should be read using bpf_probe_read_str().

  - Skip unknown syscalls when expanding strace like syscall groups.
    This helps using the 'string' group of syscalls to work in arm64,
    where some of the syscalls present in x86_64 that deal with
    strings, for instance 'access', are deprecated and this should not
    be asked for tracing.

  Leo Yan:

  - Exit when failing to build eBPF program.

perf config:

  Arnaldo Carvalho de Melo:

  - Bail out when a handler returns failure for a key-value pair. This
    helps with cases where processing a key-value pair is not just a
    matter of setting some tool specific knob, involving, for instance
    building a BPF program to then attach to the list of events 'perf
    trace' will use, e.g. augmented_raw_syscalls.c.

perf.data:

  Kan Liang:

  - Read and store die ID information available in new Intel processors
    in CPUID.1F in the CPU topology written in the perf.data header.

perf stat:

  Kan Liang:

  - Support per-die aggregation.

Documentation:

  Arnaldo Carvalho de Melo:

  - Update perf.data documentation about the CPU_TOPOLOGY, MEM_TOPOLOGY,
    CLOCKID and DIR_FORMAT headers.

  Song Liu:

  - Add description of headers HEADER_BPF_PROG_INFO and HEADER_BPF_BTF.

  Leo Yan:

  - Update default value for llvm.clang-bpf-cmd-template in 'man perf-config'.

JVMTI:

  Jiri Olsa:

  - Address gcc string overflow warning for strncpy()

core:

  - Remove superfluous nthreads system_wide setup in perf_evsel__alloc_fd().

Intel PT:

  Adrian Hunter:

  - Add support for samples to contain IPC ratio, collecting cycles
    information from CYC packets, showing the IPC info periodically, because
    Intel PT does not update the cycle count on every branch or instruction,
    the incremental values will often be zero.  When there are values, they
    will be the number of instructions and number of cycles since the last
    update, and thus represent the average IPC since the last IPC value.

    E.g.:

    # perf record --cpu 1 -m200000 -a -e intel_pt/cyc/u sleep 0.0001
    rounding mmap pages size to 1024M (262144 pages)
    [ perf record: Woken up 0 times to write data ]
    [ perf record: Captured and wrote 2.208 MB perf.data ]
    # perf script --insn-trace --xed -F+ipc,-dso,-cpu,-tid
    #
    <SNIP + add line numbering to make sense of IPC counts e.g.: (18/3)>
    1   cc1 63501.650479626: 7f5219ac27bf _int_free+0x3f   jnz 0x7f5219ac2af0       IPC: 0.81 (36/44)
    2   cc1 63501.650479626: 7f5219ac27c5 _int_free+0x45   cmp $0x1f, %rbp
    3   cc1 63501.650479626: 7f5219ac27c9 _int_free+0x49   jbe 0x7f5219ac2b00
    4   cc1 63501.650479626: 7f5219ac27cf _int_free+0x4f   test $0x8, %al
    5   cc1 63501.650479626: 7f5219ac27d1 _int_free+0x51   jnz 0x7f5219ac2b00
    6   cc1 63501.650479626: 7f5219ac27d7 _int_free+0x57   movq  0x13c58a(%rip), %rcx
    7   cc1 63501.650479626: 7f5219ac27de _int_free+0x5e   mov %rdi, %r12
    8   cc1 63501.650479626: 7f5219ac27e1 _int_free+0x61   movq  %fs:(%rcx), %rax
    9   cc1 63501.650479626: 7f5219ac27e5 _int_free+0x65   test %rax, %rax
   10   cc1 63501.650479626: 7f5219ac27e8 _int_free+0x68   jz 0x7f5219ac2821
   11   cc1 63501.650479626: 7f5219ac27ea _int_free+0x6a   leaq  -0x11(%rbp), %rdi
   12   cc1 63501.650479626: 7f5219ac27ee _int_free+0x6e   mov %rdi, %rsi
   13   cc1 63501.650479626: 7f5219ac27f1 _int_free+0x71   shr $0x4, %rsi
   14   cc1 63501.650479626: 7f5219ac27f5 _int_free+0x75   cmpq  %rsi, 0x13caf4(%rip)
   15   cc1 63501.650479626: 7f5219ac27fc _int_free+0x7c   jbe 0x7f5219ac2821
   16   cc1 63501.650479626: 7f5219ac2821 _int_free+0xa1   cmpq  0x13f138(%rip), %rbp
   17   cc1 63501.650479626: 7f5219ac2828 _int_free+0xa8   jnbe 0x7f5219ac28d8
   18   cc1 63501.650479626: 7f5219ac28d8 _int_free+0x158  testb  $0x2, 0x8(%rbx)
   19   cc1 63501.650479628: 7f5219ac28dc _int_free+0x15c  jnz 0x7f5219ac2ab0       IPC: 6.00 (18/3)
    <SNIP>

  - Allow using time ranges with Intel PT, i.e. these features, already
    present but not optimially usable with Intel PT, should be now:

        Select the second 10% time slice:

        $ perf script --time 10%/2

        Select from 0% to 10% time slice:

        $ perf script --time 0%-10%

        Select the first and second 10% time slices:

        $ perf script --time 10%/1,10%/2

        Select from 0% to 10% and 30% to 40% slices:

        $ perf script --time 0%-10%,30%-40%

cs-etm (ARM):

  Mathieu Poirier:

  - Add support for CPU-wide trace scenarios.

s390:

  Thomas Richter:

  - Fix missing kvm module load for s390.

  - Fix OOM error in TUI mode on s390

  - Support s390 diag event display when doing analysis on !s390
    architectures.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (38):
      perf intel-pt: Factor out intel_pt_update_sample_time
      perf intel-pt: Accumulate cycle count from CYC packets
      perf tools: Add IPC information to perf_sample
      perf intel-pt: Add support for samples to contain IPC ratio
      perf script: Add output of IPC ratio
      perf intel-pt: Record when decoding PSB+ packets
      perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
      perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
      perf intel-pt: Document IPC usage
      perf thread-stack: Accumulate IPC information
      perf db-export: Add brief documentation
      perf db-export: Export IPC information
      perf scripts python: export-to-sqlite.py: Export IPC information
      perf scripts python: export-to-postgresql.py: Export IPC information
      perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
      perf scripts python: exported-sql-viewer.py: Add CallGraphModelParams
      perf scripts python: exported-sql-viewer.py: Add IPC information to Call Graph Graph
      perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
      perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated
      perf auxtrace: Add perf time interval to itrace_synth_ops
      perf script: Set perf time interval in itrace_synth_ops
      perf report: Set perf time interval in itrace_synth_ops
      perf intel-pt: Add lookahead callback
      perf intel-pt: Factor out intel_pt_8b_tsc()
      perf intel-pt: Factor out intel_pt_reposition()
      perf intel-pt: Add reposition parameter to intel_pt_get_data()
      perf intel-pt: Add intel_pt_fast_forward()
      perf intel-pt: Factor out intel_pt_get_buffer()
      perf intel-pt: Add support for lookahead
      perf intel-pt: Add support for efficient time interval filtering
      perf time-utils: Treat time ranges consistently
      perf time-utils: Factor out set_percent_time()
      perf time-utils: Prevent percentage time range overlap
      perf time-utils: Fix --time documentation
      perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
      perf time-utils: Make perf_time__parse_for_ranges() more logical
      perf tests: Add a test for time-utils
      perf time-utils: Add support for multiple explicit time intervals

Alexey Budankov (1):
      perf record: Allow mixing --user-regs with --call-graph=dwarf

Arnaldo Carvalho de Melo (13):
      perf data: Document memory topology header: HEADER_MEM_TOPOLOGY
      perf data: Document clockid header: HEADER_CLOCKID
      perf data: Document directory format header: HEADER_DIR_FORMAT
      perf augmented_raw_syscalls: Tell which args are filenames and how many bytes to copy
      perf augmented_raw_syscalls: Move the probe_read_str to a separate function
      perf augmented_raw_syscalls: Change helper to consider just the augmented_filename part
      perf augmented_raw_syscalls: Move reading filename to the loop
      perf trace: Consume the augmented_raw_syscalls payload
      perf trace: Associate more argument names with the filename beautifier
      perf config: Bail out when a handler returns failure for a key-value pair
      perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
      perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead
      perf trace: Skip unknown syscalls when expanding strace like syscall groups

Jiri Olsa (2):
      perf jvmti: Address gcc string overflow warning for strncpy()
      perf evsel: Remove superfluous nthreads system_wide setup in alloc_fd()

Kan Liang (5):
      perf cpumap: Retrieve die id information
      perf header: Add die information in CPU topology
      perf stat: Support per-die aggregation
      perf header: Rename "sibling cores" to "sibling sockets"
      perf tools: Apply new CPU topology sysfs attributes

Leo Yan (3):
      perf symbols: Remove unused variable 'err'
      perf trace: Exit when failing to build eBPF program
      perf config: Update default value for llvm.clang-bpf-cmd-template

Mathieu Poirier (18):
      perf cs-etm: Configure contextID tracing in CPU-wide mode
      perf cs-etm: Configure timestamp generation in CPU-wide mode
      perf cs-etm: Configure SWITCH_EVENTS in CPU-wide mode
      perf cs-etm: Add handling of itrace start events
      perf cs-etm: Add handling of switch-CPU-wide events
      perf cs-etm: Refactor error path in cs_etm_decoder__new()
      perf cs-etm: Move packet queue out of decoder structure
      perf cs-etm: Fix indentation in function cs_etm__process_decoder_queue()
      perf cs-etm: Introduce the concept of trace ID queues
      perf cs-etm: Get rid of unused cpu in struct cs_etm_queue
      perf cs-etm: Move thread to traceid_queue
      perf cs-etm: Move tid/pid to traceid_queue
      perf cs-etm: Use traceID aware memory callback API
      perf cs-etm: Add support for multiple traceID queues
      perf cs-etm: Linking PE contextID with perf thread mechanic
      perf cs-etm: Add notion of time to decoding code
      perf cs-etm: Add support for CPU-wide trace scenarios
      perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode

Song Liu (1):
      perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF

Thomas Richter (3):
      perf test 6: Fix missing kvm module load for s390
      perf report: Fix OOM error in TUI mode on s390
      perf report: Support s390 diag event display on x86

yuzhoujian (1):
      perf record: Add support to collect callchains from kernel or user space only

 tools/perf/Documentation/db-export.txt             |   41 +
 tools/perf/Documentation/intel-pt.txt              |   30 +
 tools/perf/Documentation/perf-config.txt           |    9 +-
 tools/perf/Documentation/perf-diff.txt             |   14 +-
 tools/perf/Documentation/perf-record.txt           |   11 +
 tools/perf/Documentation/perf-report.txt           |    9 +-
 tools/perf/Documentation/perf-script.txt           |   14 +-
 tools/perf/Documentation/perf-stat.txt             |   10 +
 tools/perf/Documentation/perf.data-file-format.txt |   97 +-
 tools/perf/Makefile.config                         |    3 +
 tools/perf/arch/arm/util/cs-etm.c                  |  313 +++++-
 tools/perf/builtin-record.c                        |    4 +
 tools/perf/builtin-report.c                        |    8 +-
 tools/perf/builtin-script.c                        |   31 +-
 tools/perf/builtin-stat.c                          |   87 +-
 tools/perf/builtin-trace.c                         |   84 +-
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  281 ++----
 tools/perf/jvmti/libjvmti.c                        |    4 +-
 tools/perf/perf.h                                  |    2 +
 tools/perf/scripts/python/export-to-postgresql.py  |   36 +-
 tools/perf/scripts/python/export-to-sqlite.py      |   36 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |  294 ++++--
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |    4 +
 tools/perf/tests/parse-events.c                    |   27 +
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/tests/time-utils-test.c                 |  251 +++++
 tools/perf/util/annotate.c                         |    5 +-
 tools/perf/util/auxtrace.h                         |   34 +
 tools/perf/util/config.c                           |    8 +-
 tools/perf/util/cpumap.c                           |   64 +-
 tools/perf/util/cpumap.h                           |   10 +-
 tools/perf/util/cputopo.c                          |   84 +-
 tools/perf/util/cputopo.h                          |    2 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  268 +++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   39 +-
 tools/perf/util/cs-etm.c                           | 1026 +++++++++++++++-----
 tools/perf/util/cs-etm.h                           |   94 ++
 tools/perf/util/env.c                              |    1 +
 tools/perf/util/env.h                              |    3 +
 tools/perf/util/event.h                            |    2 +
 tools/perf/util/evsel.c                            |   16 +-
 tools/perf/util/header.c                           |   96 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  329 ++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    6 +
 tools/perf/util/intel-pt.c                         |  354 ++++++-
 tools/perf/util/perf_regs.h                        |    4 +
 tools/perf/util/s390-cpumsf.c                      |   96 +-
 .../util/scripting-engines/trace-event-python.c    |    8 +-
 tools/perf/util/smt.c                              |    8 +-
 tools/perf/util/stat-display.c                     |   29 +-
 tools/perf/util/stat-shadow.c                      |    1 +
 tools/perf/util/stat.c                             |    1 +
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/symbol-elf.c                       |    3 +-
 tools/perf/util/thread-stack.c                     |   14 +
 tools/perf/util/thread-stack.h                     |    4 +
 tools/perf/util/time-utils.c                       |  132 ++-
 58 files changed, 3581 insertions(+), 863 deletions(-)
 create mode 100644 tools/perf/Documentation/db-export.txt
 create mode 100644 tools/perf/tests/time-utils-test.c

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

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0-rc3.tar.xz
  $ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 7.0.1 (tags/RELEASE_701/final) (based on LLVM 7.0.1)
   8 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.0.1 20190501 (prerelease) gcc-8-branch@270761, clang version 8.0.0 (tags/RELEASE_800/final)
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  18 debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
  22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  29 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  30 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  31 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  32 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  33 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  34 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  35 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  36 fedora:rawhide                : Ok   gcc (GCC) 9.0.1 20190418 (Red Hat 9.0.1-0.14), clang version 8.0.0 (Fedora 8.0.0-2.fc31)
  37 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  38 mageia:5                      : Ok   gcc (GCC) 4.9.2
  39 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  40 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.0
  41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  42 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  43 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190520 [gcc-9-branch revision 271396], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  44 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  45 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  46 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  47 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  48 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  49 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  56 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
  57 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
  58 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  59 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  60 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  61 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  62 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  63 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  64 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  65 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  66 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  67 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  68 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  69 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  70 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  $
  # uname -a
  Linux quaco 5.2.0-rc1+ #1 SMP Thu May 23 10:37:55 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  04c41bcb862b perf trace: Skip unknown syscalls when expanding strace like syscall groups
  # perf version --build-options
  perf version 5.2.rc3.g04c41bcb862b
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
  65: x86 bp modify                                         : Ok
  66: probe libc's inet_pton & backtrace it with ping       : Ok
  67: Use vfs_getname probe to get syscall args filenames   : Ok
  68: Add vfs_getname probe to get syscall args filenames   : Ok
  69: Check open filename arg using perf trace + vfs_getname: Ok
  70: Zstd perf.data compression/decompression              : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_tags_O: make tags
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
                    make_doc_O: make doc
         make_install_prefix_O: make install prefix=/tmp/krava
       make_util_pmu_bison_o_O: make util/pmu-bison.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
               make_no_slang_O: make NO_SLANG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_no_newt_O: make NO_NEWT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_help_O: make help
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_install_O: make install
              make_no_libelf_O: make NO_LIBELF=1
                   make_pure_O: make
                 make_static_O: make LDFLAGS=-static
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                  make_debug_O: make DEBUG=1
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_demangle_O: make NO_DEMANGLE=1
                 make_perf_o_O: make perf.o
                 make_cscope_O: make cscope
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_util_map_o_O: make util/map.o
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_no_gtk2_O: make NO_GTK2=1
              make_clean_all_O: make clean all
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
