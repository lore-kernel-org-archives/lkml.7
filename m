Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E071AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A702A20842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfB1HMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:12:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfB1HMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:12:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7BpWq2939483
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:11:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7BovY2939479;
        Wed, 27 Feb 2019 23:11:50 -0800
Date:   Wed, 27 Feb 2019 23:11:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-de4643a77356a77bce73f64275b125b4b71a69cf@git.kernel.org>
Cc:     johannes@sipsolutions.net, mingo@kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        bvanassche@acm.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        longman@redhat.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org
Reply-To: akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
          tglx@linutronix.de, longman@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, bvanassche@acm.org,
          will.deacon@arm.com, mingo@kernel.org, johannes@sipsolutions.net
In-Reply-To: <20190214230058.196511-16-bvanassche@acm.org>
References: <20190214230058.196511-16-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Reuse lock chains that have
 been freed
Git-Commit-ID: de4643a77356a77bce73f64275b125b4b71a69cf
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

Commit-ID:  de4643a77356a77bce73f64275b125b4b71a69cf
Gitweb:     https://git.kernel.org/tip/de4643a77356a77bce73f64275b125b4b71a69cf
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:50 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:45 +0100

locking/lockdep: Reuse lock chains that have been freed

A previous patch introduced a lock chain leak. Fix that leak by reusing
lock chains that have been freed.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-16-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 57 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ec0cb794f70d..0bb204464afe 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -292,9 +292,12 @@ static LIST_HEAD(free_lock_classes);
 /**
  * struct pending_free - information about data structures about to be freed
  * @zapped: Head of a list with struct lock_class elements.
+ * @lock_chains_being_freed: Bitmap that indicates which lock_chains[] elements
+ *	are about to be freed.
  */
 struct pending_free {
 	struct list_head zapped;
+	DECLARE_BITMAP(lock_chains_being_freed, MAX_LOCKDEP_CHAINS);
 };
 
 /**
@@ -2096,8 +2099,8 @@ out_bug:
 	return 0;
 }
 
-static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
+static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 
@@ -2236,12 +2239,25 @@ static int check_no_collision(struct task_struct *curr,
  */
 long lockdep_next_lockchain(long i)
 {
-	return i + 1 < nr_lock_chains ? i + 1 : -2;
+	i = find_next_bit(lock_chains_in_use, ARRAY_SIZE(lock_chains), i + 1);
+	return i < ARRAY_SIZE(lock_chains) ? i : -2;
 }
 
 unsigned long lock_chain_count(void)
 {
-	return nr_lock_chains;
+	return bitmap_weight(lock_chains_in_use, ARRAY_SIZE(lock_chains));
+}
+
+/* Must be called with the graph lock held. */
+static struct lock_chain *alloc_lock_chain(void)
+{
+	int idx = find_first_zero_bit(lock_chains_in_use,
+				      ARRAY_SIZE(lock_chains));
+
+	if (unlikely(idx >= ARRAY_SIZE(lock_chains)))
+		return NULL;
+	__set_bit(idx, lock_chains_in_use);
+	return lock_chains + idx;
 }
 
 /*
@@ -2260,11 +2276,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 	struct lock_chain *chain;
 	int i, j;
 
-	/*
-	 * Allocate a new chain entry from the static array, and add
-	 * it to the hash:
-	 */
-
 	/*
 	 * The caller must hold the graph lock, ensure we've got IRQs
 	 * disabled to make this an IRQ-safe lock.. for recursion reasons
@@ -2273,7 +2284,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return 0;
 
-	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+	chain = alloc_lock_chain();
+	if (!chain) {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2281,7 +2293,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 		dump_stack();
 		return 0;
 	}
-	chain = lock_chains + nr_lock_chains++;
 	chain->chain_key = chain_key;
 	chain->irq_context = hlock->irq_context;
 	i = get_first_held_lock(curr, hlock);
@@ -4208,7 +4219,8 @@ void lockdep_reset(void)
 }
 
 /* Remove a class from a lock chain. Must be called with the graph lock held. */
-static void remove_class_from_lock_chain(struct lock_chain *chain,
+static void remove_class_from_lock_chain(struct pending_free *pf,
+					 struct lock_chain *chain,
 					 struct lock_class *class)
 {
 #ifdef CONFIG_PROVE_LOCKING
@@ -4246,6 +4258,7 @@ recalc:
 	 * hlist_for_each_entry_rcu() loop is safe.
 	 */
 	hlist_del_rcu(&chain->entry);
+	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
 	if (chain->depth == 0)
 		return;
 	/*
@@ -4254,22 +4267,19 @@ recalc:
 	 */
 	if (lookup_chain_cache(chain_key))
 		return;
-	if (WARN_ON_ONCE(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+	new_chain = alloc_lock_chain();
+	if (WARN_ON_ONCE(!new_chain)) {
 		debug_locks_off();
 		return;
 	}
-	/*
-	 * Leak *chain because it is not safe to reinsert it before an RCU
-	 * grace period has expired.
-	 */
-	new_chain = lock_chains + nr_lock_chains++;
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
 #endif
 }
 
 /* Must be called with the graph lock held. */
-static void remove_class_from_lock_chains(struct lock_class *class)
+static void remove_class_from_lock_chains(struct pending_free *pf,
+					  struct lock_class *class)
 {
 	struct lock_chain *chain;
 	struct hlist_head *head;
@@ -4278,7 +4288,7 @@ static void remove_class_from_lock_chains(struct lock_class *class)
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
 		hlist_for_each_entry_rcu(chain, head, entry) {
-			remove_class_from_lock_chain(chain, class);
+			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
 }
@@ -4317,7 +4327,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 			  class->name);
 	}
 
-	remove_class_from_lock_chains(class);
+	remove_class_from_lock_chains(pf, class);
 }
 
 static void reinit_class(struct lock_class *class)
@@ -4383,6 +4393,12 @@ static void __free_zapped_classes(struct pending_free *pf)
 		reinit_class(class);
 
 	list_splice_init(&pf->zapped, &free_lock_classes);
+
+#ifdef CONFIG_PROVE_LOCKING
+	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
+		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
+	bitmap_clear(pf->lock_chains_being_freed, 0, ARRAY_SIZE(lock_chains));
+#endif
 }
 
 static void free_zapped_rcu(struct rcu_head *ch)
@@ -4623,6 +4639,7 @@ void __init lockdep_init(void)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
+		+ sizeof(lock_chains_in_use)
 		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
