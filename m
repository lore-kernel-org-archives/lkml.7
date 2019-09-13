Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD6C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77403206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381313;
	bh=VK5Rm25wOZsjZRaKlGNuxvI1CRknXQN8lcLda49E7D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DctJd9O1D75tJYecth1DdNQGObahUkzCwV79qFUsvjpikzLIgH+rvLfFg81oWGJYx
	 IWZ0Nf0ZI6NP/KA72Br7Y6xb7trPH7ZHBxttleeCQ/KdrSzubSlN/UAdLkfv2V/TqC
	 dDe/5cBQeokr9zv2zs1yL6I5pPkN+Azp8iwYHUXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfIMNYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbfIMNYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 205DA18CB8E7;
        Fri, 13 Sep 2019 13:24:47 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2F115C1D4;
        Fri, 13 Sep 2019 13:24:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 19/73] libperf: Move system_wide from struct evsel to struct perf_evsel
Date:   Fri, 13 Sep 2019 15:23:01 +0200
Message-Id: <20190913132355.21634-20-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 13 Sep 2019 13:24:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the system_wide member from perf's evsel to libperf's perf_evsel.

Link: http://lkml.kernel.org/n/tip-it7hq5v16y44z220vas1kf8p@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c     |  4 ++--
 tools/perf/builtin-script.c             |  2 +-
 tools/perf/builtin-stat.c               |  4 ++--
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/tests/switch-tracking.c      |  6 +++---
 tools/perf/util/evlist.c                | 10 +++++-----
 tools/perf/util/evsel.c                 |  8 ++++----
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/stat.c                  |  2 +-
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index c0a7535cfd0e..1ae050c4045b 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -421,7 +421,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
 	perf_evsel__set_sample_bit(evsel, CPU);
 	perf_evsel__set_sample_bit(evsel, TIME);
 
-	evsel->system_wide = true;
+	evsel->core.system_wide = true;
 	evsel->no_aux_samples = true;
 	evsel->immediate = true;
 
@@ -722,7 +722,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 				switch_evsel->core.attr.sample_period = 1;
 				switch_evsel->core.attr.context_switch = 1;
 
-				switch_evsel->system_wide = true;
+				switch_evsel->core.system_wide = true;
 				switch_evsel->no_aux_samples = true;
 				switch_evsel->immediate = true;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e079b34201f2..c602793d5483 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1915,7 +1915,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	int cpu, thread;
 	static int header_printed;
 
-	if (counter->system_wide)
+	if (counter->core.system_wide)
 		nthreads = 1;
 
 	if (!header_printed) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7e17bf9f700a..35897048ba53 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -276,7 +276,7 @@ static int read_counter(struct evsel *counter, struct timespec *rs)
 	if (!counter->supported)
 		return -ENOENT;
 
