Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD8C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90B2217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869807;
	bh=elytDZwVPGzGc5JlJkLXrs7VwHSLVwgNeRNgHtlckmw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g0jM0mr9XekbT0pdGZZe5UmNBuY3iVBZ841shHW2666bzmF0CTPMkqETA1FfwajCU
	 tgddUlcbQyvOBECICF3P0sA267BRZEow9aOorylHK8KI3jJ8jdtqHWfdfzvBpBCk7A
	 y7Tzq0bMjjvA+mhm41jubqQMxtBqFis3nMA/aqss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfH0Bgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfH0Bgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2E420850;
        Tue, 27 Aug 2019 01:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869803;
        bh=elytDZwVPGzGc5JlJkLXrs7VwHSLVwgNeRNgHtlckmw=;
        h=From:To:Cc:Subject:Date:From;
        b=EN0TTH/MB6P4mu8XHJtGjL7JuCUZqrRtxX+3kU6ljJGVte+muLHAWjdH4lqpA6tll
         mtBa48OwiabGgqmnfpXpYJ/J2nILXLVMs0DSKgtV6z0VD2SvjWLL3CUtM7iac7Bza6
         czX9arJDuZESjYzxPfIM8vmVORJXSFMMj79Jnbeg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Benjamin Peterson <benjamin@python.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        James Clark <james.clark@arm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon, 26 Aug 2019 22:36:01 -0300
Message-Id: <20190827013634.3173-1-acme@kernel.org>
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

