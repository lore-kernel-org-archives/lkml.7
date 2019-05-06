Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F3C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF702087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzx/VcTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEFIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43894 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so6081422pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tmwbna4KmKFxAHRqT7/HYMHQcHvcAPY+eOoju0eHBSk=;
        b=Wzx/VcTOMBWV7qMQUSzromVZM5IMdohR3Spm+YrPxLzX87hkL995O8EZHncr6C7e37
         qxZ/5xNeOum/NfV2AR44pcqAEBDSQY/G7TbbazJA3z27BYeYjQKkjQgHpmV3Jta6t/x7
         nL31T7bs6PAvJMgrr9i8SbMjE709WLudF+x1rEH6VcTbHjC/hl3/wC4b4CtAquiJECUY
         9qOaLuSeaATa/oVirG1uwCHVaKt7gqXQ4YpkvDRdbEhuvCepip4/rWstT6Dpav9VoMrX
         TGOgiAgNeKVaMVPRpms8UI6ZaJQPMNfKZcDWJi6TrU/4Lzp2Lyx8B4AxQSU6tQ08WSTd
         RdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tmwbna4KmKFxAHRqT7/HYMHQcHvcAPY+eOoju0eHBSk=;
        b=jPgf3SmNE5IOekIwxpf2Ba2m+JSCkZv4sZYQJfbMz3W3VrYw6ZxuEj09ly8ILUpJLk
         54tOqZGJmehJxnQzuEfqeuXs7onJWcEkxTnNE/8Twf1rXyaTBZaO4JWgGWO+vIkIJSl7
         2DfNwbovLETSfM3TLmFN4Hu+VgRPBq5wUGtV0zdxQbJGwh0T0BFU1nXOccLxeAK6CHPa
         ajys0qNLNnKYSO1LbsiQJcE32Qh0g03WxT2Lp024e1JCBOXPbmNhrTzrZQdoFbjB1AIJ
         Vn3fIAz3Jwz5WEll5RRA48N3QkCcI8NrEHpRiNJd3qlZ0K/GrzRKKeGrEzNsaaZgVZMZ
         RSqw==
X-Gm-Message-State: APjAAAUQALG0Ec0JccZEJPmJx6mOlOnGGoRj6TwQZUyzSC+mL2sXIW+c
        YbhutZNXnIGoM2YitAIOn8U=
X-Google-Smtp-Source: APXvYqz1XbvvCGvdVvIMDpTHX+LN5gAwNjUETEzJOyv0bmEHbTxIK+L2n+poZIJm7RW5Bh+pKt1K7A==
X-Received: by 2002:a63:e550:: with SMTP id z16mr30753578pgj.329.1557130818238;
        Mon, 06 May 2019 01:20:18 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:17 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 09/23] locking/lockdep: Change the range of class_idx in held_lock struct
Date:   Mon,  6 May 2019 16:19:25 +0800
Message-Id: <20190506081939.74287-10-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/lockdep.h  | 14 ++++++------
 kernel/locking/lockdep.c | 59 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index bb47d7c..7c2fefa 100644
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
index 7d16fcc..76152cc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -150,17 +150,28 @@ static inline int debug_locks_off_graph_unlock(void)
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
@@ -589,19 +600,22 @@ static void print_lock(struct held_lock *hlock)
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
 
@@ -856,7 +870,7 @@ static bool check_lock_chain_key(struct lock_chain *chain)
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
 	/*
 	 * The 'unsigned long long' casts avoid that a compiler warning
 	 * is reported when building tools/lib/lockdep.
@@ -1131,6 +1145,7 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 		return NULL;
 	}
 	nr_lock_classes++;
+	__set_bit(class - lock_classes, lock_classes_in_use);
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
@@ -2545,7 +2560,7 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
 		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id + 1, chain_key);
+		chain_key = print_chain_key_iteration(class_id, chain_key);
 
 		print_lock_name(lock_classes + class_id);
 		printk("\n");
@@ -2596,7 +2611,7 @@ static int check_no_collision(struct task_struct *curr,
 	}
 
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		id = curr->held_locks[i].class_idx - 1;
+		id = curr->held_locks[i].class_idx;
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
 			print_collision(curr, hlock, chain);
@@ -2679,7 +2694,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
-			int lock_id = curr->held_locks[i].class_idx - 1;
+			int lock_id = curr->held_locks[i].class_idx;
 			chain_hlocks[chain->base + j] = lock_id;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
@@ -2863,10 +2878,12 @@ static void check_chain_key(struct task_struct *curr)
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
@@ -3714,7 +3731,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH))
 		return 0;
 
-	class_idx = class - lock_classes + 1;
+	class_idx = class - lock_classes;
 
 	if (depth) {
 		hlock = curr->held_locks + depth - 1;
@@ -3776,9 +3793,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3893,7 +3910,7 @@ static int match_held_lock(const struct held_lock *hlock,
 		if (DEBUG_LOCKS_WARN_ON(!hlock->nest_lock))
 			return 0;
 
-		if (hlock->class_idx == class - lock_classes + 1)
+		if (hlock->class_idx == class - lock_classes)
 			return 1;
 	}
 
@@ -3987,7 +4004,7 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 
 	lockdep_init_map(lock, name, key, 0);
 	class = register_lock_class(lock, subclass, 0);
-	hlock->class_idx = class - lock_classes + 1;
+	hlock->class_idx = class - lock_classes;
 
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
@@ -4637,7 +4654,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 recalc:
 	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
 	if (chain->depth && chain->chain_key == chain_key)
 		return;
 	/* Overwrite the chain key for concurrent RCU readers. */
@@ -4711,6 +4728,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
 		nr_lock_classes--;
+		__clear_bit(class - lock_classes, lock_classes_in_use);
 	} else {
 		WARN_ONCE(true, "%s() failed for class %s\n", __func__,
 			  class->name);
@@ -5056,6 +5074,7 @@ void __init lockdep_init(void)
 
 	printk(" memory used by lock dependency info: %zu kB\n",
 	       (sizeof(lock_classes) +
+		sizeof(lock_classes_in_use) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
 		sizeof(list_entries_in_use) +
-- 
1.8.3.1

