Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C634220869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571309964;
	bh=HbMGPW7xsV/pi2roEWkQiW2gP4ML0BRXz+ct99k68zs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2KBZlkqJx8WtoTUF2qSNh+wsvolG81JafxRDXwMZExQgqQ/kTRMX1UXVg11fKp09X
	 +fl7pm6qjIoX9WOpns7iXFsvKiY9rHggszigFxkx+t9APZzcSG16DU9CBtMNLeDMfa
	 tXzchBWh6YTWlHDW4Gi0fEhSMwnFSsASJJ5Nd7xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409176AbfJQK7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbfJQK7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:59:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 135C6881363;
        Thu, 17 Oct 2019 10:59:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEC4A5D70D;
        Thu, 17 Oct 2019 10:59:18 +0000 (UTC)
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
        Michael Petlan <mpetlan@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCHv3 00/10] libperf: Add sampling interface (leftover)
Date:   Thu, 17 Oct 2019 12:59:08 +0200
Message-Id: <20191017105918.20873-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 17 Oct 2019 10:59:22 +0000 (UTC)
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

v3 changes:
  - changed mmap0 and mmap_ovw0 to mmap_first and mmap_ovw_first
  - rebased to latest perf/core
  - portion of patches already taken

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
Jiri Olsa (10):
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

 tools/perf/lib/Makefile                  |   2 ++
 tools/perf/lib/evlist.c                  |  71 ++++++++++++++++++++++++++++++++++++++---------------
 tools/perf/lib/include/internal/evlist.h |   3 +++
 tools/perf/lib/include/internal/evsel.h  |   1 +
 tools/perf/lib/include/internal/mmap.h   |   5 ++--
 tools/perf/lib/include/internal/tests.h  |  20 ++++++++++++---
 tools/perf/lib/include/perf/core.h       |   1 +
 tools/perf/lib/include/perf/evlist.h     |  10 +++++++-
 tools/perf/lib/include/perf/evsel.h      |   2 --
 tools/perf/lib/internal.h                |   3 +++
 tools/perf/lib/libperf.map               |   3 +--
 tools/perf/lib/mmap.c                    |   6 +++--
 tools/perf/lib/tests/Makefile            |   8 +++---
 tools/perf/lib/tests/test-cpumap.c       |   2 +-
 tools/perf/lib/tests/test-evlist.c       | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/lib/tests/test-evsel.c        |   2 +-
 tools/perf/lib/tests/test-threadmap.c    |   2 +-
 tools/perf/util/evlist.c                 |  29 +++++++++-------------
 18 files changed, 333 insertions(+), 55 deletions(-)
