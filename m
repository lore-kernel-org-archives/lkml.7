Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274CAC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AE9216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697103;
	bh=H+L/g6XmqPUPK0cG53otugu7FHpkP2eloSPkbaBdCYE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RMfqWlBMEuccNQ3S6J0t615d22OBvMnZHBeNu02gSv3Lzy3e2TMXPTNBR11vd+0V3
	 Hp6kwGgKF6d2zwo8Iayv0A3uWplK3v0RaiXWT1LBQutCI7txxojOj/axvqsGjLuupL
	 xDnLecXrJfOp6tWk6JzlM46oYG3yYlF/bHNpa9Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfGISbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfGISbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:31:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418F220665;
        Tue,  9 Jul 2019 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697097;
        bh=H+L/g6XmqPUPK0cG53otugu7FHpkP2eloSPkbaBdCYE=;
        h=From:To:Cc:Subject:Date:From;
        b=GDCBGvAiZTH5Q3HXIB1/2bTCaAxpJXsXEANm46Vmof99KygCV510XzBxTLAH3mNoI
         Sc/qU+ifMMBEj2wpZgaRP+P6rmX45GQCecCJUQlIFkCihrzL70dKrhNtagEiDJU2ix
         JrO6LrBZWGvZlLVolGXM3vCJgw26d/ucDDUHeR5g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Luke Mujica <lukemujica@google.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Tue,  9 Jul 2019 15:31:01 -0300
Message-Id: <20190709183126.30257-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
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

The following changes since commit d1d59b817939821bee149e870ce7723f61ffb512:

  Merge tag 'perf-urgent-for-mingo-5.3-20190708-2' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-07-09 13:22:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190709

