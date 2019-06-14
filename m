Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D4C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA880208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jF25bCW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfFNNBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:01:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfFNNBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:01:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5ED18tc1697599
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 06:01:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5ED18tc1697599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560517269;
        bh=QrdrKcwffdv560arzw1Obal0k/D8i9xNBiS0m7W5NZg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jF25bCW1f7Q0wZ3IKkiZXqypgdxrETjV3MXM51JDGmpN6r4VObKYwySazIZzLA8Ty
         xZ2X8o2oalx1q6gGUFiGW6JYfDXBQuopfB6zQwr7e9bXb51gS6/ZX5Z/sLNet0+eZO
         Bwpcg/02l0OlJkcVX1mVUU6nLdieXjfY4vxWgj7L+yNnwJnljso6y0a6iIU4ArTSgB
         R6eVKiiwY4qYMAEdxw7Oo5FFQqZnQaKCAN2TUmvbblukMeLY6ez/cHctUuviT6kpq4
         nYhPxLLpyucsG/9CSLdO9hFM48+ZopKnYck0PUuH5OIXdYsSvA4zDVZCLenFh3CAJW
         NM5Yqox5AnzYQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5ED18kt1697596;
        Fri, 14 Jun 2019 06:01:08 -0700
Date:   Fri, 14 Jun 2019 06:01:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-a7344a68a79ab91bc38af4b9d24284b479aa780a@git.kernel.org>
Cc:     yang.shi@linux.alibaba.com, mingo@kernel.org,
        joel@joelfernandes.org, tglx@linutronix.de, hpa@zytor.com,
        cai@gmx.us, zhongjiang@huawei.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, longman@redhat.com
Reply-To: joel@joelfernandes.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, yang.shi@linux.alibaba.com,
          linux-kernel@vger.kernel.org, longman@redhat.com,
          akpm@linux-foundation.org, zhongjiang@huawei.com, cai@gmx.us
In-Reply-To: <20190520141450.7575-5-longman@redhat.com>
References: <20190520141450.7575-5-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Less aggressive freeing of
 excess debug objects
Git-Commit-ID: a7344a68a79ab91bc38af4b9d24284b479aa780a
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

Commit-ID:  a7344a68a79ab91bc38af4b9d24284b479aa780a
Gitweb:     https://git.kernel.org/tip/a7344a68a79ab91bc38af4b9d24284b479aa780a
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 10:14:49 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 14:51:15 +0200

debugobjects: Less aggressive freeing of excess debug objects

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

Make the freeing of excess debug objects less aggressive by freeing them at
a maximum frequency of 10Hz and about 1k objects at each round of freeing.

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190520141450.7575-5-longman@redhat.com

---
 lib/debugobjects.c | 61 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7ea19fa63561..ede96c659552 100644
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
 	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
 	struct debug_percpu_free *percpu_pool;
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
@@ -366,6 +385,21 @@ free_to_obj_pool:
 					       &obj_to_free);
 			}
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
@@ -380,7 +414,6 @@ free_to_obj_pool:
 	}
 	raw_spin_unlock(&pool_lock);
 	local_irq_restore(flags);
-	return work;
 }
 
 /*
@@ -389,8 +422,11 @@ free_to_obj_pool:
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
@@ -880,7 +916,6 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	int cnt, objs_checked = 0;
-	bool work = false;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -911,7 +946,7 @@ repeat:
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-				work |= __free_object(obj);
+				__free_object(obj);
 				break;
 			}
 		}
@@ -927,8 +962,10 @@ repeat:
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
