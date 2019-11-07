Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACE3218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153494;
	bh=iHK1ZMG3lWa59FGDM8nGS22uuvVaMY0FKc1jihv3VHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rizVPSUKK49wa8q3ZuDvZlu5t4+zqbhfvMJsFcpa12yUDRpT5JvKc9StRjzdncHyV
	 G/Ppd6+Bu2iae/O6s6oPi7UL1Mpsq6FgO0meh1gIps+OIjAH78Qc1PrAKKLd9vGH5l
	 MkRoBKikCTKDpVZ4ZrcrxpNLOV0+aVXxOXHOrWAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfKGTEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfKGTEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:52 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D4D21D6C;
        Thu,  7 Nov 2019 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153490;
        bh=iHK1ZMG3lWa59FGDM8nGS22uuvVaMY0FKc1jihv3VHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBaamE9QJ4GWtQahSGZDenuyfgaGElUMvATCwAcd4O90+TtCGDDBuTm91auZYaCeT
         hFGtvf2oD41actsfDWSmdkvlImGszHfzIOtyy8tNmr79oq1EyffjrOqBGT8zx+whCC
         ruwewbcWIb/m21cF+8qZtTBi4pggrqArNgBLC1EI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 31/63] perf map_groups: Introduce for_each_entry() and for_each_entry_safe() iterators
Date:   Thu,  7 Nov 2019 15:59:39 -0300
Message-Id: <20191107190011.23924-32-acme@kernel.org>
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
index 594fdaca4f71..b52adad55f8d 100644
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
index ce3ade32babd..bfbdbf5a443a 100644
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
index 042140fc4d36..a4bd61cbc2a0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1049,11 +1049,6 @@ int compare_proc_modules(const char *from, const char *to)
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
index ba4b4395f35d..6e00793c10ee 100644
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
-- 
2.21.0