for you to fetch changes up to 323fd749821daab0f327ec86d707c4542963cdb0:

  perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool (2019-07-09 10:13:28 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

Intel PT:

  Adrian Hunter:

  - Fix DROP VIEW power_events_view in the postgresql and sqlite export-db
    python scripts.

perf script:

  Song Liu:

  - Assume native_arch for pipe mode, fixing a segfault.

perf inject:

  Arnaldo Carvalho de Melo:

  - The tool->read() call may pass a NULL evsel, handle it.

core:

  Arnaldo Carvalho de Melo:

  - Move zalloc/zfree.c to tools/lib, further eroding tools/perf/util.[ch]

  - Use zfree() where applicable instead of open coded equivalent.

  - Add stdlib.h and some other headers to places where its needed and were
    getting via util.h, that doesn't need that anymore.

  - Use list_del_init() more thoroughly.

Miscellaneous:

  Leo Yan:

  - Fix use after free and potential NULL pointer derefs detected by the
    smatch tool in various places.

  Luke Mujica:

  - Remove a couple unused variables in the parse-events code.

  Numfor Mbiziwo-Tiapo:

  - Initialize variable to suppress memory sanitizer warning in the
    mmap-thread-lookup 'perf test' entry.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
      perf scripts python: export-to-sqlite.py: Fix DROP VIEW power_events_view

Arnaldo Carvalho de Melo (9):
      perf inject: The tool->read() call may pass a NULL evsel, handle it
      perf evsel: perf_evsel__name(NULL) is valid, no need to check evsel
      perf tools: Add missing headers, mostly stdlib.h
      perf namespaces: Move the conditional setns() prototype to namespaces.h
      perf tools: Move get_current_dir_name() cond prototype out of util.h
      tools lib: Adopt zalloc()/zfree() from tools/perf
      perf tools: Use zfree() where applicable
      perf tools: Use list_del_init() more thorougly
      perf metricgroup: Add missing list_del_init() when flushing egroups list

Leo Yan (10):
      perf stat: Fix use-after-freed pointer detected by the smatch tool
      perf top: Fix potential NULL pointer dereference detected by the smatch tool
      perf annotate: Fix dereferencing freed memory found by the smatch tool
      perf trace: Fix potential NULL pointer dereference found by the smatch tool
      perf map: Fix potential NULL pointer dereference found by smatch tool
      perf session: Fix potential NULL pointer dereference found by the smatch tool
      perf cs-etm: Fix potential NULL pointer dereference found by the smatch tool
      perf hists browser: Fix potential NULL pointer dereference found by the smatch tool
      perf intel-bts: Fix potential NULL pointer dereference found by the smatch tool
      perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool

Luke Mujica (2):
      perf parse-events: Remove unused variable 'i'
      perf parse-events: Remove unused variable: error

Numfor Mbiziwo-Tiapo (1):
      perf test mmap-thread-lookup: Initialize variable to suppress memory sanitizer warning

Song Liu (1):
      perf script: Assume native_arch for pipe mode

 tools/include/linux/zalloc.h                       | 12 +++++
 tools/lib/zalloc.c                                 | 15 ++++++
 tools/perf/MANIFEST                                |  1 +
 tools/perf/arch/arm/annotate/instructions.c        |  1 +
 tools/perf/arch/arm/util/auxtrace.c                |  1 +
 tools/perf/arch/arm/util/cs-etm.c                  |  1 +
 tools/perf/arch/arm64/util/arm-spe.c               |  1 +
 tools/perf/arch/common.c                           |  3 +-
 tools/perf/arch/powerpc/util/perf_regs.c           |  4 +-
 tools/perf/arch/s390/util/auxtrace.c               |  1 +
 tools/perf/arch/s390/util/header.c                 |  3 +-
 tools/perf/arch/x86/util/event.c                   |  2 +-
 tools/perf/arch/x86/util/intel-bts.c               |  2 +-
 tools/perf/arch/x86/util/intel-pt.c                |  2 +-
 tools/perf/arch/x86/util/perf_regs.c               |  2 +-
 tools/perf/bench/futex-hash.c                      |  3 +-
 tools/perf/bench/futex-lock-pi.c                   |  3 +-
 tools/perf/bench/mem-functions.c                   |  2 +-
 tools/perf/bench/numa.c                            |  2 +-
 tools/perf/builtin-annotate.c                      |  2 +-
 tools/perf/builtin-bench.c                         |  2 +-
 tools/perf/builtin-c2c.c                           |  2 +-
 tools/perf/builtin-config.c                        |  1 +
 tools/perf/builtin-diff.c                          |  2 +-
 tools/perf/builtin-ftrace.c                        |  2 +-
 tools/perf/builtin-help.c                          |  2 +
 tools/perf/builtin-inject.c                        |  2 +-
 tools/perf/builtin-kmem.c                          |  2 +-
 tools/perf/builtin-kvm.c                           |  2 +-
 tools/perf/builtin-lock.c                          | 10 ++--
 tools/perf/builtin-probe.c                         |  2 +-
 tools/perf/builtin-record.c                        |  4 +-
 tools/perf/builtin-report.c                        |  4 +-
 tools/perf/builtin-sched.c                         |  2 +-
 tools/perf/builtin-script.c                        |  5 +-
 tools/perf/builtin-stat.c                          |  8 ++--
 tools/perf/builtin-timechart.c                     |  4 +-
 tools/perf/builtin-top.c                           |  8 +++-
 tools/perf/builtin-trace.c                         |  7 +--
 tools/perf/perf.c                                  |  2 +-
 tools/perf/pmu-events/jevents.c                    |  2 +-
 tools/perf/scripts/python/export-to-postgresql.py  |  2 +-
 tools/perf/scripts/python/export-to-sqlite.py      |  2 +-
 tools/perf/tests/dwarf-unwind.c                    |  5 +-
 tools/perf/tests/expr.c                            |  3 +-
 tools/perf/tests/llvm.c                            |  1 +
 tools/perf/tests/mem2node.c                        |  3 +-
 tools/perf/tests/mmap-thread-lookup.c              |  2 +-
 tools/perf/tests/sample-parsing.c                  |  1 +
 tools/perf/tests/switch-tracking.c                 |  3 +-
 tools/perf/tests/thread-map.c                      |  3 +-
 tools/perf/tests/vmlinux-kallsyms.c                |  1 +
 tools/perf/ui/browser.c                            |  2 +-
 tools/perf/ui/browser.h                            |  1 +
 tools/perf/ui/browsers/annotate.c                  |  2 +-
 tools/perf/ui/browsers/hists.c                     | 17 +++++--
 tools/perf/ui/browsers/map.c                       |  1 +
 tools/perf/ui/browsers/res_sample.c                |  6 +--
 tools/perf/ui/browsers/scripts.c                   |  4 +-
 tools/perf/ui/gtk/annotate.c                       |  2 +-
 tools/perf/ui/gtk/util.c                           |  3 +-
 tools/perf/ui/stdio/hist.c                         |  2 +-
 tools/perf/ui/tui/setup.c                          |  1 +
 tools/perf/ui/tui/util.c                           |  2 +-
 tools/perf/util/Build                              |  5 ++
 tools/perf/util/annotate.c                         | 13 ++---
 tools/perf/util/arm-spe.c                          |  2 +-
 tools/perf/util/auxtrace.c                         | 11 ++---
 tools/perf/util/bpf-loader.c                       |  3 +-
 tools/perf/util/build-id.c                         |  1 +
 tools/perf/util/call-path.c                        |  5 +-
 tools/perf/util/callchain.c                        | 12 ++---
 tools/perf/util/cgroup.c                           |  4 +-
 tools/perf/util/comm.c                             |  2 +-
 tools/perf/util/config.c                           |  3 +-
 tools/perf/util/counts.c                           |  2 +-
 tools/perf/util/cpumap.c                           |  2 +-
 tools/perf/util/cputopo.c                          |  5 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  1 +
 tools/perf/util/cs-etm.c                           |  8 ++--
 tools/perf/util/data-convert-bt.c                  |  4 +-
 tools/perf/util/data.c                             |  3 +-
 tools/perf/util/db-export.c                        |  7 +--
 tools/perf/util/debug.c                            |  1 +
 tools/perf/util/demangle-java.c                    |  3 +-
 tools/perf/util/dso.c                              |  5 +-
 tools/perf/util/dwarf-aux.c                        |  2 +-
 tools/perf/util/env.c                              | 11 +++--
 tools/perf/util/event.c                            |  3 +-
 tools/perf/util/evlist.c                           |  2 +-
 tools/perf/util/evsel.c                            |  4 +-
 tools/perf/util/get_current_dir_name.c             |  6 +--
 tools/perf/util/get_current_dir_name.h             |  8 ++++
 tools/perf/util/header.c                           |  8 ++--
 tools/perf/util/help-unknown-cmd.c                 |  2 +
 tools/perf/util/hist.c                             | 20 ++++----
 tools/perf/util/intel-bts.c                        |  7 ++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  2 +-
 tools/perf/util/intel-pt.c                         | 15 +++---
 tools/perf/util/jitdump.c                          |  7 ++-
 tools/perf/util/llvm-utils.c                       |  4 +-
 tools/perf/util/machine.c                          |  6 +--
 tools/perf/util/map.c                              |  9 ++--
 tools/perf/util/mem2node.c                         |  2 +-
 tools/perf/util/metricgroup.c                      | 10 ++--
 tools/perf/util/mmap.c                             |  1 +
 tools/perf/util/namespaces.c                       |  3 +-
 tools/perf/util/namespaces.h                       |  4 ++
 tools/perf/util/ordered-events.c                   |  6 +--
 tools/perf/util/parse-branch-options.c             |  2 +-
 tools/perf/util/parse-events.c                     |  3 +-
 tools/perf/util/parse-events.y                     |  2 -
 tools/perf/util/parse-regs-options.c               |  8 +++-
 tools/perf/util/pmu.c                              |  4 +-
 tools/perf/util/probe-event.c                      | 55 ++++++++++------------
 tools/perf/util/probe-file.c                       |  2 +-
 tools/perf/util/probe-finder.c                     |  2 +-
 tools/perf/util/pstack.c                           |  2 +-
 tools/perf/util/python-ext-sources                 |  1 +
 tools/perf/util/s390-cpumsf.c                      | 11 ++---
 tools/perf/util/session.c                          |  7 ++-
 tools/perf/util/setns.c                            |  4 +-
 tools/perf/util/srccode.c                          | 11 +++--
 tools/perf/util/srcline.c                          |  2 +-
 tools/perf/util/stat-shadow.c                      |  3 +-
 tools/perf/util/stat.c                             |  3 +-
 tools/perf/util/strbuf.c                           |  3 +-
 tools/perf/util/strfilter.c                        |  3 +-
 tools/perf/util/strlist.c                          |  2 +-
 tools/perf/util/svghelper.c                        |  2 +-
 tools/perf/util/symbol-elf.c                       | 18 +++----
 tools/perf/util/symbol-minimal.c                   |  3 +-
 tools/perf/util/symbol.c                           |  1 +
 tools/perf/util/syscalltbl.c                       |  2 +-
 tools/perf/util/target.c                           |  2 +-
 tools/perf/util/thread-stack.c                     |  3 +-
 tools/perf/util/thread.c                           |  6 +--
 tools/perf/util/thread_map.c                       |  4 +-
 tools/perf/util/trace-event-info.c                 |  1 +
 tools/perf/util/trace-event-scripting.c            |  2 +-
 tools/perf/util/unwind-libdw.c                     |  1 +
 tools/perf/util/unwind-libunwind-local.c           |  3 +-
 tools/perf/util/usage.c                            |  3 ++
 tools/perf/util/util.h                             | 17 -------
 tools/perf/util/values.c                           |  2 +-
 tools/perf/util/vdso.c                             |  1 +
 tools/perf/util/xyarray.c                          |  2 +-
 147 files changed, 375 insertions(+), 279 deletions(-)
 create mode 100644 tools/include/linux/zalloc.h
 create mode 100644 tools/lib/zalloc.c
 create mode 100644 tools/perf/util/get_current_dir_name.h

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

The 'perf test bpf' test is about rlimit(MEMLOCK), bump it a to 128K from the
default 64K and it'll work. Next pull req will have auto-adjustment for 'perf
test' and 'perf trace', where BPF programs creating maps are also failing.

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0.tar.xz
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
  16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.1.1 20190628 gcc-9-branch@272773, clang version 8.0.0 (tags/RELEASE_800/final)
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  19 debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  20 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  21 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  22 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
  23 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
  24 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  32 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  33 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  34 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  35 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  36 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  37 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
  38 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
  39 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  40 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  41 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  42 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  43 manjaro:latest                : Ok   gcc (GCC) 9.1.0, clang version 8.0.0 (tags/RELEASE_800/final)
  44 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  45 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  46 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  47 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190611 [gcc-9-branch revision 272147], clang version 8.0.0 (tags/RELEASE_800/final 356365)
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
  60 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
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
  Linux quaco 5.2.0-rc7+ #4 SMP Sat Jul 6 14:43:41 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  323fd749821d perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool
  # perf version --build-options
  perf version 5.2.g323fd749821d
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
  41.1: Basic BPF filtering                                 : Skip
  41.2: BPF pinning                                         : Skip
  41.3: BPF prologue generation                             : Skip
  41.4: BPF relocation checker                              : Skip
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

  $ make -C tools/perf build-test | tee /wb/build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_static_O: make LDFLAGS=-static
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_clean_all_O: make clean all
                    make_doc_O: make doc
             make_no_libperl_O: make NO_LIBPERL=1
                make_install_O: make install
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                 make_cscope_O: make cscope
                   make_tags_O: make tags
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
               make_no_slang_O: make NO_SLANG=1
            make_install_bin_O: make install-bin
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                 make_perf_o_O: make perf.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_gtk2_O: make NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_pure_O: make
                make_no_newt_O: make NO_NEWT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_help_O: make help
                  make_debug_O: make DEBUG=1
            make_no_demangle_O: make NO_DEMANGLE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
