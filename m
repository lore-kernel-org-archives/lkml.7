Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB51AC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A16F2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pfFS9vyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfGMLCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:02:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60071 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:02:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB2Stu3838801
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:02:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB2Stu3838801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015749;
        bh=PuEuSmTYudhcB+snH/yi+Jbi/iTaQFeyTH3ZR0/Z82Y=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=pfFS9vyIF8dQmdXEdBphRQ6hW822/2T6QozgeV2/sASswV3tZW6Fm+MYclKvcbeD2
         ZEarkLsr8GqN7Im8tybuc8HYexnLpsGuiLnvAnFsdzuc65u6Kwfqixgr0Kxt32oAMR
         GISaAZuOyma7yYzwpTi7LgzNGV9OaKSZljXeWAsMD/QxAmQBJlLCVjwv39wyP6b5NV
         OaXhB4ZqPtrD9lGRQNFLpBuqPnbfqv2Z2uTY3yp80DUr9jEzRY78Px/gL0DEJXCJMY
         DqmUOlyrHJobEjv9jt25kN8D0fYbZ7vTIgZ2vH8TrJgtyC5XOjqpUEizmoWzaeR1eC
         GkReSMpGdq78g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB2RU53838798;
        Sat, 13 Jul 2019 04:02:27 -0700
Date:   Sat, 13 Jul 2019 04:02:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-deh17ub44atyox3j90e6rksu@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Use list_del_init() more thorougly
Git-Commit-ID: e56fbc9dc79ce0fdc49ffadd062214ddd02f65b6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e56fbc9dc79ce0fdc49ffadd062214ddd02f65b6
Gitweb:     https://git.kernel.org/tip/e56fbc9dc79ce0fdc49ffadd062214ddd02f65b6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 4 Jul 2019 12:13:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf tools: Use list_del_init() more thorougly

To allow for destructors to check if they're operating on a object still
in a list, and to avoid going from use after free list entries into
still valid, or even also other already removed from list entries.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-deh17ub44atyox3j90e6rksu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c        |  2 +-
 tools/perf/builtin-lock.c          |  8 ++++----
 tools/perf/pmu-events/jevents.c    |  2 +-
 tools/perf/tests/switch-tracking.c |  2 +-
 tools/perf/ui/gtk/annotate.c       |  2 +-
 tools/perf/util/annotate.c         |  4 ++--
 tools/perf/util/auxtrace.c         |  4 ++--
 tools/perf/util/bpf-loader.c       |  2 +-
 tools/perf/util/call-path.c        |  2 +-
 tools/perf/util/callchain.c        | 10 +++++-----
 tools/perf/util/db-export.c        |  4 ++--
 tools/perf/util/dso.c              |  2 +-
 tools/perf/util/evsel.c            |  2 +-
 tools/perf/util/hist.c             |  4 ++--
 tools/perf/util/ordered-events.c   |  6 +++---
 tools/perf/util/parse-events.c     |  2 +-
 tools/perf/util/pmu.c              |  2 +-
 tools/perf/util/probe-event.c      |  2 +-
 tools/perf/util/s390-cpumsf.c      |  2 +-
 tools/perf/util/srccode.c          |  2 +-
 tools/perf/util/symbol-elf.c       |  6 +++---
 tools/perf/util/thread.c           |  4 ++--
 22 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 9c228c55e1fb..66d5a6658daf 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -431,7 +431,7 @@ static void delete_filter_func(struct list_head *head)
 	struct filter_entry *pos, *tmp;
 
 	list_for_each_entry_safe(pos, tmp, head, list) {
-		list_del(&pos->list);
+		list_del_init(&pos->list);
 		free(pos);
 	}
 }
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c0be44e65e9d..574e30ec6d7c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -454,7 +454,7 @@ broken:
 		/* broken lock sequence, discard it */
 		ls->discard = 1;
 		bad_hist[BROKEN_ACQUIRE]++;
-		list_del(&seq->list);
+		list_del_init(&seq->list);
 		free(seq);
 		goto end;
 	default:
