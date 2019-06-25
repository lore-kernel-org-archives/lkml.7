Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18418C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC66F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfFYLYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFYLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:24:39 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfjYw-0004rC-6K; Tue, 25 Jun 2019 13:24:34 +0200
Message-Id: <20190625112405.666964552@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 13:13:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch 2/5] genirq: Add optional hardware synchronization for shutdown
References: <20190625111353.863718167@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_irq() ensures that no hardware interrupt handler is executing on a
different CPU before actually releasing resources and deactivating the
interrupt completely in a domain hierarchy.

But that does not catch the case where the interrupt is on flight at the
hardware level but not yet serviced by the target CPU. That creates an
interesing race condition:

   CPU 0                  CPU 1               IRQ CHIP

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
     release_resources()
                          do_IRQ()
                            -> resources are not available

That might be harmless and just trigger a spurious interrupt warning, but
some interrupt chips might get into a wedged state.

Provide infrastructure for interrupt chips to provide an optional
irq_inflight() callback and use it for the synchronization in free_irq().

synchronize_[hard]irq() are not using this mechanism as it might actually
deadlock unter certain conditions.

Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    2 ++
 kernel/irq/manage.c |   29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -418,6 +418,7 @@ static inline irq_hw_number_t irqd_to_hw
  *			required. This is used for CPU hotplug where the
  *			target CPU is not yet set in the cpu_online_mask.
  * @irq_retrigger:	resend an IRQ to the CPU
+ * @irq_inflight:	chip level detection of interrupts in flight (optional)
  * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
  * @irq_bus_lock:	function to lock access to slow bus (i2c) chips
@@ -462,6 +463,7 @@ struct irq_chip {
 
 	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
 	int		(*irq_retrigger)(struct irq_data *data);
+	int		(*irq_inflight)(struct irq_data *data);
 	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
 	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
 
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,8 +35,10 @@ static int __init setup_forced_irqthread
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
-static void __synchronize_hardirq(struct irq_desc *desc)
+static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
+	struct irq_data *irqd = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	bool inprogress;
 
 	do {
@@ -52,6 +54,13 @@ static void __synchronize_hardirq(struct
 		/* Ok, that indicated we're done: double-check carefully. */
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		inprogress = irqd_irq_inprogress(&desc->irq_data);
+
+		/*
+		 * If requested and supported, check at the chip whether it
+		 * is in flight at the hardware level:
+		 */
+		if (!inprogress && sync_chip && chip && chip->irq_inflight)
+			inprogress = chip->irq_inflight(irqd);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 		/* Oops, that failed? */
@@ -74,13 +83,16 @@ static void __synchronize_hardirq(struct
  *	Returns: false if a threaded handler is active.
  *
  *	This function may be called - with care - from IRQ context.
+ *
+ *	It does not check whether there is an interrupt on flight at the
+ *	hardware level, but not serviced yet, as this might deadlock.
  */
 bool synchronize_hardirq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, false);
 		return !atomic_read(&desc->threads_active);
 	}
 
@@ -97,13 +109,16 @@ EXPORT_SYMBOL(synchronize_hardirq);
  *	holding a resource the IRQ handler may need you will deadlock.
  *
  *	This function may be called - with care - from IRQ context.
+ *
+ *	It does not check whether there is an interrupt on flight at the
+ *	hardware level, but not serviced yet, as this might deadlock.
  */
 void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, false);
 		/*
 		 * We made sure that no hardirq handler is
 		 * running. Now verify that no threaded handlers are
@@ -1729,8 +1744,12 @@ static struct irqaction *__free_irq(stru
 
 	unregister_handler_proc(irq, action);
 
-	/* Make sure it's not being used on another CPU: */
-	synchronize_hardirq(irq);
+	/*
+	 * Make sure it's not being used on another CPU and if the chip
+	 * supports it also make sure that there is no (not yet serviced)
+	 * interrupt on flight at the hardware level.
+	 */
+	__synchronize_hardirq(desc, true);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*


