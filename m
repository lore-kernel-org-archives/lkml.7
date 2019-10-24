Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FFFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF6B2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406141AbfJXQFE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:05:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405273AbfJXQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:05:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iNfbe-00029v-FV; Thu, 24 Oct 2019 18:04:58 +0200
Date:   Thu, 24 Oct 2019 18:04:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tglx@linutronix.de, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 03/34 v3] powerpc: Use CONFIG_PREEMPTION
Message-ID: <20191024160458.vlnf3wlcyjl2ich7@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-4-bigeasy@linutronix.de>
 <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
 <87d0ext4q3.fsf@mpe.ellerman.id.au>
 <20191024135920.cp673ivbcomu2bgy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191024135920.cp673ivbcomu2bgy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2…v3: Don't mention die.c changes in the description.
v1…v2: Remove the changes to die.c.

 arch/powerpc/Kconfig           | 2 +-
 arch/powerpc/kernel/entry_32.S | 4 ++--
 arch/powerpc/kernel/entry_64.S | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3e56c9c2f16ee..8ead8d6e1cbc8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -106,7 +106,7 @@ config LOCKDEP_SUPPORT
 config GENERIC_LOCKBREAK
 	bool
 	default y
-	depends on SMP && PREEMPT
+	depends on SMP && PREEMPTION
 
 config GENERIC_HWEIGHT
 	bool
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index d60908ea37fb9..e1a4c39b83b86 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -897,7 +897,7 @@ user_exc_return:		/* r10 contains MSR_KERNEL here */
 	bne-	0b
 1:
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	/* check current_thread_info->preempt_count */
 	lwz	r0,TI_PREEMPT(r2)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
@@ -921,7 +921,7 @@ user_exc_return:		/* r10 contains MSR_KERNEL here */
 	 */
 	bl	trace_hardirqs_on
 #endif
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 restore_kuap:
 	kuap_restore r1, r2, r9, r10, r0
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6467bdab8d405..83733376533e8 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -840,7 +840,7 @@ _GLOBAL(ret_from_except_lite)
 	bne-	0b
 1:
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	/* Check if we need to preempt */
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq+	restore
@@ -871,7 +871,7 @@ _GLOBAL(ret_from_except_lite)
 	li	r10,MSR_RI
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 	.globl	fast_exc_return_irq
 fast_exc_return_irq:
-- 
2.23.0

