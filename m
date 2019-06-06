Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00034C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B0220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFFJcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:32:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbfFFJcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:32:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B862165C;
        Thu,  6 Jun 2019 02:32:14 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E80243F71D;
        Thu,  6 Jun 2019 02:32:11 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v3 4/8] arm64: Fix interrupt tracing in the presence of NMIs
Date:   Thu,  6 Jun 2019 10:31:53 +0100
Message-Id: <1559813517-41540-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
References: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the presence of any form of instrumentation, nmi_enter() should be
done before calling any traceable code and any instrumentation code.

Currently, nmi_enter() is done in handle_domain_nmi(), which is much
too late as instrumentation code might get called before. Move the
nmi_enter/exit() calls to the arch IRQ vector handler.

On arm64, it is not possible to know if the IRQ vector handler was
called because of an NMI before acknowledging the interrupt. However, It
is possible to know whether normal interrupts could be taken in the
interrupted context (i.e. if taking an NMI in that context could
introduce a potential race condition).

When interrupting a context with IRQs disabled, call nmi_enter() as soon
as possible. In contexts with IRQs enabled, defer this to the interrupt
controller, which is in a better position to know if an interrupt taken
is an NMI.

Fixes: bc3c03ccb ("arm64: Enable the support of pseudo-NMIs")
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/entry.S    | 44 +++++++++++++++++++++++++++++++++-----------
 arch/arm64/kernel/irq.c      | 17 +++++++++++++++++
 drivers/irqchip/irq-gic-v3.c |  6 ++++++
 kernel/irq/irqdesc.c         |  8 ++++++--
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 89ab6bd..46358a3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -435,6 +435,20 @@ tsk	.req	x28		// current thread_info
 	irq_stack_exit
 	.endm

+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	/*
+	 * Set res to 0 if irqs were masked in interrupted context.
+	 * Otherwise set res to non-0 value.
+	 */
+	.macro	test_irqs_unmasked res:req, pmr:req
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	sub	\res, \pmr, #GIC_PRIO_IRQON
+alternative_else
+	mov	\res, xzr
+alternative_endif
+	.endm
+#endif
+
 	.text

 /*
@@ -631,19 +645,19 @@ ENDPROC(el1_sync)
 el1_irq:
 	kernel_entry 1
 	enable_da_f
-#ifdef CONFIG_TRACE_IRQFLAGS
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	ldr	x20, [sp, #S_PMR_SAVE]
-alternative_else
-	mov	x20, #GIC_PRIO_IRQON
-alternative_endif
-	cmp	x20, #GIC_PRIO_IRQOFF
-	/* Irqs were disabled, don't trace */
-	b.ls	1f
+alternative_else_nop_endif
+	test_irqs_unmasked	res=x0, pmr=x20
+	cbz	x0, 1f
+	bl	asm_nmi_enter
+1:
 #endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
-1:
 #endif

 	irq_handler
@@ -662,14 +676,22 @@ alternative_else_nop_endif
 	bl	preempt_schedule_irq		// irq en/disable is done inside
 1:
 #endif
-#ifdef CONFIG_TRACE_IRQFLAGS
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 	/*
 	 * if IRQs were disabled when we received the interrupt, we have an NMI
 	 * and we are not re-enabling interrupt upon eret. Skip tracing.
 	 */
-	cmp	x20, #GIC_PRIO_IRQOFF
-	b.ls	1f
+	test_irqs_unmasked	res=x0, pmr=x20
+	cbz	x0, 1f
+	bl	asm_nmi_exit
+1:
+#endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	test_irqs_unmasked	res=x0, pmr=x20
+	cbnz	x0, 1f
 #endif
 	bl	trace_hardirqs_on
 1:
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 92fa817..fdd9cb2 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -27,8 +27,10 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/irqchip.h>
+#include <linux/kprobes.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <asm/daifflags.h>
 #include <asm/vmap_stack.h>

 unsigned long irq_err_count;
@@ -76,3 +78,18 @@ void __init init_IRQ(void)
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 }
+
+/*
+ * Stubs to make nmi_enter/exit() code callable from ASM
+ */
+asmlinkage void notrace asm_nmi_enter(void)
+{
+	nmi_enter();
+}
+NOKPROBE_SYMBOL(asm_nmi_enter);
+
+asmlinkage void notrace asm_nmi_exit(void)
+{
+	nmi_exit();
+}
+NOKPROBE_SYMBOL(asm_nmi_exit);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f44cd89..0bf0fc4 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -495,7 +495,13 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs

 	if (gic_supports_nmi() &&
 	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+		if (interrupts_enabled(regs))
+			nmi_enter();
+
 		gic_handle_nmi(irqnr, regs);
+
+		if (interrupts_enabled(regs))
+			nmi_exit();
 		return;
 	}

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index c52b737..a92b335 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -680,6 +680,8 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
  * @hwirq:	The HW irq number to convert to a logical one
  * @regs:	Register file coming from the low-level handling code
  *
+ *		This function must be called from an NMI context.
+ *
  * Returns:	0 on success, or -EINVAL if conversion has failed
  */
 int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
@@ -689,7 +691,10 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 	unsigned int irq;
 	int ret = 0;

-	nmi_enter();
+	/*
+	 * NMI context needs to be setup earlier in order to deal with tracing.
+	 */
+	WARN_ON(!in_nmi());

 	irq = irq_find_mapping(domain, hwirq);

@@ -702,7 +707,6 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 	else
 		ret = -EINVAL;

-	nmi_exit();
 	set_irq_regs(old_regs);
 	return ret;
 }
--
1.9.1
