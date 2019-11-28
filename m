Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBCCC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6DB21787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948438;
	bh=3PmSzWW66LEkFYAegAXqjeLom1zFx/lz6OluADX0A28=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kIvDbCIs5y1Bz/Udf3qzykC2p8gcbPJpL1+IFa+yEPENjlEwK3qTy0iEUSQT/SCdh
	 9qy/9OZM6HbvEQnXATGkx5oFVLQmGQXCXlA25WGaFYWJY/27Twh0e1iUbnfRXMqJf1
	 RXAaDB8ZlTWFzqNIi6Y4bzcxzoqnMziJoqy4bR1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1Nkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Nkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:36 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C93216F4;
        Thu, 28 Nov 2019 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948435;
        bh=3PmSzWW66LEkFYAegAXqjeLom1zFx/lz6OluADX0A28=;
        h=From:To:Cc:Subject:Date:From;
        b=hjVRoAkIvSFZFip0NFwG5p5WVZq9YPdtiaAmFIdu4F8sPXASFAIYvxcAtdm0wJ58x
         Wi5+IVRAhph6mtsj2QNowTf0Fn5GkmZx3h9+nI6OiZjnVndTyJiwkcwpc6X1Ljx2UO
         a+4BKrUIrj580iM3bcsy3cOoSpbxDLeT+54YtQK8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Thu, 28 Nov 2019 10:40:05 -0300
