Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F0C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4248422DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567582470;
	bh=L5np5J/F+d5iI+6U57BfMU0ttF24hYKALFBoDWT/ftw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mX4ncLGZuOI2ENQauBIrRjtjQen9C2nmgZ4Anef4D7gjn+2YKVElxGIOb4w+bFB9e
	 aBHZoYDl7txFDXDahu4DMgm6n8JXupees+cbO6LD1aRHUWXh5g1hQGHTLAlptZPt+a
	 zlYEE738mXW4hFiANwsjWTLN9Ua3JIwp612e5Xmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfIDHe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfIDHe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:34:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90CA33082E20;
        Wed,  4 Sep 2019 07:34:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 288D260126;
        Wed,  4 Sep 2019 07:34:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 3/3] perf stat: Add --per-node agregation support
Date:   Wed,  4 Sep 2019 09:34:15 +0200
Message-Id: <20190904073415.723-4-jolsa@kernel.org>
In-Reply-To: <20190904073415.723-1-jolsa@kernel.org>
References: <20190904073415.723-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 04 Sep 2019 07:34:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new --per-node option to aggregate counts per NUMA
nodes for system-wide mode measurements.

You can specify --per-node in live mode:

  # perf stat  -a -I 1000 -e cycles --per-node
  #           time node   cpus             counts unit events
       1.000542550 N0       20          6,202,097      cycles
       1.000542550 N1       20            639,559      cycles
       2.002040063 N0       20          7,412,495      cycles
       2.002040063 N1       20          2,185,577      cycles
       3.003451699 N0       20          6,508,917      cycles
       3.003451699 N1       20            765,607      cycles
  ...

Or in the record/report stat session:

  # perf stat record -a -I 1000 -e cycles
  #           time             counts unit events
       1.000536937         10,008,468      cycles
       2.002090152          9,578,539      cycles
       3.003625233          7,647,869      cycles
       4.005135036          7,032,086      cycles
  ^C     4.340902364          3,923,893      cycles

  # perf stat report --per-node
  #           time node   cpus             counts unit events
       1.000536937 N0       20          9,355,086      cycles
       1.000536937 N1       20            653,382      cycles
       2.002090152 N0       20          7,712,838      cycles
       2.002090152 N1       20          1,865,701      cycles
       3.003625233 N0       20          6,604,441      cycles
       3.003625233 N1       20          1,043,428      cycles
       4.005135036 N0       20          6,350,522      cycles
       4.005135036 N1       20            681,564      cycles
       4.340902364 N0       20          3,403,188      cycles
       4.340902364 N1       20            520,705      cycles

Link: http://lkml.kernel.org/n/tip-h57ftv8vmqrgzz3kdvlvh4yk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++
 tools/perf/builtin-stat.c              | 52 ++++++++++++++++++++++++++
 tools/perf/util/cpumap.c               | 18 +++++++++
 tools/perf/util/cpumap.h               |  3 ++
 tools/perf/util/stat-display.c         | 15 ++++++++
 tools/perf/util/stat.c                 |  1 +
 tools/perf/util/stat.h                 |  1 +
 7 files changed, 95 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 930c51c01201..277f7e94f7d8 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -217,6 +217,11 @@ core number and the number of online logical processors on that physical process
 Aggregate counts per monitored threads, when monitoring threads (-t option)
 or processes (-p option).
 
+--per-node::
+Aggregate counts per NUMA nodes for system-wide mode measurements. This
+is a useful mode to detect imbalance between NUMA nodes. To enable this
+mode, use --per-node in addition to -a. (system-wide).
+
 -D msecs::
 --delay msecs::
 After starting the program, wait msecs before measuring. This is useful to
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5bc0c570b7b6..bfade49955ac 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -790,6 +790,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
 		     "aggregate counts per thread", AGGR_THREAD),
+	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
+		     "aggregate counts per numa node", AGGR_NODE),
 	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
 		     "ms to wait before starting measurement after program start"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
@@ -822,6 +824,12 @@ static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 	return cpu_map__get_core(map, cpu, NULL);
 }
 
+static int perf_stat__get_node(struct perf_stat_config *config __maybe_unused,
+			       struct perf_cpu_map *map, int cpu)
+{
+	return cpu_map__get_node(map, cpu, NULL);
+}
+
 static int perf_stat__get_aggr(struct perf_stat_config *config,
 			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
 {
@@ -856,6 +864,12 @@ static int perf_stat__get_core_cached(struct perf_stat_config *config,
 	return perf_stat__get_aggr(config, perf_stat__get_core, map, idx);
 }
 
+static int perf_stat__get_node_cached(struct perf_stat_config *config,
+				      struct perf_cpu_map *map, int idx)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_node, map, idx);
+}
+
 static bool term_percore_set(void)
 {
 	struct evsel *counter;
@@ -894,6 +908,13 @@ static int perf_stat_init_aggr_mode(void)
 		}
 		stat_config.aggr_get_id = perf_stat__get_core_cached;
 		break;
