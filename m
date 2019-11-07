Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C7C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64522085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153486;
	bh=E4EkRH7L7NGrH0kgsD7NiPtS67sXNFDEdnJENtWQCHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=COJzrBPjCWW/1B5ZMpds/xPVIVOmunXzYETbh3ryIrP7TmaUXMGtiwvj6iNjT0Rt/
	 HnH8K8cymbAlsQztPU5AO5KzugXxS9fvFed0iHBI9G+JfgHfXCUqqXxX9Q2RHWUK/g
	 koxdltdBHpAG9FNQhkh/9gockEmLbh+5JXOzBnbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfKGTEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfKGTEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:44 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D429218AE;
        Thu,  7 Nov 2019 19:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153483;
        bh=E4EkRH7L7NGrH0kgsD7NiPtS67sXNFDEdnJENtWQCHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsU1OUBXyvTJIf7Wz5TxjmROzE7YBDU/PvGPVdxKbvnkTcjWKUHqwIaNjGyNiZr+m
         oZuEPw0FfiOvQEMgfr+PUSt0oLkuk4H+XIWYqcj/jA1vBFcPytgQhDNugaeOFvgIRw
         nOxAYvHqvVBu3d8ltK7FjTK3/mtppE+vdcPcWZFM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 30/63] perf maps: Add for_each_entry()/_safe() iterators
Date:   Thu,  7 Nov 2019 15:59:38 -0300
Message-Id: <20191107190011.23924-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/builtin-report.c         |  6 ++--
 tools/perf/tests/vmlinux-kallsyms.c |  6 ++--
 tools/perf/util/machine.c           |  2 +-
 tools/perf/util/map.c               | 56 +++++++++++++++++------------
 tools/perf/util/map_groups.h        | 15 ++++++++
 tools/perf/util/probe-event.c       |  2 +-
 tools/perf/util/symbol.c            | 16 ++++-----
 tools/perf/util/synthetic-events.c  |  2 +-
 tools/perf/util/thread.c            |  2 +-
 10 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index d357c625c09f..d1044df7c0d7 100644
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
index 7accaf8ef689..3bbad039abf2 100644
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
index aa296ffea6d1..ff649078da9a 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -182,7 +182,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 	header_printed = false;
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		struct map *
 		/*
 		 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
@@ -207,7 +207,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 	header_printed = false;
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		struct map *pair;
 
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
@@ -237,7 +237,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 	maps = machine__kernel_maps(&kallsyms);
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		if (!map->priv) {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in kallsyms:\n");
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 70a9f8716a4b..24d9e284daad 100644
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
index 86d8d187f872..466c9b035e19 100644
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
index 77252e14008f..ce3ade32babd 100644
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
index 91cab5f669d2..e29948b8fcab 100644
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
index a8f80e427674..042140fc4d36 100644
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
index 807cbca403a7..cfa3c9f67141 100644
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
index b64e9e049636..0a277a920970 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -350,7 +350,7 @@ static int __thread__prepare_access(struct thread *thread)
 
 	down_read(&maps->lock);
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
+	maps__for_each_entry(maps, map) {
 		err = unwind__prepare_access(thread->mg, map, &initialized);
 		if (err || initialized)
 			break;
-- 
2.21.0

