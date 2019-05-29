Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B44C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CA4218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559136980;
	bh=Ej+fNyDfYSToG9P+XAm2fy7bwxu6IenzwwnqNQ84t08=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KM3MyhB0KUq7Lx3fy7q2u/jYgbPwZytE0uTOTndSfW1d2rB9+Gks9+6QCIGB9win6
	 SPh3SsV+wM8Snpa8U5VidI+ALsPuX2vTl7Y8xbpVtOo4dsSiGNZf2EPcSZva7GuxTK
	 NpURe83K2YuX7hhLE6UvX8/4YQ1Z+mDD+Rbru0f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfE2NgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2NgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:17 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4186B218A0;
        Wed, 29 May 2019 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559136976;
        bh=Ej+fNyDfYSToG9P+XAm2fy7bwxu6IenzwwnqNQ84t08=;
        h=From:To:Cc:Subject:Date:From;
        b=EBn5uCfI3i2OKKU8TVCEvwnNe49Ppn0J7B2iOtwZEK7NvvEU+ohVO8PvYLxjsFHMB
         crgRf0+h+xzobN2sO47AZ1G9yoVgdKmfXZeT+6yZDG2APk4fvYQbVevrfSOPxQRCeN
         /b4kG42JRYxtiRpL3c2JsTIhzPIWXvetMrD421Bo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes for 5.3
Date:   Wed, 29 May 2019 10:35:24 -0300
Message-Id: <20190529133605.21118-1-acme@kernel.org>
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

Test results at the end of this message, as usual, this time with the
versions for the clang compilers used accross the various containers, to
give a further view of the build test coverage for perf, libbpf,
libtraceevent, etc.

Test results:

The following changes since commit 849e96f30068d4f6f8352715e02a10533a46deba:

  Merge tag 'perf-urgent-for-mingo-5.2-20190528' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-05-28 23:16:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190529

