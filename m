Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92488C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D6F2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708700;
	bh=4Dqs7XMWl7/C3P5yKFoPknoXqd98AQnA4k4xNXPfVYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czOcW5DJ6IEjJHvGHxB7/HAnYSSQipcCF5bdDN7/UmsCLLwdx6A5WLCq9yoOtjrVv
	 t+5HMy/lvmKB0ATsHUmjriNe5tO0BRzW4d45Gxk3MRQxvF6AVRpwcRbG43TW5sq0fc
	 uh0x2JDk2nPy+u0kTNQ/gN7yOQ03W0e0FFuBF/UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfGULbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8AF759455;
        Sun, 21 Jul 2019 11:31:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C001F5D9D3;
        Sun, 21 Jul 2019 11:31:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 59/79] libperf: Add nr_members to struct perf_evsel
Date:   Sun, 21 Jul 2019 13:24:46 +0200
Message-Id: <20190721112506.12306-60-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 21 Jul 2019 11:31:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving nr_members from evsel into perf_evsel struct.

Link: http://lkml.kernel.org/n/tip-my4n8qzlt98b0xjxbljscl7r@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c             |  2 +-
 tools/perf/builtin-script.c             |  2 +-
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/lib/include/internal/evsel.h |  3 +++
 tools/perf/tests/parse-events.c         | 22 +++++++++++-----------
 tools/perf/ui/gtk/annotate.c            |  2 +-
 tools/perf/ui/gtk/hists.c               |  2 +-
 tools/perf/ui/hist.c                    |  6 +++---
 tools/perf/util/annotate.c              |  8 ++++----
 tools/perf/util/evlist.c                |  6 +++---
 tools/perf/util/evsel.c                 |  6 +++---
 tools/perf/util/evsel.h                 |  3 +--
 tools/perf/util/evsel_fprintf.c         |  4 ++--
 tools/perf/util/header.c                | 12 ++++++------
 tools/perf/util/hist.c                  |  2 +-
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/stat-display.c          |  2 +-
 tools/perf/util/stat.c                  |  2 +-
 18 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index e258e988c55b..d4288dcce156 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -436,7 +436,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	ret = fprintf(fp, "# Samples: %lu%c", nr_samples, unit);
 	if (evname != NULL) {
 		ret += fprintf(fp, " of event%s '%s'",
-			       evsel->nr_members > 1 ? "s" : "", evname);
+			       evsel->core.nr_members > 1 ? "s" : "", evname);
 	}
 
 	if (rep->time_str)
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 46fadbbe1c3e..31a529ec139f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1734,7 +1734,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 				       sample->cpu,
 				       &rt_stat);
 	evsel_script(evsel)->val = val;
