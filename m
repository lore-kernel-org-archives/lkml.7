Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF6C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5945216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfIPNiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:38:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733276AbfIPNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:37:59 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rCW-0006vm-FG; Mon, 16 Sep 2019 15:37:56 +0200
Date:   Mon, 16 Sep 2019 13:30:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/irq for 5.4-rc1
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
Message-ID: <156864062019.3407.15459445078519188901.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-irq-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus

up to:  8725fcd99a30: x86/irq: Check for VECTOR_UNUSED directly

A small set of changes to simplify and improve the interrupt handling in
do_IRQ() by moving the common case into common code and thereby cleaning it
up.

Thanks,

	tglx

------------------>
Heiner Kallweit (3):
      x86/irq: Improve definition of VECTOR_SHUTDOWN et al
      x86/irq: Move IS_ERR_OR_NULL() check into common do_IRQ() code
      x86/irq: Check for VECTOR_UNUSED directly


 arch/x86/include/asm/hw_irq.h |  4 ++--
 arch/x86/include/asm/irq.h    |  2 +-
 arch/x86/kernel/irq.c         | 10 +++++++---
 arch/x86/kernel/irq_32.c      |  7 +------
 arch/x86/kernel/irq_64.c      |  9 ---------
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index cbd97e22d2f3..4154bc5f6a4e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -153,8 +153,8 @@ extern char irq_entries_start[];
 extern char spurious_entries_start[];
 
 #define VECTOR_UNUSED		NULL
-#define VECTOR_SHUTDOWN		((void *)~0UL)
-#define VECTOR_RETRIGGERED	((void *)~1UL)
+#define VECTOR_SHUTDOWN		((void *)-1L)
+#define VECTOR_RETRIGGERED	((void *)-2L)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 8f95686ec27e..a176f6165d85 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -34,7 +34,7 @@ extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 extern void (*x86_platform_ipi_callback)(void);
 extern void native_init_IRQ(void);
 
-extern bool handle_irq(struct irq_desc *desc, struct pt_regs *regs);
+extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern __visible unsigned int do_IRQ(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 4215653f8a8e..21efee32e2b1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -243,11 +243,15 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
 	desc = __this_cpu_read(vector_irq[vector]);
-
-	if (!handle_irq(desc, regs)) {
+	if (likely(!IS_ERR_OR_NULL(desc))) {
+		if (IS_ENABLED(CONFIG_X86_32))
+			handle_irq(desc, regs);
+		else
+			generic_handle_irq_desc(desc);
+	} else {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
+		if (desc == VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index fc34816c6f04..a759ca97cd01 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -148,18 +148,13 @@ void do_softirq_own_stack(void)
 	call_on_stack(__do_softirq, isp);
 }
 
-bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
+void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
 	int overflow = check_stack_overflow();
 
-	if (IS_ERR_OR_NULL(desc))
-		return false;
-
 	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc)) {
 		if (unlikely(overflow))
 			print_stack_overflow();
 		generic_handle_irq_desc(desc);
 	}
-
-	return true;
 }
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 6bf6517a05bb..12df3a4abfdd 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,15 +26,6 @@
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
-bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
-{
-	if (IS_ERR_OR_NULL(desc))
-		return false;
-
-	generic_handle_irq_desc(desc);
-	return true;
-}
-
 #ifdef CONFIG_VMAP_STACK
 /*
  * VMAP the backing store with guard pages


