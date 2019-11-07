Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04994C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAA721882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153238;
	bh=xa02EfvLG5/9pPmZfSzms3Lg56vKJIHifHzIi4v9aDc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qdTOxMMZ9X37I7D7vdhwYWS6BE9A6WzkYRMV1WrUoRI4elXq/bHhI3oogLFhyHSVh
	 unm62UaLnFWIXvNoHdBqyVuVH6gpRDUd/q4kdSsbcd+EdWVLFB/0GZwD1Yq/UHAbbG
	 kDynXbyCGrMPwronkBevOdaBSCateXdSItFHy0Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfKGTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKGTAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:00:37 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349C42085B;
        Thu,  7 Nov 2019 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153235;
        bh=xa02EfvLG5/9pPmZfSzms3Lg56vKJIHifHzIi4v9aDc=;
        h=From:To:Cc:Subject:Date:From;
        b=mBP1MA+553LA3n9Wc5qaY42GwFxJzyi9++FzCprOCqFGGwL+63LyLauZBevRSIO5V
         GZe2jg+77sbj4yYpleH0ld6LD8nXoB9sBAJ96jxIz5EDiKer0KunFIfrcxnsd4BUAy
         vcmiz8iEcn5lL/zlPAx1rWMhHr+LPNgpa5yswnzQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ian Rogers <irogers@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Thu,  7 Nov 2019 15:59:08 -0300
Message-Id: <20191107190011.23924-1-acme@kernel.org>
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

