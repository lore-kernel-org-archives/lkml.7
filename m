Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C030214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbfETOPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:15:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732112AbfETOPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FECF309B153;
        Mon, 20 May 2019 14:15:08 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB11A1001DD9;
        Mon, 20 May 2019 14:15:06 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qian Cai <cai@gmx.us>, Zhong Jiang <zhongjiang@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/5] debugobjects: Add percpu free pools
Date:   Mon, 20 May 2019 10:14:46 -0400
Message-Id: <20190520141450.7575-2-longman@redhat.com>
In-Reply-To: <20190520141450.7575-1-longman@redhat.com>
References: <20190520141450.7575-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 20 May 2019 14:15:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a multi-threaded workload does a lot of small memory object
allocation and deallocation, it may cause the allocation and freeing of
many debug objects. This will make the global pool_lock a bottleneck
in the performance of the workload.  Since interrupt is disabled in
acquiring the pool_lock, it may even cause hard lockup to happen.

To reduce contention of the global pool_lock, this patch adds a percpu
debug object free pool that can be used to buffer some of the debug
object allocation and freeing requests without acquiring the pool_lock.
Each CPU will now have a percpu free pool that can hold up to a maximum
of 64 debug objects. Allocation and freeing requests will go to the
percpu free pool first. If that fails, the pool_lock will be taken and
the global free pool will be used.

The presence or absence of obj_cache is used as a marker to see if the
percpu cache should be used.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 115 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 24 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 55437fd5128b..8a235c9412dc 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -25,6 +25,7 @@
 
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
+#define ODEBUG_POOL_PERCPU_SIZE	64
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
@@ -35,6 +36,17 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
+/*
+ * Debug object percpu free list
+ * Access is protected by disabling irq
+ */
+struct debug_percpu_free {
+	struct hlist_head	free_objs;
+	int			obj_free;
+};
+
+static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
 static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
@@ -44,13 +56,19 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
 static HLIST_HEAD(obj_pool);
 static HLIST_HEAD(obj_to_free);
 
+/*
+ * Because of the presence of percpu free pools, obj_pool_free will
+ * under-count those in the percpu free pools. Similarly, obj_pool_used
+ * will over-count those in the percpu free pools. Adjustments will be
+ * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
+ * can be off.
+ */
 static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int			obj_pool_max_used;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
-static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
 static int __maybe_unused	debug_objects_maxchecked __read_mostly;
@@ -63,6 +81,7 @@ static int			debug_objects_pool_size __read_mostly
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -162,6 +181,21 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 	return NULL;
 }
 
+/*
+ * Allocate a new object from the hlist
+ */
+static struct debug_obj *__alloc_object(struct hlist_head *list)
+{
+	struct debug_obj *obj = NULL;
+
+	if (list->first) {
+		obj = hlist_entry(list->first, typeof(*obj), node);
+		hlist_del(&obj->node);
+	}
+
+	return obj;
+}
+
 /*
  * Allocate a new object. If the pool is empty, switch off the debugger.
  * Must be called with interrupts disabled.
@@ -169,20 +203,21 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 {
-	struct debug_obj *obj = NULL;
-
-	raw_spin_lock(&pool_lock);
-	if (obj_pool.first) {
-		obj	    = hlist_entry(obj_pool.first, typeof(*obj), node);
-
-		obj->object = addr;
-		obj->descr  = descr;
-		obj->state  = ODEBUG_STATE_NONE;
-		obj->astate = 0;
-		hlist_del(&obj->node);
+	struct debug_percpu_free *percpu_pool;
+	struct debug_obj *obj;
 
-		hlist_add_head(&obj->node, &b->list);
+	if (likely(obj_cache)) {
+		percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+		obj = __alloc_object(&percpu_pool->free_objs);
+		if (obj) {
+			percpu_pool->obj_free--;
+			goto init_obj;
+		}
+	}
 
+	raw_spin_lock(&pool_lock);
+	obj = __alloc_object(&obj_pool);
+	if (obj) {
 		obj_pool_used++;
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
@@ -193,6 +228,14 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	}
 	raw_spin_unlock(&pool_lock);
 
+init_obj:
+	if (obj) {
+		obj->object = addr;
+		obj->descr  = descr;
+		obj->state  = ODEBUG_STATE_NONE;
+		obj->astate = 0;
+		hlist_add_head(&obj->node, &b->list);
+	}
 	return obj;
 }
 
@@ -247,8 +290,21 @@ static bool __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
 	bool work;
+	struct debug_percpu_free *percpu_pool;
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	local_irq_save(flags);
+	/*
+	 * Try to free it into the percpu pool first.
+	 */
+	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	if (obj_cache && percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
+		hlist_add_head(&obj->node, &percpu_pool->free_objs);
+		percpu_pool->obj_free++;
+		local_irq_restore(flags);
+		return false;
+	}
+
+	raw_spin_lock(&pool_lock);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
 	obj_pool_used--;
 
@@ -259,7 +315,8 @@ static bool __free_object(struct debug_obj *obj)
 		obj_pool_free++;
 		hlist_add_head(&obj->node, &obj_pool);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	raw_spin_unlock(&pool_lock);
+	local_irq_restore(flags);
 	return work;
 }
 
@@ -822,13 +879,19 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 
 static int debug_stats_show(struct seq_file *m, void *v)
 {
+	int cpu, obj_percpu_free = 0;
+
+	for_each_possible_cpu(cpu)
+		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
+
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", obj_pool_free);
+	seq_printf(m, "pool_free     :%d\n", obj_pool_free + obj_percpu_free);
+	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
+	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
 	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
@@ -1175,9 +1238,20 @@ static int __init debug_objects_replace_static_objects(void)
  */
 void __init debug_objects_mem_init(void)
 {
+	int cpu;
+
 	if (!debug_objects_enabled)
 		return;
 
+	/*
+	 * Initialize the percpu object pools
+	 *
+	 * Initialization is not strictly necessary, but was done for
+	 * completeness.
+	 */
+	for_each_possible_cpu(cpu)
+		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
+
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
 				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
@@ -1189,11 +1263,4 @@ void __init debug_objects_mem_init(void)
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
-
-	/*
-	 * Increase the thresholds for allocating and freeing objects
-	 * according to the number of possible CPUs available in the system.
-	 */
-	debug_objects_pool_size += num_possible_cpus() * 32;
-	debug_objects_pool_min_level += num_possible_cpus() * 4;
 }
-- 
2.18.1

