Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96972C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F2F2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XlyY6FMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfG3So5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:44:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbfG3So5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:44:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIijeg3334516
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:44:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIijeg3334516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512285;
        bh=BNMSP7P24XwlLcqMH3XbRFR8VX5/cKmAfqSVdJAhPCM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XlyY6FMXZm2EWPMmsVWPNaeRFkDHH+b8RmZhvTPH4dWIge5gT3x5FzoyoONAG8rA5
         nhfzcb0asP2Y7M4MfoWwU+AL98sFw/k1z6BauEP3v7EWMWJEsJ+OMSuEnSLWd8KSjQ
         D2BdfR3gmbh5ZhLhTNzwUEST4U/N+qlO/8XtgQaKI3z6N9QPuOCF5kFNettnMxKw4g
         UMfgWZtrE00B2yXK8Mpx4RrDB4rF4T2k54RUWb2KDhJ5z7CaStCqCh9EhBL4x6as6E
         HtJ01dIpu6CO0pIP4SmhT+3qskBriLp4u5HNiLIHKgU8KDLkUmrEQd6jJoRvS5VQRv
         E0g9EJPsrm9NA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIii113334513;
        Tue, 30 Jul 2019 11:44:44 -0700
Date:   Tue, 30 Jul 2019 11:44:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d400bd3abf2cc68df2df32047d3533faf690f404@git.kernel.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, mpetlan@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          tglx@linutronix.de, mingo@kernel.org,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org, acme@redhat.com, mpetlan@redhat.com,
          peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190721112506.12306-51-jolsa@kernel.org>
References: <20190721112506.12306-51-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add cpus to struct perf_evsel
Git-Commit-ID: d400bd3abf2cc68df2df32047d3533faf690f404
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d400bd3abf2cc68df2df32047d3533faf690f404
Gitweb:     https://git.kernel.org/tip/d400bd3abf2cc68df2df32047d3533faf690f404
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:37 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add cpus to struct perf_evsel

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
 tools/perf/builtin-record.c                            |  2 +-
 tools/perf/builtin-script.c                            |  2 +-
 tools/perf/lib/include/internal/evsel.h                |  7 +++++--
 tools/perf/util/evlist.c                               | 14 +++++++-------
 tools/perf/util/evsel.c                                |  4 ++--
 tools/perf/util/evsel.h                                |  3 +--
 tools/perf/util/parse-events.c                         |  2 +-
 tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/stat-display.c                         |  2 +-
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
 
