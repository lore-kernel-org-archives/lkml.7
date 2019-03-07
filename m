Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05D92085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980691;
	bh=xhVvbXQl9Yh0D3m2AhW0iS+ByhVJBirwsJL2AdfdOrc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ESjQrEiMg4ravznTs0m419LQtdgxloo/ddhurzsbiDn35KAATKW52E6Q1A3FkNcQ/
	 tDhhRp0sqIBI1yVa5aXHMENOOx0Z+Ait8/BPPM5c9v33J67+oqOTv+02mnfpyroFot
	 8HXUkO9ZX/5pnQ1sMkopj7etU8WUPIpm+Ucg0mO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCGRot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfCGRos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:44:48 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F8A20661;
        Thu,  7 Mar 2019 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980686;
        bh=xhVvbXQl9Yh0D3m2AhW0iS+ByhVJBirwsJL2AdfdOrc=;
        h=From:To:Cc:Subject:Date:From;
        b=AjH9rWM0rkjavlOEgLuFS/fTEPZCwQTp/cJYiKe2e2HnQuIo8o4Z2wgezULqgR+cT
         mfZkbmj1wWX5zZs77zOgBCXnrU8QJoaiVvuhEZ9ERnRk3mF66DMLwgVzHcVQye7X64
         HxkQB/FlHCWKKa8NoBt5+BR/nPkthIiYNgay51FI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mathias Krause <minipli@googlemail.com>,
        Michael Sartain <mikesart@fastmail.com>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>, Tony Jones <tonyj@suse.de>,
        Travis Downs <travis.downs@gmail.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/35] perf/core improvements and fixes
Date:   Thu,  7 Mar 2019 14:43:58 -0300
Message-Id: <20190307174433.28819-1-acme@kernel.org>
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

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit c978b9460fe1d4a1e1effa0abd6bd69b18a098a8:

  Merge tag 'perf-core-for-mingo-5.1-20190225' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-02-28 08:29:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190307

for you to fetch changes up to b8f7d86b5849ea7bb84bddc0345a3799049764d4:

  perf data: Force perf_data__open|close zero data->file.path (2019-03-06 18:21:00 -0300)

----------------------------------------------------------------
perf bpf:

  Arnaldo Carvalho de Melo:

  - Automatically add BTF ELF markers to 'perf trace' BPF programs, so that
    tools such as 'bpftool map dump' can pretty print map keys and values.

perf c2c:

  Jiri Olsa:

  - Fix report for empty NUMA node.

perf diff:

  Jin Yao:

  - Support --time, --cpu, --pid and --tid filter options.

perf probe:

  Arnaldo Carvalho de Melo:

  - Clarify error message about not finding kernel modules debuginfo.

perf record:

  Jiri Olsa:

  - Fixup probing for max attr.precise_ip.

perf trace:

  Arnaldo Carvalho de Melo:

  - Add missing %s lost in the 'msg_flags' recvmmsg arg when adding prefix suppression logic.

perf annotate:

  Arnaldo Carvalho de Melo:

  - Calculate the max instruction name, align column to that, removing the
    hardcoded max 6 chars and cope with instructions with names longer than that,
    such as vpmovmskb, vpcmpeqb, etc.

kernel:

  Song Liu:

  - Consider events with attr.bpf_event set as side-band.

  Gustavo A. R. Silva:

  - Mark expected switch fall-through in perf_event_parse_addr_filter().

Libraries:

  Jiri Olsa:

  - Fix leaks and double frees on error paths.

libtraceevent:

  Tony Jones:

  - Fix buffer overflow in arg_eval().

python scripting:

  Tony Jones:

  - More python3 fixes.

Trivial:

  Yang Wei:

  - Remove needless extra semicolon in clang C++ glue code.

