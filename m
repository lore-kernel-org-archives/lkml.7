Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5923C21872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfDEPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbfDEPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:30 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQV5-0005wN-J1; Fri, 05 Apr 2019 17:11:27 +0200
Message-Id: <20190405150930.967389183@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

The IRQ stack lives in percpu space, so an IRQ handler that overflows it
will overwrite other data structures.

Use vmap() to remap the IRQ stack so that it will have the usual guard
pages that vmap/vmalloc allocations have. With this the kernel will panic
immediately on an IRQ stack overflow.

[ tglx: Move the map code to a proper place and invoke it only when a CPU
  	is about to be brought online. No point in installing the map at
  	early boot for all possible CPUs. Fail the CPU bringup if the vmap
  	fails as done for all other preparatory stages in cpu hotplug. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq.h     |    4 ---
 arch/x86/kernel/irq_64.c       |   45 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/setup_percpu.c |    4 ---
 3 files changed, 45 insertions(+), 8 deletions(-)

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
 
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -89,3 +89,48 @@ bool handle_irq(struct irq_desc *desc, s
 	generic_handle_irq_desc(desc);
 	return true;
 }
+
+#ifdef CONFIG_VMAP_STACK
+/*
+ * VMAP the backing store with guard pages
+ */
+static int map_irq_stack(unsigned int cpu)
+{
+	char *stack = (char *)per_cpu_ptr(&irq_stack_backing_store, cpu);
+	struct page *pages[IRQ_STACK_SIZE / PAGE_SIZE];
+	void *va;
+	int i;
+
+	for (i = 0; i < IRQ_STACK_SIZE / PAGE_SIZE; i++) {
+		phys_addr_t pa = per_cpu_ptr_to_phys(stack + (i << PAGE_SHIFT));
+
+		pages[i] = pfn_to_page(pa >> PAGE_SHIFT);
+	}
+
+	va = vmap(pages, IRQ_STACK_SIZE / PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+	if (!va)
+		return -ENOMEM;
+
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	return 0;
+}
+#else
+/*
+ * If VMAP stacks are disabled due to KASAN, just use the per cpu
+ * backing store without guard pages.
+ */
+static int map_irq_stack(unsigned int cpu)
+{
+	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
+
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	return 0;
+}
+#endif
+
+int irq_init_percpu_irqstack(unsigned int cpu)
+{
+	if (per_cpu(hardirq_stack_ptr, cpu))
+		return 0;
+	return map_irq_stack(cpu);
+}
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -244,10 +244,6 @@ void __init setup_per_cpu_areas(void)
 		per_cpu(x86_cpu_to_logical_apicid, cpu) =
 			early_per_cpu_map(x86_cpu_to_logical_apicid, cpu);
 #endif
-#ifdef CONFIG_X86_64
-		per_cpu(hardirq_stack_ptr, cpu) = (struct irq_stack *)
-			per_cpu_ptr(&irq_stack_backing_store, cpu) + 1;
-#endif
 #ifdef CONFIG_NUMA
 		per_cpu(x86_cpu_to_node_map, cpu) =
 			early_per_cpu_map(x86_cpu_to_node_map, cpu);


