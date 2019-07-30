Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94521C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F458217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455645;
	bh=sD340AehhHgQ4QXiWsvpbHRs859D2zfKoYGa+or8oyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LT2GX/tZchj+rfMzycY8OfzHFhKGpALdIP/n7oGlB+NZrEW46h3JxKnIj7qLZXqTI
	 e9G9zsERNx6GS59o9mdFv2ajs6/mVkekkPND7tmBHG7R50eg8HR2wKmDtHv7MoDimR
	 20UvKSkRSDsdvWRtnKREZIH8SACv9WpBZiTNp4Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfG3DAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfG3DAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D23206DD;
        Tue, 30 Jul 2019 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455640;
        bh=sD340AehhHgQ4QXiWsvpbHRs859D2zfKoYGa+or8oyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dKFVQtHGt8GTCfHNnDsrH7BPvG9oCg2SBt2UwM7OUebnuiDQI7Ip0QHjzGt9LBj5
         qQZQyfSrw/gTn/iPhKifFC78YQQNUsWn60RISddUzRyyxKe6mmQZJ33F3YLneg0rDH
         AbznR2s11BGbd6i10mv/hjCJC9NYfXzarbRHEwsI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 077/107] libperf: Add cpus to struct perf_evsel
Date:   Mon, 29 Jul 2019 23:55:40 -0300
Message-Id: <20190730025610.22603-78-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Mov the 'cpus' field from tools/perf's evsel to libperf's perf_evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-51-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c                        |  2 +-
 tools/perf/builtin-script.c                        |  2 +-
 tools/perf/lib/include/internal/evsel.h            |  7 +++++--
 tools/perf/util/evlist.c                           | 14 +++++++-------
 tools/perf/util/evsel.c                            |  4 ++--
 tools/perf/util/evsel.h                            |  3 +--
 tools/perf/util/parse-events.c                     |  2 +-
 .../util/scripting-engines/trace-event-python.c    |  2 +-
 tools/perf/util/stat-display.c                     |  2 +-
 9 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b7d2c27c4164..090aaa2cf4b3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -739,7 +739,7 @@ static int record__open(struct record *rec)
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
-		if (evsel__open(pos, pos->cpus, pos->threads) < 0) {
+		if (evsel__open(pos, pos->core.cpus, pos->threads) < 0) {
 			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69133b35bbc1..35f07dde5ad4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1920,7 +1920,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 			counts = perf_counts(counter->counts, cpu, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
-				counter->cpus->map[cpu],
+				counter->core.cpus->map[cpu],
 				thread_map__pid(counter->threads, thread),
 				counts->val,
 				counts->ena,
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index c2e0bd104c94..b2c76e1a6244 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -5,9 +5,12 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 
+struct perf_cpu_map;
+
 struct perf_evsel {
-	struct list_head	node;
-	struct perf_event_attr	attr;
+	struct list_head	 node;
+	struct perf_event_attr	 attr;
+	struct perf_cpu_map	*cpus;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 67c67e9a38cd..713968130d1d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -160,11 +160,11 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 * keep it, if there's no target cpu list defined.
 	 */
 	if (!evsel->own_cpus || evlist->has_user_cpus) {
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evlist->cpus);
-	} else if (evsel->cpus != evsel->own_cpus) {
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
+		perf_cpu_map__put(evsel->core.cpus);
+		evsel->core.cpus = perf_cpu_map__get(evlist->cpus);
+	} else if (evsel->core.cpus != evsel->own_cpus) {
+		perf_cpu_map__put(evsel->core.cpus);
+		evsel->core.cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
 	perf_thread_map__put(evsel->threads);
@@ -786,7 +786,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (evsel->system_wide && thread)
 			continue;
 
-		cpu = cpu_map__idx(evsel->cpus, evlist_cpu);
+		cpu = cpu_map__idx(evsel->core.cpus, evlist_cpu);
 		if (cpu == -1)
 			continue;
 
@@ -1407,7 +1407,7 @@ int evlist__open(struct evlist *evlist)
 	perf_evlist__update_id_pos(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		err = evsel__open(evsel, evsel->cpus, evsel->threads);
+		err = evsel__open(evsel, evsel->core.cpus, evsel->threads);
 		if (err < 0)
 			goto out_err;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 089582e644d7..651f66ee902e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1325,7 +1325,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
-	perf_cpu_map__put(evsel->cpus);
+	perf_cpu_map__put(evsel->core.cpus);
 	perf_cpu_map__put(evsel->own_cpus);
 	perf_thread_map__put(evsel->threads);
 	zfree(&evsel->group_name);
@@ -3064,7 +3064,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 {
-	struct perf_cpu_map *cpus = evsel->cpus;
+	struct perf_cpu_map *cpus = evsel->core.cpus;
 	struct perf_thread_map *threads = evsel->threads;
 
 	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 43f66158de3b..8ece5edf65ac 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -123,7 +123,6 @@ struct evsel {
 	u64			db_id;
 	struct cgroup		*cgrp;
 	void			*handler;
-	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map *threads;
 	unsigned int		sample_size;
@@ -198,7 +197,7 @@ struct record_opts;
 
 static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
-	return evsel->cpus;
+	return evsel->core.cpus;
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index db2460d6b625..a27771eca9c2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -333,7 +333,7 @@ __add_event(struct list_head *list, int *idx,
 		return NULL;
 
 	(*idx)++;
-	evsel->cpus        = perf_cpu_map__get(cpus);
+	evsel->core.cpus   = perf_cpu_map__get(cpus);
 	evsel->own_cpus    = perf_cpu_map__get(cpus);
 	evsel->system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 78b40c1d688e..c5f520e0885b 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1393,7 +1393,7 @@ static void python_process_stat(struct perf_stat_config *config,
 				struct evsel *counter, u64 tstamp)
 {
 	struct perf_thread_map *threads = counter->threads;
-	struct perf_cpu_map *cpus = counter->cpus;
+	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
 	if (config->aggr_mode == AGGR_GLOBAL) {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 99bda99a1b2d..e84f8063c2db 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -745,7 +745,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
 {
 	FILE *output = config->output;
 	int nthreads = thread_map__nr(counter->threads);
-	int ncpus = cpu_map__nr(counter->cpus);
+	int ncpus = cpu_map__nr(counter->core.cpus);
 	int thread, sorted_threads, id;
 	struct perf_aggr_thread_value *buf;
 
-- 
2.21.0

