Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BDCC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6E22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708321;
	bh=ubMXJ+o0gd3tAky2awl2CKhwth9pbHOY1aZQ0usMDVc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G0kmeLdE26Sampn9NED+z2d15eEMw6g3XtYxC8pE/GKAv5CG7ITqEl9HuNQPyTGtr
	 mDGJ0ZXAvVF5oT4PFb231s1hBTQwiAyFXYwQEx5zC34VvPU5Vrt1BAZEro0Eq+lfLA
	 dgzkIq+5Yi3rQowr9ifcr8C9BGmzebIS5QlVTbiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfGULZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGULZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:25:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECFCD307D910;
        Sun, 21 Jul 2019 11:25:17 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D4013790;
        Sun, 21 Jul 2019 11:25:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [RFC 00/79] perf tools: Initial libperf separation
Date:   Sun, 21 Jul 2019 13:23:47 +0200
Message-Id: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 21 Jul 2019 11:25:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
we have long term goal to separate some of the perf functionality
into library. This patchset is initial effort on separating some
of the interface.

Currently only the basic counting interface is exported, it allows
to:
  - create cpu/threads maps
  - create evlist/evsel objects
  - add evsel objects into evlist
  - open/close evlist/evsel objects
  - enable/disable events
  - read evsel counts

The initial effort was to have total separation of the objects
from perf code, but it showed not to be a good way. The amount
of changed code was too big with high chance for regressions,
mainly because of the code embedding one of the above objects
statically.

We took the other approach of sharing the objects/struct details
within the perf and libperf code. This way we can keep perf
functionality without any major changes and the libperf users
are still separated from the object/struct details. We can move
to total libperf's objects separation gradually in future.

You can check current interface/functionality in examples under:
  tools/perf/lib/Documentation/tutorial

or check tests in here:
  $ cd tools/perf/lib && make tests
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-evlist-a
    LINK     test-evsel-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
    LINK     test-evlist-so
    LINK     test-evsel-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK

The upcoming changes in the near future:
  - move parse_events interface in, so we have the event parsing
    interface in the library together with the all events from
    tools/perf/pmu-events/arch
  - add sampling interface with event mmap support and all the
    sampling events objects
  - add user mmap interface to read counters
  - more documentation and tutorial ;-)
  - move under tools/lib after the interface is more stable-ish

Big kudos to BPF guys, because most of the infrastructure is
'borrowed' from libbpf library.. ;-)

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/lib

I tested so far on x86, I still need to run it through s390/ppc/arm.

