Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D59C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403818AbfETOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389951AbfETOPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6000307D93E;
        Mon, 20 May 2019 14:15:10 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDE061001E75;
        Mon, 20 May 2019 14:15:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qian Cai <cai@gmx.us>, Zhong Jiang <zhongjiang@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/5] debugobjects: Percpu pool lookahead freeing/allocation
Date:   Mon, 20 May 2019 10:14:47 -0400
Message-Id: <20190520141450.7575-3-longman@redhat.com>
In-Reply-To: <20190520141450.7575-1-longman@redhat.com>
References: <20190520141450.7575-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 20 May 2019 14:15:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most workloads will allocate a bunch of memory objects, work on them
and then freeing all or most of them. So just having a percpu free pool
may not reduce the pool_lock contention significantly if large number
of objects are being used.

To help those situations, we are now doing lookahead allocation and
freeing of the debug objects into and out of the percpu free pool. This
will hopefully reduce the number of times the pool_lock needs to be
taken and hence its contention level.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 69 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 8a235c9412dc..c30c9d308e9f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -26,6 +26,7 @@
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
 #define ODEBUG_POOL_PERCPU_SIZE	64
+#define ODEBUG_BATCH_SIZE	16
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
@@ -206,8 +207,8 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	struct debug_percpu_free *percpu_pool;
 	struct debug_obj *obj;
 
+	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	if (likely(obj_cache)) {
-		percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 		obj = __alloc_object(&percpu_pool->free_objs);
 		if (obj) {
 			percpu_pool->obj_free--;
@@ -219,10 +220,31 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	obj = __alloc_object(&obj_pool);
 	if (obj) {
 		obj_pool_used++;
+		obj_pool_free--;
+
+		/*
+		 * Looking ahead, allocate one batch of debug objects and
+		 * put them into the percpu free pool.
+		 */
+		if (likely(obj_cache)) {
+			int i;
+			struct debug_obj *obj2;
+
+			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
+				obj2 = __alloc_object(&obj_pool);
+				if (!obj2)
+					break;
+				hlist_add_head(&obj2->node,
+					       &percpu_pool->free_objs);
+				percpu_pool->obj_free++;
+				obj_pool_used++;
+				obj_pool_free--;
+			}
+		}
+
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
 
-		obj_pool_free--;
 		if (obj_pool_free < obj_pool_min_free)
 			obj_pool_min_free = obj_pool_free;
 	}
@@ -290,20 +312,37 @@ static bool __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
 	bool work;
+	int lookahead_count = 0;
+	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
 	struct debug_percpu_free *percpu_pool;
 
 	local_irq_save(flags);
+	if (!obj_cache)
+		goto free_to_obj_pool;
+
 	/*
 	 * Try to free it into the percpu pool first.
 	 */
 	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
-	if (obj_cache && percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
+	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
 		hlist_add_head(&obj->node, &percpu_pool->free_objs);
 		percpu_pool->obj_free++;
 		local_irq_restore(flags);
 		return false;
 	}
 
+	/*
+	 * As the percpu pool is full, look ahead and pull out a batch
+	 * of objects from the percpu pool and free them as well.
+	 */
+	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
+		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
+		if (!objs[lookahead_count])
+			break;
+		percpu_pool->obj_free--;
+	}
+
+free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
 	obj_pool_used--;
@@ -311,9 +350,23 @@ static bool __free_object(struct debug_obj *obj)
 	if (work) {
 		obj_nr_tofree++;
 		hlist_add_head(&obj->node, &obj_to_free);
+		if (lookahead_count) {
+			obj_nr_tofree += lookahead_count;
+			obj_pool_used -= lookahead_count;
+			while (lookahead_count)
+				hlist_add_head(&objs[--lookahead_count]->node,
+					       &obj_to_free);
+		}
 	} else {
 		obj_pool_free++;
 		hlist_add_head(&obj->node, &obj_pool);
+		if (lookahead_count) {
+			obj_pool_free += lookahead_count;
+			obj_pool_used -= lookahead_count;
+			while (lookahead_count)
+				hlist_add_head(&objs[--lookahead_count]->node,
+					       &obj_pool);
+		}
 	}
 	raw_spin_unlock(&pool_lock);
 	local_irq_restore(flags);
@@ -1238,7 +1291,7 @@ static int __init debug_objects_replace_static_objects(void)
  */
 void __init debug_objects_mem_init(void)
 {
-	int cpu;
+	int cpu, extras;
 
 	if (!debug_objects_enabled)
 		return;
@@ -1263,4 +1316,12 @@ void __init debug_objects_mem_init(void)
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
+
+	/*
+	 * Increase the thresholds for allocating and freeing objects
+	 * according to the number of possible CPUs available in the system.
+	 */
+	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
+	debug_objects_pool_size += extras;
+	debug_objects_pool_min_level += extras;
 }
-- 
2.18.1

