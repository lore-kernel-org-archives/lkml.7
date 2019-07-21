Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652A6C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3043F2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708658;
	bh=EAdQFaAOLjP1rdVsEwJ0P2elQofDEAVv9Imlg3c9lAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0SzcagCDEMVPutWN79X/v6MfHM59OSq+fmEKpjYLrs6f9OG8u99v/JYdWPPPO+Rbz
	 qZIwOK1nBzLImW9MvAqMrzDvMJtRVDQjGx3y4brsFTtnqxH1mHh1wD9LjFC733LDxG
	 2uYElbk1ZEFCSbB3PNUh59IgQadUkKbrqG9pGmLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGULa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfGULaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67368300895B;
        Sun, 21 Jul 2019 11:30:54 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 373DA5D9D3;
        Sun, 21 Jul 2019 11:30:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 50/79] libperf: Add cpus to struct perf_evsel
Date:   Sun, 21 Jul 2019 13:24:37 +0200
Message-Id: <20190721112506.12306-51-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 21 Jul 2019 11:30:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving cpus from evsel into perf_evsel struct.

Link: http://lkml.kernel.org/n/tip-thply1bxow2zmjs48on3ljc2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index fb5abd08e366..58f041263bd8 100644
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

