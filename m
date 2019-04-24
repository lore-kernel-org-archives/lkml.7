Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABC72175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l575aO/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfDXKVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37539 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfDXKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so9088923ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBJOYOm7BDSYJax0VKqLPG5RxXBKenrt1OOM6BQrUgs=;
        b=l575aO/oxRKX+7bihOh8uTCbhJ0odEPAa5mqtnz0QgPBisJNdfnh/OhT6JsDeQhi3w
         t4z1RSI2XsrDs9iNDPM4Fhd3ybFiey2BZXFKt74WKOEZ1dRADa17h/aPxKEMHw7W5fWt
         Oca5meUwztxxKe+hO563/xsciz8bWJSz5rZKIuXahy3+An0x67hYmnKjX/dmnoJyn/L1
         U8V3eEgWZKGzJaG21KYCT0Oc+e4ghTAgtrdel3COKt1517vmXOlDlgYMX1Y48ieuBgP9
         xu0bkHVSiasHV4XYJq1gCdFG3o35g0fNrKw9XT4/3rj+76opjbtw+X1rORqv1pZSpwxi
         Ct9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBJOYOm7BDSYJax0VKqLPG5RxXBKenrt1OOM6BQrUgs=;
        b=UyYkkPxu4oFBWRvktlmQLfFyIyrsfjk8gAm4t125XdztHYHk3xQtLCEVzhmKzvqxJD
         ukQCpEEgwjEIaupnz8NUF+TRqWky45k5ovKuTsdTCvpUrQbW+wZEbCjijfRi8EfqIOHe
         oSjin86DBYnquNEdB63ksbFaDjtL5PyH3UU7XticGsk1TMceKGniaNhojigQP78tfS6R
         vRutqltEIw/2dSacVxe7/jHZZO0nOdV/yhys5+pJ9L10xkepcYNbxVMmd8+64JFAS5sg
         t4RUcby6wTymX0L70/0uJklQNW3+fKemVNLm5rNZcxD0GSNwtkL57gTs5lpCWq0E6yiB
         afFQ==
X-Gm-Message-State: APjAAAWm3kxyOm4RwMcqrqMrWn1vqChSa8jHMLwiVtS7pDiMG7DzPVp+
        Rre0KStM3nVSVEaUl/vAnqs=
X-Google-Smtp-Source: APXvYqwprkcEvske0frjzrRCMGXIZe+3Ou5y5RQ+I5Fh4DVGfep5VUsc22tDkRntsyhflErLLgmuEg==
X-Received: by 2002:a17:902:ba85:: with SMTP id k5mr31588135pls.270.1556101305338;
        Wed, 24 Apr 2019 03:21:45 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:44 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 25/28] locking/lockdep: Implement new IRQ usage checking algorithm
Date:   Wed, 24 Apr 2019 18:19:31 +0800
Message-Id: <20190424101934.51535-26-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read-write locks make checks much more complex, we elaborate on all
possible cases in the following two tables, one for marking a new IRQ
usage and the other for adding a new dependency.

When reasoning all the cases in checking, these two factors are taken
into consideration. Firstly, if a lock is irqsafe or irqsafe read, it is
not necessary to mark it as reachable from any locks. Secondly, IRQ safe
for read lock is weak compared to IRQ safe lock in terms of checking IRQ
usage rules violation. As a result, if a lock is reachable from safe
lock, it is not necesary to record reachable from safe read lock.

