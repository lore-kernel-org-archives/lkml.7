Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC68218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfCOINs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:13:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:56884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfCOINp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:13:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 01:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="134268118"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2019 01:13:43 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/3] perf stat: Support coresum event qualifier
Date:   Sat, 16 Mar 2019 00:04:15 +0800
Message-Id: <1552665856-27741-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, we can use the coresum event qualifier in perf-stat.

root@skl:/tmp# perf stat -e cpu/event=0,umask=0x3,coresum=1/,cpu/event=0,umask=0x3/ -a -A -I1000
 #           time CPU                  counts      unit events
     1.000816660 S0-C0             80,676,154      cpu/event=0,umask=0x3,coresum=1/                                     (50.04%)
     1.000816660 S0-C1            115,314,959      cpu/event=0,umask=0x3,coresum=1/                                     (50.04%)
     1.000816660 S0-C2            126,541,249      cpu/event=0,umask=0x3,coresum=1/                                     (50.04%)
     1.000816660 S0-C3            119,950,015      cpu/event=0,umask=0x3,coresum=1/                                     (50.04%)
     1.000816660 CPU0              52,439,489      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU1              53,431,155      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU2              91,192,070      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU3              90,852,159      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU4              29,715,956      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU5              63,289,507      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU6              29,036,120      cpu/event=0,umask=0x3/                                        (49.96%)
     1.000816660 CPU7              28,996,591      cpu/event=0,umask=0x3/                                        (49.97%)

In this example, we count the event 'ref-cycles' per-core and per-CPU in
one perf stat command-line. From the output, we can see:

  S0-C0 = CPU0 + CPU4
  S0-C1 = CPU1 + CPU5
  S0-C2 = CPU2 + CPU6
  S0-C3 = CPU3 + CPU7

