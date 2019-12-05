Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB63C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5C24648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575574357;
	bh=ZIz/zJNPkEoFGb38xks3BvXqc2l1VGjwfte6YsFEU/A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Z2zP6bUadD8Rv8jQrSaUBKEyo+t+IRk3n45pgqayclNKP6gJxRJDi6ZbxIs8NXEe5
	 KofbQrnHMgznrFK/Ea0Dr61Wh9G6MZ7afnoCkrFYSkAB9OydO9gVdrmMFZpkVzbSq8
	 YSzKvCk6e17O+wnz0zOX5Jd9klifBfcVjUQnMB9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfLETcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLETcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:32:35 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655EE224F8;
        Thu,  5 Dec 2019 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574353;
        bh=ZIz/zJNPkEoFGb38xks3BvXqc2l1VGjwfte6YsFEU/A=;
        h=From:To:Cc:Subject:Date:From;
        b=1vH6oEwIgo2K++LCMH3lxCFBu9/4DvCWv4ce6cWitM7OtWPGK9Vd4nj3Oxpd3vozX
         TOrW43vrLtQ/XsmUjQ7bYJSmUyh7IWQ44TFDcm9179vCa8CqjkAxcWkbysKz3wX1zr
         IK/57J1xESGa0m6SLSUTK3g724ApByGN7hjkPL4E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/6] perf/urgent fixes
Date:   Thu,  5 Dec 2019 16:32:18 -0300
Message-Id: <20191205193224.24629-1-acme@kernel.org>
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

The following changes since commit 9f58c93efdffc2cba91fdcee010b3e5e8860334d:

  Merge tag 'perf-core-for-mingo-5.5-20191203' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-12-04 08:49:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191205

for you to fetch changes up to fd9bee5e24141d00e23b66d1b51bc759efa7e3fe:

  tools headers UAPI: Update tools's copy of drm.h headers (2019-12-04 16:22:38 -0300)

----------------------------------------------------------------
perf inject:

  Adrian Hunter:

  - Fix processing of ID index for injected instruction tracing

perf report:

  Ravi Bangoria:

  - Replace pr_err() with ui__error(), so that we can see the output
    in the TUI mode instead of showing and immediately restoring the
    screen to the state before perf was started.

  - Don't start --mem-mode/--branch-mode mode if required samples are not
    available.

tools headers UAPI:

  Arnaldo Carvalho de Melo:

  - Sync drm/i915_drm.h with the kernel sources

  - Update tools's copy of drm.h headers.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf inject: Fix processing of ID index for injected instruction tracing

Arnaldo Carvalho de Melo (2):
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers

Ravi Bangoria (3):
      perf report/top TUI: Replace pr_err() with ui__error()
      perf report: Make -F more strict like -s
      perf report: Bail out --mem-mode if mem info is not available

 tools/include/uapi/drm/drm.h      |   3 +-
 tools/include/uapi/drm/i915_drm.h | 128 +++++++++++++++++++++++++++++++++++++-
 tools/perf/builtin-inject.c       |  13 +---
 tools/perf/builtin-report.c       |   8 +++
 tools/perf/util/sort.c            |  16 +++--
 5 files changed, 147 insertions(+), 21 deletions(-)

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

With the update of linux/linkage.h to move from ENTRY()/ENDPROC() to
SYM_FUNC_START()/etc some of the older containers can't be used with clang,
as the minimum version for the constructs used in the new linkage.h is 3.5,
older versions (3.4, 3.4.2, etc) end up with:

  bench/../../arch/x86/lib/memcpy_64.S:44:14: error: unexpected token in '.type' directive
  .type MEMCPY STT_FUNC ; .size MEMCPY, .-MEMCPY
               ^

Finally the build-tests and container tests were performed with the following
two fixes (different sha, same contents), that are not in this patch series,
will go thru the bpf/net trees.

The 'perf test' was performed with what is in this series tho.

  $ git log --oneline -2
  e1bc15a8e7d1 (HEAD -> perf/core) libbpf: Use PRIu64 for sym->st_value to fix build on 32-bit arches
  0d0f9df96c5a libbpf: Fix up generation of bpf_helper_defs.h
  $ 

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
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  16 centos:8                      : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3), clang version 7.0.1 (tags/RELEASE_701/final)
  17 clearlinux:latest             : FAIL gcc (Clear Linux OS for Intel Architecture) 9.2.1 20191125 gcc-9-branch@278689, clang version 9.0.0 (tags/RELEASE_900/final)
  18 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  19 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  20 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  21 debian:experimental           : Ok   gcc (Debian 9.2.1-19) 9.2.1 20191109, clang version 8.0.1-4 (tags/RELEASE_801/final)
  22 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  23 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  24 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.2.1-8) 9.2.1 20190909
  25 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
  26 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
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
  57 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
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

  # uname -a
  Linux quaco 5.3.14-200.fc30.x86_64 #1 SMP Mon Dec 2 15:57:50 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  fd9bee5e2414 tools headers UAPI: Update tools's copy of drm.h headers
  # perf version --build-options
  perf version 5.4.gfd9bee5e2414
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
  52: Merge cpu map                                         : Ok
  53: Probe SDT events                                      : Ok
  54: is_printable_array                                    : Ok
  55: Print bitmap                                          : Ok
  56: perf hooks                                            : Ok
  57: builtin clang support                                 : Skip (not compiled in)
  58: unit_number__scnprintf                                : Ok
  59: mem2node                                              : Ok
  60: time utils                                            : Ok
  61: Test jit_write_elf                                    : Ok
  62: maps__merge_in                                        : Ok
  63: x86 rdpmc                                             : Ok
  64: Convert perf time to TSC                              : Ok
  65: DWARF unwind                                          : Ok
  66: x86 instruction decoder - new instructions            : Ok
  67: Intel PT packet decoder                               : Ok
  68: x86 bp modify                                         : Ok
  69: probe libc's inet_pton & backtrace it with ping       : Ok
  70: Use vfs_getname probe to get syscall args filenames   : Ok
  71: Add vfs_getname probe to get syscall args filenames   : Ok
  72: Check open filename arg using perf trace + vfs_getname: Ok
  73: Zstd perf.data compression/decompression              : Ok

  $ make -C tools/perf build-test 
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_tags_O: make tags
              make_clean_all_O: make clean all
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_no_gtk2_O: make NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                 make_cscope_O: make cscope
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_util_map_o_O: make util/map.o
              make_no_libelf_O: make NO_LIBELF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                  make_debug_O: make DEBUG=1
               make_no_slang_O: make NO_SLANG=1
                make_install_O: make install
                   make_pure_O: make
         make_install_prefix_O: make install prefix=/tmp/krava
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                    make_doc_O: make doc
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
                 make_perf_o_O: make perf.o
            make_no_demangle_O: make NO_DEMANGLE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
