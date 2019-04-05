Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADBDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36D021872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfDEPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbfDEPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:27 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQV3-0005vR-0t; Fri, 05 Apr 2019 17:11:25 +0200
Message-Id: <20190405150930.787413144@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 26/29] x86/irq/32: Handle irq stack allocation failure
 proper
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_ctx_init() crashes hard on page allocation failures. While that's ok
during early boot, it's just wrong in the CPU hotplug bringup code.

Check the page allocation failure and return -ENOMEM and handle it at the
call sites. On early boot the only way out is to BUG(), but on CPU hotplug
there is no reason to crash, so just abort the operation.

Rename the function to something more sensible while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq.h |    4 ++--
 arch/x86/include/asm/smp.h |    2 +-
 arch/x86/kernel/irq_32.c   |   34 +++++++++++++++++-----------------
 arch/x86/kernel/irqinit.c  |    2 +-
 arch/x86/kernel/smpboot.c  |   15 ++++++++++++---
 arch/x86/xen/smp_pv.c      |    4 +++-
 6 files changed, 36 insertions(+), 25 deletions(-)

--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -17,9 +17,9 @@ static inline int irq_canonicalize(int i
 }
 
 #ifdef CONFIG_X86_32
-extern void irq_ctx_init(int cpu);
+extern int irq_init_percpu_irqstack(unsigned int cpu);
 #else
-# define irq_ctx_init(cpu) do { } while (0)
+static inline int irq_init_percpu_irqstack(unsigned int cpu) { return 0; }
 #endif
 
 #define __ARCH_HAS_DO_SOFTIRQ
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -131,7 +131,7 @@ void native_smp_prepare_boot_cpu(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
-void common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
+int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_disable(void);
 int common_cpu_die(unsigned int cpu);
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -107,28 +107,28 @@ static inline int execute_on_irq_stack(i
 }
 
 /*
- * allocate per-cpu stacks for hardirq and for softirq processing
+ * Allocate per-cpu stacks for hardirq and softirq processing
  */
-void irq_ctx_init(int cpu)
+int irq_init_percpu_irqstack(unsigned int cpu)
 {
-	struct irq_stack *irqstk;
+	int node = cpu_to_node(cpu);
+	struct page *ph, *ps;
 
 	if (per_cpu(hardirq_stack_ptr, cpu))
-		return;
+		return 0;
 
-	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
-					       THREADINFO_GFP,
-					       THREAD_SIZE_ORDER));
-	per_cpu(hardirq_stack_ptr, cpu) = irqstk;
-
-	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
-					       THREADINFO_GFP,
-					       THREAD_SIZE_ORDER));
-	per_cpu(softirq_stack_ptr, cpu) = irqstk;
-
-	pr_debug("CPU %u irqstacks, hard=%p soft=%p\n",
-		 cpu, per_cpu(hardirq_stack_ptr, cpu),
-		 per_cpu(softirq_stack_ptr, cpu));
+	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
+	if (!ph)
+		return -ENOMEM;
+	ps = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
+	if (!ps) {
+		__free_pages(ph, THREAD_SIZE_ORDER);
+		return -ENOMEM;
+	}
+
+	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
+	return 0;
 }
 
 void do_softirq_own_stack(void)
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -91,7 +91,7 @@ void __init init_IRQ(void)
 	for (i = 0; i < nr_legacy_irqs(); i++)
 		per_cpu(vector_irq, 0)[ISA_IRQ_VECTOR(i)] = irq_to_desc(i);
 
-	irq_ctx_init(smp_processor_id());
+	BUG_ON(irq_init_percpu_irqstack(smp_processor_id()));
 
 	x86_init.irqs.intr_init();
 }
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -935,20 +935,27 @@ wakeup_cpu_via_init_nmi(int cpu, unsigne
 	return boot_error;
 }
 
-void common_cpu_up(unsigned int cpu, struct task_struct *idle)
+int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 {
+	int ret;
+
 	/* Just in case we booted with a single CPU. */
 	alternatives_enable_smp();
 
 	per_cpu(current_task, cpu) = idle;
 
+	/* Initialize the interrupt stack(s) */
+	ret = irq_init_percpu_irqstack(cpu);
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
-	irq_ctx_init(cpu);
 	per_cpu(cpu_current_top_of_stack, cpu) = task_top_of_stack(idle);
 #else
 	initial_gs = per_cpu_offset(cpu);
 #endif
+	return 0;
 }
 
 /*
@@ -1106,7 +1113,9 @@ int native_cpu_up(unsigned int cpu, stru
 	/* the FPU context is blank, nobody can own it */
 	per_cpu(fpu_fpregs_owner_ctx, cpu) = NULL;
 
-	common_cpu_up(cpu, tidle);
+	err = common_cpu_up(cpu, tidle);
+	if (err)
+		return err;
 
 	err = do_boot_cpu(apicid, cpu, tidle, &cpu0_nmi_registered);
 	if (err) {
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -361,7 +361,9 @@ static int xen_pv_cpu_up(unsigned int cp
 {
 	int rc;
 
-	common_cpu_up(cpu, idle);
+	rc = common_cpu_up(cpu, idle);
+	if (rc)
+		return rc;
 
 	xen_setup_runstate_info(cpu);
 


