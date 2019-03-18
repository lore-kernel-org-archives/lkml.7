Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E60EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413E62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUFlVzXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCRI5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:57:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42096 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so8047540pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YiDL9SeZ1bOUiTTVU0TxWuil9w2kwg3iCp870npsqao=;
        b=XUFlVzXmXjXNUqm3MCB+wg/9wS9zLMQyd4vTvpoK4P1LzzLOljDNxVks/MbdfmPXs7
         WSOqf3bfDzS6q9gjR0QtSQZnplAPNt/EtZk0u2G1qGF4ip/B+lw4uTFQbmnTp0HH54yY
         QxG6rJowpiovIBcyqilom4g6ZcjZuK4ZK+YJlBWdXMOJu/mfK9nmlBv0Ymr3lzAdpATF
         R1Ads96zPhSU/obGS24HhVY8nMLAfIVAYskbNje29sa/b8lcVTnBlOkxUjXUDM9EWE1Q
         VMeC7zmNZRatTR+DyZjeZTKC5oShqqxmys2jiK1ez0t9ShTppdoQbAsNFYzLiG/85E0K
         8uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YiDL9SeZ1bOUiTTVU0TxWuil9w2kwg3iCp870npsqao=;
        b=kU9NR64lJmp1hlohV4xJEllazoZ12a4BljJsMLwplXbBeQ75dEhcKTOUw9M/BrfqiL
         rwrpTq2grbMaSoPosifmy5/jWeZVk3QPfgAWtVdhZOWDUOmOxmXx1uRy4arRa6zZ3uQz
         tyRgi6eLq9ay9NaTRxR/gmANE58yhANX6Pxs2MI7gRAOgna/IDzJ6k+VTtSKnqS+bZaL
         vohbgv7AK9tMKnd9R3VZBHRGFGYRHBBNd4u/gzwE9rJzocgLUHsiS48haGaaDRSYXGD3
         2NkIeC6me3rSXQ5HdcKy6gO9bAlmn55VNN9PECVpUbSkBXThSUoW6a31XTzhk6NpEHDn
         ZCYA==
X-Gm-Message-State: APjAAAV9d9ZTnPdpYAgT3MpzuQO/AMa6V8bQxE2ENIlyFX9rZnXJ+ADo
        3mxKK7i/hdi7bt1MyjbCB9Y=
X-Google-Smtp-Source: APXvYqy1V6BWQsUSJTvSSQ5w7pWNYeuM4TWMKr0CkjRyfdB4C+QlEuVLIom8/RtXmVo4DyP32ULFhA==
X-Received: by 2002:a65:64c4:: with SMTP id t4mr16689648pgv.152.1552899466680;
        Mon, 18 Mar 2019 01:57:46 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:46 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 01/19] locking/lockdep: Change all print_*() return type to void
Date:   Mon, 18 Mar 2019 16:57:15 +0800
Message-Id: <20190318085733.3143-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since none of the print_*() function's return value is necessary, change
their return type to void. No functional change.

In cases where an invariable return value is used, this change slightly
improves readability, i.e.:

	print_x();
	return 0;

is definitely better than:

	return print_x(); /* where print_x() always returns 0 */

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 222 ++++++++++++++++++++++++-----------------------
 1 file changed, 112 insertions(+), 110 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbe..1c5e947 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1430,23 +1430,20 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
  * Print a dependency chain entry (this is only done when a deadlock
  * has been detected):
  */
-static noinline int
+static noinline void
 print_circular_bug_entry(struct lock_list *target, int depth)
 {
 	if (debug_locks_silent)
-		return 0;
+		return;
 	printk("\n-> #%u", depth);
 	print_lock_name(target->class);
 	printk(KERN_CONT ":\n");
 	print_stack_trace(&target->trace, 6);
-
-	return 0;
 }
 
-static void
-print_circular_lock_scenario(struct held_lock *src,
-			     struct held_lock *tgt,
-			     struct lock_list *prt)
+static void print_circular_lock_scenario(struct held_lock *src,
+					 struct held_lock *tgt,
+					 struct lock_list *prt)
 {
 	struct lock_class *source = hlock_class(src);
 	struct lock_class *target = hlock_class(tgt);
@@ -1497,7 +1494,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
  * When a circular dependency is detected, print the
  * header first:
  */
-static noinline int
+static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 			struct held_lock *check_src,
 			struct held_lock *check_tgt)
@@ -1505,7 +1502,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	struct task_struct *curr = current;
 
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("======================================================\n");
@@ -1523,8 +1520,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
 	print_circular_bug_entry(entry, depth);
