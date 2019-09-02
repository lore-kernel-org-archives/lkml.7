Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F38215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfIBIRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:17:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56386 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbfIBIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:17:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW8-0008DU-Nv; Mon, 02 Sep 2019 10:16:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6ABD21C0DF7;
        Mon,  2 Sep 2019 10:16:41 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:41 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf metricgroup: Scale the metric result
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828055932.8269-4-yao.jin@linux.intel.com>
References: <20190828055932.8269-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156741220133.17381.1725783860233117581.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     287f2649f791819dd2d8f32f0213c8c521d6dfa0
Gitweb:        https://git.kernel.org/tip/287f2649f791819dd2d8f32f0213c8c521d6dfa0
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 28 Aug 2019 13:59:31 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:52 -03:00

perf metricgroup: Scale the metric result

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
 tools/perf/util/metricgroup.c |  3 +++-
 tools/perf/util/metricgroup.h |  1 +-
 tools/perf/util/stat-shadow.c | 38 ++++++++++++++++++++++++----------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 33f5e21..f474a29 100644
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
index e5092f6..475c7f9 100644
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
index 2ed5e00..696d263 100644
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
