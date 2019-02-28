Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7AB21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfB1HKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:10:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbfB1HKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:10:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S79GMK2939174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:09:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S79Foq2939171;
        Wed, 27 Feb 2019 23:09:15 -0800
Date:   Wed, 27 Feb 2019 23:09:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-a0b0fd53e1e67639b303b15939b9c653dbe7a8c4@git.kernel.org>
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        johannes@sipsolutions.net, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org
Reply-To: hpa@zytor.com, akpm@linux-foundation.org,
          paulmck@linux.vnet.ibm.com, johannes@sipsolutions.net,
          tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, will.deacon@arm.com,
          bvanassche@acm.org, linux-kernel@vger.kernel.org,
          longman@redhat.com, peterz@infradead.org
In-Reply-To: <20190214230058.196511-12-bvanassche@acm.org>
References: <20190214230058.196511-12-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Free lock classes that are no
 longer in use
Git-Commit-ID: a0b0fd53e1e67639b303b15939b9c653dbe7a8c4
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

Commit-ID:  a0b0fd53e1e67639b303b15939b9c653dbe7a8c4
Gitweb:     https://git.kernel.org/tip/a0b0fd53e1e67639b303b15939b9c653dbe7a8c4
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:46 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:43 +0100

locking/lockdep: Free lock classes that are no longer in use

Instead of leaving lock classes that are no longer in use in the
lock_classes array, reuse entries from that array that are no longer in
use. Maintain a linked list of free lock classes with list head
'free_lock_class'. Only add freed lock classes to the free_lock_classes
list after a grace period to avoid that a lock_classes[] element would
be reused while an RCU reader is accessing it. Since the lockdep
selftests run in a context where sleeping is not allowed and since the
selftests require that lock resetting/zapping works with debug_locks
off, make the behavior of lockdep_free_key_range() and
lockdep_reset_lock() depend on whether or not these are called from
the context of the lockdep selftests.

Thanks to Peter for having shown how to modify get_pending_free()
such that that function does not have to sleep.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-12-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  |   9 +-
 kernel/locking/lockdep.c | 396 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 354 insertions(+), 51 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 66eee1ba0f2a..619ec3f26cdc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -63,7 +63,8 @@ extern struct lock_class_key __lockdep_no_validate__;
 #define LOCKSTAT_POINTS		4
 
 /*
- * The lock-class itself:
+ * The lock-class itself. The order of the structure members matters.
+ * reinit_class() zeroes the key member and all subsequent members.
  */
 struct lock_class {
 	/*
@@ -72,7 +73,9 @@ struct lock_class {
 	struct hlist_node		hash_entry;
 
 	/*
-	 * global list of all lock-classes:
+	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
+	 * when not in use. Instances that are being freed are on one of the
+	 * zapped_classes lists.
 	 */
 	struct list_head		lock_entry;
 
@@ -104,7 +107,7 @@ struct lock_class {
 	unsigned long			contention_point[LOCKSTAT_POINTS];
 	unsigned long			contending_point[LOCKSTAT_POINTS];
 #endif
-};
+} __no_randomize_layout;
 
 #ifdef CONFIG_LOCK_STAT
 struct lock_time {
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c7ca3a4def7e..8ecf355dd163 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/jhash.h>
 #include <linux/nmi.h>
+#include <linux/rcupdate.h>
 
 #include <asm/sections.h>
 
@@ -135,8 +136,8 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
 /*
  * All data structures here are protected by the global debug_lock.
  *
- * Mutex key structs only get allocated, once during bootup, and never
- * get freed - this significantly simplifies the debugging code.
+ * nr_lock_classes is the number of elements of lock_classes[] that is
+ * in use.
  */
 unsigned long nr_lock_classes;
 #ifndef CONFIG_DEBUG_LOCKDEP
@@ -278,11 +279,39 @@ static inline void lock_release_holdtime(struct held_lock *hlock)
 #endif
 
 /*
- * We keep a global list of all lock classes. The list only grows,
- * never shrinks. The list is only accessed with the lockdep
- * spinlock lock held.
+ * We keep a global list of all lock classes. The list is only accessed with
+ * the lockdep spinlock lock held. free_lock_classes is a list with free
+ * elements. These elements are linked together by the lock_entry member in
+ * struct lock_class.
  */
 LIST_HEAD(all_lock_classes);
+static LIST_HEAD(free_lock_classes);
+
+/**
+ * struct pending_free - information about data structures about to be freed
+ * @zapped: Head of a list with struct lock_class elements.
+ */
+struct pending_free {
+	struct list_head zapped;
+};
+
+/**
+ * struct delayed_free - data structures used for delayed freeing
+ *
+ * A data structure for delayed freeing of data structures that may be
+ * accessed by RCU readers at the time these were freed.
+ *
+ * @rcu_head:  Used to schedule an RCU callback for freeing data structures.
+ * @index:     Index of @pf to which freed data structures are added.
+ * @scheduled: Whether or not an RCU callback has been scheduled.
+ * @pf:        Array with information about data structures about to be freed.
+ */
+static struct delayed_free {
+	struct rcu_head		rcu_head;
+	int			index;
+	int			scheduled;
+	struct pending_free	pf[2];
+} delayed_free;
 
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
@@ -742,7 +771,8 @@ static bool assign_lock_key(struct lockdep_map *lock)
 }
 
 /*
- * Initialize the lock_classes[] array elements.
+ * Initialize the lock_classes[] array elements, the free_lock_classes list
+ * and also the delayed_free structure.
  */
 static void init_data_structures_once(void)
 {
@@ -754,7 +784,12 @@ static void init_data_structures_once(void)
 
 	initialization_happened = true;
 
+	init_rcu_head(&delayed_free.rcu_head);
+	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
+	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);
+
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
 		INIT_LIST_HEAD(&lock_classes[i].locks_after);
 		INIT_LIST_HEAD(&lock_classes[i].locks_before);
 	}
