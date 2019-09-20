Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B442086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989611;
	bh=uyVcND8XZxCm2uhJOeAJ9jNzXsYBDLf133JFKWXm7IE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=p8PhAUtaj6xMq+V/Ojj0+bX3lMcOjiXsj/IeFqzG1i2/EXVIi5oIdi++uX89gMuKS
	 mHaelMVzchU+cH3KDsm9oVty4+pZSjvgFr+4bRQavR9WkRYlxJxfbPJ27E0bf1cuo6
	 iklt7tnvb8s8lya2DGljFKA1gTXDHmV5DMUGxP7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbfITO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388768AbfITOZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E83F2080F;
        Fri, 20 Sep 2019 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989551;
        bh=uyVcND8XZxCm2uhJOeAJ9jNzXsYBDLf133JFKWXm7IE=;
        h=From:To:Cc:Subject:Date:From;
        b=RrjTXSyChJQqwfHcc2sCftLSIprA+eWBUsKcYKBAshi81IA4RzzSdM12Z7kVtPMZv
         xAFLi/YQgTr/7esnJbU0racvjJuNCwu9PM8bLhhO+OFKrUxwI1Pi6XjiShabNjBb7b
         a4XNA02BbThq/1w2GtmnJOP39e6+ywPMArqXY6ow=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Colin King <colin.king@canonical.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Fri, 20 Sep 2019 11:25:11 -0300
Message-Id: <20190920142542.12047-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
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

