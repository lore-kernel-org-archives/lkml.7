Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63BC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D32147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708562;
	bh=hIIw/ZK/fwSuVU/lSIk9IWfmSJ5hqg2qJ1oqnawz+LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CR3+lKI5Gm6Q6iE3SczPQQfkJg+32jnhRFlpfmtCw4njHz5LW3n0dmntD2+2zcRK1
	 63sziwDgfVcjlWDE+2/SPmfjgJVsYrORXWqNBJIRXR0zb5xU9WBAcJ/0NY5HCz0BIW
	 P21LRPLqzbcVmRNPjGx0Vva4CmqjKUAWmlRxI79o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfGUL3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22271308FC4B;
        Sun, 21 Jul 2019 11:29:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C86C25D9D3;
        Sun, 21 Jul 2019 11:29:14 +0000 (UTC)
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
Subject: [PATCH 35/79] libperf: Include perf_evsel in evsel object
Date:   Sun, 21 Jul 2019 13:24:22 +0200
Message-Id: <20190721112506.12306-36-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 21 Jul 2019 11:29:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including perf_evsel in evsel object, will continue
to move other generic things into libperf evsel.

Link: http://lkml.kernel.org/n/tip-5hwrt780h6bkry7pxvqprrgk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-sched.c         |  2 +-
 tools/perf/builtin-trace.c         |  2 +-
 tools/perf/ui/browsers/hists.c     |  8 ++++----
 tools/perf/util/evlist.c           | 16 ++++++++--------
 tools/perf/util/evlist.h           | 12 ++++++------
 tools/perf/util/evsel.c            |  4 ++--
 tools/perf/util/evsel.h            | 16 ++++++++--------
 tools/perf/util/parse-events.c     | 20 ++++++++++----------
 tools/perf/util/stat-display.c     |  4 ++--
 tools/perf/util/trace-event-info.c |  4 ++--
 10 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index c02ecb295f23..70247f1b23da 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2929,7 +2929,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel *evsel;
 	struct evsel_runtime *er;
 
