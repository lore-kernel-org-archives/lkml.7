Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD9BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A6C2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A83n8b72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfCUH5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43679 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so3655270pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zRR1BSvhk1emt8aLGfC5YUC1fiem5oygL307/0Wp9z8=;
        b=A83n8b72xhVwAWYqkfe8waajU2ZCj09Jnceruv3IEXp/X2KJLXoj1/Yd8uwx/rFGoh
         tsdd1JhUYUePioiNdYwxGFcJ6wuvd0AMu74JItnj88Tle2CTKjiKfsQx+19NXa+5Q9RT
         i5MRgUx7goiFLNs1Aa8/xv6IwbJB4AXx+voOc6oZqzn0SxJmBXbd25q68ZFxAv8Gk01R
         dYB5bJli4f38lwCooTWcucyO973J1wbomx3TvIexRaWCfvh8tQ3XVl+LBkvTniEEEDQN
         X5djNtcQEqAemNTISP8DxrcurX+T01xkDISFp2OV98PMpfVFwD453EGAdJGkwN9LcL/y
         FJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zRR1BSvhk1emt8aLGfC5YUC1fiem5oygL307/0Wp9z8=;
        b=iUI2HKqOCV0dL3EhTXcQ7njDE/2BzX5u5woxjZCKqRjX860LBF84dgQRdXE+u5ygYP
         TlcYJ3vSdQeL4nEDxSS8T7kvYLNA0mUQcp63LWYrqa9mgSEAcaRVT1Rkt4+JY/E4pCSQ
         Rr6WODsQb2YD1q7Bapr3OCLRmwIO2qcnG4NpPOPfDh1WPLWP0iYolwx5Y2oGxpNZ5rqm
         ShI/5U/LHMe3TI0zRSpY/klI3KEJ0E4ngQi+wuxiPl+QRqr4/W8D2J5mrAi9NM10jkmi
         nZKHhYc+jKmaarWW7aqI6DNIac7NNb3z4qJH0Epqely5NdSq2hRU+oJ2VzQcyNK+RC3z
         G/3Q==
X-Gm-Message-State: APjAAAW8FCur/J3bX7yrKaR+7FoPxQL5w4xg5M7jhuUkFc0Kw6vQngC3
        8jLuj5pNOwRAGMxiDCQcO9g=
X-Google-Smtp-Source: APXvYqwX6PnnEWFwk9DMTf8BNuoq/aMaG/0XhzsBqoDDbNlhKEb/tx/QUWnjL+3unUMgMcUFmnSx2Q==
X-Received: by 2002:a65:6085:: with SMTP id t5mr2124565pgu.257.1553155056653;
        Thu, 21 Mar 2019 00:57:36 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:36 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 01/18] locking/lockdep: Change all print_*() return type to void
Date:   Thu, 21 Mar 2019 15:57:08 +0800
Message-Id: <20190321075725.14054-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
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
 kernel/locking/lockdep.c | 203 ++++++++++++++++++++++++-----------------------
 1 file changed, 103 insertions(+), 100 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbe..41137ad 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1430,17 +1430,15 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
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
 
 static void
@@ -1497,7 +1495,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
  * When a circular dependency is detected, print the
  * header first:
  */
-static noinline int
+static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 			struct held_lock *check_src,
 			struct held_lock *check_tgt)
@@ -1505,7 +1503,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	struct task_struct *curr = current;
 
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("======================================================\n");
@@ -1523,8 +1521,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
 	print_circular_bug_entry(entry, depth);
-
-	return 0;
 }
 
 static inline int class_equal(struct lock_list *entry, void *data)
@@ -1532,11 +1528,11 @@ static inline int class_equal(struct lock_list *entry, void *data)
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
@@ -1544,10 +1540,10 @@ static noinline int print_circular_bug(struct lock_list *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	if (!save_trace(&this->trace))
-		return 0;
+		return;
 
 	depth = get_lock_depth(target);
 
@@ -1569,21 +1565,17 @@ static noinline int print_circular_bug(struct lock_list *this,
 
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
@@ -1766,7 +1758,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				struct lock_list *root)
+				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1788,8 +1780,6 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		entry = get_lock_parent(entry);
 		depth--;
 	} while (entry && (depth >= 0));
-
-	return;
 }
 
 static void
@@ -1848,7 +1838,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_bad_irq_dependency(struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
@@ -1861,7 +1851,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 			 const char *irqclass)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
@@ -1907,19 +1897,17 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
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
@@ -1936,23 +1924,28 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
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
@@ -2055,8 +2048,7 @@ static inline void inc_chains(void)
 #endif
 
 static void
-print_deadlock_scenario(struct held_lock *nxt,
-			     struct held_lock *prv)
+print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -2074,12 +2066,12 @@ static inline void inc_chains(void)
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
@@ -2098,8 +2090,6 @@ static inline void inc_chains(void)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2141,7 +2131,8 @@ static inline void inc_chains(void)
 		if (nest)
 			return 2;
 
-		return print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(curr, prev, next);
+		return 0;
 	}
 	return 1;
 }
@@ -2217,10 +2208,13 @@ static inline void inc_chains(void)
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
@@ -2261,8 +2255,10 @@ static inline void inc_chains(void)
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
@@ -2784,8 +2780,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
-static void
-print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
@@ -2802,12 +2797,12 @@ static void check_chain_key(struct task_struct *curr)
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
@@ -2837,8 +2832,6 @@ static void check_chain_key(struct task_struct *curr)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2848,8 +2841,10 @@ static void check_chain_key(struct task_struct *curr)
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
 
@@ -2861,7 +2856,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 /*
  * print irq inversion bug:
  */
-static int
+static void
 print_irq_inversion_bug(struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
@@ -2872,7 +2867,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("========================================================\n");
@@ -2913,13 +2908,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
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
@@ -2937,13 +2930,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -2961,13 +2957,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -3510,15 +3509,15 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
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
@@ -3540,8 +3539,6 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3690,8 +3687,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3727,14 +3726,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3752,8 +3751,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int match_held_lock(const struct held_lock *hlock,
@@ -3872,8 +3869,10 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
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
@@ -3913,8 +3912,10 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -3958,16 +3959,20 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -4310,14 +4315,14 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
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
@@ -4335,8 +4340,6 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static void
-- 
1.8.3.1

