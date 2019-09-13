Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C2EC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CDC20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381044;
	bh=LRuMOc4BS4iAH5UahoVLhjGbdSvEic7UMGCcH7NF1dc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EGlsriV9XAMIlE4wKV5JGPWWAcKVc7jzFLx4iSnoMc0h6oIhAxoHOJd8pyIZeNBaw
	 nuloon9ycjbHHqJoqoz65+y0GbwZKTP+cEhGavbcV9dlM74wkNIVAsfsVXsP9HTyN2
	 sulcsZ248cljUki7zHW+Tgce1Mz7mMw6xYVnMHbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbfIMNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390039AbfIMNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9AD8190C102;
        Fri, 13 Sep 2019 13:23:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A43CF5C219;
        Fri, 13 Sep 2019 13:23:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [RFC 00/73] libperf: Add sampling interface
Date:   Fri, 13 Sep 2019 15:22:42 +0200
Message-Id: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 13 Sep 2019 13:24:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending changes for exporting basic sampling interface
in libperf. It's now possible to use following code in
applications via libperf:

--- (example is without error checks for simplicity)

  struct perf_event_attr attr = {
          .type             = PERF_TYPE_TRACEPOINT,
          .sample_period    = 1,
          .wakeup_watermark = 1,
          .disabled         = 1,
  };
  /* ... setup attr */

  cpus = perf_cpu_map__new(NULL);

  evlist = perf_evlist__new();
  evsel  = perf_evsel__new(&attr);
  perf_evlist__add(evlist, evsel);

  perf_evlist__set_maps(evlist, cpus, NULL);

  err = perf_evlist__open(evlist);
  err = perf_evlist__mmap(evlist, 4);

  err = perf_evlist__enable(evlist);

  /* ... monitored area, plus all the other cpus */

  err = perf_evlist__disable(evlist);

  perf_evlist__for_each_mmap(evlist, map) {
          if (perf_mmap__read_init(map) < 0)
                  continue;

          while ((event = perf_mmap__read_event(map)) != NULL) {
                  perf_mmap__consume(map);
          }

          perf_mmap__read_done(map);
  }

  perf_evlist__delete(evlist);
  perf_cpu_map__put(cpus);

--- (end)

Nothing is carved in stone so far, the interface is exported
as is available in perf now and we can change it as we want.

New tests are added in test-evlist.c to do thread and cpu based
sampling.

All the functionality should not change, however there's considerable
mmap code rewrite, so would be great if guys could run your usual
workloads to see if all is fine.. so far so good in my tests ;-)

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/lib