throughts? thanks,
jirka


Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephane Eranian <eranian@google.com>
---
Jiri Olsa (79):
      perf tools: Move loaded out of struct perf_counts_values
      perf tools: Rename struct cpu_map to struct perf_cpu_map
      perf tools: Rename struct thread_map to struct perf_thread_map
      perf tools: Rename struct perf_evsel to struct evsel
      perf tools: Rename struct perf_evlist to struct evlist
      perf tools: Rename perf_evsel__init to evsel__init
      perf tools: Rename perf_evlist__init to evlist__init
      perf tools: Rename perf_evlist__new to evlist__new
      perf tools: Rename perf_evlist__delete to evlist__delete
      perf tools: Rename perf_evsel__delete to evsel__delete
      perf tools: Rename perf_evsel__new to evsel__new
      perf tools: Rename perf_evlist__add to evlist__add
      perf tools: Rename perf_evlist__remove to evlist__remove
      perf tools: Rename perf_evsel__open to evsel__open
      perf tools: Rename perf_evsel__enable to evsel__enable
      perf tools: Rename perf_evsel__disable to evsel__disable
      perf tools: Rename perf_evsel__apply_filter to evsel__apply_filter
      perf tools: Rename perf_evsel__cpus to evsel__cpus
      perf tools: Rename perf_evlist__open to evlist__open
      perf tools: Rename perf_evlist__close to evlist__close
      perf tools: Rename perf_evlist__enable to evlist__enable
      perf tools: Rename perf_evlist__disable to evlist__disable
      libperf: Make libperf.a part of the build
      libperf: Add build version support
      libperf: Add libperf in python.so compilation
      libperf: Add perf/core.h header
      libperf: Add debug output support
      libperf: Add perf_cpu_map struct
      libperf: Add perf_cpu_map__dummy_new function
      libperf: Add perf_cpu_map__get/perf_cpu_map__put
      libperf: Add perf_thread_map struct
      libperf: Add perf_thread_map__new_dummy function
      libperf: Add perf_thread_map__get/perf_thread_map__put
      libperf: Add perf_evlist and perf_evsel structs
      libperf: Include perf_evsel in evsel object
      libperf: Include perf_evlist in evlist object
      libperf: Add perf_evsel__init function
      libperf: Add perf_evlist__init function
      libperf: Add perf_evlist__add function
      libperf: Add perf_evlist__remove function
      libperf: Add nr_entries to perf_evlist
      libperf: Add attr to perf_evsel
      libperf: Add perf_cpu_map__new/perf_cpu_map__read functions
      libperf: Move zalloc.o into libperf
      libperf: Add perf_evlist__new function
      libperf: Add perf_evsel__new function
      libperf: Add perf_evlist__for_each_evsel macro
      libperf: Add perf_evlist__delete function
      libperf: Add perf_evsel__delete function
      libperf: Add cpus to struct perf_evsel
      libperf: Add own_cpus to struct perf_evsel
      libperf: Add threads to struct perf_evsel
      libperf: Add has_user_cpus to struct perf_evlist
      libperf: Add cpus to struct perf_evlist
      libperf: Add threads to struct perf_evlist
      libperf: Add perf_evlist__set_maps function
      libperf: Add xyarray object
      libperf: Add fd array to struct perf_evsel
      libperf: Add nr_members to struct perf_evsel
      libperf: Add readn/writen function
      libperf: Add perf_evsel__alloc_fd function
      libperf: Add perf_evsel__open function
      libperf: Add perf_evsel__close function
      libperf: Add perf_evsel__read function
      libperf: Add perf_evsel__enable/disable/apply_filter functions
      libperf: Add perf_cpu_map__for_each_cpu macro
      libperf: Add perf_evsel__cpus/threads functions
      libperf: Add perf_evlist__open/close functions
      libperf: Add perf_evlist__enable/disable functions
      libperf: Add perf_evsel__attr functions
      libperf: Add install targets
      libperf: Add tests support
      libperf: Add perf_cpu_map test
      libperf: Add perf_thread_map test
      libperf: Add perf_evlist test
      libperf: Add perf_evsel tests
      libperf: Add perf_evlist__enable/disable test
      libperf: Add perf_evsel__enable/disable test
      libperf: Initial documentation

 tools/perf/Makefile.config                         |    1 +
 tools/perf/Makefile.perf                           |   31 +-
 tools/perf/arch/arm/util/auxtrace.c                |    4 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   26 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    6 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |   12 +-
 tools/perf/arch/s390/util/auxtrace.c               |    8 +-
 tools/perf/arch/s390/util/kvm-stat.c               |    8 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |    8 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   30 +-
 tools/perf/arch/x86/util/auxtrace.c                |   10 +-
 tools/perf/arch/x86/util/intel-bts.c               |   38 +-
 tools/perf/arch/x86/util/intel-pt.c                |   82 +-
 tools/perf/arch/x86/util/kvm-stat.c                |   12 +-
 tools/perf/bench/epoll-ctl.c                       |    7 +-
 tools/perf/bench/epoll-wait.c                      |    7 +-
 tools/perf/bench/futex-hash.c                      |    5 +-
 tools/perf/bench/futex-lock-pi.c                   |    7 +-
 tools/perf/bench/futex-requeue.c                   |    7 +-
 tools/perf/bench/futex-wake-parallel.c             |    6 +-
 tools/perf/bench/futex-wake.c                      |    7 +-
 tools/perf/builtin-annotate.c                      |   16 +-
 tools/perf/builtin-c2c.c                           |   10 +-
 tools/perf/builtin-diff.c                          |   20 +-
 tools/perf/builtin-evlist.c                        |    4 +-
 tools/perf/builtin-ftrace.c                        |   18 +-
 tools/perf/builtin-inject.c                        |   60 +-
 tools/perf/builtin-kmem.c                          |   24 +-
 tools/perf/builtin-kvm.c                           |   46 +-
 tools/perf/builtin-lock.c                          |   30 +-
 tools/perf/builtin-mem.c                           |    2 +-
 tools/perf/builtin-record.c                        |   50 +-
 tools/perf/builtin-report.c                        |   32 +-
 tools/perf/builtin-sched.c                         |   96 +-
 tools/perf/builtin-script.c                        |  167 +--
 tools/perf/builtin-stat.c                          |  135 +--
 tools/perf/builtin-timechart.c                     |   46 +-
 tools/perf/builtin-top.c                           |   71 +-
 tools/perf/builtin-trace.c                         |  180 +--
 tools/perf/lib/Build                               |   12 +
 tools/perf/lib/Documentation/Makefile              |    7 +
 tools/perf/lib/Documentation/man/libperf.rst       |  102 ++
 tools/perf/lib/Documentation/tutorial/tutorial.rst |  123 ++
 tools/perf/lib/Makefile                            |  158 +++
 tools/perf/lib/core.c                              |   34 +
 tools/perf/lib/cpumap.c                            |  239 ++++
 tools/perf/lib/evlist.c                            |  159 +++
 tools/perf/lib/evsel.c                             |  232 ++++
 tools/perf/lib/include/internal/cpumap.h           |   17 +
 tools/perf/lib/include/internal/evlist.h           |   50 +
 tools/perf/lib/include/internal/evsel.h            |   29 +
 tools/perf/lib/include/internal/lib.h              |   10 +
 tools/perf/lib/include/internal/tests.h            |   19 +
 tools/perf/lib/include/internal/threadmap.h        |   23 +
 .../perf/{util => lib/include/internal}/xyarray.h  |    6 +-
 tools/perf/lib/include/perf/core.h                 |   22 +
 tools/perf/lib/include/perf/cpumap.h               |   23 +
 tools/perf/lib/include/perf/evlist.h               |   35 +
 tools/perf/lib/include/perf/evsel.h                |   39 +
 tools/perf/lib/include/perf/threadmap.h            |   18 +
 tools/perf/lib/internal.h                          |   18 +
 tools/perf/lib/lib.c                               |   46 +
 tools/perf/lib/libperf.map                         |   40 +
 tools/perf/lib/libperf.pc.template                 |   11 +
 tools/perf/lib/tests/Makefile                      |   38 +
 tools/perf/lib/tests/test-cpumap.c                 |   21 +
 tools/perf/lib/tests/test-evlist.c                 |  186 +++
 tools/perf/lib/tests/test-evsel.c                  |  125 ++
 tools/perf/lib/tests/test-threadmap.c              |   21 +
 tools/perf/lib/threadmap.c                         |   81 ++
 tools/perf/lib/xyarray.c                           |   33 +
 tools/perf/tests/backward-ring-buffer.c            |   18 +-
 tools/perf/tests/bitmap.c                          |    5 +-
 tools/perf/tests/bpf.c                             |   12 +-
 tools/perf/tests/code-reading.c                    |   50 +-
 tools/perf/tests/cpumap.c                          |   21 +-
 tools/perf/tests/event-times.c                     |   81 +-
 tools/perf/tests/event_update.c                    |   13 +-
 tools/perf/tests/evsel-roundtrip-name.c            |   12 +-
 tools/perf/tests/evsel-tp-sched.c                  |    8 +-
 tools/perf/tests/hists_cumulate.c                  |   18 +-
 tools/perf/tests/hists_filter.c                    |   10 +-
 tools/perf/tests/hists_link.c                      |   10 +-
 tools/perf/tests/hists_output.c                    |   20 +-
 tools/perf/tests/keep-tracking.c                   |   44 +-
 tools/perf/tests/mem2node.c                        |    5 +-
 tools/perf/tests/mmap-basic.c                      |   28 +-
 tools/perf/tests/mmap-thread-lookup.c              |    4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   18 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   14 +-
 tools/perf/tests/openat-syscall.c                  |   10 +-
 tools/perf/tests/parse-events.c                    | 1220 ++++++++++----------
 tools/perf/tests/parse-no-sample-id-all.c          |    6 +-
 tools/perf/tests/perf-record.c                     |   10 +-
 tools/perf/tests/sample-parsing.c                  |    8 +-
 tools/perf/tests/sw-clock.c                        |   33 +-
 tools/perf/tests/switch-tracking.c                 |   64 +-
 tools/perf/tests/task-exit.c                       |   35 +-
 tools/perf/tests/thread-map.c                      |   28 +-
 tools/perf/tests/time-utils-test.c                 |    2 +-
 tools/perf/tests/topology.c                        |    9 +-
 tools/perf/ui/browsers/annotate.c                  |   16 +-
 tools/perf/ui/browsers/hists.c                     |   54 +-
 tools/perf/ui/browsers/res_sample.c                |    4 +-
 tools/perf/ui/browsers/scripts.c                   |    6 +-
 tools/perf/ui/gtk/annotate.c                       |    8 +-
 tools/perf/ui/gtk/gtk.h                            |    8 +-
 tools/perf/ui/gtk/hists.c                          |    6 +-
 tools/perf/ui/hist.c                               |   16 +-
 tools/perf/util/Build                              |    6 -
 tools/perf/util/annotate.c                         |   42 +-
 tools/perf/util/annotate.h                         |   26 +-
 tools/perf/util/auxtrace.c                         |   28 +-
 tools/perf/util/auxtrace.h                         |   24 +-
 tools/perf/util/bpf-event.c                        |    2 +-
 tools/perf/util/bpf-event.h                        |    4 +-
 tools/perf/util/bpf-loader.c                       |   34 +-
 tools/perf/util/bpf-loader.h                       |   28 +-
 tools/perf/util/build-id.c                         |    2 +-
 tools/perf/util/build-id.h                         |    2 +-
 tools/perf/util/callchain.c                        |    2 +-
 tools/perf/util/callchain.h                        |    2 +-
 tools/perf/util/cgroup.c                           |   22 +-
 tools/perf/util/cgroup.h                           |    6 +-
 tools/perf/util/counts.c                           |   17 +-
 tools/perf/util/counts.h                           |   34 +-
 tools/perf/util/cpumap.c                           |  264 +----
 tools/perf/util/cpumap.h                           |   54 +-
 tools/perf/util/cputopo.c                          |   13 +-
 tools/perf/util/cs-etm.c                           |    4 +-
 tools/perf/util/data-convert-bt.c                  |   38 +-
 tools/perf/util/db-export.c                        |   10 +-
 tools/perf/util/db-export.h                        |   10 +-
 tools/perf/util/env.c                              |    2 +-
 tools/perf/util/env.h                              |    2 +-
 tools/perf/util/event.c                            |   30 +-
 tools/perf/util/event.h                            |   14 +-
 tools/perf/util/evlist.c                           |  607 +++++-----
 tools/perf/util/evlist.h                           |  215 ++--
 tools/perf/util/evsel.c                            |  496 ++++----
 tools/perf/util/evsel.h                            |  194 ++--
 tools/perf/util/evsel_fprintf.c                    |   16 +-
 tools/perf/util/header.c                           |  225 ++--
 tools/perf/util/header.h                           |   24 +-
 tools/perf/util/hist.c                             |   32 +-
 tools/perf/util/hist.h                             |   38 +-
 tools/perf/util/intel-bts.c                        |   22 +-
 tools/perf/util/intel-pt.c                         |   94 +-
 tools/perf/util/jitdump.c                          |    8 +-
 tools/perf/util/kvm-stat.h                         |   22 +-
 tools/perf/util/machine.c                          |   12 +-
 tools/perf/util/machine.h                          |    8 +-
 tools/perf/util/map.h                              |    2 +-
 tools/perf/util/metricgroup.c                      |   26 +-
 tools/perf/util/metricgroup.h                      |    6 +-
 tools/perf/util/mmap.c                             |    4 +-
 tools/perf/util/parse-events.c                     |  143 +--
 tools/perf/util/parse-events.h                     |    8 +-
 tools/perf/util/pmu.c                              |   15 +-
 tools/perf/util/pmu.h                              |    2 +-
 tools/perf/util/python-ext-sources                 |    2 -
 tools/perf/util/python.c                           |   73 +-
 tools/perf/util/record.c                           |   73 +-
 tools/perf/util/s390-cpumsf.c                      |    4 +-
 tools/perf/util/s390-sample-raw.c                  |    6 +-
 tools/perf/util/sample-raw.c                       |    2 +-
 tools/perf/util/sample-raw.h                       |    6 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   14 +-
 .../util/scripting-engines/trace-event-python.c    |   40 +-
 tools/perf/util/session.c                          |   81 +-
 tools/perf/util/session.h                          |   12 +-
 tools/perf/util/setup.py                           |    3 +-
 tools/perf/util/sort.c                             |   60 +-
 tools/perf/util/sort.h                             |    6 +-
 tools/perf/util/stat-display.c                     |  112 +-
 tools/perf/util/stat-shadow.c                      |   70 +-
 tools/perf/util/stat.c                             |   64 +-
 tools/perf/util/stat.h                             |   35 +-
 tools/perf/util/svghelper.c                        |    7 +-
 tools/perf/util/thread_map.c                       |  131 +--
 tools/perf/util/thread_map.h                       |   58 +-
 tools/perf/util/tool.h                             |    8 +-
 tools/perf/util/top.c                              |   12 +-
 tools/perf/util/top.h                              |    8 +-
 tools/perf/util/trace-event-info.c                 |   14 +-
 tools/perf/util/trace-event-scripting.c            |    2 +-
 tools/perf/util/trace-event.h                      |    4 +-
 tools/perf/util/util.c                             |   40 -
 tools/perf/util/util.h                             |    4 +-
 189 files changed, 5313 insertions(+), 3819 deletions(-)
 create mode 100644 tools/perf/lib/Build
 create mode 100644 tools/perf/lib/Documentation/Makefile
 create mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 create mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst
 create mode 100644 tools/perf/lib/Makefile
 create mode 100644 tools/perf/lib/core.c
 create mode 100644 tools/perf/lib/cpumap.c
 create mode 100644 tools/perf/lib/evlist.c
 create mode 100644 tools/perf/lib/evsel.c
 create mode 100644 tools/perf/lib/include/internal/cpumap.h
 create mode 100644 tools/perf/lib/include/internal/evlist.h
 create mode 100644 tools/perf/lib/include/internal/evsel.h
 create mode 100644 tools/perf/lib/include/internal/lib.h
 create mode 100644 tools/perf/lib/include/internal/tests.h
 create mode 100644 tools/perf/lib/include/internal/threadmap.h
 rename tools/perf/{util => lib/include/internal}/xyarray.h (84%)
 create mode 100644 tools/perf/lib/include/perf/core.h
 create mode 100644 tools/perf/lib/include/perf/cpumap.h
 create mode 100644 tools/perf/lib/include/perf/evlist.h
 create mode 100644 tools/perf/lib/include/perf/evsel.h
 create mode 100644 tools/perf/lib/include/perf/threadmap.h
 create mode 100644 tools/perf/lib/internal.h
 create mode 100644 tools/perf/lib/lib.c
 create mode 100644 tools/perf/lib/libperf.map
 create mode 100644 tools/perf/lib/libperf.pc.template
 create mode 100644 tools/perf/lib/tests/Makefile
 create mode 100644 tools/perf/lib/tests/test-cpumap.c
 create mode 100644 tools/perf/lib/tests/test-evlist.c
 create mode 100644 tools/perf/lib/tests/test-evsel.c
 create mode 100644 tools/perf/lib/tests/test-threadmap.c
 create mode 100644 tools/perf/lib/threadmap.c
 create mode 100644 tools/perf/lib/xyarray.c