1. Marking a new IRQ usage for a lock:

   ------------------------------------------------------------------------------
  |   dir    | new usage |  reachable  |     bad usage     |   check   |  reach  |
  |------------------------------------------------------------------------------|
  |          |           |             |   safe -> unsafe  |   done    |   done  |
  |          |           |    safe     |-----------------------------------------|
  |          |           |             | safe -> unsafe rd |   done    |   done  |
  |          |           |-------------------------------------------------------|
  |          |           |             |   safe -> unsafe  |   done    |   safe  |
  |          |   safe    |   safe rd   |-----------------------------------------|
  |          |           |             | safe -> unsafe rd | unsafe rd |   safe  |
  | forward  |           |-------------------------------------------------------|
  |          |           |             |   safe -> unsafe  |  unsafe   |   safe  |
  |          |           | unreachable |-----------------------------------------|
  |          |           |             | safe -> unsafe rd | unsafe rd |   safe  |
  |          |-------------------------------------------------------------------|
  |          |           |    safe     | safe rd -> unsafe |   done    |   done  |
  |          |           |-------------------------------------------------------|
  |          |  safe rd  |   safe rd   | safe rd -> unsafe |   done    |   done  |
  |          |           |-------------------------------------------------------|
  |          |           | unreachable | safe rd -> unsafe |  unsafe   | safe rd |
  |------------------------------------------------------------------------------|
  |          |           |             |   safe -> unsafe  | violation |    -    |
  |          |           |    safe     |-----------------------------------------|
  |          |           |             | safe rd -> unsafe | violation |    -    |
  |          |           |-------------------------------------------------------|
  |          |           |             |   safe -> unsafe  | violation |    -    |
  |          |   unsafe  |   safe rd   |-----------------------------------------|
  |          |           |             | safe rd -> unsafe | violation |    -    |
  | backward |           |-------------------------------------------------------|
  |          |           |             |   safe -> unsafe  |   done    |    -    |
  |          |           | unreachable |-----------------------------------------|
  |          |           |             | safe rd -> unsafe |   done    |    -    |
  |          |-------------------------------------------------------------------|
  |          |           |    safe     | safe -> unsafe rd | violation |    -    |
  |          |           |-------------------------------------------------------|
  |          | unsafe rd |   safe rd   | safe -> unsafe rd |   done    |    -    |
  |          |           |-------------------------------------------------------|
  |          |           | unreachable | safe -> unsafe rd |   done    |    -    |
   ------------------------------------------------------------------------------

where:
 - column "reachable" means whether the lock is previously reachable from
   safe or safe read locks
 - column "check" means what lock to search forward or nothing needs to be done
 - column "reach" means what lock to mark as reachable from this new usage

2. Adding a new dependency from prev to next:

   -----------------------------------------------------------------------------
  |           prev         |    next     |        check        |       reach    |
  |-----------------------------------------------------------------------------|
  |           safe         |    safe     |        done         |       done     |
  |-----------------------------------------------------------------------------|
  |           safe         |  safe rd    |       [unsafe]      |       safe     |
  |-----------------------------------------------------------------------------|
  |           safe         |   unsafe    |      violation      |       done     |
  |-----------------------------------------------------------------------------|
  |           safe         |  unsafe rd  |       unsafe        |       safe     |
  |-----------------------------------------------------------------------------|
  |           safe         |    used     |       unsafe        |       safe     |
  |-----------------------------------------------------------------------------|
  |        safe read       |    safe     |        done         |       done     |
  |-----------------------------------------------------------------------------|
  |        safe read       |   safe rd   |        done         |       done     |
  |-----------------------------------------------------------------------------|
  |        safe read       |   unsafe    |      violation      |       done     |
  |-----------------------------------------------------------------------------|
  |        safe read       |  unsafe rd  |       unsafe        |     safe rd    |
  |-----------------------------------------------------------------------------|
  |        safe read       |    used     |       unsafe        |     safe rd    |
  |-----------------------------------------------------------------------------|
  |         unsafe         |     -       |        done         |       done     |
  |-----------------------------------------------------------------------------|
  |       unsafe read      |     -       |        done         |     safe rd?   |
  |-----------------------------------------------------------------------------|
  |          used and safe reachable     |        the same as prev is safe      |
  |-----------------------------------------------------------------------------|
  |          used safe reachable rd      |     the same as prev is safe read    |
  |-----------------------------------------------------------------------------|
  |        just used       |                      done                          |
   -----------------------------------------------------------------------------

where:
 - column "prev" indicate the prev lock's usage type
 - column "next" indicate the next lock's usage type
 - columns "check" and "reach" mean the same as above table
 - "(rd)" means the same for the read case
 - "[unsafe]" means the check is not necessary
 - "safe rd?" means it is needed to mark reachable for the read case

It is worth noting that when adding a new dependency or marking a new
usage bit, if a conflicting usage is found, we don't continue to search
the graph for more conflicting usages or for marking reachable nodes,
which results in that we can miss more conflicting usages, however, the
missed ones are related to the one we found but have different
dependency paths. This bahavior is exactly the same as the current
checks.

