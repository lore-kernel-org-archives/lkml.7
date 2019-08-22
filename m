Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D41C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C12422CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566472311;
	bh=4KpdvQhO1M/moOswAbFXH7Hua/ZWM1K7Oh/iYUwGHwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOawhxE5K90GUNg2l+eQdiT9D7YibpoHplFKpHgoq9bUGOd3TQlLopOdAa+vYIaEI
	 hJQRwLuQ0FMjTsNWe9BmusuJC6JDZEioQ09ONrb4S1FddT7J02eGNk1a96YC35XYdz
	 Tf46+sOuDW7LVZ1yiHHv8EpP1vfym6v7GtMRoo4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbfHVLLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:11:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbfHVLLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:11:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B134F7FDCD;
        Thu, 22 Aug 2019 11:11:47 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16D171001B17;
        Thu, 22 Aug 2019 11:11:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 2/5] libperf: Use perf_cpu_map__nr instead of cpu_map__nr
Date:   Thu, 22 Aug 2019 13:11:38 +0200
Message-Id: <20190822111141.25823-3-jolsa@kernel.org>
In-Reply-To: <20190822111141.25823-1-jolsa@kernel.org>
References: <20190822111141.25823-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 22 Aug 2019 11:11:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the rest of the perf code to use perf_cpu_map__nr,
which is the same as current cpu_map__nr and remove
cpu_map__nr function.

Link: http://lkml.kernel.org/n/tip-6e0guy75clis7nm0xpuz9fga@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c |  4 ++--
 tools/perf/util/cpumap.h          |  5 -----
 tools/perf/util/evlist.c          | 10 +++++-----
 tools/perf/util/mmap.c            |  2 +-
 tools/perf/util/stat-display.c    |  2 +-
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5cb07e8cb296..c786ab095d15 100644
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
index a3d27f4131be..77f85e9c88d4 100644
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
index c4489a1ad6bc..15d1046014d7 100644
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
index 42a5971146ae..5f3532e51ec9 100644
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
index f7b39f4bc51e..3df0e39ccd52 100644
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
 
-- 
2.21.0

