Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C88C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5264020B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UjqcUqma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfERJiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:38:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfERJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:38:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9amCi1743047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:36:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9amCi1743047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558172209;
        bh=ybiv5D3gcUp1K/smVDuwgDFrBut9HyGuO04fqmqh02k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UjqcUqmadmzHOrrjeoVn934d4OpIdECvPFt7wd3QQhPtv6GDy2AusNYdUdToGA3kb
         doLYJx1seAyBbq2SaFd+ej/zcFHJmHkZEhnuIw/7abtd3triDgJM9D6ivhfLztrWox
         TFeONeDkaKLr5LMFrV+pPofSgbqMU8aobivE2FtaqyIweumhjhhQ2yaOVIkxhE2NJP
         HBj59ZbOXOQJNLir0MAS4p9DAoFr44EUJlZKdMT7LqkJ/V2qdzgP6NYpgb/9Vrge6f
         7qgitPxEOtCbWl7nr8kdeE1NUw/niKoPusa/QqKUHfLeSQpXCwDpGJr7EuY4OXtPhs
         b37nSaPmcFyLA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9alOr1743044;
        Sat, 18 May 2019 02:36:47 -0700
Date:   Sat, 18 May 2019 02:36:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, yao.jin@linux.intel.com, yao.jin@intel.com,
        kan.liang@linux.intel.com, jolsa@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, ravi.bangoria@linux.ibm.com
Reply-To: kan.liang@linux.intel.com, jolsa@kernel.org,
          ravi.bangoria@linux.ibm.com, peterz@infradead.org,
          ak@linux.intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, yao.jin@intel.com,
          tglx@linutronix.de, mingo@kernel.org, yao.jin@linux.intel.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com
In-Reply-To: <1555077590-27664-4-git-send-email-yao.jin@linux.intel.com>
References: <1555077590-27664-4-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Support 'percore' event qualifier
Git-Commit-ID: 4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c
Gitweb:     https://git.kernel.org/tip/4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 12 Apr 2019 21:59:49 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:24 -0300

perf stat: Support 'percore' event qualifier

With this patch, we can use the 'percore' event qualifier in perf-stat.

  root@skl:/tmp# perf stat -e cpu/event=0,umask=0x3,percore=1/,cpu/event=0,umask=0x3/ -a -A -I1000
    1.000773050 S0-C0   98,352,832 cpu/event=0,umask=0x3,percore=1/  (50.01%)
    1.000773050 S0-C1  103,763,057 cpu/event=0,umask=0x3,percore=1/  (50.02%)
    1.000773050 S0-C2  196,776,995 cpu/event=0,umask=0x3,percore=1/  (50.02%)
    1.000773050 S0-C3  176,493,779 cpu/event=0,umask=0x3,percore=1/  (50.02%)
    1.000773050 CPU0    47,699,641 cpu/event=0,umask=0x3/            (50.02%)
    1.000773050 CPU1    49,052,451 cpu/event=0,umask=0x3/            (49.98%)
    1.000773050 CPU2   102,771,422 cpu/event=0,umask=0x3/            (49.98%)
    1.000773050 CPU3   100,784,662 cpu/event=0,umask=0x3/            (49.98%)
    1.000773050 CPU4    43,171,342 cpu/event=0,umask=0x3/            (49.98%)
    1.000773050 CPU5    54,152,158 cpu/event=0,umask=0x3/            (49.98%)
    1.000773050 CPU6    93,618,410 cpu/event=0,umask=0x3/            (49.98%)
    1.000773050 CPU7    74,477,589 cpu/event=0,umask=0x3/            (49.99%)

In this example, we count the event 'ref-cycles' per-core and per-CPU in
one perf stat command-line. From the output, we can see:

  S0-C0 = CPU0 + CPU4
  S0-C1 = CPU1 + CPU5
  S0-C2 = CPU2 + CPU6
  S0-C3 = CPU3 + CPU7

So the result is expected (tiny difference is ignored).

Note that, the 'percore' event qualifier needs to use with option '-A'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1555077590-27664-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 21 +++++++++++++++++
 tools/perf/util/stat-display.c         | 43 ++++++++++++++++++++++++++++++----
 tools/perf/util/stat.c                 |  8 ++++---
 4 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 39c05f89104e..1e312c2672e4 100644
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
index a3c060878faa..24b8e690fb69 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -847,6 +847,18 @@ static int perf_stat__get_core_cached(struct perf_stat_config *config,
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
@@ -867,6 +879,15 @@ static int perf_stat_init_aggr_mode(void)
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
index f5b4ee79568c..4c53bae5644b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -88,9 +88,17 @@ static void aggr_printout(struct perf_stat_config *config,
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
@@ -1103,6 +1111,30 @@ static void print_footer(struct perf_stat_config *config)
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
@@ -1153,7 +1185,10 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_no_aggr_metric(config, evlist, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
-				print_counter(config, counter, prefix);
+				if (counter->percore)
+					print_percore(config, counter, prefix);
+				else
+					print_counter(config, counter, prefix);
 			}
 		}
 		break;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 2856cc9d5a31..c3115d939b0b 100644
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
