Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C1C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE012217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569457984;
	bh=Xkbhjnhy+eQqcOUOsfgZPyZVXj5v286TYUJj8kSnxuQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D0L/EhupVIvBnNzZUCzH4AZJXrUCDysOUarPycVc9GxV/gSNJQhFHKT8lgA1msROw
	 3SWKqRtg29auPdjYK1jwQnJKyTJcAueVLZ6q753ePhsVN3lnoZ5fAZJEFRDBVrwLOQ
	 AOe+zD5+USsLaSKQ9PQCGgIocpcyE4dCkvDKFrz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfIZAc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:32:57 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B19121D6C;
        Thu, 26 Sep 2019 00:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569457975;
        bh=Xkbhjnhy+eQqcOUOsfgZPyZVXj5v286TYUJj8kSnxuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=2dPcu0mvv9YJm3jhZ7v6NtWzS8SiO31B3oRrMoKZFw7bD9mvuB/DoHaBH1bK5qQgq
         hfG8SVScUqFjzdPIh+LOp0tU+givvRu0ahNpCgMVmhSUCPpFIGMcveOA7zQo9Ez+sZ
         7WyWy9fPL6EDfadSfNiH2J4YkKE/RnLacQDnSMzA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Wed, 25 Sep 2019 21:31:38 -0300
Message-Id: <20190926003244.13962-1-acme@kernel.org>
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

The following changes since commit 2b32769700f857a8e608a8ee24080833889965b9:

  Merge tag 'perf-urgent-for-mingo-5.4-20190921' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-09-22 12:45:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20190925

