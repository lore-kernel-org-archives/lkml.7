Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm4++UpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfF1JQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33271 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1JQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so2924646plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsa/U3B37oa1cKCFyu1gJKoR68S0lx9Lallknh59bXk=;
        b=fm4++UpGJT6/FKgrCXwdxn5JNK0zmrt2lV8QMXM3GZR+/7nqpr+8USGaiyWAPt6Vqa
         UofMBleFP5K5fB4wLX8sD4jYcZu+FPnDNOdT/34KOchriLzpGlLb4X5vs94ED+XidQag
         Km0HORTlRiHqfCYBc7pxQQdrf0iuBfcCyDYkXKzYdSsPmSKwkJVPl6ZOQXNKzpFEZVNN
         JgIWj4pCczB6JPJZOVrDQfliNHPhnAyh99l5jY5YSIXXJ93pXMXsUfQREZFo4cHWfhEb
         ExD1PZHWZOd1GsL5QQw5PQWazBREVmft3sCe57oOOU3umargaJZGuv9ETP4DMUo/Kro3
         f90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsa/U3B37oa1cKCFyu1gJKoR68S0lx9Lallknh59bXk=;
        b=oJrY3tuBaYX2VA8aXsB4ml9MDlyA0JNCESjk3qk8ISCWb+gMh6Wo/MRen8KxhAYCXn
         nAkPzcys3w5W4bp5BJxenlTSX68+FgM0gPFlxJuLJt8AORIF7L/hW26sifbjZET5YZYn
         DQoYjfiuOEPJZiXf7dPl+Ws4b/0GqskRkLbaQfNgUX+ixsk/y5r6wkowUXkRsbZlKK1S
         qNrNF9+mNlWck/p6u36GYWCSXkylVOPhv/XROlDU0Ye0XMxmkqp/DsLBhZ5EJgTcjBMq
         TsV867Q1m/fL6peIRzv32Sq/m36YgmXP0cMaKe3SYYpCzdcpFGmDoNhmNYrJT581qrdL
         kCJQ==
X-Gm-Message-State: APjAAAW2NwGsBdTkYVma4AUJMTZEikcvezPrelQR+XwO7ot3KYcDK11N
        G6hlVnurdw1z8jbmivyhDb0=
X-Google-Smtp-Source: APXvYqxgr1tmuavuagW/4irEMHHMpqmaaR92PCGG/pLFgQkT2Uy/9EYFZJab4WI9aNwaIEZPyxnVew==
X-Received: by 2002:a17:902:788e:: with SMTP id q14mr10357744pll.234.1561713406760;
        Fri, 28 Jun 2019 02:16:46 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:46 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 14/30] locking/lockdep: Consolidate forward and backward lock_lists into one
Date:   Fri, 28 Jun 2019 17:15:12 +0800
Message-Id: <20190628091528.17059-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a forward dependency has an exact 1:1 mapping to a backward
dependency, the forward and its counterpart backward lock_lists can be
combined into one lock_list entry. This can be illustrated as:

Forward dependecy:   L1 -> L2
Backward dependency: L2 <- L1

So one lock_list can represent these two dependencies.

Despite the side effect of saving memory benefit, the direct reason for
sharing one lock list between forward and its counterpart backward
dependencies is that after this, we would be able to map lock chains to
their lock dependencies in the graph because a forward dependency and
its counterpart backward dependency has the same lock chains.

To make this possible, one lock_list struct would have two-element
arrays of classes and list_heads for dependency list for graph:

Lock_list: L1 -> L2
class[0]:  L1
class[1]:  L2
entry[0]:  for dep_list[0]
entry[1]:  for dep_list[1]

With this change the rule to use which class[] or entry[] element is
easy: whenever forward graph search is performed use class[1] and
entry[1], and whenever backward graph search is performed use class[0]
and entry[0].