It is also worth noting that because an irqsafe lock can be zapped
unfortunately, if it once reached a lock, it might need to be replaced
after zapping. To do so, we have to do a full forward graph traverse for
all the IRQ safe locks. This is heavy, but consider that irqsafe locks
are not too many and that zapping locks does not happen on a regular
basis, this should be affordable.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 494 +++++++++++++++++++++++--------------
 kernel/locking/lockdep_internals.h |  15 +-
 kernel/locking/lockdep_proc.c      |   1 -
 3 files changed, 314 insertions(+), 196 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2f24028..06ae87f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1365,6 +1365,33 @@ static inline int get_lock_depth(struct lock_list *child)
 	return depth;
 }
 
+static void
+mark_safe_lock(bool reach, struct lock_class *lock, int index, int distance,
+	       struct lock_class *safe_lock)
+{
+	int read = index % 2;
+	int shift = LOCK_USAGE_CONTEXT_SHIFT * (index >> 1);
+	unsigned long usage = lock->usage_mask;
+	unsigned long safe_mask = LOCKF_USED_IN_HARDIRQ << shift,
+		      safe_read_mask = LOCKF_USED_IN_HARDIRQ_READ << shift;
+
+	if (!reach)
+		return;
+
+	/*
+	 * If a lock itself is irqsafe, it is unnecessary to set it is an
+	 * irqsafe reachable lock.
+	 */
+	if (usage & safe_mask || (read && (usage & safe_read_mask)))
+		return;
+
+	/* Check whether this new distance is shorter */
+	if (lock->irqsafe_distance[index] > distance) {
+		lock->irqsafe_lock[index] = safe_lock;
+		lock->irqsafe_distance[index] = distance;
+	}
+}
+
 /*
  * Return the forward or backward dependency list.
  *
@@ -1383,11 +1410,10 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
  */
-static int __bfs(struct lock_list *source_entry,
-		 void *data,
+static int __bfs(struct lock_list *source_entry, void *data,
 		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int offset)
+		 struct lock_list **target_entry, int offset, int index,
+		 int distance, struct lock_class *safe_lock, bool reach)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1395,6 +1421,8 @@ static int __bfs(struct lock_list *source_entry,
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
 
+	mark_safe_lock(reach, source_entry->class, index, distance++, safe_lock);
+
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
 		ret = 0;
@@ -1422,6 +1450,10 @@ static int __bfs(struct lock_list *source_entry,
 		list_for_each_entry_rcu(entry, head, entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
+
+				mark_safe_lock(reach, entry->class, index,
+					       distance++, safe_lock);
+
 				mark_lock_accessed(entry, lock);
 				if (match(entry, data)) {
 					*target_entry = entry;
@@ -1443,23 +1475,15 @@ static int __bfs(struct lock_list *source_entry,
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline int __bfs_forwards(struct lock_list *src_entry, void *data,
+				 int (*match)(struct lock_list *entry, void *data),
+				 struct lock_list **target_entry, int index,
+				 int distance, struct lock_class *safe_lock,
+				 bool reach)
 {
 	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after));
-
-}
-
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
-{
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_before));
+		     offsetof(struct lock_class, locks_after),
+		     index, distance, safe_lock, reach);
 
 }
 
@@ -1632,7 +1656,8 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *uninitialized_var(target_entry);
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, &target_entry,
+		       0, 0, NULL, false);
 
 	return count;
 }
@@ -1653,33 +1678,6 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	return ret;
 }
 
-static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
-{
-	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
-
-	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
-
-	return count;
-}
-
-unsigned long lockdep_count_backward_deps(struct lock_class *class)
-{
-	unsigned long ret, flags;
-	struct lock_list this;
-
-	this.parent = NULL;
-	this.class = class;
-
-	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	ret = __lockdep_count_backward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
-
-	return ret;
-}
-
 /*
  * Check that the dependency graph starting at <src> can lead to
  * <target> or not. Print an error and return 0 if it does.
@@ -1691,7 +1689,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	int ret;
 
 	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
-			     target_entry);
+			     target_entry, 0, 0, NULL, false);
 
 	if (unlikely(ret < 0))
 		print_bfs_bug(ret);
@@ -1768,11 +1766,11 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 	return entry->class->usage_mask & *(unsigned long *)mask;
 }
 
-
-
 /*
- * Find a node in the forwards-direction dependency sub-graph starting
- * at @root->class that matches @bit.
+ * Find a node in the forward-direction dependency sub-graph starting
+ * at @root->class that matches @mask, meanwhile update
+ * irqsafe_lock[@index] and irqsafe_distance[@index] of the reached
+ * locks if this path is shorter.
  *
  * Return 0 if such a node exists in the subgraph, and put that node
  * into *@target_entry.
@@ -1782,38 +1780,19 @@ static inline int usage_match(struct lock_list *entry, void *mask)
  */
 static int
 find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