for you to fetch changes up to 14f1cfd4f7b4794e2f9d2ae214bcf049654b0b5c:

  perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid (2019-05-28 18:37:45 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

BPF:

  Jiri Olsa:

  - Preserve eBPF maps when loading kcore.

  - Fix up DSO name padding in 'perf script --call-trace', as BPF DSO names are
    much larger than what we used to have there.

  - Add --show-bpf-events to 'perf script'.

perf trace:

  Arnaldo Carvalho de Melo:

  - Add string table generators and beautify arguments for the new fspick,
    fsmount, fsconfig, fsopen, move_mount and open_tree syscalls, as well
    as new values for arguments of clone and sync_file_range syscalls.

perf version:

  Arnaldo Carvalho de Melo:

  - Append 12 git SHA chars to the version string.

Namespaces:

  Namhyung Kim:

  - Add missing --namespaces option to 'perf top', to generate and process
    namespace events, just like present for 'perf record'.

Intel PT:

  Andrian Hunter:

  - Fix itrace defaults for 'perf script', not using the 'use_browser' variable
    to figure out what options are better for 'script' and 'report'

  - Allow root fixing up buildid cache permissions in the perf-with-kcore.sh
    script when sharing that cache with another user.

  - Improve sync_switch, a facility used to synchronize decoding of HW
    traces more closely with the point in the kerne where a context
    switch took place, by processing the PERF_RECORD_CONTEXT_SWITCH "in"
    metadata records too.

  - Make the exported-sql-viewer.py GUI also support pyside2, which
    upgrades from qt4 used in pyside to qt5. Use the argparser module
    for more easily addition of new command line args.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (11):
      perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
      perf intel-pt: Fix itrace defaults for perf script
      perf auxtrace: Fix itrace defaults for perf script
      perf intel-pt: Fix itrace defaults for perf script intel-pt documentation
      perf scripts python: exported-sql-viewer.py: Change python2 to python
      perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
      perf scripts python: exported-sql-viewer.py: Add support for pyside2
      perf scripts python: export-to-sqlite.py: Add support for pyside2
      perf scripts python: export-to-postgresql.py: Add support for pyside2
      perf intel-pt: Improve sync_switch by processing PERF_RECORD_SWITCH* in events
      perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid

Arnaldo Carvalho de Melo (17):
      perf augmented_raw_syscalls: Fix up comment
      perf beauty: Add generator for 'move_mount' flags argument
      perf trace: Beautify 'move_mount' arguments
      perf beauty: Add generator for fspick's 'flags' arg values
      perf trace: Beautify 'fspick' arguments
      perf beauty: Add generator for fsconfig's 'cmd' arg values
      perf trace: Beautify 'fsconfig' arguments
      perf beauty: Add generator for fsmount's 'attr_flags' arg values
      perf trace: Introduce syscall_arg__scnprintf_strarray_flags
      perf trace: Beautify 'fsmount' arguments
      perf trace beauty clone: Handle CLONE_PIDFD
      perf beauty: Add generator for sync_file_range's 'flags' arg values
      perf trace: Beautify 'sync_file_range' arguments
      perf version: Append 12 git SHA chars to the version string
      perf annotate TUI browser: Do not use member from variable within its own initialization
      perf python: Remove -fstack-protector-strong if clang doesn't have it
      perf top: Lower message level for failure on synthesizing events for pre-existing BPF programs

Donald Yandt (1):
      perf machine: Return NULL instead of null-terminating /proc/version array

Jiri Olsa (10):
      perf machine: Keep zero in pgoff BPF map
      perf tools: Preserve eBPF maps when loading kcore
      perf dso: Separate generic code in dso__data_file_size()
      perf dso: Separate generic code in dso_cache__read
      perf dso: Simplify dso_cache__read function
      perf dso: Add BPF DSO read and size hooks
      perf script: Pad DSO name for --call-trace
      perf tests: Add map_groups__merge_in test
      perf script: Add --show-bpf-events to show eBPF related events
      perf script: Remove superfluous BPF event titles

Namhyung Kim (2):
      perf top: Add --namespaces option
      perf tools: Remove const from thread read accessors

 tools/include/linux/kernel.h                      |   1 +
 tools/lib/vsprintf.c                              |  19 ++++
 tools/perf/Documentation/intel-pt.txt             |  10 +-
 tools/perf/Documentation/perf-script.txt          |   3 +
 tools/perf/Documentation/perf-top.txt             |   5 +
 tools/perf/Makefile.perf                          |  44 +++++++-
 tools/perf/builtin-script.c                       |  43 ++++++++
 tools/perf/builtin-top.c                          |   7 +-
 tools/perf/builtin-trace.c                        |  35 ++++++
 tools/perf/examples/bpf/augmented_raw_syscalls.c  |  15 ++-
 tools/perf/perf-with-kcore.sh                     |   5 -
 tools/perf/scripts/python/export-to-postgresql.py |  43 ++++++--
 tools/perf/scripts/python/export-to-sqlite.py     |  44 ++++++--
 tools/perf/scripts/python/exported-sql-viewer.py  |  51 ++++++---
 tools/perf/tests/Build                            |   1 +
 tools/perf/tests/builtin-test.c                   |   4 +
 tools/perf/tests/map_groups.c                     | 120 +++++++++++++++++++++
 tools/perf/tests/tests.h                          |   1 +
 tools/perf/trace/beauty/Build                     |   4 +
 tools/perf/trace/beauty/beauty.h                  |  15 +++
 tools/perf/trace/beauty/clone.c                   |   1 +
 tools/perf/trace/beauty/fsconfig.sh               |  17 +++
 tools/perf/trace/beauty/fsmount.c                 |  34 ++++++
 tools/perf/trace/beauty/fsmount.sh                |  22 ++++
 tools/perf/trace/beauty/fspick.c                  |  24 +++++
 tools/perf/trace/beauty/fspick.sh                 |  17 +++
 tools/perf/trace/beauty/move_mount.c              |  24 +++++
 tools/perf/trace/beauty/move_mount_flags.sh       |  17 +++
 tools/perf/trace/beauty/sync_file_range.c         |  31 ++++++
 tools/perf/trace/beauty/sync_file_range.sh        |  17 +++
 tools/perf/ui/browsers/annotate.c                 |   5 +-
 tools/perf/util/PERF-VERSION-GEN                  |   2 +-
 tools/perf/util/auxtrace.c                        |   3 +-
 tools/perf/util/dso.c                             | 125 +++++++++++++++-------
 tools/perf/util/event.c                           |   4 +-
 tools/perf/util/hist.c                            |   2 +-
 tools/perf/util/intel-pt.c                        |  47 +++++++-
 tools/perf/util/machine.c                         |   8 +-
 tools/perf/util/map.c                             |   6 ++
 tools/perf/util/map_groups.h                      |   2 +
 tools/perf/util/setup.py                          |   2 +
 tools/perf/util/symbol.c                          |  97 ++++++++++++++++-
 tools/perf/util/symbol_conf.h                     |   1 +
 tools/perf/util/thread.c                          |  12 +--
 tools/perf/util/thread.h                          |   4 +-
 45 files changed, 888 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/tests/map_groups.c
 create mode 100755 tools/perf/trace/beauty/fsconfig.sh
 create mode 100644 tools/perf/trace/beauty/fsmount.c
 create mode 100755 tools/perf/trace/beauty/fsmount.sh
 create mode 100644 tools/perf/trace/beauty/fspick.c
 create mode 100755 tools/perf/trace/beauty/fspick.sh
 create mode 100644 tools/perf/trace/beauty/move_mount.c
 create mode 100755 tools/perf/trace/beauty/move_mount_flags.sh
 create mode 100644 tools/perf/trace/beauty/sync_file_range.c
 create mode 100755 tools/perf/trace/beauty/sync_file_range.sh

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

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0-rc1.tar.xz
  $ dm
   1 alpine:3.4                   : Ok  gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                   : Ok  gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                   : Ok  gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                   : Ok  gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                   : Ok  gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                   : Ok  gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:edge                  : Ok  gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 7.0.1 (tags/RELEASE_701/final) (based on LLVM 7.0.1)
   8 amazonlinux:1                : Ok  gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
   9 amazonlinux:2                : Ok  gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  10 android-ndk:r12b-arm         : Ok  arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm         : Ok  arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                     : Ok  gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                     : Ok  gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                     : Ok  gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest            : Ok  gcc (Clear Linux OS for Intel Architecture) 9.0.1 20190501 (prerelease) gcc-8-branch@270761, clang version 8.0.0 (tags/RELEASE_800/final)
  16 debian:8                     : Ok  gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  17 debian:9                     : Ok  gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  18 debian:experimental          : Ok  gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  19 debian:experimental-x-arm64  : Ok  aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  20 debian:experimental-x-mips   : Ok  mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  21 debian:experimental-x-mips64 : Ok  mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
  22 debian:experimental-x-mipsel : Ok  mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  23 fedora:20                    : Ok  gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:22                    : Ok  gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                    : Ok  gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:24                    : Ok  gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27 fedora:24-x-ARC-uClibc       : Ok  arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28 fedora:25                    : Ok  gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  29 fedora:26                    : Ok  gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  30 fedora:27                    : Ok  gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  31 fedora:28                    : Ok  gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  32 fedora:29                    : Ok  gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  33 fedora:30                    : Ok  gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  34 fedora:30-x-ARC-glibc        : Ok  arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  35 fedora:30-x-ARC-uClibc       : Ok  arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  36 fedora:rawhide               : Ok  gcc (GCC) 9.0.1 20190418 (Red Hat 9.0.1-0.14), clang version 8.0.0 (Fedora 8.0.0-2.fc31)
  37 gentoo-stage3-amd64:latest   : Ok  gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  38 mageia:5                     : Ok  gcc (GCC) 4.9.2
  39 mageia:6                     : Ok  gcc (Mageia 5.5.0-1.mga6) 5.5.0
  40 opensuse:15.0                : Ok  gcc (SUSE Linux) 7.4.0
  41 opensuse:15.1                : Ok  gcc (SUSE Linux) 7.4.0
  42 opensuse:42.3                : Ok  gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  43 opensuse:tumbleweed          : Ok  gcc (SUSE Linux) 9.1.1 20190520 [gcc-9-branch revision 271396], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  44 oraclelinux:6                : Ok  gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  45 oraclelinux:7                : Ok  gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  46 ubuntu:12.04.5               : Ok  gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  47 ubuntu:14.04.4               : Ok  gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  48 ubuntu:16.04                 : Ok  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  49 ubuntu:16.04-x-arm           : Ok  arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-arm64         : Ok  aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc       : Ok  powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64     : Ok  powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-powerpc64el   : Ok  powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-s390          : Ok  s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:17.10                 : Ok  gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0, clang version 4.0.1-6 (tags/RELEASE_401/final)
  56 ubuntu:18.04                 : Ok  gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  57 ubuntu:18.04-x-arm           : Ok  arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
  58 ubuntu:18.04-x-arm64         : Ok  aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
  59 ubuntu:18.04-x-m68k          : Ok  m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  60 ubuntu:18.04-x-powerpc       : Ok  powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  61 ubuntu:18.04-x-powerpc64     : Ok  powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  62 ubuntu:18.04-x-powerpc64el   : Ok  powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  63 ubuntu:18.04-x-riscv64       : Ok  riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  64 ubuntu:18.04-x-s390          : Ok  s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  65 ubuntu:18.04-x-sh4           : Ok  sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  66 ubuntu:18.04-x-sparc64       : Ok  sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  67 ubuntu:18.10                 : Ok  gcc (Ubuntu 8.3.0-6ubuntu1~18.10) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  68 ubuntu:19.04                 : Ok  gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  69 ubuntu:19.04-x-alpha         : Ok  alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  70 ubuntu:19.04-x-arm64         : Ok  aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  71 ubuntu:19.04-x-hppa          : Ok  hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  $

  # uname -a
  Linux quaco 5.2.0-rc1+ #1 SMP Thu May 23 10:37:55 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  14f1cfd4f7b4 perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
  # perf version --build-options
  perf version 5.2.rc1.gdb3a270ffd55
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
  59: map_groups__merge_in                                  : Ok
  60: x86 rdpmc                                             : Ok
  61: Convert perf time to TSC                              : Ok
  62: DWARF unwind                                          : Ok
  63: x86 instruction decoder - new instructions            : Ok
  64: x86 bp modify                                         : Ok
  65: probe libc's inet_pton & backtrace it with ping       : Ok
  66: Use vfs_getname probe to get syscall args filenames   : Ok
  67: Add vfs_getname probe to get syscall args filenames   : Ok
  68: Check open filename arg using perf trace + vfs_getname: Ok
  69: Zstd perf.data compression/decompression              : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_no_libperl_O: make NO_LIBPERL=1
                 make_cscope_O: make cscope
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_help_O: make help
                   make_pure_O: make
           make_no_libbionic_O: make NO_LIBBIONIC=1
               make_no_slang_O: make NO_SLANG=1
                 make_static_O: make LDFLAGS=-static
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                    make_doc_O: make doc
              make_no_libelf_O: make NO_LIBELF=1
                   make_tags_O: make tags
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_no_demangle_O: make NO_DEMANGLE=1
                make_install_O: make install
            make_install_bin_O: make install-bin
                make_no_newt_O: make NO_NEWT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
                  make_debug_O: make DEBUG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                 make_perf_o_O: make perf.o
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_gtk2_O: make NO_GTK2=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