thanks,
jirka


Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
Jiri Olsa (73):
      tools: Add missing stdio.h include to asm/bug.h header
      perf tests: Fix static build test
      perf tools: Rename struct perf_mmap to struct mmap
      perf tools: Rename perf_evlist__mmap() to evlist__mmap()
      perf tools: Rename perf_evlist__munmap() to evlist__munmap()
      perf tools: Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap()
      perf tools: Rename perf_evlist__exit() to evlist__exit()
      perf tools: Rename perf_evlist__purge() to evlist__purge()
      libperf: Link libapi.a in libperf.so
      libperf: Add perf_mmap struct
      libperf: Add mask to struct perf_mmap
      libperf: Add fd to struct perf_mmap
      libperf: Add cpu to struct perf_mmap
      libperf: Add refcnt to struct perf_mmap
      libperf: Add prev/start/end to struct perf_mmap
      libperf: Add overwrite to struct perf_mmap
      libperf: Add event_copy to struct perf_mmap
      libperf: Add flush to struct perf_mmap
      libperf: Move system_wide from struct evsel to struct perf_evsel
      libperf: Move nr_mmaps from struct evlist to struct perf_evlist
      libperf: Move mmap_len from struct evlist to struct perf_evlist
      libperf: Move pollfd from struct evlist to struct perf_evlist
      libperf: Move sample_id from struct evsel to struct perf_evsel
      libperf: Move id from struct evsel to struct perf_evsel
      libperf: Move ids from struct evsel to struct perf_evsel
      libperf: Move heads from struct evlist to struct perf_evlist
      libperf: Add perf_evsel__alloc_id/perf_evsel__free_id functions
      libperf: Add perf_evlist__first/last functions
      libperf: Add perf_evlist__read_format function
      libperf: Add perf_evlist__id_add function
      libperf: Add perf_evlist__id_add_fd function
      libperf: Move page_size into libperf
      libperf: Merge libperf_set_print in libperf_init
      libperf: Add libperf_init call to tests
      libperf: Add libperf dependency for tests targets
      libperf: Add perf_evlist__alloc_pollfd function
      libperf: Add perf_evlist__add_pollfd function
      libperf: Add perf_evlist__poll function
      libperf: Add perf_mmap__init function
      libperf: Add struct perf_mmap_param
      libperf: Add perf_mmap__mmap_len function
      libperf: Add perf_mmap__mmap function
      libperf: Add perf_mmap__get function
      libperf: Add perf_mmap__unmap function
      libperf: Add perf_mmap__put function
      libperf: Add perf_mmap__new function
      perf tools: Use perf_mmap way to detect aux mmap
      libperf: Add perf_mmap__consume function
      libperf: Add perf_mmap__read_init function
      libperf: Add perf_mmap__read_done function
      libperf: Add perf_mmap__read_event function
      libperf: Add perf_evlist__mmap/munmap function
      libperf: Add perf_evlist__mmap_ops function
      libperf: Add perf_evlist_mmap_ops::idx callback
      libperf: Add perf_evlist_mmap_ops::new callback
      libperf: Add perf_evlist_mmap_ops::mmap callback
      perf tools: Add perf_evlist__mmap_cb_idx function
      perf tools: Add perf_evlist__mmap_cb_new function
      perf tools: Add perf_evlist__mmap_cb_mmap function
      perf tools: Switch to libperf mmap interface
      libperf: Move pollfd allocation to libperf
      libperf: Add perf_evlist__exit function
      libperf: Add perf_evlist__purge function
      libperf: Call perf_evlist__munmap/close on perf_evlist__delete
      libperf: Add perf_evlist__filter_pollfd function
      libperf: Add perf_evlist__for_each_mmap function
      libperf: Link static tests with libapi.a
      libperf: Add _GNU_SOURCE define to compilation
      libperf: Add tests_mmap_thread test
      libperf: Add tests_mmap_cpus test
      libperf: Keep count of failed tests
      libperf: Do not export perf_evsel__init/perf_evlist__init
      libperf: Add pr_err macro

 tools/include/asm/bug.h                      |   1 +
 tools/perf/arch/arm/util/cs-etm.c            |   4 +-
 tools/perf/arch/arm64/util/arm-spe.c         |   4 +-
 tools/perf/arch/x86/tests/intel-cqm.c        |   4 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  19 +-
 tools/perf/arch/x86/util/intel-bts.c         |   6 +-
 tools/perf/arch/x86/util/intel-pt.c          |  14 +-
 tools/perf/builtin-kvm.c                     |  23 +-
 tools/perf/builtin-record.c                  |  90 ++---
 tools/perf/builtin-script.c                  |   4 +-
 tools/perf/builtin-stat.c                    |   6 +-
 tools/perf/builtin-top.c                     |  29 +-
 tools/perf/builtin-trace.c                   |  21 +-
 tools/perf/lib/Build                         |   1 +
 tools/perf/lib/Makefile                      |  42 ++-
 tools/perf/lib/core.c                        |  13 +-
 tools/perf/lib/evlist.c                      | 440 +++++++++++++++++++++++++
 tools/perf/lib/evsel.c                       |  30 ++
 tools/perf/lib/include/internal/evlist.h     |  74 +++++
 tools/perf/lib/include/internal/evsel.h      |  32 ++
 tools/perf/lib/include/internal/lib.h        |   2 +
 tools/perf/lib/include/internal/mmap.h       |  59 ++++
 tools/perf/lib/include/internal/tests.h      |  20 +-
 tools/perf/lib/include/perf/core.h           |   5 +-
 tools/perf/lib/include/perf/evlist.h         |  14 +-
 tools/perf/lib/include/perf/evsel.h          |   2 -
 tools/perf/lib/include/perf/mmap.h           |  14 +
 tools/perf/lib/internal.h                    |   5 +
 tools/perf/lib/lib.c                         |   2 +
 tools/perf/lib/libperf.map                   |  13 +-
 tools/perf/lib/mmap.c                        | 289 +++++++++++++++++
 tools/perf/lib/tests/Makefile                |   8 +-
 tools/perf/lib/tests/test-cpumap.c           |  10 +-
 tools/perf/lib/tests/test-evlist.c           | 228 ++++++++++++-
 tools/perf/lib/tests/test-evsel.c            |  10 +-
 tools/perf/lib/tests/test-threadmap.c        |  10 +-
 tools/perf/perf.c                            |  10 +-
 tools/perf/tests/backward-ring-buffer.c      |  17 +-
 tools/perf/tests/bpf.c                       |  15 +-
 tools/perf/tests/code-reading.c              |  19 +-
 tools/perf/tests/event-times.c               |  14 +-
 tools/perf/tests/event_update.c              |   6 +-
 tools/perf/tests/evsel-roundtrip-name.c      |   2 +-
 tools/perf/tests/hists_cumulate.c            |   2 +-
 tools/perf/tests/hists_link.c                |   4 +-
 tools/perf/tests/hists_output.c              |   2 +-
 tools/perf/tests/keep-tracking.c             |  19 +-
 tools/perf/tests/make                        |   2 +-
 tools/perf/tests/mmap-basic.c                |  13 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  19 +-
 tools/perf/tests/parse-events.c              | 116 +++----
 tools/perf/tests/perf-record.c               |  21 +-
 tools/perf/tests/sw-clock.c                  |  13 +-
 tools/perf/tests/switch-tracking.c           |  37 ++-
 tools/perf/tests/task-exit.c                 |  17 +-
 tools/perf/ui/browsers/hists.c               |   6 +-
 tools/perf/util/auxtrace.c                   |   6 +-
 tools/perf/util/auxtrace.h                   |   8 +-
 tools/perf/util/bpf-loader.c                 |   2 +-
 tools/perf/util/evlist.c                     | 469 +++++++--------------------
 tools/perf/util/evlist.h                     |  50 ++-
 tools/perf/util/evsel.c                      |  44 +--
 tools/perf/util/evsel.h                      |  29 --
 tools/perf/util/header.c                     |  38 +--
 tools/perf/util/intel-bts.c                  |   4 +-
 tools/perf/util/intel-pt.c                   |  10 +-
 tools/perf/util/jitdump.c                    |   2 +-
 tools/perf/util/mmap.c                       | 309 +++---------------
 tools/perf/util/mmap.h                       |  51 +--
 tools/perf/util/parse-events.c               |   6 +-
 tools/perf/util/python.c                     |  29 +-
 tools/perf/util/record.c                     |   6 +-
 tools/perf/util/session.c                    |  10 +-
 tools/perf/util/sort.c                       |   2 +-
 tools/perf/util/stat.c                       |   2 +-
 tools/perf/util/top.c                        |   2 +-
 tools/perf/util/util.h                       |   2 -
 77 files changed, 1862 insertions(+), 1121 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/mmap.h
 create mode 100644 tools/perf/lib/include/perf/mmap.h
 create mode 100644 tools/perf/lib/mmap.c
