Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BA2C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729332183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034388;
	bh=trWQQimgHas4uwA1eCOZKiHYqFjE0EmTJY/w25B6CD0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Gz7ItPzY7ZUaTtBKYNVxSjiHaGVJjM/2aGZaccxxaNhXnIzks9McSpeguKytZJbY8
	 4Lxgn+OnPoGB25vOqNMDM3oYYk1Sfwu1iUKYDjVVHluYBOVhfuIAj6Luso5Lq470XY
	 dC0dfJy71rZdEhdDwUMKT9s8WR2dLJvzCisgzhXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfGBC00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfGBC00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02EAF206A2;
        Tue,  2 Jul 2019 02:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034383;
        bh=trWQQimgHas4uwA1eCOZKiHYqFjE0EmTJY/w25B6CD0=;
        h=From:To:Cc:Subject:Date:From;
        b=LSSiSHVUTQMevf17RoW5wh9FHLPw6LFylxOsZGCprMEZnm/LzgoSN9zUACmY6+ROM
         OaXBam72jTNe+qf1lJUAlcEBP/lX9qhlq0Ktcq5+xkRTg7Zl9LMG9WSI/XJmzpb8gd
         FSaByl1QMPvlTU0LJXh/wXMGPHh2MU5iWrL0Ytwg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Luke Mujica <lukemujica@google.com>,
        Mao Han <han_mao@c-sky.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon,  1 Jul 2019 23:25:33 -0300
Message-Id: <20190702022616.1259-1-acme@kernel.org>
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

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit fd7d55172d1e2e501e6da0a5c1de25f06612dc2e:

  perf/cgroups: Don't rotate events for cgroups unnecessarily (2019-06-24 19:30:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190701