The following changes since commit e336b4027775cb458dc713745e526fa1a1996b2a:

  kprobes: Prohibit probing on BUG() and WARN() address (2019-09-05 10:15:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190920-2

for you to fetch changes up to 2bff2b828502b5e5d5ea5a52643d3542053df03f:

  perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc (2019-09-20 10:28:26 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf stat:

  Srikar Dronamraju:

  - Fix a segmentation fault when using repeat forever.

  - Reset previous counts on repeat with interval.

aarch64:

  James Clark:

  - Add PMU event JSON files for Cortex-A76 and Neoverse N1.

PowerPC:

  Anju T Sudhakar:

  - Make 'trace_cycles' the default event for 'perf kvm record' in PowerPC.

S/390:

  - Link libjvmti to tools/lib/string.o to have a weak strlcpy()
    implementation, providing previously unresolved symbol on s/390.

perf test:

  Jiri Olsa:

  - Add libperf automated tests to 'make -C tools/perf build-test'.

  Colin Ian King:

  - Fix spelling mistake.

Tree wide:

  Arnaldo Carvalho de Melo:

  - Some more header file sanitization.

libperf:

  Jiri Olsa:

  - Add dependency on libperf for python.so binding.

libtraceevent:

  Sakari Ailus:

  - Convert remaining %p[fF] users to %p[sS].

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Anju T Sudhakar (3):
      perf kvm: Move kvm-stat header file from conditional inclusion to common include section
      perf kvm: Add arch neutral function to choose event for perf kvm record
      perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc

Arnaldo Carvalho de Melo (19):
      perf jvmti: Link against tools/lib/string.o to have weak strlcpy()
      perf tools: Remove needless builtin.h include directives
      perf debug: No need to include ui/util.h
      perf tools: Remove debug.h from places where it is not needed
      perf tools: Remove util.h from where it is not needed
      perf probe: Add missing build-id.h header.
      perf symbols: Add missing dso.h header
      perf env: Remove needless cpumap.h header
      perf event: Move perf_event__synthesize* to event.h
      perf stat: Move perf_stat_synthesize_config() to event.h
      perf callchain: Remove needless event.h include
      perf python: Remove debug.h
      perf hist: Add missing 'struct branch_stack' forward declaration
      perf annotate: Add missing machine.h include directive
      perf sched: Add missing event.h include directive
      perf auxtrace: Add missing 'struct perf_sample' forward declaration
      perf tools: Move event synthesizing routines to separate header
      perf memswap: Adopt 'struct u64_swap' from evsel.h
      perf tools: Move event synthesizing routines to separate .c file

Colin Ian King (1):
      perf test: Fix spelling mistake "allos" -> "allocate"

James Clark (1):
      perf tools: Add PMU event JSON files for ARM Cortex-A76 and, Neoverse N1.

Jiri Olsa (4):
      perf python: Add missing python/perf.so dependency for libperf
      perf tests: Add libperf automated test for 'make -C tools/perf build-test'
      libperf: Add missing event.h file to install rule
      libperf: Adopt perf_cpu_map__max() function

Sakari Ailus (1):
      tools lib traceevent: Convert remaining %p[fF] users to %p[sS]

Srikar Dronamraju (2):
      perf stat: Reset previous counts on repeat with interval
      perf stat: Fix a segmentation fault when using repeat forever

 .../Documentation/libtraceevent-func_apis.txt      |   10 +-
 tools/lib/traceevent/event-parse.c                 |   18 +-
 tools/perf/Makefile.perf                           |    2 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    2 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    2 +-
 tools/perf/arch/arm64/util/dwarf-regs.c            |    1 -
 tools/perf/arch/arm64/util/header.c                |    4 +-
 tools/perf/arch/arm64/util/unwind-libunwind.c      |    2 +-
 tools/perf/arch/powerpc/util/dwarf-regs.c          |    1 -
 tools/perf/arch/powerpc/util/header.c              |    1 -
 tools/perf/arch/powerpc/util/kvm-stat.c            |   45 +
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    1 +
 tools/perf/arch/powerpc/util/sym-handling.c        |    1 -
 tools/perf/arch/s390/util/machine.c                |    2 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |    1 -
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |    1 -
 tools/perf/arch/x86/tests/rdpmc.c                  |    2 +-
 tools/perf/arch/x86/util/archinsn.c                |    1 +
 tools/perf/arch/x86/util/event.c                   |    2 +
 tools/perf/arch/x86/util/intel-bts.c               |    2 +-
 tools/perf/arch/x86/util/intel-pt.c                |    2 +-
 tools/perf/arch/x86/util/machine.c                 |    3 +-
 tools/perf/arch/x86/util/tsc.c                     |    2 +
 tools/perf/bench/epoll-ctl.c                       |    2 +-
 tools/perf/bench/epoll-wait.c                      |    2 +-
 tools/perf/bench/futex-hash.c                      |    2 +-
 tools/perf/bench/futex-lock-pi.c                   |    2 +-
 tools/perf/bench/futex-requeue.c                   |    2 +-
 tools/perf/bench/futex-wake-parallel.c             |    3 +-
 tools/perf/bench/futex-wake.c                      |    2 +-
 tools/perf/bench/numa.c                            |    1 -
 tools/perf/bench/sched-messaging.c                 |    2 -
 tools/perf/bench/sched-pipe.c                      |    2 -
 tools/perf/builtin-annotate.c                      |    1 +
 tools/perf/builtin-c2c.c                           |    1 +
 tools/perf/builtin-config.c                        |    1 -
 tools/perf/builtin-evlist.c                        |    2 -
 tools/perf/builtin-inject.c                        |    1 +
 tools/perf/builtin-kvm.c                           |   15 +-
 tools/perf/builtin-record.c                        |   10 +-
 tools/perf/builtin-report.c                        |    2 +-
 tools/perf/builtin-sched.c                         |    3 +
 tools/perf/builtin-stat.c                          |   24 +-
 tools/perf/builtin-top.c                           |    1 +
 tools/perf/builtin-trace.c                         |    1 +
 tools/perf/jvmti/Build                             |    9 +
 tools/perf/lib/Makefile                            |    1 +
 tools/perf/lib/cpumap.c                            |   12 +
 tools/perf/lib/include/perf/cpumap.h               |    1 +
 tools/perf/lib/libperf.map                         |    1 +
 tools/perf/perf.c                                  |    2 +-
 .../arch/arm64/arm/cortex-a76-n1/branch.json       |   14 +
 .../arch/arm64/arm/cortex-a76-n1/bus.json          |   24 +
 .../arch/arm64/arm/cortex-a76-n1/cache.json        |  207 +++
 .../arch/arm64/arm/cortex-a76-n1/exception.json    |   52 +
 .../arch/arm64/arm/cortex-a76-n1/instruction.json  |  108 ++
 .../arch/arm64/arm/cortex-a76-n1/memory.json       |   23 +
 .../arch/arm64/arm/cortex-a76-n1/other.json        |    7 +
 .../arch/arm64/arm/cortex-a76-n1/pipeline.json     |   14 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    2 +
 tools/perf/tests/bitmap.c                          |    2 +-
 tools/perf/tests/clang.c                           |    2 -
 tools/perf/tests/code-reading.c                    |    2 +-
 tools/perf/tests/cpumap.c                          |    1 +
 tools/perf/tests/dso-data.c                        |    1 -
 tools/perf/tests/dwarf-unwind.c                    |    1 +
 tools/perf/tests/event-times.c                     |    1 -
 tools/perf/tests/event_update.c                    |    4 +-
 tools/perf/tests/hists_common.c                    |    2 +
 tools/perf/tests/keep-tracking.c                   |    3 +-
 tools/perf/tests/llvm.c                            |    1 -
 tools/perf/tests/make                              |    6 +-
 tools/perf/tests/mem2node.c                        |    2 +-
 tools/perf/tests/mmap-basic.c                      |    3 +-
 tools/perf/tests/mmap-thread-lookup.c              |    4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |    5 +-
 tools/perf/tests/parse-events.c                    |    1 -
 tools/perf/tests/parse-no-sample-id-all.c          |    2 -
 tools/perf/tests/perf-hooks.c                      |    1 -
 tools/perf/tests/pmu.c                             |    1 -
 tools/perf/tests/sample-parsing.c                  |    2 +-
 tools/perf/tests/stat.c                            |    1 +
 tools/perf/tests/switch-tracking.c                 |    1 -
 tools/perf/tests/task-exit.c                       |    2 +-
 tools/perf/tests/thread-map.c                      |    1 +
 tools/perf/tests/topology.c                        |    2 +-
 tools/perf/tests/vmlinux-kallsyms.c                |    2 +-
 tools/perf/ui/browser.c                            |    1 -
 tools/perf/ui/browsers/annotate.c                  |    1 -
 tools/perf/ui/browsers/header.c                    |    1 -
 tools/perf/ui/browsers/map.c                       |    1 -
 tools/perf/ui/browsers/res_sample.c                |    2 +-
 tools/perf/ui/browsers/scripts.c                   |    3 +-
 tools/perf/ui/gtk/helpline.c                       |    1 -
 tools/perf/ui/gtk/progress.c                       |    1 -
 tools/perf/ui/gtk/setup.c                          |    3 +-
 tools/perf/ui/gtk/util.c                           |    1 -
 tools/perf/ui/helpline.c                           |    2 -
 tools/perf/ui/hist.c                               |    1 -
 tools/perf/ui/setup.c                              |    2 +-
 tools/perf/ui/stdio/hist.c                         |    1 +
 tools/perf/ui/tui/helpline.c                       |    1 -
 tools/perf/ui/tui/setup.c                          |    2 +-
 tools/perf/ui/tui/util.c                           |    1 -
 tools/perf/util/Build                              |    1 +
 tools/perf/util/annotate.c                         |    2 +-
 tools/perf/util/arm-spe.c                          |    1 -
 tools/perf/util/auxtrace.c                         |    6 +-
 tools/perf/util/auxtrace.h                         |   18 +-
 tools/perf/util/bpf-event.c                        |    1 +
 tools/perf/util/bpf-event.h                        |   15 +-
 tools/perf/util/branch.c                           |    2 -
 tools/perf/util/branch.h                           |    9 +-
 tools/perf/util/build-id.c                         |    2 +-
 tools/perf/util/callchain.c                        |    1 +
 tools/perf/util/callchain.h                        |    5 +-
 tools/perf/util/cloexec.c                          |    2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |    1 -
 tools/perf/util/cs-etm.c                           |    2 +-
 tools/perf/util/data.c                             |    3 +-
 tools/perf/util/debug.c                            |    1 -
 tools/perf/util/debug.h                            |    2 +-
 tools/perf/util/demangle-java.c                    |    1 -
 tools/perf/util/demangle-rust.c                    |    1 -
 tools/perf/util/dwarf-regs.c                       |    1 -
 tools/perf/util/env.h                              |    3 +-
 tools/perf/util/event.c                            | 1109 +-----------
 tools/perf/util/event.h                            |   77 +-
 tools/perf/util/evlist.c                           |    2 +-
 tools/perf/util/evsel.c                            |  280 +--
 tools/perf/util/evsel.h                            |    5 -
 tools/perf/util/evsel_fprintf.c                    |    1 +
 tools/perf/util/header.c                           |  395 +---
 tools/perf/util/header.h                           |   60 +-
 tools/perf/util/hist.h                             |    1 +
 tools/perf/util/intel-bts.c                        |    2 +-
 tools/perf/util/intel-pt.c                         |    1 +
 tools/perf/util/jitdump.c                          |    2 -
 tools/perf/util/kvm-stat.h                         |    4 +
 tools/perf/util/libunwind/arm64.c                  |    1 -
 tools/perf/util/libunwind/x86_32.c                 |    1 -
 tools/perf/util/llvm-utils.c                       |    1 +
 tools/perf/util/lzma.c                             |    2 +-
 tools/perf/util/machine.c                          |   15 -
 tools/perf/util/machine.h                          |   15 -
 tools/perf/util/memswap.h                          |    7 +
 tools/perf/util/namespaces.c                       |   18 +
 tools/perf/util/namespaces.h                       |    2 +
 tools/perf/util/parse-events.c                     |    1 -
 tools/perf/util/perf-hooks.c                       |    1 -
 tools/perf/util/pmu.c                              |    1 -
 tools/perf/util/probe-file.c                       |    1 +
 tools/perf/util/python.c                           |    4 +-
 tools/perf/util/record.c                           |    2 -
 tools/perf/util/rwsem.c                            |    1 +
 tools/perf/util/s390-cpumsf.c                      |    1 -
 tools/perf/util/s390-sample-raw.c                  |    1 -
 .../util/scripting-engines/trace-event-python.c    |    2 -
 tools/perf/util/session.c                          |   72 +-
 tools/perf/util/session.h                          |    5 -
 tools/perf/util/srccode.c                          |    2 +-
 tools/perf/util/stat.c                             |   60 +-
 tools/perf/util/stat.h                             |    9 +-
 tools/perf/util/svghelper.c                        |    2 +-
 tools/perf/util/symbol-elf.c                       |    3 +
 tools/perf/util/symbol-minimal.c                   |    3 +-
 tools/perf/util/symbol.c                           |    2 +-
 tools/perf/util/synthetic-events.c                 | 1884 ++++++++++++++++++++
 tools/perf/util/synthetic-events.h                 |  103 ++
 tools/perf/util/target.c                           |    2 -
 tools/perf/util/top.c                              |    1 -
 tools/perf/util/trace-event-info.c                 |    2 +-
 tools/perf/util/trace-event-read.c                 |    1 -
 tools/perf/util/trace-event.c                      |    1 -
 tools/perf/util/tsc.h                              |   14 +-
 tools/perf/util/unwind-libdw.c                     |    1 -
 tools/perf/util/unwind-libunwind-local.c           |    1 -
 tools/perf/util/usage.c                            |    1 -
 tools/perf/util/vdso.c                             |    2 +-
 tools/perf/util/zlib.c                             |    4 +-
 180 files changed, 2763 insertions(+), 2256 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
 create mode 100644 tools/perf/util/synthetic-events.c
 create mode 100644 tools/perf/util/synthetic-events.h

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

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.3.0-rc6.tar.xz
  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.1 (tags/RELEASE_801/final) (based on LLVM 8.0.1)
   9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20190908 gcc-9-branch@275492, clang version 8.0.0 (tags/RELEASE_800/final)
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  19 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  20 debian:experimental           : Ok   gcc (Debian 9.2.1-8) 9.2.1 20190909, clang version 8.0.1-3+b1 (tags/RELEASE_801/final)
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
  38 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31.1)
  39 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31.1)
  40 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  41 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  42 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  43 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  44 manjaro:latest                : Ok   gcc (GCC) 9.1.0, clang version 8.0.1 (tags/RELEASE_801/final)
  45 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  46 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  47 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  48 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190820 [gcc-9-branch revision 274748], clang version 8.0.1 (tags/RELEASE_801/final 366581)
  49 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  50 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  51 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  52 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
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
  76 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  77 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-8ubuntu1) 9.2.1 20190909, clang version 9.0.0-+rc5-1~exp1 (tags/RELEASE_900/rc5)
  #

  # uname -a
  Linux quaco 5.3.0+ #2 SMP Thu Sep 19 16:13:22 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  2bff2b828502 perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc
  # perf version --build-options
  perf version 5.3.rc6.g2bff2b828502
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
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_install_O: make install
             make_util_map_o_O: make util/map.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_perf_o_O: make perf.o
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_clean_all_O: make clean all
                    make_doc_O: make doc
                make_no_gtk2_O: make NO_GTK2=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                 make_static_O: make LDFLAGS=-static
                   make_help_O: make help
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                   make_pure_O: make
                   make_tags_O: make tags
                make_no_newt_O: make NO_NEWT=1
                 make_cscope_O: make cscope
            make_install_bin_O: make install-bin
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
        make_with_babeltrace_O: make LIBBABELTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                  make_debug_O: make DEBUG=1
               make_no_slang_O: make NO_SLANG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libperl_O: make NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
