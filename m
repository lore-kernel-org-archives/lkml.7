Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B29C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A132064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfGHJWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38826 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfGHJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr0-0004ok-B8; Mon, 08 Jul 2019 11:22:34 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for 5.3-rc1
Message-ID: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-debugobjects-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-for-linus

up to:  d5f34153e526: debugobjects: Move printk out of db->lock critical sections

A set of updates for debugobjects:

 - A series of changes to make debugobjects more scalable by introducing
   per cpu pools and reducing the number of lock acquisitions.

 - debugfs cleanup

Thanks,

	tglx

------------------>
Greg Kroah-Hartman (1):
      debugobjects: No need to check return value of debugfs_create()

Waiman Long (5):
      debugobjects: Add percpu free pools
      debugobjects: Percpu pool lookahead freeing/allocation
      debugobjects: Reduce number of pool_lock acquisitions in fill_pool()
      debugobjects: Less aggressive freeing of excess debug objects
      debugobjects: Move printk out of db->lock critical sections


 lib/debugobjects.c | 321 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 253 insertions(+), 68 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 55437fd5128b..61261195f5b6 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -25,16 +25,37 @@
 
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
+#define ODEBUG_POOL_PERCPU_SIZE	64
+#define ODEBUG_BATCH_SIZE	16
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
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
@@ -44,13 +65,20 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
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
+static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
-static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
 static int __maybe_unused	debug_objects_maxchecked __read_mostly;
@@ -63,6 +91,7 @@ static int			debug_objects_pool_size __read_mostly
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -71,7 +100,7 @@ static int			debug_objects_allocated;
 static int			debug_objects_freed;
 
 static void free_obj_work(struct work_struct *work);
