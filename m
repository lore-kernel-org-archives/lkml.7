Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37462C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F4822469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:21:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33699 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfKLLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBV-0000WD-Ij; Tue, 12 Nov 2019 12:18:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 536BF1C04CB;
        Tue, 12 Nov 2019 12:18:05 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:04 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf maps: Add for_each_entry()/_safe() iterators
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-59gmq4kg1r68ou1wknyjl78x@git.kernel.org>
References: <tip-59gmq4kg1r68ou1wknyjl78x@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355748488.29376.14126273088149463533.tip-bot2@tip-bot2>
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

Commit-ID:     8efc4f05685dae2da1d21973eba5e59e7863c77f
Gitweb:        https://git.kernel.org/tip/8efc4f05685dae2da1d21973eba5e59e7863c77f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 28 Oct 2019 11:31:38 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:49:25 -03:00

perf maps: Add for_each_entry()/_safe() iterators

To reduce boilerplate, provide a more compact form using an idiom
present in other trees of data structures.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-59gmq4kg1r68ou1wknyjl78x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/event.c    |  2 +-
 tools/perf/builtin-report.c         |  6 +--
 tools/perf/tests/vmlinux-kallsyms.c |  6 +--
 tools/perf/util/machine.c           |  2 +-
 tools/perf/util/map.c               | 56 +++++++++++++++++-----------
 tools/perf/util/map_groups.h        | 15 ++++++++-
 tools/perf/util/probe-event.c       |  2 +-
 tools/perf/util/symbol.c            | 16 +++-----
 tools/perf/util/synthetic-events.c  |  2 +-
 tools/perf/util/thread.c            |  2 +-
 10 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index d357c62..d1044df 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -29,7 +29,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 		return -1;
 	}
 