So the result is expected (tiny difference is ignored).

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |   4 ++
 tools/perf/builtin-stat.c              |  21 +++++++
 tools/perf/util/stat-display.c         | 108 ++++++++++++++++++++++++---------
 tools/perf/util/stat.c                 |   8 ++-
 4 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4bc2085..cd5fbd9 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -43,6 +43,10 @@ report::
 	  param1 and param2 are defined as formats for the PMU in
 	  /sys/bus/event_source/devices/<pmu>/format/*
 
+	  'coresum' is a event qualifier that sums up the event counts for both
+	  hardware threads in a core. For example:
+	  perf stat -A -a -e cpu/event,coresum=1/,otherevent ...
+
 	- a symbolically formed event like 'pmu/config=M,config1=N,config2=K/'
 	  where M, N, K are numbers (in decimal, hex, octal format).
 	  Acceptable values for each of 'config', 'config1' and 'config2'
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7b8f09b..8ce0168 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -832,6 +832,18 @@ static int perf_stat__get_core_cached(struct perf_stat_config *config,
 	return perf_stat__get_aggr(config, perf_stat__get_core, map, idx);
 }
 
+static bool term_coresum_set(void)
+{
+	struct perf_evsel *counter;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		if (counter->coresum)
+			return true;
+	}
+
+	return false;
+}
+
 static int perf_stat_init_aggr_mode(void)
 {
 	int nr;
@@ -852,6 +864,15 @@ static int perf_stat_init_aggr_mode(void)
 		stat_config.aggr_get_id = perf_stat__get_core_cached;
 		break;
 	case AGGR_NONE:
+		if (term_coresum_set()) {
+			if (cpu_map__build_core_map(evsel_list->cpus,
+						    &stat_config.aggr_map)) {
+				perror("cannot build core map");
+				return -1;
+			}
+			stat_config.aggr_get_id = perf_stat__get_core_cached;
+		}
+		break;
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d043c7..23c9368 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -93,9 +93,17 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 			break;
 	case AGGR_NONE:
-		fprintf(config->output, "CPU%*d%s",
-			config->csv_output ? 0 : -4,
-			perf_evsel__cpus(evsel)->map[id], config->csv_sep);
+		if (evsel->coresum) {
+			fprintf(config->output, "S%d-C%*d%s",
+				cpu_map__id_to_socket(id),
+				config->csv_output ? 0 : -5,
+				cpu_map__id_to_cpu(id), config->csv_sep);
+		} else {
+			fprintf(config->output, "CPU%*d%s ",
+				config->csv_output ? 0 : -5,
+				perf_evsel__cpus(evsel)->map[id],
+				config->csv_sep);
+		}
 		break;
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
@@ -599,6 +607,41 @@ static void aggr_cb(struct perf_stat_config *config,
 	}
 }
 
+static void print_counter_aggrdata(struct perf_stat_config *config,
+				   struct perf_evsel *counter, int s,
+				   char *prefix, bool metric_only,
+				   bool *first)
+{
+	struct aggr_data ad;
+	FILE *output = config->output;
+	u64 ena, run, val;
+	int id, nr;
+	double uval;
+
+	ad.id = id = config->aggr_map->map[s];
+	ad.val = ad.ena = ad.run = 0;
+	ad.nr = 0;
+	if (!collect_data(config, counter, aggr_cb, &ad))
+		return;
+
+	nr = ad.nr;
+	ena = ad.ena;
+	run = ad.run;
+	val = ad.val;
+	if (*first && metric_only) {
+		*first = false;
+		aggr_printout(config, counter, id, nr);
+	}
+	if (prefix && !metric_only)
+		fprintf(output, "%s", prefix);
+
+	uval = val * counter->scale;
+	printout(config, id, nr, counter, uval, prefix,
+		 run, ena, 1.0, &rt_stat);
+	if (!metric_only)
+		fputc('\n', output);
+}
+
 static void print_aggr(struct perf_stat_config *config,
 		       struct perf_evlist *evlist,
 		       char *prefix)
@@ -606,9 +649,7 @@ static void print_aggr(struct perf_stat_config *config,
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
 	struct perf_evsel *counter;
-	int s, id, nr;
-	double uval;
-	u64 ena, run, val;
+	int s;
 	bool first;
 
 	if (!(config->aggr_map || config->aggr_get_id))
@@ -621,36 +662,16 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		struct aggr_data ad;
 		if (prefix && metric_only)
 			fprintf(output, "%s", prefix);
 
-		ad.id = id = config->aggr_map->map[s];
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
-
-			ad.val = ad.ena = ad.run = 0;
-			ad.nr = 0;
-			if (!collect_data(config, counter, aggr_cb, &ad))
-				continue;
-			nr = ad.nr;
-			ena = ad.ena;
-			run = ad.run;
-			val = ad.val;
-			if (first && metric_only) {
-				first = false;
-				aggr_printout(config, counter, id, nr);
-			}
-			if (prefix && !metric_only)
-				fprintf(output, "%s", prefix);
-
-			uval = val * counter->scale;
-			printout(config, id, nr, counter, uval, prefix,
-				 run, ena, 1.0, &rt_stat);
-			if (!metric_only)
-				fputc('\n', output);
+			print_counter_aggrdata(config, counter, s,
+					       prefix, metric_only,
+					       &first);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -1101,6 +1122,30 @@ static void print_footer(struct perf_stat_config *config)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
+static void print_coresum(struct perf_stat_config *config,
+			  struct perf_evsel *counter, char *prefix)
+{
+	bool metric_only = config->metric_only;
+	FILE *output = config->output;
+	int s;
+	bool first = true;
+
+	if (!(config->aggr_map || config->aggr_get_id))
+		return;
+
+	for (s = 0; s < config->aggr_map->nr; s++) {
+		if (prefix && metric_only)
+			fprintf(output, "%s", prefix);
+
+		print_counter_aggrdata(config, counter, s,
+				       prefix, metric_only,
+				       &first);
+	}
+
+	if (metric_only)
+		fputc('\n', output);
+}
+
 void
 perf_evlist__print_counters(struct perf_evlist *evlist,
 			    struct perf_stat_config *config,
@@ -1157,7 +1202,10 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
 					continue;
-				print_counter(config, counter, prefix);
+				if (counter->coresum)
+					print_coresum(config, counter, prefix);
+				else
+					print_counter(config, counter, prefix);
 			}
 		}
 		break;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515..33a6e3c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -277,9 +277,11 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 		if (!evsel->snapshot)
 			perf_evsel__compute_deltas(evsel, cpu, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
-		if (config->aggr_mode == AGGR_NONE)
-			perf_stat__update_shadow_stats(evsel, count->val, cpu,
-						       &rt_stat);
+		if ((config->aggr_mode == AGGR_NONE) && (!evsel->coresum)) {
+			perf_stat__update_shadow_stats(evsel, count->val,
+						       cpu, &rt_stat);
+		}
+
 		if (config->aggr_mode == AGGR_THREAD) {
 			if (config->stats)
 				perf_stat__update_shadow_stats(evsel,
-- 
2.7.4

