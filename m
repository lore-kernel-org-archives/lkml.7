Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E34C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAD821916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194319;
	bh=RSJEXHp3MkWy/nPxncDGwaO6ksrACmPNLZuDAh8C9yM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CBoEasPCDAhkiV2MF0SWPBFxhKXJtNjV6xujJBB3Lre5ekSpYOv+mv4meX996eD+x
	 g7Y3iUHlvAa2oxIgmmQD1IGMjsRSwvmwvySFxONnb65gVwcrg1A7VL6KwUQ8C4+85F
	 LmGMwjUo50xaqQdZ+WysQef18wnfrCNbRYecpasY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfCUSv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfCUSv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:51:57 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CE1218D8;
        Thu, 21 Mar 2019 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194314;
        bh=RSJEXHp3MkWy/nPxncDGwaO6ksrACmPNLZuDAh8C9yM=;
        h=From:To:Cc:Subject:Date:From;
        b=DzGMYAu1LCPHT6WI4T79KFS3FWPGdauJA06Nd+yT724EF9+DCl3GuxmAd+6X+2DRO
         cX+SRGNGSwQ9SWk2JIGZ/6Oe1q0hVHGCAylefoShfbkJrYmgOG5XTRVoYBkhxX57id
         SqUMW+rLlxQuiBuj5va6T1F8sdfnmv+N2Vp1qkRY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/44] perf/core fixes and improvements
Date:   Thu, 21 Mar 2019 15:50:58 -0300
Message-Id: <20190321185142.11441-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, this is on top of my previous pull
request, that is outstanding, perf-core-for-mingo-5.1-20190311.

	Most of the patches plug exit path reference count and memory
leaks, some simple new features and then a late new one that has been
thru 9 versions before being finally merged, the annotation of BPF
programs, using the BTF information to have even the original source
code intermixed with the JITed code.

