Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D44C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC6F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374149;
	bh=nyU7f1j1y8U6MFpJsCgqHeNjktS6y3H58NEAfktKKug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jOQhCBftROveuw0MsYGoLgGF6q01sR4777LqQrD5QVbJrqqo81iRmxwzxs+DQXMAY
	 OnSOnsBlWH2ldge1ecTxAlcw13Aza9UgVOpoNSoIDuMHtkcDmlb//MdXM1uwH17sJm
	 tvzBIUv1AndJJn7WxrtdMmFBan+wYviS1NVmpZuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfB1RPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbfB1RN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:58 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E713218D8;
        Thu, 28 Feb 2019 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374037;
        bh=nyU7f1j1y8U6MFpJsCgqHeNjktS6y3H58NEAfktKKug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+zPLkvjLaYvMJcGKFBXoAVwvxCKWDtqZdW0NzHN8rXkJCk8/O8geZgZI132hLT3G
         PyNdcFs+V/HSg8N4mr2eW1jtCrPE5oA9dxRaX9D8LU3bGEnpCYwYRCE79tahN8tyiL
         3gWDaBLqeQAqjFteAHE4nJPyPqfYKU1tUVZngwJU=
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
Subject: [PATCH 19/37] softirq: Convert softirq_pending_*() to set/clear mask scheme
Date:   Thu, 28 Feb 2019 18:12:24 +0100
Message-Id: <20190228171242.32144-20-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to need a nand version of softirq_pending_or() in order
to clear specific bits from the pending mask.

But instead of naming the mutators after their implementation, rather
name them after their high level purpose.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
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
 arch/s390/include/asm/hardirq.h | 4 ++--
 include/linux/interrupt.h       | 5 +++--
 kernel/softirq.c                | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 3103680487cf..54e81f520175 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -14,8 +14,8 @@
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_data)
-#define softirq_pending_set(x) (S390_lowcore.softirq_data = (x))
-#define softirq_pending_or(x)  (S390_lowcore.softirq_data |= (x))
+#define softirq_pending_clear_mask(x) (S390_lowcore.softirq_data &= ~(x))
+#define softirq_pending_set_mask(x)  (S390_lowcore.softirq_data |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a5dec926531b..c402770ae45b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -472,6 +472,7 @@ enum
 };
 
 #define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
+#define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
 
 #ifndef local_softirq_pending
 
@@ -480,8 +481,8 @@ enum
 #endif
 
 #define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
-#define softirq_pending_set(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
-#define softirq_pending_or(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
+#define softirq_pending_clear_mask(x)	(__this_cpu_and(local_softirq_data_ref, ~(x)))
+#define softirq_pending_set_mask(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
 
 #endif /* local_softirq_pending */
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2137c54baf98..5f167fc43ab9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -268,7 +268,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	softirq_pending_set(0);
+	softirq_pending_clear_mask(SOFTIRQ_ALL_MASK);
 
 	local_irq_enable();
 
@@ -449,7 +449,7 @@ void raise_softirq(unsigned int nr)
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	trace_softirq_raise(nr);
-	softirq_pending_or(1UL << nr);
+	softirq_pending_set_mask(1UL << nr);
 }
 
 void open_softirq(int nr, void (*action)(struct softirq_action *))
-- 
2.21.0

