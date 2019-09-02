Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68657215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfIBIRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:17:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfIBIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW4-0008Do-Us; Mon, 02 Sep 2019 10:16:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DE01B1C0DF8;
        Mon,  2 Sep 2019 10:16:41 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:41 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf metricgroup: Support multiple events for metricgroup
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828055932.8269-5-yao.jin@linux.intel.com>
References: <20190828055932.8269-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156741220181.17384.11338259464302112264.tip-bot2@tip-bot2>
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

Commit-ID:     f01642e4912bb80a01d693f4cc6fb0897207a090
Gitweb:        https://git.kernel.org/tip/f01642e4912bb80a01d693f4cc6fb0897207a090
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 28 Aug 2019 13:59:32 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:52 -03:00

perf metricgroup: Support multiple events for metricgroup

Some uncore metrics don't work as expected. For example, on
cascadelakex:

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

The issue is, the case of an alias expanding to mulitple events is not
supported, typically the uncore events.  (see comments in
find_evsel_group()).

For UNC_M_PMM_BANDWIDTH.TOTAL in above example, the expanded event group
is '{unc_m_pmm_rpq_inserts,unc_m_pmm_wpq_inserts}:W', but the actual
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

This patch introduces a new field 'metric_leader' in struct evsel. The
first event is considered as a metric leader. For the rest of same
events, they point to the first event via it's metric_leader field in
struct evsel.

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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190828055932.8269-5-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h       |  1 +-
 tools/perf/util/metricgroup.c | 84 +++++++++++++++++-----------------
 tools/perf/util/stat-shadow.c | 27 +++++++++--
 3 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index fd60cac..68321d1 100644
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
index f474a29..a7c0424 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -90,57 +90,61 @@ struct egroup {
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
index 696d263..70c87fd 100644
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
 
