Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A47C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D122189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfH1GAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:00:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:22123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GAc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:00:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181924789"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 23:00:28 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 4/4] perf util: Support multiple events for metricgroup
Date:   Wed, 28 Aug 2019 13:59:32 +0800
Message-Id: <20190828055932.8269-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828055932.8269-1-yao.jin@linux.intel.com>
References: <20190828055932.8269-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some uncore metrics don't work as expected. For example, on cascadelakex,

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_BANDWIDTH.TOTAL -a -- sleep 1

 Performance counter stats for 'system wide':

           1841092      unc_m_pmm_rpq_inserts
           3680816      unc_m_pmm_wpq_inserts

       1.001775055 seconds time elapsed

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_READ_LATENCY -a -- sleep 1

 Performance counter stats for 'system wide':

         860649746      unc_m_pmm_rpq_occupancy.all
           1840557      unc_m_pmm_rpq_inserts
       12790627455      unc_m_clockticks

       1.001773348 seconds time elapsed

No metrics 'UNC_M_PMM_BANDWIDTH.TOTAL' or 'UNC_M_PMM_READ_LATENCY' are
reported.

The issue is, the case of an alias expanding to mulitple events is
not supported, typically the uncore events.
(see comments in find_evsel_group()).

For UNC_M_PMM_BANDWIDTH.TOTAL in above example, the expanded event
group is '{unc_m_pmm_rpq_inserts,unc_m_pmm_wpq_inserts}:W', but the actual
events passed to find_evsel_group are:

unc_m_pmm_rpq_inserts
unc_m_pmm_rpq_inserts
unc_m_pmm_rpq_inserts
unc_m_pmm_rpq_inserts
unc_m_pmm_rpq_inserts
unc_m_pmm_rpq_inserts
unc_m_pmm_wpq_inserts
unc_m_pmm_wpq_inserts
unc_m_pmm_wpq_inserts
unc_m_pmm_wpq_inserts
unc_m_pmm_wpq_inserts
unc_m_pmm_wpq_inserts

For this multiple events case, it's not supported well.

This patch introduces a new field 'metric_leader' in struct evsel. The first
event is considered as a metric leader. For the rest of same events, they
point to the first event via it's metric_leader field in struct evsel.

This design is for adding the counting results of all same events to the
first event in group (the metric_leader).

With this patch,

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_BANDWIDTH.TOTAL -a -- sleep 1

 Performance counter stats for 'system wide':

           1842108      unc_m_pmm_rpq_inserts     #    337.2 MB/sec  UNC_M_PMM_BANDWIDTH.TOTAL
           3682209      unc_m_pmm_wpq_inserts

       1.001819706 seconds time elapsed

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_READ_LATENCY -a -- sleep 1

 Performance counter stats for 'system wide':

         861970685      unc_m_pmm_rpq_occupancy.all #    219.4 ns  UNC_M_PMM_READ_LATENCY
           1842772      unc_m_pmm_rpq_inserts
       12790196356      unc_m_clockticks

       1.001749103 seconds time elapsed

