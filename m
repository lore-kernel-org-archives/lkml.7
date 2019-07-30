Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD5C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8DC21841
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455651;
	bh=UIeL9OJN2YK36OthhLk7JLDBBQZSEffiKIhBBJDJyt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6/jWl1DgfrSAfVCoNJ7UuW7kkdzenR1Nif9XBUgUiqajImxgrhPx2NIybOSt3n0g
	 8A0ZsufBUqqO+57ltrKZ3M5kcIjU+9maUgxdqUBFk3uanpVKQtiuMlLCvDHKFtsq8p
	 L/lNcVyJTLbY4bzW8KdBHE9aQ3WfxctewKrUHUUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfG3DAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732462AbfG3DAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115E6217D4;
        Tue, 30 Jul 2019 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455647;
        bh=UIeL9OJN2YK36OthhLk7JLDBBQZSEffiKIhBBJDJyt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBaoe7nVo+4YGslNObzEn5Azl4SzbfzREqhQIPxSZY1DDgEerRThiGjNTPE8wV+t0
         x1hosgOfhg+yOCaA5CTRaSEQznlgdynXu9/81bNo3GCmPzZF6d0eYs20yHAqNpt/m+
         tk89hE6QHqLFmh5NY+znmN/AWLLlsD7Og1xF71Gk=
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
Subject: [PATCH 079/107] libperf: Add threads to struct perf_evsel
Date:   Mon, 29 Jul 2019 23:55:42 -0300
Message-Id: <20190730025610.22603-80-acme@kernel.org>
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

Move 'threads' from tools/perf's evsel to libperf's perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-53-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c                            | 2 +-
 tools/perf/builtin-script.c                            | 4 ++--
 tools/perf/lib/include/internal/evsel.h                | 2 ++
 tools/perf/util/evlist.c                               | 6 +++---
 tools/perf/util/evsel.c                                | 4 ++--
 tools/perf/util/evsel.h                                | 1 -
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/stat-display.c                         | 6 +++---
 tools/perf/util/stat.c                                 | 6 +++---
 9 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 090aaa2cf4b3..27ff899bed88 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -739,7 +739,7 @@ static int record__open(struct record *rec)
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
-		if (evsel__open(pos, pos->core.cpus, pos->threads) < 0) {
+		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
 			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 35f07dde5ad4..a787c5cb1331 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1899,7 +1899,7 @@ static struct scripting_ops	*scripting_ops;
 
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
-	int nthreads = thread_map__nr(counter->threads);
+	int nthreads = thread_map__nr(counter->core.threads);
 	int ncpus = perf_evsel__nr_cpus(counter);
 	int cpu, thread;
 	static int header_printed;
@@ -1921,7 +1921,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
 				counter->core.cpus->map[cpu],
-				thread_map__pid(counter->threads, thread),
+				thread_map__pid(counter->core.threads, thread),
 				counts->val,
 				counts->ena,
 				counts->run,
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index d15d8ccfa3dc..8340fd883a3d 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -6,12 +6,14 @@
 #include <linux/perf_event.h>
 
 struct perf_cpu_map;
+struct perf_thread_map;
 
 struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
 	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*own_cpus;
+	struct perf_thread_map	*threads;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d203305ac187..5ce8fc730453 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -167,8 +167,8 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 		evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
 	}
 
-	perf_thread_map__put(evsel->threads);
-	evsel->threads = perf_thread_map__get(evlist->threads);
+	perf_thread_map__put(evsel->core.threads);
+	evsel->core.threads = perf_thread_map__get(evlist->threads);
 }
 
 static void perf_evlist__propagate_maps(struct evlist *evlist)
@@ -1407,7 +1407,7 @@ int evlist__open(struct evlist *evlist)
 	perf_evlist__update_id_pos(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		err = evsel__open(evsel, evsel->core.cpus, evsel->threads);
+		err = evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 		if (err < 0)
 			goto out_err;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c5f6ee6d5f3b..f7758ce0dd5c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1327,7 +1327,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->core.cpus);
 	perf_cpu_map__put(evsel->core.own_cpus);
-	perf_thread_map__put(evsel->threads);
+	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	perf_evsel__object.fini(evsel);
@@ -3065,7 +3065,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus = evsel->core.cpus;
-	struct perf_thread_map *threads = evsel->threads;
+	struct perf_thread_map *threads = evsel->core.threads;
 
 	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
 		return -ENOMEM;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2eff837f10bd..57b5523b480c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -123,7 +123,6 @@ struct evsel {
 	u64			db_id;
 	struct cgroup		*cgrp;
 	void			*handler;
-	struct perf_thread_map *threads;
 	unsigned int		sample_size;
 	int			id_pos;
 	int			is_pos;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c5f520e0885b..32c17a727450 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1392,7 +1392,7 @@ process_stat(struct evsel *counter, int cpu, int thread, u64 tstamp,
 static void python_process_stat(struct perf_stat_config *config,
 				struct evsel *counter, u64 tstamp)
 {
-	struct perf_thread_map *threads = counter->threads;
+	struct perf_thread_map *threads = counter->core.threads;
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e84f8063c2db..7c938135398b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -116,9 +116,9 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
 			config->csv_output ? 0 : 16,
-			perf_thread_map__comm(evsel->threads, id),
+			perf_thread_map__comm(evsel->core.threads, id),
 			config->csv_output ? 0 : -8,
-			thread_map__pid(evsel->threads, id),
+			thread_map__pid(evsel->core.threads, id),
 			config->csv_sep);
 		break;
 	case AGGR_GLOBAL:
@@ -744,7 +744,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
 			      struct evsel *counter, char *prefix)
 {
 	FILE *output = config->output;
-	int nthreads = thread_map__nr(counter->threads);
+	int nthreads = thread_map__nr(counter->core.threads);
 	int ncpus = cpu_map__nr(counter->core.cpus);
 	int thread, sorted_threads, id;
 	struct perf_aggr_thread_value *buf;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 632bf72cf780..1e351462ca49 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -158,7 +158,7 @@ static void perf_evsel__free_prev_raw_counts(struct evsel *evsel)
 static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
 	int ncpus = perf_evsel__nr_cpus(evsel);
-	int nthreads = thread_map__nr(evsel->threads);
+	int nthreads = thread_map__nr(evsel->core.threads);
 
 	if (perf_evsel__alloc_stat_priv(evsel) < 0 ||
 	    perf_evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
@@ -308,7 +308,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 static int process_counter_maps(struct perf_stat_config *config,
 				struct evsel *counter)
 {
-	int nthreads = thread_map__nr(counter->threads);
+	int nthreads = thread_map__nr(counter->core.threads);
 	int ncpus = perf_evsel__nr_cpus(counter);
 	int cpu, thread;
 
@@ -485,7 +485,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	if (target__has_cpu(target) && !target__has_per_thread(target))
 		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
 
-	return perf_evsel__open_per_thread(evsel, evsel->threads);
+	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
 
 int perf_stat_synthesize_config(struct perf_stat_config *config,
-- 
2.21.0

