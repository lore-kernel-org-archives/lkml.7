Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECDEC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B552175B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfDNQDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:03:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfDNQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:03:16 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhb9-0002ko-5p; Sun, 14 Apr 2019 18:03:15 +0200
Message-Id: <20190414160146.177558566@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 18:00:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 29/32] x86/irq/64: Init hardirq_stack_ptr during CPU hotplug
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory change for distangling the irq stack union as a prerequisite
for irq stacks with guard pages.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq.h   |    4 ----
 arch/x86/kernel/cpu/common.c |    4 +---
 arch/x86/kernel/irq_64.c     |   15 +++++++++++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -16,11 +16,7 @@ static inline int irq_canonicalize(int i
 	return ((irq == 2) ? 9 : irq);
 }
 
-#ifdef CONFIG_X86_32
 extern int irq_init_percpu_irqstack(unsigned int cpu);
-#else
-static inline int irq_init_percpu_irqstack(unsigned int cpu) { return 0; }
-#endif
 
 #define __ARCH_HAS_DO_SOFTIRQ
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,9 +1510,7 @@ DEFINE_PER_CPU(struct task_struct *, cur
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(char *, hardirq_stack_ptr) =
-	init_per_cpu_var(irq_stack_union.irq_stack) + IRQ_STACK_SIZE;
-
+DEFINE_PER_CPU(char *, hardirq_stack_ptr);
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -87,3 +87,18 @@ bool handle_irq(struct irq_desc *desc, s
 	generic_handle_irq_desc(desc);
 	return true;
 }
+
+static int map_irq_stack(unsigned int cpu)
+{
+	void *va = per_cpu_ptr(irq_stack_union.irq_stack, cpu);
+
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	return 0;
+}
+
+int irq_init_percpu_irqstack(unsigned int cpu)
+{
+	if (per_cpu(hardirq_stack_ptr, cpu))
+		return 0;
+	return map_irq_stack(cpu);
+}


