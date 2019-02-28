Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EA1218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfB1HOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:14:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfB1HOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:14:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7DmQN2939894
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:13:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7DmhT2939891;
        Wed, 27 Feb 2019 23:13:48 -0800
Date:   Wed, 27 Feb 2019 23:13:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-108c14858b9ea224686e476c8f5ec345a0df9e27@git.kernel.org>
Cc:     hpa@zytor.com, johannes@sipsolutions.net, peterz@infradead.org,
        longman@redhat.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, bvanassche@acm.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, will.deacon@arm.com, bvanassche@acm.org,
          paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
          longman@redhat.com, torvalds@linux-foundation.org,
          johannes@sipsolutions.net, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190214230058.196511-19-bvanassche@acm.org>
References: <20190214230058.196511-19-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Add support for dynamic keys
Git-Commit-ID: 108c14858b9ea224686e476c8f5ec345a0df9e27
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

Commit-ID:  108c14858b9ea224686e476c8f5ec345a0df9e27
Gitweb:     https://git.kernel.org/tip/108c14858b9ea224686e476c8f5ec345a0df9e27
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:53 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:47 +0100

locking/lockdep: Add support for dynamic keys

A shortcoming of the current lockdep implementation is that it requires
lock keys to be allocated statically. That forces all instances of lock
objects that occur in a given data structure to share a lock key. Since
lock dependency analysis groups lock objects per key sharing lock keys
can cause false positive lockdep reports. Make it possible to avoid
such false positive reports by allowing lock keys to be allocated
dynamically. Require that dynamically allocated lock keys are
registered before use by calling lockdep_register_key(). Complain about
attempts to register the same lock key pointer twice without calling
lockdep_unregister_key() between successive registration calls.

The purpose of the new lock_keys_hash[] data structure that keeps
track of all dynamic keys is twofold:

  - Verify whether the lockdep_register_key() and lockdep_unregister_key()
    functions are used correctly.

  - Avoid that lockdep_init_map() complains when encountering a dynamically
    allocated key.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-19-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  |  21 ++++++--
 kernel/locking/lockdep.c | 121 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 619ec3f26cdc..43fb35bd7baf 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -46,15 +46,19 @@ extern int lock_stat;
 #define NR_LOCKDEP_CACHING_CLASSES	2
 
 /*
- * Lock-classes are keyed via unique addresses, by embedding the
- * lockclass-key into the kernel (or module) .data section. (For
- * static locks we use the lock address itself as the key.)
+ * A lockdep key is associated with each lock object. For static locks we use
+ * the lock address itself as the key. Dynamically allocated lock objects can
+ * have a statically or dynamically allocated key. Dynamically allocated lock
+ * keys must be registered before being used and must be unregistered before
+ * the key memory is freed.
  */
 struct lockdep_subclass_key {
 	char __one_byte;
 } __attribute__ ((__packed__));
 
+/* hash_entry is used to keep track of dynamically allocated keys. */
 struct lock_class_key {
+	struct hlist_node		hash_entry;
 	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 };
 
@@ -273,6 +277,9 @@ extern void lockdep_set_selftest_task(struct task_struct *task);
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
+extern void lockdep_register_key(struct lock_class_key *key);
+extern void lockdep_unregister_key(struct lock_class_key *key);
+
 /*
  * These methods are used by specific locking variants (spinlocks,
  * rwlocks, mutexes and rwsems) to pass init/acquire/release events
@@ -434,6 +441,14 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
  */
 struct lock_class_key { };
 
+static inline void lockdep_register_key(struct lock_class_key *key)
+{
+}
+
+static inline void lockdep_unregister_key(struct lock_class_key *key)
+{
+}
+
 /*
  * The lockdep_map takes no space if lockdep is disabled:
  */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 84427441824e..c73bc4334bee 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -143,6 +143,9 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
  * nr_lock_classes is the number of elements of lock_classes[] that is
  * in use.
  */
+#define KEYHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
+#define KEYHASH_SIZE		(1UL << KEYHASH_BITS)
+static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
 unsigned long nr_lock_classes;
 #ifndef CONFIG_DEBUG_LOCKDEP
 static
@@ -641,7 +644,7 @@ static int very_verbose(struct lock_class *class)
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-static int static_obj(void *obj)
+static int static_obj(const void *obj)
 {
 	unsigned long start = (unsigned long) &_stext,
 		      end   = (unsigned long) &_end,
@@ -975,6 +978,71 @@ static void init_data_structures_once(void)
 	}
 }
 
+static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
+{
+	unsigned long hash = hash_long((uintptr_t)key, KEYHASH_BITS);
+
+	return lock_keys_hash + hash;
+}
+
+/* Register a dynamically allocated key. */
+void lockdep_register_key(struct lock_class_key *key)
+{
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return;
+	hash_head = keyhashentry(key);
+
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto restore_irqs;
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (WARN_ON_ONCE(k == key))
+			goto out_unlock;
+	}
+	hlist_add_head_rcu(&key->hash_entry, hash_head);
+out_unlock:
+	graph_unlock();
+restore_irqs:
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_register_key);
+
+/* Check whether a key has been registered as a dynamic key. */
+static bool is_dynamic_key(const struct lock_class_key *key)
+{
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	bool found = false;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return false;
+
+	/*
+	 * If lock debugging is disabled lock_keys_hash[] may contain
+	 * pointers to memory that has already been freed. Avoid triggering
+	 * a use-after-free in that case by returning early.
+	 */
+	if (!debug_locks)
+		return true;
+
+	hash_head = keyhashentry(key);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -996,7 +1064,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
 			return NULL;
-	} else if (!static_obj(lock->key)) {
+	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
 		return NULL;
 	}
 
@@ -3378,13 +3446,12 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 	if (DEBUG_LOCKS_WARN_ON(!key))
 		return;
 	/*
-	 * Sanity check, the lock-class key must be persistent:
+	 * Sanity check, the lock-class key must either have been allocated
+	 * statically or must have been registered as a dynamic key.
 	 */
-	if (!static_obj(key)) {
-		printk("BUG: key %px not in .data!\n", key);
-		/*
-		 * What it says above ^^^^^, I suggest you read it.
-		 */
+	if (!static_obj(key) && !is_dynamic_key(key)) {
+		if (debug_locks)
+			printk(KERN_ERR "BUG: key %px has not been registered!\n", key);
 		DEBUG_LOCKS_WARN_ON(1);
 		return;
 	}
@@ -4795,6 +4862,44 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		lockdep_reset_lock_reg(lock);
 }
 
+/* Unregister a dynamically allocated key. */
+void lockdep_unregister_key(struct lock_class_key *key)
+{
+	struct hlist_head *hash_head = keyhashentry(key);
+	struct lock_class_key *k;
+	struct pending_free *pf;
+	unsigned long flags;
+	bool found = false;
+
+	might_sleep();
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return;
+
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	pf = get_pending_free();
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			hlist_del_rcu(&k->hash_entry);
+			found = true;
+			break;
+		}
+	}
+	WARN_ON_ONCE(!found);
+	__lockdep_free_key_range(pf, key, 1);
+	call_rcu_zapped(pf);
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
+
+	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(lockdep_unregister_key);
+
 void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
