Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F52C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA09A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sanc31YU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfDXKUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36135 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfDXKUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so9178994pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vdbtb5lci1KEhZ8FJ/jGcriZ+R+G9Kur2ahT7KGdZlU=;
        b=sanc31YUqxZ4Vnf2xpX4KnngA1wCZ9X1RnPqGFy2845iqiQkWWwxo7x8fcvYCCoUkh
         bNGRLC4yCTvH2YbyZUzj+ue5C5ZPhhAenmr/wBjms32BkkdfYtioB0wiiCQTK2FoLz4i
         oSatLxgd2gmSYymR5uQ4IXDRRC6dQIZsvPTetrhCSQetKlT2eBGAA6JJiiSl1UlQiFad
         wzbdztzh7Ms/id+Z2vv6ADEajDZuHyuN63PDlHKCXASp7NpHysT9z2iEHa2JmwKVX1nm
         qgBPN8HTo4kOq6fk6ZBVuBuX4AJelXjW5H1V6xqsL3vbgNyz+b5croSt0YSYPtsGXjQJ
         esbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vdbtb5lci1KEhZ8FJ/jGcriZ+R+G9Kur2ahT7KGdZlU=;
        b=UBNkHMjfjYBZaSPhm5AwktUoKJCCT/8Zyxu6sLApqB2sv0+HRGMJQ7QJfjCfbyk6sn
         dHQZvhAPKV+FU/ZrlXp9yu+Fb0qqQAS2gAud0NLC5O3mmwKuYZf597wttOzilo6imi9N
         KLvr2buanL/yerIpKIHLeAvunfh257952KgeiT07hLFgoESRkjLRpwiEkOy5wf9FSjjx
         1Z37zkkLsIo7wcg27mrYDPFiIUSODktbtvRk0kS7t3apM/Oyoa+fT7X0EaXgRTYsnd0F
         bXjSlHWpmGTX9SOKsHAJE0HU5ifrM4HbmgmGWwOTs691NgNBRJvG9ElEljmHSPXYHSA8
         vbhA==
X-Gm-Message-State: APjAAAWZluMMevyq/zWvLLjUOST+8Mm7ZL6vAi0Mc56aR702n+obikTe
        /sN3721+nkadk1MMoN3vTF4=
X-Google-Smtp-Source: APXvYqzoMysL+A/Jfzj2AfJCW7VK2Jf2bCvmNA0a5I8YZZC/ngiNURel1GGh61WG8JTf/oz5KTuAjg==
X-Received: by 2002:a63:ed4e:: with SMTP id m14mr30484938pgk.182.1556101231136;
        Wed, 24 Apr 2019 03:20:31 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:30 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 01/28] locking/lockdep: Change all print_*() return type to void
Date:   Wed, 24 Apr 2019 18:19:07 +0800
Message-Id: <20190424101934.51535-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
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
 kernel/locking/lockdep.c | 197 ++++++++++++++++++++++++-----------------------
 1 file changed, 101 insertions(+), 96 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 147ae0a..4bf396b 100644
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
@@ -1523,7 +1520,7 @@ static inline int class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
-static noinline int print_circular_bug(struct lock_list *this,
+static noinline void print_circular_bug(struct lock_list *this,
 				       struct lock_list *target,
 				       struct held_lock *check_src,
 				       struct held_lock *check_tgt)
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
@@ -1756,7 +1749,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				struct lock_list *root)
+				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1778,8 +1771,6 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		entry = get_lock_parent(entry);
 		depth--;
 	} while (entry && (depth >= 0));
-
-	return;
 }
 
 static void
@@ -1838,7 +1829,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
-static int
+static void
 print_bad_irq_dependency(struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
@@ -1851,7 +1842,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 			 const char *irqclass)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
@@ -1897,19 +1888,17 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
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
@@ -1926,23 +1915,28 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	this.class = hlock_class(prev);
 	ret = find_usage_backwards(&this, lock_flag(bit_backwards), &target_entry);
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
 	ret = find_usage_forwards(&that, lock_flag(bit_forwards), &target_entry1);
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
@@ -2048,8 +2042,7 @@ static inline void inc_chains(void)
 #endif
 
 static void
-print_deadlock_scenario(struct held_lock *nxt,
-			     struct held_lock *prv)
+print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -2067,12 +2060,12 @@ static inline void inc_chains(void)
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
@@ -2091,8 +2084,6 @@ static inline void inc_chains(void)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2134,7 +2125,8 @@ static inline void inc_chains(void)
 		if (nest)
 			return 2;
 
-		return print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(curr, prev, next);
+		return 0;
 	}
 	return 1;
 }
@@ -2201,10 +2193,14 @@ static inline void inc_chains(void)
 	this.class = hlock_class(next);
 	this.parent = NULL;
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
-	if (unlikely(!ret))
-		return print_circular_bug(&this, target_entry, next, prev);
-	else if (unlikely(ret < 0))
-		return print_bfs_bug(ret);
+	if (unlikely(!ret)) {
+		print_circular_bug(&this, target_entry, next, prev);
+		return 0;
+	}
+	else if (unlikely(ret < 0)) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 
 	if (!check_prev_add_irq(curr, prev, next))
 		return 0;
@@ -2245,8 +2241,10 @@ static inline void inc_chains(void)
 		debug_atomic_inc(nr_redundant);
 		return 2;
 	}
-	if (ret < 0)
-		return print_bfs_bug(ret);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
 
 
 	if (!save_trace(&trace))
@@ -2773,8 +2771,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
 
-static void
-print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
@@ -2791,12 +2788,12 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -2826,8 +2823,6 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -2837,8 +2832,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
 
@@ -2846,7 +2843,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 /*
  * print irq inversion bug:
  */
-static int
+static void
 print_irq_inversion_bug(struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
@@ -2857,7 +2854,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	int depth;
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("========================================================\n");
@@ -2898,13 +2895,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
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
@@ -2922,13 +2917,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -2946,13 +2944,16 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -3495,15 +3496,15 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
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
@@ -3525,8 +3526,6 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3675,8 +3674,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3712,14 +3713,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3737,8 +3738,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int match_held_lock(const struct held_lock *hlock,
@@ -3857,8 +3856,10 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
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
@@ -3898,8 +3899,10 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -3943,16 +3946,20 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -4295,14 +4302,14 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
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
@@ -4320,8 +4327,6 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static void
-- 
1.8.3.1