Best Regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4:

  tools lib bpf: Fix the build by adding a missing stdarg.h include (2019-03-11 17:14:31 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190321

for you to fetch changes up to f8dfeae009effc0b6dac2741cf8d7cbb91edb982:

  perf bpf: Show more BPF program info in print_bpf_prog_info() (2019-03-21 11:27:04 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

BPF:

  Song Liu:

  - Add support for annotating BPF programs, using the PERF_RECORD_BPF_EVENT
    and PERF_RECORD_KSYMBOL recently added to the kernel and plugging
    binutils's libopcodes disassembly of BPF programs with the existing
    annotation interfaces in 'perf annotate', 'perf report' and 'perf top'
    various output formats (--stdio, --stdio2, --tui).

perf list:

  Andi Kleen:

  - Filter metrics when using substring search.

perf record:

  Andi Kleen:

  - Allow to limit number of reported perf.data files

  - Clarify help for --switch-output.

perf report:

  Andi Kleen

  - Indicate JITed code better.

  - Show all sort keys in help output.

perf script:

  Andi Kleen:

  - Support relative time.

perf stat:

  Andi Kleen:

  - Improve scaling.

General:

  Changbin Du:

  - Fix some mostly error path memory and reference count leaks found
    using gcc's ASan and UBSan.

Vendor events:

  Mamatha Inamdar:

  - Remove P8 HW events which are not supported.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (8):
      perf list: Filter metrics too
      perf record: Allow to limit number of reported perf.data files
      perf record: Clarify help for --switch-output
      perf report: Show all sort keys in help output
      perf report: Indicate JITed code better in report
      perf script: Support relative time
      perf stat: Fix --no-scale
      perf stat: Improve scaling

Arnaldo Carvalho de Melo (1):
      perf evsel: Free evsel->counts in perf_evsel__exit()

Changbin Du (15):
      perf tools: Add doc about how to build perf with Asan and UBSan
      perf list: Don't forget to drop the reference to the allocated thread_map
      perf tools: Fix errors under optimization level '-Og'
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Delete the evlist before perf_session, fixing heap-use-after-free issue
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf map: Remove map from 'names' tree in __maps__remove()
      perf maps: Purge all maps from the 'names' tree
      perf top: Fix global-buffer-overflow issue
      perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test
      perf tests: Fix memory leak by expr__find_other() in test__expr()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Mamatha Inamdar (1):
      perf vendor events: Remove P8 HW events which are not supported

Song Liu (19):
      perf record: Replace option --bpf-event with --no-bpf-event
      tools lib bpf: Introduce bpf_program__get_prog_info_linear()
      bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()
      perf bpf: Synthesize bpf events with bpf_program__get_prog_info_linear()
      perf bpf: Make synthesize_bpf_events() receive perf_session pointer instead of perf_tool
      perf bpf: Save bpf_prog_info in a rbtree in perf_env
      perf bpf: Save bpf_prog_info information as headers to perf.data
      perf bpf: Save BTF in a rbtree in perf_env
      perf bpf: Save BTF information as headers to perf.data
      perf top: Add option --no-bpf-event
      perf feature detection: Add -lopcodes to feature-libbfd
      perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
      perf bpf: Process PERF_BPF_EVENT_PROG_LOAD for annotation
      perf build: Check what binutils's 'disassembler()' signature to use
      perf annotate: Enable annotation of BPF programs
      perf evlist: Introduce side band thread
      perf tools: Save bpf_prog_info and BTF of new BPF programs
      perf bpf: Extract logic to create program names from perf_event__synthesize_one_bpf_prog()
      perf bpf: Show more BPF program info in print_bpf_prog_info()

 tools/bpf/bpftool/prog.c                           | 266 ++-------
 tools/build/Makefile.feature                       |   6 +-
 tools/build/feature/test-all.c                     |   5 +
 tools/lib/bpf/libbpf.c                             | 253 ++++++++-
 tools/lib/bpf/libbpf.h                             |  63 +++
 tools/lib/bpf/libbpf.map                           |   3 +
 tools/perf/Documentation/Build.txt                 |  24 +
 tools/perf/Documentation/perf-config.txt           |   2 +-
 tools/perf/Documentation/perf-record.txt           |   4 +
 tools/perf/Documentation/perf-script.txt           |   3 +
 tools/perf/Documentation/perf-stat.txt             |   5 +-
 tools/perf/Makefile.config                         |  15 +-
 tools/perf/bench/epoll-ctl.c                       |   2 +-
 tools/perf/bench/epoll-wait.c                      |   2 +-
 tools/perf/builtin-list.c                          |   2 +-
 tools/perf/builtin-record.c                        |  50 +-
 tools/perf/builtin-report.c                        |   5 +-
 tools/perf/builtin-script.c                        |  18 +-
 tools/perf/builtin-stat.c                          |   3 +-
 tools/perf/builtin-top.c                           |  62 ++-
 tools/perf/perf.c                                  |   1 +
 tools/perf/perf.h                                  |   2 +-
 .../perf/pmu-events/arch/powerpc/power8/other.json | 594 ---------------------
 tools/perf/tests/attr/test-record-C0               |   2 +-
 tools/perf/tests/attr/test-record-basic            |   2 +-
 tools/perf/tests/attr/test-record-branch-any       |   2 +-
 .../perf/tests/attr/test-record-branch-filter-any  |   2 +-
 .../tests/attr/test-record-branch-filter-any_call  |   2 +-
 .../tests/attr/test-record-branch-filter-any_ret   |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-hv |   2 +-
 .../tests/attr/test-record-branch-filter-ind_call  |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-k  |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-u  |   2 +-
 tools/perf/tests/attr/test-record-count            |   2 +-
 tools/perf/tests/attr/test-record-data             |   2 +-
 tools/perf/tests/attr/test-record-freq             |   2 +-
 tools/perf/tests/attr/test-record-graph-default    |   2 +-
 tools/perf/tests/attr/test-record-graph-dwarf      |   2 +-
 tools/perf/tests/attr/test-record-graph-fp         |   2 +-
 tools/perf/tests/attr/test-record-group            |   2 +-
 tools/perf/tests/attr/test-record-group-sampling   |   2 +-
 tools/perf/tests/attr/test-record-group1           |   2 +-
 tools/perf/tests/attr/test-record-no-buffering     |   2 +-
 tools/perf/tests/attr/test-record-no-inherit       |   2 +-
 tools/perf/tests/attr/test-record-no-samples       |   2 +-
 tools/perf/tests/attr/test-record-period           |   2 +-
 tools/perf/tests/attr/test-record-raw              |   2 +-
 tools/perf/tests/backward-ring-buffer.c            |   2 +-
 tools/perf/tests/evsel-tp-sched.c                  |   1 +
 tools/perf/tests/expr.c                            |   5 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   4 +-
 tools/perf/util/annotate.c                         | 163 +++++-
 tools/perf/util/annotate.h                         |   1 +
 tools/perf/util/bpf-event.c                        | 425 +++++++++++----
 tools/perf/util/bpf-event.h                        |  42 +-
 tools/perf/util/build-id.c                         |   1 +
 tools/perf/util/config.c                           |   3 +-
 tools/perf/util/data.c                             |  11 +-
 tools/perf/util/data.h                             |   2 +-
 tools/perf/util/dso.c                              |  43 +-
 tools/perf/util/dso.h                              |   8 +
 tools/perf/util/env.c                              | 155 ++++++
 tools/perf/util/env.h                              |  24 +
 tools/perf/util/evlist.c                           | 119 +++++
 tools/perf/util/evlist.h                           |  12 +
 tools/perf/util/evsel.c                            |   8 +-
 tools/perf/util/evsel.h                            |   6 +
 tools/perf/util/header.c                           | 253 ++++++++-
 tools/perf/util/header.h                           |   2 +
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/map.c                              |  18 +
 tools/perf/util/ordered-events.c                   |   2 +
 tools/perf/util/parse-events.c                     |   2 +
 tools/perf/util/session.c                          |   1 +
 tools/perf/util/sort.c                             |  52 ++
 tools/perf/util/sort.h                             |   2 +
 tools/perf/util/stat.c                             |  12 +-
 tools/perf/util/symbol.c                           |   1 +
 78 files changed, 1794 insertions(+), 1028 deletions(-)

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

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.0.0.tar.xz
  $ time dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.3.1 20190317 gcc-8-branch@269736
  16 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  19 debian:experimental           : Ok   gcc (Debian 8.3.0-2) 8.3.0
  20 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0
  21 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0
  22 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-2) 8.3.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  29 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  31 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  32 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  33 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190227 (Red Hat 9.0.1-0.8)
  34 fedora:rawhide                : Ok   gcc (GCC) 9.0.1 20190227 (Red Hat 9.0.1-0.8)
  35 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.2.0-r6 p1.7) 8.2.0
  36 mageia:5                      : Ok   gcc (GCC) 4.9.2
  37 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  38 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  39 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  40 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.3.1 20190226 [gcc-8-branch revision 269204]
  41 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  42 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  43 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  44 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  45 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  46 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  47 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  54 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  55 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  56 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  57 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  66 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-2ubuntu2) 8.3.0
  67 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-2ubuntu1) 8.3.0
  68 ubuntu:19.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-2ubuntu1) 8.3.0
  69 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-2ubuntu1) 8.3.0