-static DECLARE_WORK(debug_obj_work, free_obj_work);
+static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
 
 static int __init enable_object_debug(char *str)
 {
@@ -100,7 +129,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 static void fill_pool(void)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
-	struct debug_obj *new, *obj;
+	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (likely(obj_pool_free >= debug_objects_pool_min_level))
@@ -116,7 +145,7 @@ static void fill_pool(void)
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		if (obj_nr_tofree) {
+		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			obj_nr_tofree--;
@@ -130,15 +159,23 @@ static void fill_pool(void)
 		return;
 
 	while (obj_pool_free < debug_objects_pool_min_level) {
+		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		int cnt;
 
-		new = kmem_cache_zalloc(obj_cache, gfp);
-		if (!new)
+		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new[cnt])
+				break;
+		}
+		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		hlist_add_head(&new->node, &obj_pool);
-		debug_objects_allocated++;
-		obj_pool_free++;
+		while (cnt) {
+			hlist_add_head(&new[--cnt]->node, &obj_pool);
+			debug_objects_allocated++;
+			obj_pool_free++;
+		}
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }
@@ -162,6 +199,21 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
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
@@ -169,30 +221,60 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 {
-	struct debug_obj *obj = NULL;
+	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	struct debug_obj *obj;
 
-	raw_spin_lock(&pool_lock);
-	if (obj_pool.first) {
-		obj	    = hlist_entry(obj_pool.first, typeof(*obj), node);
+	if (likely(obj_cache)) {
+		obj = __alloc_object(&percpu_pool->free_objs);
+		if (obj) {
+			percpu_pool->obj_free--;
+			goto init_obj;
+		}
+	}
 
-		obj->object = addr;
-		obj->descr  = descr;
-		obj->state  = ODEBUG_STATE_NONE;
-		obj->astate = 0;
-		hlist_del(&obj->node);
+	raw_spin_lock(&pool_lock);
+	obj = __alloc_object(&obj_pool);
+	if (obj) {
+		obj_pool_used++;
+		obj_pool_free--;
 
-		hlist_add_head(&obj->node, &b->list);
+		/*
+		 * Looking ahead, allocate one batch of debug objects and
+		 * put them into the percpu free pool.
+		 */
+		if (likely(obj_cache)) {
+			int i;
+
+			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
+				struct debug_obj *obj2;
+
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
 
-		obj_pool_used++;
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
 
-		obj_pool_free--;
 		if (obj_pool_free < obj_pool_min_free)
 			obj_pool_min_free = obj_pool_free;
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
 
@@ -209,13 +291,19 @@ static void free_obj_work(struct work_struct *work)
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
-	 * list from the global free list
+	 * list from the global free list. As it is likely that a workload
+	 * may be gearing up to use more and more objects, don't free any
+	 * of them until the next round.
 	 */
 	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
 		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
@@ -224,7 +312,10 @@ static void free_obj_work(struct work_struct *work)
 		obj_pool_free++;
 		obj_nr_tofree--;
 	}
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	return;
 
+free_objs:
 	/*
 	 * Pool list is already full and there are still objs on the free
 	 * list. Move remaining free objs to a temporary list to free the
@@ -243,24 +334,86 @@ static void free_obj_work(struct work_struct *work)
 	}
 }
 
-static bool __free_object(struct debug_obj *obj)
+static void __free_object(struct debug_obj *obj)
 {
+	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
+	struct debug_percpu_free *percpu_pool;
+	int lookahead_count = 0;
 	unsigned long flags;
 	bool work;
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
-	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
+	local_irq_save(flags);
+	if (!obj_cache)
+		goto free_to_obj_pool;
+
+	/*
+	 * Try to free it into the percpu pool first.
+	 */
+	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
+		hlist_add_head(&obj->node, &percpu_pool->free_objs);
+		percpu_pool->obj_free++;
+		local_irq_restore(flags);
+		return;
+	}
+
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
+	raw_spin_lock(&pool_lock);
+	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
+	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
 	obj_pool_used--;
 
 	if (work) {
 		obj_nr_tofree++;
 		hlist_add_head(&obj->node, &obj_to_free);
+		if (lookahead_count) {
+			obj_nr_tofree += lookahead_count;
+			obj_pool_used -= lookahead_count;
+			while (lookahead_count) {
+				hlist_add_head(&objs[--lookahead_count]->node,
+					       &obj_to_free);
+			}
+		}
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
+		if (lookahead_count) {
+			obj_pool_free += lookahead_count;
+			obj_pool_used -= lookahead_count;
+			while (lookahead_count) {
+				hlist_add_head(&objs[--lookahead_count]->node,
+					       &obj_pool);
+			}
+		}
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	return work;
+	raw_spin_unlock(&pool_lock);
+	local_irq_restore(flags);
 }
 
 /*
@@ -269,8 +422,11 @@ static bool __free_object(struct debug_obj *obj)
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
@@ -372,6 +528,7 @@ static void
 __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
+	bool check_stack = false;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -391,7 +548,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 			debug_objects_oom();
 			return;
 		}
-		debug_object_is_on_stack(addr, onstack);
+		check_stack = true;
 	}
 
 	switch (obj->state) {
@@ -402,20 +559,23 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 		break;
 
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "init");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "init");
 		debug_object_fixup(descr->fixup_init, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
+		raw_spin_unlock_irqrestore(&db->lock, flags);
 		debug_print_object(obj, "init");
-		break;
+		return;
 	default:
 		break;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (check_stack)
+		debug_object_is_on_stack(addr, onstack);
 }
 
 /**
@@ -473,6 +633,8 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 
 	obj = lookup_object(addr, db);
 	if (obj) {
+		bool print_object = false;
+
 		switch (obj->state) {
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
@@ -481,14 +643,14 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 
 		case ODEBUG_STATE_ACTIVE:
-			debug_print_object(obj, "activate");
 			state = obj->state;
 			raw_spin_unlock_irqrestore(&db->lock, flags);
+			debug_print_object(obj, "activate");
 			ret = debug_object_fixup(descr->fixup_activate, addr, state);
 			return ret ? 0 : -EINVAL;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "activate");
+			print_object = true;
 			ret = -EINVAL;
 			break;
 		default:
@@ -496,10 +658,13 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		if (print_object)
+			debug_print_object(obj, "activate");
 		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
 	/*
 	 * We are here when a static object is activated. We
 	 * let the type specific code confirm whether this is
@@ -531,6 +696,7 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -548,24 +714,27 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 			if (!obj->astate)
 				obj->state = ODEBUG_STATE_INACTIVE;
 			else
-				debug_print_object(obj, "deactivate");
+				print_object = true;
 			break;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "deactivate");
+			print_object = true;
 			break;
 		default:
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "deactivate");
+	} else if (print_object) {
+		debug_print_object(obj, "deactivate");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -580,6 +749,7 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -599,20 +769,22 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		break;
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "destroy");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "destroy");
 		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
-		debug_print_object(obj, "destroy");
+		print_object = true;
 		break;
 	default:
 		break;
 	}
 out_unlock:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (print_object)
+		debug_print_object(obj, "destroy");
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -641,9 +813,9 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "free");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "free");
 		debug_object_fixup(descr->fixup_free, addr, state);
 		return;
 	default:
@@ -716,6 +888,7 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -731,22 +904,25 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 			if (obj->astate == expect)
 				obj->astate = next;
 			else
-				debug_print_object(obj, "active_state");
+				print_object = true;
 			break;
 
 		default:
-			debug_print_object(obj, "active_state");
+			print_object = true;
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "active_state");
+	} else if (print_object) {
+		debug_print_object(obj, "active_state");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -760,7 +936,6 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	int cnt, objs_checked = 0;
-	bool work = false;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -782,16 +957,16 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				debug_print_object(obj, "free");
 				descr = obj->descr;
 				state = obj->state;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
+				debug_print_object(obj, "free");
 				debug_object_fixup(descr->fixup_free,
 						   (void *) oaddr, state);
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-				work |= __free_object(obj);
+				__free_object(obj);
 				break;
 			}
 		}
@@ -807,8 +982,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
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
@@ -822,13 +999,19 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 
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
@@ -850,26 +1033,16 @@ static const struct file_operations debug_stats_fops = {
 
 static int __init debug_objects_init_debugfs(void)
 {
-	struct dentry *dbgdir, *dbgstats;
+	struct dentry *dbgdir;
 
 	if (!debug_objects_enabled)
 		return 0;
 
 	dbgdir = debugfs_create_dir("debug_objects", NULL);
-	if (!dbgdir)
-		return -ENOMEM;
 
-	dbgstats = debugfs_create_file("stats", 0444, dbgdir, NULL,
-				       &debug_stats_fops);
-	if (!dbgstats)
-		goto err;
+	debugfs_create_file("stats", 0444, dbgdir, NULL, &debug_stats_fops);
 
 	return 0;
-
-err:
-	debugfs_remove(dbgdir);
-
-	return -ENOMEM;
 }
 __initcall(debug_objects_init_debugfs);
 
@@ -1175,9 +1348,20 @@ static int __init debug_objects_replace_static_objects(void)
  */
 void __init debug_objects_mem_init(void)
 {
+	int cpu, extras;
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
@@ -1194,6 +1378,7 @@ void __init debug_objects_mem_init(void)
 	 * Increase the thresholds for allocating and freeing objects
 	 * according to the number of possible CPUs available in the system.
 	 */
-	debug_objects_pool_size += num_possible_cpus() * 32;
-	debug_objects_pool_min_level += num_possible_cpus() * 4;
+	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
+	debug_objects_pool_size += extras;
+	debug_objects_pool_min_level += extras;
 }

