Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF66EC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8784A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633749AbfIYCDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:03:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:32026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394649AbfIYCDT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:03:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 19:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; 
   d="scan'208";a="213896594"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2019 19:03:16 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/2] perf stat: Support --all-kernel and --all-user options
Date:   Wed, 25 Sep 2019 10:02:17 +0800
Message-Id: <20190925020218.8288-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925020218.8288-1-yao.jin@linux.intel.com>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf record has supported --all-kernel / --all-user to configure all used
events to run in kernel space or in user space. But perf stat doesn't support
that. It would be useful to support these options so that we can collect
metrics for e.g. user space only without having to type ":u" in the events
manually.

Also it would be useful if --all-user / --all-kernel could be specified
together, and the tool would automatically add two copies of the events,
so that we get a break down between user and kernel.

Since we need to support specifying both --all-user and --all-kernel together,
we can't do as what the perf record does for supporting --all-user /
--all-kernel (it sets attr->exclude_kernel and attr->exclude_user).

This patch uses another solution which appends the modifiers ":u"/":k" to
event string.

For example,
perf stat -e cycles,instructions --all-user --all-kernel

It's automatically expanded to:
perf stat -e cycles:k,instructions:k,cycles:u,instructions:u

More examples,

 root@kbl:~# perf stat -e cycles --all-kernel --all-user -a -- sleep 1

 Performance counter stats for 'system wide':

        20,884,637      cycles:k
     4,511,494,722      cycles:u

       1.000891147 seconds time elapsed

 root@kbl:~# perf stat -e cycles,instructions --all-kernel --all-user -a -- sleep 1

 Performance counter stats for 'system wide':

        19,156,665      cycles:k
         7,265,342      instructions:k            #    0.38  insn per cycle
     4,511,186,293      cycles:u
       121,881,436      instructions:u            #    0.03  insn per cycle

       1.001153540 seconds time elapsed

 root@kbl:~#  perf stat -e "{cycles,instructions}" --all-kernel --all-user -a -- sleep 1

 Performance counter stats for 'system wide':

        16,230,472      cycles:k
         5,357,549      instructions:k            #    0.33  insn per cycle
     4,510,695,030      cycles:u
       122,097,780      instructions:u            #    0.03  insn per cycle

       1.000933419 seconds time elapsed

 root@kbl:~# perf stat -e "{cycles,instructions},{cache-misses,cache-references}" --all-kernel --all-user -a -- sleep 1

 Performance counter stats for 'system wide':

       111,688,302      cycles:k                                                      (74.81%)
        24,322,238      instructions:k            #    0.22  insn per cycle           (74.81%)
         1,115,414      cache-misses:k            #   21.292 % of all cache refs      (75.02%)
         5,238,665      cache-references:k                                            (75.02%)
     4,506,792,681      cycles:u                                                      (75.22%)
       124,199,635      instructions:u            #    0.03  insn per cycle           (75.22%)
        43,846,543      cache-misses:u            #   62.616 % of all cache refs      (74.97%)
        70,024,231      cache-references:u                                            (74.97%)

       1.001186804 seconds time elapsed

Note:

1. This patch can only configure the specified events (-e xxx) to run
   in user space or in kernel space. For supporting other options, such as
   --topdown, need follow-up patches.

