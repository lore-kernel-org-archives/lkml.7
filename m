Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C37FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9227FE6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xd9FA3By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfFCNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:06:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFCNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:06:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D6Pm1604568
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:06:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D6Pm1604568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567185;
        bh=o0Rkq1piZVemJ27EtLwSBJa4/SXPT99EgLPAYq+8KnY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xd9FA3Bymgk47cXLwWffjMoqPUpwjIo3dDiYEyH2tLdc20ts48+6Y2zWbYlLoT6tf
         IqmXV62YxCwvxxqG8OcFmS/SO4YiMDPp1jnc7s7m0ktYfD+eIU0xJG6TUiUjuAz1NJ
         8rPk5uuMPWFhqCmAtbq/Le8NZcuI+GHzY6XhPNEvrXMaYqoE1G1t+82u6r/RrYwvAv
         B7lAl7/l5/yB4ZEvIhzNM5UrEf8la/jiPvTw+AGkyz/LwBPangXq96j73AiEiHoCAX
         xUwqJSG9cxs022BG8f9zPGYB9KWza3Hz3K6HX57ZATrMcRpe9dyfqPYpTAMW1oIKkX
         yJTLkLbXYSEEw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D6OCN604565;
        Mon, 3 Jun 2019 06:06:24 -0700
Date:   Mon, 3 Jun 2019 06:06:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-f7c1c6b36a3874d3a7987fb3af829d5b0d75bda7@git.kernel.org>
Cc:     duyuyang@gmail.com, torvalds@linux-foundation.org, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, duyuyang@gmail.com, hpa@zytor.com,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190506081939.74287-2-duyuyang@gmail.com>
References: <20190506081939.74287-2-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Change all print_*() return
 type to void
Git-Commit-ID: f7c1c6b36a3874d3a7987fb3af829d5b0d75bda7
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

Commit-ID:  f7c1c6b36a3874d3a7987fb3af829d5b0d75bda7
Gitweb:     https://git.kernel.org/tip/f7c1c6b36a3874d3a7987fb3af829d5b0d75bda7
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:17 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:32 +0200

locking/lockdep: Change all print_*() return type to void

Since none of the print_*() function's return value is necessary, change
their return type to void. No functional change.

In cases where an invariable return value is used, this change slightly
improves readability, i.e.:

	print_x();
	return 0;

is definitely better than:

	return print_x(); /* where print_x() always returns 0 */

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-2-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 209 ++++++++++++++++++++++++-----------------------
 1 file changed, 108 insertions(+), 101 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8d32ae7768a7..109b56267c8f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1427,16 +1427,15 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
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
 	print_lock_trace(&target->trace, 6);
-	return 0;
 }
 
 static void
@@ -1493,7 +1492,7 @@ print_circular_lock_scenario(struct held_lock *src,
  * When a circular dependency is detected, print the
  * header first:
  */
-static noinline int
+static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 			struct held_lock *check_src,
 			struct held_lock *check_tgt)
@@ -1501,7 +1500,7 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	struct task_struct *curr = current;
 
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("======================================================\n");
@@ -1519,8 +1518,6 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
 	print_circular_bug_entry(entry, depth);
-
-	return 0;
 }
 
 static inline int class_equal(struct lock_list *entry, void *data)
@@ -1528,10 +1525,10 @@ static inline int class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
-static noinline int print_circular_bug(struct lock_list *this,
-				       struct lock_list *target,
-				       struct held_lock *check_src,
-				       struct held_lock *check_tgt)
+static noinline void print_circular_bug(struct lock_list *this,
+					struct lock_list *target,
+					struct held_lock *check_src,
+					struct held_lock *check_tgt)
 {
 	struct task_struct *curr = current;
 	struct lock_list *parent;
@@ -1539,10 +1536,10 @@ static noinline int print_circular_bug(struct lock_list *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	if (!save_trace(&this->trace))
-		return 0;
+		return;
 
 	depth = get_lock_depth(target);
 
@@ -1564,21 +1561,17 @@ static noinline int print_circular_bug(struct lock_list *this,
 
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
@@ -1767,7 +1760,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				struct lock_list *root)
+				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1789,8 +1782,6 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 		entry = get_lock_parent(entry);
 		depth--;
 	} while (entry && (depth >= 0));
-
-	return;
 }
 
 static void
