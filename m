Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C886DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1182223D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfKSQ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:58:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbfKSQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oJ-0007W8-4f; Tue, 19 Nov 2019 17:57:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9EFA21C19DB;
        Tue, 19 Nov 2019 17:56:50 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf maps: Do not use an rbtree to sort by map name
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-bvr8fqfgzxtgnhnwt5sssx5g@git.kernel.org>
References: <tip-bvr8fqfgzxtgnhnwt5sssx5g@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418261057.12247.17096733259845940442.tip-bot2@tip-bot2>
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

Commit-ID:     c5c584d2dbb0883f1e6f61872964a4a3a35a2017
Gitweb:        https://git.kernel.org/tip/c5c584d2dbb0883f1e6f61872964a4a3a35a2017
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 13 Nov 2019 16:16:25 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 11:19:51 -03:00

perf maps: Do not use an rbtree to sort by map name

This is only used for the kernel maps, shave 24 bytes out 'struct map'
and just traverse the existing per ip rbtree to look for maps by name,
use a front end cache to reuse the last search if its the same name.

After this 'struct map' is down to just two cachelines:

  $ pahole -C map ~/bin/perf
  struct map {
  	union {
  		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
  		struct list_head node;                   /*     0    16 */
  	} __attribute__((__aligned__(8)));                                               /*     0    24 */
  	u64                        start;                /*    24     8 */
  	u64                        end;                  /*    32     8 */
  	_Bool                      erange_warned;        /*    40     1 */

  	/* XXX 3 bytes hole, try to pack */

  	u32                        priv;                 /*    44     4 */
  	u32                        prot;                 /*    48     4 */
  	u32                        flags;                /*    52     4 */
  	u64                        pgoff;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u64                        reloc;                /*    64     8 */
  	u32                        maj;                  /*    72     4 */
  	u32                        min;                  /*    76     4 */
  	u64                        ino;                  /*    80     8 */
  	u64                        ino_generation;       /*    88     8 */
  	u64                        (*map_ip)(struct map *, u64); /*    96     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*   104     8 */
  	struct dso *               dso;                  /*   112     8 */
  	refcount_t                 refcnt;               /*   120     4 */

  	/* size: 128, cachelines: 2, members: 17 */
  	/* sum members: 121, holes: 1, sum holes: 3 */
  	/* padding: 4 */
  	/* forced alignments: 1 */
  } __attribute__((__aligned__(8)));
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bvr8fqfgzxtgnhnwt5sssx5g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/map_groups.c |  2 +-
 tools/perf/util/map.c         | 30 ------------------------------
 tools/perf/util/map.h         |  1 -
 tools/perf/util/map_groups.h  |  1 -
 tools/perf/util/symbol.c      | 16 ++--------------
 5 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index b52adad..6b9f1cd 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -25,7 +25,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct map_grou
 		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
 		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
 		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
-		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 2);
+		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
 
 		i++;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 69b9e9b..49e353e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -26,7 +26,6 @@
 #include "ui/ui.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
-static void __maps__insert_name(struct maps *maps, struct map *map);
 
 static inline int is_anon_memory(const char *filename, u32 flags)
 {
@@ -566,7 +565,6 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 static void maps__init(struct maps *maps)
 {
 	maps->entries = RB_ROOT;
-	maps->names = RB_ROOT;
 	init_rwsem(&maps->lock);
 }
 
@@ -589,8 +587,6 @@ static void __maps__purge(struct maps *maps)
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  &maps->entries);
 		map__put(pos);
-		rb_erase_init(&pos->rb_node_name, &maps->names);
-		map__put(pos);
 	}
 }
 
@@ -736,7 +732,6 @@ size_t map_groups__fprintf(struct map_groups *mg, FILE *fp)
 static void __map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	__maps__insert(&mg->maps, map);
-	__maps__insert_name(&mg->maps, map);
 }
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
@@ -893,32 +888,10 @@ static void __maps__insert(struct maps *maps, struct map *map)
 	map__get(map);
 }
 
-static void __maps__insert_name(struct maps *maps, struct map *map)
-{
-	struct rb_node **p = &maps->names.rb_node;
-	struct rb_node *parent = NULL;
-	struct map *m;
-	int rc;
-
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node_name);
-		rc = strcmp(m->dso->short_name, map->dso->short_name);
-		if (rc < 0)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
-	rb_link_node(&map->rb_node_name, parent, p);
-	rb_insert_color(&map->rb_node_name, &maps->names);
-	map__get(map);
-}
-
 void maps__insert(struct maps *maps, struct map *map)
 {
 	down_write(&maps->lock);
 	__maps__insert(maps, map);
-	__maps__insert_name(maps, map);
 	up_write(&maps->lock);
 }
 
@@ -926,9 +899,6 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
-
-	rb_erase_init(&map->rb_node_name, &maps->names);
-	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 365deb6..a31e809 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -23,7 +23,6 @@ struct map {
 		struct rb_node	rb_node;
 		struct list_head node;
 	};
-	struct rb_node          rb_node_name;
 	u64			start;
 	u64			end;
 	bool			erange_warned;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 3f36140..26fc68b 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -16,7 +16,6 @@ struct thread;
 
 struct maps {
 	struct rb_root      entries;
-	struct rb_root	    names;
 	struct rw_semaphore lock;
 };
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 88f4cfb..0fb9bd8 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1764,24 +1764,12 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 {
 	struct maps *maps = &mg->maps;
 	struct map *map;
-	struct rb_node *node;
 
 	down_read(&maps->lock);
 
-	for (node = maps->names.rb_node; node; ) {
-		int rc;
-
-		map = rb_entry(node, struct map, rb_node_name);
-
-		rc = strcmp(map->dso->short_name, name);
-		if (rc < 0)
-			node = node->rb_left;
-		else if (rc > 0)
-			node = node->rb_right;
-		else
-
+	maps__for_each_entry(maps, map)
+		if (strcmp(map->dso->short_name, name) == 0)
 			goto out_unlock;
-	}
 
 	map = NULL;
 
