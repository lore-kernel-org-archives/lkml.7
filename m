Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83065C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2E12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633759AbfIYCDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:03:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:32026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633750AbfIYCDV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:03:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 19:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; 
   d="scan'208";a="213896608"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2019 19:03:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/2] perf stat: Support topdown with --all-kernel/--all-user
Date:   Wed, 25 Sep 2019 10:02:18 +0800
Message-Id: <20190925020218.8288-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925020218.8288-1-yao.jin@linux.intel.com>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf stat --topdown is enabled, the internal event list is expanded to:
"{topdown-total-slots,topdown-slots-retired,topdown-recovery-bubbles,topdown-fetch-bubbles,topdown-slots-issued}".

With this patch,

1. When --all-user is enabled, it's expanded to:
"{topdown-total-slots:u,topdown-slots-retired:u,topdown-recovery-bubbles:u,topdown-fetch-bubbles:u,topdown-slots-issued:u}"

2. When --all-kernel is enabled, it's expanded to:
"{topdown-total-slots:k,topdown-slots-retired:k,topdown-recovery-bubbles:k,topdown-fetch-bubbles:k,topdown-slots-issued:k}"

3. Both are enabled, it's expanded to:
"{topdown-total-slots:k,topdown-slots-retired:k,topdown-recovery-bubbles:k,topdown-fetch-bubbles:k,topdown-slots-issued:k},{topdown-total-slots:u,topdown-slots-retired:u,topdown-recovery-bubbles:u,topdown-fetch-bubbles:u,topdown-slots-issued:u}"

This patch creates new topdown stat type (STAT_TOPDOWN_XXX_K /
STAT_TOPDOWN_XXX_U), and save the event counting value to type
related entry in runtime_stat rblist.

For example,

 root@kbl:~# perf stat -a --topdown --all-kernel -- sleep 1

 Performance counter stats for 'system wide':

                                  retiring:k    bad speculation:k     frontend bound:k      backend bound:k
S0-D0-C0           2                 7.6%                 1.8%                40.5%                50.0%
S0-D0-C1           2                15.4%                 3.4%                14.4%                66.8%
S0-D0-C2           2                15.8%                 5.1%                26.9%                52.2%
S0-D0-C3           2                 5.7%                 5.7%                46.2%                42.4%

       1.000771709 seconds time elapsed

 root@kbl:~# perf stat -a --topdown --all-user -- sleep 1

 Performance counter stats for 'system wide':

                                  retiring:u    bad speculation:u     frontend bound:u      backend bound:u