@@ -515,7 +515,7 @@ static int report_lock_acquired_event(struct perf_evsel *evsel,
 		/* broken lock sequence, discard it */
 		ls->discard = 1;
 		bad_hist[BROKEN_ACQUIRED]++;
-		list_del(&seq->list);
+		list_del_init(&seq->list);
 		free(seq);
 		goto end;
 	default:
@@ -570,7 +570,7 @@ static int report_lock_contended_event(struct perf_evsel *evsel,
 		/* broken lock sequence, discard it */
 		ls->discard = 1;
 		bad_hist[BROKEN_CONTENDED]++;
-		list_del(&seq->list);
+		list_del_init(&seq->list);
 		free(seq);
 		goto end;
 	default:
@@ -639,7 +639,7 @@ static int report_lock_release_event(struct perf_evsel *evsel,
 
 	ls->nr_release++;
 free_seq:
-	list_del(&seq->list);
+	list_del_init(&seq->list);
 	free(seq);
 end:
 	return 0;
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 287a6f10ca48..1a91a197cafb 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -407,7 +407,7 @@ static void free_arch_std_events(void)
 
 	list_for_each_entry_safe(es, next, &arch_std_events, list) {
 		FOR_ALL_EVENT_STRUCT_FIELDS(FREE_EVENT_FIELD);
-		list_del(&es->list);
+		list_del_init(&es->list);
 		free(es);
 	}
 }
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 744409dce65f..6cdab5f4812a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -238,7 +238,7 @@ static void free_event_nodes(struct list_head *events)
 
 	while (!list_empty(events)) {
 		node = list_entry(events->next, struct event_node, list);
-		list_del(&node->list);
+		list_del_init(&node->list);
 		free(node);
 	}
 }
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index df49c9ba1785..3af87c18a914 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -152,7 +152,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 	gtk_container_add(GTK_CONTAINER(window), view);
 
 	list_for_each_entry_safe(pos, n, &notes->src->source, al.node) {
-		list_del(&pos->al.node);
+		list_del_init(&pos->al.node);
 		disasm_line__free(pos);
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ef0e6028684c..ac9ad2330f93 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1586,7 +1586,7 @@ static void delete_last_nop(struct symbol *sym)
 				return;
 		}
 
-		list_del(&dl->al.node);
+		list_del_init(&dl->al.node);
 		disasm_line__free(dl);
 	}
 }
@@ -2463,7 +2463,7 @@ void annotated_source__purge(struct annotated_source *as)
 	struct annotation_line *al, *n;
 
 	list_for_each_entry_safe(al, n, &as->source, node) {
-		list_del(&al->node);
+		list_del_init(&al->node);
 		disasm_line__free(disasm_line(al));
 	}
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b033a43dfe3b..ec0af36697c4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -408,7 +408,7 @@ void auxtrace_queues__free(struct auxtrace_queues *queues)
 
 			buffer = list_entry(queues->queue_array[i].head.next,
 					    struct auxtrace_buffer, list);
-			list_del(&buffer->list);
+			list_del_init(&buffer->list);
 			auxtrace_buffer__free(buffer);
 		}
 	}