Message-Id: <20191128134027.23726-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling, this has a merge with mainline to pick
bpf stuff, and the build-test and container build tests were performed
with two extra patches I cooked to fix libbpf issuers in some odd 32-bit
arches and on generation of some bpf helpers headers that will hit
mainline via the bpf/net trees.

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 2ea352d5960ad469f5712cf3e293db97beac4e01:

  Merge remote-tracking branch 'torvalds/master' into perf/core (2019-11-26 11:06:19 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191128

for you to fetch changes up to 5172672da02e483d9b3c4d814c3482d0c8ffb1a6:

  perf script: Fix invalid LBR/binary mismatch error (2019-11-28 08:08:38 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf script:

  Adrian Hunter:

  - Fix brstackinsn for AUXTRACE.

  - Fix invalid LBR/binary mismatch error.

perf diff:

  Arnaldo Carvalho de Melo:

  - Use llabs() with 64-bit values, fixing the build in some 32-bit
    architectures.

perf pmu:

  Andi Kleen:

  - Use file system cache to optimize sysfs access.

x86:

  Adrian Hunter:

  - Add some more Intel instructions to the opcode map and to the perf
    test entry:

      gf2p8affineinvqb, gf2p8affineqb, gf2p8mulb, v4fmaddps,
      v4fmaddss, v4fnmaddps, v4fnmaddss, vaesdec, vaesdeclast, vaesenc,
      vaesenclast, vcvtne2ps2bf16, vcvtneps2bf16, vdpbf16ps,
      vgf2p8affineinvqb, vgf2p8affineqb, vgf2p8mulb, vp2intersectd,
      vp2intersectq, vp4dpwssd, vp4dpwssds, vpclmulqdq, vpcompressb,
      vpcompressw, vpdpbusd, vpdpbusds, vpdpwssd, vpdpwssds, vpexpandb,
      vpexpandw, vpopcntb, vpopcntd, vpopcntq, vpopcntw, vpshldd, vpshldq,
      vpshldvd, vpshldvq, vpshldvw, vpshldw, vpshrdd, vpshrdq, vpshrdvd,
      vpshrdvq, vpshrdvw, vpshrdw, vpshufbitqmb.

perf affinity:

  Andi Kleen:

  - Add infrastructure to save/restore affinity

perf maps:

  Arnaldo Carvalho de Melo:

  - Merge 'struct maps' with 'struct map_groups', as there is a
    1x1 relationship, simplifying code overal.

perf build:

  Jiri Olsa:

  - Allow to link with libbpf dynamicaly.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (4):
      x86/insn: Add some more Intel instructions to the opcode map
      x86/insn: perf tools: Add some more instructions to the new instructions test
      perf script: Fix brstackinsn for AUXTRACE
      perf script: Fix invalid LBR/binary mismatch error

Andi Kleen (2):
      perf pmu: Use file system cache to optimize sysfs access
      perf affinity: Add infrastructure to save/restore affinity

Arnaldo Carvalho de Melo (15):
      perf script: Move map__fprintf_srccode() to near its only user
      perf map: Ditch leftover map__reloc_vmlinux() prototype
      perf map: Remove needless struct forward declarations
      perf map: Remove unused functions
      perf maps: Merge 'struct maps' with 'struct map_groups'
      perf thread: Rename thread->mg to thread->maps
      perf addr_location: Rename al->mg to al->maps
      perf map_symbol: Rename ms->mg to ms->maps
      perf maps: Rename 'mg' variables to 'maps'
      perf maps: Rename map_groups.h to maps.h
      perf tests: Rename thread-mg-share to thread-maps-share
      perf tests: Rename tests/map_groups.c to tests/maps.c
      perf diff: Use llabs() with 64-bit values
      perf diff: Use llabs() with 64-bit values
      perf regs: Make perf_reg_name() return "unknown" instead of NULL

Jiri Olsa (1):
      perf tools: Allow to link with libbpf dynamicaly

 arch/x86/lib/x86-opcode-map.txt                    |  44 +-
 tools/arch/x86/lib/x86-opcode-map.txt              |  44 +-
 tools/build/Makefile.feature                       |   3 +-
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-libbpf.c                  |   7 +
 tools/perf/Makefile.config                         |  10 +
 tools/perf/Makefile.perf                           |   6 +-
 tools/perf/arch/arm/tests/dwarf-unwind.c           |   4 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |   4 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |   4 +-
 tools/perf/arch/s390/annotate/instructions.c       |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |   4 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        | 366 ++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        | 484 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       | 655 +++++++++++++++++++++
 tools/perf/arch/x86/util/event.c                   |   5 +-
 tools/perf/builtin-diff.c                          |   6 +-
 tools/perf/builtin-report.c                        |   7 +-
 tools/perf/builtin-script.c                        |  46 +-
 tools/perf/tests/Build                             |   4 +-
 tools/perf/tests/builtin-test.c                    |   8 +-
 tools/perf/tests/code-reading.c                    |   2 +-
 tools/perf/tests/{map_groups.c => maps.c}          |  26 +-
 tools/perf/tests/tests.h                           |   4 +-
 .../{thread-mg-share.c => thread-maps-share.c}     |  36 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   9 +-
 tools/perf/ui/browsers/annotate.c                  |   2 +-
 tools/perf/ui/stdio/hist.c                         |   4 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/affinity.c                         |  73 +++
 tools/perf/util/affinity.h                         |  17 +
 tools/perf/util/annotate.c                         |   8 +-
 tools/perf/util/bpf-event.c                        |   4 +-
 tools/perf/util/callchain.c                        |   8 +-
 tools/perf/util/cs-etm.c                           |   2 +-
 tools/perf/util/db-export.c                        |  12 +-
 tools/perf/util/event.c                            |  14 +-
 tools/perf/util/fncache.c                          |  63 ++
 tools/perf/util/fncache.h                          |   7 +
 tools/perf/util/hist.c                             |   8 +-
 tools/perf/util/intel-pt.c                         |   2 +-
 tools/perf/util/machine.c                          |  80 ++-
 tools/perf/util/machine.h                          |  10 +-
 tools/perf/util/map.c                              | 223 ++-----
 tools/perf/util/map.h                              |  14 +-
 tools/perf/util/map_groups.h                       | 106 ----
 tools/perf/util/map_symbol.h                       |   4 +-
 tools/perf/util/maps.h                             |  87 +++
 tools/perf/util/perf_regs.h                        |   2 +-
 tools/perf/util/pmu.c                              |  34 +-
 tools/perf/util/probe-event.c                      |   4 +-
 tools/perf/util/python-ext-sources                 |   1 +
 .../util/scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/srccode.c                          |   9 +-
 tools/perf/util/symbol-elf.c                       |  16 +-
 tools/perf/util/symbol.c                           |  91 ++-
 tools/perf/util/symbol.h                           |   6 +-
 tools/perf/util/synthetic-events.c                 |   2 +-
 tools/perf/util/thread-stack.c                     |   4 +-
 tools/perf/util/thread.c                           |  38 +-
 tools/perf/util/thread.h                           |   4 +-
 tools/perf/util/unwind-libdw.c                     |   4 +-
 tools/perf/util/unwind-libunwind-local.c           |  22 +-
 tools/perf/util/unwind-libunwind.c                 |  36 +-
 tools/perf/util/unwind.h                           |  27 +-
 tools/perf/util/vdso.c                             |   2 +-
 66 files changed, 2230 insertions(+), 618 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf.c
 rename tools/perf/tests/{map_groups.c => maps.c} (83%)
 rename tools/perf/tests/{thread-mg-share.c => thread-maps-share.c} (64%)
 create mode 100644 tools/perf/util/affinity.c
 create mode 100644 tools/perf/util/affinity.h
 create mode 100644 tools/perf/util/fncache.c
 create mode 100644 tools/perf/util/fncache.h
 delete mode 100644 tools/perf/util/map_groups.h
 create mode 100644 tools/perf/util/maps.h

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

OpenMandriva Cooker works well with gcc, uncovers a bug where we have to
get compiler-clang.h from the kernel sources, will be fixed soon.

Finally the build-tests and container tests were performed with the following
two fixes, that are not in this patch series, will go thru the bpf/net trees:

  $ git log --oneline -2
  e1bc15a8e7d1 (HEAD -> perf/core) libbpf: Use PRIu64 for sym->st_value to fix build on 32-bit arches
  0d0f9df96c5a libbpf: Fix up generation of bpf_helper_defs.h
  $ 

The 'perf test' was performed with what is in this series tho.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.4.0.tar.xz
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
  17 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20191121 gcc-9-branch@278551, clang version 9.0.0 (tags/RELEASE_900/final)
  18 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  19 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  20 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  21 debian:experimental           : Ok   gcc (Debian 9.2.1-19) 9.2.1 20191109, clang version 8.0.1-4 (tags/RELEASE_801/final)
  22 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  23 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  24 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.2.1-8) 9.2.1 20190909
  25 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
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
  42 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  43 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  44 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  45 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  46 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  47 openmandriva:cooker           : Ok   gcc (GCC) 9.2.1 20191123 (OpenMandriva)
  48 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  49 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  50 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  51 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  52 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190903 [gcc-9-branch revision 275330], clang version 9.0.0 (tags/RELEASE_900/final 372316)
  53 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  54 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
  55 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  56 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  57 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  58 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
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
  Linux quaco 5.4.0+ #1 SMP Wed Nov 27 12:05:27 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  5172672da02e perf script: Fix invalid LBR/binary mismatch error
  # perf version --build-options
  perf version 5.4.g5172672da02e
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
  31: Share thread maps                                     : Ok
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
  60: maps__merge_in                                        : Ok
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
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_clean_all_O: make clean all
                   make_pure_O: make
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_no_demangle_O: make NO_DEMANGLE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_help_O: make help
                    make_doc_O: make doc
           make_no_libbionic_O: make NO_LIBBIONIC=1
  - /home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC: make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  LDFLAGS='-static' feature-dump
  make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC LDFLAGS='-static' feature-dump
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_newt_O: make NO_NEWT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
                  make_debug_O: make DEBUG=1
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_cscope_O: make cscope
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_install_O: make install
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libunwind_O: make NO_LIBUNWIND=1
               make_no_slang_O: make NO_SLANG=1
                 make_perf_o_O: make perf.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_tags_O: make tags
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
