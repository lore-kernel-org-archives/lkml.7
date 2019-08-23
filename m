Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D80C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EAD22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394520AbfHWMWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:22:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbfHWMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18ZX-0001gU-0o; Fri, 23 Aug 2019 14:21:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 590361C089A;
        Fri, 23 Aug 2019 14:21:38 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:38 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Use perf_cpu_map__nr instead of cpu_map__nr
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-6e0guy75clis7nm0xpuz9fga@git.kernel.org>
References: <tip-6e0guy75clis7nm0xpuz9fga@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656289827.31538.8523725469520885256.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6549cd8f2cc2cdf7e107fbbc3a68ecefb774bb2f
Gitweb:        https://git.kernel.org/tip/6549cd8f2cc2cdf7e107fbbc3a68ecefb774bb2f
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 22 Aug 2019 13:11:38 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 11:14:54 -03:00

perf tools: Use perf_cpu_map__nr instead of cpu_map__nr

Switch the rest of the perf code to use libperf's perf_cpu_map__nr(),
which is the same as current cpu_map__nr() and remove the cpu_map__nr()
function.

Link: http://lkml.kernel.org/n/tip-6e0guy75clis7nm0xpuz9fga@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190822111141.25823-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c |  4 ++--
 tools/perf/util/cpumap.h          |  5 -----
 tools/perf/util/evlist.c          | 10 +++++-----
 tools/perf/util/mmap.c            |  2 +-
 tools/perf/util/stat-display.c    |  2 +-
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5cb07e8..c786ab0 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -653,7 +653,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 		cpu_map = online_cpus;
 	} else {
 		/* Make sure all specified CPUs are online */
-		for (i = 0; i < cpu_map__nr(event_cpus); i++) {
+		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
 			if (cpu_map__has(event_cpus, i) &&
 			    !cpu_map__has(online_cpus, i))
 				return -EINVAL;
@@ -662,7 +662,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 		cpu_map = event_cpus;
 	}
 
-	nr_cpu = cpu_map__nr(cpu_map);
+	nr_cpu = perf_cpu_map__nr(cpu_map);
 	/* Get PMU type as dynamically assigned by the core */
 	type = cs_etm_pmu->type;
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a3d27f4..77f85e9 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -49,11 +49,6 @@ static inline int cpu_map__id_to_cpu(int id)
 	return id & 0xffff;
 }
 
-static inline int cpu_map__nr(const struct perf_cpu_map *map)
-{
-	return map ? map->nr : 1;
-}
-
 static inline bool cpu_map__empty(const struct perf_cpu_map *map)
 {
 	return map ? map->map[0] == -1 : true;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c4489a1..15d1046 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -370,7 +370,7 @@ static int perf_evlist__enable_event_thread(struct evlist *evlist,
 					    int thread)
 {
 	int cpu;
-	int nr_cpus = cpu_map__nr(evlist->core.cpus);
+	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
 
 	if (!evsel->core.fd)
 		return -EINVAL;
@@ -396,7 +396,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 
 int perf_evlist__alloc_pollfd(struct evlist *evlist)
 {
-	int nr_cpus = cpu_map__nr(evlist->core.cpus);
+	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
 	int nr_threads = thread_map__nr(evlist->core.threads);
 	int nfds = 0;
 	struct evsel *evsel;
@@ -692,7 +692,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct perf_mmap *map;
 
-	evlist->nr_mmaps = cpu_map__nr(evlist->core.cpus);
+	evlist->nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
 	if (cpu_map__empty(evlist->core.cpus))
 		evlist->nr_mmaps = thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
@@ -807,7 +807,7 @@ static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
 	int cpu, thread;
-	int nr_cpus = cpu_map__nr(evlist->core.cpus);
+	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
 	int nr_threads = thread_map__nr(evlist->core.threads);
 
 	pr_debug2("perf event ring buffer mmapped per cpu\n");
@@ -1014,7 +1014,7 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
 		    evsel->sample_id == NULL &&
-		    perf_evsel__alloc_id(evsel, cpu_map__nr(cpus), threads->nr) < 0)
+		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
 			return -ENOMEM;
 	}
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 42a5971..5f3532e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -331,7 +331,7 @@ static void build_node_mask(int node, cpu_set_t *mask)
 	if (!cpu_map)
 		return;
 
-	nr_cpus = cpu_map__nr(cpu_map);
+	nr_cpus = perf_cpu_map__nr(cpu_map);
 	for (c = 0; c < nr_cpus; c++) {
 		cpu = cpu_map->map[c]; /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f7b39f4..3df0e39 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -745,7 +745,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
 {
 	FILE *output = config->output;
 	int nthreads = thread_map__nr(counter->core.threads);
-	int ncpus = cpu_map__nr(counter->core.cpus);
+	int ncpus = perf_cpu_map__nr(counter->core.cpus);
 	int thread, sorted_threads, id;
 	struct perf_aggr_thread_value *buf;
 