for you to fetch changes up to 06c642c0e9fceafd16b1a4c80d44b1c09e282215:

  perf jevents: Use nonlocal include statements in pmu-events.c (2019-07-01 22:50:42 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf annotate:

  Mao Han:

  - Add support for the csky processor architecture.

perf stat:

  Andi Kleen:

  - Fix metrics with --no-merge.

  - Don't merge events in the same PMU.

  - Fix group lookup for metric group.

Intel PT:

  Adrian Hunter:

  - Improve CBR (Core to Bus Ratio) packets support.

  - Fix thread stack return from kernel for kernel only case.

  - Export power and ptwrite events to sqlite and postgresql.

core libraries:

  Arnaldo Carvalho de Melo:

  - Find routines in tools/perf/util/ that have implementations in the kernel
    libraries (lib/*.c), such as strreplace(), strim(), skip_spaces() and reuse
    them after making a copy into tools/lib and tools/include/.

    This continues the effort of having tools/ code looking as much as possible
    like kernel source code, to help encourage people to work on both the kernel
    and in tools hosted in the kernel sources.

    That in turn will help moving stuff that uses those routines to
    tools/lib/perf/ where they will be made available for use in other tools.

    In the process ditch old cruft, remove unused variables and add missing
    include directives for headers providing things used in places that were
    building by sheer luck.

  Kyle Meyer:

  - Bump MAX_NR_CPUS and MAX_CACHES to get these tools to work on more machines.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (9):
      perf thread-stack: Fix thread stack return from kernel for kernel-only case
      perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()
      perf intel-pt: Decoder to output CBR changes immediately
      perf intel-pt: Cater for CBR change in PSB+
      perf intel-pt: Add CBR value to decoder state
      perf intel-pt: Synthesize CBR events when last seen value changes
      perf db-export: Export synth events
      perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events
      perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events

Andi Kleen (4):
      perf stat: Make metric event lookup more robust
      perf stat: Don't merge events in the same PMU
      perf stat: Fix group lookup for metric group
      perf stat: Fix metrics with --no-merge

Arnaldo Carvalho de Melo (26):
      perf ctype: Remove unused 'graph_line' variable
      perf ui stdio: No need to use 'spaces' to left align
      perf ctype: Remove now unused 'spaces' variable
      perf string: Move 'dots' and 'graph_dotted_line' out of sane_ctype.h
      tools x86 machine: Add missing util.h to pick up 'page_size'
      perf kallsyms: Adopt hex2u64 from tools/perf/util/util.h
      perf symbols: We need util.h in symbol-elf.c for zfree()
      perf tools: Remove old baggage that is util/include/linux/ctype.h
      perf tools: Add missing util.h to pick up 'page_size' variable
      tools perf: Move from sane_ctype.h obtained from git to the Linux's original
      perf tools: Use linux/ctype.h in more places
      tools lib: Adopt skip_spaces() from the kernel sources
      perf stat: Use recently introduced skip_spaces()
      perf header: Use skip_spaces() in __write_cpudesc()
      perf time-utils: Use skip_spaces()
      perf probe: Use skip_spaces() for argv handling
      perf strfilter: Use skip_spaces()
      perf metricgroup: Use strsep()
      perf report: Use skip_spaces()
      perf tools: Ditch rtrim(), use skip_spaces() to get closer to the kernel
      tools lib: Adopt strim() from the kernel
      perf tools: Remove trim() implementation, use tools/lib's strim()
      perf tools: Ditch rtrim(), use strim() from tools/lib
      tools lib: Adopt strreplace() from the kernel
      perf tools: Drop strxfrchar(), use strreplace() equivalent from kernel
      tools lib: Move argv_{split,free} from tools/perf/util/

Kyle Meyer (1):
      perf tools: Increase MAX_NR_CPUS and MAX_CACHES

Luke Mujica (1):
      perf jevents: Use nonlocal include statements in pmu-events.c

Mao Han (1):
      perf annotate: Add csky support

Numfor Mbiziwo-Tiapo (1):
      perf tools: Fix cache.h include directive

 tools/include/linux/ctype.h                        |  75 ++++++
 tools/include/linux/string.h                       |  11 +-
 tools/lib/argv_split.c                             | 100 ++++++++
 tools/lib/ctype.c                                  |  35 +++
 tools/lib/string.c                                 |  55 +++++
 tools/lib/symbol/kallsyms.c                        |  14 +-
 tools/lib/symbol/kallsyms.h                        |   2 +
 tools/perf/MANIFEST                                |   2 +
 tools/perf/arch/arm/util/cs-etm.c                  |   1 +
 tools/perf/arch/csky/annotate/instructions.c       |  48 ++++
 tools/perf/arch/s390/util/header.c                 |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |   1 +
 tools/perf/arch/x86/util/intel-pt.c                |   1 +
 tools/perf/arch/x86/util/machine.c                 |   3 +-
 tools/perf/builtin-kmem.c                          |   3 +-
 tools/perf/builtin-report.c                        |   5 +-
 tools/perf/builtin-sched.c                         |   3 +-
 tools/perf/builtin-script.c                        |  14 +-
 tools/perf/builtin-stat.c                          |   2 +-
 tools/perf/builtin-top.c                           |   3 +-
 tools/perf/builtin-trace.c                         |   2 +-
 tools/perf/check-headers.sh                        |   2 +
 tools/perf/perf.c                                  |   1 +
 tools/perf/perf.h                                  |   2 +-
 tools/perf/pmu-events/jevents.c                    |   4 +-
 tools/perf/scripts/python/export-to-postgresql.py  | 251 +++++++++++++++++++++
 tools/perf/scripts/python/export-to-sqlite.py      | 239 ++++++++++++++++++++
 tools/perf/tests/builtin-test.c                    |   3 +-
 tools/perf/tests/code-reading.c                    |   2 +-
 tools/perf/ui/browser.c                            |   4 +-
 tools/perf/ui/browsers/hists.c                     |  10 +-
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/gtk/hists.c                          |   5 +-
 tools/perf/ui/progress.c                           |   2 +-
 tools/perf/ui/stdio/hist.c                         |  16 +-
 tools/perf/util/Build                              |   9 +
 tools/perf/util/annotate.c                         |  20 +-
 tools/perf/util/auxtrace.c                         |   2 +-
 tools/perf/util/build-id.c                         |   2 +-
 tools/perf/util/config.c                           |   2 +-
 tools/perf/util/cpumap.c                           |   2 +-
 tools/perf/util/ctype.c                            |  49 ----
 tools/perf/util/data-convert-bt.c                  |   2 +-
 tools/perf/util/debug.c                            |   2 +-
 tools/perf/util/demangle-java.c                    |   2 +-
 tools/perf/util/dso.c                              |   3 +-
 tools/perf/util/env.c                              |   2 +-
 tools/perf/util/event.c                            |   6 +-
 tools/perf/util/evsel.c                            |   3 +-
 tools/perf/util/header.c                           |  15 +-
 tools/perf/util/include/linux/ctype.h              |   1 -
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  24 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         |  65 ++++--
 tools/perf/util/jitdump.c                          |   2 +-
 tools/perf/util/machine.c                          |   3 +-
 tools/perf/util/metricgroup.c                      |  52 +++--
 tools/perf/util/pmu.c                              |   5 +-
 tools/perf/util/print_binary.c                     |   2 +-
 tools/perf/util/probe-event.c                      |   2 +-
 tools/perf/util/probe-finder.h                     |   2 +-
 tools/perf/util/python-ext-sources                 |   3 +-
 tools/perf/util/python.c                           |   1 +
 tools/perf/util/sane_ctype.h                       |  52 -----
 .../util/scripting-engines/trace-event-python.c    |  46 +++-
 tools/perf/util/srcline.c                          |   3 +-
 tools/perf/util/stat-display.c                     |  14 +-
 tools/perf/util/stat-shadow.c                      |  23 +-
 tools/perf/util/strfilter.c                        |   6 +-
 tools/perf/util/string.c                           | 169 +-------------
 tools/perf/util/string2.h                          |  15 +-
 tools/perf/util/symbol-elf.c                       |   3 +-
 tools/perf/util/symbol.c                           |   2 +-
 tools/perf/util/thread-stack.c                     |  48 ++--
 tools/perf/util/thread_map.c                       |   3 +-
 tools/perf/util/time-utils.c                       |   8 +-
 tools/perf/util/trace-event-parse.c                |   2 +-
 tools/perf/util/util.c                             |  13 --
 tools/perf/util/util.h                             |   1 -
 79 files changed, 1167 insertions(+), 450 deletions(-)
 create mode 100644 tools/include/linux/ctype.h
 create mode 100644 tools/lib/argv_split.c
 create mode 100644 tools/lib/ctype.c
 create mode 100644 tools/perf/arch/csky/annotate/instructions.c
 delete mode 100644 tools/perf/util/ctype.c
 delete mode 100644 tools/perf/util/include/linux/ctype.h
 delete mode 100644 tools/perf/util/sane_ctype.h

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

Investigating the failure for ubuntu:18.04-x-arm, doesn't look like something
introduced by this patchkit.

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0-rc6.tar.xz
  $ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 7.0.1 (tags/RELEASE_701/final) (based on LLVM 7.0.1)
   9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  18 debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
  22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  26 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  27 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  29 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  30 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  31 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  32 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  33 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  34 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  35 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  36 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
  37 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
  38 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  39 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  40 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  41 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  42 manjaro:latest                : Ok   gcc (GCC) 8.3.0, clang version 8.0.0 (tags/RELEASE_800/final)
  43 openmandriva:cooker           : Ok   gcc (GCC) 9.1.0 20190503 (OpenMandriva)
  44 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  45 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  46 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  47 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190520 [gcc-9-branch revision 271396], clang version 8.0.0 (tags/RELEASE_800/final 356365)
  48 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  49 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  50 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  51 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  52 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  53 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  59 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  60 ubuntu:18.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  
  arch/arm64/util/dwarf-regs.c: In function 'regs_query_register_offset':
  arch/arm64/util/dwarf-regs.c:26:43: error: dereferencing pointer to incomplete type 'struct user_pt_regs'
    (index * sizeof((struct user_pt_regs *)0)->regs[0])
                                             ^
  arch/arm64/util/dwarf-regs.c:91:11: note: in expansion of macro 'DWARFNUM2OFFSET'
      return DWARFNUM2OFFSET(roff->dwarfnum);
             ^~~~~~~~~~~~~~~
  mv: cannot stat '/tmp/build/perf/arch/arm64/util/.dwarf-regs.o.tmp': No such file or directory

  61 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  62 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  63 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  64 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  65 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  66 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  67 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  68 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  69 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  70 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  71 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  72 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  73 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  74 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  75 ubuntu:19.10                  : Ok   gcc (Ubuntu 8.3.0-14ubuntu1) 8.3.0, clang version 8.0.1-+rc1-1~exp1 (tags/RELEASE_801/rc1)
  $

  # uname -a
  Linux quaco 5.2.0-rc7 #2 SMP Mon Jul 1 23:05:41 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  06c642c0e9fc perf jevents: Use nonlocal include statements in pmu-events.c
  # perf version --build-options
  perf version 5.2.rc6.g06c642c0e9fc
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
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_static_O: make LDFLAGS=-static
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_install_prefix_O: make install prefix=/tmp/krava
              make_no_libelf_O: make NO_LIBELF=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                    make_doc_O: make doc
                   make_help_O: make help
                 make_perf_o_O: make perf.o
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                  make_debug_O: make DEBUG=1
                   make_pure_O: make
                make_install_O: make install
            make_install_bin_O: make install-bin
                make_no_newt_O: make NO_NEWT=1
                 make_cscope_O: make cscope
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
                   make_tags_O: make tags
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_util_map_o_O: make util/map.o
               make_no_slang_O: make NO_SLANG=1
              make_clean_all_O: make clean all
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