S0-D0-C0           2                 0.5%                 0.0%                 0.0%                99.4%
S0-D0-C1           2                 5.7%                 5.8%                77.7%                10.7%
S0-D0-C2           2                15.5%                20.5%                35.8%                28.2%
S0-D0-C3           2                14.1%                 0.5%                 1.5%                83.9%

       1.000773028 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c     |  37 +++++++-
 tools/perf/util/stat-shadow.c | 167 +++++++++++++++++++++++++---------
 tools/perf/util/stat.h        |  12 +++
 3 files changed, 171 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7f4d22b00d04..b766293b9a15 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1436,7 +1436,8 @@ static int add_default_attributes(void)
 
 	if (topdown_run) {
 		char *str = NULL;
-		bool warn = false;
+		bool warn = false, append_uk = false;
+		struct strbuf new_str;
 
 		if (stat_config.aggr_mode != AGGR_GLOBAL &&
 		    stat_config.aggr_mode != AGGR_CORE) {
@@ -1457,6 +1458,21 @@ static int add_default_attributes(void)
 			return -1;
 		}
 		if (topdown_attrs[0] && str) {
+			int ret;
+
+			if (stat_config.all_kernel || stat_config.all_user) {
+				ret = append_modifier(&new_str, str,
+						stat_config.all_kernel,
+						stat_config.all_user);
+				if (ret)
+					return ret;
+
+				free(str);
+				str = strbuf_detach(&new_str, NULL);
+				strbuf_release(&new_str);
+				append_uk = true;
+			}
+
 			if (warn)
 				arch_topdown_group_warn();
 			err = parse_events(evsel_list, str, &errinfo);
@@ -1468,6 +1484,25 @@ static int add_default_attributes(void)
 				free(str);
 				return -1;
 			}
+
+			if (append_uk) {
+				struct evsel *evsel;
+				char *p;
+
+				evlist__for_each_entry(evsel_list, evsel) {
+					/*
+					 * We appended the modifiers ":u"/":k"
+					 * to evsel->name. Since the events have
+					 * been parsed, remove the appended
+					 * modifiers from event name here.
+					 */
+					if (evsel->name) {
+						p = strchr(evsel->name, ':');
+						if (p)
+							*p = 0;
+					}
+				}
+			}
 		} else {
 			fprintf(stderr, "System does not support topdown\n");
 			return -1;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 70c87fdb2a43..013e0f772658 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -204,6 +204,24 @@ static void update_runtime_stat(struct runtime_stat *st,
 		update_stats(&v->stats, count);
 }
 
+static void update_runtime_stat_uk(struct runtime_stat *st,
+				   enum stat_type type,
+				   int ctx, int cpu, u64 count,
+				   struct evsel *counter, int type_off)
+{
+	struct perf_event_attr *attr = &counter->core.attr;
+
+	if (!attr->exclude_user && !attr->exclude_kernel)
+		update_runtime_stat(st, type, ctx, cpu, count);
+	else if (attr->exclude_user) {
+		update_runtime_stat(st, type + type_off,
+				    ctx, cpu, count);
+	} else {
+		update_runtime_stat(st, type + type_off * 2,
+				    ctx, cpu, count);
+	}
+}
+
 /*
  * Update various tracking values we maintain to print
  * more semantic information such as miss/hit ratios,
@@ -229,20 +247,25 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	else if (perf_stat_evsel__is(counter, ELISION_START))
 		update_runtime_stat(st, STAT_ELISION, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
-		update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
-				    ctx, cpu, count);
+		update_runtime_stat_uk(st, STAT_TOPDOWN_TOTAL_SLOTS,
+				       ctx, cpu, count, counter,
+				       STAT_TOPDOWN_NUM);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
-		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
-				    ctx, cpu, count);
+		update_runtime_stat_uk(st, STAT_TOPDOWN_SLOTS_ISSUED,
+				       ctx, cpu, count, counter,
+				       STAT_TOPDOWN_NUM);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
-		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
-				    ctx, cpu, count);
+		update_runtime_stat_uk(st, STAT_TOPDOWN_SLOTS_RETIRED,
+				       ctx, cpu, count, counter,
+				       STAT_TOPDOWN_NUM);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
-		update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
-				    ctx, cpu, count);
+		update_runtime_stat_uk(st, STAT_TOPDOWN_FETCH_BUBBLES,
+				       ctx, cpu, count, counter,
+				       STAT_TOPDOWN_NUM);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
-		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
-				    ctx, cpu, count);
+		update_runtime_stat_uk(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
+				       ctx, cpu, count, counter,
+				       STAT_TOPDOWN_NUM);
 	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
 				    ctx, cpu, count);
@@ -410,6 +433,20 @@ static double runtime_stat_avg(struct runtime_stat *st,
 	return avg_stats(&v->stats);
 }
 
+static double runtime_stat_avg_uk(struct runtime_stat *st,
+				  enum stat_type type, int ctx, int cpu,
+				  struct evsel *counter, int type_off)
+{
+	struct perf_event_attr *attr = &counter->core.attr;
+
+	if (!attr->exclude_user && !attr->exclude_kernel)
+		return runtime_stat_avg(st, type, ctx, cpu);
+	else if (attr->exclude_user)
+		return runtime_stat_avg(st, type + type_off, ctx, cpu);
+
+	return runtime_stat_avg(st, type + type_off * 2, ctx, cpu);
+}
+
 static double runtime_stat_n(struct runtime_stat *st,
 			     enum stat_type type, int ctx, int cpu)
 {
@@ -639,56 +676,67 @@ static double sanitize_val(double x)
 	return x;
 }
 
-static double td_total_slots(int ctx, int cpu, struct runtime_stat *st)
+static double td_total_slots(int ctx, int cpu, struct runtime_stat *st,
+			     struct evsel *evsel)
 {
-	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, ctx, cpu);
+	return runtime_stat_avg_uk(st, STAT_TOPDOWN_TOTAL_SLOTS, ctx, cpu,
+				   evsel, STAT_TOPDOWN_NUM);
 }
 
-static double td_bad_spec(int ctx, int cpu, struct runtime_stat *st)
+static double td_bad_spec(int ctx, int cpu, struct runtime_stat *st,
+			  struct evsel *evsel)
 {
 	double bad_spec = 0;
 	double total_slots;
 	double total;
 
-	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, ctx, cpu) -
-		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, ctx, cpu) +
-		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, ctx, cpu);
+	total = runtime_stat_avg_uk(st, STAT_TOPDOWN_SLOTS_ISSUED, ctx, cpu,
+				    evsel, STAT_TOPDOWN_NUM) -
+		runtime_stat_avg_uk(st, STAT_TOPDOWN_SLOTS_RETIRED, ctx, cpu,
+				    evsel, STAT_TOPDOWN_NUM) +
+		runtime_stat_avg_uk(st, STAT_TOPDOWN_RECOVERY_BUBBLES, ctx, cpu,
+				    evsel, STAT_TOPDOWN_NUM);
 
-	total_slots = td_total_slots(ctx, cpu, st);
+	total_slots = td_total_slots(ctx, cpu, st, evsel);
 	if (total_slots)
 		bad_spec = total / total_slots;
 	return sanitize_val(bad_spec);
 }
 
-static double td_retiring(int ctx, int cpu, struct runtime_stat *st)
+static double td_retiring(int ctx, int cpu, struct runtime_stat *st,
+			  struct evsel *evsel)
 {
 	double retiring = 0;
-	double total_slots = td_total_slots(ctx, cpu, st);
-	double ret_slots = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED,
-					    ctx, cpu);
+	double total_slots = td_total_slots(ctx, cpu, st, evsel);
+	double ret_slots = runtime_stat_avg_uk(st, STAT_TOPDOWN_SLOTS_RETIRED,
+					       ctx, cpu, evsel,
+					       STAT_TOPDOWN_NUM);
 
 	if (total_slots)
 		retiring = ret_slots / total_slots;
 	return retiring;
 }
 
-static double td_fe_bound(int ctx, int cpu, struct runtime_stat *st)
+static double td_fe_bound(int ctx, int cpu, struct runtime_stat *st,
+			  struct evsel *evsel)
 {
 	double fe_bound = 0;
-	double total_slots = td_total_slots(ctx, cpu, st);
-	double fetch_bub = runtime_stat_avg(st, STAT_TOPDOWN_FETCH_BUBBLES,
-					    ctx, cpu);
+	double total_slots = td_total_slots(ctx, cpu, st, evsel);
+	double fetch_bub = runtime_stat_avg_uk(st, STAT_TOPDOWN_FETCH_BUBBLES,
+					       ctx, cpu, evsel,
+					       STAT_TOPDOWN_NUM);
 
 	if (total_slots)
 		fe_bound = fetch_bub / total_slots;
 	return fe_bound;
 }
 
-static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
+static double td_be_bound(int ctx, int cpu, struct runtime_stat *st,
+			  struct evsel *evsel)
 {
-	double sum = (td_fe_bound(ctx, cpu, st) +
-		      td_bad_spec(ctx, cpu, st) +
-		      td_retiring(ctx, cpu, st));
+	double sum = (td_fe_bound(ctx, cpu, st, evsel) +
+		      td_bad_spec(ctx, cpu, st, evsel) +
+		      td_retiring(ctx, cpu, st, evsel));
 	if (sum == 0)
 		return 0;
 	return sanitize_val(1.0 - sum);
@@ -814,6 +862,33 @@ static void generic_metric(struct perf_stat_config *config,
 		zfree(&pctx.ids[i].name);
 }
 
+static void print_metric_uk(struct perf_stat_config *config,
+			    void *ctx, const char *color,
+			    const char *fmt, const char *unit,
+			    double val, struct evsel *evsel,
+			    print_metric_t print_metric)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	char *new_unit;
+
+	if (!attr->exclude_user && !attr->exclude_kernel) {
+		print_metric(config, ctx, color, fmt, unit, val);
+		return;
+	}
+
+	new_unit = calloc(1, strlen(unit) + 3);
+	if (!new_unit)
+		return;
+
+	if (attr->exclude_user)
+		sprintf(new_unit, "%s:k", unit);
+	else
+		sprintf(new_unit, "%s:u", unit);
+
+	print_metric(config, ctx, color, fmt, new_unit, val);
+	free(new_unit);
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int cpu,
@@ -986,28 +1061,30 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
-		double fe_bound = td_fe_bound(ctx, cpu, st);
+		double fe_bound = td_fe_bound(ctx, cpu, st, evsel);
 
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
-				fe_bound * 100.);
+		print_metric_uk(config, ctxp, color, "%8.1f%%",
+				"frontend bound",
+				fe_bound * 100., evsel, print_metric);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
-		double retiring = td_retiring(ctx, cpu, st);
+		double retiring = td_retiring(ctx, cpu, st, evsel);
 
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
-		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
-				retiring * 100.);
+		print_metric_uk(config, ctxp, color, "%8.1f%%", "retiring",
+				retiring * 100., evsel, print_metric);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
-		double bad_spec = td_bad_spec(ctx, cpu, st);
+		double bad_spec = td_bad_spec(ctx, cpu, st, evsel);
 
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
-				bad_spec * 100.);
+		print_metric_uk(config, ctxp, color, "%8.1f%%",
+				"bad speculation",
+				bad_spec * 100., evsel, print_metric);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
-		double be_bound = td_be_bound(ctx, cpu, st);
+		double be_bound = td_be_bound(ctx, cpu, st, evsel);
 		const char *name = "backend bound";
 		static int have_recovery_bubbles = -1;
 
@@ -1020,11 +1097,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
-		if (td_total_slots(ctx, cpu, st) > 0)
-			print_metric(config, ctxp, color, "%8.1f%%", name,
-					be_bound * 100.);
-		else
-			print_metric(config, ctxp, NULL, NULL, name, 0);
+		if (td_total_slots(ctx, cpu, st, evsel) > 0)
+			print_metric_uk(config, ctxp, color, "%8.1f%%", name,
+					be_bound * 100., evsel, print_metric);
+		else {
+			print_metric_uk(config, ctxp, NULL, NULL, name, 0,
+					evsel, print_metric);
+		}
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
 				evsel->metric_name, NULL, avg, cpu, out, st);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8154e07ced64..1bae80ed5543 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -60,6 +60,8 @@ enum {
 
 #define NUM_CTX CTX_BIT_MAX
 
+#define STAT_TOPDOWN_NUM	5
+
 enum stat_type {
 	STAT_NONE = 0,
 	STAT_NSECS,
@@ -81,6 +83,16 @@ enum stat_type {
 	STAT_TOPDOWN_SLOTS_RETIRED,
 	STAT_TOPDOWN_FETCH_BUBBLES,
 	STAT_TOPDOWN_RECOVERY_BUBBLES,
+	STAT_TOPDOWN_TOTAL_SLOTS_K,
+	STAT_TOPDOWN_SLOTS_ISSUED_K,
+	STAT_TOPDOWN_SLOTS_RETIRED_K,
+	STAT_TOPDOWN_FETCH_BUBBLES_K,
+	STAT_TOPDOWN_RECOVERY_BUBBLES_K,
+	STAT_TOPDOWN_TOTAL_SLOTS_U,
+	STAT_TOPDOWN_SLOTS_ISSUED_U,
+	STAT_TOPDOWN_SLOTS_RETIRED_U,
+	STAT_TOPDOWN_FETCH_BUBBLES_U,
+	STAT_TOPDOWN_RECOVERY_BUBBLES_U,
 	STAT_SMI_NUM,
 	STAT_APERF,
 	STAT_MAX
-- 
2.17.1