-	if (evsel_script(evsel->leader)->gnum == evsel->leader->nr_members) {
+	if (evsel_script(evsel->leader)->gnum == evsel->leader->core.nr_members) {
 		for_each_group_member (ev2, evsel->leader) {
 			perf_stat__print_shadow_stats(&stat_config, ev2,
 						      evsel_script(ev2)->val,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 14e4c970d16a..b19df671111e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -479,7 +479,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				counter->supported = false;
 
 				if ((counter->leader != counter) ||
-				    !(counter->leader->nr_members > 1))
+				    !(counter->leader->core.nr_members > 1))
 					continue;
 			} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
                                 if (verbose > 0)
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index df4078194e9a..29eca9576546 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -15,6 +15,9 @@ struct perf_evsel {
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
+
+	/* parse modifier helper */
+	int			 nr_members;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5b4a5a3dac50..49f52e4de41b 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -653,7 +653,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -695,7 +695,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -753,7 +753,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong group name",
 		!strcmp(leader->group_name, "group1"));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -788,7 +788,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong group name",
 		!strcmp(leader->group_name, "group2"));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -844,7 +844,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -887,7 +887,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -919,7 +919,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -973,7 +973,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:G + :H group modifier */
@@ -1013,7 +1013,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :G group modifier */
@@ -1053,7 +1053,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :u group modifier */
@@ -1093,7 +1093,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
+	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :uG group modifier */
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 40e263a730e4..d7f984436dec 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -129,7 +129,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 		gtk_list_store_append(store, &iter);
 
 		if (perf_evsel__is_group_event(evsel)) {
-			for (i = 0; i < evsel->nr_members; i++) {
+			for (i = 0; i < evsel->core.nr_members; i++) {
 				ret += perf_gtk__get_percent(s + ret,
 							     sizeof(s) - ret,
 							     sym, pos,
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 1b181d8ea953..0efdb226d1a7 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -645,7 +645,7 @@ int perf_evlist__gtk_browse_hists(struct evlist *evlist,
 			if (!perf_evsel__is_group_leader(pos))
 				continue;
 
-			if (pos->nr_members > 1) {
+			if (pos->core.nr_members > 1) {
 				perf_evsel__group_desc(pos, buf, size);
 				evname = buf;
 			}
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 8c7fb11edc60..e5fb64347b2c 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -43,7 +43,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	if (perf_evsel__is_group_event(evsel)) {
 		int prev_idx, idx_delta;
 		struct hist_entry *pair;
-		int nr_members = evsel->nr_members;
+		int nr_members = evsel->core.nr_members;
 
 		prev_idx = perf_evsel__group_idx(evsel);
 
@@ -165,7 +165,7 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 	if (!perf_evsel__is_group_event(evsel))
 		return ret;
 
-	nr_members = evsel->nr_members;
+	nr_members = evsel->core.nr_members;
 	fields_a = calloc(nr_members, sizeof(*fields_a));
 	fields_b = calloc(nr_members, sizeof(*fields_b));
 
@@ -226,7 +226,7 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 	struct evsel *evsel = hists_to_evsel(hists);
 
 	if (symbol_conf.event_group)
-		len = max(len, evsel->nr_members * fmt->len);
+		len = max(len, evsel->core.nr_members * fmt->len);
 
 	if (len < (int)strlen(fmt->name))
 		len = strlen(fmt->name);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d46f2ae2c695..91d4fc3e78cf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1170,7 +1170,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 	int nr = 1;
 
 	if (perf_evsel__is_group_event(evsel))
-		nr = evsel->nr_members;
+		nr = evsel->core.nr_members;
 
 	size += sizeof(al->data[0]) * nr;
 
@@ -1448,7 +1448,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			return -1;
 
 		if (perf_evsel__is_group_event(evsel))
-			width *= evsel->nr_members;
+			width *= evsel->core.nr_members;
 
 		if (!*al->line)
 			printf(" %*s:\n", width, " ");
@@ -2272,7 +2272,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	len = symbol__size(sym);
 
 	if (perf_evsel__is_group_event(evsel)) {
-		width *= evsel->nr_members;
+		width *= evsel->core.nr_members;
 		perf_evsel__group_desc(evsel, buf, sizeof(buf));
 		evsel_name = buf;
 	}
@@ -2968,7 +2968,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 		return -1;
 
 	if (perf_evsel__is_group_event(evsel))
-		nr_pcnt = evsel->nr_members;
+		nr_pcnt = evsel->core.nr_members;
 
 	err = symbol__annotate(sym, map, evsel, 0, options, parch);
 	if (err)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 453c401606cc..34f32027be1c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -188,7 +188,7 @@ void __perf_evlist__set_leader(struct list_head *list)
 	leader = list_entry(list->next, struct evsel, core.node);
 	evsel = list_entry(list->prev, struct evsel, core.node);
 
-	leader->nr_members = evsel->idx - leader->idx + 1;
+	leader->core.nr_members = evsel->idx - leader->idx + 1;
 
 	__evlist__for_each_entry(list, evsel) {
 		evsel->leader = leader;
@@ -1761,7 +1761,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 
 	leader = evsel->leader;
 	pr_debug("Weak group for %s/%d failed\n",
-			leader->name, leader->nr_members);
+			leader->name, leader->core.nr_members);
 
 	/*
 	 * for_each_group_member doesn't work here because it doesn't
@@ -1774,7 +1774,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			if (is_open)
 				perf_evsel__close(c2);
 			c2->leader = c2;
-			c2->nr_members = 0;
+			c2->core.nr_members = 0;
 		}
 	}
 	return leader;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8d087d0e55f1..8b9a00598677 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -948,7 +948,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		 * Apply group format only if we belong to group
 		 * with more than one members.
 		 */
-		if (leader->nr_members > 1) {
+		if (leader->core.nr_members > 1) {
 			attr->read_format |= PERF_FORMAT_GROUP;
 			attr->inherit = 0;
 		}
@@ -1396,7 +1396,7 @@ static int perf_evsel__read_size(struct evsel *evsel)
 		entry += sizeof(u64);
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		nr = evsel->nr_members;
+		nr = evsel->core.nr_members;
 		size += sizeof(u64);
 	}
 
@@ -1453,7 +1453,7 @@ perf_evsel__process_group_data(struct evsel *leader,
 
 	nr = *data++;
 
-	if (nr != (u64) leader->nr_members)
+	if (nr != (u64) leader->core.nr_members)
 		return -EINVAL;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6056ce64bfdf..afd3a5b7bcc3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -142,7 +142,6 @@ struct evsel {
 	bool			use_uncore_alias;
 	/* parse modifier helper */
 	int			exclude_GH;
-	int			nr_members;
 	int			sample_read;
 	unsigned long		*per_pkg_mask;
 	struct evsel		*leader;
@@ -414,7 +413,7 @@ static inline bool perf_evsel__is_group_event(struct evsel *evsel)
 	if (!symbol_conf.event_group)
 		return false;
 
-	return perf_evsel__is_group_leader(evsel) && evsel->nr_members > 1;
+	return perf_evsel__is_group_leader(evsel) && evsel->core.nr_members > 1;
 }
 
 bool perf_evsel__is_function_event(struct evsel *evsel);
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 3466eca34a00..496fec01f5d1 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -45,14 +45,14 @@ int perf_evsel__fprintf(struct evsel *evsel,
 		if (!perf_evsel__is_group_leader(evsel))
 			return 0;
 
-		if (evsel->nr_members > 1)
+		if (evsel->core.nr_members > 1)
 			printed += fprintf(fp, "%s{", evsel->group_name ?: "");
 
 		printed += fprintf(fp, "%s", perf_evsel__name(evsel));
 		for_each_group_member(pos, evsel)
 			printed += fprintf(fp, ",%s", perf_evsel__name(pos));
 
-		if (evsel->nr_members > 1)
+		if (evsel->core.nr_members > 1)
 			printed += fprintf(fp, "}");
 		goto out;
 	}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 21d845202c29..cf9821eae70f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -772,10 +772,10 @@ static int write_group_desc(struct feat_fd *ff,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (perf_evsel__is_group_leader(evsel) &&
-		    evsel->nr_members > 1) {
+		    evsel->core.nr_members > 1) {
 			const char *name = evsel->group_name ?: "{anon_group}";
 			u32 leader_idx = evsel->idx;
-			u32 nr_members = evsel->nr_members;
+			u32 nr_members = evsel->core.nr_members;
 
 			ret = do_write_string(ff, name);
 			if (ret < 0)
@@ -1812,11 +1812,11 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (perf_evsel__is_group_leader(evsel) &&
-		    evsel->nr_members > 1) {
+		    evsel->core.nr_members > 1) {
 			fprintf(fp, "# group: %s{%s", evsel->group_name ?: "",
 				perf_evsel__name(evsel));
 
-			nr = evsel->nr_members - 1;
+			nr = evsel->core.nr_members - 1;
 		} else if (nr) {
 			fprintf(fp, ",%s", perf_evsel__name(evsel));
 
@@ -2463,7 +2463,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 				evsel->group_name = desc[i].name;
 				desc[i].name = NULL;
 			}
-			evsel->nr_members = desc[i].nr_members;
+			evsel->core.nr_members = desc[i].nr_members;
 
 			if (i >= nr_groups || nr > 0) {
 				pr_debug("invalid group desc\n");
@@ -2471,7 +2471,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 			}
 
 			leader = evsel;
-			nr = evsel->nr_members - 1;
+			nr = evsel->core.nr_members - 1;
 			i++;
 		} else if (nr) {
 			/* This is a group member */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 821e0fe6cf26..4297f56b1e05 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2643,7 +2643,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	nr_samples = convert_unit(nr_samples, &unit);
 	printed = scnprintf(bf, size,
 			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			   nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
+			   nr_samples, unit, evsel->core.nr_members > 1 ? "s" : "",
 			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
 
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8182b1e66ec6..2cfec3b7a982 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1528,7 +1528,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	/* The number of members and group name are same for each group */
 	for (i = 0; i < nr_pmu; i++) {
 		evsel = (struct evsel *) leaders[i];
-		evsel->nr_members = total_members / nr_pmu;
+		evsel->core.nr_members = total_members / nr_pmu;
 		evsel->group_name = name ? strdup(name) : NULL;
 	}
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4a162858583f..f7b39f4bc51e 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -369,7 +369,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
 	u32 pmu_type = counter->core.attr.type;
 	struct evsel *pos;
 
-	if (counter->nr_members < 2)
+	if (counter->core.nr_members < 2)
 		return false;
 
 	evlist__for_each_entry(evlist, pos) {
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 799f3c0a9050..e4e4e3bf8b2b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -452,7 +452,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	 * the group read (for leader) and ID retrieval for all
 	 * members.
 	 */
-	if (leader->nr_members > 1)
+	if (leader->core.nr_members > 1)
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
 	attr->inherit = !config->no_inherit;
-- 
2.21.0

