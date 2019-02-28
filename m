Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A90218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374101;
	bh=cmCVTIPmj4tsOmnUQwhRBQRZZ3OGTDK2YIQY+Ccw6n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hd7zdsJH847XdPU664kSH6UxnSoIfmobF954uFCt3kXeqU9l+jGMDs4zOXVRJveTH
	 SBfCN94CqLqctYzMgO6Qdh03z7TPEGhOtsBwzeaXa4gMKuQm2xuDMdyxkhqj139JEo
	 Nc79HjDTwoziAIFys+ajrBYoHCEO0w7uobkJgLKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfB1RO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388105AbfB1ROz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:55 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6607C218D8;
        Thu, 28 Feb 2019 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374094;
        bh=cmCVTIPmj4tsOmnUQwhRBQRZZ3OGTDK2YIQY+Ccw6n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoBnnnfF6M+yGTnMoieEKe7YQ0jlD9N/gxX1wqH6VsMp0aOT5OMBwLIbTJ+Z6LC4/
         IZ5NqnvzB6KQ0RVztpiWjEUVWfPa+n4ZKVRHgysBMq+3CWDC0UJBN/ZEtAiFN1yGV3
         imkG48b3cptjBsV86okztZVdf+EnWuvG4Jqy/eRE=
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
Subject: [PATCH 35/37] softirq: Allow to soft interrupt vector-specific masked contexts
Date:   Thu, 28 Feb 2019 18:12:40 +0100
Message-Id: <20190228171242.32144-36-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the old protections that prevented softirqs from interrupting any
softirq-disabled context. Now that we can disable specific vectors on
a given piece of code, we want to be able to soft-interrupt those places
with other vectors.

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
 kernel/softirq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index bb841e5d9951..95156afb768f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -240,7 +240,7 @@ static void local_bh_enable_ip_mask(unsigned long ip, unsigned int cnt,
 	 */
 	preempt_count_sub(cnt - 1);
 
-	if (unlikely(!in_interrupt() && softirq_pending_enabled())) {
+	if (unlikely(softirq_pending_enabled())) {
 		/*
 		 * Run softirq if any pending. And do it in its own stack
 		 * as we may be calling this deep in a task call stack already.
@@ -390,7 +390,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
 	__local_bh_enable_no_softirq(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	WARN_ON_ONCE(in_irq());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -399,7 +399,7 @@ asmlinkage __visible void do_softirq(void)
 	__u32 pending;
 	unsigned long flags;
 
-	if (in_interrupt())
+	if (in_irq())
 		return;
 
 	local_irq_save(flags);
@@ -482,7 +482,7 @@ void irq_exit(void)
 #endif
 	account_irq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && softirq_pending_enabled())
+	if (!in_irq() && softirq_pending_enabled())
 		invoke_softirq();
 
 	tick_irq_exit();
@@ -506,7 +506,7 @@ inline void raise_softirq_irqoff(unsigned int nr)
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_irq())
 		wakeup_softirqd();
 }
 
-- 
2.21.0

