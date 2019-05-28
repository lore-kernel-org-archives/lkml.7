Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEAC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AD421726
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfE1Mow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:44:52 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42281 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbfE1Mou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:44:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TStMl0v_1559047475;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TStMl0v_1559047475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 May 2019 20:44:42 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: shrinker: make shrinker not depend on memcg kmem
Date:   Tue, 28 May 2019 20:44:24 +0800
Message-Id: <1559047464-59838-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently shrinker is just allocated and can work when memcg kmem is
enabled.  But, THP deferred split shrinker is not slab shrinker, it
doesn't make too much sense to have such shrinker depend on memcg kmem.
It should be able to reclaim THP even though memcg kmem is disabled.

Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker,
i.e. THP deferred split shrinker.  When memcg kmem is disabled, just
such shrinkers can be called in shrinking memcg slab.

Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/shrinker.h |  3 +--
 mm/huge_memory.c         |  3 ++-
 mm/vmscan.c              | 27 ++++++---------------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443caf..e18dc00 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -69,10 +69,8 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
-#ifdef CONFIG_MEMCG_KMEM
 	/* ID in shrinker_idr */
 	int id;
-#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
@@ -81,6 +79,7 @@ struct shrinker {
 /* Flags */
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
+#define SHRINKER_NONSLAB	(1 << 3)
 
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 91a709e..b01fdc3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2963,7 +2963,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	.count_objects = deferred_split_count,
 	.scan_objects = deferred_split_scan,
 	.seeks = DEFAULT_SEEKS,
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
+	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
+		 SHRINKER_NONSLAB,
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7acd0af..62000ae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -174,8 +174,6 @@ struct scan_control {
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
-#ifdef CONFIG_MEMCG_KMEM
-
 /*
  * We allow subsystems to populate their shrinker-related
  * LRU lists before register_shrinker_prepared() is called
@@ -227,16 +225,6 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	idr_remove(&shrinker_idr, id);
 	up_write(&shrinker_rwsem);
 }
-#else /* CONFIG_MEMCG_KMEM */
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
-{
-	return 0;
-}
-
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
@@ -579,7 +567,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
@@ -587,7 +574,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	unsigned long ret, freed = 0;
 	int i;
 
-	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+	if (!mem_cgroup_online(memcg))
 		return 0;
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -613,6 +600,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 		}
 
+		/* Call non-slab shrinkers even though kmem is disabled */
+		if (!memcg_kmem_enabled() &&
+		    !(shrinker->flags & SHRINKER_NONSLAB))
+			continue;
+
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
 			clear_bit(i, map->map);
@@ -649,13 +641,6 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	up_read(&shrinker_rwsem);
 	return freed;
 }
-#else /* CONFIG_MEMCG_KMEM */
-static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
-			struct mem_cgroup *memcg, int priority)
-{
-	return 0;
-}
-#endif /* CONFIG_MEMCG_KMEM */
 
 /**
  * shrink_slab - shrink slab caches
-- 
1.8.3.1

