Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C0FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1B2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfDNQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:03:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfDNQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:03:21 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhbC-0002lV-D2; Sun, 14 Apr 2019 18:03:18 +0200
Message-Id: <20190414160146.466354762@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 18:00:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 32/32] x86/irq/64: Remove stack overflow debug code
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All stack types on x86 64-bit have guard pages now.

So there is no point in executing probabilistic overflow checks as the
guard pages are a accurate and reliable overflow prevention.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig         |    2 -
 arch/x86/kernel/irq_64.c |   56 -----------------------------------------------
 2 files changed, 1 insertion(+), 57 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,6 +14,7 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select HAVE_DEBUG_STACKOVERFLOW
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
 
@@ -138,7 +139,6 @@ config X86
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,64 +26,8 @@
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
-int sysctl_panic_on_stackoverflow;
-
-/*
- * Probabilistic stack overflow check:
- *
- * Regular device interrupts can enter on the following stacks:
- *
- * - User stack
- *
- * - Kernel task stack
- *
- * - Interrupt stack if a device driver reenables interrupts
- *   which should only happen in really old drivers.
- *
- * - Debug IST stack
- *
- * All other contexts are invalid.
- */
-static inline void stack_overflow_check(struct pt_regs *regs)
-{
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
-#define STACK_MARGIN	128
-	u64 irq_stack_top, irq_stack_bottom, estack_top, estack_bottom;
-	u64 curbase = (u64)task_stack_page(current);
-	struct cea_exception_stacks *estacks;
-
-	if (user_mode(regs))
-		return;
-
-	if (regs->sp >= curbase + sizeof(struct pt_regs) + STACK_MARGIN &&
-	    regs->sp <= curbase + THREAD_SIZE)
-		return;
-
-	irq_stack_top = (u64)__this_cpu_read(hardirq_stack_ptr);
-	irq_stack_bottom = irq_stack_top - IRQ_STACK_SIZE + STACK_MARGIN;
-	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
-		return;
-
-	estacks = __this_cpu_read(cea_exception_stacks);
-	estack_top = CEA_ESTACK_TOP(estacks, DB);
-	estack_bottom = CEA_ESTACK_BOT(estacks, DB) + STACK_MARGIN;
-	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
-		return;
-
-	WARN_ONCE(1, "do_IRQ(): %s has overflown the kernel stack (cur:%Lx,sp:%lx, irq stack:%Lx-%Lx, exception stack: %Lx-%Lx, ip:%pF)\n",
-		current->comm, curbase, regs->sp,
-		irq_stack_bottom, irq_stack_top,
-		estack_bottom, estack_top, (void *)regs->ip);
-
-	if (sysctl_panic_on_stackoverflow)
-		panic("low stack detected by irq handler - check messages\n");
-#endif
-}
-
 bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
-	stack_overflow_check(regs);
-
 	if (IS_ERR_OR_NULL(desc))
 		return false;
 