-	list_for_each_entry(evsel, &evlist->entries, node) {
+	list_for_each_entry(evsel, &evlist->entries, core.node) {
 		er = perf_evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0fa6f0530d0f..c2a284b82fa2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2648,7 +2648,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 			continue;
 		}
 
-		list_del_init(&evsel->node);
+		list_del_init(&evsel->core.node);
 		evsel->evlist = NULL;
 		evsel__delete(evsel);
 	}
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b83258bece05..280347499c50 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3212,7 +3212,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 {
 	struct evsel_menu *menu = container_of(browser,
 						    struct evsel_menu, b);
-	struct evsel *evsel = list_entry(entry, struct evsel, node);
+	struct evsel *evsel = list_entry(entry, struct evsel, core.node);
 	struct hists *hists = evsel__hists(evsel);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
@@ -3309,13 +3309,13 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
-				if (pos->node.next == &evlist->entries)
+				if (pos->core.node.next == &evlist->entries)
 					pos = perf_evlist__first(evlist);
 				else
 					pos = perf_evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
-				if (pos->node.prev == &evlist->entries)
+				if (pos->core.node.prev == &evlist->entries)
 					pos = perf_evlist__last(evlist);
 				else
 					pos = perf_evsel__prev(pos);
@@ -3351,7 +3351,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 static bool filter_group_entries(struct ui_browser *browser __maybe_unused,
 				 void *entry)
 {
-	struct evsel *evsel = list_entry(entry, struct evsel, node);
+	struct evsel *evsel = list_entry(entry, struct evsel, core.node);
 
 	if (symbol_conf.event_group && !perf_evsel__is_group_leader(evsel))
 		return true;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 38a3c6d16b4b..227576bf16c0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -119,7 +119,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	struct evsel *pos, *n;
 
 	evlist__for_each_entry_safe(evlist, n, pos) {
-		list_del_init(&pos->node);
+		list_del_init(&pos->core.node);
 		pos->evlist = NULL;
 		evsel__delete(pos);
 	}
@@ -180,7 +180,7 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
-	list_add_tail(&entry->node, &evlist->entries);
+	list_add_tail(&entry->core.node, &evlist->entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
@@ -193,7 +193,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
-	list_del_init(&evsel->node);
+	list_del_init(&evsel->core.node);
 	evlist->nr_entries -= 1;
 }
 
@@ -203,7 +203,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 	struct evsel *evsel, *temp;
 
 	__evlist__for_each_entry_safe(list, temp, evsel) {
-		list_del_init(&evsel->node);
+		list_del_init(&evsel->core.node);
 		evlist__add(evlist, evsel);
 	}
 }
@@ -212,8 +212,8 @@ void __perf_evlist__set_leader(struct list_head *list)
 {
 	struct evsel *evsel, *leader;
 
-	leader = list_entry(list->next, struct evsel, node);
-	evsel = list_entry(list->prev, struct evsel, node);
+	leader = list_entry(list->next, struct evsel, core.node);
+	evsel = list_entry(list->prev, struct evsel, core.node);
 
 	leader->nr_members = evsel->idx - leader->idx + 1;
 
@@ -268,7 +268,7 @@ static int evlist__add_attrs(struct evlist *evlist,
 		evsel = perf_evsel__new_idx(attrs + i, evlist->nr_entries + i);
 		if (evsel == NULL)
 			goto out_delete_partial_list;
-		list_add_tail(&evsel->node, &head);
+		list_add_tail(&evsel->core.node, &head);
 	}
 
 	perf_evlist__splice_list_tail(evlist, &head);
@@ -1680,7 +1680,7 @@ void perf_evlist__to_front(struct evlist *evlist,
 
 	evlist__for_each_entry_safe(evlist, n, evsel) {
 		if (evsel->leader == move_evsel->leader)
-			list_move_tail(&evsel->node, &move);
+			list_move_tail(&evsel->core.node, &move);
 	}
 
 	list_splice(&move, &evlist->entries);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 99621c056d09..1315e64ad69e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -230,12 +230,12 @@ static inline bool perf_evlist__empty(struct evlist *evlist)
 
 static inline struct evsel *perf_evlist__first(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.next, struct evsel, node);
+	return list_entry(evlist->entries.next, struct evsel, core.node);
 }
 
 static inline struct evsel *perf_evlist__last(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.prev, struct evsel, node);
+	return list_entry(evlist->entries.prev, struct evsel, core.node);
 }
 
 size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
@@ -253,7 +253,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry(list, evsel) \
-        list_for_each_entry(evsel, list, node)
+        list_for_each_entry(evsel, list, core.node)
 
 /**
  * evlist__for_each_entry - iterate thru all the evsels
@@ -269,7 +269,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry_continue(list, evsel) \
-        list_for_each_entry_continue(evsel, list, node)
+        list_for_each_entry_continue(evsel, list, core.node)
 
 /**
  * evlist__for_each_entry_continue - continue iteration thru all the evsels
@@ -285,7 +285,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry_reverse(list, evsel) \
-        list_for_each_entry_reverse(evsel, list, node)
+        list_for_each_entry_reverse(evsel, list, core.node)
 
 /**
  * evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
@@ -302,7 +302,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry_safe(list, tmp, evsel) \
-        list_for_each_entry_safe(evsel, tmp, list, node)
+        list_for_each_entry_safe(evsel, tmp, list, core.node)
 
 /**
  * evlist__for_each_entry_safe - safely iterate thru all the evsels
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 652e53279b28..8fed22d889a4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -236,7 +236,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
-	INIT_LIST_HEAD(&evsel->node);
+	INIT_LIST_HEAD(&evsel->core.node);
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
@@ -1318,7 +1318,7 @@ void perf_evsel__close_fd(struct evsel *evsel)
 
 void perf_evsel__exit(struct evsel *evsel)
 {
-	assert(list_empty(&evsel->node));
+	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	perf_evsel__free_counts(evsel);
 	perf_evsel__free_fd(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5fec1ca64f58..d74cac6fe306 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -7,6 +7,7 @@
 #include <stddef.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <internal/evsel.h>
 #include "xyarray.h"
 #include "symbol_conf.h"
 #include "cpumap.h"
@@ -87,8 +88,7 @@ struct bpf_object;
 /** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
- * @node - To insert it into evlist->entries or in other list_heads, say in
- *         the event parsing routines.
+ * @core - libperf evsel object
  * @name - Can be set to retain the original event name passed by the user,
  *         so that when showing results in tools such as 'perf stat', we
  *         show the name used, not some alias.
@@ -101,7 +101,7 @@ struct bpf_object;
  * @priv:   And what is in its containing unnamed union are tool specific
  */
 struct evsel {
-	struct list_head	node;
+	struct perf_evsel	core;
 	struct evlist	*evlist;
 	struct perf_event_attr	attr;
 	char			*filter;
@@ -386,12 +386,12 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 
 static inline struct evsel *perf_evsel__next(struct evsel *evsel)
 {
-	return list_entry(evsel->node.next, struct evsel, node);
+	return list_entry(evsel->core.node.next, struct evsel, core.node);
 }
 
 static inline struct evsel *perf_evsel__prev(struct evsel *evsel)
 {
-	return list_entry(evsel->node.prev, struct evsel, node);
+	return list_entry(evsel->core.node.prev, struct evsel, core.node);
 }
 
 /**
@@ -478,15 +478,15 @@ static inline int perf_evsel__group_idx(struct evsel *evsel)
 
 /* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
-for ((_evsel) = list_entry((_leader)->node.next, struct evsel, node); 	\
+for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
      (_evsel) && (_evsel)->leader == (_leader);					\
-     (_evsel) = list_entry((_evsel)->node.next, struct evsel, node))
+     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
 /* Iterates group WITH the leader. */
 #define for_each_group_evsel(_evsel, _leader) 					\
 for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
-     (_evsel) = list_entry((_evsel)->node.next, struct evsel, node))
+     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
 static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
 {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 38eeca6fa1fc..e111c0e0a5ac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -343,7 +343,7 @@ __add_event(struct list_head *list, int *idx,
 	if (config_terms)
 		list_splice(config_terms, &evsel->config_terms);
 
-	list_add_tail(&evsel->node, list);
+	list_add_tail(&evsel->core.node, list);
 	return evsel;
 }
 
@@ -526,7 +526,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 		list_splice(&config_terms, &evsel->config_terms);
 	}
 
-	list_add_tail(&evsel->node, list);
+	list_add_tail(&evsel->core.node, list);
 	return 0;
 }
 
