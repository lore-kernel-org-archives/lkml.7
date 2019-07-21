Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF9C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE082147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708567;
	bh=BBhkoQLZNatuMHleGAUcbfKkKwuCsY8RZlaKh4TKJnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=risW7NTlBZWUeDd2+sPt5tYdaNgkaAj4If9G+83pbUF7ujOfLt1p+6d5sgMho2SxK
	 aoykwEZN8RvXHFyzI1XE85UW2Hjt+fJP0SVIzkckWQ2FaLR98an4epHvUQIcW7iBSV
	 aXKMZcXGFdV/fJzqJUuwv0FRS5uTMq4MUC4dRkXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGUL30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B018D30821B3;
        Sun, 21 Jul 2019 11:29:24 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9C4E5D9D3;
        Sun, 21 Jul 2019 11:29:20 +0000 (UTC)
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
Subject: [PATCH 36/79] libperf: Include perf_evlist in evlist object
Date:   Sun, 21 Jul 2019 13:24:23 +0200
Message-Id: <20190721112506.12306-37-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 21 Jul 2019 11:29:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including perf_evlist in evlist object, will continue
to move other generic things into libperf evlist.

Link: http://lkml.kernel.org/n/tip-eb54iy0z3sb2543few2052wg@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c    |  4 ++--
 tools/perf/builtin-sched.c     |  2 +-
 tools/perf/builtin-trace.c     |  2 +-
 tools/perf/ui/browsers/hists.c |  6 +++---
 tools/perf/util/cgroup.c       |  2 +-
 tools/perf/util/evlist.c       |  8 ++++----
 tools/perf/util/evlist.h       | 17 +++++++++--------
 tools/perf/util/header.c       |  4 ++--
 tools/perf/util/parse-events.c |  2 +-
 tools/perf/util/stat-display.c |  4 ++--
 10 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 03fbe4600ca0..17bb0a536da3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1002,7 +1002,7 @@ static void record__init_features(struct record *rec)
 	if (rec->no_buildid)
 		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 
-	if (!have_tracepoints(&rec->evlist->entries))
+	if (!have_tracepoints(&rec->evlist->core.entries))
 		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 
 	if (!rec->opts.branch_stack)
@@ -1218,7 +1218,7 @@ static int record__synthesize(struct record *rec, bool tail)
 			return err;
 		}
 