-			struct lock_list **target_entry)
+		    struct lock_list **target_entry, int index, int distance,
+		    struct lock_class *safe_lock)
 {
-	int result;
+	int ret;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
-
-	return result;
-}
-
-/*
- * Find a node in the backwards-direction dependency sub-graph starting
- * at @root->class that matches @bit.
- *
- * Return 0 if such a node exists in the subgraph, and put that node
- * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
- */
-static int
-find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
-			struct lock_list **target_entry)
-{
-	int result;
-
-	debug_atomic_inc(nr_find_usage_backwards_checks);
-
-	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
+	ret = __bfs_forwards(root, (void *)&usage_mask, usage_match, target_entry,
+			     index, distance, safe_lock, true);
+	if (ret < 0)
+		print_bfs_bug(ret);
 
-	return result;
+	return ret;
 }
 
 static void print_lock_class_header(struct lock_class *class, int depth)
@@ -1999,44 +1978,6 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	dump_stack();
 }
 
-static int
-check_usage(struct task_struct *curr, struct held_lock *prev,
-	    struct held_lock *next, enum lock_usage_bit bit_backwards,
-	    enum lock_usage_bit bit_forwards, const char *irqclass)
-{
-	int ret;
-	struct lock_list this, that;
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list *uninitialized_var(target_entry1);
-
-	this.parent = NULL;
-
-	this.class = hlock_class(prev);
-	ret = find_usage_backwards(&this, lock_flag(bit_backwards), &target_entry);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (ret == 1)
-		return ret;
-
-	that.parent = NULL;
-	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, lock_flag(bit_forwards), &target_entry1);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (ret == 1)
-		return ret;
-
-	print_bad_irq_dependency(curr, &this, &that,
-				 target_entry, target_entry1,
-				 prev, next,
-				 bit_backwards, bit_forwards, irqclass);
-	return 0;
-}
-
 static const char *state_names[] = {
 #define LOCKDEP_STATE(__STATE) \
 	__stringify(__STATE),
@@ -2070,30 +2011,131 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
-static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
-			   struct held_lock *next, enum lock_usage_bit bit)
+static int
+check_usage(struct task_struct *curr, struct held_lock *prev,
+	    struct held_lock *next, unsigned long mask,
+	    enum lock_usage_bit bit_backwards, enum lock_usage_bit bit_forwards,
+	    int index, int distance, struct lock_class *safe_lock)
 {
-	/*
-	 * Prove that the new dependency does not connect a hardirq-safe
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
-	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	int ret;
+	struct lock_list this, that;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *uninitialized_var(target_entry1);
+	const char *irqclass = state_name(bit_backwards);
 
-	bit++; /* _READ */
+	that.parent = NULL;
+	that.class = hlock_class(next);
+	ret = find_usage_forwards(&that, mask, &target_entry1, index, distance,
+				  safe_lock);
+	if (ret != 0)
+		return ret;
 
 	/*
-	 * Prove that the new dependency does not connect a hardirq-safe-read
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
+	 * To print out the dependencies of this conflicting usage, we
+	 * have to do a forward search from the IRQ safe or IRQ safe
+	 * read lock to this lock; the chance we are here is very small.
 	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
+	this.parent = NULL;
+	this.class = safe_lock;
+	/* If prev is the target, the search will return right away anyway */
+	ret = check_path(hlock_class(prev), &this, &target_entry);
+	if (unlikely(ret != 0)) {
+		if (unlikely(ret == 1)) {
+			/* Surprisingly the path does not exist */
+			if (!debug_locks_off_graph_unlock())
+				return 0;
+			WARN_ON_ONCE(1);
+		}
 		return 0;
+	}
+
+	print_bad_irq_dependency(curr, &this, &that,
+				 target_entry, target_entry1,
+				 prev, next,
+				 bit_backwards, bit_forwards, irqclass);
+	return 0;
+}
+
+static inline bool safe_usage(struct lock_class *lock, unsigned long mask,
+			      int index, int *distance,
+			      struct lock_class **safe_lock)
+{
+	unsigned long usage = lock->usage_mask;
+
+	if (usage & mask)
+		return true;
+
+	if (lock->irqsafe_distance[index] < INT_MAX) {
+		WARN_ON_ONCE(!lock->irqsafe_lock[index]);
+
+		if (distance)
+			*distance += lock->irqsafe_distance[index];
+		if (safe_lock)
+			*safe_lock = lock->irqsafe_lock[index];
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Prove that the new dependency does not connect:
+ *  -      irq-safe lock -> irq-unsafe lock
+ *  - irq-safe read lock -> irq-unsafe lock
+ *  -      irq-safe lock -> irq-unsafe read lock
+ *
+ *  Return 0 if it does or 1 if not.
+ */
+static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
+			   struct held_lock *next, int context)
+{
+	int index = context << 1, distance = 1, distance_read = 1;
+	int shift = LOCK_USAGE_CONTEXT_SHIFT * context;
+	int safe_bit = LOCK_USED_IN_HARDIRQ + shift;
+	int safe_read_bit = LOCK_USED_IN_HARDIRQ_READ + shift;
+	int unsafe_bit = LOCK_ENABLED_HARDIRQ + shift;
+	struct lock_class *safe_lock = hlock_class(prev);
+	struct lock_class *safe_lock_read = hlock_class(prev);
+	unsigned long safe_mask = LOCKF_USED_IN_HARDIRQ << shift;
+	unsigned long safe_read_mask = LOCKF_USED_IN_HARDIRQ_READ << shift;
+	unsigned long unsafe_mask = LOCKF_ENABLED_HARDIRQ << shift;
+	unsigned long unsafe_read_mask = LOCKF_ENABLED_HARDIRQ_READ << shift;
+	bool prev_safe = safe_usage(hlock_class(prev), safe_mask, index,
+				    &distance, &safe_lock);
+	bool prev_safe_read = safe_usage(hlock_class(prev), safe_read_mask,
+					 index+1, &distance_read, &safe_lock_read);
+	bool next_safe = safe_usage(hlock_class(next), safe_mask, index, NULL, NULL);
+	bool next_safe_read = safe_usage(hlock_class(next), safe_read_mask,
+					 index+1, NULL, NULL);
+
+	if (hlock_class(prev)->usage_mask & unsafe_mask)
+		return 1;
+
+	if (hlock_class(prev)->usage_mask & unsafe_read_mask)
+		goto check_read;
+
+	if (prev_safe) {
+		if (next_safe)
+			return 1;
+		/*
+		 * If next_usage & unsafe_mask, a conflicting usage is
+		 * found already, but we check to print the bad
+		 * dependency.
+		 */
+		return check_usage(curr, prev, next, unsafe_mask, safe_bit,
+				   unsafe_bit, index, distance, safe_lock);
+	}
+
+check_read:
+	if (prev_safe_read) {
+		if (next_safe || next_safe_read)
+			return 1;
+
+		/* Ditto */
+		return check_usage(curr, prev, next, unsafe_mask,
+				   safe_read_bit, unsafe_bit, index + 1,
+				   distance_read, safe_lock_read);
+	}
 
 	return 1;
 }
@@ -2103,7 +2145,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 		struct held_lock *next)
 {
 #define LOCKDEP_STATE(__STATE)						\
-	if (!check_irq_usage(curr, prev, next, LOCK_USED_IN_##__STATE))	\
+	if (!check_irq_usage(curr, prev, next, LOCK_CONTEXT_##__STATE))	\
 		return 0;
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
@@ -2340,12 +2382,6 @@ static inline void inc_chains(void)
 	if (!ret)
 		return 0;
 
-	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, &trace);
-	if (!ret)
-		return 0;
-
 	return 2;
 }
 
@@ -2995,30 +3031,54 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 	dump_stack();
 }
 
-/*
- * Prove that in the forwards-direction subgraph starting at <this>
- * there is no lock matching <mask>:
- */
+#define STRICT_READ_CHECKS	1
+
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
+		     enum lock_usage_bit new_bit, enum lock_usage_bit excl_bit)
 {
-	int ret;
+	int ret, context = new_bit >> 2;
+	int index = new_bit >> 1; /* new_bit is USED_IN */
+	int shift = LOCK_USAGE_CONTEXT_SHIFT * context;
+	int read = new_bit & LOCK_USAGE_READ_MASK;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
+	unsigned long mask = LOCKF_ENABLED_HARDIRQ << shift;
+	const char *irqclass = state_name(new_bit & ~LOCK_USAGE_READ_MASK);
 
+	if (!read) {
+		/*
+		 * This lock was just marked USED_IN and hence becomes a
+		 * new IRQ safe lock. If it was already reachable from
+		 * an IRQ safe lock, the locks forward the graph have
+		 * been proven no conflicting usage.
+		 */
+		if (hlock_class(this)->irqsafe_lock[index])
+			return 1;
+		if (STRICT_READ_CHECKS)
+			mask |= (LOCKF_ENABLED_HARDIRQ_READ << shift);
+	} else {
+		if (!STRICT_READ_CHECKS)
+			return 1;
+		if (hlock_class(this)->irqsafe_lock[index])
+			return 1;
+		if (hlock_class(this)->irqsafe_lock[++index])
+			return 1;
+	}
+
+	/*
+	 * If it was unreachable from an IRQ safe lock before, a forward
+	 * search for IRQ unsafe lock is needed.
+	 */
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (ret == 1)
+	ret = find_usage_forwards(&root, mask, &target_entry, index, 0,
+				  hlock_class(this));
+	if (ret != 0)
 		return ret;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 1, irqclass);
+	print_irq_inversion_bug(curr, &root, target_entry, this, 1, irqclass);
+
 	return 0;
 }
 
