Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82DE218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373982;
	bh=2m4Vrt8AevmaGM2gEFC5Ga+Fz6M4dynXJXfOJGFnyqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GIKQlO3wtxpoG8/UKrMC5WeHtPoBpNrqCLDiLiahmJWC18fQl/s9L/UfL2t/HMew5
	 c1cRw6X99bhUKJKWg6ZllppjbuAKMa79elhKbVkRLuoX1bck6Z+LTbPq4Kg4SIbBL0
	 gnWFt0A/Sdh5IV45llCH/+XTTE+/nl41LQ1JWNOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfB1RNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbfB1RM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:12:59 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D967218D0;
        Thu, 28 Feb 2019 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373977;
        bh=2m4Vrt8AevmaGM2gEFC5Ga+Fz6M4dynXJXfOJGFnyqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHJ9m7BregEptphHIUfsV5+T6roZynMLkKyyub8dHlN6hsvSRJlNKN/2JupDIPf9a
         rwXcwo7u+T0TnFu4yIznRfe1y6Vx3OT0dH6fJ12NqlEs5OI2uEgHCleveagomhh0B2
         dMhL8GDEibsKZgxK+Iw0ijVppSqWT5V7TB4XGF6E=
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
Subject: [PATCH 02/37] locking/lockdep: Use expanded masks on find_usage_*() functions
Date:   Thu, 28 Feb 2019 18:12:07 +0100
Message-Id: <20190228171242.32144-3-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to perform softirq vector-finegrained locking validation we'll
need to be able to check multiple vector usages at once. Prepare the low
level usage mask check functions for that purpose.

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
 kernel/locking/lockdep.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a989a3e9ead7..11db7ba29660 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1335,9 +1335,9 @@ check_redundant(struct lock_list *root, struct lock_class *target,
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
 
-static inline int usage_match(struct lock_list *entry, void *bit)
+static inline int usage_match(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
+	return entry->class->usage_mask & *(unsigned long *)mask;
 }
 
 
@@ -1353,14 +1353,14 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  * Return <0 on error.
  */
 static int
-find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
+find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, (void *)bit, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
 
 	return result;
 }
@@ -1376,14 +1376,14 @@ find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
  * Return <0 on error.
  */
 static int
-find_usage_backwards(struct lock_list *root, enum lock_usage_bit bit,
+find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, (void *)bit, usage_match, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
 
 	return result;
 }
@@ -1588,7 +1588,7 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 	this.parent = NULL;
 
 	this.class = hlock_class(prev);
-	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
+	ret = find_usage_backwards(&this, BIT(bit_backwards), &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -1596,7 +1596,7 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
+	ret = find_usage_forwards(&that, BIT(bit_forwards), &target_entry1);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2555,7 +2555,7 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
+		     unsigned long usage_mask, const char *irqclass)
 {
 	int ret;
 	struct lock_list root;
@@ -2563,7 +2563,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_forwards(&root, bit, &target_entry);
+	ret = find_usage_forwards(&root, usage_mask, &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2579,7 +2579,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
+		      unsigned long usage_mask, const char *irqclass)
 {
 	int ret;
 	struct lock_list root;
@@ -2587,7 +2587,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_backwards(&root, bit, &target_entry);
+	ret = find_usage_backwards(&root, usage_mask, &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2646,7 +2646,7 @@ static inline int state_verbose(enum lock_usage_bit bit,
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     enum lock_usage_bit bit, const char *name);
+			     unsigned long usage_mask, const char *name);
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
@@ -2678,7 +2678,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, BIT(excl_bit), state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
@@ -2689,7 +2689,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+		    !usage(curr, this, BIT(excl_bit + LOCK_USAGE_READ_MASK),
 				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
-- 
2.21.0