-		if (have_tracepoints(&rec->evlist->entries)) {
+		if (have_tracepoints(&rec->evlist->core.entries)) {
 			/*
 			 * FIXME err <= 0 here actually means that
 			 * there were no tracepoints so its not really
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 70247f1b23da..897d11c8ca2e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2929,7 +2929,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel *evsel;
 	struct evsel_runtime *er;
 
-	list_for_each_entry(evsel, &evlist->entries, core.node) {
+	list_for_each_entry(evsel, &evlist->core.entries, core.node) {
 		er = perf_evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c2a284b82fa2..8bd42ea2315b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3979,7 +3979,7 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 {
 	struct trace *trace = opt->value;
 
-	if (!list_empty(&trace->evlist->entries))
+	if (!list_empty(&trace->evlist->core.entries))
 		return parse_cgroups(opt, str, unset);
 
 	trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 280347499c50..ed5406ff9fe4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3309,13 +3309,13 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
-				if (pos->core.node.next == &evlist->entries)
+				if (pos->core.node.next == &evlist->core.entries)
 					pos = perf_evlist__first(evlist);
 				else
 					pos = perf_evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
-				if (pos->core.node.prev == &evlist->entries)
+				if (pos->core.node.prev == &evlist->core.entries)
 					pos = perf_evlist__last(evlist);
 				else
 					pos = perf_evsel__prev(pos);
@@ -3370,7 +3370,7 @@ static int __perf_evlist__tui_browse_hists(struct evlist *evlist,
 	struct evsel *pos;
 	struct evsel_menu menu = {
 		.b = {
-			.entries    = &evlist->entries,
+			.entries    = &evlist->core.entries,
 			.refresh    = ui_browser__list_head_refresh,
 			.seek	    = ui_browser__list_head_seek,
 			.write	    = perf_evsel_menu__write,
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index deb87ecd3671..f73599f271ff 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -208,7 +208,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 	char *s;
 	int ret, i;
 
-	if (list_empty(&evlist->entries)) {
+	if (list_empty(&evlist->core.entries)) {
 		fprintf(stderr, "must define events before cgroups\n");
 		return -1;
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 227576bf16c0..faf3ffd81d4c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -48,7 +48,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
-	INIT_LIST_HEAD(&evlist->entries);
+	INIT_LIST_HEAD(&evlist->core.entries);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
@@ -180,7 +180,7 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
-	list_add_tail(&entry->core.node, &evlist->entries);
+	list_add_tail(&entry->core.node, &evlist->core.entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
@@ -226,7 +226,7 @@ void perf_evlist__set_leader(struct evlist *evlist)
 {
 	if (evlist->nr_entries) {
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
-		__perf_evlist__set_leader(&evlist->entries);
+		__perf_evlist__set_leader(&evlist->core.entries);
 	}
 }
 
@@ -1683,7 +1683,7 @@ void perf_evlist__to_front(struct evlist *evlist,
 			list_move_tail(&evsel->core.node, &move);
 	}
 
-	list_splice(&move, &evlist->entries);
+	list_splice(&move, &evlist->core.entries);
 }
 
 void perf_evlist__set_tracking_event(struct evlist *evlist,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1315e64ad69e..7117378a08e3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <api/fd/array.h>
 #include <stdio.h>
+#include <internal/evlist.h>
 #include "../perf.h"
 #include "event.h"
 #include "evsel.h"
@@ -25,7 +26,7 @@ struct record_opts;
 #define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
 
 struct evlist {
-	struct list_head entries;
+	struct perf_evlist core;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_entries;
 	int		 nr_groups;
@@ -225,17 +226,17 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 
 static inline bool perf_evlist__empty(struct evlist *evlist)
 {
-	return list_empty(&evlist->entries);
+	return list_empty(&evlist->core.entries);
 }
 
 static inline struct evsel *perf_evlist__first(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.next, struct evsel, core.node);
+	return list_entry(evlist->core.entries.next, struct evsel, core.node);
 }
 
 static inline struct evsel *perf_evlist__last(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.prev, struct evsel, core.node);
+	return list_entry(evlist->core.entries.prev, struct evsel, core.node);
 }
 
 size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
@@ -261,7 +262,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define evlist__for_each_entry(evlist, evsel) \
-	__evlist__for_each_entry(&(evlist)->entries, evsel)
+	__evlist__for_each_entry(&(evlist)->core.entries, evsel)
 
 /**
  * __evlist__for_each_entry_continue - continue iteration thru all the evsels
@@ -277,7 +278,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define evlist__for_each_entry_continue(evlist, evsel) \
-	__evlist__for_each_entry_continue(&(evlist)->entries, evsel)
+	__evlist__for_each_entry_continue(&(evlist)->core.entries, evsel)
 
 /**
  * __evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
@@ -293,7 +294,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define evlist__for_each_entry_reverse(evlist, evsel) \
-	__evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
+	__evlist__for_each_entry_reverse(&(evlist)->core.entries, evsel)
 
 /**
  * __evlist__for_each_entry_safe - safely iterate thru all the evsels
@@ -311,7 +312,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @tmp: struct evsel temp iterator
  */
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
-	__evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
+	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9c43a372d8ad..9731eecf2689 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -304,7 +304,7 @@ static int write_tracing_data(struct feat_fd *ff,
 	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
 		return -1;
 
-	return read_tracing_data(ff->fd, &evlist->entries);
+	return read_tracing_data(ff->fd, &evlist->core.entries);
 }
 
 static int write_build_id(struct feat_fd *ff,
@@ -4105,7 +4105,7 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
 	 * - write the tracing data from the temp file
 	 *   to the pipe
 	 */
-	tdata = tracing_data_get(&evlist->entries, fd, true);
+	tdata = tracing_data_get(&evlist->core.entries, fd, true);
 	if (!tdata)
 		return -1;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e111c0e0a5ac..a0b7d68d2f8e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2050,7 +2050,7 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 		if (!last)
 			return 0;
 
-		if (last->core.node.prev == &evlist->entries)
+		if (last->core.node.prev == &evlist->core.entries)
 			return 0;
 		last = list_entry(last->core.node.prev, struct evsel, core.node);
 	} while (!last->cmdline_group_boundary);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 17b7d3b55b5f..b1a2571f7c8f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -548,8 +548,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	struct evlist *evlist = counter->evlist;
 	struct evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evlist->entries), core.node);
-	list_for_each_entry_continue (alias, &evlist->entries, core.node) {
+	alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
+	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
-- 
2.21.0