@@ -3028,24 +3088,47 @@ static void print_usage_bug_scenario(struct held_lock *lock)
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
+		      enum lock_usage_bit new_bit, enum lock_usage_bit excl_bit)
 {
-	int ret;
+	int ret, index = (new_bit >> 2) << 1; /* new_bit is ENABLED */
+	int read = new_bit & LOCK_USAGE_READ_MASK;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
+	const char *irqclass = state_name(new_bit & ~LOCK_USAGE_READ_MASK);
 
+	/*
+	 * This lock was just marked ENABLED and hence becomes a new IRQ
+	 * unsafe lock. If it was proven unreachable from an IRQ safe lock
+	 * before, there is no conflicting usage.
+	 */
+	if (!hlock_class(this)->irqsafe_lock[index]) {
+		if (!hlock_class(this)->irqsafe_lock[++index] || read)
+			return 1;
+	}
+
+	/*
+	 * This lock was proven reachable from an IRQ safe lock before,
+	 * a conflicting usage is thus found.
+	 *
+	 * To print out the dependencies of this conflicting usage, we
+	 * have to do a forward search from the IRQ safe lock to this
+	 * lock; the chance we are here is very small.
+	 */
 	root.parent = NULL;
-	root.class = hlock_class(this);
-	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
-		print_bfs_bug(ret);
+	root.class = hlock_class(this)->irqsafe_lock[index];
+	ret = check_path(hlock_class(this), &root, &target_entry);
+	if (unlikely(ret != 0)) {
+		if (unlikely(ret == 1)) {
+			/* Surprisingly the path does not exist */
+			if (!debug_locks_off_graph_unlock())
+				return 0;
+			WARN_ON_ONCE(1);
+		}
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 0, irqclass);
+	print_irq_inversion_bug(curr, target_entry, &root, this, 0, irqclass);
+
 	return 0;
 }
 