@@ -612,7 +612,7 @@ void auxtrace_index__free(struct list_head *head)
 	struct auxtrace_index *auxtrace_index, *n;
 
 	list_for_each_entry_safe(auxtrace_index, n, head, list) {
-		list_del(&auxtrace_index->list);
+		list_del_init(&auxtrace_index->list);
 		free(auxtrace_index);
 	}
 }
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 93d0f239ad4f..c61974a50aa5 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -829,7 +829,7 @@ static void
 bpf_map_op__delete(struct bpf_map_op *op)
 {
 	if (!list_empty(&op->list))
-		list_del(&op->list);
+		list_del_init(&op->list);
 	if (op->key_type == BPF_MAP_KEY_RANGES)
 		parse_events__clear_array(&op->k.array);
 	free(op);
diff --git a/tools/perf/util/call-path.c b/tools/perf/util/call-path.c
index e8a80c41cba3..5c60b8be1cf6 100644
--- a/tools/perf/util/call-path.c
+++ b/tools/perf/util/call-path.c
@@ -40,7 +40,7 @@ void call_path_root__free(struct call_path_root *cpr)
 	struct call_path_block *pos, *n;
 
 	list_for_each_entry_safe(pos, n, &cpr->blocks, node) {
-		list_del(&pos->node);
+		list_del_init(&pos->node);
 		free(pos);
 	}
 	free(cpr);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index b4af25dca5eb..8d7d8f62fcca 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -636,7 +636,7 @@ add_child(struct callchain_node *parent,
 		struct callchain_list *call, *tmp;
 
 		list_for_each_entry_safe(call, tmp, &new->val, list) {
-			list_del(&call->list);
+			list_del_init(&call->list);
 			map__zput(call->ms.map);
 			free(call);
 		}
@@ -1002,7 +1002,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
 					false, NULL, 0, 0, 0, list->srcline);
-		list_del(&list->list);
+		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		free(list);
 	}
@@ -1453,13 +1453,13 @@ static void free_callchain_node(struct callchain_node *node)
 	struct rb_node *n;
 
 	list_for_each_entry_safe(list, tmp, &node->parent_val, list) {
-		list_del(&list->list);
+		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		free(list);
 	}
 
 	list_for_each_entry_safe(list, tmp, &node->val, list) {
-		list_del(&list->list);
+		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		free(list);
 	}
@@ -1544,7 +1544,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 
 out:
 	list_for_each_entry_safe(chain, new, &head, list) {
-		list_del(&chain->list);
+		list_del_init(&chain->list);
 		map__zput(chain->ms.map);
 		free(chain);
 	}
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 3f2694ccfac7..2394c7506abe 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -34,7 +34,7 @@ static int db_export__deferred(struct db_export *dbe)
 		de = list_entry(dbe->deferred.next, struct deferred_export,
 				node);
 		err = dbe->export_comm(dbe, de->comm);
-		list_del(&de->node);
+		list_del_init(&de->node);
 		free(de);
 		if (err)
 			return err;
