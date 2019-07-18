Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30662C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9A62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbfGRSIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRSIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71A9381E00;
        Thu, 18 Jul 2019 18:08:36 +0000 (UTC)
Received: from llong.com (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3AFD19C65;
        Thu, 18 Jul 2019 18:08:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm, slab: Move memcg_cache_params structure to mm/slab.h
Date:   Thu, 18 Jul 2019 14:08:27 -0400
Message-Id: <20190718180827.18758-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 18 Jul 2019 18:08:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg_cache_params structure is only embedded into the kmem_cache
of slab and slub allocators as defined in slab_def.h and slub_def.h
and used internally by mm code. There is no needed to expose it in
a public header. So move it from include/linux/slab.h to mm/slab.h.
It is just a refactoring patch with no code change.

In fact both the slub_def.h and slab_def.h should be moved into the mm
directory as well, but that will probably cause many merge conflicts.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/slab.h | 62 -------------------------------------------
 mm/slab.h            | 63 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 56c9c7eed34e..ab2b98ad76e1 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -595,68 +595,6 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 	return __kmalloc_node(size, flags, node);
 }
 
-struct memcg_cache_array {
-	struct rcu_head rcu;
-	struct kmem_cache *entries[0];
-};
-
-/*
- * This is the main placeholder for memcg-related information in kmem caches.
- * Both the root cache and the child caches will have it. For the root cache,
- * this will hold a dynamically allocated array large enough to hold
- * information about the currently limited memcgs in the system. To allow the
- * array to be accessed without taking any locks, on relocation we free the old
- * version only after a grace period.
- *
- * Root and child caches hold different metadata.
- *
- * @root_cache:	Common to root and child caches.  NULL for root, pointer to
- *		the root cache for children.
- *
- * The following fields are specific to root caches.
- *
- * @memcg_caches: kmemcg ID indexed table of child caches.  This table is
- *		used to index child cachces during allocation and cleared
- *		early during shutdown.
- *
- * @root_caches_node: List node for slab_root_caches list.
- *
- * @children:	List of all child caches.  While the child caches are also
- *		reachable through @memcg_caches, a child cache remains on
- *		this list until it is actually destroyed.
- *
- * The following fields are specific to child caches.
- *
- * @memcg:	Pointer to the memcg this cache belongs to.
- *
- * @children_node: List node for @root_cache->children list.
- *
- * @kmem_caches_node: List node for @memcg->kmem_caches list.
- */
-struct memcg_cache_params {
-	struct kmem_cache *root_cache;
-	union {
-		struct {
-			struct memcg_cache_array __rcu *memcg_caches;
-			struct list_head __root_caches_node;
-			struct list_head children;
-			bool dying;
-		};
-		struct {
-			struct mem_cgroup *memcg;
-			struct list_head children_node;
-			struct list_head kmem_caches_node;
-			struct percpu_ref refcnt;
-
-			void (*work_fn)(struct kmem_cache *);
-			union {
-				struct rcu_head rcu_head;
-				struct work_struct work;
-			};
-		};
-	};
-};
-
 int memcg_update_all_caches(int num_memcgs);
 
 /**
diff --git a/mm/slab.h b/mm/slab.h
index 5bf615cb3f99..68e455f2b698 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -30,6 +30,69 @@ struct kmem_cache {
 	struct list_head list;	/* List of all slab caches on the system */
 };
 
+#else /* !CONFIG_SLOB */
+
+struct memcg_cache_array {
+	struct rcu_head rcu;
+	struct kmem_cache *entries[0];
+};
+
+/*
+ * This is the main placeholder for memcg-related information in kmem caches.
+ * Both the root cache and the child caches will have it. For the root cache,
+ * this will hold a dynamically allocated array large enough to hold
+ * information about the currently limited memcgs in the system. To allow the
+ * array to be accessed without taking any locks, on relocation we free the old
+ * version only after a grace period.
+ *
+ * Root and child caches hold different metadata.
+ *
+ * @root_cache:	Common to root and child caches.  NULL for root, pointer to
+ *		the root cache for children.
+ *
+ * The following fields are specific to root caches.
+ *
+ * @memcg_caches: kmemcg ID indexed table of child caches.  This table is
+ *		used to index child cachces during allocation and cleared
+ *		early during shutdown.
+ *
+ * @root_caches_node: List node for slab_root_caches list.
+ *
+ * @children:	List of all child caches.  While the child caches are also
+ *		reachable through @memcg_caches, a child cache remains on
+ *		this list until it is actually destroyed.
+ *
+ * The following fields are specific to child caches.
+ *
+ * @memcg:	Pointer to the memcg this cache belongs to.
+ *
+ * @children_node: List node for @root_cache->children list.
+ *
+ * @kmem_caches_node: List node for @memcg->kmem_caches list.
+ */
+struct memcg_cache_params {
+	struct kmem_cache *root_cache;
+	union {
+		struct {
+			struct memcg_cache_array __rcu *memcg_caches;
+			struct list_head __root_caches_node;
+			struct list_head children;
+			bool dying;
+		};
+		struct {
+			struct mem_cgroup *memcg;
+			struct list_head children_node;
+			struct list_head kmem_caches_node;
+			struct percpu_ref refcnt;
+
+			void (*work_fn)(struct kmem_cache *);
+			union {
+				struct rcu_head rcu_head;
+				struct work_struct work;
+			};
+		};
+	};
+};
 #endif /* CONFIG_SLOB */
 
 #ifdef CONFIG_SLAB
-- 
2.18.1

