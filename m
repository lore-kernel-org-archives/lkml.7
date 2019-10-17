Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA8DFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4DE2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437228AbfJQNxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:53:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:37761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbfJQNxP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:53:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 06:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,307,1566889200"; 
   d="scan'208";a="208285870"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2019 06:53:12 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf list: Separate the deprecated events
Date:   Thu, 17 Oct 2019 21:52:14 +0800
Message-Id: <20191017135214.18620-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some deprecated events listed by perf list. But we can't remove
them from perf list with ease because some old scripts may use them.

Deprecated events are old names of renamed events.  When an event gets
renamed the old name is kept around for some time and marked with
Deprecated. The newer Intel event lists in the tree already have these
headers.

So we need to keep them in the event list, but show them in a separate
area.

For example,

  --- Following are deprecated events ---

  cache:
    l2_lines_out.useless_pref
         [This event is deprecated. Refer to new event L2_LINES_OUT.USELESS_HWPF]
    ...

  memory:
    ...

  pipeline:
    ...

 v2:
 ---
 In v1, the deprecated events are hidden by default but they can be
 displayed when option "--deprecated" is enabled. In v2, we don't use
 the new option "--deprecated". Instead, we just display the deprecated
 events under the title "--- Following are deprecated events ---".

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c    |  26 ++++--
 tools/perf/pmu-events/jevents.h    |   3 +-
 tools/perf/pmu-events/pmu-events.h |   1 +
 tools/perf/util/pmu.c              | 124 +++++++++++++++++++----------
 tools/perf/util/pmu.h              |   1 +
 5 files changed, 107 insertions(+), 48 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e2837260ca4d..7d69727f44bd 100644
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
@@ -673,6 +686,7 @@ int json_events(const char *fn,
 		free(pmu);
 		free(filter);
 		free(perpkg);
+		free(deprecated);
 		free(unit);
 		free(metric_expr);
 		free(metric_name);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 4684c673c445..5cda49a42143 100644
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
index 92a4d15ee0b9..caeb577d36c9 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -17,6 +17,7 @@ struct pmu_event {
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_group;
+	const char *deprecated;
 };
 
 /*
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5608da82ad23..6d80166ba326 100644
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
@@ -787,7 +792,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 				(char *)pe->long_desc, (char *)pe->topic,
 				(char *)pe->unit, (char *)pe->perpkg,
 				(char *)pe->metric_expr,
-				(char *)pe->metric_name);
+				(char *)pe->metric_name,
+				(char *)pe->deprecated);
 	}
 }
 
@@ -1342,6 +1348,7 @@ struct sevent {
 	char *pmu;
 	char *metric_expr;
 	char *metric_name;
+	bool deprecated;
 };
 
 static int cmp_sevent(const void *a, const void *b)
@@ -1382,18 +1389,78 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
+static void print_sorted_events(struct sevent *aliases, int len,
+				bool quiet_flag, bool name_only,
+				bool details_flag, bool deprecated,
+				int *deprecated_num)
+{
+	int j;
+	int printed = 0;
+	int numdesc = 0;
+	char *topic = NULL;
+	int columns = pager_get_columns();
+
+	*deprecated_num = 0;
+
+	for (j = 0; j < len; j++) {
+		if (!deprecated) {
+			if (aliases[j].deprecated) {
+				*deprecated_num += 1;
+				continue;
+			}
+		} else {
+			if (!aliases[j].deprecated)
+				continue;
+		}
+
+		/* Skip duplicates */
+		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name))
+			continue;
+		if (name_only) {
+			printf("%s ", aliases[j].name);
+			continue;
+		}
+		if (aliases[j].desc && !quiet_flag) {
+			if (numdesc++ == 0)
+				printf("\n");
+			if (aliases[j].topic && (!topic ||
+					strcmp(topic, aliases[j].topic))) {
+				printf("%s%s:\n", topic ? "\n" : "",
+						aliases[j].topic);
+				topic = aliases[j].topic;
+			}
+			printf("  %-50s\n", aliases[j].name);
+			printf("%*s", 8, "[");
+			wordwrap(aliases[j].desc, 8, columns, 0);
+			printf("]\n");
+			if (details_flag) {
+				printf("%*s%s/%s/ ", 8, "", aliases[j].pmu,
+				       aliases[j].str);
+				if (aliases[j].metric_name)
+					printf(" MetricName: %s",
+					       aliases[j].metric_name);
+				if (aliases[j].metric_expr)
+					printf(" MetricExpr: %s",
+					       aliases[j].metric_expr);
+				putchar('\n');
+			}
+		} else
+			printf("  %-50s [Kernel PMU event]\n", aliases[j].name);
+		printed++;
+	}
+	if (printed && pager_in_use())
+		printf("\n");
+}
+
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			bool long_desc, bool details_flag)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
 	char buf[1024];
-	int printed = 0;
 	int len, j;
+	int deprecated_num;
 	struct sevent *aliases;
-	int numdesc = 0;
-	int columns = pager_get_columns();
-	char *topic = NULL;
 
 	pmu = NULL;
 	len = 0;
@@ -1441,6 +1508,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			aliases[j].pmu = pmu->name;
 			aliases[j].metric_expr = alias->metric_expr;
 			aliases[j].metric_name = alias->metric_name;
+			aliases[j].deprecated = alias->deprecated;
 			j++;
 		}
 		if (pmu->selectable &&
@@ -1454,41 +1522,15 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	}
 	len = j;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
-	for (j = 0; j < len; j++) {
-		/* Skip duplicates */
-		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name))
-			continue;
-		if (name_only) {
-			printf("%s ", aliases[j].name);
-			continue;
-		}
-		if (aliases[j].desc && !quiet_flag) {
-			if (numdesc++ == 0)
-				printf("\n");
-			if (aliases[j].topic && (!topic ||
-					strcmp(topic, aliases[j].topic))) {
-				printf("%s%s:\n", topic ? "\n" : "",
-						aliases[j].topic);
-				topic = aliases[j].topic;
-			}
-			printf("  %-50s\n", aliases[j].name);
-			printf("%*s", 8, "[");
-			wordwrap(aliases[j].desc, 8, columns, 0);
-			printf("]\n");
-			if (details_flag) {
-				printf("%*s%s/%s/ ", 8, "", aliases[j].pmu, aliases[j].str);
-				if (aliases[j].metric_name)
-					printf(" MetricName: %s", aliases[j].metric_name);
-				if (aliases[j].metric_expr)
-					printf(" MetricExpr: %s", aliases[j].metric_expr);
-				putchar('\n');
-			}
-		} else
-			printf("  %-50s [Kernel PMU event]\n", aliases[j].name);
-		printed++;
+
+	print_sorted_events(aliases, len, quiet_flag, name_only, details_flag,
+			    false, &deprecated_num);
+
+	if (deprecated_num > 0) {
+		printf("\n--- Following are deprecated events ---\n");
+		print_sorted_events(aliases, len, quiet_flag, name_only,
+				    details_flag, true, &deprecated_num);
 	}
-	if (printed && pager_in_use())
-		printf("\n");
 out_free:
 	for (j = 0; j < len; j++)
 		zfree(&aliases[j].name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f36ade6df76d..5e8fa85a3783 100644
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
-- 
2.17.1

