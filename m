Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B0AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1880D2246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfKLLVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:21:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfKLLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBU-0000VP-A1; Tue, 12 Nov 2019 12:18:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABB3D1C04C9;
        Tue, 12 Nov 2019 12:18:04 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:04 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map_groups: Introduce for_each_entry() and
 for_each_entry_safe() iterators
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-gc3go6fmdn30twusg91t2q56@git.kernel.org>
References: <tip-gc3go6fmdn30twusg91t2q56@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355748426.29376.10807971722624153496.tip-bot2@tip-bot2>
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

Commit-ID:     50481461cfe937289724643691a752fa15a600c9
Gitweb:        https://git.kernel.org/tip/50481461cfe937289724643691a752fa15a600c9
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 28 Oct 2019 11:55:28 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:49:39 -03:00

perf map_groups: Introduce for_each_entry() and for_each_entry_safe() iterators

To reduce boilerplate, providing a more compact form to iterate over the
maps in a map_group.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gc3go6fmdn30twusg91t2q56@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/map_groups.c |  9 ++++-----
 tools/perf/util/map_groups.h  |  9 ++++-----
 tools/perf/util/symbol.c      | 24 ++++--------------------
 tools/perf/util/vdso.c        |  4 ++--
 4 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 594fdac..b52adad 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -18,17 +18,16 @@ static int check_maps(struct map_def *merged, unsigned int size, struct map_grou
 	struct map *map;
 	unsigned int i = 0;
 
-	map = map_groups__first(mg);
-	while (map) {
+	map_groups__for_each_entry(mg, map) {
+		if (i > 0)
+			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
+
 		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
 		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
 		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
 		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 2);
 
 		i++;
-		map = map_groups__next(map);
-
-		TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
 	}
 
 	return TEST_OK;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index ce3ade3..bfbdbf5 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -89,12 +89,11 @@ static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 	return maps__find(&mg->maps, addr);
 }
 
-struct map *map_groups__first(struct map_groups *mg);
+#define map_groups__for_each_entry(mg, map) \
+	for (map = maps__first(&mg->maps); map; map = map__next(map))
 
-static inline struct map *map_groups__next(struct map *map)
-{
-	return map__next(map);
-}
+#define map_groups__for_each_entry_safe(mg, map, next) \
+	for (map = maps__first(&mg->maps), next = map__next(map); map; map = next, next = map__next(map))
 
 struct symbol *map_groups__find_symbol(struct map_groups *mg, u64 addr, struct map **mapp);
 struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char *name, struct map **mapp);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 042140f..a4bd61c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1049,11 +1049,6 @@ out_delete_from:
 	return ret;
 }
 
-struct map *map_groups__first(struct map_groups *mg)
-{
-	return maps__first(&mg->maps);
-}
-
 static int do_validate_kcore_modules(const char *filename,
 				  struct map_groups *kmaps)
 {
@@ -1065,13 +1060,10 @@ static int do_validate_kcore_modules(const char *filename,
 	if (err)
 		return err;
 
-	old_map = map_groups__first(kmaps);
-	while (old_map) {
-		struct map *next = map_groups__next(old_map);
+	map_groups__for_each_entry(kmaps, old_map) {
 		struct module_info *mi;
 
 		if (!__map__is_kmodule(old_map)) {
-			old_map = next;
 			continue;
 		}
 
@@ -1081,8 +1073,6 @@ static int do_validate_kcore_modules(const char *filename,
 			err = -EINVAL;
 			goto out;
 		}
-
-		old_map = next;
 	}
 out:
 	delete_modules(&modules);
@@ -1185,9 +1175,7 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 	struct map *old_map;
 	LIST_HEAD(merged);
 
-	for (old_map = map_groups__first(kmaps); old_map;
-	     old_map = map_groups__next(old_map)) {
-
+	map_groups__for_each_entry(kmaps, old_map) {
 		/* no overload with this one */
 		if (new_map->end < old_map->start ||
 		    new_map->start >= old_map->end)
@@ -1260,7 +1248,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct map_groups *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *old_map, *new_map, *replacement_map = NULL;
+	struct map *old_map, *new_map, *replacement_map = NULL, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1307,10 +1295,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	old_map = map_groups__first(kmaps);
-	while (old_map) {
-		struct map *next = map_groups__next(old_map);
-
+	map_groups__for_each_entry_safe(kmaps, old_map, next) {
 		/*
 		 * We need to preserve eBPF maps even if they are
 		 * covered by kcore, because we need to access
@@ -1318,7 +1303,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		 */
 		if (old_map != map && !__map__is_bpf_prog(old_map))
 			map_groups__remove(kmaps, old_map);
-		old_map = next;
 	}
 	machine->trampolines_mapped = false;
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index ba4b439..6e00793 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -142,9 +142,9 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map *map = map_groups__first(thread->mg);
+	struct map *map;
 
-	for (; map ; map = map_groups__next(map)) {
+	map_groups__for_each_entry(thread->mg, map) {
 		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
