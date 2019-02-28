Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE465218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373998;
	bh=LWI59Lez4hZcEfd4ntHUIqNDXmusRguG1Xc4u4h0CcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TF2NAQhyTt0n41IE5DDp77rCnW3uVEKZsMFUTzsvcl6YUNOMz5QACB2gbwZoBy0DK
	 ueaSr2z5QmPY/O96TGM25OfdWpznh1qD9uaE8CUVzgF1V5p/VlT7w/RE+Djrml+jVT
	 yG57zdsFc/C7SqBwHFFKsVrS1q2ieiw+kJ71gxK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbfB1RNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfB1RNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:13 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4FF218D0;
        Thu, 28 Feb 2019 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373992;
        bh=LWI59Lez4hZcEfd4ntHUIqNDXmusRguG1Xc4u4h0CcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSUTGncdVGGpCbbjanTPTJ7Sa05wg9KLWXOAnWksJiZdIHJdtKiJPGrZ3a2M94pvm
         KI59HVLqFQyN3sbK1ac4TL5cjY2KMF0fUgWi+y9u0l0c5dHRRCATJFKjzy+qthFPnW
         YCh3wh0faAfobpAx+8JRguclESiGFDgairhiSIH8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/37] locking/lockdep: Test all incompatible scenario at once in check_irq_usage()
Date:   Thu, 28 Feb 2019 18:12:11 +0100
Message-Id: <20190228171242.32144-7-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
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

Now things are going to become much worse as we plan to add as much
LOCK_USED_IN_{$VEC}_SOFTIRQ[_READ] as we have softirq vectors, currently
10. So the expanded test would be at least 22 loops and at most 44. We
can't really afford that.

So we take a different approach to fix this:

1) Iterate through @prev backward dependencies and accumulate all the IRQ
   uses in a single mask.

2) Iterate through @next forward dependencies and try to find a lock
   whose usage is exclusive to the accumulated usages gathered in the
   previous step. If we find one (call it @lockA), we have found an
   incompatible use.

3) Iterate again through @prev backward dependency and find the lock
   whose usage matches @lockA in term of incompatibility. Call that
   lock @lockB.

4) Report the incompatible usages of @lockA and @lockB

If no incompatible use is found, the verification never goes beyond
step 2 which means at most two iterations.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 193 +++++++++++++++++++++++++--------------
 1 file changed, 126 insertions(+), 67 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1a335176cb61..ac1efd16f3e7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1351,6 +1351,14 @@ check_redundant(struct lock_list *root, struct lock_class *target,
 }
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+
+static inline int usage_accumulate(struct lock_list *entry, void *mask)
+{
+	*(u64 *)mask |= entry->class->usage_mask;
+
+	return 0;
+}
+
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -1362,8 +1370,6 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 	return entry->class->usage_mask & *(u64 *)mask;
 }
 
-
-
 /*
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
@@ -1597,39 +1603,6 @@ print_bad_irq_dependency(struct task_struct *curr,
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
-	ret = find_usage_backwards(&this, BIT(bit_backwards), &target_entry);
-	if (ret < 0)
-		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
-
-	that.parent = NULL;
-	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, BIT(bit_forwards), &target_entry1);
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
@@ -1660,45 +1633,132 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
+static u64 __invert_mask(u64 mask, bool read)
+{
+	u64 excl_mask = 0;
+	int bit;
+
+	for_each_bit_nr(mask, bit) {
+		int excl = exclusive_bit(bit);
+		excl_mask |= lock_flag(excl);
+		if (read)
+			excl_mask |= lock_flag(excl | LOCK_USAGE_READ_MASK);
+	}
+
+	return excl_mask;
+}
+
+static u64 exclusive_mask(u64 mask)
+{
+	return __invert_mask(mask, false);
+}
+
+/*
+ * Retrieve the _possible_ original mask to which @mask is
+ * exclusive. Ie: this is the opposite of exclusive_mask().
+ * Note that 2 possible original bits can match an exclusive
+ * bit: one has LOCK_USAGE_READ_MASK set, the other has it
+ * cleared. So both are returned for each exclusive bit.
+ */
+static u64 original_mask(u64 mask)
+{
+	return __invert_mask(mask, true);
+}
+
+/*
+ * Find the first pair of bit match between an original
+ * usage mask and an exclusive usage mask.
+ */
+static int find_exclusive_match(u64 mask, u64 excl_mask,
+				enum lock_usage_bit *bit,
+				enum lock_usage_bit *excl_bit)
+{
+	int nr;
+
+	for_each_bit_nr(mask, nr) {
+		int excl = exclusive_bit(nr);
+		if (excl_mask & lock_flag(excl)) {
+			*bit = nr;
+			*excl_bit = excl;
+			return 0;
+		}
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
+	enum lock_usage_bit forward_bit = 0, backward_bit = 0;
+	struct lock_list *uninitialized_var(target_entry1);
+	struct lock_list *uninitialized_var(target_entry);
+	u64 usage_mask = 0, forward_mask, backward_mask;
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
+	usage_mask &= LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ;
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
+	if (ret == 1)
+		return print_bfs_bug(ret);
+
+	/*
+	 * Step 4: narrow down to a pair of incompatible usage bits
+	 * and report it.
+	 */
+	ret = find_exclusive_match(target_entry->class->usage_mask,
+				   target_entry1->class->usage_mask,
+				   &backward_bit, &forward_bit);
+	WARN_ON_ONCE(ret == -1);
 
-	return 1;
+	return print_bad_irq_dependency(curr, &this, &that,
+			target_entry, target_entry1,
+			prev, next,
+			backward_bit, forward_bit,
+			state_name(backward_bit));
 }
 
 static void inc_chains(void)
@@ -1715,9 +1775,8 @@ static void inc_chains(void)
 
 #else
 
-static inline int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+static inline int check_irq_usage(struct task_struct *curr,
+				  struct held_lock *prev, struct held_lock *next)
 {
 	return 1;
 }
@@ -1879,7 +1938,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
 
-	if (!check_prev_add_irq(curr, prev, next))
+	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
 	/*
-- 
2.21.0

