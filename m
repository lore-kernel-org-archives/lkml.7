Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47ADC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7627C217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WP/+D8cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDKKqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:46:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8aSn0dyUwbGch68YAJINwmfjJGzdVQ7gqy871uBD61E=; b=WP/+D8cp/4HF/T9jthlgpXsHW
        t07cmS5O8ui4/ZHH1Vt1ZXgWbaC4D33kzt48Nrnq19lWONijvT/OeeMuq7MLEf0giaWCJYAsnxhuX
        XwpIfjh95G382h8fi4dZ49JR1UlJVzMox1SxIl5IqWOlmMkeoHIFfNye5lmE+TfiK7dxpSxBduzg4
        qcBijFSJ08MTaEiYbI6nx3FhUzrKWBlrQtR5o9fvB3VHGSJnk1oAkzlFVx77xaiLtm05SG+cr8VPW
        s3u433kdCJzPLc4o2ybwgTXiZ/S+EOR6Vbl2zhZIa6MMt8vl6IqvNnTtQ7XM6lhIIqV6uDVSJyyTQ
        aLgwqYyYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEXE2-0005Ln-Lh; Thu, 11 Apr 2019 10:46:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B02E29AA8DC8; Thu, 11 Apr 2019 12:46:32 +0200 (CEST)
Date:   Thu, 11 Apr 2019 12:46:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at
 once in check_irq_usage()
Message-ID: <20190411104632.GH4038@hirez.programming.kicks-ass.net>
References: <20190402160244.32434-1-frederic@kernel.org>
 <20190402160244.32434-5-frederic@kernel.org>
 <20190409130352.GV4038@hirez.programming.kicks-ass.net>
 <20190410022846.GA30602@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410022846.GA30602@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:28:48AM +0200, Frederic Weisbecker wrote:
> Should I re-issue the set or you do the changes?

I've made it like so; does that work? In particular, do the comments
make sense? It is always hard to write these things down.

---

Subject: locking/lockdep: Test all incompatible scenario at once in check_irq_usage()
From: Frederic Weisbecker <frederic@kernel.org>
Date: Tue, 2 Apr 2019 18:02:44 +0200

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

Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190402160244.32434-5-frederic@kernel.org
---
 kernel/locking/lockdep.c           |  226 ++++++++++++++++++++++++++-----------
 kernel/locking/lockdep_internals.h |    6 
 2 files changed, 165 insertions(+), 67 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1676,6 +1676,14 @@ check_redundant(struct lock_list *root,
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
@@ -1687,8 +1695,6 @@ static inline int usage_match(struct loc
 	return entry->class->usage_mask & *(unsigned long *)mask;
 }
 
-
-
 /*
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
@@ -1922,39 +1928,6 @@ print_bad_irq_dependency(struct task_str
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
@@ -1977,6 +1950,13 @@ static inline const char *state_name(enu
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
@@ -1988,45 +1968,158 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
+/*
+ * Observe that when given a bitmask where each bitnr is encoded as above, a
+ * right shift of the mask transforms the individual bitnrs as -1.
+ *
+ * So for all bits where bitnr1 == 1, we can create the mask where bitnr1 == 0
+ * by subtracting 2, or shifting the mask right by 2.
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
+ * As above, we clear bitnr0 with bitmask ops. First, for all bits with bitnr1
+ * set, add those with bitnr1 cleared. And then mask out all bitnr1.
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
@@ -2043,9 +2136,8 @@ static void inc_chains(void)
 
 #else
 
-static inline int
-check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+static inline int check_irq_usage(struct task_struct *curr,
+				  struct held_lock *prev, struct held_lock *next)
 {
 	return 1;
 }
@@ -2225,7 +2317,7 @@ check_prev_add(struct task_struct *curr,
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
 
-	if (!check_prev_add_irq(curr, prev, next))
+	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
 	/*
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -66,6 +66,12 @@ static const unsigned long LOCKF_USED_IN
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
