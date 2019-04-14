Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACDC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8352084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfDNQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:03:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfDNQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:03:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhb5-0002jo-6t; Sun, 14 Apr 2019 18:03:11 +0200
Message-Id: <20190414160145.912584074@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 18:00:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 26/32] x86/irq/64: Rename irq_stack_ptr to hardirq_stack_ptr
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory patch to share code with 32bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S        |    2 +-
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 arch/x86/kernel/dumpstack_64.c   |    2 +-
 arch/x86/kernel/irq_64.c         |    2 +-
 arch/x86/kernel/setup_percpu.c   |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -431,7 +431,7 @@ END(irq_entries_start)
 	 */
 
 	movq	\old_rsp, PER_CPU_VAR(irq_stack_union + IRQ_STACK_SIZE - 8)
-	movq	PER_CPU_VAR(irq_stack_ptr), %rsp
+	movq	PER_CPU_VAR(hardirq_stack_ptr), %rsp
 
 #ifdef CONFIG_DEBUG_ENTRY
 	/*
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -396,7 +396,7 @@ static inline unsigned long cpu_kernelmo
 	return (unsigned long)per_cpu(irq_stack_union.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(char *, irq_stack_ptr);
+DECLARE_PER_CPU(char *, hardirq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,7 +1510,7 @@ DEFINE_PER_CPU(struct task_struct *, cur
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(char *, irq_stack_ptr) =
+DEFINE_PER_CPU(char *, hardirq_stack_ptr) =
 	init_per_cpu_var(irq_stack_union.irq_stack) + IRQ_STACK_SIZE;
 
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -120,7 +120,7 @@ static bool in_exception_stack(unsigned
 
 static bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end   = (unsigned long *)this_cpu_read(irq_stack_ptr);
+	unsigned long *end   = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *begin = end - (IRQ_STACK_SIZE / sizeof(long));
 
 	/*
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -56,7 +56,7 @@ static inline void stack_overflow_check(
 	    regs->sp <= curbase + THREAD_SIZE)
 		return;
 
-	irq_stack_top = (u64)__this_cpu_read(irq_stack_ptr);
+	irq_stack_top = (u64)__this_cpu_read(hardirq_stack_ptr);
 	irq_stack_bottom = irq_stack_top - IRQ_STACK_SIZE + STACK_MARGIN;
 	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
 		return;
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -245,7 +245,7 @@ void __init setup_per_cpu_areas(void)
 			early_per_cpu_map(x86_cpu_to_logical_apicid, cpu);
 #endif
 #ifdef CONFIG_X86_64
-		per_cpu(irq_stack_ptr, cpu) =
+		per_cpu(hardirq_stack_ptr, cpu) =
 			per_cpu(irq_stack_union.irq_stack, cpu) +
 			IRQ_STACK_SIZE;
 #endif


