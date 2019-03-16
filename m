Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7BFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C538218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCPIoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:44:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:7291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfCPIn7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:43:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 01:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,485,1544515200"; 
   d="scan'208";a="152239414"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2019 01:43:57 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 3/4] perf stat: Support 'percore' event qualifier
Date:   Sun, 17 Mar 2019 00:34:27 +0800
Message-Id: <1552754068-10325-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552754068-10325-1-git-send-email-yao.jin@linux.intel.com>
References: <1552754068-10325-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, we can use the 'percore' event qualifier in perf-stat.

root@skl:/tmp# perf stat -e cpu/event=0,umask=0x3,percore=1/,cpu/event=0,umask=0x3/ -a -A -I1000
     1.000773050 S0-C0             98,352,832      cpu/event=0,umask=0x3,percore=1/                                     (50.01%)
     1.000773050 S0-C1            103,763,057      cpu/event=0,umask=0x3,percore=1/                                     (50.02%)
     1.000773050 S0-C2            196,776,995      cpu/event=0,umask=0x3,percore=1/                                     (50.02%)
     1.000773050 S0-C3            176,493,779      cpu/event=0,umask=0x3,percore=1/                                     (50.02%)
     1.000773050 CPU0              47,699,641      cpu/event=0,umask=0x3/                                        (50.02%)
     1.000773050 CPU1              49,052,451      cpu/event=0,umask=0x3/                                        (49.98%)
     1.000773050 CPU2             102,771,422      cpu/event=0,umask=0x3/                                        (49.98%)
     1.000773050 CPU3             100,784,662      cpu/event=0,umask=0x3/                                        (49.98%)
     1.000773050 CPU4              43,171,342      cpu/event=0,umask=0x3/                                        (49.98%)
     1.000773050 CPU5              54,152,158      cpu/event=0,umask=0x3/                                        (49.98%)
     1.000773050 CPU6              93,618,410      cpu/event=0,umask=0x3/                                        (49.98%)
     1.000773050 CPU7              74,477,589      cpu/event=0,umask=0x3/                                        (49.99%)

In this example, we count the event 'ref-cycles' per-core and per-CPU in
one perf stat command-line. From the output, we can see:

  S0-C0 = CPU0 + CPU4
  S0-C1 = CPU1 + CPU5
  S0-C2 = CPU2 + CPU6
  S0-C3 = CPU3 + CPU7

So the result is expected (tiny difference is ignored).

Note that, the 'percore' event qualifier needs to use with option '-A'.

 v2:
 ---
 Change 'coresum' to 'percore'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 21 +++++++++++++++++
 tools/perf/util/stat-display.c         | 43 ++++++++++++++++++++++++++++++----
 tools/perf/util/stat.c                 |  8 ++++---
 4 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4bc2085..614d2c5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -43,6 +43,10 @@ report::
 	  param1 and param2 are defined as formats for the PMU in
 	  /sys/bus/event_source/devices/<pmu>/format/*
 
+	  'percore' is a event qualifier that sums up the event counts for both
+	  hardware threads in a core. For example:
+	  perf stat -A -a -e cpu/event,percore=1/,otherevent ...
+
 	- a symbolically formed event like 'pmu/config=M,config1=N,config2=K/'
 	  where M, N, K are numbers (in decimal, hex, octal format).
 	  Acceptable values for each of 'config', 'config1' and 'config2'
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7b8f09b..af2ce87 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -832,6 +832,18 @@ static int perf_stat__get_core_cached(struct perf_stat_config *config,
 	return perf_stat__get_aggr(config, perf_stat__get_core, map, idx);
 }
 
+static bool term_percore_set(void)
+{
+	struct perf_evsel *counter;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		if (counter->percore)
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
+		if (term_percore_set()) {
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
index 728dc88..477da62 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -93,9 +93,17 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 			break;
 	case AGGR_NONE:
-		fprintf(config->output, "CPU%*d%s",
-			config->csv_output ? 0 : -4,
-			perf_evsel__cpus(evsel)->map[id], config->csv_sep);
+		if (evsel->percore) {
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
@@ -1114,6 +1122,30 @@ static void print_footer(struct perf_stat_config *config)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
+static void print_percore(struct perf_stat_config *config,
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
@@ -1170,7 +1202,10 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
 					continue;
-				print_counter(config, counter, prefix);
+				if (counter->percore)
+					print_percore(config, counter, prefix);
+				else
+					print_counter(config, counter, prefix);
 			}
 		}
 		break;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515..1e2da2b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -277,9 +277,11 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 		if (!evsel->snapshot)
 			perf_evsel__compute_deltas(evsel, cpu, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
-		if (config->aggr_mode == AGGR_NONE)
-			perf_stat__update_shadow_stats(evsel, count->val, cpu,
-						       &rt_stat);
+		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
+			perf_stat__update_shadow_stats(evsel, count->val,
+						       cpu, &rt_stat);
+		}
+
 		if (config->aggr_mode == AGGR_THREAD) {
 			if (config->stats)
 				perf_stat__update_shadow_stats(evsel,
-- 
2.7.4

