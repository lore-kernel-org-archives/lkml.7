Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BDBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3422072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434643;
	bh=LqW76NVXt+0picv1ml61fx0WOYpXEMrB3iQ0M1FESjY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sWBE9lngd1AFJ5ev7Pgj8F0I6jXD7jHSksTebzKvwPxiki7CyKcKk73rlSXaf+GsX
	 iV84WWKbj01w8odbhHMRAEYce445jk494j38fmdglkDstWtVi/cfMWHOvoecFcI5oC
	 MxreYsD48ljTqSO5gMKgn2YAzFZaMwfxn+AL1T6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKVO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVO5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F420420706;
        Fri, 22 Nov 2019 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434639;
        bh=LqW76NVXt+0picv1ml61fx0WOYpXEMrB3iQ0M1FESjY=;
        h=From:To:Cc:Subject:Date:From;
        b=eTvPurKBZwP/n9O+fejSfm8u34QLaRZoIqTd42dIWaZevQ0j9oZ84VuYT7s07iRPY
         iEdsd/PbrrmYeQgQ1VxzIH45SaA3kV3rFad1/LCTF98mJQTT/2UlHbYfv4S8OovceP
         R381Ho1P2XoAZLAv7b/uOvBTYESRoI6tM5ZZJ6Xo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudipm Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Fri, 22 Nov 2019 11:56:45 -0300
Message-Id: <20191122145711.3171-1-acme@kernel.org>
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

The following changes since commit 8f6ee51d772d0dab407d868449d2c5d9c8d2b6fc:

  Merge tag 'perf-core-for-mingo-5.5-20191119' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-11-19 12:59:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191122

