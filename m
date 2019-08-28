Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9A422CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfH1GAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:00:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:22123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfH1GA2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181924780"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 23:00:26 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 3/4] perf util: Scale the metric result
Date:   Wed, 28 Aug 2019 13:59:31 +0800
Message-Id: <20190828055932.8269-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828055932.8269-1-yao.jin@linux.intel.com>
References: <20190828055932.8269-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/perf/util/metricgroup.c |  3 +++
 tools/perf/util/metricgroup.h |  1 +
 tools/perf/util/stat-shadow.c | 38 +++++++++++++++++++++++++----------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index aaf55444f81b..4036ed9ba942 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -85,6 +85,7 @@ struct egroup {
 	const char **ids;
 	const char *metric_name;
 	const char *metric_expr;
+	const char *metric_unit;
 };
 
 static bool record_evsel(int *ind, struct evsel **start,
@@ -180,6 +181,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		}
 		expr->metric_expr = eg->metric_expr;
 		expr->metric_name = eg->metric_name;
+		expr->metric_unit = eg->metric_unit;
 		expr->metric_events = metric_events;
 		list_add(&expr->nd, &me->head);
 	}
@@ -451,6 +453,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
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
2.17.1