The following changes since commit 39152ee51b77851689f9b23fde6f610d13566c39:

  perf/x86/intel/pt: Get rid of reverse lookup table for ToPA (2019-08-26 12:00:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190826

for you to fetch changes up to 74a1e863eb73dcc9f069b671dfb40650f3832116:

  perf evsel: Rename perf_missing_features::bpf_event to ::bpf (2019-08-26 19:39:11 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf report:

  Andi Kleen:

  - Make --ns time sort key output column wide enough for nanoseconds.

perf script:

  Gustavo A. R. Silva:

  - Fix memory leaks in list_scripts()

perf tests:

  James Clark:

  - Fixes hang in zstd compression test by changing the source of random data.

perf trace:

  Arnaldo Carvalho de Melo:

  - augmented_raw_syscalls.c BPF helper improvements.

  Benjamin Peterson:

  - Fix off-by-one error in ioctl cmd->string table.

libperf:

  Jiri Olsa:

  - Move most PERF_RECORD_ structs to perf/event.h.

headers:

  Arnaldo Carvalho de Melo:

  - Move cacheline related routines to separate source files.

  - Move record_opts and other record declarations to separate files.

  - Explicitly add some more needed headers here and there.

  Souptick Joarder:

  - Remove some duplicate include directives.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (2):
      perf report: Use timestamp__scnprintf_nsec() for time sort key
      perf report: Fix --ns time sort key output

Arnaldo Carvalho de Melo (15):
      perf cpumap: No need to include perf.h, ditch it
      perf stat: Remove needless headers from stat.h
      perf record: Move record_opts and other record decls out of perf.h
      perf cacheline: Move cacheline related routines to separate files
      perf srcline: Add missing srcline.h header to files needing its defs
      perf sort: Remove needless headers from sort.h, provide fwd struct decls
      perf augmented_raw_syscalls: Rename augmented_filename to augmented_arg
      perf augmented_raw_syscalls: Postpone tmp map lookup to after pid_filter
      perf augmented_raw_syscalls: Introduce helper to get the scratch space
      perf augmented_raw_syscalls: Reduce perf_event_output() boilerplate
      libperf: Rename the PERF_RECORD_ structs to have a "perf" suffix
      perf tools: Rename perf_event::ksymbol_event to perf_event::ksymbol
      perf tools: Rename perf_event::bpf_event to perf_event::bpf
      perf tool: Rename perf_tool::bpf_event to bpf
      perf evsel: Rename perf_missing_features::bpf_event to ::bpf

Benjamin Peterson (1):
      perf trace beauty ioctl: Fix off-by-one error in cmd->string table

Gustavo A. R. Silva (1):
      perf script: Fix memory leaks in list_scripts()

James Clark (1):
      perf tests: Fixes hang in zstd compression test by changing the source of random data

Jiri Olsa (12):
      libperf: Add PERF_RECORD_MMAP 'struct mmap_event' to perf/event.h
      libperf: Add PERF_RECORD_MMAP2 'struct mmap2_event' to perf/event.h
      libperf: Add PERF_RECORD_COMM 'struct comm_event' to perf/event.h
      libperf: Add PERF_RECORD_NAMESPACES 'struct namespaces_event' to perf/event.h
      libperf: Add PERF_RECORD_FORK 'struct fork_event' to perf/event.h
      libperf: Add PERF_RECORD_LOST 'struct lost_event' to perf/event.h
      libperf: Add PERF_RECORD_LOST_SAMPLES 'struct lost_samples_event' to perf/event.h
      libperf: Add PERF_RECORD_READ 'struct read_event' to perf/event.h
      libperf: Add PERF_RECORD_THROTTLE 'struct throttle_event' to perf/event.h
      libperf: Add PERF_RECORD_KSYMBOL 'struct ksymbol_event' to perf/event.h
      libperf: Add PERF_RECORD_BPF_EVENT 'struct bpf_event' to perf/event.h
      libperf: Add PERF_RECORD_SAMPLE 'struct sample_event' to perf/event.h

Souptick Joarder (1):
      perf tools: Remove duplicate headers

 tools/perf/arch/arm/util/cs-etm.c                 |   2 +-
 tools/perf/arch/arm64/util/arm-spe.c              |   1 +
 tools/perf/arch/s390/util/auxtrace.c              |   1 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c      |   2 +
 tools/perf/arch/x86/util/intel-bts.c              |   1 +
 tools/perf/arch/x86/util/intel-pt.c               |   3 +-
 tools/perf/builtin-c2c.c                          |   1 +
 tools/perf/builtin-diff.c                         |   2 +
 tools/perf/builtin-record.c                       |   4 +-
 tools/perf/builtin-report.c                       |   1 +
 tools/perf/builtin-sched.c                        |   2 +-
 tools/perf/builtin-script.c                       |   7 +-
 tools/perf/builtin-stat.c                         |   2 +-
 tools/perf/builtin-trace.c                        |   1 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c  | 100 +++++++--------
 tools/perf/lib/include/perf/event.h               | 112 ++++++++++++++++
 tools/perf/perf.h                                 |  62 ---------
 tools/perf/tests/backward-ring-buffer.c           |   2 +-
 tools/perf/tests/bpf.c                            |   1 +
 tools/perf/tests/code-reading.c                   |   1 +
 tools/perf/tests/keep-tracking.c                  |   1 +
 tools/perf/tests/openat-syscall-tp-fields.c       |   3 +-
 tools/perf/tests/parse-no-sample-id-all.c         |   4 +-
 tools/perf/tests/perf-record.c                    |   2 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh |   2 +-
 tools/perf/tests/switch-tracking.c                |   1 +
 tools/perf/tests/task-exit.c                      |   1 +
 tools/perf/trace/beauty/ioctl.c                   |   2 +-
 tools/perf/ui/browsers/res_sample.c               |   2 +
 tools/perf/ui/browsers/scripts.c                  |   8 +-
 tools/perf/ui/stdio/hist.c                        |   1 +
 tools/perf/util/Build                             |   1 +
 tools/perf/util/annotate.c                        |   2 +
 tools/perf/util/auxtrace.c                        |   2 +-
 tools/perf/util/bpf-event.c                       |  36 +++---
 tools/perf/util/bpf-event.h                       |  10 +-
 tools/perf/util/cacheline.c                       |  26 ++++
 tools/perf/util/cacheline.h                       |  21 +++
 tools/perf/util/callchain.c                       |   1 +
 tools/perf/util/cpumap.h                          |   2 -
 tools/perf/util/data.c                            |   1 -
 tools/perf/util/event.c                           |  35 +++--
 tools/perf/util/event.h                           | 149 +++++-----------------
 tools/perf/util/evlist.c                          |   2 +-
 tools/perf/util/evsel.c                           |  22 ++--
 tools/perf/util/evsel.h                           |   4 +-
 tools/perf/util/get_current_dir_name.c            |   1 -
 tools/perf/util/hist.c                            |   5 +-
 tools/perf/util/intel-bts.c                       |   2 +-
 tools/perf/util/kvm-stat.h                        |   2 +-
 tools/perf/util/machine.c                         |  25 ++--
 tools/perf/util/machine.h                         |   1 +
 tools/perf/util/namespaces.c                      |   2 +-
 tools/perf/util/namespaces.h                      |   4 +-
 tools/perf/util/python.c                          |  58 ++++-----
 tools/perf/util/record.c                          |   1 +
 tools/perf/util/record.h                          |  74 +++++++++++
 tools/perf/util/session.c                         |  16 +--
 tools/perf/util/sort.c                            |  12 +-
 tools/perf/util/sort.h                            |  27 +---
 tools/perf/util/stat-display.c                    |   1 -
 tools/perf/util/stat.c                            |   1 +
 tools/perf/util/stat.h                            |   7 +-
 tools/perf/util/thread.c                          |   4 +-
 tools/perf/util/thread.h                          |   4 +-
 tools/perf/util/tool.h                            |   2 +-
 tools/perf/util/top.h                             |   1 +
 tools/perf/util/util.c                            |  20 ---
 tools/perf/util/util.h                            |   1 -
 69 files changed, 493 insertions(+), 427 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/event.h
 create mode 100644 tools/perf/util/cacheline.c
 create mode 100644 tools/perf/util/cacheline.h
 create mode 100644 tools/perf/util/record.h

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
    15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
    16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20190816 gcc-9-branch@274554, clang version 8.0.0 (tags/RELEASE_800/final)
    17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
    18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
    19 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
    20 debian:experimental           : Ok   gcc (Debian 8.3.0-19) 8.3.0, clang version 7.0.1-9 (tags/RELEASE_701/final)
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
    46 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
    47 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
    48 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190805 [gcc-9-branch revision 274114], clang version 8.0.1 (tags/RELEASE_801/final 366581)
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
    78 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.1.0-9ubuntu2) 9.1.0, clang version 8.0.1-+rc4-1 (tags/RELEASE_801/rc4)
  #

  # uname -a
  Linux quaco 5.2.6-200.fc30.x86_64 #1 SMP Mon Aug 5 13:20:47 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  74a1e863eb73 perf evsel: Rename perf_missing_features::bpf_event to ::bpf
  # perf version --build-options
  perf version 5.3.rc6.g74a1e863eb73
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
                 make_perf_o_O: make perf.o
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_util_map_o_O: make util/map.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
                make_no_gtk2_O: make NO_GTK2=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
                   make_tags_O: make tags
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
                    make_doc_O: make doc
                 make_cscope_O: make cscope
                   make_pure_O: make
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
                   make_help_O: make help
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_auxtrace_O: make NO_AUXTRACE=1
               make_no_slang_O: make NO_SLANG=1
              make_clean_all_O: make clean all
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                  make_debug_O: make DEBUG=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_newt_O: make NO_NEWT=1
                 make_static_O: make LDFLAGS=-static
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
           make_no_libunwind_O: make NO_LIBUNWIND=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