Now we can see the correct metrics 'UNC_M_PMM_BANDWIDTH.TOTAL' and
'UNC_M_PMM_READ_LATENCY'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.h       |  1 +
 tools/perf/util/metricgroup.c | 84 ++++++++++++++++++-----------------
 tools/perf/util/stat-shadow.c | 27 +++++++++--
 3 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index fd60caced4fc..68321d10eb2d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -168,6 +168,7 @@ struct evsel {
 	const char *		metric_expr;
 	const char *		metric_name;
 	struct evsel		**metric_events;
+	struct evsel		*metric_leader;
 	bool			collect_stat;
 	bool			weak_group;
 	bool			percore;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4036ed9ba942..90b5690e5bbc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -88,57 +88,61 @@ struct egroup {
 	const char *metric_unit;
 };
 
-static bool record_evsel(int *ind, struct evsel **start,
-			 int idnum,
-			 struct evsel **metric_events,
-			 struct evsel *ev)
-{
-	metric_events[*ind] = ev;
-	if (*ind == 0)
-		*start = ev;
-	if (++*ind == idnum) {
-		metric_events[*ind] = NULL;
-		return true;
-	}
-	return false;
-}
-
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
 				      struct evsel **metric_events)
 {
-	struct evsel *ev, *start = NULL;
-	int ind = 0;
+	struct evsel *ev;
+	int i = 0;
+	bool leader_found;
 
 	evlist__for_each_entry (perf_evlist, ev) {
-		if (ev->collect_stat)
-			continue;
-		if (!strcmp(ev->name, ids[ind])) {
-			if (record_evsel(&ind, &start, idnum,
-					 metric_events, ev))
-				return start;
+		if (!strcmp(ev->name, ids[i])) {
+			if (!metric_events[i])
+				metric_events[i] = ev;
 		} else {
-			/*
-			 * We saw some other event that is not
-			 * in our list of events. Discard
-			 * the whole match and start again.
-			 */
-			ind = 0;
-			start = NULL;
-			if (!strcmp(ev->name, ids[ind])) {
-				if (record_evsel(&ind, &start, idnum,
-						 metric_events, ev))
-					return start;
+			if (++i == idnum) {
+				/* Discard the whole match and start again */
+				i = 0;
+				memset(metric_events, 0,
+				       sizeof(struct evsel *) * idnum);
+				continue;
+			}
+
+			if (!strcmp(ev->name, ids[i]))
+				metric_events[i] = ev;
+			else {
+				/* Discard the whole match and start again */
+				i = 0;
+				memset(metric_events, 0,
+				       sizeof(struct evsel *) * idnum);
+				continue;
 			}
 		}
 	}
-	/*
-	 * This can happen when an alias expands to multiple
-	 * events, like for uncore events.
-	 * We don't support this case for now.
-	 */
-	return NULL;
+
+	if (i != idnum - 1) {
+		/* Not whole match */
+		return NULL;
+	}
+
+	metric_events[idnum] = NULL;
+
+	for (i = 0; i < idnum; i++) {
+		leader_found = false;
+		evlist__for_each_entry(perf_evlist, ev) {
+			if (!leader_found && (ev == metric_events[i]))
+				leader_found = true;
+
+			if (leader_found &&
+			    !strcmp(ev->name, metric_events[i]->name)) {
+				ev->metric_leader = metric_events[i];
+			}
+		}
+	}
+
+	return metric_events[0];
 }
 
 static int metricgroup__setup_events(struct list_head *groups,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 696d263f6eb6..70c87fdb2a43 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -31,6 +31,8 @@ struct saved_value {
 	int cpu;
 	struct runtime_stat *stat;
 	struct stats stats;
+	u64 metric_total;
+	int metric_other;
 };
 
 static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
@@ -212,6 +214,7 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 {
 	int ctx = evsel_context(counter);
 	u64 count_ns = count;
+	struct saved_value *v;
 
 	count *= counter->scale;
 
@@ -266,9 +269,15 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_runtime_stat(st, STAT_APERF, ctx, cpu, count);
 
 	if (counter->collect_stat) {
-		struct saved_value *v = saved_value_lookup(counter, cpu, true,
-							   STAT_NONE, 0, st);
+		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st);
 		update_stats(&v->stats, count);
+		if (counter->metric_leader)
+			v->metric_total += count;
+	} else if (counter->metric_leader) {
+		v = saved_value_lookup(counter->metric_leader,
+				       cpu, true, STAT_NONE, 0, st);
+		v->metric_total += count;
+		v->metric_other++;
 	}
 }
 
@@ -729,10 +738,10 @@ static void generic_metric(struct perf_stat_config *config,
 	char *n, *pn;
 
 	expr__ctx_init(&pctx);
-	expr__add_id(&pctx, name, avg);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
+		u64 metric_total = 0;
 
 		if (!strcmp(metric_events[i]->name, "duration_time")) {
 			stats = &walltime_nsecs_stats;
@@ -744,6 +753,9 @@ static void generic_metric(struct perf_stat_config *config,
 				break;
 			stats = &v->stats;
 			scale = 1.0;
+
+			if (v->metric_other)
+				metric_total = v->metric_total;
 		}
 
 		n = strdup(metric_events[i]->name);
@@ -757,8 +769,15 @@ static void generic_metric(struct perf_stat_config *config,
 		pn = strchr(n, ' ');
 		if (pn)
 			*pn = 0;
-		expr__add_id(&pctx, n, avg_stats(stats)*scale);
+
+		if (metric_total)
+			expr__add_id(&pctx, n, metric_total);
+		else
+			expr__add_id(&pctx, n, avg_stats(stats)*scale);
 	}
+
+	expr__add_id(&pctx, name, avg);
+
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
 
-- 
2.17.1