+	case AGGR_NODE:
+		if (cpu_map__build_node_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
+			perror("cannot build core map");
+			return -1;
+		}
+		stat_config.aggr_get_id = perf_stat__get_node_cached;
+		break;
 	case AGGR_NONE:
 		if (term_percore_set()) {
 			if (cpu_map__build_core_map(evsel_list->core.cpus,
@@ -1006,6 +1027,13 @@ static int perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
 	return core;
 }
 
+static int perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
+{
+	int cpu = perf_env__get_cpu(data, map, idx);
+
+	return perf_env__numa_node(data, cpu);
+}
+
 static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				      struct perf_cpu_map **sockp)
 {
@@ -1024,6 +1052,12 @@ static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *c
 	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
 }
 
+static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
+				    struct perf_cpu_map **nodep)
+{
+	return cpu_map__build_map(cpus, nodep, perf_env__get_node, env);
+}
+
 static int perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
 				      struct perf_cpu_map *map, int idx)
 {
@@ -1041,6 +1075,12 @@ static int perf_stat__get_core_file(struct perf_stat_config *config __maybe_unus
 	return perf_env__get_core(map, idx, &perf_stat.session->header.env);
 }
 
+static int perf_stat__get_node_file(struct perf_stat_config *config __maybe_unused,
+				    struct perf_cpu_map *map, int idx)
+{
+	return perf_env__get_node(map, idx, &perf_stat.session->header.env);
+}
+
 static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 {
 	struct perf_env *env = &st->session->header.env;
@@ -1067,6 +1107,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 		}
 		stat_config.aggr_get_id = perf_stat__get_core_file;
 		break;
+	case AGGR_NODE:
+		if (perf_env__build_node_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
+			perror("cannot build core map");
+			return -1;
+		}
+		stat_config.aggr_get_id = perf_stat__get_node_file;
+		break;
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
@@ -1614,6 +1661,8 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per processor die", AGGR_DIE),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
+	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
+		     "aggregate counts per numa node", AGGR_NODE),
 	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
 		     "disable CPU count aggregation", AGGR_NONE),
 	OPT_END()
@@ -1888,6 +1937,9 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
+	if (stat_config.aggr_mode == AGGR_NODE)
+		cpu__setup_cpunode_map();
+
 	if (stat_config.times && interval)
 		interval_count = true;
 	else if (stat_config.times && !interval) {
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index a22c1114e880..e44ab6ee17fb 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -206,6 +206,11 @@ int cpu_map__get_core_id(int cpu)
 	return ret ?: value;
 }
 
+int cpu_map__get_node_id(int cpu)
+{
+	return cpu__get_node(cpu);
+}
+
 int cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
 {
 	int cpu, s_die;
@@ -235,6 +240,14 @@ int cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
 	return (s_die << 16) | (cpu & 0xffff);
 }
 
+int cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
+{
+	if (idx < 0 || idx >= map->nr)
+		return -1;
+
+	return cpu_map__get_node_id(map->map[idx]);
+}
+
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct perf_cpu_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
@@ -250,6 +263,11 @@ int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **cor
 	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
 }
 
+int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct perf_cpu_map **nodep)
+{
+	return cpu_map__build_map(cpus, nodep, cpu_map__get_node, NULL);
+}
+
 /* setup simple routines to easily access node numbers given a cpu number */
 static int get_max_num(char *path, int *max)
 {
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 2553bef1279d..57943f3685f8 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -20,9 +20,12 @@ int cpu_map__get_die_id(int cpu);
 int cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
+int cpu_map__get_node_id(int cpu);
+int cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct perf_cpu_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct perf_cpu_map **diep);
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **corep);
+int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct perf_cpu_map **nodep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
 static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ed3b0ac2f785..bc31fccc0057 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -100,6 +100,15 @@ static void aggr_printout(struct perf_stat_config *config,
 			nr,
 			config->csv_sep);
 			break;
+	case AGGR_NODE:
+		fprintf(config->output, "N%*d%s%*d%s",
+			config->csv_output ? 0 : -5,
+			id,
+			config->csv_sep,
+			config->csv_output ? 0 : 4,
+			nr,
+			config->csv_sep);
+			break;
 	case AGGR_NONE:
 		if (evsel->percore) {
 			fprintf(config->output, "S%d-D%d-C%*d%s",
@@ -965,6 +974,11 @@ static void print_interval(struct perf_stat_config *config,
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
+		case AGGR_NODE:
+			fprintf(output, "#           time node   cpus");
+			if (!metric_only)
+				fprintf(output, "             counts %*s events\n", unit_width, "unit");
+			break;
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
 			if (!metric_only)
@@ -1188,6 +1202,7 @@ perf_evlist__print_counters(struct evlist *evlist,
 	case AGGR_CORE:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
+	case AGGR_NODE:
 		print_aggr(config, evlist, prefix);
 		break;
 	case AGGR_THREAD:
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8f1ea27f976f..839d1dd6794a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -281,6 +281,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	case AGGR_CORE:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
+	case AGGR_NODE:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
 			perf_evsel__compute_deltas(evsel, cpu, thread, count);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 14fe3e548229..2ddaefe93cc8 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -46,6 +46,7 @@ enum aggr_mode {
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
+	AGGR_NODE,
 };
 
 enum {
-- 
2.21.0