@@ -50,7 +50,7 @@ static void db_export__free_deferred(struct db_export *dbe)
 	while (!list_empty(&dbe->deferred)) {
 		de = list_entry(dbe->deferred.next, struct deferred_export,
 				node);
-		list_del(&de->node);
+		list_del_init(&de->node);
 		free(de);
 	}
 }
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ebacf07fc9ee..ebc9d46c15a7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -434,7 +434,7 @@ static void dso__list_add(struct dso *dso)
 
 static void dso__list_del(struct dso *dso)
 {
-	list_del(&dso->data.open_entry);
+	list_del_init(&dso->data.open_entry);
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7ede674edf07..ebb46da4dfe5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1298,7 +1298,7 @@ static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
 	struct perf_evsel_config_term *term, *h;
 
 	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
-		list_del(&term->list);
+		list_del_init(&term->list);
 		free(term);
 	}
 }
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 9b0ee0ef0f44..f24fd1954f6c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2741,10 +2741,10 @@ static void hists_evsel__exit(struct perf_evsel *evsel)
 
 	list_for_each_entry_safe(node, tmp, &hists->hpp_formats, list) {
 		perf_hpp_list__for_each_format_safe(&node->hpp, fmt, pos) {
-			list_del(&fmt->list);
+			list_del_init(&fmt->list);
 			free(fmt);
 		}
-		list_del(&node->list);
+		list_del_init(&node->list);
 		free(node);
 	}
 }
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 989fed6f43b5..bb5f34b7ab44 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -138,7 +138,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 
 	if (!list_empty(cache)) {
 		new = list_entry(cache->next, struct ordered_event, list);
-		list_del(&new->list);
+		list_del_init(&new->list);
 	} else if (oe->buffer) {
 		new = &oe->buffer->event[oe->buffer_idx];
 		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
@@ -394,13 +394,13 @@ void ordered_events__free(struct ordered_events *oe)
 	 * yet, we need to free only allocated ones ...
 	 */
 	if (oe->buffer) {
-		list_del(&oe->buffer->list);
+		list_del_init(&oe->buffer->list);
 		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
 	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
-		list_del(&buffer->list);
+		list_del_init(&buffer->list);
 		ordered_events_buffer__free(buffer, MAX_SAMPLE_BUFFER, oe);
 	}
 }
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index aa439853f20a..371ff3aee769 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -652,7 +652,7 @@ static int add_bpf_event(const char *group, const char *event, int fd,
 		pr_debug("Failed to add BPF event %s:%s\n",
 			 group, event);
 		list_for_each_entry_safe(evsel, tmp, &new_evsels, node) {
-			list_del(&evsel->node);
+			list_del_init(&evsel->node);
 			perf_evsel__delete(evsel);
 		}
 		return err;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 12b677902fbc..f32b710347db 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1245,7 +1245,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 		info->metric_expr = alias->metric_expr;
 		info->metric_name = alias->metric_name;
 
-		list_del(&term->list);
+		list_del_init(&term->list);
 		free(term);
 	}
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0a57b316c4dd..0c3b55d0617d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2333,7 +2333,7 @@ static void kprobe_blacklist__delete(struct list_head *blacklist)
 	while (!list_empty(blacklist)) {
 		node = list_first_entry(blacklist,
 					struct kprobe_blacklist_node, list);
-		list_del(&node->list);
+		list_del_init(&node->list);
 		zfree(&node->symbol);
 		free(node);
 	}
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index cca9cb851d02..83d2e149ef19 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -756,7 +756,7 @@ static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
 	 */
 	if (err) {
 		sfq->buffer = NULL;
-		list_del(&buffer->list);
+		list_del_init(&buffer->list);
 		auxtrace_buffer__free(buffer);
 		if (err > 0)		/* Buffer done, no error */
 			err = 0;
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index 688a85a3d454..adfcf1ff464c 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -83,7 +83,7 @@ static void fill_lines(char **lines, int maxline, char *map, int maplen)
 
 static void free_srcfile(struct srcfile *sf)
 {
-	list_del(&sf->nd);
+	list_del_init(&sf->nd);
 	hlist_del(&sf->hash_nd);
 	map_total_sz -= sf->maplen;
 	munmap(sf->map, sf->maplen);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1d5447594f5d..7d504dc22108 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1478,7 +1478,7 @@ static void kcore_copy__free_phdrs(struct kcore_copy_info *kci)
 	struct phdr_data *p, *tmp;
 
 	list_for_each_entry_safe(p, tmp, &kci->phdrs, node) {
-		list_del(&p->node);
+		list_del_init(&p->node);
 		free(p);
 	}
 }
@@ -1501,7 +1501,7 @@ static void kcore_copy__free_syms(struct kcore_copy_info *kci)
 	struct sym_data *s, *tmp;
 
 	list_for_each_entry_safe(s, tmp, &kci->syms, node) {
-		list_del(&s->node);
+		list_del_init(&s->node);
 		free(s);
 	}
 }
@@ -2252,7 +2252,7 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
 	int nr_free = 0;
 
 	list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
-		list_del(&pos->note_list);
+		list_del_init(&pos->note_list);
 		zfree(&pos->name);
 		zfree(&pos->provider);
 		free(pos);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index bbfb9c767f5f..873ab505ca80 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -93,14 +93,14 @@ void thread__delete(struct thread *thread)
 	down_write(&thread->namespaces_lock);
 	list_for_each_entry_safe(namespaces, tmp_namespaces,
 				 &thread->namespaces_list, list) {
-		list_del(&namespaces->list);
+		list_del_init(&namespaces->list);
 		namespaces__free(namespaces);
 	}
 	up_write(&thread->namespaces_lock);
 
 	down_write(&thread->comm_lock);
 	list_for_each_entry_safe(comm, tmp_comm, &thread->comm_list, list) {
-		list_del(&comm->list);
+		list_del_init(&comm->list);
 		comm__free(comm);
 	}
 	up_write(&thread->comm_lock);
