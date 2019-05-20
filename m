Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0ADC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65604216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbfETOPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403878AbfETOPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A991D30832EA;
        Mon, 20 May 2019 14:15:13 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C526D100EBDF;
        Mon, 20 May 2019 14:15:11 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qian Cai <cai@gmx.us>, Zhong Jiang <zhongjiang@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] debugobjects: Less aggressive freeing of excess debug objects
Date:   Mon, 20 May 2019 10:14:49 -0400
Message-Id: <20190520141450.7575-5-longman@redhat.com>
In-Reply-To: <20190520141450.7575-1-longman@redhat.com>
References: <20190520141450.7575-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 20 May 2019 14:15:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a system bootup and 3 parallel kernel builds, a partial output
of the debug objects stats file was:

pool_free     :5101
pool_pcp_free :4181
pool_min_free :220
pool_used     :104172
pool_max_used :171920
on_free_list  :0
objs_allocated:39268280
objs_freed    :39160031

More than 39 millions debug objects had since been allocated and then
freed. The pool_max_used, however, was only about 172k. So this is a
lot of extra overhead in freeing and allocating objects from slabs. It
may also causes the slabs to be more fragmented and harder to reclaim.

This patch tries to make the freeing of excess debug objects less
aggressive by freeing it at a maximum frequency of 10Hz and about 1k
objects at each round of freeing.

With that change applied, the partial output of the debug objects stats
file after similar actions became:

pool_free     :5901
pool_pcp_free :3742
pool_min_free :1022
pool_used     :104805
pool_max_used :168081
on_free_list  :0
objs_allocated:5796864
objs_freed    :5687182

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 61 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7573c736da7d..065770254899 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -32,6 +32,14 @@
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
 
+/*
+ * We limit the freeing of debug objects via workqueue at a maximum
+ * frequency of 10Hz and about 1024 objects for each freeing operation.
+ * So it is freeing at most 10k debug objects per second.
+ */
+#define ODEBUG_FREE_WORK_MAX	1024
+#define ODEBUG_FREE_WORK_DELAY	DIV_ROUND_UP(HZ, 10)
+
 struct debug_bucket {
 	struct hlist_head	list;
 	raw_spinlock_t		lock;
@@ -68,6 +76,7 @@ static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int			obj_pool_max_used;
+static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
 
@@ -91,7 +100,7 @@ static int			debug_objects_allocated;
 static int			debug_objects_freed;
 
 static void free_obj_work(struct work_struct *work);
-static DECLARE_WORK(debug_obj_work, free_obj_work);
+static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
 
 static int __init enable_object_debug(char *str)
 {
@@ -282,13 +291,19 @@ static void free_obj_work(struct work_struct *work)
 	unsigned long flags;
 	HLIST_HEAD(tofree);
 
+	WRITE_ONCE(obj_freeing, false);
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
 		return;
 
+	if (obj_pool_free >= debug_objects_pool_size)
+		goto free_objs;
+
 	/*
 	 * The objs on the pool list might be allocated before the work is
 	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list.
+	 * list from the global free list. As it is likely that a workload
+	 * may be gearing up to use more and more objects, don't free any
+	 * of them until the next round.
 	 */
 	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
 		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
@@ -297,7 +312,10 @@ static void free_obj_work(struct work_struct *work)
 		obj_pool_free++;
 		obj_nr_tofree--;
 	}
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	return;
 
+free_objs:
 	/*
 	 * Pool list is already full and there are still objs on the free
 	 * list. Move remaining free objs to a temporary list to free the
@@ -316,7 +334,7 @@ static void free_obj_work(struct work_struct *work)
 	}
 }
 
-static bool __free_object(struct debug_obj *obj)
+static void __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
 	bool work;
@@ -336,7 +354,7 @@ static bool __free_object(struct debug_obj *obj)
 		hlist_add_head(&obj->node, &percpu_pool->free_objs);
 		percpu_pool->obj_free++;
 		local_irq_restore(flags);
-		return false;
+		return;
 	}
 
 	/*
@@ -352,7 +370,8 @@ static bool __free_object(struct debug_obj *obj)
 
 free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
-	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
+	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
+	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
 	obj_pool_used--;
 
 	if (work) {
@@ -365,6 +384,21 @@ static bool __free_object(struct debug_obj *obj)
 				hlist_add_head(&objs[--lookahead_count]->node,
 					       &obj_to_free);
 		}
+
+		if ((obj_pool_free > debug_objects_pool_size) &&
+		    (obj_nr_tofree < ODEBUG_FREE_WORK_MAX)) {
+			int i;
+
+			/*
+			 * Free one more batch of objects from obj_pool.
+			 */
+			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
+				obj = __alloc_object(&obj_pool);
+				hlist_add_head(&obj->node, &obj_to_free);
+				obj_pool_free--;
+				obj_nr_tofree++;
+			}
+		}
 	} else {
 		obj_pool_free++;
 		hlist_add_head(&obj->node, &obj_pool);
@@ -378,7 +412,6 @@ static bool __free_object(struct debug_obj *obj)
 	}
 	raw_spin_unlock(&pool_lock);
 	local_irq_restore(flags);
-	return work;
 }
 
 /*
@@ -387,8 +420,11 @@ static bool __free_object(struct debug_obj *obj)
  */
 static void free_object(struct debug_obj *obj)
 {
-	if (__free_object(obj))
-		schedule_work(&debug_obj_work);
+	__free_object(obj);
+	if (!obj_freeing && obj_nr_tofree) {
+		WRITE_ONCE(obj_freeing, true);
+		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
+	}
 }
 
 /*
@@ -878,7 +914,6 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	int cnt, objs_checked = 0;
-	bool work = false;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -909,7 +944,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-				work |= __free_object(obj);
+				__free_object(obj);
 				break;
 			}
 		}
@@ -925,8 +960,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 		debug_objects_maxchecked = objs_checked;
 
 	/* Schedule work to actually kmem_cache_free() objects */
-	if (work)
-		schedule_work(&debug_obj_work);
+	if (!obj_freeing && obj_nr_tofree) {
+		WRITE_ONCE(obj_freeing, true);
+		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
+	}
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
-- 
2.18.1

