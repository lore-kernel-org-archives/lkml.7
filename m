Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E28CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C822067B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfJVAFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbfJVAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwz-0003wV-LP; Tue, 22 Oct 2019 01:18:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A2B11C03AB;
        Tue, 22 Oct 2019 01:18:57 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:56 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf list: Hide deprecated events by default
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191015025357.8708-1-yao.jin@linux.intel.com>
References: <20191015025357.8708-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157169993657.29376.3461797823282165805.tip-bot2@tip-bot2>
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

Commit-ID:     a7f6c8c81afdd6d24eb12558f2fb66901207d349
Gitweb:        https://git.kernel.org/tip/a7f6c8c81afdd6d24eb12558f2fb66901207d349
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Tue, 15 Oct 2019 10:53:57 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

perf list: Hide deprecated events by default

There are some deprecated events listed by perf list. But we can't
remove them from perf list with ease because some old scripts may use
them.

Deprecated events are old names of renamed events.  When an event gets
renamed the old name is kept around for some time and marked with
Deprecated. The newer Intel event lists in the tree already have these
headers.

So we need to keep them in the event list, but provide a new option to
show them. The new option is "--deprecated".

With this patch, the deprecated events are hidden by default but they
can be displayed when option "--deprecated" is enabled.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191015025357.8708-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  3 +++-
 tools/perf/builtin-list.c              | 14 +++++++++----
 tools/perf/pmu-events/jevents.c        | 26 +++++++++++++++++++------
 tools/perf/pmu-events/jevents.h        |  3 ++-
 tools/perf/pmu-events/pmu-events.h     |  1 +-
 tools/perf/util/parse-events.c         |  4 ++--
 tools/perf/util/parse-events.h         |  2 +-
 tools/perf/util/pmu.c                  | 17 ++++++++++++----
 tools/perf/util/pmu.h                  |  4 +++-
 9 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 18ed1b0..6345db3 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -36,6 +36,9 @@ Enable debugging output.
 Print how named events are resolved internally into perf events, and also
 any extra expressions computed by perf stat.
 
+--deprecated::
+Print deprecated events. By default the deprecated events are hidden.
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 08e62ae..965ef01 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -26,6 +26,7 @@ int cmd_list(int argc, const char **argv)
 	int i;
 	bool raw_dump = false;
 	bool long_desc_flag = false;
+	bool deprecated = false;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
 		OPT_BOOLEAN('d', "desc", &desc_flag,
@@ -34,6 +35,8 @@ int cmd_list(int argc, const char **argv)
 			    "Print longer event descriptions."),
 		OPT_BOOLEAN(0, "details", &details_flag,
 			    "Print information on the perf event names and expressions used internally by events."),
+		OPT_BOOLEAN(0, "deprecated", &deprecated,
+			    "Print deprecated events."),
 		OPT_INCR(0, "debug", &verbose,
 			     "Enable debugging output"),
 		OPT_END()
@@ -55,7 +58,7 @@ int cmd_list(int argc, const char **argv)
 
 	if (argc == 0) {
 		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
-				details_flag);
+				details_flag, deprecated);
 		return 0;
 	}
 
@@ -78,7 +81,8 @@ int cmd_list(int argc, const char **argv)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
 			print_pmu_events(NULL, raw_dump, !desc_flag,
-						long_desc_flag, details_flag);
+						long_desc_flag, details_flag,
+						deprecated);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
@@ -91,7 +95,8 @@ int cmd_list(int argc, const char **argv)
 			if (sep == NULL) {
 				print_events(argv[i], raw_dump, !desc_flag,
 							long_desc_flag,
-							details_flag);
+							details_flag,
+							deprecated);
 				continue;
 			}
 			sep_idx = sep - argv[i];
@@ -117,7 +122,8 @@ int cmd_list(int argc, const char **argv)
 			print_hwcache_events(s, raw_dump);
 			print_pmu_events(s, raw_dump, !desc_flag,
 						long_desc_flag,
-						details_flag);
+						details_flag,
+						deprecated);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
 			metricgroup__print(true, true, s, raw_dump, details_flag);
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e283726..7d69727 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -322,7 +322,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *desc, char *long_desc,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
-				    char *metric_name, char *metric_group)
+				    char *metric_name, char *metric_group,
+				    char *deprecated)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -354,6 +355,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_name = \"%s\",\n", metric_name);
 	if (metric_group)
 		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
+	if (deprecated)
+		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -371,6 +374,7 @@ struct event_struct {
 	char *metric_expr;
 	char *metric_name;
 	char *metric_group;
+	char *deprecated;
 };
 
 #define ADD_EVENT_FIELD(field) do { if (field) {		\
@@ -398,6 +402,7 @@ struct event_struct {
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
+	op(deprecated);						\
 } while (0)
 
 static LIST_HEAD(arch_std_events);