Actually, should be no functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h       |  22 +++--
 kernel/locking/lockdep.c      | 191 ++++++++++++++++++++++++------------------
 kernel/locking/lockdep_proc.c |   6 +-
 3 files changed, 130 insertions(+), 89 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 62eba72..981718b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -186,14 +186,26 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 }
 
 /*
- * Every lock has a list of other locks that were taken after it.
- * We only grow the list, never remove from it:
+ * Every lock has a list of other locks that were taken after or before
+ * it as lock dependencies. These dependencies constitute a graph, which
+ * depicts the locking behavior of the kernel and the workloads.
+ *
+ * Since forward dependencies and backward dependencies have an exact
+ * 1:1 mapping. A lock_list entry can be shared between them.
+ *
+ * For the locks after and before lists:
+ *
+ * @entry[0] is used to link to next backward lock, while @entry[1] is
+ * used for next forward lock.
+ *
+ * For the forward dependency L1 -> L2:
+ *
+ * @class[0] is used for L1 and @class[1] is for L2.
  */
 struct lock_list {
-	struct list_head		entry;
+	struct list_head		entry[2];
 	struct list_head		chains;
-	struct lock_class		*class;
-	struct lock_class		*links_to;
+	struct lock_class		*class[2];
 	struct lock_trace		trace;
 	int				distance;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 39210a4..36d55d3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -175,6 +175,16 @@ static inline struct lock_class *hlock_class(struct held_lock *hlock)
 	return lock_classes + class_idx;
 }
 
+static inline struct lock_class *fw_dep_class(struct lock_list *lock)
+{
+	return lock->class[1];
+}
+
+static inline struct lock_class *bw_dep_class(struct lock_list *lock)
+{
+	return lock->class[0];
+}
+
 #ifdef CONFIG_LOCK_STAT
 static DEFINE_PER_CPU(struct lock_class_stats[MAX_LOCKDEP_KEYS], cpu_lock_stats);
 
@@ -849,19 +859,21 @@ static bool in_any_class_list(struct list_head *e)
 	return false;
 }
 
-static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
+static bool class_lock_list_valid(struct lock_class *c, int forward)
 {
 	struct lock_list *e;
+	struct list_head *h = &c->dep_list[forward];
+	int other = 1 - forward;
 
-	list_for_each_entry(e, h, entry) {
-		if (e->links_to != c) {
+	list_for_each_entry(e, h, entry[forward]) {
+		if (e->class[other] != c) {
 			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s",
 			       c->name ? : "(?)",
 			       (unsigned long)(e - list_entries),
-			       e->links_to && e->links_to->name ?
-			       e->links_to->name : "(?)",
-			       e->class && e->class->name ? e->class->name :
-			       "(?)");
+			       e->class[other] && e->class[other]->name ?
+			       e->class[other]->name : "(?)",
+			       e->class[forward] && e->class[forward]->name ?
+			       e->class[forward]->name : "(?)");
 			return false;
 		}
 	}
@@ -931,9 +943,9 @@ static bool __check_data_structures(void)
 	/* Check whether all classes have valid lock lists. */
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		class = &lock_classes[i];
-		if (!class_lock_list_valid(class, &class->dep_list[0]))
+		if (!class_lock_list_valid(class, 0))
 			return false;
-		if (!class_lock_list_valid(class, &class->dep_list[1]))
+		if (!class_lock_list_valid(class, 1))
 			return false;
 	}
 
@@ -952,11 +964,18 @@ static bool __check_data_structures(void)
 	 */
 	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
 		e = list_entries + i;
