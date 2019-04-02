Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EAC2148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221191;
	bh=qxw/ILqrK98JXPMqBCbN7B+UA1DlIz+PKbBgPX3ntOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nypd0Er38XJxHFmcKkPY73Ac4gBiZdCMK5CVFKOvmNj3oBzxO5dU7KbrsmKHymx4M
	 SveaqudMJq1t91vjP5S3AsIaRQxWV8qc+XWkF5nLA3a73KkIBHKsJpd6pOZLi0GbVI
	 l9My9cbFPLhhJz3r/q4PqYra+s00DTKoCEAtc/FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfDBQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbfDBQG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:28 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8884A20840;
        Tue,  2 Apr 2019 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221187;
        bh=qxw/ILqrK98JXPMqBCbN7B+UA1DlIz+PKbBgPX3ntOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJdH4INMfQf3Mbyn2JeG4meMwq2IaGkmED766B4/46lDoTDJvGketXOV1Xv0CnQNA
         fabmAKro9EVEtg5nOl7yVfT5sEwwDiuDNcCquTAZg3IkHGwMdAHg3Y7oj5/NTGqb9w
         HvrCC0Yh1IN5OSRA9Mzwl3E6Eix600sYVAwr21rU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/44] perf stat: Implement duration_time as a proper event
Date:   Tue,  2 Apr 2019 13:05:13 -0300
Message-Id: <20190402160549.13544-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The perf metric expression use 'duration_time' internally to normalize
events.  Normal 'perf stat' without -x also prints the duration time.
But when using -x, the interval is not output anywhere, which is
inconvenient for any post processing which often wants to normalize
values to time.

So implement 'duration_time' as a proper perf event that can be
specified explicitely with -e.

The previous implementation of 'duration_time' only worked for metric
processing. This adds the concept of a tool event that is handled by the
tool. On the kernel level it is still mapped to the dummy software
event, but the values are not read anymore, but instead computed by the
tool.

Add proper plumbing to handle this in the event parser, and display it
in 'perf stat'. We don't want 'duration_time' to be added up, so it's
only printed for the first CPU.

% perf stat -e duration_time,cycles true

 Performance counter stats for 'true':

           555,476 ns   duration_time
           771,958      cycles

       0.000555476 seconds time elapsed

       0.000644000 seconds user
       0.000000000 seconds sys

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c      | 28 ++++++++++++++++++-------
 tools/perf/util/evsel.h        |  6 ++++++
 tools/perf/util/parse-events.c | 38 +++++++++++++++++++++++++++++-----
 tools/perf/util/parse-events.h |  4 ++++
 tools/perf/util/parse-events.l | 11 +++++++++-
 tools/perf/util/parse-events.y | 12 +++++++++++
 6 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 49ee3c2033ec..7f9c4b7f5d69 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -244,11 +244,25 @@ perf_evsel__write_stat_event(struct perf_evsel *counter, u32 cpu, u32 thread,
 					   process_synthesized_event, NULL);
 }
 
+static int read_single_counter(struct perf_evsel *counter, int cpu,
+			       int thread, struct timespec *rs)
+{
+	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
+		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
+		struct perf_counts_values *count =
+			perf_counts(counter->counts, cpu, thread);
+		count->ena = count->run = val;
+		count->val = val;
+		return 0;
+	}
+	return perf_evsel__read_counter(counter, cpu, thread);
+}
+
 /*
  * Read out the results of a single counter:
  * do not aggregate counts across CPUs in system-wide mode
  */