-	if (counter->system_wide)
+	if (counter->core.system_wide)
 		nthreads = 1;
 
 	for (thread = 0; thread < nthreads; thread++) {
@@ -1681,7 +1681,7 @@ static void setup_system_wide(int forks)
 		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (!counter->system_wide)
+			if (!counter->core.system_wide)
 				return;
 		}
 
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 8b854d1c9b45..220cb2e2b54e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -18,6 +18,7 @@ struct perf_evsel {
 
 	/* parse modifier helper */
 	int			 nr_members;
+	bool			 system_wide;
 };
 
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index f6c2c026988a..01bfb087ce22 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -144,7 +144,7 @@ static int process_sample_event(struct evlist *evlist,
 			return err;
 		/*
 		 * Check for no missing sched_switch events i.e. that the
-		 * evsel->system_wide flag has worked.
+		 * evsel->core.system_wide flag has worked.
 		 */
 		if (switch_tracking->tids[cpu] != -1 &&
 		    switch_tracking->tids[cpu] != prev_tid) {
@@ -316,7 +316,7 @@ static int process_events(struct evlist *evlist,
  *
  * This function implements a test that checks that sched_switch events and
  * tracking events can be recorded for a workload (current process) using the
- * evsel->system_wide and evsel->tracking flags (respectively) with other events
+ * evsel->core.system_wide and evsel->tracking flags (respectively) with other events
  * sometimes enabled or disabled.
  */
 int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -396,7 +396,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	perf_evsel__set_sample_bit(switch_evsel, CPU);
 	perf_evsel__set_sample_bit(switch_evsel, TIME);
 
-	switch_evsel->system_wide = true;
+	switch_evsel->core.system_wide = true;
 	switch_evsel->no_aux_samples = true;
 	switch_evsel->immediate = true;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 98827df5a40a..0ffa1e9b6243 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -318,7 +318,7 @@ int perf_evlist__add_newtp(struct evlist *evlist,
 static int perf_evlist__nr_threads(struct evlist *evlist,
 				   struct evsel *evsel)
 {
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		return 1;
 	else
 		return perf_thread_map__nr(evlist->core.threads);
@@ -409,7 +409,7 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->system_wide)
+		if (evsel->core.system_wide)
 			nfds += nr_cpus;
 		else
 			nfds += nr_cpus * nr_threads;
@@ -535,7 +535,7 @@ static void perf_evlist__set_sid_idx(struct evlist *evlist,
 		sid->cpu = evlist->core.cpus->map[cpu];
 	else
 		sid->cpu = -1;
-	if (!evsel->system_wide && evlist->core.threads && thread >= 0)
+	if (!evsel->core.system_wide && evlist->core.threads && thread >= 0)
 		sid->tid = perf_thread_map__pid(evlist->core.threads, thread);
 	else
 		sid->tid = -1;
@@ -762,7 +762,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			mp->prot &= ~PROT_WRITE;
 		}
 
-		if (evsel->system_wide && thread)
+		if (evsel->core.system_wide && thread)
 			continue;
 
 		cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
@@ -792,7 +792,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		 * other events, so it should not need to be polled anyway.
 		 * Therefore don't add it for polling.
 		 */
-		if (!evsel->system_wide &&
+		if (!evsel->core.system_wide &&
 		    __perf_evlist__add_pollfd(evlist, fd, &maps[idx], revent) < 0) {
 			perf_mmap__put(&maps[idx]);
 			return -1;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 85825384f9e8..9dcee5a8875e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1231,7 +1231,7 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	if (ncpus == 0 || nthreads == 0)
 		return 0;
 
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		nthreads = 1;
 
 	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
@@ -1662,7 +1662,7 @@ static bool ignore_missing_thread(struct evsel *evsel,
 		return false;
 
 	/* The system wide setup does not work with threads. */
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		return false;
 
 	/* The -ESRCH is perf event syscall errno for pid's not found. */
@@ -1771,7 +1771,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		threads = empty_thread_map;
 	}
 
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		nthreads = 1;
 	else
 		nthreads = threads->nr;
@@ -1818,7 +1818,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
 
-			if (!evsel->cgrp && !evsel->system_wide)
+			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
 			group_fd = get_group_fd(evsel, cpu, thread);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68321d10eb2d..eb4d03cd0b17 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -146,7 +146,6 @@ struct evsel {
 	bool 			disabled;
 	bool			no_aux_samples;
 	bool			immediate;
-	bool			system_wide;
 	bool			tracking;
 	bool			per_pkg;
 	bool			precise_max;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5ec21d21113c..403fb5e05108 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -335,7 +335,7 @@ __add_event(struct list_head *list, int *idx,
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
-	evsel->system_wide = pmu ? pmu->is_uncore : false;
+	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
 	if (name)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8f1ea27f976f..ef02d8b709ff 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -318,7 +318,7 @@ static int process_counter_maps(struct perf_stat_config *config,
 	int ncpus = perf_evsel__nr_cpus(counter);
 	int cpu, thread;
 
-	if (counter->system_wide)
+	if (counter->core.system_wide)
 		nthreads = 1;
 
 	for (thread = 0; thread < nthreads; thread++) {
-- 
2.21.0