-		if (!in_any_class_list(&e->entry)) {
+		if (!in_any_class_list(&e->entry[0])) {
 			printk(KERN_INFO "list entry %d is not in any class list; class %s <> %s\n",
 			       (unsigned int)(e - list_entries),
-			       e->class->name ? : "(?)",
-			       e->links_to->name ? : "(?)");
+			       e->class[0]->name ? : "(?)",
+			       e->class[1]->name ? : "(?)");
+			return false;
+		}
+		if (!in_any_class_list(&e->entry[1])) {
+			printk(KERN_INFO "list entry %d is not in any class list; class %s <> %s\n",
+			       (unsigned int)(e - list_entries),
+			       e->class[0]->name ? : "(?)",
+			       e->class[1]->name ? : "(?)");
 			return false;
 		}
 	}
@@ -967,13 +986,22 @@ static bool __check_data_structures(void)
 	 */
 	for_each_clear_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
 		e = list_entries + i;
-		if (in_any_class_list(&e->entry)) {
+		if (in_any_class_list(&e->entry[0])) {
+			printk(KERN_INFO "list entry %d occurs in a class list; class %s <> %s\n",
+			       (unsigned int)(e - list_entries),
+			       e->class[0] && e->class[0]->name ? e->class[0]->name :
+			       "(?)",
+			       e->class[1] && e->class[1]->name ?
+			       e->class[1]->name : "(?)");
+			return false;
+		}
+		if (in_any_class_list(&e->entry[1])) {
 			printk(KERN_INFO "list entry %d occurs in a class list; class %s <> %s\n",
 			       (unsigned int)(e - list_entries),
-			       e->class && e->class->name ? e->class->name :
+			       e->class[0] && e->class[0]->name ? e->class[0]->name :
 			       "(?)",
-			       e->links_to && e->links_to->name ?
-			       e->links_to->name : "(?)");
+			       e->class[1] && e->class[1]->name ?
+			       e->class[1]->name : "(?)");
 			return false;
 		}
 	}
@@ -1236,8 +1264,7 @@ static struct lock_list *alloc_list_entry(void)
 /*
  * Add a new dependency to the head of the list:
  */
-static int add_lock_to_list(struct lock_class *this,
-			    struct lock_class *links_to, struct list_head *head,
+static int add_lock_to_list(struct lock_class *lock1, struct lock_class *lock2,
 			    unsigned long ip, int distance,
 			    struct lock_trace *trace)
 {
@@ -1250,16 +1277,18 @@ static int add_lock_to_list(struct lock_class *this,
 	if (!entry)
 		return 0;
 
-	entry->class = this;
-	entry->links_to = links_to;
+	entry->class[0] = lock1;
+	entry->class[1] = lock2;
 	entry->distance = distance;
 	entry->trace = *trace;
+
 	/*
 	 * Both allocation and removal are done under the graph lock; but
 	 * iteration is under RCU-sched; see look_up_lock_class() and
 	 * lockdep_free_key_range().
 	 */
-	list_add_tail_rcu(&entry->entry, head);
+	list_add_tail_rcu(&entry->entry[1], &lock1->dep_list[1]);
+	list_add_tail_rcu(&entry->entry[0], &lock2->dep_list[0]);
 
 	return 1;
 }
@@ -1340,23 +1369,23 @@ static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
 }
 
 static inline void mark_lock_accessed(struct lock_list *lock,
-					struct lock_list *parent)
+				      struct lock_list *parent, int forward)
 {
 	unsigned long nr;
 
 	nr = lock - list_entries;
 	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	lock->parent = parent;
-	lock->class->dep_gen_id = lockdep_dependency_gen_id;
+	lock->class[forward]->dep_gen_id = lockdep_dependency_gen_id;
 }
 
-static inline unsigned long lock_accessed(struct lock_list *lock)
+static inline unsigned long lock_accessed(struct lock_list *lock, int forward)
 {
 	unsigned long nr;
 
 	nr = lock - list_entries;
 	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
-	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
+	return lock->class[forward]->dep_gen_id == lockdep_dependency_gen_id;
 }
 
 static inline struct lock_list *get_lock_parent(struct lock_list *child)
