Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CFA23A61
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N84DjHMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfFCNMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:12:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:12:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DCBk2605588
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:12:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DCBk2605588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567532;
        bh=BhiN52TB/dQyXVGItsz0PQw8WUZoC2aLZY7X0lw1MVo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N84DjHMXIkkUgKcZpRUceMeU3oQrnDsq7pevOrqMgZjB9547bi47tjGQWvcfSpK+J
         tWh3gvOGrnK6sc3ymB91gy5yEYm8g/gNPkkgfTeqj8iqIL4Cb987H1LO0EQY6fMJfR
         lfEXZ8+qUyMvgls567w9smPumsBDmSNbRwJg6K33XYKxj2k594naHeCrja4n2akC8l
         36m/0jsD/0n1T95YAkZWfek83gexT4slJAzn+EHVD96ICzJlUcTBGRd+wlxOrd+7xd
         bdoXGkhKh2A5yIx83KVECnvaT2NdnOGF3ZdMIf0DM8L/VN5ycyhgxkPTVb6Ta2hVMZ
         wIgZOnF9+3D3A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DCBtD605585;
        Mon, 3 Jun 2019 06:12:11 -0700
Date:   Mon, 3 Jun 2019 06:12:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-01bb6f0af992a1e6b7797d92fd31a7864872e347@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, duyuyang@gmail.com
Reply-To: tglx@linutronix.de, duyuyang@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org
In-Reply-To: <20190506081939.74287-10-duyuyang@gmail.com>
References: <20190506081939.74287-10-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Change the range of class_idx
 in held_lock struct
Git-Commit-ID: 01bb6f0af992a1e6b7797d92fd31a7864872e347
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

Commit-ID:  01bb6f0af992a1e6b7797d92fd31a7864872e347
Gitweb:     https://git.kernel.org/tip/01bb6f0af992a1e6b7797d92fd31a7864872e347
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:25 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:43 +0200

locking/lockdep: Change the range of class_idx in held_lock struct

held_lock->class_idx is used to point to the class of the held lock. The
index is shifted by 1 to make index 0 mean no class, which results in class
index shifting back and forth but is not worth doing so.

The reason is: (1) there will be no "no-class" held_lock to begin with, and
(2) index 0 seems to be used for error checking, but if something wrong
indeed happened, the index can't be counted on to distinguish it as that
something won't set the class_idx to 0 on purpose to tell us it is wrong.

Therefore, change the index to start from 0. This saves a lot of
back-and-forth shifts and a class slot back to lock_classes.

Since index 0 is now used for lock class, we change the initial chain key to
-1 to avoid key collision, which is due to the fact that __jhash_mix(0, 0, 0) = 0.
Actually, the initial chain key can be any arbitrary value other than 0.

In addition, a bitmap is maintained to keep track of the used lock classes,
and we check the validity of the held lock against that bitmap.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-10-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  | 14 ++++++------
 kernel/locking/lockdep.c | 59 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index d4e69595dbd4..30a0f81aa130 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -223,13 +223,8 @@ struct lock_chain {
 };
 
 #define MAX_LOCKDEP_KEYS_BITS		13
-/*
- * Subtract one because we offset hlock->class_idx by 1 in order
- * to make 0 mean no class. This avoids overflowing the class_idx
- * bitfield and hitting the BUG in hlock_class().
- */
-#define MAX_LOCKDEP_KEYS		((1UL << MAX_LOCKDEP_KEYS_BITS) - 1)
-#define INITIAL_CHAIN_KEY		0
+#define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
+#define INITIAL_CHAIN_KEY		-1
 
 struct held_lock {
 	/*
@@ -254,6 +249,11 @@ struct held_lock {
 	u64 				waittime_stamp;
 	u64				holdtime_stamp;
 #endif
+	/*
+	 * class_idx is zero-indexed; it points to the element in
+	 * lock_classes this held lock instance belongs to. class_idx is in
+	 * the range from 0 to (MAX_LOCKDEP_KEYS-1) inclusive.
+	 */
 	unsigned int			class_idx:MAX_LOCKDEP_KEYS_BITS;
 	/*
 	 * The lock-stack is unified in that the lock chains of interrupt
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9edf6f12b711..3eecae315885 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -151,17 +151,28 @@ unsigned long nr_lock_classes;
 static
 #endif
 struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
+static DECLARE_BITMAP(lock_classes_in_use, MAX_LOCKDEP_KEYS);
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
 {
-	if (!hlock->class_idx) {
+	unsigned int class_idx = hlock->class_idx;
+
+	/* Don't re-read hlock->class_idx, can't use READ_ONCE() on bitfield */
+	barrier();
+
+	if (!test_bit(class_idx, lock_classes_in_use)) {
 		/*
 		 * Someone passed in garbage, we give up.
 		 */
 		DEBUG_LOCKS_WARN_ON(1);
 		return NULL;
 	}
-	return lock_classes + hlock->class_idx - 1;
+
+	/*
+	 * At this point, if the passed hlock->class_idx is still garbage,
+	 * we just have to live with it
+	 */
+	return lock_classes + class_idx;
 }
 
 #ifdef CONFIG_LOCK_STAT
