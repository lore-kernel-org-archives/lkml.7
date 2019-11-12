Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5545DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223BD22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKLLST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKLLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBP-0000Q8-9H; Tue, 12 Nov 2019 12:18:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4F16D1C047B;
        Tue, 12 Nov 2019 12:18:00 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:59 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf stat: Add --per-node agregation support
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190904073415.723-4-jolsa@kernel.org>
References: <20190904073415.723-4-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157355747983.29376.15354432562328477493.tip-bot2@tip-bot2>
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

Commit-ID:     86895b480a2f10c7c6659fc5312f84b93011ce2d
Gitweb:        https://git.kernel.org/tip/86895b480a2f10c7c6659fc5312f84b93011ce2d
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 10:17:43 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:49:39 -03:00

perf stat: Add --per-node agregation support

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20190904073415.723-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 ++-
 tools/perf/builtin-stat.c              | 52 +++++++++++++++++++++++++-
 tools/perf/util/cpumap.c               | 18 +++++++++-
 tools/perf/util/cpumap.h               |  3 +-
 tools/perf/util/stat-display.c         | 15 +++++++-
 tools/perf/util/stat.c                 |  1 +-
 tools/perf/util/stat.h                 |  1 +-
 7 files changed, 95 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index a9af4e4..9431b80 100644
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
index c88d4e1..5964e80 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -792,6 +792,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
 		     "aggregate counts per thread", AGGR_THREAD),
+	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
+		     "aggregate counts per numa node", AGGR_NODE),
 	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
 		     "ms to wait before starting measurement after program start"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
@@ -830,6 +832,12 @@ static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
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
@@ -864,6 +872,12 @@ static int perf_stat__get_core_cached(struct perf_stat_config *config,
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
@@ -902,6 +916,13 @@ static int perf_stat_init_aggr_mode(void)
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
@@ -1014,6 +1035,13 @@ static int perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
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
@@ -1032,6 +1060,12 @@ static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *c
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
@@ -1049,6 +1083,12 @@ static int perf_stat__get_core_file(struct perf_stat_config *config __maybe_unus
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
@@ -1075,6 +1115,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
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
@@ -1622,6 +1669,8 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per processor die", AGGR_DIE),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
+	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
+		     "aggregate counts per numa node", AGGR_NODE),
 	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
 		     "disable CPU count aggregation", AGGR_NONE),
 	OPT_END()
@@ -1896,6 +1945,9 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
+	if (stat_config.aggr_mode == AGGR_NODE)
+		cpu__setup_cpunode_map();
+
 	if (stat_config.times && interval)
 		interval_count = true;
 	else if (stat_config.times && !interval) {
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index a22c111..983b738 100644
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
 
+int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct perf_cpu_map **numap)
+{
+	return cpu_map__build_map(cpus, numap, cpu_map__get_node, NULL);
+}
+
 /* setup simple routines to easily access node numbers given a cpu number */
 static int get_max_num(char *path, int *max)
 {
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 2553bef..57943f3 100644
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
index ed3b0ac..bc31fcc 100644
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
index 6822e4f..332cb73 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -299,6 +299,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	case AGGR_CORE:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
+	case AGGR_NODE:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
 			perf_evsel__compute_deltas(evsel, cpu, thread, count);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 081c4a5..bfa9aaf 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -47,6 +47,7 @@ enum aggr_mode {
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
+	AGGR_NODE,
 };
 
 enum {