@@ -416,7 +421,8 @@ static void free_arch_std_events(void)
 static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group)
+				char *metric_name, char *metric_group,
+				char *deprecated)
 {
 	struct event_struct *es;
 
@@ -479,7 +485,8 @@ static int
 try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
 	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
-	  char **metric_group, unsigned long long eventcode)
+	  char **metric_group, unsigned long long eventcode,
+	  char **deprecated)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -507,7 +514,8 @@ int json_events(const char *fn,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
-		      char *metric_name, char *metric_group),
+		      char *metric_name, char *metric_group,
+		      char *deprecated),
 	  void *data)
 {
 	int err;
@@ -536,6 +544,7 @@ int json_events(const char *fn,
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
 		char *metric_group = NULL;
+		char *deprecated = NULL;
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
@@ -614,6 +623,8 @@ int json_events(const char *fn,
 				addfield(map, &unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
 				addfield(map, &perpkg, "", "", val);
+			} else if (json_streq(map, field, "Deprecated")) {
+				addfield(map, &deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
 				addfield(map, &metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
@@ -658,12 +669,14 @@ int json_events(const char *fn,
 			err = try_fixup(fn, arch_std, &event, &desc, &name,
 					&long_desc, &pmu, &filter, &perpkg,
 					&unit, &metric_expr, &metric_name,
-					&metric_group, eventcode);
+					&metric_group, eventcode,
+					&deprecated);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
+			   pmu, unit, perpkg, metric_expr, metric_name,
+			   metric_group, deprecated);
 free_strings:
 		free(event);
 		free(desc);
@@ -673,6 +686,7 @@ free_strings:
 		free(pmu);
 		free(filter);
 		free(perpkg);
+		free(deprecated);
 		free(unit);
 		free(metric_expr);
 		free(metric_name);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 4684c67..5cda49a 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -7,7 +7,8 @@ int json_events(const char *fn,
 				char *long_desc,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group),
+				char *metric_name, char *metric_group,
+				char *deprecated),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 92a4d15..caeb577 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -17,6 +17,7 @@ struct pmu_event {
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_group;
+	const char *deprecated;
 };
 
 /*
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b5e2ade..db882f6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2600,7 +2600,7 @@ out_enomem:
  * Print the help text for the event symbols:
  */
 void print_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag)
+			bool long_desc, bool details_flag, bool deprecated)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -2612,7 +2612,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 	print_hwcache_events(event_glob, name_only);
 
 	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
-			details_flag);
+			details_flag, deprecated);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 616ca1e..769e07c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -195,7 +195,7 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
 void print_events(const char *event_glob, bool name_only, bool quiet,
-		  bool long_desc, bool details_flag);
+		  bool long_desc, bool details_flag, bool deprecated);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5608da8..adbe97e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -308,7 +308,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *long_desc, char *topic,
 				 char *unit, char *perpkg,
 				 char *metric_expr,
-				 char *metric_name)
+				 char *metric_name,
+				 char *deprecated)
 {
 	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
@@ -325,6 +326,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->unit[0] = '\0';
 	alias->per_pkg = false;
 	alias->snapshot = false;
+	alias->deprecated = false;
 
 	ret = parse_events_terms(&alias->terms, val);
 	if (ret) {
@@ -379,6 +381,9 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
 
+	if (deprecated)
+		alias->deprecated = true;
+
 	if (!perf_pmu_merge_alias(alias, list))
 		list_add_tail(&alias->list, list);
 
@@ -400,7 +405,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 	strim(buf);
 
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
-				     NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -787,7 +792,8 @@ new_alias:
 				(char *)pe->long_desc, (char *)pe->topic,
 				(char *)pe->unit, (char *)pe->perpkg,
 				(char *)pe->metric_expr,
-				(char *)pe->metric_name);
+				(char *)pe->metric_name,
+				(char *)pe->deprecated);
 	}
 }
 
@@ -1383,7 +1389,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 }
 
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag)
+			bool long_desc, bool details_flag, bool deprecated)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1414,6 +1420,9 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 				format_alias(buf, sizeof(buf), pmu, alias);
 			bool is_cpu = !strcmp(pmu->name, "cpu");
 
+			if (alias->deprecated && !deprecated)
+				continue;
+
 			if (event_glob != NULL &&
 			    !(strglobmatch_nocase(name, event_glob) ||
 			      (!is_cpu && strglobmatch_nocase(alias->name,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f36ade6..3e8cd31 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -57,6 +57,7 @@ struct perf_pmu_alias {
 	double scale;
 	bool per_pkg;
 	bool snapshot;
+	bool deprecated;
 	char *metric_expr;
 	char *metric_name;
 };
@@ -85,7 +86,8 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
-		      bool long_desc, bool details_flag);
+		      bool long_desc, bool details_flag,
+		      bool deprecated);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