Intel PT/BTS:

  Adrian Hunter:

  - Improve auxtrace address filter error message when there is no DSO.

  - Fix divide by zero when TSC is not available.

  - Further improvements to the export to sqlite/posgresql python scripts
    and to the GUI sqlviewer, exporting 'parent_id' so that we have enable
    the creation of call trees.

  Andi Kleen:

  - Generalize function to copy from thread addr space from intel-bts code.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (10):
      perf auxtrace: Improve address filter error message when there is no DSO
      perf intel-pt: Fix divide by zero when TSC is not available
      perf db-export: Add calls parent_id to enable creation of call trees
      perf scripts python: export-to-sqlite.py: Export calls parent_id
      perf scripts python: export-to-postgresql.py: Fix invalid input syntax for integer error
      perf scripts python: export-to-postgresql.py: Export calls parent_id
      perf scripts python: exported-sql-viewer.py: Factor out TreeWindowBase
      perf scripts python: exported-sql-viewer.py: Improve TreeModel abstraction
      perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase
      perf scripts python: exported-sql-viewer.py: Add call tree

Andi Kleen (1):
      perf thread: Generalize function to copy from thread addr space from intel-bts code

Arnaldo Carvalho de Melo (4):
      perf probe: Clarify error message about not finding kernel modules debuginfo
      perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic
      perf bpf: Automatically add BTF ELF markers
      perf annotate: Calculate the max instruction name, align column to that

Gustavo A. R. Silva (1):
      perf: Mark expected switch fall-through

Jin Yao (4):
      perf time-utils: Refactor time range parsing code
      perf diff: Support --time filter option
      perf diff: Support --cpu filter option
      perf diff: Support --pid/--tid filter options

Jiri Olsa (7):
      perf c2c: Fix c2c report for empty numa node
      perf hist: Add error path into hist_entry__init
      perf hist: Fix memory leak of srcline
      perf tools: Read and store caps/max_precise in perf_pmu
      perf evsel: Probe for precise_ip with simple attr
      perf session: Fix double free in perf_data__close
      perf data: Force perf_data__open|close zero data->file.path

Song Liu (1):
      perf, bpf: Consider events with attr.bpf_event as side-band events

Tony Jones (6):
      tools lib traceevent: Fix buffer overflow in arg_eval
      perf script python: Remove mixed indentation
      perf script python: Add Python3 support to futex-contention.py
      perf script python: add Python3 support to check-perf-trace.py
      perf script python: Add Python3 support to event_analyzing_sample.py
      perf script python: Add Python3 support to intel-pt-events.py