-
-	return 0;
 }
 
 static inline int class_equal(struct lock_list *entry, void *data)
@@ -1532,11 +1527,11 @@ static inline int class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
-static noinline int print_circular_bug(struct lock_list *this,
-				struct lock_list *target,
-				struct held_lock *check_src,
-				struct held_lock *check_tgt,
-				struct stack_trace *trace)
+static noinline void print_circular_bug(struct lock_list *this,
+					struct lock_list *target,
+					struct held_lock *check_src,
+					struct held_lock *check_tgt,
+					struct stack_trace *trace)
 {
 	struct task_struct *curr = current;
 	struct lock_list *parent;
@@ -1544,10 +1539,10 @@ static noinline int print_circular_bug(struct lock_list *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	if (!save_trace(&this->trace))
-		return 0;
+		return;
 
 	depth = get_lock_depth(target);
 
@@ -1569,21 +1564,17 @@ static noinline int print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
-static noinline int print_bfs_bug(int ret)
+static noinline void print_bfs_bug(int ret)
 {
 	if (!debug_locks_off_graph_unlock())
-		return 0;
+		return;
 
 	/*
 	 * Breadth-first-search failed, graph got corrupted?
 	 */
 	WARN(1, "lockdep bfs error:%d\n", ret);
-
-	return 0;
 }
 
 static int noop_count(struct lock_list *entry, void *data)
@@ -1766,7 +1757,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				struct lock_list *root)
+				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1788,8 +1779,6 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		entry = get_lock_parent(entry);
 		depth--;
 	} while (entry && (depth >= 0));
-
-	return;
 }
 
 static void
@@ -1848,7 +1837,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_bad_irq_dependency(struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
@@ -1861,7 +1850,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 			 const char *irqclass)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
@@ -1907,19 +1896,17 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
 	if (!save_trace(&prev_root->trace))
-		return 0;
+		return;
 	print_shortest_lock_dependencies(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	if (!save_trace(&next_root->trace))
-		return 0;
+		return;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int
@@ -1936,23 +1923,28 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	this.class = hlock_class(prev);
 	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
 	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
-	return print_bad_irq_dependency(curr, &this, &that,
-			target_entry, target_entry1,
-			prev, next,
-			bit_backwards, bit_forwards, irqclass);
+	print_bad_irq_dependency(curr, &this, &that,
+				 target_entry, target_entry1,
+				 prev, next,
+				 bit_backwards, bit_forwards, irqclass);
+	return 0;
 }
 
 static const char *state_names[] = {
@@ -2042,7 +2034,7 @@ static void inc_chains(void)
 
 static inline int
 check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+		   struct held_lock *next)
 {
 	return 1;
 }
@@ -2054,9 +2046,8 @@ static inline void inc_chains(void)
 
 #endif
 
-static void
-print_deadlock_scenario(struct held_lock *nxt,
-			     struct held_lock *prv)
+static void print_deadlock_scenario(struct held_lock *nxt,
+				    struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -2074,12 +2065,12 @@ static inline void inc_chains(void)
 	printk(" May be due to missing lock nesting notation\n\n");
 }
 
-static int
+static void
 print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("============================================\n");
@@ -2098,8 +2089,6 @@ static inline void inc_chains(void)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2141,7 +2130,8 @@ static inline void inc_chains(void)
 		if (nest)
 			return 2;
 
-		return print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(curr, prev, next);
+		return 0;
 	}
 	return 1;
 }
@@ -2217,10 +2207,13 @@ static inline void inc_chains(void)
 			 */
 			save(trace);
 		}
-		return print_circular_bug(&this, target_entry, next, prev, trace);
+		print_circular_bug(&this, target_entry, next, prev, trace);
+		return 0;
+	}
+	else if (unlikely(ret < 0)) {
+		print_bfs_bug(ret);
+		return 0;
 	}
-	else if (unlikely(ret < 0))
-		return print_bfs_bug(ret);
 
 	if (!check_prev_add_irq(curr, prev, next))
 		return 0;
@@ -2261,8 +2254,10 @@ static inline void inc_chains(void)
 		debug_atomic_inc(nr_redundant);
 		return 2;
 	}
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 
 
 	if (!trace->entries && !save(trace))
@@ -2452,8 +2447,8 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 }
 
 static void print_collision(struct task_struct *curr,
-			struct held_lock *hlock_next,
-			struct lock_chain *chain)
+			    struct held_lock *hlock_next,
+			    struct lock_chain *chain)
 {
 	pr_warn("\n");
 	pr_warn("============================\n");
@@ -2726,8 +2721,8 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 }
 #else
 static inline int validate_chain(struct task_struct *curr,
-	       	struct lockdep_map *lock, struct held_lock *hlock,
-		int chain_head, u64 chain_key)
+				 struct lockdep_map *lock, struct held_lock *hlock,
+				 int chain_head, u64 chain_key)
 {
 	return 1;
 }
