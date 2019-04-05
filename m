Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921B21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfDEPL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48941 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbfDEPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUz-0005uI-LH; Fri, 05 Apr 2019 17:11:21 +0200
Message-Id: <20190405150930.500775703@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 23/29] x86/irq/32: Rename hard/softirq_stack to
 hard/softirq_stack_ptr
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu storage holds a pointer to the stack not the stack
itself. Rename it before sharing struct irq_stack with 64-bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    4 ++--
 arch/x86/kernel/dumpstack_32.c   |    4 ++--
 arch/x86/kernel/irq_32.c         |   19 ++++++++++---------
 3 files changed, 14 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -425,8 +425,8 @@ struct irq_stack {
 	char			stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack);
-DECLARE_PER_CPU(struct irq_stack *, softirq_stack);
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* X86_64 */
 
 extern unsigned int fpu_kernel_xstate_size;
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -34,7 +34,7 @@ const char *stack_type_name(enum stack_t
 
 static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack);
+	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
@@ -59,7 +59,7 @@ static bool in_hardirq_stack(unsigned lo
 
 static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack);
+	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -51,8 +51,8 @@ static inline int check_stack_overflow(v
 static inline void print_stack_overflow(void) { }
 #endif
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack);
-DEFINE_PER_CPU(struct irq_stack *, softirq_stack);
+DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+DEFINE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 
 static void call_on_stack(void *func, void *stack)
 {
@@ -76,7 +76,7 @@ static inline int execute_on_irq_stack(i
 	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(hardirq_stack);
+	irqstk = __this_cpu_read(hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -113,21 +113,22 @@ void irq_ctx_init(int cpu)
 {
 	struct irq_stack *irqstk;
 
-	if (per_cpu(hardirq_stack, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return;
 
 	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
 					       THREADINFO_GFP,
 					       THREAD_SIZE_ORDER));
-	per_cpu(hardirq_stack, cpu) = irqstk;
+	per_cpu(hardirq_stack_ptr, cpu) = irqstk;
 
 	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
 					       THREADINFO_GFP,
 					       THREAD_SIZE_ORDER));
-	per_cpu(softirq_stack, cpu) = irqstk;
+	per_cpu(softirq_stack_ptr, cpu) = irqstk;
 
-	printk(KERN_DEBUG "CPU %u irqstacks, hard=%p soft=%p\n",
-	       cpu, per_cpu(hardirq_stack, cpu),  per_cpu(softirq_stack, cpu));
+	pr_debug("CPU %u irqstacks, hard=%p soft=%p\n",
+		 cpu, per_cpu(hardirq_stack_ptr, cpu),
+		 per_cpu(softirq_stack_ptr, cpu));
 }
 
 void do_softirq_own_stack(void)
@@ -135,7 +136,7 @@ void do_softirq_own_stack(void)
 	struct irq_stack *irqstk;
 	u32 *isp, *prev_esp;
 
-	irqstk = __this_cpu_read(softirq_stack);
+	irqstk = __this_cpu_read(softirq_stack_ptr);
 
 	/* build the stack frame on the softirq stack */
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));