@@ -802,11 +837,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 
 	init_data_structures_once();
 
-	/*
-	 * Allocate a new key from the static array, and add it to
-	 * the hash:
-	 */
-	if (nr_lock_classes >= MAX_LOCKDEP_KEYS) {
+	/* Allocate a new lock class and add it to the hash. */
+	class = list_first_entry_or_null(&free_lock_classes, typeof(*class),
+					 lock_entry);
+	if (!class) {
 		if (!debug_locks_off_graph_unlock()) {
 			return NULL;
 		}
@@ -815,7 +849,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 		dump_stack();
 		return NULL;
 	}
-	class = lock_classes + nr_lock_classes++;
+	nr_lock_classes++;
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
@@ -829,9 +863,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 */
 	hlist_add_head_rcu(&class->hash_entry, hash_head);
 	/*
-	 * Add it to the global list of classes:
+	 * Remove the class from the free list and add it to the global list
+	 * of classes.
 	 */
-	list_add_tail(&class->lock_entry, &all_lock_classes);
+	list_move_tail(&class->lock_entry, &all_lock_classes);
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -1860,6 +1895,24 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list this;
 	int ret;
 
+	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
+		/*
+		 * The warning statements below may trigger a use-after-free
+		 * of the class name. It is better to trigger a use-after free
+		 * and to have the class name most of the time instead of not
+		 * having the class name available.
+		 */
+		WARN_ONCE(!debug_locks_silent && !hlock_class(prev)->key,
+			  "Detected use-after-free of lock class %px/%s\n",
+			  hlock_class(prev),
+			  hlock_class(prev)->name);
+		WARN_ONCE(!debug_locks_silent && !hlock_class(next)->key,
+			  "Detected use-after-free of lock class %px/%s\n",
+			  hlock_class(next),
+			  hlock_class(next)->name);
+		return 2;
+	}
+
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
@@ -2242,19 +2295,16 @@ static inline int add_chain_cache(struct task_struct *curr,
 }
 
 /*
- * Look up a dependency chain.
+ * Look up a dependency chain. Must be called with either the graph lock or
+ * the RCU read lock held.
  */
 static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 {
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	/*
-	 * We can walk it lock-free, because entries only get added
-	 * to the hash:
-	 */
 	hlist_for_each_entry_rcu(chain, hash_head, entry) {
-		if (chain->chain_key == chain_key) {
+		if (READ_ONCE(chain->chain_key) == chain_key) {
 			debug_atomic_inc(chain_lookup_hits);
 			return chain;
 		}
@@ -3337,6 +3387,11 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (nest_lock && !__lock_is_held(nest_lock, -1))
 		return print_lock_nested_lock_not_held(curr, hlock, ip);
 
+	if (!debug_locks_silent) {
+		WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->key);
+		WARN_ON_ONCE(!hlock_class(hlock)->key);
+	}
+
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
@@ -4131,14 +4186,92 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+/* Remove a class from a lock chain. Must be called with the graph lock held. */
+static void remove_class_from_lock_chain(struct lock_chain *chain,
+					 struct lock_class *class)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	struct lock_chain *new_chain;
+	u64 chain_key;
+	int i;
+
+	for (i = chain->base; i < chain->base + chain->depth; i++) {
+		if (chain_hlocks[i] != class - lock_classes)
+			continue;
+		/* The code below leaks one chain_hlock[] entry. */
+		if (--chain->depth > 0)
+			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks[0]));
+		/*
+		 * Each lock class occurs at most once in a lock chain so once
+		 * we found a match we can break out of this loop.
+		 */
+		goto recalc;
+	}
+	/* Since the chain has not been modified, return. */
+	return;
+
+recalc:
+	chain_key = 0;
+	for (i = chain->base; i < chain->base + chain->depth; i++)
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+	if (chain->depth && chain->chain_key == chain_key)
+		return;
+	/* Overwrite the chain key for concurrent RCU readers. */
+	WRITE_ONCE(chain->chain_key, chain_key);
+	/*
+	 * Note: calling hlist_del_rcu() from inside a
+	 * hlist_for_each_entry_rcu() loop is safe.
+	 */
+	hlist_del_rcu(&chain->entry);
+	if (chain->depth == 0)
+		return;
+	/*
+	 * If the modified lock chain matches an existing lock chain, drop
+	 * the modified lock chain.
+	 */
+	if (lookup_chain_cache(chain_key))
+		return;
+	if (WARN_ON_ONCE(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+		debug_locks_off();
+		return;
+	}
+	/*
+	 * Leak *chain because it is not safe to reinsert it before an RCU
+	 * grace period has expired.
+	 */
+	new_chain = lock_chains + nr_lock_chains++;
+	*new_chain = *chain;
+	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+#endif
+}
+
+/* Must be called with the graph lock held. */
+static void remove_class_from_lock_chains(struct lock_class *class)
+{
+	struct lock_chain *chain;
+	struct hlist_head *head;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
+		head = chainhash_table + i;
+		hlist_for_each_entry_rcu(chain, head, entry) {
+			remove_class_from_lock_chain(chain, class);
+		}
+	}
+}
+
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
-static void zap_class(struct lock_class *class)
+static void zap_class(struct pending_free *pf, struct lock_class *class)
 {
 	struct lock_list *entry;
 	int i;
 
+	WARN_ON_ONCE(!class->key);
+
 	/*
 	 * Remove all dependencies this lock is
 	 * involved in:
@@ -4151,14 +4284,33 @@ static void zap_class(struct lock_class *class)
 		WRITE_ONCE(entry->class, NULL);
 		WRITE_ONCE(entry->links_to, NULL);
 	}
-	/*
-	 * Unhash the class and remove it from the all_lock_classes list:
-	 */
-	hlist_del_rcu(&class->hash_entry);
-	list_del(&class->lock_entry);
+	if (list_empty(&class->locks_after) &&
+	    list_empty(&class->locks_before)) {
+		list_move_tail(&class->lock_entry, &pf->zapped);
+		hlist_del_rcu(&class->hash_entry);
+		WRITE_ONCE(class->key, NULL);
+		WRITE_ONCE(class->name, NULL);
+		nr_lock_classes--;
+	} else {
+		WARN_ONCE(true, "%s() failed for class %s\n", __func__,
+			  class->name);
+	}
 
-	RCU_INIT_POINTER(class->key, NULL);
-	RCU_INIT_POINTER(class->name, NULL);
+	remove_class_from_lock_chains(class);
+}
+
+static void reinit_class(struct lock_class *class)
+{
+	void *const p = class;
+	const unsigned int offset = offsetof(struct lock_class, key);
+
+	WARN_ON_ONCE(!class->lock_entry.next);
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	memset(p + offset, 0, sizeof(*class) - offset);
+	WARN_ON_ONCE(!class->lock_entry.next);
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
@@ -4166,7 +4318,87 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
-static void __lockdep_free_key_range(void *start, unsigned long size)
+static bool inside_selftest(void)
+{
+	return current == lockdep_selftest_task_struct;
+}
+
+/* The caller must hold the graph lock. */
+static struct pending_free *get_pending_free(void)
+{
+	return delayed_free.pf + delayed_free.index;
+}
+
+static void free_zapped_rcu(struct rcu_head *cb);
+
+/*
+ * Schedule an RCU callback if no RCU callback is pending. Must be called with
+ * the graph lock held.
+ */
+static void call_rcu_zapped(struct pending_free *pf)
+{
+	WARN_ON_ONCE(inside_selftest());
+
+	if (list_empty(&pf->zapped))
+		return;
+
+	if (delayed_free.scheduled)
+		return;
+
+	delayed_free.scheduled = true;
+
+	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
+	delayed_free.index ^= 1;
+
+	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+}
+
+/* The caller must hold the graph lock. May be called from RCU context. */
+static void __free_zapped_classes(struct pending_free *pf)
+{
+	struct lock_class *class;
+
+	list_for_each_entry(class, &pf->zapped, lock_entry)
+		reinit_class(class);
+
+	list_splice_init(&pf->zapped, &free_lock_classes);
+}
+
+static void free_zapped_rcu(struct rcu_head *ch)
+{
+	struct pending_free *pf;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
+		return;
+
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	/* closed head */
+	pf = delayed_free.pf + (delayed_free.index ^ 1);
+	__free_zapped_classes(pf);
+	delayed_free.scheduled = false;
+
+	/*
+	 * If there's anything on the open list, close and start a new callback.
+	 */
+	call_rcu_zapped(delayed_free.pf + delayed_free.index);
+
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
+}
+
+/*
+ * Remove all lock classes from the class hash table and from the
+ * all_lock_classes list whose key or name is in the address range [start,
+ * start + size). Move these lock classes to the zapped_classes list. Must
+ * be called with the graph lock held.
+ */
+static void __lockdep_free_key_range(struct pending_free *pf, void *start,
+				     unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
@@ -4179,7 +4411,7 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
 			if (!within(class->key, start, size) &&
 			    !within(class->name, start, size))
 				continue;
-			zap_class(class);
+			zap_class(pf, class);
 		}
 	}
 }
