Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D5C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B924217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455676;
	bh=jhYJjIUbNls6TwW0w4rme185u8FI3gU2SDLhIq0SIG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QN1B4FGfmjYUJGHfjR8HgFDUiqAzh3PyGML7RJ6xQjTONc7Jh0N4UGO35jzEZrFYo
	 LesMQdvrD5tVEaHjl9e2pmva8Xf/oOfY+cOANJO73DvdqRtoBIGs5NH+RikKD/+wf1
	 WOv9iq+hYScxDMKKjMx2RPfkv0bUpHYkxIOJRfIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfG3DBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732538AbfG3DBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E6520578;
        Tue, 30 Jul 2019 03:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455671;
        bh=jhYJjIUbNls6TwW0w4rme185u8FI3gU2SDLhIq0SIG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttvKbdDH4hp0SJFvJbY/kSYPSlhLKT69VAw5cGAA6OOgS7alQxpJJoOOCuWsB5WVO
         wVU95t7GMLpob594w6LwDyljWbZaGOKVU9ulOMqROo6um2JdR4jMO8YiFI4tNSz495
         Pu5mZsEQir3C6mDirFAIjJjJQsQJ4VLAR9S7PtAw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 086/107] libperf: Move nr_members from perf's evsel to libperf's perf_evsel
Date:   Mon, 29 Jul 2019 23:55:49 -0300
Message-Id: <20190730025610.22603-87-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the nr_members member from perf's evsel to libperf's perf_evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-60-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index e4b1a9914ea4..eac4d634b9c7 100644
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
index f97df418d661..b04c2b6b28b3 100644
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

