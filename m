Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B4D233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340732;
	bh=hL6XtUm1WRXCPE18+CEZF6ihu87h60nnPAYPrD/egfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uoRWP4VSPpYDf+RxtrjBjdf4vbKC4okOwnVwaegEWt0pTinuWqYs2Fw6/0yZcrRFq
	 brsgwUhRRMBFdqmvWZxOZHXoM2HBiLRwfGJgC3LXIjFz3StHun94t3gHx1xYWotckP
	 dpRa7Y/ipUrZHRJ0TskpoUrQldIHqTHlKej42Rn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfIAMZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbfIAMZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEE723429;
        Sun,  1 Sep 2019 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340728;
        bh=hL6XtUm1WRXCPE18+CEZF6ihu87h60nnPAYPrD/egfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vo3AlIvFZzWg9V3UWnsLF6YKmZFc3UsJsEOl8+h2HluVWnPA9nzU9p0CK+mqRlqCi
         mGFbGG4PfJ6e6sJZkLrO/lqmeobPXcXIwtn0TU0aQkqgAYzVXFIc/eQNYGQ3LNrDFe
         mSIBdF2K+CCt6n76osvj5YfRy2ilDZHjJN8ztdm0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/47] perf metricgroup: Scale the metric result
Date:   Sun,  1 Sep 2019 09:23:18 -0300
Message-Id: <20190901122326.5793-40-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Some metrics define the scale unit, such as

    {
        "BriefDescription": "Intel Optane DC persistent memory read latency (ns). Derived from unc_m_pmm_rpq_occupancy.all",
        "Counter": "0,1,2,3",
        "EventCode": "0xE0",
        "EventName": "UNC_M_PMM_READ_LATENCY",
        "MetricExpr": "UNC_M_PMM_RPQ_OCCUPANCY.ALL / UNC_M_PMM_RPQ_INSERTS / UNC_M_CLOCKTICKS",
        "MetricName": "UNC_M_PMM_READ_LATENCY",
        "PerPkg": "1",
        "ScaleUnit": "6000000000ns",
        "UMask": "0x1",
        "Unit": "iMC"
    },

For above example, the ratio should be,

ratio = (UNC_M_PMM_RPQ_OCCUPANCY.ALL / UNC_M_PMM_RPQ_INSERTS / UNC_M_CLOCKTICKS) * 6000000000

But in current code, the ratio is not scaled ( * 6000000000)

With this patch, the ratio is scaled and the unit (ns) is printed.

For example,
  #    219.4 ns  UNC_M_PMM_READ_LATENCY

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190828055932.8269-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c |  3 +++
 tools/perf/util/metricgroup.h |  1 +
 tools/perf/util/stat-shadow.c | 38 +++++++++++++++++++++++++----------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 33f5e2101874..f474a29f1b69 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -87,6 +87,7 @@ struct egroup {
 	const char **ids;
 	const char *metric_name;
 	const char *metric_expr;
+	const char *metric_unit;
 };
 
 static bool record_evsel(int *ind, struct evsel **start,
@@ -182,6 +183,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		}
 		expr->metric_expr = eg->metric_expr;
 		expr->metric_name = eg->metric_name;
+		expr->metric_unit = eg->metric_unit;
 		expr->metric_events = metric_events;
 		list_add(&expr->nd, &me->head);
 	}
@@ -453,6 +455,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			eg->idnum = idnum;
 			eg->metric_name = pe->metric_name;
 			eg->metric_expr = pe->metric_expr;
+			eg->metric_unit = pe->unit;
 			list_add_tail(&eg->nd, group_list);
 			ret = 0;
 		}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index e5092f6404ae..475c7f912864 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -20,6 +20,7 @@ struct metric_expr {
 	struct list_head nd;
 	const char *metric_expr;
 	const char *metric_name;
+	const char *metric_unit;
 	struct evsel **metric_events;
 };
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2ed5e0066c70..696d263f6eb6 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -715,6 +715,7 @@ static void generic_metric(struct perf_stat_config *config,
 			   struct evsel **metric_events,
 			   char *name,
 			   const char *metric_name,
+			   const char *metric_unit,
 			   double avg,
 			   int cpu,
 			   struct perf_stat_output_ctx *out,
@@ -722,7 +723,7 @@ static void generic_metric(struct perf_stat_config *config,
 {
 	print_metric_t print_metric = out->print_metric;
 	struct parse_ctx pctx;
-	double ratio;
+	double ratio, scale;
 	int i;
 	void *ctxp = out->ctx;
 	char *n, *pn;
@@ -732,7 +733,6 @@ static void generic_metric(struct perf_stat_config *config,
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
-		double scale;
 
 		if (!strcmp(metric_events[i]->name, "duration_time")) {
 			stats = &walltime_nsecs_stats;
@@ -762,16 +762,32 @@ static void generic_metric(struct perf_stat_config *config,
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
 
-		if (expr__parse(&ratio, &pctx, &p) == 0)
-			print_metric(config, ctxp, NULL, "%8.1f",
-				metric_name ?
-				metric_name :
-				out->force_header ?  name : "",
-				ratio);
-		else
+		if (expr__parse(&ratio, &pctx, &p) == 0) {
+			char *unit;
+			char metric_bf[64];
+
+			if (metric_unit && metric_name) {
+				if (perf_pmu__convert_scale(metric_unit,
+					&unit, &scale) >= 0) {
+					ratio *= scale;
+				}
+
+				scnprintf(metric_bf, sizeof(metric_bf),
+					  "%s  %s", unit, metric_name);
+				print_metric(config, ctxp, NULL, "%8.1f",
+					     metric_bf, ratio);
+			} else {
+				print_metric(config, ctxp, NULL, "%8.1f",
+					metric_name ?
+					metric_name :
+					out->force_header ?  name : "",
+					ratio);
+			}
+		} else {
 			print_metric(config, ctxp, NULL, NULL,
 				     out->force_header ?
 				     (metric_name ? metric_name : name) : "", 0);
+		}
 	} else
 		print_metric(config, ctxp, NULL, NULL, "", 0);
 
@@ -992,7 +1008,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
-				evsel->metric_name, avg, cpu, out, st);
+				evsel->metric_name, NULL, avg, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
@@ -1021,7 +1037,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				out->new_line(config, ctxp);
 			generic_metric(config, mexp->metric_expr, mexp->metric_events,
 					evsel->name, mexp->metric_name,
-					avg, cpu, out, st);
+					mexp->metric_unit, avg, cpu, out, st);
 		}
 	}
 	if (num == 0)
-- 
2.21.0

