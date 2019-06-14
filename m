Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEDC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06D3208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qdxpi9Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfFNM7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:59:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35677 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfFNM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:59:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5ECwvLm1697077
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 05:58:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5ECwvLm1697077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560517137;
        bh=koCdn7NObztXPGBZw7scb+Fn5KLRsKS7tf++EkW/tQw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Qdxpi9Nr9mLgGfkSQaj1uB3YXSMM25QpyX0+nIBs6BuPNUtdGr/lKlwRwtQ+9R4Pb
         4eHUNgTHG7RfGNJktvE1sl/dp2GAvDwjU6ibQTEXy0FVcViu2de0JWs3jrw5qDmYZz
         ojH3eAXNDP3a3mjtcWweV6OJOqx+Jg9GRwr93Sud44LOv/OYryZaEBs+o6Fe89UVNN
         +G6IYVGHf7A6tDtYwfG80fOjprfZ8DEEhkurcs5XMc940sxeD7E8we/ePl3qniXDBb
         TE4kja4Qq3zgwFtMUh2w43av/NZ9JccNbHYtHVcey6GB5MT9C73KYBWRvHnAN5gx4i
         OL4SJjIQqMzcg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5ECwuSp1697074;
        Fri, 14 Jun 2019 05:58:56 -0700
Date:   Fri, 14 Jun 2019 05:58:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-d86998b17a01050c0232231fa481e65ef8171ca6@git.kernel.org>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        zhongjiang@huawei.com, hpa@zytor.com, joel@joelfernandes.org,
        cai@gmx.us, yang.shi@linux.alibaba.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, yang.shi@linux.alibaba.com,
          cai@gmx.us, joel@joelfernandes.org, longman@redhat.com,
          zhongjiang@huawei.com, linux-kernel@vger.kernel.org,
          akpm@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20190520141450.7575-2-longman@redhat.com>
References: <20190520141450.7575-2-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Add percpu free pools
Git-Commit-ID: d86998b17a01050c0232231fa481e65ef8171ca6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d86998b17a01050c0232231fa481e65ef8171ca6
Gitweb:     https://git.kernel.org/tip/d86998b17a01050c0232231fa481e65ef8171ca6
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 10:14:46 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 14:51:14 +0200

debugobjects: Add percpu free pools

When a multi-threaded workload does a lot of small memory object
allocations and deallocations, it may cause the allocation and freeing of
many debug objects. This will make the global pool_lock a bottleneck in the
performance of the workload.  Since interrupts are disabled when acquiring
the pool_lock, it may even cause hard lockups to happen.

To reduce contention of the global pool_lock, add a percpu debug object
free pool that can be used to buffer some of the debug object allocation
and freeing requests without acquiring the pool_lock.  Each CPU will now
have a percpu free pool that can hold up to a maximum of 64 debug
objects. Allocation and freeing requests will go to the percpu free pool
first. If that fails, the pool_lock will be taken and the global free pool
will be used.

The presence or absence of obj_cache is used as a marker to see if the
percpu cache should be used.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190520141450.7575-2-longman@redhat.com

---
 lib/debugobjects.c | 115 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 24 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2ac42286cd08..38c23b528f6f 100644
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
@@ -1165,9 +1228,20 @@ free:
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
@@ -1179,11 +1253,4 @@ void __init debug_objects_mem_init(void)
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
