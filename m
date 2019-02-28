Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE0FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C9F218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373989;
	bh=hZR1Qkj49h3hy/Lt3y6WQtg5lXKX6/mXSdQ0kIht+R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0r0SBYTUiyN73Tczd0nRPTLuyHTetahTKujKvMZ2X/8TbiczZEYpvo+g2U/r5M2q
	 JjLkEzNgH5wAlQIlpQTqjwGcJniV25V3uLwYltmt3oqix38JWfixgu07SeUCt9goiJ
	 4eteo+G2/7hf8F8rBUph10IxKuynDDSiT7AKNAAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfB1RNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbfB1RNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:06 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0717D218E2;
        Thu, 28 Feb 2019 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373984;
        bh=hZR1Qkj49h3hy/Lt3y6WQtg5lXKX6/mXSdQ0kIht+R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5z+1ICs2Jr0fwSepHuEZgiw5P0mbgCwfBejdHZc1TZ5M0m6Jt2gunEbs13TTpwAo
         JUFqW7uE+RWj50NsvsqfGaCLICZHZgaUPxshNXxTykH2y2sQUKusCO9wpu8pvrDffz
         nOj8oWTTMY8wjs+z2tMhCO0RVlPI2Lm7tNTfYtjQ=
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
Subject: [PATCH 04/37] locking/lockdep: Convert usage_mask to u64
Date:   Thu, 28 Feb 2019 18:12:09 +0100
Message-Id: <20190228171242.32144-5-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage mask is going to expand to validate softirq related usages in
a per-vector finegrained way.

The current bitmap layout is:

                  LOCK_USED        HARDIRQ bits
                        \            /
                         \          /
                          0  0000  0000
                               |
                               |
                          SOFTIRQ bits

The new one will be:

                                  TIMER_SOFTIRQ
                 LOCK_USED            bits       HARDIRQ bits
                     \                  |            |
                      \                 |            |
                      0   0000  [...]  0000  0000  0000
                            |                  |
                            |                  |
                       RCU_SOFTIRQ        HI_SOFTIRQ bits
                          bits

So we have 4 hardirq bits + NR_SOFTIRQS * 4 + 1 bit (LOCK_USED) = 45
bits. Therefore we need a 64 bits mask.

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
 include/linux/lockdep.h  |  2 +-
 kernel/locking/lockdep.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df2372f..06669f20a30a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -83,7 +83,7 @@ struct lock_class {
 	/*
 	 * IRQ/softirq usage tracking bits:
 	 */
-	unsigned long			usage_mask;
+	u64				usage_mask;
 	struct stack_trace		usage_traces[XXX_LOCK_USAGE_STATES];
 
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4fc859c0a799..004278969afc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -463,12 +463,12 @@ const char * __get_key_name(struct lockdep_subclass_key *key, char *str)
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
 }
 
-static inline unsigned long lock_flag(enum lock_usage_bit bit)
+static inline u64 lock_flag(enum lock_usage_bit bit)
 {
-	return 1UL << bit;
+	return BIT_ULL(bit);
 }
 
-static unsigned long lock_usage_mask(struct lock_usage *usage)
+static u64 lock_usage_mask(struct lock_usage *usage)
 {
 	return lock_flag(usage->bit);
 }
@@ -1342,7 +1342,7 @@ check_redundant(struct lock_list *root, struct lock_class *target,
 
 static inline int usage_match(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & *(unsigned long *)mask;
+	return entry->class->usage_mask & *(u64 *)mask;
 }
 
 
@@ -1358,7 +1358,7 @@ static inline int usage_match(struct lock_list *entry, void *mask)
  * Return <0 on error.
  */
 static int
-find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
+find_usage_forwards(struct lock_list *root, u64 usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
@@ -1381,7 +1381,7 @@ find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
  * Return <0 on error.
  */
 static int
-find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
+find_usage_backwards(struct lock_list *root, u64 usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
@@ -1405,7 +1405,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk(KERN_CONT " {\n");
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
-		if (class->usage_mask & (1 << bit)) {
+		if (class->usage_mask & lock_flag(bit)) {
 			int len = depth;
 
 			len += printk("%*s   %s", depth, "", usage_str[bit]);
@@ -2484,7 +2484,7 @@ static inline int
 valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
-	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit)))
+	if (unlikely(hlock_class(this)->usage_mask & lock_flag(bad_bit)))
 		return print_usage_bug(curr, this, bad_bit, new_bit);
 	return 1;
 }
@@ -2559,7 +2559,7 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     unsigned long usage_mask, const char *irqclass)
+		     u64 usage_mask, const char *irqclass)
 {
 	int ret;
 	struct lock_list root;
@@ -2583,7 +2583,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      unsigned long usage_mask, const char *irqclass)
+		      u64 usage_mask, const char *irqclass)
 {
 	int ret;
 	struct lock_list root;
@@ -2650,7 +2650,7 @@ static inline int state_verbose(enum lock_usage_bit bit,
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     unsigned long usage_mask, const char *name);
+			     u64 usage_mask, const char *name);
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
@@ -3034,7 +3034,7 @@ static inline int separate_irq_context(struct task_struct *curr,
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     struct lock_usage *new_usage)
 {
-	unsigned long new_mask = lock_usage_mask(new_usage), ret = 1;
+	u64 new_mask = lock_usage_mask(new_usage), ret = 1;
 
 	/*
 	 * If already set then do not dirty the cacheline,
-- 
2.21.0

