Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F45C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C8E20840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220986;
	bh=Ie5HSVYKOd/M6GEi4wabiS/JbOaS6l6oMMTV4n5zjI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=upDyTZAg/BfIOLgO1ILCYHQ6V11w2epbafWIjKzyQiSIJEQxT8NGHcaE7671D0F6X
	 DmFiGKoKqFrRdldKyWXXDBdXJ14Ec2QHPrjiOnS22zgUSgkL9RPKUcQ4zA3kJC6Y4u
	 cjjFvG22a2R1c9Q3GLuGaEHOmcHz1FRDZnF+K2Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfDBQDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbfDBQC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:58 -0400
Received: from lenoir.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 028C020857;
        Tue,  2 Apr 2019 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554220978;
        bh=Ie5HSVYKOd/M6GEi4wabiS/JbOaS6l6oMMTV4n5zjI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6Re52v5g0yRaw4nsHK7tC4h21efYOrTPdu/flhYTaRUTZetXEKZ209x/JwW8TU/8
         sV4onn0P++D5eZ1mFULTBoEGsPCVpYkqZXHJAmEOM+XPGcUgJxyjP8ljD9KiK7dG9z
         FhFaE7JoviESzXXgX1zce+X6l0+cZHmDFOu3pPkY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at once in check_irq_usage()
Date:   Tue,  2 Apr 2019 18:02:44 +0200
Message-Id: <20190402160244.32434-5-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402160244.32434-1-frederic@kernel.org>
References: <20190402160244.32434-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_prev_add_irq() tests all incompatible scenarios one after the
other while adding a lock (@next) to a tree dependency (@prev):

	LOCK_USED_IN_HARDIRQ          vs         LOCK_ENABLED_HARDIRQ
	LOCK_USED_IN_HARDIRQ_READ     vs         LOCK_ENABLED_HARDIRQ
	LOCK_USED_IN_SOFTIRQ          vs         LOCK_ENABLED_SOFTIRQ
	LOCK_USED_IN_SOFTIRQ_READ     vs         LOCK_ENABLED_SOFTIRQ

Also for these four scenarios, we must at least iterate the @prev
backward dependency. Then if it matches the relevant LOCK_USED_* bit,
we must also iterate the @next forward dependency.

Therefore in the best case we iterate 4 times, in the worst case 8 times.

A different approach can let us divide the number of branch iterations
by 4:

1) Iterate through @prev backward dependencies and accumulate all the IRQ
   uses in a single mask. In the best case where the current lock hasn't
   been used in IRQ, we stop here.

2) Iterate through @next forward dependencies and try to find a lock
   whose usage is exclusive to the accumulated usages gathered in the
   previous step. If we find one (call it @lockA), we have found an
   incompatible use, otherwise we stop here. Only bad locking scenario
   go further. So a sane verification stop here.

3) Iterate again through @prev backward dependency and find the lock
   whose usage matches @lockA in term of incompatibility. Call that
   lock @lockB.

4) Report the incompatible usages of @lockA and @lockB

If no incompatible use is found, the verification never goes beyond
step 2 which means at most two iterations.

The following compares the execution measurements of the function
check_prev_add_irq():

          Number of  calls   | Avg (ns)  | Stdev (ns) | Total time (ns)
------------------------------------------------------------------------
Mainline         8452        |  2652     |    11962   |    22415143
This patch       8452        |  1518     |     7090   |    12835602

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c           | 212 ++++++++++++++++++++---------
 kernel/locking/lockdep_internals.h |   6 +
 2 files changed, 151 insertions(+), 67 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5e149dd78298..80f33c700314 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1676,6 +1676,14 @@ check_redundant(struct lock_list *root, struct lock_class *target,
 }
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+
+static inline int usage_accumulate(struct lock_list *entry, void *mask)
+{
+	*(unsigned long *)mask |= entry->class->usage_mask;
+
+	return 0;
+}
+
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -1687,8 +1695,6 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 	return entry->class->usage_mask & *(unsigned long *)mask;
 }
 