@@ -2784,8 +2779,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
-static void
-print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
@@ -2802,12 +2796,12 @@ static void check_chain_key(struct task_struct *curr)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("================================\n");
@@ -2837,8 +2831,6 @@ static void check_chain_key(struct task_struct *curr)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2848,8 +2840,10 @@ static void check_chain_key(struct task_struct *curr)
 valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
-	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit)))
-		return print_usage_bug(curr, this, bad_bit, new_bit);
+	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
+		print_usage_bug(curr, this, bad_bit, new_bit);
+		return 0;
+	}
 	return 1;
 }
 
@@ -2861,7 +2855,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 /*
  * print irq inversion bug:
  */
-static int
+static void
 print_irq_inversion_bug(struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
@@ -2872,7 +2866,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("========================================================\n");
@@ -2913,13 +2907,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	if (!save_trace(&root->trace))
-		return 0;
+		return;
 	print_shortest_lock_dependencies(other, root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2937,13 +2929,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, bit, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
-	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 1, irqclass);
+	print_irq_inversion_bug(curr, &root, target_entry,
+				this, 1, irqclass);
+	return 0;
 }
 
 /*
@@ -2961,13 +2956,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, bit, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
-	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 0, irqclass);
+	print_irq_inversion_bug(curr, &root, target_entry,
+				this, 0, irqclass);
+	return 0;
 }
 
 void print_irqtrace_events(struct task_struct *curr)
@@ -3510,15 +3508,15 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
-static int
+static void
 print_lock_nested_lock_not_held(struct task_struct *curr,
 				struct held_lock *hlock,
 				unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("==================================\n");
@@ -3540,8 +3538,6 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3690,8 +3686,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	}
 	chain_key = iterate_chain_key(chain_key, class_idx);
 
-	if (nest_lock && !__lock_is_held(nest_lock, -1))
-		return print_lock_nested_lock_not_held(curr, hlock, ip);
+	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
+		print_lock_nested_lock_not_held(curr, hlock, ip);
+		return 0;
+	}
 
 	if (!debug_locks_silent) {
 		WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->key);
@@ -3727,14 +3725,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	return 1;
 }
 
-static int
-print_unlock_imbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
-			   unsigned long ip)
+static void print_unlock_imbalance_bug(struct task_struct *curr,
+				       struct lockdep_map *lock,
+				       unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================\n");
@@ -3752,8 +3750,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int match_held_lock(const struct held_lock *hlock,
@@ -3872,8 +3868,10 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 		return 0;
 
 	hlock = find_held_lock(curr, lock, depth, &i);
-	if (!hlock)
-		return print_unlock_imbalance_bug(curr, lock, ip);
+	if (!hlock) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	lockdep_init_map(lock, name, key, 0);
 	class = register_lock_class(lock, subclass, 0);
@@ -3913,8 +3911,10 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 		return 0;
 
 	hlock = find_held_lock(curr, lock, depth, &i);
-	if (!hlock)
-		return print_unlock_imbalance_bug(curr, lock, ip);
+	if (!hlock) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
@@ -3958,16 +3958,20 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	 * So we're all set to release this lock.. wait what lock? We don't
 	 * own any locks, you've been drinking again?
 	 */
-	if (DEBUG_LOCKS_WARN_ON(depth <= 0))
-		 return print_unlock_imbalance_bug(curr, lock, ip);
+	if (DEBUG_LOCKS_WARN_ON(depth <= 0)) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	/*
 	 * Check whether the lock exists in the current stack
 	 * of held locks:
 	 */
 	hlock = find_held_lock(curr, lock, depth, &i);
-	if (!hlock)
-		return print_unlock_imbalance_bug(curr, lock, ip);
+	if (!hlock) {
+		print_unlock_imbalance_bug(curr, lock, ip);
+		return 0;
+	}
 
 	if (hlock->instance == lock)
 		lock_release_holdtime(hlock);
@@ -4310,14 +4314,14 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
 
 #ifdef CONFIG_LOCK_STAT
-static int
-print_lock_contention_bug(struct task_struct *curr, struct lockdep_map *lock,
-			   unsigned long ip)
+static void print_lock_contention_bug(struct task_struct *curr,
+				      struct lockdep_map *lock,
+				      unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=================================\n");
@@ -4335,8 +4339,6 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static void
-- 
1.8.3.1