The following changes since commit d44f821b0e13275735e8f3fe4db8703b45f05d52:

  perf/core: Optimize perf_init_event() for TYPE_SOFTWARE (2019-10-28 12:53:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191107

for you to fetch changes up to 7fa46cbf20d327d78114b1c8c7e69fabe7c57794:

  perf report: Sort by sampled cycles percent per block for tui (2019-11-07 10:14:48 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf report:

  Jin Yao:

  - Introduce --total-cycles, for basic block profiling, further using data
    obtained from LBR, an example should suffice:

      # perf record -b
      ^C[ perf record: Woken up 595 times to write data ]
      [ perf record: Captured and wrote 156.672 MB perf.data (196873 samples) ]

      # perf evlist -v
      cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY

      # perf report --total-cycles --stdio
      # To display the perf.data header info, please use --header/--header-only options.
      #
      # Total Lost Samples: 0
      #
      # Samples: 6M of event 'cycles'
      # Event count (approx.): 6299936
      #
      # Sampled  Sampled   Avg     Avg
      # Cycles%  Cycles  Cycles%  Cycles                 [Program Block Range]     Shared Object
      # .......  ......  .......  .....   ....................................  ................
      #
         2.17%     1.7M   0.08%     607       [compiler.h:199 -> common.c:221]  [kernel.vmlinux]
         0.72%   544.5K   0.03%     230     [entry_64.S:657 -> entry_64.S:662]  [kernel.vmlinux]
         0.56%   541.8K   0.09%     672       [compiler.h:199 -> common.c:300]  [kernel.vmlinux]
         0.39%   293.2K   0.01%     104   [list_debug.c:43 -> list_debug.c:61]  [kernel.vmlinux]
         0.36%   278.6K   0.03%     272   [entry_64.S:1289 -> entry_64.S:1308]  [kernel.vmlinux]

perf record:

  Adrian Hunter:

  - Allow storing perf.data in a directory together with a copy of /proc/kcore.

  Jiwei Sun:

  - Add support for limit perf output file size, i.e.:

    # perf record --all-cpus -F 10000 --max-size=4M sleep 10h
    [ perf record: perf size limit reached (4097 KB), stopping session ]
    [ perf record: Woken up 6 times to write data ]
    [ perf record: Captured and wrote 4.048 MB perf.data (54094 samples) ]
    Terminated
    # ls -lah perf.data
    -rw-------. 1 root root 4.1M Nov  7 15:27 perf.data
    #

perf stat:

  Jiri Olsa:

  - Add --per-node agregation support:

    In live mode:

      # perf stat  -a -I 1000 -e cycles --per-node
      #           time node   cpus             counts unit events
           1.000542550 N0       20          6,202,097      cycles
           1.000542550 N1       20            639,559      cycles
           2.002040063 N0       20          7,412,495      cycles
           2.002040063 N1       20          2,185,577      cycles
           3.003451699 N0       20          6,508,917      cycles
           3.003451699 N1       20            765,607      cycles
      ...

    Or in the record/report stat session:

      # perf stat record -a -I 1000 -e cycles
      #           time             counts unit events
           1.000536937         10,008,468      cycles
           2.002090152          9,578,539      cycles
           3.003625233          7,647,869      cycles
           4.005135036          7,032,086      cycles
      ^C     4.340902364          3,923,893      cycles

      # perf stat report --per-node
      #           time node   cpus             counts unit events
           1.000536937 N0       20          9,355,086      cycles
           1.000536937 N1       20            653,382      cycles
           2.002090152 N0       20          7,712,838      cycles
           2.002090152 N1       20          1,865,701      cycles
       ...

perf probe:

  Masami Hiramatsu:

  Various fixes related to recent additions to the DWARF format:

  - Fix to find range-only function instance

  - Walk function lines in lexical blocks

  - Fix to show function entry line as probe-able

  - Fix wrong address verification

  - Fix to probe a function which has no entry pc

  - Fix to probe an inline function which has no entry pc

  - Fix to list probe event with correct line number

  - Fix to show inlined function callsite without entry_pc

  - Fix to show ranges of variables in functions without entry_pc

  - Return a better scope DIE if there is no best scope

  - Skip end-of-sequence and non statement lines

  - Filter out instances except for inlined subroutine and subprogram

  - Fix to show calling lines of inlined functions

  - Skip overlapped location on searching variables

perf inject:

  Adrian Hunter:

  - Do not strip evsels with --strip, as they are needed for create_gcov
    (see the autofdo example in tools/perf/Documentation/intel-pt.txt).

Intel PT:

  Adrian Hunter:

  - Intel PT uses an auxtrace_cache to store the results of code-walking, to avoid
    repeated decoding. Add an auxtrace_cache__remove to handle text poke events.

core:

  Andi Kleen:

  - Always preserve errno while cleaning up perf_event_open failures.

llvm:

  Arnaldo Carvalho de Melo:

  - No need to tell that the request for saving a .o file for BPF events, as
    expressed in ~/.perfconfig was satisfied, make that a debug message.

perf vendor events:

Intel:

  Haiyan Song:

  - Update CascadelakeX events to v1.05.

  - Update all the Intel JSON metrics from TMAM 3.6.

Treewide:

  Ian Rogers:

  - Improve error paths, plugging leaks found using LLVM tools
    such as libFuzzer.

jevents:

  Yunfeng Ye:

  - Fix resource leak in process_mapfile() and main()

perf kvm:

  Igor Lubashev:

  - Use evlist layer api when possible.

libsubcmd:

  James Clark:

  - Move EXTRA_FLAGS to the end to allow overriding existing flags.

  - Use -O0 with DEBUG=1

perf diff:

  Jin Yao:

  - Don't use hack to skip column length calculation

CoreSight ETM:

  Leo yan:

  - Fix definition of macro TO_CS_QUEUE_NR

ARM64:

  John Garry:

  - Do not try to include libelf header files when its feature detection
    failed, fixing the cross build for ARM64.

perf tests:

  Leo Yan:

  - Fix out of bounds memory access in the backward ring buffer test.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (9):
      perf data: Correctly identify directory data files
      perf data: Move perf_dir_version into data.h
      perf data: Rename directory "header" file to "data"
      perf data: Support single perf.data file directory
      perf record: Put a copy of kcore into the perf.data directory
      perf auxtrace: Add auxtrace_cache__remove()
      perf dso: Refactor dso_cache__read()
      perf dso: Add dso__data_write_cache_addr()
      perf inject: Make --strip keep evsels

Andi Kleen (2):
      perf evsel: Always preserve errno while cleaning up perf_event_open failures
      perf evsel: Avoid close(-1)

Arnaldo Carvalho de Melo (7):
      perf llvm: Make .o saving a debug message, not an info one
      perf map: Check if the map still has some refcounts on exit
      perf map: Allow map__next() to receive a NULL arg
      perf maps: Add for_each_entry()/_safe() iterators
      perf map_groups: Introduce for_each_entry() and for_each_entry_safe() iterators
      perf symbols: Remove needless checks for map->groups->machine
      perf machine: Add kernel_dso() method

Haiyan Song (2):
      perf vendor events intel: Update CascadelakeX events to v1.05
      perf vendor events intel: Update all the Intel JSON metrics from TMAM 3.6.

Ian Rogers (10):
      perf tools: Move ALLOC_LIST into a function
      perf tools: Avoid a malloc() for array events
      perf tools: Splice events onto evlist even on error
      perf parse: Add parse events handle error
      perf parse: Ensure config and str in terms are unique
      perf parse: Add destructors for parse event terms
      perf parse: Before yyabort-ing free components
      perf parse: If pmu configuration fails free terms
      perf parse: Add a deep delete for parse event terms
      perf annotate: Fix heap overflow

Igor Lubashev (1):
      perf kvm: Use evlist layer api when possible

James Clark (2):
      libsubcmd: Move EXTRA_FLAGS to the end to allow overriding existing flags
      libsubcmd: Use -O0 with DEBUG=1

Jin Yao (7):
      perf diff: Don't use hack to skip column length calculation
      perf block: Cleanup and refactor block info functions
      perf hist: Count the total cycles of all samples
      perf hist: Support block formats with compare/sort/display
      perf report: Sort by sampled cycles percent per block for stdio
      perf report: Support --percent-limit for --total-cycles
      perf report: Sort by sampled cycles percent per block for tui

Jiri Olsa (3):
      perf session: Fix indent in perf_session__new()"
      perf env: Add perf_env__numa_node()
      perf stat: Add --per-node agregation support

Jiwei Sun (1):
      perf record: Add support for limit perf output file size

John Garry (1):
      perf tools: Fix cross compile for ARM64

Leo Yan (3):
      perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
      perf tests: Fix a typo
      perf tests: Fix out of bounds memory access

Masami Hiramatsu (14):
      perf probe: Fix to find range-only function instance
      perf probe: Walk function lines in lexical blocks
      perf probe: Fix to show function entry line as probe-able
      perf probe: Fix wrong address verification
      perf probe: Fix to probe a function which has no entry pc
      perf probe: Fix to probe an inline function which has no entry pc
      perf probe: Fix to list probe event with correct line number
      perf probe: Fix to show inlined function callsite without entry_pc
      perf probe: Fix to show ranges of variables in functions without entry_pc
      perf probe: Return a better scope DIE if there is no best scope
      perf probe: Skip end-of-sequence and non statement lines
      perf probe: Filter out instances except for inlined subroutine and subprogram
      perf probe: Fix to show calling lines of inlined functions
      perf probe: Skip overlapped location on searching variables

Yunfeng Ye (1):
      perf jevents: Fix resource leak in process_mapfile() and main()

 tools/lib/subcmd/Makefile                          |     9 +-
 tools/perf/Documentation/perf-record.txt           |     7 +
 tools/perf/Documentation/perf-report.txt           |    11 +
 tools/perf/Documentation/perf-stat.txt             |     5 +
 .../Documentation/perf.data-directory-format.txt   |    63 +
 tools/perf/arch/arm64/util/sym-handling.c          |     3 +-
 tools/perf/arch/x86/util/event.c                   |     2 +-
 tools/perf/builtin-annotate.c                      |     2 +-
 tools/perf/builtin-diff.c                          |   121 +-
 tools/perf/builtin-inject.c                        |    54 -
 tools/perf/builtin-kvm.c                           |     2 +-
 tools/perf/builtin-record.c                        |   100 +-
 tools/perf/builtin-report.c                        |    67 +-
 tools/perf/builtin-stat.c                          |    52 +
 tools/perf/builtin-top.c                           |     3 +-
 tools/perf/lib/evsel.c                             |     3 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   178 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   184 +-
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 12068 +++++++++----------
 .../arch/x86/cascadelakex/clx-metrics.json         |   210 +-
 .../arch/x86/cascadelakex/floating-point.json      |    92 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   656 +-
 .../pmu-events/arch/x86/cascadelakex/memory.json   | 11408 +++++++++---------
 .../pmu-events/arch/x86/cascadelakex/other.json    |  9620 +++++++--------
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |  1234 +-
 .../arch/x86/cascadelakex/uncore-memory.json       |   191 +
 .../arch/x86/cascadelakex/uncore-other.json        |  1585 ++-
 .../arch/x86/cascadelakex/virtual-memory.json      |   339 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   164 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   170 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   170 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   172 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   114 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   112 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   188 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   204 +-
 tools/perf/pmu-events/jevents.c                    |    13 +-
 tools/perf/tests/backward-ring-buffer.c            |     9 +
 tools/perf/tests/bp_signal.c                       |     2 +-
 tools/perf/tests/map_groups.c                      |     9 +-
 tools/perf/tests/vmlinux-kallsyms.c                |     6 +-
 tools/perf/ui/browsers/hists.c                     |     7 +-
 tools/perf/ui/browsers/hists.h                     |     2 +
 tools/perf/ui/stdio/hist.c                         |    29 +-
 tools/perf/util/Build                              |     1 +
 tools/perf/util/annotate.c                         |     2 +-
 tools/perf/util/auxtrace.c                         |    28 +
 tools/perf/util/auxtrace.h                         |     1 +
 tools/perf/util/block-info.c                       |   538 +
 tools/perf/util/block-info.h                       |    78 +
 tools/perf/util/cpumap.c                           |    18 +
 tools/perf/util/cpumap.h                           |     3 +
 tools/perf/util/cs-etm.c                           |     4 +-
 tools/perf/util/data.c                             |    46 +-
 tools/perf/util/data.h                             |    12 +
 tools/perf/util/dso.c                              |   135 +-
 tools/perf/util/dso.h                              |     7 +
 tools/perf/util/dwarf-aux.c                        |    80 +-
 tools/perf/util/dwarf-aux.h                        |     3 +
 tools/perf/util/env.c                              |    40 +
 tools/perf/util/env.h                              |     6 +
 tools/perf/util/evsel.c                            |     9 +-
 tools/perf/util/header.h                           |     4 -
 tools/perf/util/hist.c                             |    13 +-
 tools/perf/util/hist.h                             |     3 +-
 tools/perf/util/llvm-utils.c                       |     5 +-
 tools/perf/util/machine.c                          |    12 +-
 tools/perf/util/map.c                              |    65 +-
 tools/perf/util/map_groups.h                       |    24 +-
 tools/perf/util/parse-events.c                     |   175 +-
 tools/perf/util/parse-events.h                     |     3 +
 tools/perf/util/parse-events.y                     |   390 +-
 tools/perf/util/pmu.c                              |    32 +-
 tools/perf/util/probe-event.c                      |     2 +-
 tools/perf/util/probe-finder.c                     |    77 +-
 tools/perf/util/record.h                           |     1 +
 tools/perf/util/session.c                          |     8 +-
 tools/perf/util/stat-display.c                     |    15 +
 tools/perf/util/stat.c                             |     1 +
 tools/perf/util/stat.h                             |     1 +
 tools/perf/util/symbol.c                           |    64 +-
 tools/perf/util/symbol.h                           |    24 -
 tools/perf/util/symbol_conf.h                      |     1 +
 tools/perf/util/synthetic-events.c                 |     2 +-
 tools/perf/util/thread.c                           |     2 +-
 tools/perf/util/util.c                             |    19 +-
 tools/perf/util/vdso.c                             |     4 +-
 87 files changed, 22145 insertions(+), 19453 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt
 create mode 100644 tools/perf/util/block-info.c
 create mode 100644 tools/perf/util/block-info.h

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

Manjaro is failing due to some missing library related to bison, looks like
a distro bug.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.4.0-rc5.tar.xz
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
  10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 centos:8                      : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3), clang version 7.0.1 (tags/RELEASE_701/final)
  17 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20191101 gcc-9-branch@277702, clang version 9.0.0 (tags/RELEASE_900/final)
  18 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  19 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  20 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  21 debian:experimental           : Ok   gcc (Debian 9.2.1-9) 9.2.1 20191008, clang version 8.0.1-3+b1 (tags/RELEASE_801/final)
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
  46 manjaro:latest                : FAIL gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  47 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  48 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  49 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  50 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  51 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190903 [gcc-9-branch revision 275330], clang version 9.0.0 (tags/RELEASE_900/final 372316)
  52 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  53 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  54 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  55 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  56 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  57 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  58 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  59 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  60 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  61 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  62 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  63 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  65 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  66 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  67 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  68 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  69 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  70 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  73 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  74 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  75 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  76 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  77 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  78 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  79 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  80 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)
  #

  # uname -a
  Linux quaco 5.3.8-200.fc30.x86_64 #1 SMP Tue Oct 29 14:46:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  7fa46cbf20d3 perf report: Sort by sampled cycles percent per block for tui
  # perf version --build-options
  perf version 5.4.rc5.g7fa46cbf20d3
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
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
                   make_help_O: make help
        make_with_babeltrace_O: make LIBBABELTRACE=1
               make_no_slang_O: make NO_SLANG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
                    make_doc_O: make doc
                make_install_O: make install
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_debug_O: make DEBUG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_util_map_o_O: make util/map.o
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_tags_O: make tags
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
                 make_cscope_O: make cscope
         make_with_clangllvm_O: make LIBCLANGLLVM=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
                make_no_newt_O: make NO_NEWT=1
              make_clean_all_O: make clean all
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                 make_perf_o_O: make perf.o
                   make_pure_O: make
            make_no_demangle_O: make NO_DEMANGLE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
