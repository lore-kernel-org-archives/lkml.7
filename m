Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5696821744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567426387;
	bh=WzrtNVGzm4ixTupcczZxtXfBA84ivj+cFQIGjhG8XeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uURhoGXLqtt+HVYLJS38/yDewvTqv5QFodHxOq/sHDGUQ22eCxH4p2FR+jVEt9KKe
	 oApMtw7OOOUAb+X83jVQgq6Qb3ri6Cuw/gAkvQIg22qGpN+iPveWW0Mopb3SQEwBAh
	 GQKirQf48iox9LMA0qzEGHB649UX9CVk6Z/ATQ44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfIBMNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfIBMNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CBD7307D90D;
        Mon,  2 Sep 2019 12:13:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BB9060C05;
        Mon,  2 Sep 2019 12:12:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/3] libperf: Add perf_cpu_map__max function
Date:   Mon,  2 Sep 2019 14:12:53 +0200
Message-Id: <20190902121255.536-2-jolsa@kernel.org>
In-Reply-To: <20190902121255.536-1-jolsa@kernel.org>
References: <20190902121255.536-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 02 Sep 2019 12:13:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it can be used from multiple places.

Link: http://lkml.kernel.org/n/tip-yp3h5rl9e8piybufq41zqnla@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c            | 14 +-------------
 tools/perf/lib/cpumap.c              | 12 ++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  1 +
 tools/perf/lib/libperf.map           |  1 +
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7e17bf9f700a..5bc0c570b7b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -822,18 +822,6 @@ static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 	return cpu_map__get_core(map, cpu, NULL);
 }
 
-static int cpu_map__get_max(struct perf_cpu_map *map)
-{
-	int i, max = -1;
-
-	for (i = 0; i < map->nr; i++) {
-		if (map->map[i] > max)
-			max = map->map[i];
-	}
-
-	return max;
-}
-
 static int perf_stat__get_aggr(struct perf_stat_config *config,
 			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
 {
@@ -928,7 +916,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = cpu_map__get_max(evsel_list->core.cpus);
+	nr = perf_cpu_map__max(evsel_list->core.cpus);
 	stat_config.cpus_aggr_map = perf_cpu_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 1f0e6f334237..2ca1fafa620d 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -260,3 +260,15 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 
 	return -1;
 }
+
+int perf_cpu_map__max(struct perf_cpu_map *map)
+{
+	int i, max = -1;
+
+	for (i = 0; i < map->nr; i++) {
+		if (map->map[i] > max)
+			max = map->map[i];
+	}
+
+	return max;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 8aa995c59498..ac9aa497f84a 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -16,6 +16,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index dc4d66363bc4..cd0d17b996c8 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__empty;
+		perf_cpu_map__max;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
-- 
2.21.0

