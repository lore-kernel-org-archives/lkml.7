Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF39EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB2820665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfHLQGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:06:50 -0400
Received: from foss.arm.com ([217.140.110.172]:52322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfHLQGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:06:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6357E174E;
        Mon, 12 Aug 2019 09:06:49 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6132C3F718;
        Mon, 12 Aug 2019 09:06:48 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: [PATCH v3 2/3] mm: kmemleak: Simple memory allocation pool for kmemleak objects
Date:   Mon, 12 Aug 2019 17:06:41 +0100
Message-Id: <20190812160642.52134-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
In-Reply-To: <20190812160642.52134-1-catalin.marinas@arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a memory pool for struct kmemleak_object in case the normal
kmem_cache_alloc() fails under the gfp constraints passed by the caller.
The mem_pool[] array size is currently fixed at 16000.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5ba7fad00fda..2fb86524d70b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -180,11 +180,17 @@ struct kmemleak_object {
 #define HEX_ASCII		1
 /* max number of lines to be printed */
 #define HEX_MAX_LINES		2
+/* memory pool size */
+#define MEM_POOL_SIZE		16000
 
 /* the list of all allocated objects */
 static LIST_HEAD(object_list);
 /* the list of gray-colored objects (see color_gray comment below) */
 static LIST_HEAD(gray_list);
+/* memory pool allocation */
+static struct kmemleak_object mem_pool[MEM_POOL_SIZE];
+static int mem_pool_free_count = ARRAY_SIZE(mem_pool);
+static LIST_HEAD(mem_pool_free_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
 /* rw_lock protecting the access to object_list and object_tree_root */
@@ -451,6 +457,50 @@ static int get_object(struct kmemleak_object *object)
 	return atomic_inc_not_zero(&object->use_count);
 }
 
+/*
+ * Memory pool allocation and freeing. kmemleak_lock must not be held.
+ */
+static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
+{
+	unsigned long flags;
+	struct kmemleak_object *object;
+
+	/* try the slab allocator first */
+	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+	if (object)
+		return object;
+
+	/* slab allocation failed, try the memory pool */
+	write_lock_irqsave(&kmemleak_lock, flags);
+	object = list_first_entry_or_null(&mem_pool_free_list,
+					  typeof(*object), object_list);
+	if (object)
+		list_del(&object->object_list);
+	else if (mem_pool_free_count)
+		object = &mem_pool[--mem_pool_free_count];
+	write_unlock_irqrestore(&kmemleak_lock, flags);
+
+	return object;
+}
+
+/*
+ * Return the object to either the slab allocator or the memory pool.
+ */
+static void mem_pool_free(struct kmemleak_object *object)
+{
+	unsigned long flags;
+
+	if (object < mem_pool || object >= mem_pool + ARRAY_SIZE(mem_pool)) {
+		kmem_cache_free(object_cache, object);
+		return;
+	}
+
+	/* add the object to the memory pool free list */
+	write_lock_irqsave(&kmemleak_lock, flags);
+	list_add(&object->object_list, &mem_pool_free_list);
+	write_unlock_irqrestore(&kmemleak_lock, flags);
+}
+
 /*
  * RCU callback to free a kmemleak_object.
  */
@@ -469,7 +519,7 @@ static void free_object_rcu(struct rcu_head *rcu)
 		hlist_del(&area->node);
 		kmem_cache_free(scan_area_cache, area);
 	}
-	kmem_cache_free(object_cache, object);
+	mem_pool_free(object);
 }
 
 /*
@@ -552,7 +602,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	struct rb_node **link, *rb_parent;
 	unsigned long untagged_ptr;
 
-	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+	object = mem_pool_alloc(gfp);
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
