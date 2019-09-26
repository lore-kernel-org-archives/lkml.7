Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BAAC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A65222CA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458099;
	bh=jTzPmZMElWxGPAcbmOqKxWJfeQ/gQBd4zebzT27wpRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ARSrqzsGr9e2/FJB8fo6Mo74LRepdPZ9qwLNsGHm9UL/6WwhBxJx+TDL3sKQkccHu
	 qYj93bgQtjvHIxrP76S/SK+itNyeUvxpM0IjWyRX7CXdNtrcLxGdThhelPNcqRYZte
	 QrrL4S8YeyQlEo90V8gho6o/pCBdZgYzTamDuIYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfIZAe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388885AbfIZAe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:56 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92463222C5;
        Thu, 26 Sep 2019 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458095;
        bh=jTzPmZMElWxGPAcbmOqKxWJfeQ/gQBd4zebzT27wpRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwOoRQTRhRMz9GSSARljDNb1o6skjwc2MKcxVK1jBThDcFHOWfh+DsLs5rArQ9Dws
         e4+SwU//PuWlkD5ZiOg+fNQYpN5TKRpyW73oS9T5TEv4Eqoz9BVFUByUi1Zy2WaME1
         7IL5u7TmDtQBXK1fQYXcWIhH8lZfygbishg/1JQw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/66] libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'
Date:   Wed, 25 Sep 2019 21:32:10 -0300
Message-Id: <20190926003244.13962-33-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'system_wide 'member from perf's evsel to libperf's perf_evsel.

Committer notes:

Added stdbool.h as we now use bool here.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c     |  4 ++--
 tools/perf/builtin-script.c             |  2 +-
 tools/perf/builtin-stat.c               |  4 ++--
 tools/perf/lib/include/internal/evsel.h |  2 ++
 tools/perf/tests/switch-tracking.c      |  6 +++---
 tools/perf/util/evlist.c                | 10 +++++-----
 tools/perf/util/evsel.c                 |  8 ++++----
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/stat.c                  |  2 +-
 10 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 34d7118bf390..1aa86a88884a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -422,7 +422,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
 	perf_evsel__set_sample_bit(evsel, CPU);
 	perf_evsel__set_sample_bit(evsel, TIME);
 
-	evsel->system_wide = true;
+	evsel->core.system_wide = true;
 	evsel->no_aux_samples = true;
 	evsel->immediate = true;
 
@@ -723,7 +723,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 				switch_evsel->core.attr.sample_period = 1;
 				switch_evsel->core.attr.context_switch = 1;
 
-				switch_evsel->system_wide = true;
+				switch_evsel->core.system_wide = true;
 				switch_evsel->no_aux_samples = true;
 				switch_evsel->immediate = true;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a17a9306bdf6..e7a49e2d7575 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1916,7 +1916,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	int cpu, thread;
 	static int header_printed;
 
-	if (counter->system_wide)
+	if (counter->core.system_wide)
 		nthreads = 1;
 
 	if (!header_printed) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f7d13326b830..0d55eb6bd6e2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -278,7 +278,7 @@ static int read_counter(struct evsel *counter, struct timespec *rs)
 	if (!counter->supported)
 		return -ENOENT;
 
-	if (counter->system_wide)
+	if (counter->core.system_wide)
 		nthreads = 1;
 
 	for (thread = 0; thread < nthreads; thread++) {
@@ -1671,7 +1671,7 @@ static void setup_system_wide(int forks)
 		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (!counter->system_wide)
+			if (!counter->core.system_wide)
 				return;
 		}
 
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 8b854d1c9b45..1bff789b0923 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/perf_event.h>
+#include <stdbool.h>
 
 struct perf_cpu_map;
 struct perf_thread_map;
@@ -18,6 +19,7 @@ struct perf_evsel {
 
 	/* parse modifier helper */
 	int			 nr_members;
+	bool			 system_wide;
 };
 
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index e5c3f2ee223a..de700aad1fed 100644
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
index 16d47a420bc2..16866533745c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -319,7 +319,7 @@ int perf_evlist__add_newtp(struct evlist *evlist,
 static int perf_evlist__nr_threads(struct evlist *evlist,
 				   struct evsel *evsel)
 {
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		return 1;
 	else
 		return perf_thread_map__nr(evlist->core.threads);
@@ -410,7 +410,7 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->system_wide)
+		if (evsel->core.system_wide)
 			nfds += nr_cpus;
 		else
 			nfds += nr_cpus * nr_threads;
@@ -536,7 +536,7 @@ static void perf_evlist__set_sid_idx(struct evlist *evlist,
 		sid->cpu = evlist->core.cpus->map[cpu];
 	else
 		sid->cpu = -1;
-	if (!evsel->system_wide && evlist->core.threads && thread >= 0)
+	if (!evsel->core.system_wide && evlist->core.threads && thread >= 0)
 		sid->tid = perf_thread_map__pid(evlist->core.threads, thread);
 	else
 		sid->tid = -1;
@@ -763,7 +763,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			mp->prot &= ~PROT_WRITE;
 		}
 
-		if (evsel->system_wide && thread)
+		if (evsel->core.system_wide && thread)
 			continue;
 
 		cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
@@ -793,7 +793,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		 * other events, so it should not need to be polled anyway.
 		 * Therefore don't add it for polling.
 		 */
-		if (!evsel->system_wide &&
+		if (!evsel->core.system_wide &&
 		    __perf_evlist__add_pollfd(evlist, fd, &maps[idx], revent) < 0) {
 			perf_mmap__put(&maps[idx]);
 			return -1;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 502bc3d50e0d..566c9413246c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1232,7 +1232,7 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	if (ncpus == 0 || nthreads == 0)
 		return 0;
 
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		nthreads = 1;
 
 	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
@@ -1663,7 +1663,7 @@ static bool ignore_missing_thread(struct evsel *evsel,
 		return false;
 
 	/* The system wide setup does not work with threads. */
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		return false;
 
 	/* The -ESRCH is perf event syscall errno for pid's not found. */
@@ -1772,7 +1772,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		threads = empty_thread_map;
 	}
 
-	if (evsel->system_wide)
+	if (evsel->core.system_wide)
 		nthreads = 1;
 	else
 		nthreads = threads->nr;
@@ -1819,7 +1819,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
 
-			if (!evsel->cgrp && !evsel->system_wide)
+			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
 			group_fd = get_group_fd(evsel, cpu, thread);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 74df298acb31..f757ff449a17 100644
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
index 9cf1371c90a3..d7aebe9b005d 100644
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
index fcd54342c04c..ebdd130557fb 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -336,7 +336,7 @@ static int process_counter_maps(struct perf_stat_config *config,
 	int ncpus = perf_evsel__nr_cpus(counter);
 	int cpu, thread;
 
-	if (counter->system_wide)
+	if (counter->core.system_wide)
 		nthreads = 1;
 
 	for (thread = 0; thread < nthreads; thread++) {
-- 
2.21.0