for you to fetch changes up to d6840d87b2d148e19e244ad2b44d28ba07f437a0:

  perf parser: Remove needless include directives (2019-09-25 16:26:41 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf record:

  Stephane Eranian:

  - Fix priv level with branch sampling for paranoid=2, i.e. the kernel checks
    if perf_event_attr_attr.exclude_hv is set in addition to .exclude_kernel,
    so reset both to zero.

  Arnaldo Carvalho de Melo:

  - Don't warn about not being able to read kernel maps (kallsyms, etc) when
    kernel samples aren't being collected.

perf list:

  Kim Phillips:

  - Allow plurals for metric, metricgroup., i.e.:

    $ perf list metrics

    was showing nothing, which is very confusing, make it work like:

    $ perf stat metric

perf stat:

  Andi Kleen:

  - Free memory access/leaks detected via valgrind, related to metrics.

Libraries:

libperf:

  Jiri Olsa:

  - Move more stuff from tools/perf, this time a first stab at moving perf_mmap
    methods.

libtracevent:

  Steven Rostedt (VMware):

  - Round up in tep_print_event() time precision.

  Tzvetomir Stoyanov (VMware):

  - Man pages for event print and related and plugins APIs.

  - Move traceevent plugins in its own subdirectory.

Feature detection:

  Thomas Richter:

  - Add detection of java-11-openjdk-devel package, in addition to the older
    versions supported.

Architecture specific:

S/390:

  Thomas Richter (2):

  - Include JVMTI support for s390

Vendor events:

AMD:

  Kim Phillips:

  - Add L3 cache events for Family 17h.

  - Remove redundant '['.

PowerPC:

  Mamatha Inamdar:

  - Remove P8 HW events which are not supported.

Cleanups:

  Arnaldo Carvalho de Melo:

  - Remove needless headers, add needed ones, move things around to reduce the
    headers dependency tree, speeding up builds by not doing needless compiles
    when unrelated stuff gets changed.

  - Ditch unused code that was dragging headers.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (2):
      perf stat: Fix free memory access / memory leaks in metrics
      perf evlist: Fix access of freed id arrays

Arnaldo Carvalho de Melo (12):
      perf record: Move restricted maps check to after a possible fallback to not collect kernel samples
      perf evlist: Adopt backwards ring buffer state enum
      libperf: Add missing 'struct xyarray' forward declaration
      perf tools: No need to include internal/lib.h from util/util.h
      libperf: Use sys/types.h to get ssize_t, not unistd.h
      perf copyfile: Move copyfile routines to separate files
      perf evsel: Remove need for symbol_conf in evsel_fprintf.c
      perf evsel: Introduce evsel_fprintf.h
      perf evlist: Remove unused perf_evlist__fprintf() method
      perf evsel: Move config terms to a separate header
      perf tools: Replace needless mmap.h with what is needed, event.h
      perf parser: Remove needless include directives

Jiri Olsa (37):
      tools: Add missing stdio.h include to asm/bug.h header
      perf tools: Rename 'struct perf_mmap' to 'struct mmap'
      perf tools: Rename perf_evlist__mmap() to evlist__mmap()
      perf tools: Rename perf_evlist__munmap() to evlist__munmap()
      perf tools: Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap()
      perf tools: Rename perf_evlist__exit() to evlist__exit()
      perf tools: Rename perf_evlist__purge() to evlist__purge()
      libperf: Link libapi.a in libperf.so
      libperf: Add perf_mmap struct
      libperf: Add 'mask' to struct perf_mmap
      libperf: Add 'fd' to struct perf_mmap
      libperf: Add 'cpu' to struct perf_mmap
      libperf: Add 'refcnt' to struct perf_mmap
      libperf: Add prev/start/end to struct perf_mmap
      libperf: Add 'overwrite' to 'struct perf_mmap'
      libperf: Add 'event_copy' to 'struct perf_mmap'
      libperf: Add 'flush' to 'struct perf_mmap'
      libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'
      libperf: Move 'nr_mmaps' from 'struct evlist' to 'struct perf_evlist'
      libperf: Move 'mmap_len' from 'struct evlist' to 'struct perf_evlist'
      libperf: Move 'pollfd' from 'struct evlist' to 'struct perf_evlist'
      libperf: Move 'sample_id' from 'struct evsel' to 'struct perf_evsel'
      libperf: Move 'id' from 'struct evsel' to 'struct perf_evsel'
      libperf: Move 'ids' from 'struct evsel' to 'struct perf_evsel'
      libperf: Move 'heads' from 'struct evlist' to 'struct perf_evlist'
      libperf: Add perf_evsel__alloc_id/perf_evsel__free_id functions
      libperf: Add perf_evlist__first()/last() functions
      libperf: Add perf_evlist__read_format() function
      libperf: Add perf_evlist__id_add() function
      libperf: Add perf_evlist__id_add_fd() function
      libperf: Move 'page_size' global variable to libperf
      libperf: Add libperf dependency for tests targets
      libperf: Merge libperf_set_print() into libperf_init()
      libperf: Add libperf_init() call to the tests
      libperf: Add perf_evlist__alloc_pollfd() function
      libperf: Add perf_evlist__add_pollfd() function
      libperf: Add perf_evlist__poll() function

Kim Phillips (4):
      perf vendor events amd: Add L3 cache events for Family 17h
      perf vendor events amd: Remove redundant '['
      perf vendor events: Minor fixes to the README
      perf list: Allow plurals for metric, metricgroup

Mamatha Inamdar (1):
      perf vendor events: Remove P8 HW events which are not supported

Stephane Eranian (1):
      perf record: Fix priv level with branch sampling for paranoid=2

Steven Rostedt (VMware) (1):
      libtraceevent: Round up in tep_print_event() time precision

Thomas Richter (2):
      perf jvmti: Include JVMTI support for s390
      perf build: Add detection of java-11-openjdk-devel package

Tzvetomir Stoyanov (2):
      libtraceevent: Man pages for libtraceevent event print related API
      libtraceevent: Man pages for tep plugins APIs

Tzvetomir Stoyanov (VMware) (4):
      libtraceevent: Man pages fix, rename tep_ref_get() to tep_get_ref()
      libtraceevent: Man pages fix, changes in event printing APIs
      libtraceevent: Add tep_get_event() in event-parse.h
      libtraceevent: Move traceevent plugins in its own subdirectory

 tools/include/asm/bug.h                            |   1 +
 tools/lib/traceevent/Build                         |  11 -
 .../Documentation/libtraceevent-event_print.txt    | 130 +++++++++
 .../Documentation/libtraceevent-handle.txt         |   8 +-
 .../Documentation/libtraceevent-plugins.txt        |  99 +++++++
 .../lib/traceevent/Documentation/libtraceevent.txt |  15 +-
 tools/lib/traceevent/Makefile                      |  94 ++-----
 tools/lib/traceevent/event-parse.c                 |   4 +-
 tools/lib/traceevent/event-parse.h                 |   2 +
 tools/lib/traceevent/plugins/Build                 |  10 +
 tools/lib/traceevent/plugins/Makefile              | 222 ++++++++++++++++
 .../lib/traceevent/{ => plugins}/plugin_cfg80211.c |   0
 .../lib/traceevent/{ => plugins}/plugin_function.c |   0
 .../lib/traceevent/{ => plugins}/plugin_hrtimer.c  |   0
 tools/lib/traceevent/{ => plugins}/plugin_jbd2.c   |   0
 tools/lib/traceevent/{ => plugins}/plugin_kmem.c   |   0
 tools/lib/traceevent/{ => plugins}/plugin_kvm.c    |   0
 .../lib/traceevent/{ => plugins}/plugin_mac80211.c |   0
 .../traceevent/{ => plugins}/plugin_sched_switch.c |   0
 tools/lib/traceevent/{ => plugins}/plugin_scsi.c   |   0
 tools/lib/traceevent/{ => plugins}/plugin_xen.c    |   0
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/Makefile.perf                           |   4 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   6 +-
 tools/perf/arch/s390/Makefile                      |   1 +
 tools/perf/arch/s390/util/auxtrace.c               |   1 +
 tools/perf/arch/s390/util/machine.c                |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |   5 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |  11 +-
 tools/perf/arch/x86/tests/rdpmc.c                  |   2 +-
 tools/perf/arch/x86/util/intel-bts.c               |   9 +-
 tools/perf/arch/x86/util/intel-pt.c                |  17 +-
 tools/perf/arch/x86/util/machine.c                 |   2 +-
 tools/perf/builtin-evlist.c                        |   1 +
 tools/perf/builtin-kvm.c                           |  13 +-
 tools/perf/builtin-list.c                          |   4 +-
 tools/perf/builtin-record.c                        | 102 +++----
 tools/perf/builtin-sched.c                         |   3 +-
 tools/perf/builtin-script.c                        |  11 +-
 tools/perf/builtin-stat.c                          |   6 +-
 tools/perf/builtin-top.c                           |  22 +-
 tools/perf/builtin-trace.c                         |  17 +-
 tools/perf/lib/Makefile                            |  35 ++-
 tools/perf/lib/core.c                              |  13 +-
 tools/perf/lib/evlist.c                            | 124 +++++++++
 tools/perf/lib/evsel.c                             |  30 +++
 tools/perf/lib/include/internal/evlist.h           |  33 +++
 tools/perf/lib/include/internal/evsel.h            |  33 +++
 tools/perf/lib/include/internal/lib.h              |   4 +-
 tools/perf/lib/include/internal/mmap.h             |  32 +++
 tools/perf/lib/include/perf/core.h                 |   2 +-
 tools/perf/lib/include/perf/evlist.h               |   1 +
 tools/perf/lib/lib.c                               |   2 +
 tools/perf/lib/libperf.map                         |   3 +-
 tools/perf/lib/tests/test-cpumap.c                 |  10 +
 tools/perf/lib/tests/test-evlist.c                 |  10 +
 tools/perf/lib/tests/test-evsel.c                  |  10 +
 tools/perf/lib/tests/test-threadmap.c              |  10 +
 tools/perf/perf.c                                  |  13 +-
 tools/perf/pmu-events/README                       |  22 +-
 .../perf/pmu-events/arch/powerpc/power8/other.json |  24 --
 .../perf/pmu-events/arch/x86/amdfam17h/cache.json  |  42 +++
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json |   2 +-
 tools/perf/pmu-events/jevents.c                    |   1 +
 tools/perf/tests/backward-ring-buffer.c            |  11 +-
 tools/perf/tests/bpf.c                             |   9 +-
 tools/perf/tests/code-reading.c                    |  11 +-
 tools/perf/tests/event-times.c                     |  14 +-
 tools/perf/tests/event_update.c                    |   6 +-
 tools/perf/tests/evsel-roundtrip-name.c            |   2 +-
 tools/perf/tests/hists_cumulate.c                  |   2 +-
 tools/perf/tests/hists_link.c                      |   5 +-
 tools/perf/tests/hists_output.c                    |   2 +-
 tools/perf/tests/keep-tracking.c                   |  11 +-
 tools/perf/tests/mmap-basic.c                      |   5 +-
 tools/perf/tests/mmap-thread-lookup.c              |   2 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |  11 +-
 tools/perf/tests/parse-events.c                    | 116 ++++----
 tools/perf/tests/perf-record.c                     |  13 +-
 tools/perf/tests/sdt.c                             |   1 +
 tools/perf/tests/sw-clock.c                        |   5 +-
 tools/perf/tests/switch-tracking.c                 |  29 +-
 tools/perf/tests/task-exit.c                       |   9 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   2 +-
 tools/perf/ui/browsers/hists.c                     |   6 +-
 tools/perf/ui/gtk/hists.c                          |   1 +
 tools/perf/util/Build                              |   2 +
 tools/perf/util/annotate.c                         |   1 +
 tools/perf/util/auxtrace.c                         |   8 +-
 tools/perf/util/auxtrace.h                         |   8 +-
 tools/perf/util/bpf-loader.c                       |   2 +-
 tools/perf/util/build-id.c                         |   3 +-
 tools/perf/util/copyfile.c                         | 144 ++++++++++
 tools/perf/util/copyfile.h                         |  16 ++
 tools/perf/util/cs-etm.c                           |   2 +-
 tools/perf/util/evlist.c                           | 295 ++++++---------------
 tools/perf/util/evlist.h                           |  81 +++---
 tools/perf/util/evsel.c                            | 204 ++------------
 tools/perf/util/evsel.h                            | 121 +--------
 tools/perf/util/evsel_config.h                     |  50 ++++
 tools/perf/util/evsel_fprintf.c                    |  15 +-
 tools/perf/util/evsel_fprintf.h                    |  50 ++++
 tools/perf/util/genelf.h                           |   3 +
 tools/perf/util/header.c                           |  29 +-
 tools/perf/util/intel-bts.c                        |   4 +-
 tools/perf/util/intel-pt.c                         |  10 +-
 tools/perf/util/jitdump.c                          |   2 +-
 tools/perf/util/machine.c                          |   1 +
 tools/perf/util/mmap.c                             | 185 ++++++-------
 tools/perf/util/mmap.h                             |  77 ++----
 tools/perf/util/parse-events.c                     |   8 +-
 tools/perf/util/parse-events.y                     |   4 +-
 tools/perf/util/perf_event_attr_fprintf.c          | 148 +++++++++++
 tools/perf/util/python-ext-sources                 |   1 +
 tools/perf/util/python.c                           |  24 +-
 tools/perf/util/record.c                           |   6 +-
 tools/perf/util/session.c                          |   5 +-
 tools/perf/util/sort.c                             |   2 +-
 tools/perf/util/srccode.c                          |   2 +-
 tools/perf/util/stat-shadow.c                      |   4 +-
 tools/perf/util/stat.c                             |   2 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 tools/perf/util/synthetic-events.c                 |  20 +-
 tools/perf/util/top.c                              |   2 +-
 tools/perf/util/trace-event-info.c                 |   2 +-
 tools/perf/util/util.c                             | 136 ----------
 tools/perf/util/util.h                             |   8 -
 128 files changed, 1941 insertions(+), 1321 deletions(-)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
 create mode 100644 tools/lib/traceevent/plugins/Build
 create mode 100644 tools/lib/traceevent/plugins/Makefile
 rename tools/lib/traceevent/{ => plugins}/plugin_cfg80211.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_function.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_hrtimer.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_jbd2.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_kmem.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_kvm.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_mac80211.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_sched_switch.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_scsi.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_xen.c (100%)
 create mode 100644 tools/perf/lib/include/internal/mmap.h
 create mode 100644 tools/perf/util/copyfile.c
 create mode 100644 tools/perf/util/copyfile.h
 create mode 100644 tools/perf/util/evsel_config.h
 create mode 100644 tools/perf/util/evsel_fprintf.h
 create mode 100644 tools/perf/util/perf_event_attr_fprintf.c

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

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.3.0.tar.xz
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
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20190908 gcc-9-branch@275492, clang version 8.0.0 (tags/RELEASE_800/final)
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  19 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  20 debian:experimental           : Ok   gcc (Debian 9.2.1-8) 9.2.1 20190909, clang version 8.0.1-3+b1 (tags/RELEASE_801/final)
  21 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  22 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  23 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-19) 8.3.0
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
  35 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  36 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  37 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  38 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc31.1)
  39 fedora:rawhide                : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-0.2.rc3.fc31)
  40 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  41 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  42 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  43 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  44 manjaro:latest                : Ok   gcc (GCC) 9.1.0, clang version 8.0.1 (tags/RELEASE_801/final)
  45 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  46 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  47 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  48 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190820 [gcc-9-branch revision 274748], clang version 8.0.1 (tags/RELEASE_801/final 366581)
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
  77 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-8ubuntu1) 9.2.1 20190909, clang version 9.0.0-+rc5-1~exp1 (tags/RELEASE_900/rc5)
  #

  # uname -a
  Linux quaco 5.2.17-200.fc30.x86_64 #1 SMP Mon Sep 23 13:42:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  d6840d87b2d1 perf parser: Remove needless include directives
  # perf version --build-options
  perf version 5.3.gd6840d87b2d1
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
  
  $ make -C tools/perf build-test | tee /wb/build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_no_libbpf_O: make NO_LIBBPF=1
                make_install_O: make install
                 make_cscope_O: make cscope
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
                 make_perf_o_O: make perf.o
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
                   make_tags_O: make tags
                   make_pure_O: make
             make_util_map_o_O: make util/map.o
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_no_newt_O: make NO_NEWT=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                    make_doc_O: make doc
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_debug_O: make DEBUG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