@@ -3082,8 +3165,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -3098,7 +3179,8 @@ static inline int state_verbose(enum lock_usage_bit bit,
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     enum lock_usage_bit bit, const char *name);
+			     enum lock_usage_bit new_bit,
+			     enum lock_usage_bit excl_bit);
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
@@ -3114,7 +3196,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * has ENABLED state, which would allow recursion deadlocks.
 	 *
 	 * mark ENABLED has to look backwards -- to ensure no dependee
-	 * has USED_IN state, which, again, would allow  recursion deadlocks.
+	 * has USED_IN state, which, again, would allow recursion deadlocks.
 	 */
 	check_usage_f usage = dir ?
 		check_usage_backwards : check_usage_forwards;
@@ -3145,27 +3227,17 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	if (!valid_state(curr, this, new_bit, excl_bit))
 		return 0;
 
+	if (!read && !valid_state(curr, this, new_bit,
+				  excl_bit + LOCK_USAGE_READ_MASK))
+		return 0;
+
 	/*
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	if (!usage(curr, this, new_bit, excl_bit))
 		return 0;
 
-	/*
-	 * Check for read in write conflicts
-	 */
-	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
-			return 0;
-
-		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
-			return 0;
-	}
-
 	if (state_verbose(new_bit, lock))
 		return 2;
 
