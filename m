Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634F8218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374004;
	bh=lMDmD+yHh+DlWhq/53k7Ao+2uIANDRR35ZmppOVVl8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7yNkTcpL1fBT/MJN1pu8PnNzrBt3tLee3yObfuqwehDQyMmeGbF6JOlrOK1kJ3Nw
	 I5lI+JGEU3mm8pxBCqPThApOFY8r9e5vvjAwIcE7IoVTE0jUV/ovEbr+NZdgyIegPV
	 rabXX46t4VPOnkMdwhfMoX5cF7DJebsJJyVBKlbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbfB1RNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfB1RNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:19 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2E7218AE;
        Thu, 28 Feb 2019 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373999;
        bh=lMDmD+yHh+DlWhq/53k7Ao+2uIANDRR35ZmppOVVl8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meALxdGOCDarFNGzXykv5bS5OPkRw78FCEtr6Ixrw12xPZi6q7AHnwmZyVbWj4QHg
         vmLnXT0pLGKGLDICFCY98BM3n4d/7GaVkmEPkTXgy1O57OX+eToinOFXfWCg4TM/wr
         eiOzYQchVn294bkIokflcW+4dreDb7qH6/La2OkU=
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
Subject: [PATCH 08/37] locking/lockdep: Prepare check_usage_*() to handle plain masks
Date:   Thu, 28 Feb 2019 18:12:13 +0100
Message-Id: <20190228171242.32144-9-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_lock_irq() is going to deal with lock usages that gather multiple
softirq vectors at once. Therefore the validation through
check_usage_backwards() and check_usage_forwards() will need to handle
expanded usage masks.

So enhance those functions to that purpose.

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
 kernel/locking/lockdep.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2321b5e16cdf..d1bfe5eff708 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2662,9 +2662,12 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     u64 usage_mask, const char *irqclass)
+		     u64 usage_mask, bool read)
 {
 	int ret;
+	u64 intersec;
+	int intersec_bit;
+	const char *irqclass;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
@@ -2676,8 +2679,14 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == 1)
 		return ret;
 
+	intersec = usage_mask & target_entry->class->usage_mask;
+	intersec_bit = __ffs64(intersec);
+	if (read)
+		intersec_bit += LOCK_USAGE_READ_MASK;
+	irqclass = state_name(intersec_bit);
+
 	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 1, irqclass);
+				       this, 1, irqclass);
 }
 
 /*
@@ -2686,9 +2695,12 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      u64 usage_mask, const char *irqclass)
+		      u64 usage_mask, bool read)
 {
 	int ret;
+	u64 intersec;
+	int intersec_bit;
+	const char *irqclass;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
@@ -2700,6 +2712,12 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == 1)
 		return ret;
 
+	intersec = usage_mask & target_entry->class->usage_mask;
+	intersec_bit = __ffs64(intersec);
+	if (read)
+		intersec_bit += LOCK_USAGE_READ_MASK;
+	irqclass = state_name(intersec_bit);
+
 	return print_irq_inversion_bug(curr, &root, target_entry,
 					this, 0, irqclass);
 }
@@ -2753,7 +2771,7 @@ static inline int state_verbose(enum lock_usage_bit bit,
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     u64 usage_mask, const char *name);
+			     u64 usage_mask, bool read);
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
@@ -2789,7 +2807,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-	    !usage(curr, this, lock_usage_mask(&excl_usage), state_name(new_usage->bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, lock_usage_mask(&excl_usage), false))
 		return 0;
 
 	/*
@@ -2803,7 +2821,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 
 		if (STRICT_READ_CHECKS &&
 		    !usage(curr, this, lock_usage_mask(&excl_usage),
-			   state_name(new_usage->bit + LOCK_USAGE_READ_MASK)))
+			       true))
 			return 0;
 	}
 
-- 
2.21.0

