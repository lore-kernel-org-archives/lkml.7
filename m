Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01724C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CF721925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571214159;
	bh=Z/HQsjHE/SdLQUdyp3xLZpnaLBcYM4F1YPtipQSiLdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RP/QCB9pAQEYPXStzTJpNdPk1th0XxQ8sFnaP9tYKuCOkTVLHM4Sd0j9IiNes6qCX
	 BgJLVRIwkG/9DqX6GSAglp9xtb49CUHo2+F1RnVE2kmlAApgcuIkTj43kc5v3Qtgqd
	 g+FVED4TRTJULCeACDl37HOd6te0UmbLFxyzAOlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbfJPIWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:22:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391502AbfJPIWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 178743082135;
        Wed, 16 Oct 2019 08:22:35 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C04481001B08;
        Wed, 16 Oct 2019 08:22:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 2/2] perf tools: Make 'struct map_shared' truly shared
Date:   Wed, 16 Oct 2019 10:22:26 +0200
Message-Id: <20191016082226.10325-3-jolsa@kernel.org>
In-Reply-To: <20191016082226.10325-1-jolsa@kernel.org>
References: <20191016082226.10325-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 16 Oct 2019 08:22:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi reported that maps cloning is eating lot of memory and
it's probably unnecessary, because they keep the same data.

Changing 'struct map_shared' to be a pointer inside 'struct map',
so it can be shared on fork. Changing the map__clone function to
actually share 'struct map_shared' for cloned maps.

The 'struct map_shared' carries its own refcnt counter, which is
incremented when it's assigned to new 'struct map' and decremented
when 'struct map' gets deleted in map__delete (its refcnt is 0).

This 'maps sharing' seems to save lot of heap for reports with
many forks/cloned mmaps (over 60% in example below).

Profile kernel build:

  $ perf record make -j 40

Get heap profile (tools/perf directory):

  $ <install gperftools>
  $ make TCMALLOC=1
  $ HEAPPROFILE=/tmp/heapprof ./perf report -i perf.data --stdio > out
  $ pprof ./perf /tmp/heapprof.000*

Before:

  (pprof) top
  Total: 2335.5 MB
    1735.1  74.3%  74.3%   1735.1  74.3% memdup
     402.0  17.2%  91.5%    402.0  17.2% zalloc
     140.2   6.0%  97.5%    145.8   6.2% map__new
      33.6   1.4%  98.9%     33.6   1.4% symbol__new
      12.4   0.5%  99.5%     12.4   0.5% alloc_event
       6.2   0.3%  99.7%      6.2   0.3% nsinfo__new
       5.5   0.2% 100.0%      5.5   0.2% nsinfo__copy
       0.3   0.0% 100.0%      0.3   0.0% dso__new
       0.1   0.0% 100.0%      0.1   0.0% do_read_string
       0.0   0.0% 100.0%      0.0   0.0% __GI__IO_file_doallocate

After:

  (pprof) top
  Total: 758.5 MB
     385.7  50.8%  50.8%    385.7  50.8% memdup
     248.4  32.7%  83.6%    248.4  32.7% zalloc
      91.2  12.0%  95.6%     94.8  12.5% map__new
      19.3   2.5%  98.2%     19.3   2.5% symbol__new
       6.2   0.8%  99.0%      6.2   0.8% alloc_event
       3.9   0.5%  99.5%      3.9   0.5% nsinfo__new
       3.5   0.5% 100.0%      3.5   0.5% nsinfo__copy
       0.2   0.0% 100.0%      0.2   0.0% dso__new
       0.0   0.0% 100.0%      0.0   0.0% do_read_string
       0.0   0.0% 100.0%      0.0   0.0% elf_fill

The perf report output is the same.

Reported-by: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-9x8utaeeqwyktzhruhrpp9g9@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/map.c    | 62 ++++++++++++++++++++++++++++++++--------
 tools/perf/util/map.h    |  7 +++--
 tools/perf/util/symbol.c |  2 +-
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 98c56714f1ae..9df18ef76241 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -145,6 +145,7 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->groups   = NULL;
 	sh->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
+	refcount_set(&sh->refcnt, 1);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
@@ -153,14 +154,16 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     struct thread *thread)
 {
 	struct map *map = malloc(sizeof(*map));
+	struct map_shared *sh = malloc(sizeof(*sh));
 	struct nsinfo *nsi = NULL;
 	struct nsinfo *nnsi;
 
-	if (map != NULL) {
+	if (map != NULL && sh != NULL) {
 		char newfilename[PATH_MAX];
 		struct dso *dso;
 		int anon, no_dso, vdso, android;
-		struct map_shared *sh = map_sh(map);
+
+		map->shared = sh;
 
 		android = is_android_lib(filename);
 		anon = is_anon_memory(filename, flags);
@@ -220,11 +223,12 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		}
 		dso->nsinfo = nsi;
 		dso__put(dso);
+		return map;
 	}
-	return map;
 out_delete:
 	nsinfo__put(nsi);
 	free(map);
+	free(sh);
 	return NULL;
 }
 