-	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
+	maps__for_each_entry(maps, pos) {
 		struct kmap *kmap;
 		size_t size;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7accaf8..3bbad03 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -727,11 +727,9 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 {
 	size_t printed = 0;
-	struct rb_node *nd;
-
-	for (nd = rb_first(&maps->entries); nd; nd = rb_next(nd)) {
-		struct map *map = rb_entry(nd, struct map, rb_node);
+	struct map *map;
 
+	maps__for_each_entry(maps, map) {
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
 				   indent, "", map->start, map->end,
 				   map->prot & PROT_READ ? 'r' : '-',
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index aa296ff..ff64907 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -182,7 +182,7 @@ next_pair:
 
 	header_printed = false;
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		struct map *
 		/*
 		 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
@@ -207,7 +207,7 @@ next_pair:
 
 	header_printed = false;
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		struct map *pair;
 
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
@@ -237,7 +237,7 @@ next_pair:
 
 	maps = machine__kernel_maps(&kallsyms);
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		if (!map->priv) {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in kallsyms:\n");
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 70a9f87..24d9e28 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1057,7 +1057,7 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 	 * In the vmlinux case, pgoff is a virtual address which must now be
 	 * mapped to a vmlinux offset.
 	 */
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		struct kmap *kmap = __map__kmap(map);
 		struct map *dest_map;
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 86d8d18..466c9b0 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -594,28 +594,20 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 
 static void __maps__purge(struct maps *maps)
 {
-	struct rb_root *root = &maps->entries;
-	struct rb_node *next = rb_first(root);
+	struct map *pos, *next;
 
-	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
-
-		next = rb_next(&pos->rb_node);
-		rb_erase_init(&pos->rb_node, root);
+	maps__for_each_entry_safe(maps, pos, next) {
+		rb_erase_init(&pos->rb_node,  &maps->entries);
 		map__put(pos);
 	}
 }
 
 static void __maps__purge_names(struct maps *maps)
 {
-	struct rb_root *root = &maps->names;
-	struct rb_node *next = rb_first(root);
-
-	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node_name);
+	struct map *pos, *next;
 
-		next = rb_next(&pos->rb_node_name);
-		rb_erase_init(&pos->rb_node_name, root);
+	maps__for_each_entry_by_name_safe(maps, pos, next) {
+		rb_erase_init(&pos->rb_node_name,  &maps->names);
 		map__put(pos);
 	}
 }
@@ -687,13 +679,11 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 					 struct map **mapp)
 {
 	struct symbol *sym;
-	struct rb_node *nd;
+	struct map *pos;
 
 	down_read(&maps->lock);
 
-	for (nd = rb_first(&maps->entries); nd; nd = rb_next(nd)) {
-		struct map *pos = rb_entry(nd, struct map, rb_node);
-
+	maps__for_each_entry(maps, pos) {
 		sym = map__find_symbol_by_name(pos, name);
 
 		if (sym == NULL)
@@ -739,12 +729,11 @@ int map_groups__find_ams(struct addr_map_symbol *ams)
 static size_t maps__fprintf(struct maps *maps, FILE *fp)
 {
 	size_t printed = 0;
-	struct rb_node *nd;
+	struct map *pos;
 
 	down_read(&maps->lock);
 
-	for (nd = rb_first(&maps->entries); nd; nd = rb_next(nd)) {
-		struct map *pos = rb_entry(nd, struct map, rb_node);
+	maps__for_each_entry(maps, pos) {
 		printed += fprintf(fp, "Map:");
 		printed += map__fprintf(pos, fp);
 		if (verbose > 2) {
@@ -889,7 +878,7 @@ int map_groups__clone(struct thread *thread, struct map_groups *parent)
 
 	down_read(&maps->lock);
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		struct map *new = map__clone(map);
 		if (new == NULL)
 			goto out_unlock;
@@ -1021,6 +1010,29 @@ struct map *map__next(struct map *map)
 	return map ? __map__next(map) : NULL;
 }
 
+struct map *maps__first_by_name(struct maps *maps)
+{
+	struct rb_node *first = rb_first(&maps->names);
+
+	if (first)
+		return rb_entry(first, struct map, rb_node_name);
+	return NULL;
+}
+
+static struct map *__map__next_by_name(struct map *map)
+{
+	struct rb_node *next = rb_next(&map->rb_node_name);
+
+	if (next)
+		return rb_entry(next, struct map, rb_node_name);
+	return NULL;
+}
+
+struct map *map__next_by_name(struct map *map)
+{
+	return map ? __map__next_by_name(map) : NULL;
+}
+
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 77252e1..ce3ade3 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -25,7 +25,22 @@ void maps__remove(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 struct map *maps__first(struct maps *maps);
 struct map *map__next(struct map *map);
+
+#define maps__for_each_entry(maps, map) \
+	for (map = maps__first(maps); map; map = map__next(map))
+
+#define maps__for_each_entry_safe(maps, map, next) \
+	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
+
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
+struct map *maps__first_by_name(struct maps *maps);
+struct map *map__next_by_name(struct map *map);
+
+#define maps__for_each_entry_by_name(maps, map) \
+	for (map = maps__first_by_name(maps); map; map = map__next_by_name(map))
+
+#define maps__for_each_entry_by_name_safe(maps, map, next) \
+	for (map = maps__first_by_name(maps), next = map__next_by_name(map); map; map = next, next = map__next_by_name(map))
 
 struct map_groups {
 	struct maps	 maps;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 91cab5f..e29948b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -153,7 +153,7 @@ static struct map *kernel_get_module_map(const char *module)
 		return map__get(pos);
 	}
 
-	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
+	maps__for_each_entry(maps, pos) {
 		/* short_name is "[module]" */
 		if (strncmp(pos->dso->short_name + 1, module,
 			    pos->dso->short_name_len - 2) == 0 &&
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a8f80e4..042140f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -242,28 +242,24 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 void map_groups__fixup_end(struct map_groups *mg)
 {
 	struct maps *maps = &mg->maps;
-	struct map *next, *curr;
+	struct map *prev = NULL, *curr;
 
 	down_write(&maps->lock);
 
-	curr = maps__first(maps);
-	if (curr == NULL)
-		goto out_unlock;
+	maps__for_each_entry(maps, curr) {
+		if (prev != NULL && !prev->end)
+			prev->end = curr->start;
 
-	for (next = map__next(curr); next; next = map__next(curr)) {
-		if (!curr->end)
-			curr->end = next->start;
-		curr = next;
+		prev = curr;
 	}
 
 	/*
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (!curr->end)
+	if (curr && !curr->end)
 		curr->end = ~0ULL;
 
-out_unlock:
 	up_write(&maps->lock);
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 807cbca..cfa3c9f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -438,7 +438,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	else
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
-	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
+	maps__for_each_entry(maps, pos) {
 		size_t size;
 
 		if (!__map__is_kmodule(pos))
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b64e9e0..0a277a9 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -350,7 +350,7 @@ static int __thread__prepare_access(struct thread *thread)
 
 	down_read(&maps->lock);
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		err = unwind__prepare_access(thread->mg, map, &initialized);
 		if (err || initialized)
 			break;