@@ -590,19 +601,22 @@ static void print_lock(struct held_lock *hlock)
 	/*
 	 * We can be called locklessly through debug_show_all_locks() so be
 	 * extra careful, the hlock might have been released and cleared.
+	 *
+	 * If this indeed happens, lets pretend it does not hurt to continue
+	 * to print the lock unless the hlock class_idx does not point to a
+	 * registered class. The rationale here is: since we don't attempt
+	 * to distinguish whether we are in this situation, if it just
+	 * happened we can't count on class_idx to tell either.
 	 */
-	unsigned int class_idx = hlock->class_idx;
+	struct lock_class *lock = hlock_class(hlock);
 
-	/* Don't re-read hlock->class_idx, can't use READ_ONCE() on bitfields: */
-	barrier();
-
-	if (!class_idx || (class_idx - 1) >= MAX_LOCKDEP_KEYS) {
+	if (!lock) {
 		printk(KERN_CONT "<RELEASED>\n");
 		return;
 	}
 
 	printk(KERN_CONT "%p", hlock->instance);
-	print_lock_name(lock_classes + class_idx - 1);
+	print_lock_name(lock);
 	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
@@ -861,7 +875,7 @@ static bool check_lock_chain_key(struct lock_chain *chain)
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
 	/*
 	 * The 'unsigned long long' casts avoid that a compiler warning
 	 * is reported when building tools/lib/lockdep.
@@ -1136,6 +1150,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 		return NULL;
 	}
 	nr_lock_classes++;
+	__set_bit(class - lock_classes, lock_classes_in_use);
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
@@ -2550,7 +2565,7 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
 		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id + 1, chain_key);
+		chain_key = print_chain_key_iteration(class_id, chain_key);
 
 		print_lock_name(lock_classes + class_id);
 		printk("\n");
@@ -2601,7 +2616,7 @@ static int check_no_collision(struct task_struct *curr,
 	}
 
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		id = curr->held_locks[i].class_idx - 1;
+		id = curr->held_locks[i].class_idx;
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
 			print_collision(curr, hlock, chain);
@@ -2684,7 +2699,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
-			int lock_id = curr->held_locks[i].class_idx - 1;
+			int lock_id = curr->held_locks[i].class_idx;
 			chain_hlocks[chain->base + j] = lock_id;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
@@ -2864,10 +2879,12 @@ static void check_chain_key(struct task_struct *curr)
 				(unsigned long long)hlock->prev_chain_key);
 			return;
 		}
+
 		/*
-		 * Whoops ran out of static storage again?
+		 * hlock->class_idx can't go beyond MAX_LOCKDEP_KEYS, but is
+		 * it registered lock class index?
 		 */
-		if (DEBUG_LOCKS_WARN_ON(hlock->class_idx > MAX_LOCKDEP_KEYS))
+		if (DEBUG_LOCKS_WARN_ON(!test_bit(hlock->class_idx, lock_classes_in_use)))
 			return;
 
 		if (prev_hlock && (prev_hlock->irq_context !=
@@ -3715,7 +3732,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH))
 		return 0;
 
-	class_idx = class - lock_classes + 1;
+	class_idx = class - lock_classes;
 
 	if (depth) {
 		hlock = curr->held_locks + depth - 1;
@@ -3777,9 +3794,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	 * the hash, not class->key.
 	 */
 	/*
-	 * Whoops, we did it again.. ran straight out of our static allocation.
+	 * Whoops, we did it again.. class_idx is invalid.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS))
+	if (DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use)))
 		return 0;
 
 	chain_key = curr->curr_chain_key;
@@ -3894,7 +3911,7 @@ static int match_held_lock(const struct held_lock *hlock,
 		if (DEBUG_LOCKS_WARN_ON(!hlock->nest_lock))
 			return 0;
 
-		if (hlock->class_idx == class - lock_classes + 1)
+		if (hlock->class_idx == class - lock_classes)
 			return 1;
 	}
 
@@ -3988,7 +4005,7 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 
 	lockdep_init_map(lock, name, key, 0);
 	class = register_lock_class(lock, subclass, 0);
-	hlock->class_idx = class - lock_classes + 1;
+	hlock->class_idx = class - lock_classes;
 
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
@@ -4638,7 +4655,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 recalc:
 	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
 	if (chain->depth && chain->chain_key == chain_key)
 		return;
 	/* Overwrite the chain key for concurrent RCU readers. */
@@ -4712,6 +4729,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
 		nr_lock_classes--;
+		__clear_bit(class - lock_classes, lock_classes_in_use);
 	} else {
 		WARN_ONCE(true, "%s() failed for class %s\n", __func__,
 			  class->name);
@@ -5057,6 +5075,7 @@ void __init lockdep_init(void)
 
 	printk(" memory used by lock dependency info: %zu kB\n",
 	       (sizeof(lock_classes) +
+		sizeof(lock_classes_in_use) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
 		sizeof(list_entries_in_use) +