2. In perf-record, it has already supported the --all-kernel and
   --all-user, but they can't be combined. We should keep the behavior
   consistent among all perf subtools. So if this patch can be accepted,
   will post follow-up patches for supporting other subtools for the
   same behavior.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |   3 +-
 tools/perf/Documentation/perf-stat.txt   |   7 +
 tools/perf/builtin-stat.c                | 163 ++++++++++++++++++++++-
 tools/perf/util/stat.h                   |  11 ++
 4 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c6f9f31b6039..739e29905184 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -495,7 +495,8 @@ Produce compressed trace using specified level n (default: 1 - fastest compressi
 Configure all used events to run in kernel space.
 
 --all-user::
-Configure all used events to run in user space.
+Configure all used events to run in user space. The --all-kernel
+and --all-user can't be combined.
 
 --kernel-callchains::
 Collect callchains only from kernel space. I.e. this option sets
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 930c51c01201..3f630e2f4144 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -323,6 +323,13 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
 
 Users who wants to get the actual value can apply --no-metric-only.
 
+--all-kernel::
+Configure all specified events to run in kernel space.
+
+--all-user::
+Configure all specified events to run in user space. The --all-kernel
+and --all-user can be combined.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..7f4d22b00d04 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/target.h"
 #include "util/time-utils.h"
 #include "util/top.h"
+#include "util/strbuf.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -723,12 +724,124 @@ static int parse_metric_groups(const struct option *opt,
 	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
+static int get_char_num(const char *str, char ch)
+{
+	int i = 0;
+
+	while (*str != '\0') {
+		if (*str == ch)
+			i++;
+		str++;
+	}
+
+	return i;
+}
+
+static int append_uk(struct strbuf *new_str, char *old_str, char ch)
+{
+	char *str_dup, *name, *next, *sep;
+	int event_num = get_char_num(old_str, ',') + 1;
+
+	str_dup = strdup(old_str);
+	if (!str_dup)
+		return -1;
+
+	name = strtok_r(str_dup, ",", &next);
+	while (name) {
+		sep = strchr(name, ':');
+		if (sep)
+			*sep = 0;
+
+		if (--event_num)
+			strbuf_addf(new_str, "%s:%c,", name, ch);
+		else
+			strbuf_addf(new_str, "%s:%c", name, ch);
+
+		name = strtok_r(NULL, ",", &next);
+	}
+
+	free(str_dup);
+	return 0;
+}
+
+static int get_group_num(char *str)
+{
+	return get_char_num(str, '}');
+}
+
+static int append_group_uk(struct strbuf *new_str, const char *old_str, bool k)
+{
+	char *str_dup, *group_str, *group_next, ch;
+	int group_num;
+	bool no_group;
+
+	str_dup = strdup(old_str);
+	if (!str_dup)
+		return -1;
+
+	group_num = get_group_num(str_dup);
+	ch = (k) ? 'k' : 'u';
+	no_group = (group_num) ? false : true;
+
+	group_str = strtok_r(str_dup, "}", &group_next);
+	while (group_str) {
+		append_uk(new_str, group_str, ch);
+
+		if (!no_group) {
+			if (--group_num)
+				strbuf_addf(new_str, "},");
+			else
+				strbuf_addf(new_str, "}");
+		}
+
+		group_str = strtok_r(NULL, "}", &group_next);
+		if (group_str && *group_str == ',')
+			group_str++;
+	}
+
+	free(str_dup);
+	return 0;
+}
+
+static int append_modifier(struct strbuf *new_str, const char *str,
+			   bool all_kernel, bool all_user)
+{
+	int ret;
+
+	strbuf_init(new_str, 512);
+
+	if (all_kernel && all_user) {
+		ret = append_group_uk(new_str, str, true);
+		if (ret)
+			return ret;
+
+		strbuf_addf(new_str, ",");
+		ret = append_group_uk(new_str, str, false);
+	} else
+		ret = append_group_uk(new_str, str, all_kernel);
+
+	return ret;
+}
+
+static int parse_events_option_wrap(const struct option *opt, const char *str,
+				    int unset __maybe_unused)
+{
+	if (stat_config.opt_num < PERF_STAT_EVENT_OPT_MAX) {
+		stat_config.event_opt[stat_config.opt_num].opt = opt;
+		stat_config.event_opt[stat_config.opt_num].event_str = str;
+		stat_config.opt_num++;
+		return 0;
+	}
+
+	return -1;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
 	OPT_CALLBACK('e', "event", &evsel_list, "event",
 		     "event selector. use 'perf list' to list available events",
-		     parse_events_option),
+		     parse_events_option_wrap),
 	OPT_CALLBACK(0, "filter", &evsel_list, "filter",
 		     "event filter", parse_filter),
 	OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
@@ -800,6 +913,10 @@ static struct option stat_options[] = {
 			"measure topdown level 1 statistics"),
 	OPT_BOOLEAN(0, "smi-cost", &smi_cost,
 			"measure SMI cost"),
+	OPT_BOOLEAN(0, "all-user", &stat_config.all_user,
+		    "Configure all used events to run in user space."),
+	OPT_BOOLEAN(0, "all-kernel", &stat_config.all_kernel,
+		    "Configure all used events to run in kernel space."),
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
@@ -1680,6 +1797,44 @@ static void setup_system_wide(int forks)
 	}
 }
 
+static int parse_events_again(void)
+{
+	int i, ret;
+
+	if (!stat_config.all_kernel && !stat_config.all_user) {
+		for (i = 0; i < stat_config.opt_num; i++) {
+			ret = parse_events_option(stat_config.event_opt[i].opt,
+					stat_config.event_opt[i].event_str, 0);
+			if (ret)
+				return ret;
+		}
+
+		return 0;
+	}
+
+	for (i = 0; i < stat_config.opt_num; i++) {
+		struct strbuf new_str;
+
+		ret = append_modifier(&new_str,
+				      stat_config.event_opt[i].event_str,
+				      stat_config.all_kernel,
+				      stat_config.all_user);
+		if (ret)
+			return ret;
+
+		pr_debug("New event string with appended modifiers: %s\n",
+			 new_str.buf);
+
+		ret = parse_events_option(stat_config.event_opt[i].opt,
+					  new_str.buf, 0);
+		strbuf_release(&new_str);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	const char * const stat_usage[] = {
@@ -1708,6 +1863,12 @@ int cmd_stat(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, stat_options, stat_subcommands,
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (parse_events_again() != 0) {
+		parse_options_usage(stat_usage, stat_options, "e", 1);
+		goto out;
+	}
+
 	perf_stat__collect_metric_expr(evsel_list);
 	perf_stat__init_shadow_stats();
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index edbeb2f63e8d..8154e07ced64 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -93,6 +93,13 @@ struct runtime_stat {
 typedef int (*aggr_get_id_t)(struct perf_stat_config *config,
 			     struct perf_cpu_map *m, int cpu);
 
+struct perf_stat_event_opt {
+	const struct option	*opt;
+	const char		*event_str;
+};
+
+#define PERF_STAT_EVENT_OPT_MAX        128
+
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
@@ -106,6 +113,8 @@ struct perf_stat_config {
 	bool			 big_num;
 	bool			 no_merge;
 	bool			 walltime_run_table;
+	bool			 all_kernel;
+	bool			 all_user;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -126,6 +135,8 @@ struct perf_stat_config {
 	struct perf_cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	struct perf_stat_event_opt	event_opt[PERF_STAT_EVENT_OPT_MAX];
+	int			opt_num;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.17.1