Yang Wei (1):
      perf clang: Remove needless extra semicolon

 kernel/events/core.c                               |   4 +-
 tools/lib/traceevent/event-parse.c                 |   2 +-
 tools/perf/Documentation/perf-diff.txt             |  56 ++++
 tools/perf/arch/arm64/annotate/instructions.c      |   2 +-
 tools/perf/arch/s390/annotate/instructions.c       |   2 +-
 tools/perf/builtin-c2c.c                           |   8 +-
 tools/perf/builtin-diff.c                          | 168 +++++++++-
 tools/perf/builtin-report.c                        |  38 +--
 tools/perf/builtin-script.c                        |  39 +--
 tools/perf/include/bpf/bpf.h                       |   8 +-
 tools/perf/scripts/python/check-perf-trace.py      |  76 ++---
 tools/perf/scripts/python/compaction-times.py      |   8 +-
 .../perf/scripts/python/event_analyzing_sample.py  |  48 +--
 tools/perf/scripts/python/export-to-postgresql.py  |  16 +-
 tools/perf/scripts/python/export-to-sqlite.py      |  12 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 354 ++++++++++++++++-----
 .../perf/scripts/python/failed-syscalls-by-pid.py  |  38 +--
 tools/perf/scripts/python/futex-contention.py      |  10 +-
 tools/perf/scripts/python/intel-pt-events.py       |  60 ++--
 tools/perf/scripts/python/mem-phys-addr.py         |   7 +-
 tools/perf/scripts/python/net_dropmonitor.py       |   2 +-
 tools/perf/scripts/python/netdev-times.py          |  12 +-
 tools/perf/scripts/python/sched-migration.py       |   6 +-
 tools/perf/scripts/python/sctop.py                 |  13 +-
 tools/perf/scripts/python/stackcollapse.py         |   2 +-
 tools/perf/scripts/python/syscall-counts-by-pid.py |  47 ++-
 tools/perf/scripts/python/syscall-counts.py        |  31 +-
 tools/perf/trace/beauty/msg_flags.c                |   2 +-
 tools/perf/util/annotate.c                         |  74 +++--
 tools/perf/util/annotate.h                         |   7 +-
 tools/perf/util/auxtrace.c                         |   3 +-
 tools/perf/util/c++/clang.cpp                      |   2 +-
 tools/perf/util/data.c                             |   4 +-
 tools/perf/util/db-export.c                        |  15 +-
 tools/perf/util/db-export.h                        |   3 +-
 tools/perf/util/evlist.c                           |  25 +-
 tools/perf/util/evsel.c                            |   8 -
 tools/perf/util/hist.c                             |  51 +--
 tools/perf/util/intel-bts.c                        |  20 +-
 tools/perf/util/intel-pt.c                         |   2 +
 tools/perf/util/pmu.c                              |  14 +
 tools/perf/util/pmu.h                              |   1 +
 tools/perf/util/probe-event.c                      |   9 +-
 .../util/scripting-engines/trace-event-python.c    |   8 +-
 tools/perf/util/session.c                          |   4 +-
 tools/perf/util/thread-stack.c                     |  16 +-
 tools/perf/util/thread-stack.h                     |   6 +-
 tools/perf/util/thread.c                           |  23 ++
 tools/perf/util/thread.h                           |   3 +
 tools/perf/util/time-utils.c                       |  51 ++-
 tools/perf/util/time-utils.h                       |   6 +
 51 files changed, 978 insertions(+), 448 deletions(-)

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

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.0.0-rc8.tar.xz
  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  16 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  19 debian:experimental           : Ok   gcc (Debian 8.2.0-17) 8.2.1 20190204
  20 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  21 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  22 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.2.0-16) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  33 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  34 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190203 (Red Hat 9.0.1-0.3)
  35 fedora:rawhide                : Ok   gcc (GCC) 9.0.1 20190209 (Red Hat 9.0.1-0.4)
  36 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  37 mageia:5                      : Ok   gcc (GCC) 4.9.2
  38 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  39 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  40 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  42 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  43 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  44 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  45 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.2.1 20190103 [gcc-8-branch revision 267549]
  46 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  47 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  48 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  49 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  50 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  51 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  52 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  59 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  67 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  68 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  69 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  70 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  71 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  72 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  73 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.2.0-20ubuntu1) 8.2.0
  74 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  #

  # uname -a
  Linux quaco 5.0.0+ #1 SMP Thu Mar 7 10:32:55 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  b8f7d86b5849 perf data: Force perf_data__open|close zero data->file.path
  # perf version --build-options
  perf version 5.0.rc8.gb8f7d8
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
        make_with_babeltrace_O: make LIBBABELTRACE=1
                  make_debug_O: make DEBUG=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_pure_O: make
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                 make_perf_o_O: make perf.o
            make_install_bin_O: make install-bin
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_newt_O: make NO_NEWT=1
             make_no_libperl_O: make NO_LIBPERL=1
              make_no_libbpf_O: make NO_LIBBPF=1
                make_no_gtk2_O: make NO_GTK2=1
                    make_doc_O: make doc
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                 make_cscope_O: make cscope
                 make_static_O: make LDFLAGS=-static
              make_no_libelf_O: make NO_LIBELF=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_clean_all_O: make clean all
                make_install_O: make install
                   make_tags_O: make tags
         make_install_prefix_O: make install prefix=/tmp/krava
             make_util_map_o_O: make util/map.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_help_O: make help
            make_no_auxtrace_O: make NO_AUXTRACE=1
               make_no_slang_O: make NO_SLANG=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