@@ -235,13 +239,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
  */
 struct map *map__new2(u64 start, struct dso *dso)
 {
+	struct map_shared *sh = zalloc(sizeof(*sh));
 	struct map *map = calloc(1, (sizeof(*map) +
 				     (dso->kernel ? sizeof(struct kmap) : 0)));
-	if (map != NULL) {
+
+	if (map != NULL && sh != NULL) {
+		map->shared = sh;
 		/*
 		 * ->end will be filled after we load all the symbols
 		 */
 		map__init(map, start, 0, 0, dso);
+	} else {
+		zfree(&map);
+		free(sh);
 	}
 
 	return map;
@@ -289,15 +299,29 @@ bool map__has_symbols(const struct map *map)
 	return dso__has_symbols(map_sh(map)->dso);
 }
 
-static void map__exit(struct map *map)
+static void map_shared__delete(struct map_shared *sh)
 {
-	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
-	dso__zput(map_sh(map)->dso);
+	dso__put(sh->dso);
+	free(sh);
+}
+
+static struct map_shared *map_shared__get(struct map_shared *sh)
+{
+	if (sh)
+		refcount_inc(&sh->refcnt);
+	return sh;
+}
+
+static void map_shared__put(struct map_shared *sh)
+{
+	if (sh && refcount_dec_and_test(&sh->refcnt))
+		map_shared__delete(sh);
 }
 
 void map__delete(struct map *map)
 {
-	map__exit(map);
+	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
+	map_shared__put(map->shared);
 	free(map);
 }
 
@@ -390,12 +414,26 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 	return dso__find_symbol_by_name(map_sh(map)->dso, name);
 }
 
-struct map *map__clone(struct map *from)
+struct map *map__clone(struct map *from, bool share)
 {
 	struct map *map = memdup(from, sizeof(*map));
+	struct map_shared *sh;
 
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
+
+		if (share) {
+			sh = map_shared__get(map->shared);
+		} else {
+			sh = memdup(map->shared, sizeof(*sh));
+			if (!sh) {
+				free(map);
+				return NULL;
+			}
+			map->shared = sh;
+			refcount_set(&sh->refcnt, 1);
+		}
+
 		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map_sh(map)->dso);
 		map->groups = NULL;
@@ -840,7 +878,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		 * overlapped by the new map:
 		 */
 		if (map_sh(map)->start > map_sh(pos)->start) {
-			struct map *before = map__clone(pos);
+			struct map *before = map__clone(pos, false);
 
 			if (before == NULL) {
 				err = -ENOMEM;
@@ -855,7 +893,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		}
 
 		if (map_sh(map)->end < map_sh(pos)->end) {
-			struct map *after = map__clone(pos);
+			struct map *after = map__clone(pos, false);
 
 			if (after == NULL) {
 				err = -ENOMEM;
@@ -902,7 +940,7 @@ int map_groups__clone(struct thread *thread, struct map_groups *parent)
 	down_read(&maps->lock);
 
 	for (map = maps__first(maps); map; map = map__next(map)) {
-		struct map *new = map__clone(map);
+		struct map *new = map__clone(map, true);
 		if (new == NULL)
 			goto out_unlock;
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 297e8f9d1c4c..2788894bdd1c 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -38,6 +38,7 @@ struct map_shared {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
+	refcount_t		 refcnt;
 };
 
 struct map {
@@ -46,12 +47,12 @@ struct map {
 		struct list_head node;
 	};
 	struct rb_node		 rb_node_name;
-	struct map_shared	 shared;
+	struct map_shared	*shared;
 	struct map_groups	*groups;
 	refcount_t		 refcnt;
 };
 
-#define map_sh(__m)  (&((__m)->shared))
+#define map_sh(__m)  ((__m)->shared)
 
 struct kmap;
 
@@ -123,7 +124,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     char *filename, struct thread *thread);
 struct map *map__new2(u64 start, struct dso *dso);
 void map__delete(struct map *map);
-struct map *map__clone(struct map *map);
+struct map *map__clone(struct map *map, bool share);
 
 static inline struct map *map__get(struct map *map)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 80c4429304f0..bca6cbdd7eea 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1213,7 +1213,7 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 				 * |new.............| -> |new..|       |new..|
 				 *       |old....|    ->       |old....|
 				 */
-				struct map *m = map__clone(new_map);
+				struct map *m = map__clone(new_map, false);
 
 				if (!m)
 					return -ENOMEM;
-- 
2.21.0

