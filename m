Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED35AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221F2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfDNQDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:03:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfDNQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:03:19 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhbB-0002lG-AT; Sun, 14 Apr 2019 18:03:17 +0200
Message-Id: <20190414160146.363733568@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 18:00:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 31/32] x86/irq/64: Remap the IRQ stack with guard pages
References: <20190414155936.679808307@linutronix.de>
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
 arch/x86/kernel/irq_64.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -91,6 +91,35 @@ bool handle_irq(struct irq_desc *desc, s
 	return true;
 }
 
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
 static int map_irq_stack(unsigned int cpu)
 {
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
@@ -98,6 +127,7 @@ static int map_irq_stack(unsigned int cp
 	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
 	return 0;
 }
+#endif
 
 int irq_init_percpu_irqstack(unsigned int cpu)
 {


