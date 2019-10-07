Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AEAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3983D205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452830;
	bh=EfMiOEE4IAIxoAwWtclbXz0CLdE2kUVVZzE4sinvRcY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dx36ofbd52SmAwv2pa9UJY9xxAqSuACA54EuBKjgGKjxpOpLJlJX47dgnZAfW6E9C
	 wUBWsaaXLQr79Jj4eOFR+fJGq1H+O/abnmptep1odixAPjwD+CHxJZShPp5yJPdxyo
	 fCv4HcrRAh2DRnv/cOPF6DfG3loI2qY025vhZoZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfJGMxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41CDA80F79;
        Mon,  7 Oct 2019 12:53:48 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEBA25D9CC;
        Mon,  7 Oct 2019 12:53:44 +0000 (UTC)
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
Subject: [PATCHv2 00/36] libperf: Add sampling interface
Date:   Mon,  7 Oct 2019 14:53:08 +0200
Message-Id: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 07 Oct 2019 12:53:48 +0000 (UTC)
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
mmap code rewrite.

Now we have perf_evlist__mmap_ops called by both perf and libperf
mmaps functions with specific 'struct perf_evlist_mmap_ops'
callbacks:

  - get  - to get mmap object, both libperf and perf use different
           objects, because perf needs to carry more data for aio,
           compression and auxtrace
  - mmap - to actually mmap the object, it's simple mmap for libperf,
           but more work for perf wrt aio, compression and auxtrace
  - idx  - callback to get current IDs, used only in perf for auxtrace
           setup


It would be great if guys could run your usual workloads to see if all
is fine.. so far so good in my tests ;-)


It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/lib

v2 changes:
  - rebased to latest perf/core
  - portion of patches already taken
  - explained mmap refcnt management in following patch changelog:
    libperf: Centralize map refcnt setting

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
Jiri Olsa (36):
      libperf: Add perf_mmap__init() function
      libperf: Add 'struct perf_mmap_param'
      libperf: Add perf_mmap__mmap_len() function
      libperf: Add perf_mmap__mmap() function
      libperf: Add perf_mmap__get() function
      libperf: Add perf_mmap__unmap() function
      libperf: Add perf_mmap__put() function
      perf tools: Use perf_mmap way to detect aux mmap
      libperf: Add perf_mmap__consume() function
      libperf: Add perf_mmap__read_init() function
      libperf: Add perf_mmap__read_done() function
      libperf: Add perf_mmap__read_event() function
      libperf: Add perf_evlist__mmap()/munmap() functions
      libperf: Add perf_evlist__mmap_ops function
      libperf: Add perf_evlist_mmap_ops::idx callback
      libperf: Add perf_evlist_mmap_ops::get callback
      libperf: Add perf_evlist_mmap_ops::mmap callback
      perf tools: Add perf_evlist__mmap_cb_idx function
      perf tools: Add perf_evlist__mmap_cb_get function
      perf tools: Add perf_evlist__mmap_cb_mmap function
      perf tools: Switch to libperf mmap interface
      libperf: Centralize map refcnt setting
      libperf: Move pollfd allocation to libperf
      libperf: Add perf_evlist__exit function
      libperf: Add perf_evlist__purge function
      libperf: Add perf_evlist__filter_pollfd function
      libperf: Add perf_evlist__for_each_mmap function
      libperf: Move mmap allocation to perf_evlist__mmap_ops::get
      libperf: Move mask setup to perf_evlist__mmap_ops function
      libperf: Link static tests with libapi.a
      libperf: Add _GNU_SOURCE define to compilation
      libperf: Add tests_mmap_thread test
      libperf: Add tests_mmap_cpus test
      libperf: Keep count of failed tests
      libperf: Do not export perf_evsel__init/perf_evlist__init
      libperf: Add pr_err macro

 tools/perf/arch/x86/tests/perf-time-to-tsc.c |   9 ++--
 tools/perf/builtin-kvm.c                     |  11 ++---
 tools/perf/builtin-record.c                  |  10 ++---
 tools/perf/builtin-top.c                     |   9 ++--
 tools/perf/builtin-trace.c                   |   9 ++--
 tools/perf/lib/Build                         |   1 +
 tools/perf/lib/Makefile                      |   7 +++-
 tools/perf/lib/evlist.c                      | 357 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h     |  43 ++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h      |   1 +
 tools/perf/lib/include/internal/mmap.h       |  46 ++++++++++++++++-----
 tools/perf/lib/include/internal/tests.h      |  20 +++++++--
 tools/perf/lib/include/perf/core.h           |   3 ++
 tools/perf/lib/include/perf/evlist.h         |  15 ++++++-
 tools/perf/lib/include/perf/evsel.h          |   2 -
 tools/perf/lib/include/perf/mmap.h           |  14 +++++++
 tools/perf/lib/internal.h                    |   5 +++
 tools/perf/lib/libperf.map                   |  10 ++++-
 tools/perf/lib/mmap.c                        | 274 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/lib/tests/Makefile                |   8 ++--
 tools/perf/lib/tests/test-cpumap.c           |   2 +-
 tools/perf/lib/tests/test-evlist.c           | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/lib/tests/test-evsel.c            |   2 +-
 tools/perf/lib/tests/test-threadmap.c        |   2 +-
 tools/perf/tests/backward-ring-buffer.c      |   7 ++--
 tools/perf/tests/bpf.c                       |   7 ++--
 tools/perf/tests/code-reading.c              |   9 ++--
 tools/perf/tests/keep-tracking.c             |   9 ++--
 tools/perf/tests/mmap-basic.c                |   9 ++--
 tools/perf/tests/openat-syscall-tp-fields.c  |   9 ++--
 tools/perf/tests/perf-record.c               |   9 ++--
 tools/perf/tests/sw-clock.c                  |   9 ++--
 tools/perf/tests/switch-tracking.c           |   9 ++--
 tools/perf/tests/task-exit.c                 |   9 ++--
 tools/perf/util/evlist.c                     | 256 +++++++++++++++++++++++++++---------------------------------------------------------------------------------------
 tools/perf/util/mmap.c                       | 260 +++++++-------------------------------------------------------------------------------------------------------------
 tools/perf/util/mmap.h                       |  28 +++----------
 tools/perf/util/python.c                     |   7 ++--
 38 files changed, 1161 insertions(+), 554 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/mmap.h
 create mode 100644 tools/perf/lib/mmap.c