@@ -1849,7 +1840,7 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_bad_irq_dependency(struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
@@ -1862,7 +1853,7 @@ print_bad_irq_dependency(struct task_struct *curr,
 			 const char *irqclass)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
@@ -1908,19 +1899,17 @@ print_bad_irq_dependency(struct task_struct *curr,
 
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
 
 static const char *state_names[] = {
@@ -2067,8 +2056,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	this.class = hlock_class(prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 
 	usage_mask &= LOCKF_USED_IN_IRQ_ALL;
 	if (!usage_mask)
@@ -2084,8 +2075,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	that.class = hlock_class(next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (ret == 1)
 		return ret;
 
@@ -2097,8 +2090,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	backward_mask = original_mask(target_entry1->class->usage_mask);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 	if (DEBUG_LOCKS_WARN_ON(ret == 1))
 		return 1;
 
@@ -2112,11 +2107,13 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	if (DEBUG_LOCKS_WARN_ON(ret == -1))
 		return 1;
 
-	return print_bad_irq_dependency(curr, &this, &that,
-			target_entry, target_entry1,
-			prev, next,
-			backward_bit, forward_bit,
-			state_name(backward_bit));
+	print_bad_irq_dependency(curr, &this, &that,
+				 target_entry, target_entry1,
+				 prev, next,
+				 backward_bit, forward_bit,
+				 state_name(backward_bit));
+
+	return 0;
 }
 
 static void inc_chains(void)
@@ -2147,8 +2144,7 @@ static inline void inc_chains(void)
 #endif
 
 static void
-print_deadlock_scenario(struct held_lock *nxt,
-			     struct held_lock *prv)
+print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -2166,12 +2162,12 @@ print_deadlock_scenario(struct held_lock *nxt,
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
@@ -2190,8 +2186,6 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2233,7 +2227,8 @@ check_deadlock(struct task_struct *curr, struct held_lock *next,
 		if (nest)
 			return 2;
 
-		return print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(curr, prev, next);
+		return 0;
 	}
 	return 1;
 }
@@ -2308,10 +2303,13 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 			 */
 			save_trace(trace);
 		}
-		return print_circular_bug(&this, target_entry, next, prev);
+		print_circular_bug(&this, target_entry, next, prev);
+		return 0;
+	}
+	else if (unlikely(ret < 0)) {
+		print_bfs_bug(ret);
+		return 0;
 	}
-	else if (unlikely(ret < 0))
-		return print_bfs_bug(ret);
 
 	if (!check_irq_usage(curr, prev, next))
 		return 0;
@@ -2352,8 +2350,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		debug_atomic_inc(nr_redundant);
 		return 2;
 	}
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 
 
 	if (!trace->nr_entries && !save_trace(trace))
@@ -2877,8 +2877,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
 
-static void
-print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
@@ -2895,12 +2894,12 @@ print_usage_bug_scenario(struct held_lock *lock)
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
@@ -2930,8 +2929,6 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2941,8 +2938,10 @@ static inline int
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
 
@@ -2950,7 +2949,7 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 /*
  * print irq inversion bug:
  */
-static int
+static void
 print_irq_inversion_bug(struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
@@ -2961,7 +2960,7 @@ print_irq_inversion_bug(struct task_struct *curr,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("========================================================\n");
@@ -3002,13 +3001,11 @@ print_irq_inversion_bug(struct task_struct *curr,
 
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
@@ -3026,13 +3023,16 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
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
@@ -3050,13 +3050,16 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
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
@@ -3599,15 +3602,15 @@ EXPORT_SYMBOL_GPL(lockdep_init_map);
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
@@ -3629,8 +3632,6 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3779,8 +3780,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3816,14 +3819,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3841,8 +3844,6 @@ print_unlock_imbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int match_held_lock(const struct held_lock *hlock,
@@ -3961,8 +3962,10 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
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
@@ -4002,8 +4005,10 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -4047,16 +4052,20 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
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
@@ -4399,14 +4408,14 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
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
@@ -4424,8 +4433,6 @@ print_lock_contention_bug(struct task_struct *curr, struct lockdep_map *lock,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static void