for you to fetch changes up to 4584f084aa9d8033d5911935837dbee7b082d0e9:

  perf parse: Fix potential memory leak when handling tracepoint errors (2019-11-22 10:48:14 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf report:

  Jin Yao:

  - Allow entering the annotation view (symbol source/assembly +
    overhead/cycles/etc column) from the 'perf report --total-cycles'
    interface.

    E.g.:

      # perf record --all-cpus --branch-any --all-kernel
      ^C[ perf record: Woken up 5 times to write data ]
      #
      # perf evlist -v
      cycles: size: 120, { sample_period, sample_freq }: 4000,
      sample_type: IP|TID|TIME|CPU|PERIOD|BRANCH_STACK,
      read_format: ID, disabled: 1, inherit: 1, exclude_user: 1, mmap: 1, comm: 1, freq: 1, task: 1,
      precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1,
      bpf_event: 1, branch_sample_type: ANY
      #
      # perf report --total-cycles
      #
      # Samples: 78762 of event 'cycles'
      Sampled  Sampled Avg      Avg
      Cycles%  Cycles  Cycles%  Cycles                           [Program Block Range]     Shared Object
        1.72%    95.8K   0.00%     254                        [msr.h:105 -> msr.h:166]  [kernel.vmlinux]
        1.56%   107.6K   0.00%     618                [compiler.h:199 -> common.c:301]  [kernel.vmlinux]
        0.83%    46.3K   0.00%     409              [entry_64.S:153 -> entry_64.S:175]  [kernel.vmlinux]
        0.83%    46.1K   0.00%      83                  [jump_label.h:41 -> tsc.c:230]  [kernel.vmlinux]
        0.64%    36.9K   0.01%    1.4K            [hda_intel.c:904 -> hda_intel.c:916]   [snd_hda_intel]
        0.57%    30.2K   0.00%     282                      [file.c:710 -> file.c:730]  [kernel.vmlinux]
        0.48%    25.8K   0.00%      82              [spinlock.c:158 -> spinlock.c:160]  [kernel.vmlinux]
        0.45%    23.7K   0.00%     369  [tick-broadcast.c:585 -> tick-broadcast.c:586]  [kernel.vmlinux]
        0.44%    24.4K   0.00%      73                       [msr.h:236 -> tsc.c:1088]  [kernel.vmlinux]
        0.43%    22.7K   0.00%     144                [cpuidle.c:229 -> cpuidle.c:232]  [kernel.vmlinux]

    Then press 'A' or Enter on one of those lines, just like with 'perf top', say
    the top one: [msr.h:105 -> msr.h:166], then this shows up:

      Samples: 78K of event 'cycles', 4000 Hz, Event count (approx.): 78762
      native_write_msr  /lib/modules/5.4.0-rc8/build/vmlinux [Percent: local period]
      Percent│ IPC Cycle (Average IPC: 0.02, IPC Coverage: 50.0%)
             │
             │             Disassembly of section .text:
             │
             │             ffffffff8106c480 <native_write_msr>:
             │             __wrmsr():
             │             return EAX_EDX_VAL(val, low, high);
             │             }
             │
             │             static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
             │             {
             │             asm volatile("1: wrmsr\n"
       49.16 │0.02           mov   %edi,%ecx
             │0.02           mov   %esi,%eax
             │0.02           wrmsr
             │             arch_static_branch():
             │             #include <linux/stringify.h>
             │             #include <linux/types.h>
             │
             │             static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
             │             {
             │             asm_volatile_goto("1:"
        0.79 │0.02           nop
             │             native_write_msr():
             │             {
             │             __wrmsr(msr, low, high);
             │
             │             if (msr_tracepoint_active(__tracepoint_write_msr))
             │             do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
             │             }
       50.05 │0.02  254    ← retq
             │             do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
             │               shl   $0x20,%rdx
             │               mov   %esi,%esi
             │               or    %rdx,%rsi
             │               xor   %edx,%edx
             │             → jmpq  do_trace_write_msr

    We need to improve this to show the source code line numbers in the
    annotation view, so one can go from that program block to the annotation view
    and see those source code line numbers straight away.

auxtrace/Intel PT:

  Adrian Hunter:

  - Add support for AUX area sampling, requires new functionality that
    will land in 5.5, its already in tip.

    This includes kernel capability querying so that it fails gracefully
    with older kernels, duimping aux area samples in 'perf report -D' and
    'perf script'.

perf.data:

  Alexey Budankov:

  - Fix decompression of PERF_RECORD_COMPRESSED records.

core:

  Arnaldo Carvalho de Melo:

  - Use the 'dcacheline' cmp routine to find the right DSOs taking into
    account the 'maj', 'min', 'ino' and 'ino_generation', that got moved
    from 'struct map' to 'struct dso', where it belongs.

    This further reduces the size of 'struct map', there is still more
    work to do to maybe get it to max one cacheline.

libtraceevent:

  Hewenliang:

  - Fix memory leakage in copy_filter_type().

  Sudip Mukherjee:

  - Fix header installation.

perf parse:

  Ian Rogers :

  - Fix potential memory leak when handling tracepoint errors, found using
    LLVM's libFuzzer.

perf probe:

  Colin Ian King:

  - Fix spelling mistake "addrees" -> "address".

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (14):
      perf tools: Add kernel AUX area sampling definitions
      perf record: Add a function to test for kernel support for AUX area sampling
      perf auxtrace: Move perf_evsel__find_pmu()
      perf auxtrace: Add support for AUX area sample recording
      perf record: Add support for AUX area sampling
      perf record: Add aux-sample-size config term
      perf inject: Cut AUX area samples
      perf auxtrace: Add support for dumping AUX area samples
      perf session: Add facility to peek at all events
      perf auxtrace: Add support for queuing AUX area samples
      perf pmu: When using default config, record which bits of config were changed by the user
      perf intel-pt: Add support for recording AUX area samples
      perf intel-pt: Add support for decoding AUX area samples
      perf intel-bts: Does not support AUX area sampling

Alexey Budankov (1):
      perf session: Fix decompression of PERF_RECORD_COMPRESSED records

Arnaldo Carvalho de Melo (5):
      perf map: Move maj/min/ino/ino_generation to separate struct
      perf map: Pass a dso_id to map__new()
      perf map: Move comparision of map's dso_id to a separate function
      perf dsos: Remove unused dsos__find() method
      perf dso: Move dso_id from 'struct map' to 'struct dso'

Colin Ian King (1):
      perf probe: Fix spelling mistake "addrees" -> "address"

Hewenliang (1):
      libtraceevent: Fix memory leakage in copy_filter_type

Ian Rogers (1):
      perf parse: Fix potential memory leak when handling tracepoint errors

Jin Yao (2):
      perf util: Move block TUI function to ui browsers
      perf report: Jump to symbol source view from total cycles view

Sudip Mukherjee (1):
      libtraceevent: Fix header installation

 tools/include/uapi/linux/perf_event.h     |  10 +-
 tools/lib/traceevent/Makefile             |   8 +-
 tools/lib/traceevent/parse-filter.c       |   9 +-
 tools/perf/Documentation/intel-pt.txt     |  59 +++++-
 tools/perf/Documentation/perf-record.txt  |   9 +
 tools/perf/arch/x86/util/auxtrace.c       |   4 +
 tools/perf/arch/x86/util/intel-bts.c      |   5 +
 tools/perf/arch/x86/util/intel-pt.c       |  81 +++++++-
 tools/perf/builtin-inject.c               |  29 +++
 tools/perf/builtin-record.c               |  21 +-
 tools/perf/builtin-report.c               |  11 +-
 tools/perf/tests/attr/base-record         |   2 +-
 tools/perf/tests/attr/base-stat           |   2 +-
 tools/perf/tests/sample-parsing.c         |  16 +-
 tools/perf/ui/browsers/hists.c            |  78 +++++++-
 tools/perf/util/auxtrace.c                | 322 ++++++++++++++++++++++++++++--
 tools/perf/util/auxtrace.h                |  43 ++++
 tools/perf/util/block-info.c              |  71 +------
 tools/perf/util/block-info.h              |   3 +-
 tools/perf/util/dso.c                     |  24 ++-
 tools/perf/util/dso.h                     |  13 ++
 tools/perf/util/dsos.c                    |  97 +++++++--
 tools/perf/util/dsos.h                    |  14 +-
 tools/perf/util/event.h                   |   6 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  31 +++
 tools/perf/util/evsel_config.h            |  13 ++
 tools/perf/util/hist.h                    |  15 ++
 tools/perf/util/intel-pt.c                | 109 +++++++++-
 tools/perf/util/machine.c                 |  22 +-
 tools/perf/util/machine.h                 |   2 +
 tools/perf/util/map.c                     |  11 +-
 tools/perf/util/map.h                     |   9 +-
 tools/perf/util/parse-events.c            |  65 +++++-
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   3 +-
 tools/perf/util/pmu.c                     |  10 +
 tools/perf/util/pmu.h                     |   2 +
 tools/perf/util/probe-finder.c            |   2 +-
 tools/perf/util/record.c                  |  31 +++
 tools/perf/util/record.h                  |   2 +
 tools/perf/util/session.c                 |  82 ++++++--
 tools/perf/util/session.h                 |   5 +
 tools/perf/util/sort.c                    |  24 +--
 tools/perf/util/synthetic-events.c        |  12 ++
 46 files changed, 1190 insertions(+), 200 deletions(-)

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

Manjaro got fixed by adding the 'gettext' package, that provides a
library needed by bison but not present in its dependencies list, i.e. a
distro bug.

cooker is failing with:

  In file included from cpumap.c:4:
  In file included from /git/linux/tools/include/linux/refcount.h:41:
  In file included from /git/linux/tools/include/linux/atomic.h:5:
  In file included from /git/linux/tools/include/asm/atomic.h:6:
  In file included from /git/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:11:
  /git/linux/tools/arch/x86/include/asm/cmpxchg.h:12:2: error: unknown attribute 'error' ignored [-Werror,-Wunknown-attributes]
          __compiletime_error("Bad argument size for cmpxchg");
          ^
  /git/linux/tools/include/linux/compiler-gcc.h:20:54: note: expanded from macro '__compiletime_error'
  # define __compiletime_error(message) __attribute__((error(message)))
                                                       ^
    LD       /tmp/build/perf/fs/libapi-in.o

Still needs investigating, new image, just leaving it here for
documentation purposes, maybe related to it using the most recent gcc
and clang versions?

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.4.0-rc7.tar.xz
  # dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (git://git.alpinelinux.org/aports 25c73ae7b95bdb42ae5f0ceac3b703e766582527) (based on LLVM 9.0.0)
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
  46 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  47 openmandriva:cooker           : FAIL gcc (GCC) 9.2.1 20191109 (OpenMandriva), clang version 9.0.1 
  48 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  49 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  50 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  51 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  52 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190903 [gcc-9-branch revision 275330], clang version 9.0.0 (tags/RELEASE_900/final 372316)
  53 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  54 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  55 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  56 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  57 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  58 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  59 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  60 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  61 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  62 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  63 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  66 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  67 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  68 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  69 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  70 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  73 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  74 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  75 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  76 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  77 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  78 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  79 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  80 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  81 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)
  #

  # uname -a
  Linux quaco 5.4.0-rc8 #1 SMP Mon Nov 18 06:15:31 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  4584f084aa9d perf parse: Fix potential memory leak when handling tracepoint errors
  # perf version --build-options
  perf version 5.4.rc7.g4584f084aa9d
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
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_perf_o_O: make perf.o
                make_install_O: make install
             make_no_libnuma_O: make NO_LIBNUMA=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_pure_O: make
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_help_O: make help
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_cscope_O: make cscope
                make_no_newt_O: make NO_NEWT=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                  make_debug_O: make DEBUG=1
              make_clean_all_O: make clean all
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                    make_doc_O: make doc
         make_install_prefix_O: make install prefix=/tmp/krava
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
             make_util_map_o_O: make util/map.o
                   make_tags_O: make tags
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
