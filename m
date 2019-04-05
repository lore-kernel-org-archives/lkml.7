Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17708C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F96218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfDEPLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbfDEPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:31 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQV6-0005wt-QP; Fri, 05 Apr 2019 17:11:29 +0200
Message-Id: <20190405150931.058204303@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 29/29] x86/irq/64: Remove stack overflow debug code
References: <20190405150658.237064784@linutronix.de>
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
@@ -25,64 +25,8 @@
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 
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
 