-
-
 /*
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
@@ -1922,39 +1928,6 @@ print_bad_irq_dependency(struct task_struct *curr,
 	return 0;
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
-	if (ret < 0)
-		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
-
-	that.parent = NULL;
-	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, lock_flag(bit_forwards), &target_entry1);
-	if (ret < 0)
-		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
-
-	return print_bad_irq_dependency(curr, &this, &that,
-			target_entry, target_entry1,
-			prev, next,
-			bit_backwards, bit_forwards, irqclass);
-}
-
 static const char *state_names[] = {
 #define LOCKDEP_STATE(__STATE) \
 	__stringify(__STATE),
@@ -1988,45 +1961,151 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
+static unsigned long exclusive_dir_mask(unsigned long mask)
+{
+	unsigned long excl;
+
+	/* Invert dir */
+	excl = (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
+	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
+
+	return excl;
+}
+
+static unsigned long exclusive_mask(unsigned long mask)
+{
+	unsigned long excl = exclusive_dir_mask(mask);
+
+	/* Strip read */
+	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
+	excl &= ~LOCKF_IRQ_READ;
+
+	return excl;
+}
+
+
+/*
+ * Retrieve the _possible_ original mask to which @mask is
+ * exclusive. Ie: this is the opposite of exclusive_mask().
+ * Note that 2 possible original bits can match an exclusive
+ * bit: one has LOCK_USAGE_READ_MASK set, the other has it
+ * cleared. So both are returned for each exclusive bit.
+ */
+static unsigned long original_mask(unsigned long mask)
+{
+	unsigned long excl = exclusive_dir_mask(mask);
+
+	/* Include read in existing usages */
+	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
+
+	return excl;
+}
+
+/*
+ * Find the first pair of bit match between an original
+ * usage mask and an exclusive usage mask.
+ */
+static int find_exclusive_match(unsigned long mask,
+				unsigned long excl_mask,
+				enum lock_usage_bit *bit,
+				enum lock_usage_bit *excl_bit)
+{
+	int fs, nr = 0;
+
+	while ((fs = ffs(mask))) {
+		int excl;
+
+		nr += fs;
+		excl = exclusive_bit(nr - 1);
+		if (excl_mask & lock_flag(excl)) {
+			*bit = nr - 1;
+			*excl_bit = excl;
+			return 0;
+		}
+		mask >>= fs - 1;
+		/*
+		 * Prevent from shifts of sizeof(long) which can
+		 * give unpredictable results.
+		 */
+		mask >>= 1;
+	}
+	return -1;
+}
+
+/*
+ * Prove that the new dependency does not connect a hardirq-safe(-read)
+ * lock with a hardirq-unsafe lock - to achieve this we search
+ * the backwards-subgraph starting at <prev>, and the
+ * forwards-subgraph starting at <next>:
+ */
 static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
-			   struct held_lock *next, enum lock_usage_bit bit)
+			   struct held_lock *next)
 {
+	unsigned long usage_mask = 0, forward_mask, backward_mask;
+	enum lock_usage_bit forward_bit = 0, backward_bit = 0;
+	struct lock_list *uninitialized_var(target_entry1);
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list this, that;
+	int ret;
+
 	/*
-	 * Prove that the new dependency does not connect a hardirq-safe
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
+	 * Step 1: gather all hard/soft IRQs usages backward in an
+	 * accumulated usage mask.
 	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	this.parent = NULL;
+	this.class = hlock_class(prev);
+
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
+	if (ret < 0)
+		return print_bfs_bug(ret);
 
-	bit++; /* _READ */
+	usage_mask &= LOCKF_USED_IN_IRQ_ALL;
+	if (!usage_mask)
+		return 1;
 
 	/*
-	 * Prove that the new dependency does not connect a hardirq-safe-read
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
+	 * Step 2: find exclusive uses forward that match the previous
+	 * backward accumulated mask.
 	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	forward_mask = exclusive_mask(usage_mask);
 
-	return 1;
-}
+	that.parent = NULL;
+	that.class = hlock_class(next);
 
-static int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
-{
-#define LOCKDEP_STATE(__STATE)						\
-	if (!check_irq_usage(curr, prev, next, LOCK_USED_IN_##__STATE))	\
-		return 0;
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
+	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
+	if (ret < 0)
+		return print_bfs_bug(ret);
+	if (ret == 1)
+		return ret;
+
+	/*
+	 * Step 3: we found a bad match! Now retrieve a lock from the backward
+	 * list whose usage mask matches the exclusive usage mask from the
+	 * lock found on the forward list.
+	 */
+	backward_mask = original_mask(target_entry1->class->usage_mask);
+
+	ret = find_usage_backwards(&this, backward_mask, &target_entry);
+	if (ret < 0)
+		return print_bfs_bug(ret);
+	if (DEBUG_LOCKS_WARN_ON(ret == 1))
+		return 1;
+
+	/*
+	 * Step 4: narrow down to a pair of incompatible usage bits
+	 * and report it.
+	 */
+	ret = find_exclusive_match(target_entry->class->usage_mask,
+				   target_entry1->class->usage_mask,
+				   &backward_bit, &forward_bit);
+	if (DEBUG_LOCKS_WARN_ON(ret == -1))
+		return 1;
 
-	return 1;
+	return print_bad_irq_dependency(curr, &this, &that,
+			target_entry, target_entry1,
+			prev, next,
+			backward_bit, forward_bit,
+			state_name(backward_bit));
 }
 
 static void inc_chains(void)
@@ -2043,9 +2122,8 @@ static void inc_chains(void)
 
 #else
 
-static inline int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+static inline int check_irq_usage(struct task_struct *curr,
+				  struct held_lock *prev, struct held_lock *next)
 {
 	return 1;
 }
@@ -2225,7 +2303,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
 
-	if (!check_prev_add_irq(curr, prev, next))
+	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
 	/*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index d4c197425f68..d849692f2da7 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -50,6 +50,12 @@ enum {
 #define LOCKF_USED_IN_IRQ_READ \
 		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
 
+#define LOCKF_ENABLED_IRQ_ALL (LOCKF_ENABLED_IRQ | LOCKF_ENABLED_IRQ_READ)
+#define LOCKF_USED_IN_IRQ_ALL (LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ)
+
+#define LOCKF_IRQ (LOCKF_ENABLED_IRQ | LOCKF_USED_IN_IRQ)
+#define LOCKF_IRQ_READ (LOCKF_ENABLED_IRQ_READ | LOCKF_USED_IN_IRQ_READ)
+
 /*
  * CONFIG_LOCKDEP_SMALL is defined for sparc. Sparc requires .text,
  * .data and .bss to fit in required 32MB limit for the kernel. With
-- 
2.21.0

