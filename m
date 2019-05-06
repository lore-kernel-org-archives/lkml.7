Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C11C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01422087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHZ1TAPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfEFIT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:19:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39986 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfEFITy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:19:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so6090456pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/t4tXKxSS56W14qd8a7yJ5WVoldrYrzIt29S2wqFNzw=;
        b=rHZ1TAPLRlw5r3EGPnbeGGwk/gEO+MXwdSpkfL5l5E8RVhqmCIIC+Ob7dpl3DQLVdN
         qtSaZRzOnfH3R2AUD1NbefnIW3wx6Z0/m4LxPLT/GPhnD5AyAfWTYbeQtRzD8Y2EEg9T
         ooeYzlIIM6h71vk8iixtd3525O0tBUACJ9R3YfJB/wpMYwaddEP+XYKmw+eeZnOJfrNa
         zxFqzdpulf/5AO6a/tAUxnsZcBpteNKNv2lNfTZHOhssivUBMMEEC0/aM2aceHBCtDnl
         2np48mZ7joS+LbtPWPHvYrwrAIRLW1LAhonNvfM3mPOQebpVshHsKi+NdI5uCSgyYJY6
         QMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/t4tXKxSS56W14qd8a7yJ5WVoldrYrzIt29S2wqFNzw=;
        b=evHXOhOWmhYUOQOB67cZQSseoQmr/utc8DakxC0FbZrf4qlUmKodNNyHnCFGjdah29
         hX3QJRN11VZ0O4xsYVJrUqqFqr839iE1YM9JBSsg24KK1s64Acise8Xkd254PqWgCf3r
         MrEyvodTlB6Zw+8XYDj/CRyqlvRsEL8u9azKZv4N4C3W3OOZ5+eQER//e3f0kEbdGLrR
         655V1pPfTq+rm6cUnrP6mgqCiRxmkieK7o2G1sSLFPcL6vyfea3k0I8coZEsCrL9ltux
         REzGlraaCNxVcgJi79ex+ZRK4VLPOb814u4DY1KDLA7zFAtEsH+iCONTl9oyJs9H8Tka
         twTQ==
X-Gm-Message-State: APjAAAUz33tA6oc4fXQYSle6o9AYITzqodEIUS2ctX71o9KBMVvd08GU
        2T2R4uukQzuDFzUp/1UOcR8=
X-Google-Smtp-Source: APXvYqxYwGXI9LsNXK8oHf2MyIxMBpjGRpYOxi42m+iAkHE143F8rscd6BIeSsrr/Z8epILjW1CI4w==
X-Received: by 2002:a63:2118:: with SMTP id h24mr30832621pgh.320.1557130793114;
        Mon, 06 May 2019 01:19:53 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:19:52 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 01/23] locking/lockdep: Change all print_*() return type to void
Date:   Mon,  6 May 2019 16:19:17 +0800
Message-Id: <20190506081939.74287-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 kernel/locking/lockdep.c | 209 ++++++++++++++++++++++++-----------------------
 1 file changed, 108 insertions(+), 101 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 27b992f..a019330 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1422,16 +1422,15 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
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
@@ -1488,7 +1487,7 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
  * When a circular dependency is detected, print the
  * header first:
  */
-static noinline int
+static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 			struct held_lock *check_src,
 			struct held_lock *check_tgt)
@@ -1496,7 +1495,7 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 	struct task_struct *curr = current;
 
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("======================================================\n");
@@ -1514,8 +1513,6 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
 	print_circular_bug_entry(entry, depth);
-
-	return 0;
 }
 
 static inline int class_equal(struct lock_list *entry, void *data)
@@ -1523,10 +1520,10 @@ static inline int class_equal(struct lock_list *entry, void *data)
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
@@ -1534,10 +1531,10 @@ static noinline int print_circular_bug(struct lock_list *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	if (!save_trace(&this->trace))
-		return 0;
+		return;
 
 	depth = get_lock_depth(target);
 
@@ -1559,21 +1556,17 @@ static noinline int print_circular_bug(struct lock_list *this,
 
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
@@ -1762,7 +1755,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				struct lock_list *root)
+				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1784,8 +1777,6 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		entry = get_lock_parent(entry);
 		depth--;
 	} while (entry && (depth >= 0));
-
-	return;
 }
 
 static void
@@ -1844,7 +1835,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_bad_irq_dependency(struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
@@ -1857,7 +1848,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 			 const char *irqclass)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
@@ -1903,19 +1894,17 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
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
@@ -2062,8 +2051,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
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
@@ -2079,8 +2070,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
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
 
@@ -2092,8 +2085,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
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
 
@@ -2107,11 +2102,13 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
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
@@ -2142,8 +2139,7 @@ static inline void inc_chains(void)
 #endif
 
 static void
-print_deadlock_scenario(struct held_lock *nxt,
-			     struct held_lock *prv)
+print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -2161,12 +2157,12 @@ static inline void inc_chains(void)
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
@@ -2185,8 +2181,6 @@ static inline void inc_chains(void)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2228,7 +2222,8 @@ static inline void inc_chains(void)
 		if (nest)
 			return 2;
 
-		return print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(curr, prev, next);
+		return 0;
 	}
 	return 1;
 }
@@ -2303,10 +2298,13 @@ static inline void inc_chains(void)
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
@@ -2347,8 +2345,10 @@ static inline void inc_chains(void)
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
@@ -2876,8 +2876,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
 
-static void
-print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
@@ -2894,12 +2893,12 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -2929,8 +2928,6 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2940,8 +2937,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
 
@@ -2949,7 +2948,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 /*
  * print irq inversion bug:
  */
-static int
+static void
 print_irq_inversion_bug(struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
@@ -2960,7 +2959,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("========================================================\n");
@@ -3001,13 +3000,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
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
@@ -3025,13 +3022,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -3049,13 +3049,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -3598,15 +3601,15 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
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
@@ -3628,8 +3631,6 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3778,8 +3779,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3815,14 +3818,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3840,8 +3843,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int match_held_lock(const struct held_lock *hlock,
@@ -3960,8 +3961,10 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
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
@@ -4001,8 +4004,10 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -4046,16 +4051,20 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -4398,14 +4407,14 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
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
@@ -4423,8 +4432,6 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static void
-- 
1.8.3.1