@@ -4192,8 +4424,9 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
  * guaranteed nobody will look up these exact classes -- they're properly dead
  * but still allocated.
  */
-void lockdep_free_key_range(void *start, unsigned long size)
+static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
+	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
 
@@ -4201,9 +4434,15 @@ void lockdep_free_key_range(void *start, unsigned long size)
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
-	__lockdep_free_key_range(start, size);
-	if (locked)
-		graph_unlock();
+	if (!locked)
+		goto out_irq;
+
+	pf = get_pending_free();
+	__lockdep_free_key_range(pf, start, size);
+	call_rcu_zapped(pf);
+
+	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4211,12 +4450,35 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	 * before continuing to free the memory they refer to.
 	 */
 	synchronize_rcu();
+}
 
-	/*
-	 * XXX at this point we could return the resources to the pool;
-	 * instead we leak them. We would need to change to bitmap allocators
-	 * instead of the linear allocators we have now.
-	 */
+/*
+ * Free all lockdep keys in the range [start, start+size). Does not sleep.
+ * Ignores debug_locks. Must only be used by the lockdep selftests.
+ */
+static void lockdep_free_key_range_imm(void *start, unsigned long size)
+{
+	struct pending_free *pf = delayed_free.pf;
+	unsigned long flags;
+
+	init_data_structures_once();
+
+	raw_local_irq_save(flags);
+	arch_spin_lock(&lockdep_lock);
+	__lockdep_free_key_range(pf, start, size);
+	__free_zapped_classes(pf);
+	arch_spin_unlock(&lockdep_lock);
+	raw_local_irq_restore(flags);
+}
+
+void lockdep_free_key_range(void *start, unsigned long size)
+{
+	init_data_structures_once();
+
+	if (inside_selftest())
+		lockdep_free_key_range_imm(start, size);
+	else
+		lockdep_free_key_range_reg(start, size);
 }
 
 /*
@@ -4242,7 +4504,8 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 }
 
 /* The caller must hold the graph lock. Does not sleep. */
