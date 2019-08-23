Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA42C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9965023404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbfHWBzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:55:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbfHWBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:55:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0ynV-0000h3-TO; Fri, 23 Aug 2019 03:55:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 79DEE1C0883;
        Fri, 23 Aug 2019 03:55:25 +0200 (CEST)
Date:   Fri, 23 Aug 2019 01:55:25 -0000
From:   tip-bot2 for Heiner Kallweit <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Move IS_ERR_OR_NULL() check into common
 do_IRQ() code
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <2ec758c7-9aaa-73ab-f083-cc44c86aa741@gmail.com>
References: <2ec758c7-9aaa-73ab-f083-cc44c86aa741@gmail.com>
MIME-Version: 1.0
Message-ID: <156652532539.10816.4131841639058979430.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     d6f83427ff422b3a65e4a6bd84c010f78d4a30a5
Gitweb:        https://git.kernel.org/tip/d6f83427ff422b3a65e4a6bd84c010f78d4a30a5
Author:        Heiner Kallweit <hkallweit1@gmail.com>
AuthorDate:    Mon, 19 Aug 2019 21:36:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Aug 2019 23:19:06 +02:00

x86/irq: Move IS_ERR_OR_NULL() check into common do_IRQ() code

Both the 64bit and the 32bit handle_irq() implementation check the irq
descriptor pointer with IS_ERR_OR_NULL() and return failure. That can be
done simpler in the common do_IRQ() code.

This reduces the 64bit handle_irq() function to a wrapper around
generic_handle_irq_desc(). Invoke it directly from do_IRQ() to spare the
extra function call.

[ tglx: Got rid of the #ifdef and massaged changelog ]

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/2ec758c7-9aaa-73ab-f083-cc44c86aa741@gmail.com

---
 arch/x86/include/asm/irq.h |  2 +-
 arch/x86/kernel/irq.c      |  8 ++++++--
 arch/x86/kernel/irq_32.c   |  7 +------
 arch/x86/kernel/irq_64.c   |  9 ---------
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 8f95686..a176f61 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -34,7 +34,7 @@ extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 extern void (*x86_platform_ipi_callback)(void);
 extern void native_init_IRQ(void);
 
-extern bool handle_irq(struct irq_desc *desc, struct pt_regs *regs);
+extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern __visible unsigned int do_IRQ(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 4215653..3eae012 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -243,8 +243,12 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
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
 
 		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index fc34816..a759ca9 100644
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
index 6bf6517..12df3a4 100644
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