The gcc got pdated on that ubuntu 19.04-x-arm64 container and caught this, that
is already being addressed by Mathieu and Solomon Tan, the problem is not being
introduced by this patchset.

    LD       /tmp/build/perf/util/scripting-engines/perf-in.o
  util/cs-etm-decoder/cs-etm-decoder.c: In function 'cs_etm_decoder__buffer_range':
  util/cs-etm-decoder/cs-etm-decoder.c:383:2: error: enumeration value 'OCSD_INSTR_WFI_WFE' not handled in switch [-Werror=switch-enum]
    switch (elem->last_i_type) {
    ^~~~~~
    CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o


  # uname -a
  Linux quaco 5.0.0+ #2 SMP Tue Mar 12 15:15:22 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  f8dfeae009ef perf bpf: Show more BPF program info in print_bpf_prog_info()
  # perf version --build-options
  perf version 5.0.gf8dfea
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
  59: x86 rdpmc                                             : Ok
  60: Convert perf time to TSC                              : Ok
  61: DWARF unwind                                          : Ok
  62: x86 instruction decoder - new instructions            : Ok
  63: x86 bp modify                                         : Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
            make_install_bin_O: make install-bin
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                    make_doc_O: make doc
                 make_cscope_O: make cscope
                   make_help_O: make help
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_backtrace_O: make NO_BACKTRACE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
  g               make_perf_o_O: make perf.o
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_newt_O: make NO_NEWT=1
                make_install_O: make install
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_tags_O: make tags
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libperl_O: make NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_util_map_o_O: make util/map.o
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_pure_O: make
                 make_static_O: make LDFLAGS=-static
           make_no_libunwind_O: make NO_LIBUNWIND=1
                  make_debug_O: make DEBUG=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_clean_all_O: make clean all
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  
