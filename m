Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A03AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0122F20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfKPHwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 02:52:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfKPHwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 02:52:51 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D016F1133B732AF9015;
        Sat, 16 Nov 2019 15:52:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 16 Nov 2019 15:52:40 +0800
From:   lqqq341 <liuqi115@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <ak@linux.intel.com>
CC:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry@huawei.com>,
        <zhangshaokun@hisilicon.com>, <huangdaode@hisilicon.com>,
        <linyunsheng@huawei.com>, <liuqi115@hisilicon.com>
Subject: [PATCH] Perf stat: Fix the ratio comments of miss-events
Date:   Sat, 16 Nov 2019 15:48:41 +0800
Message-ID: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@hisilicon.com>

Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
iTLB cache and LL-cache. Take L1-dcache for example, its miss ratio
is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
accesses" seems better. The comments of L1-icache, dTLB cache, iTLB
cache and LL-cache are fixed in the same way.

Signed-off-by: Qi Liu <liuqi115@hisilicon.com>
---
 tools/perf/util/stat-shadow.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47..a3bdf2b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -506,7 +506,8 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
 
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%",
+			  "of all L1-dcache accesses", ratio);
 }
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
@@ -527,7 +528,8 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%",
+			  "of all L1-icache accesses", ratio);
 }
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
@@ -547,7 +549,8 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%",
+			  "of all dTLB cache accesses", ratio);
 }
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
@@ -567,7 +570,8 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%",
+			  "of all iTLB cache accesses", ratio);
 }
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
@@ -587,7 +591,8 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%",
+			  "of all LL-cache accesses", ratio);
 }
 
 /*
@@ -872,7 +877,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
 			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
+			print_metric(config, ctxp, NULL, NULL,
+				     "of all L1-dcache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
@@ -882,7 +888,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
 			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
+			print_metric(config, ctxp, NULL, NULL,
+				     "of all L1-icache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
@@ -892,7 +899,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
 			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL,
+				     "of all dTLB cache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
@@ -902,7 +910,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
 			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL,
+				     "of all iTLB cache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
@@ -912,7 +921,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
 			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL,
+				     "of all LL-cache accesses", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
 		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
 
-- 
2.8.1