-static int read_counter(struct perf_evsel *counter)
+static int read_counter(struct perf_evsel *counter, struct timespec *rs)
 {
 	int nthreads = thread_map__nr(evsel_list->threads);
 	int ncpus, cpu, thread;
@@ -275,7 +289,7 @@ static int read_counter(struct perf_evsel *counter)
 			 * (via perf_evsel__read_counter) and sets threir count->loaded.
 			 */
 			if (!count->loaded &&
-			    perf_evsel__read_counter(counter, cpu, thread)) {
+			    read_single_counter(counter, cpu, thread, rs)) {
 				counter->counts->scaled = -1;
 				perf_counts(counter->counts, cpu, thread)->ena = 0;
 				perf_counts(counter->counts, cpu, thread)->run = 0;
@@ -304,13 +318,13 @@ static int read_counter(struct perf_evsel *counter)
 	return 0;
 }
 
-static void read_counters(void)
+static void read_counters(struct timespec *rs)
 {
 	struct perf_evsel *counter;
 	int ret;
 
 	evlist__for_each_entry(evsel_list, counter) {
-		ret = read_counter(counter);
+		ret = read_counter(counter, rs);
 		if (ret)
 			pr_debug("failed to read counter %s\n", counter->name);
 
@@ -323,11 +337,11 @@ static void process_interval(void)
 {
 	struct timespec ts, rs;
 
-	read_counters();
-
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
+	read_counters(&rs);
+
 	if (STAT_RECORD) {
 		if (WRITE_STAT_ROUND_EVENT(rs.tv_sec * NSEC_PER_SEC + rs.tv_nsec, INTERVAL))
 			pr_err("failed to write stat round event\n");
@@ -593,7 +607,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * avoid arbitrary skew, we must read all counters before closing any
 	 * group leaders.
 	 */
-	read_counters();
+	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
 	perf_evlist__close(evsel_list);
 
 	return WEXITSTATUS(status);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0f2c6c93d721..6d190cbf1070 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -75,6 +75,11 @@ struct perf_stat_evsel;
 
 typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
 
+enum perf_tool_event {
+	PERF_TOOL_NONE		= 0,
+	PERF_TOOL_DURATION_TIME = 1,
+};
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -121,6 +126,7 @@ struct perf_evsel {
 	unsigned int		sample_size;
 	int			id_pos;
 	int			is_pos;
+	enum perf_tool_event	tool_event;
 	bool			uniquified_name;
 	bool			snapshot;
 	bool 			supported;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5ef4939408f2..98c0fadaedb9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -317,10 +317,12 @@ static struct perf_evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    char *name, struct perf_pmu *pmu,
-	    struct list_head *config_terms, bool auto_merge_stats)
+	    struct list_head *config_terms, bool auto_merge_stats,
+	    const char *cpu_list)
 {
 	struct perf_evsel *evsel;
-	struct cpu_map *cpus = pmu ? pmu->cpus : NULL;
+	struct cpu_map *cpus = pmu ? pmu->cpus :
+			       cpu_list ? cpu_map__new(cpu_list) : NULL;
 
 	event_attr_init(attr);
 
@@ -348,7 +350,25 @@ static int add_event(struct list_head *list, int *idx,
 		     struct perf_event_attr *attr, char *name,
 		     struct list_head *config_terms)
 {
-	return __add_event(list, idx, attr, name, NULL, config_terms, false) ? 0 : -ENOMEM;
+	return __add_event(list, idx, attr, name, NULL, config_terms, false, NULL) ? 0 : -ENOMEM;
+}
+
+static int add_event_tool(struct list_head *list, int *idx,
+			  enum perf_tool_event tool_event)
+{
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_DUMMY,
+	};
+
+	evsel = __add_event(list, idx, &attr, NULL, NULL, NULL, false, "0");
+	if (!evsel)
+		return -ENOMEM;
+	evsel->tool_event = tool_event;
+	if (tool_event == PERF_TOOL_DURATION_TIME)
+		evsel->unit = strdup("ns");
+	return 0;
 }
 
 static int parse_aliases(char *str, const char *names[][PERF_EVSEL__MAX_ALIASES], int size)
@@ -1233,6 +1253,13 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			 get_config_name(head_config), &config_terms);
 }
 
+int parse_events_add_tool(struct parse_events_state *parse_state,
+			  struct list_head *list,
+			  enum perf_tool_event tool_event)
+{
+	return add_event_tool(list, &parse_state->idx, tool_event);
+}
+
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
@@ -1267,7 +1294,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	if (!head_config) {
 		attr.type = pmu->type;
-		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL, auto_merge_stats);
+		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
+				    auto_merge_stats, NULL);
 		if (evsel) {
 			evsel->pmu_name = name;
 			evsel->use_uncore_alias = use_uncore_alias;
@@ -1295,7 +1323,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	evsel = __add_event(list, &parse_state->idx, &attr,
 			    get_config_name(head_config), pmu,
-			    &config_terms, auto_merge_stats);
+			    &config_terms, auto_merge_stats, NULL);
 	if (evsel) {
 		evsel->unit = info.unit;
 		evsel->scale = info.scale;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ed035cbcbb7..0c1f5b98f636 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -160,6 +160,10 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
 			     struct list_head *head_config);
+enum perf_tool_event;
+int parse_events_add_tool(struct parse_events_state *parse_state,
+			  struct list_head *list,
+			  enum perf_tool_event tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *error,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7805c71aaae2..c54bfe88626c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -15,6 +15,7 @@
 #include "../perf.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
+#include "evsel.h"
 
 char *parse_events_get_text(yyscan_t yyscanner);
 YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
@@ -154,6 +155,14 @@ static int sym(yyscan_t scanner, int type, int config)
 	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
 }
 
+static int tool(yyscan_t scanner, enum perf_tool_event event)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+
+	yylval->num = event;
+	return PE_VALUE_SYM_TOOL;
+}
+
 static int term(yyscan_t scanner, int type)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
@@ -322,7 +331,7 @@ cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COU
 alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
 emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
-duration_time					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
+duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
 
 	/*
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 44819bdb037d..6ad8d4914969 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include "util.h"
 #include "pmu.h"
+#include "evsel.h"
 #include "debug.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
@@ -45,6 +46,7 @@ static void inc_group_count(struct list_head *list,
 
 %token PE_START_EVENTS PE_START_TERMS
 %token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_RAW PE_TERM
+%token PE_VALUE_SYM_TOOL
 %token PE_EVENT_NAME
 %token PE_NAME
 %token PE_BPF_OBJECT PE_BPF_SOURCE
@@ -58,6 +60,7 @@ static void inc_group_count(struct list_head *list,
 %type <num> PE_VALUE
 %type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
+%type <num> PE_VALUE_SYM_TOOL
 %type <num> PE_RAW
 %type <num> PE_TERM
 %type <str> PE_NAME
@@ -321,6 +324,15 @@ value_sym sep_slash_slash_dc
 	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config, NULL));
 	$$ = list;
 }
+|
+PE_VALUE_SYM_TOOL sep_slash_slash_dc
+{
+	struct list_head *list;
+
+	ALLOC_LIST(list);
+	ABORT_ON(parse_events_add_tool(_parse_state, list, $1));
+	$$ = list;
+}
 
 event_legacy_cache:
 PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_event_config
-- 
2.20.1