@@ -660,15 +660,15 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 
 		pr_debug("Failed to add BPF event %s:%s\n",
 			 group, event);
-		list_for_each_entry_safe(evsel, tmp, &new_evsels, node) {
-			list_del_init(&evsel->node);
+		list_for_each_entry_safe(evsel, tmp, &new_evsels, core.node) {
+			list_del_init(&evsel->core.node);
 			evsel__delete(evsel);
 		}
 		return err;
 	}
 	pr_debug("adding %s:%s\n", group, event);
 
-	list_for_each_entry(pos, &new_evsels, node) {
+	list_for_each_entry(pos, &new_evsels, core.node) {
 		pr_debug("adding %s:%s to %p\n",
 			 group, event, pos);
 		pos->bpf_fd = fd;
@@ -1458,8 +1458,8 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	bool is_leader = true;
 	int i, nr_pmu = 0, total_members, ret = 0;
 
-	leader = list_first_entry(list, struct evsel, node);
-	evsel = list_last_entry(list, struct evsel, node);
+	leader = list_first_entry(list, struct evsel, core.node);
+	evsel = list_last_entry(list, struct evsel, core.node);
 	total_members = evsel->idx - leader->idx + 1;
 
 	leaders = calloc(total_members, sizeof(uintptr_t));
@@ -1555,7 +1555,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 		return;
 
 	__perf_evlist__set_leader(list);
-	leader = list_entry(list->next, struct evsel, node);
+	leader = list_entry(list->next, struct evsel, core.node);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
@@ -2050,9 +2050,9 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 		if (!last)
 			return 0;
 
-		if (last->node.prev == &evlist->entries)
+		if (last->core.node.prev == &evlist->entries)
 			return 0;
-		last = list_entry(last->node.prev, struct evsel, node);
+		last = list_entry(last->core.node.prev, struct evsel, core.node);
 	} while (!last->cmdline_group_boundary);
 
 	return 0;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1f099823a1f9..17b7d3b55b5f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -548,8 +548,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	struct evlist *evlist = counter->evlist;
 	struct evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evlist->entries), node);
-	list_for_each_entry_continue (alias, &evlist->entries, node) {
+	alias = list_prepare_entry(counter, &(evlist->entries), core.node);
+	list_for_each_entry_continue (alias, &evlist->entries, core.node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index d7ae0627ac47..7efdbb182ea1 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -408,7 +408,7 @@ get_tracepoints_path(struct list_head *pattrs)
 	struct evsel *pos;
 	int nr_tracepoints = 0;
 
-	list_for_each_entry(pos, pattrs, node) {
+	list_for_each_entry(pos, pattrs, core.node) {
 		if (pos->attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 		++nr_tracepoints;
@@ -443,7 +443,7 @@ bool have_tracepoints(struct list_head *pattrs)
 {
 	struct evsel *pos;
 
-	list_for_each_entry(pos, pattrs, node)
+	list_for_each_entry(pos, pattrs, core.node)
 		if (pos->attr.type == PERF_TYPE_TRACEPOINT)
 			return true;
 
-- 
2.21.0

