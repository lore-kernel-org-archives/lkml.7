Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B20C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF425233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507682;
	bh=oRufS8ruDdZqtqaU9HHgxNNCImIcMPkh45qL8VZbwts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdlYWjOxM9P5/EgQG6z+j7TcrMMpYxMZI2mNf3Z+kW6LEgOXQIO9DJwxok42VFM66
	 x6Wj8QKFGLiWm4CeGDCqx6goEDuMoNpxB4i7Mab9eIYLRXMa0/W0SW858dmHb1LyWq
	 3vrbUFDbN5g6AAcHJN4nrS/C/kTqxueYO8j0IVAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbfHVVBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733015AbfHVVBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:19 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF4B23401;
        Thu, 22 Aug 2019 21:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507678;
        bh=oRufS8ruDdZqtqaU9HHgxNNCImIcMPkh45qL8VZbwts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WS5uDey3gQkwj0kTLdXvlxuLPXo1NZGUxCcFZNSTNzsSRKd489Lc0N5xIi8AGMclJ
         OK378z2zDfHHKpTkcOKX/QKWjV66TQUINVVaad09+cG5N6X8d1s31TnKjIVKVab4ns
         qXrH02jHMBHWvG9VgJe1L2eZ1yRkR0jTc6WoTh8w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/25] perf tools: Use perf_cpu_map__nr instead of cpu_map__nr
Date:   Thu, 22 Aug 2019 18:00:37 -0300
Message-Id: <20190822210100.3461-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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

