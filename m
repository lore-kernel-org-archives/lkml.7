Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A2C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41D2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d4idvhC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfD2GkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:40:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfD2GkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:40:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6dpDE784289
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:39:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6dpDE784289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556519991;
        bh=uxe7cr2/aBo2yaIEbqAb/nybbxwaLgg5jhI0o0AUy64=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=d4idvhC3tZbEqSGsw0n+UUFwO4iwism6pFvKO7UUrF2W0VWSAeDQ+TEECAmmeIn+l
         6cfd9GS3oUbVZUszv/Rv22SDT3+D13d1yVwzV9QE7z/wj/Ge1cZLuQ5cJUG2vYYUTX
         tibXny7TYUde9pROX0+gijM/iTX+EDEyRN5YpYs6+lq041tl48ParPcO7WbODwq7Ri
         f9MeuI5Tye+w30gi///rsJqi/qluyRBRuSdQfUEMAXDQo4bgEQnHMhNpIvp7S/Q0kL
         aoA7cBM66hmFx08qTRkRONXnf1Tc5ItZn+s+J/vccLx0Yn/Izbu8h6WKKI1OIV6UF7
         P3Bht0w5J1bpA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6dnXO784286;
        Sun, 28 Apr 2019 23:39:49 -0700
Date:   Sun, 28 Apr 2019 23:39:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-948f83768a180ec8e85c4a8ff269d5e433d10815@git.kernel.org>
Cc:     tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        akpm@linux-foundation.org, frederic@kernel.org,
        will.deacon@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, will.deacon@arm.com,
          mingo@kernel.org, paulmck@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, akpm@linux-foundation.org,
          frederic@kernel.org, tglx@linutronix.de
In-Reply-To: <20190402160244.32434-5-frederic@kernel.org>
References: <20190402160244.32434-5-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Test all incompatible scenarios
 at once in check_irq_usage()
Git-Commit-ID: 948f83768a180ec8e85c4a8ff269d5e433d10815
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

Commit-ID:  948f83768a180ec8e85c4a8ff269d5e433d10815
Gitweb:     https://git.kernel.org/tip/948f83768a180ec8e85c4a8ff269d5e433d10815
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 2 Apr 2019 18:02:44 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:29:20 +0200

locking/lockdep: Test all incompatible scenarios at once in check_irq_usage()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190402160244.32434-5-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c           | 228 ++++++++++++++++++++++++++-----------
 kernel/locking/lockdep_internals.h |   6 +
 2 files changed, 167 insertions(+), 67 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5e149dd78298..25ecc6d3058b 100644
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
@@ -1977,6 +1950,13 @@ static inline const char *state_name(enum lock_usage_bit bit)
 		return state_names[bit >> LOCK_USAGE_DIR_MASK];
 }
 
+/*
+ * The bit number is encoded like:
+ *
+ *  bit0: 0 exclusive, 1 read lock
+ *  bit1: 0 used in irq, 1 irq enabled
+ *  bit2-n: state
+ */
 static int exclusive_bit(int new_bit)
 {
 	int state = new_bit & LOCK_USAGE_STATE_MASK;
@@ -1988,45 +1968,160 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
+/*
+ * Observe that when given a bitmask where each bitnr is encoded as above, a
+ * right shift of the mask transforms the individual bitnrs as -1 and
+ * conversely, a left shift transforms into +1 for the individual bitnrs.
+ *
+ * So for all bits whose number have LOCK_ENABLED_* set (bitnr1 == 1), we can
+ * create the mask with those bit numbers using LOCK_USED_IN_* (bitnr1 == 0)
+ * instead by subtracting the bit number by 2, or shifting the mask right by 2.
+ *
+ * Similarly, bitnr1 == 0 becomes bitnr1 == 1 by adding 2, or shifting left 2.
+ *
+ * So split the mask (note that LOCKF_ENABLED_IRQ_ALL|LOCKF_USED_IN_IRQ_ALL is
+ * all bits set) and recompose with bitnr1 flipped.
+ */
+static unsigned long invert_dir_mask(unsigned long mask)
+{
+	unsigned long excl = 0;
+
+	/* Invert dir */
+	excl |= (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
+	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
+
+	return excl;
+}
+
+/*
+ * As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all
+ * bits with bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*).
+ * And then mask out all bitnr0.
+ */
+static unsigned long exclusive_mask(unsigned long mask)
+{
+	unsigned long excl = invert_dir_mask(mask);
+
+	/* Strip read */
+	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
+	excl &= ~LOCKF_IRQ_READ;
+
+	return excl;
+}
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
+	unsigned long excl = invert_dir_mask(mask);
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
+				enum lock_usage_bit *bitp,
+				enum lock_usage_bit *excl_bitp)
+{
+	int bit, excl;
+
+	for_each_set_bit(bit, &mask, LOCK_USED) {
+		excl = exclusive_bit(bit);
+		if (excl_mask & lock_flag(excl)) {
+			*bitp = bit;
+			*excl_bitp = excl;
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
 
-	bit++; /* _READ */
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
+	if (ret < 0)
+		return print_bfs_bug(ret);
+
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
 
-	return 1;
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
+
+	return print_bad_irq_dependency(curr, &this, &that,
+			target_entry, target_entry1,
+			prev, next,
+			backward_bit, forward_bit,
+			state_name(backward_bit));
 }
 
 static void inc_chains(void)
@@ -2043,9 +2138,8 @@ static void inc_chains(void)
 
 #else
 
-static inline int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+static inline int check_irq_usage(struct task_struct *curr,
+				  struct held_lock *prev, struct held_lock *next)
 {
 	return 1;
 }
@@ -2225,7 +2319,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
 
-	if (!check_prev_add_irq(curr, prev, next))
+	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
 	/*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2b3ffd4117ad..150ec3f0c5b5 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -66,6 +66,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 	0;
 #undef LOCKDEP_STATE
 
+#define LOCKF_ENABLED_IRQ_ALL (LOCKF_ENABLED_IRQ | LOCKF_ENABLED_IRQ_READ)
+#define LOCKF_USED_IN_IRQ_ALL (LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ)
+
+#define LOCKF_IRQ (LOCKF_ENABLED_IRQ | LOCKF_USED_IN_IRQ)
+#define LOCKF_IRQ_READ (LOCKF_ENABLED_IRQ_READ | LOCKF_USED_IN_IRQ_READ)
+
 /*
  * CONFIG_LOCKDEP_SMALL is defined for sparc. Sparc requires .text,
  * .data and .bss to fit in required 32MB limit for the kernel. With