-static void __lockdep_reset_lock(struct lockdep_map *lock)
+static void __lockdep_reset_lock(struct pending_free *pf,
+				 struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	int j;
@@ -4256,7 +4519,7 @@ static void __lockdep_reset_lock(struct lockdep_map *lock)
 		 */
 		class = look_up_lock_class(lock, j);
 		if (class)
-			zap_class(class);
+			zap_class(pf, class);
 	}
 	/*
 	 * Debug check: in the end all mapped classes should
@@ -4266,21 +4529,57 @@ static void __lockdep_reset_lock(struct lockdep_map *lock)
 		debug_locks_off();
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/*
+ * Remove all information lockdep has about a lock if debug_locks == 1. Free
+ * released data structures from RCU context.
+ */
+static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 {
+	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
 
-	init_data_structures_once();
-
 	raw_local_irq_save(flags);
 	locked = graph_lock();
-	__lockdep_reset_lock(lock);
-	if (locked)
-		graph_unlock();
+	if (!locked)
+		goto out_irq;
+
+	pf = get_pending_free();
+	__lockdep_reset_lock(pf, lock);
+	call_rcu_zapped(pf);
+
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
+}
+
+/*
+ * Reset a lock. Does not sleep. Ignores debug_locks. Must only be used by the
+ * lockdep selftests.
+ */
+static void lockdep_reset_lock_imm(struct lockdep_map *lock)
+{
+	struct pending_free *pf = delayed_free.pf;
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	arch_spin_lock(&lockdep_lock);
+	__lockdep_reset_lock(pf, lock);
+	__free_zapped_classes(pf);
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
 
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	init_data_structures_once();
+
+	if (inside_selftest())
+		lockdep_reset_lock_imm(lock);
+	else
+		lockdep_reset_lock_reg(lock);
+}
+
 void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
@@ -4297,7 +4596,8 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
-		sizeof(chainhash_table)
+		sizeof(chainhash_table) +
+		sizeof(delayed_free)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
