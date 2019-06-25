Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46873C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241A8215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfFYLYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:24:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbfFYLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:24:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfjYx-0004rM-7d; Tue, 25 Jun 2019 13:24:35 +0200
Message-Id: <20190625112405.853334981@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 13:13:57 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch 4/5] x86/irq: Handle spurious interrupt after shutdown
 gracefully
References: <20190625111353.863718167@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the rework of the vector management, warnings about spurious
interrupts have been reported. Robert provided some more information and
did an initial analysis. The following situation leads to these warnings:

   CPU 0                  CPU 1               IO_APIC

                                              interrupt is raised
                                              sent to CPU1
			  Unable to handle
			  immediately
			  (interrupts off,
			   deep idle delay)
   mask()
   ...
   free()
     shutdown()
     synchronize_irq()
     clear_vector()
                          do_IRQ()
                            -> vector is clear

Before the rework the vector entries of legacy interrupts were statically
assigned and occupied precious vector space while most of them were
unused. Due to that the above situation was handled silently because the
vector was handled and the core handler of the assigned interrupt
descriptor noticed that it is shut down and returned.

While this has been usually observed with legacy interrupts, this situation
is not limited to them. Any other interrupt source, e.g. MSI, can cause the
same issue.

After adding proper synchronization for level triggered interrupts, this
can only happen for edge triggered interrupts where the IO-APIC obviously
cannot provide information about interrupts in flight.

While the spurious warning is actually harmless in this case it worries
users and driver developers.

Handle it gracefully by marking the vector entry as VECTOR_SHUTDOWN instead
of VECTOR_UNUSED when the vector is freed up.

If that above late handling happens the spurious detector will not complain
and switch the entry to VECTOR_UNUSED. Any subsequent spurious interrupt on
that line will trigger the spurious warning as before.

Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hw_irq.h |    3 ++-
 arch/x86/kernel/apic/vector.c |    4 ++--
 arch/x86/kernel/irq.c         |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -151,7 +151,8 @@ extern char irq_entries_start[];
 #endif
 
 #define VECTOR_UNUSED		NULL
-#define VECTOR_RETRIGGERED	((void *)~0UL)
+#define VECTOR_SHUTDOWN		((void *)~0UL)
+#define VECTOR_RETRIGGERED	((void *)~1UL)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -340,7 +340,7 @@ static void clear_irq_vector(struct irq_
 	trace_vector_clear(irqd->irq, vector, apicd->cpu, apicd->prev_vector,
 			   apicd->prev_cpu);
 
-	per_cpu(vector_irq, apicd->cpu)[vector] = VECTOR_UNUSED;
+	per_cpu(vector_irq, apicd->cpu)[vector] = VECTOR_SHUTDOWN;
 	irq_matrix_free(vector_matrix, apicd->cpu, vector, managed);
 	apicd->vector = 0;
 
@@ -349,7 +349,7 @@ static void clear_irq_vector(struct irq_
 	if (!vector)
 		return;
 
-	per_cpu(vector_irq, apicd->prev_cpu)[vector] = VECTOR_UNUSED;
+	per_cpu(vector_irq, apicd->prev_cpu)[vector] = VECTOR_SHUTDOWN;
 	irq_matrix_free(vector_matrix, apicd->prev_cpu, vector, managed);
 	apicd->prev_vector = 0;
 	apicd->move_in_progress = 0;
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -247,7 +247,7 @@ u64 arch_irq_stat(void)
 	if (!handle_irq(desc, regs)) {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED) {
+		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);