@@ -4673,16 +4745,60 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 static inline void remove_irqsafe_lock_bitmap(struct lock_class *class)
 {
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+	int i, j, count = 0;
+	DECLARE_BITMAP(irqsafe_locks, 4);
 	unsigned long usage = class->usage_mask;
+	unsigned long *bitmaps[4] = {
+		lock_classes_hardirq_safe,
+		lock_classes_hardirq_safe_read,
+		lock_classes_softirq_safe,
+		lock_classes_softirq_safe_read
+	};
 
-	if (usage & LOCKF_USED_IN_HARDIRQ)
+	if (usage & LOCKF_USED_IN_HARDIRQ) {
 		__clear_bit(class - lock_classes, lock_classes_hardirq_safe);
-	if (usage & LOCKF_USED_IN_HARDIRQ_READ)
+		__set_bit(0, irqsafe_locks);
+	}
+	if (usage & LOCKF_USED_IN_HARDIRQ_READ) {
 		__clear_bit(class - lock_classes, lock_classes_hardirq_safe_read);
-	if (usage & LOCKF_USED_IN_SOFTIRQ)
+		__set_bit(1, irqsafe_locks);
+	}
+	if (usage & LOCKF_USED_IN_SOFTIRQ) {
 		__clear_bit(class - lock_classes, lock_classes_softirq_safe);
-	if (usage & LOCKF_USED_IN_SOFTIRQ_READ)
+		__set_bit(2, irqsafe_locks);
+	}
+	if (usage & LOCKF_USED_IN_SOFTIRQ_READ) {
 		__clear_bit(class - lock_classes, lock_classes_softirq_safe_read);
+		__set_bit(3, irqsafe_locks);
+	}
+
+	if (bitmap_empty(irqsafe_locks, 4))
+		return;
+
+	for_each_set_bit(i, lock_classes_in_use, ARRAY_SIZE(lock_classes)) {
+		for_each_set_bit(j, irqsafe_locks, 4) {
+			if (lock_classes[i].irqsafe_lock[j] == class) {
+				lock_classes[i].irqsafe_lock[j] = NULL;
+				lock_classes[i].irqsafe_distance[j] = INT_MAX;
+				count++;
+			}
+		}
+	}
+
+	if (!count)
+		return;
+
+	for_each_set_bit(j, irqsafe_locks, 4) {
+		for_each_set_bit(i, bitmaps[j], ARRAY_SIZE(lock_classes)) {
+			struct lock_list root;
+			struct lock_list *uninitialized_var(target_entry);
+			struct lock_class *lock = lock_classes + i;
+
+			root.parent = NULL;
+			root.class = lock;
+			find_usage_forwards(&root, 0, &target_entry, j, 0, lock);
+		}
+	}
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2b3ffd4..30d021b 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -25,6 +25,7 @@ enum lock_usage_bit {
 #define LOCK_USAGE_READ_MASK 1
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+#define LOCK_USAGE_CONTEXT_SHIFT   4
 
 /*
  * Usage-state bitmasks:
@@ -66,6 +67,14 @@ enum {
 	0;
 #undef LOCKDEP_STATE
 
+enum {
+#define LOCKDEP_STATE(__STATE)		\
+	LOCK_CONTEXT_##__STATE,
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+	LOCK_CONTEXTS
+};
+
 /*
  * CONFIG_LOCKDEP_SMALL is defined for sparc. Sparc requires .text,
  * .data and .bss to fit in required 32MB limit for the kernel. With
@@ -131,18 +140,12 @@ extern void get_usage_chars(struct lock_class *class,
 
 #ifdef CONFIG_PROVE_LOCKING
 extern unsigned long lockdep_count_forward_deps(struct lock_class *);
-extern unsigned long lockdep_count_backward_deps(struct lock_class *);
 #else
 static inline unsigned long
 lockdep_count_forward_deps(struct lock_class *class)
 {
 	return 0;
 }
-static inline unsigned long
-lockdep_count_backward_deps(struct lock_class *class)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_DEBUG_LOCKDEP
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9c49ec6..7b5fe77 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -72,7 +72,6 @@ static int l_show(struct seq_file *m, void *v)
 #endif
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
-	seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
 #endif
 
 	get_usage_chars(class, usage);
-- 
1.8.3.1