@@ -1384,7 +1413,7 @@ static inline int get_lock_depth(struct lock_list *child)
  */
 static inline struct list_head *get_dep_list(struct lock_list *lock, int forward)
 {
-	struct lock_class *class = lock->class;
+	struct lock_class *class = lock->class[forward];
 
 	return &class->dep_list[forward];
 }
@@ -1419,7 +1448,7 @@ static int __bfs(struct lock_list *source_entry,
 
 	while ((lock = __cq_dequeue(cq))) {
 
-		if (!lock->class) {
+		if (!lock->class[forward]) {
 			ret = -2;
 			goto exit;
 		}
@@ -1428,10 +1457,10 @@ static int __bfs(struct lock_list *source_entry,
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
-		list_for_each_entry_rcu(entry, head, entry) {
-			if (!lock_accessed(entry)) {
+		list_for_each_entry_rcu(entry, head, entry[forward]) {
+			if (!lock_accessed(entry, forward)) {
 				unsigned int cq_depth;
-				mark_lock_accessed(entry, lock);
+				mark_lock_accessed(entry, lock, forward);
 				if (match(entry, data)) {
 					*target_entry = entry;
 					ret = 0;
@@ -1485,7 +1514,7 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 	if (debug_locks_silent)
 		return;
 	printk("\n-> #%u", depth);
-	print_lock_name(target->class);
+	print_lock_name(fw_dep_class(target));
 	printk(KERN_CONT ":\n");
 	print_lock_trace(&target->trace, 6);
 }
@@ -1497,7 +1526,7 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 	struct lock_class *source = hlock_class(src);
 	struct lock_class *target = hlock_class(tgt);
-	struct lock_class *parent = prt->class;
+	struct lock_class *parent = fw_dep_class(prt);
 
 	/*
 	 * A direct locking problem where unsafe_class lock is taken
@@ -1574,7 +1603,7 @@ static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 
 static inline int class_equal(struct lock_list *entry, void *data)
 {
-	return entry->class == data;
+	return fw_dep_class(entry) == data;
 }
 
 static noinline void print_circular_bug(struct lock_list *this,
@@ -1647,7 +1676,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	struct lock_list this;
 
 	this.parent = NULL;
-	this.class = class;
+	this.class[1] = class;
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
@@ -1674,7 +1703,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	struct lock_list this;
 
 	this.parent = NULL;
-	this.class = class;
+	this.class[0] = class;
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
@@ -1718,7 +1747,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	int ret;
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list src_entry = {
-		.class = hlock_class(src),
+		.class[1] = hlock_class(src),
 		.parent = NULL,
 	};
 
@@ -1746,7 +1775,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 static inline int usage_accumulate(struct lock_list *entry, void *mask)
 {
-	*(unsigned long *)mask |= entry->class->usage_mask;
+	*(unsigned long *)mask |= bw_dep_class(entry)->usage_mask;
 
 	return 0;
 }
@@ -1756,10 +1785,14 @@ static inline int usage_accumulate(struct lock_list *entry, void *mask)
  * proving that two subgraphs can be connected by a new dependency
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
+static inline int usage_match_forward(struct lock_list *entry, void *mask)
+{
+	return entry->class[1]->usage_mask & *(unsigned long *)mask;
+}
 
-static inline int usage_match(struct lock_list *entry, void *mask)
+static inline int usage_match_backward(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & *(unsigned long *)mask;
+	return entry->class[0]->usage_mask & *(unsigned long *)mask;
 }
 
 /*
@@ -1780,7 +1813,8 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match_forward,
+				target_entry);
 
 	return result;
 }
@@ -1803,7 +1837,8 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match_backward,
+				 target_entry);
 
 	return result;
 }
@@ -1839,7 +1874,8 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
-				 struct lock_list *root)
+				 struct lock_list *root,
+				 int forward)
 {
 	struct lock_list *entry = leaf;
 	int depth;
@@ -1848,7 +1884,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	depth = get_lock_depth(leaf);
 
 	do {
-		print_lock_class_header(entry->class, depth);
+		print_lock_class_header(entry->class[forward], depth);
 		printk("%*s ... acquired at:\n", depth, "");
 		print_lock_trace(&entry->trace, 2);
 		printk("\n");
@@ -1864,13 +1900,11 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 }
 
 static void
-print_irq_lock_scenario(struct lock_list *safe_entry,
-			struct lock_list *unsafe_entry,
+print_irq_lock_scenario(struct lock_class *safe_class,
+			struct lock_class *unsafe_class,
 			struct lock_class *prev_class,
 			struct lock_class *next_class)
 {
-	struct lock_class *safe_class = safe_entry->class;
-	struct lock_class *unsafe_class = unsafe_entry->class;
 	struct lock_class *middle_class = prev_class;
 
 	if (middle_class == safe_class)
@@ -1958,20 +1992,21 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
 		irqclass);
-	print_lock_name(backwards_entry->class);
+	print_lock_name(bw_dep_class(backwards_entry));
 	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
 
-	print_lock_trace(backwards_entry->class->usage_traces + bit1, 1);
+	print_lock_trace(bw_dep_class(backwards_entry)->usage_traces + bit1, 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
-	print_lock_name(forwards_entry->class);
+	print_lock_name(fw_dep_class(forwards_entry));
 	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
 	pr_warn("...");
 
-	print_lock_trace(forwards_entry->class->usage_traces + bit2, 1);
+	print_lock_trace(fw_dep_class(forwards_entry)->usage_traces + bit2, 1);
 
 	pr_warn("\nother info that might help us debug this:\n\n");
-	print_irq_lock_scenario(backwards_entry, forwards_entry,
+	print_irq_lock_scenario(bw_dep_class(backwards_entry),
+				fw_dep_class(forwards_entry),
 				hlock_class(prev), hlock_class(next));
 
 	lockdep_print_held_locks(curr);
@@ -1979,13 +2014,13 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
 	if (!save_trace(&prev_root->trace))
 		return;
-	print_shortest_lock_dependencies(backwards_entry, prev_root);
+	print_shortest_lock_dependencies(backwards_entry, prev_root, 0);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	if (!save_trace(&next_root->trace))
 		return;
-	print_shortest_lock_dependencies(forwards_entry, next_root);
+	print_shortest_lock_dependencies(forwards_entry, next_root, 1);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -2132,7 +2167,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * accumulated usage mask.
 	 */
 	this.parent = NULL;
-	this.class = hlock_class(prev);
+	this.class[0] = hlock_class(prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
 	if (ret < 0) {
@@ -2151,7 +2186,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	forward_mask = exclusive_mask(usage_mask);
 
 	that.parent = NULL;
-	that.class = hlock_class(next);
+	that.class[1] = hlock_class(next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
 	if (ret < 0) {
@@ -2166,7 +2201,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * list whose usage mask matches the exclusive usage mask from the
 	 * lock found on the forward list.
 	 */
-	backward_mask = original_mask(target_entry1->class->usage_mask);
+	backward_mask = original_mask(fw_dep_class(target_entry1)->usage_mask);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
 	if (ret < 0) {
@@ -2180,8 +2215,8 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * Step 4: narrow down to a pair of incompatible usage bits
 	 * and report it.
 	 */
-	ret = find_exclusive_match(target_entry->class->usage_mask,
-				   target_entry1->class->usage_mask,
+	ret = find_exclusive_match(bw_dep_class(target_entry)->usage_mask,
+				   fw_dep_class(target_entry1)->usage_mask,
 				   &backward_bit, &forward_bit);
 	if (DEBUG_LOCKS_WARN_ON(ret == -1))
 		return 1;
@@ -2368,8 +2403,8 @@ static inline void inc_chains(void)
 	 *  chains - the second one will be new, but L1 already has
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
-	list_for_each_entry(entry, &hlock_class(prev)->dep_list[1], entry) {
-		if (entry->class == hlock_class(next)) {
+	list_for_each_entry(entry, &hlock_class(prev)->dep_list[1], entry[1]) {
+		if (fw_dep_class(entry) == hlock_class(next)) {
 			debug_atomic_inc(nr_redundant);
 
 			if (distance == 1)
@@ -2411,19 +2446,12 @@ static inline void inc_chains(void)
 		return 0;
 
 	/*
-	 * Ok, all validations passed, add the new lock
-	 * to the previous lock's dependency list:
+	 * Ok, all validations passed, add the new lock <next> to the
+	 * dependency list of the previous lock <prev>:
 	 */
-	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
-			       &hlock_class(prev)->dep_list[1],
-			       next->acquire_ip, distance, trace);
-
-	if (!ret)
-		return 0;
-
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       &hlock_class(next)->dep_list[0],
 			       next->acquire_ip, distance, trace);
+
 	if (!ret)
 		return 0;
 
@@ -3016,7 +3044,7 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
 	else
 		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
+	print_lock_name(other->class[forwards]);
 	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
 
 	pr_warn("\nother info that might help us debug this:\n");
@@ -3033,18 +3061,18 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 		depth--;
 	} while (entry && entry != root && (depth >= 0));
 	if (forwards)
-		print_irq_lock_scenario(root, other,
-			middle ? middle->class : root->class, other->class);
+		print_irq_lock_scenario(fw_dep_class(root), fw_dep_class(other),
+			middle ? middle->class[1] : root->class[1], other->class[1]);
 	else
-		print_irq_lock_scenario(other, root,
-			middle ? middle->class : other->class, root->class);
+		print_irq_lock_scenario(bw_dep_class(other), bw_dep_class(root),
+			middle ? middle->class[0] : other->class[0], root->class[0]);
 
 	lockdep_print_held_locks(curr);
 
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	if (!save_trace(&root->trace))
 		return;
-	print_shortest_lock_dependencies(other, root);
+	print_shortest_lock_dependencies(other, root, forwards);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -3063,7 +3091,7 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 	struct lock_list *uninitialized_var(target_entry);
 
 	root.parent = NULL;
-	root.class = hlock_class(this);
+	root.class[1] = hlock_class(this);
 	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
 	if (ret < 0) {
 		print_bfs_bug(ret);
@@ -3090,7 +3118,7 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 	struct lock_list *uninitialized_var(target_entry);
 
 	root.parent = NULL;
-	root.class = hlock_class(this);
+	root.class[0] = hlock_class(this);
 	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
 	if (ret < 0) {
 		print_bfs_bug(ret);
@@ -4727,11 +4755,12 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	 */
 	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
 		entry = list_entries + i;
-		if (entry->class != class && entry->links_to != class)
+		if (entry->class[0] != class && entry->class[1] != class)
 			continue;
 		__clear_bit(i, list_entries_in_use);
 		nr_list_entries--;
-		list_del_rcu(&entry->entry);
+		list_del_rcu(&entry->entry[0]);
+		list_del_rcu(&entry->entry[1]);
 	}
 	if (list_empty(&class->dep_list[0]) &&
 	    list_empty(&class->dep_list[1])) {
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index dc0dfae..bbc1644 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -82,10 +82,10 @@ static int l_show(struct seq_file *m, void *v)
 	print_name(m, class);
 	seq_puts(m, "\n");
 
-	list_for_each_entry(entry, &class->dep_list[1], entry) {
+	list_for_each_entry(entry, &class->dep_list[1], entry[1]) {
 		if (entry->distance == 1) {
-			seq_printf(m, " -> [%p] ", entry->class->key);
-			print_name(m, entry->class);
+			seq_printf(m, " -> [%p] ", entry->class[1]->key);
+			print_name(m, entry->class[1]);
 			seq_puts(m, "\n");
 		}
 	}
-- 
1.8.3.1

