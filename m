Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCBFC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E2F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfFYLZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:25:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfFYLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:24:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfjYw-0004rH-Nq; Tue, 25 Jun 2019 13:24:34 +0200
Message-Id: <20190625112405.760253024@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 13:13:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch 3/5] x86/ioapic: Implement irq_inflight() callback
References: <20190625111353.863718167@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an interrupt is shut down in free_irq() there might be an inflight
interrupt which is not yet serviced pending in the IO-APIC remote IRR. That
means the interrupt has been sent to the target CPUs local APIC, but the
target CPU is in a state which delays the servicing.

So free_irq() would proceed to free resources and to clear the vector
because synchronize_hardirq() does not see an interrupt handler in
progress.

That can trigger a spurious interrupt warning, which is harmless and just
confuses users, but it also can leave the remote IRR in a stale state
because once the handler is invoked the interrupt resources might be freed
already and therefore acknowledgement is not possible anymore.

Implement the new irq_inflight() callback for the IO-APIC irq chip. The
callback is invoked from free_irq() via __synchronize_hardirq(). Check the
remote IRR bit of the interrupt and return 'in flight' if it is set and the
interrupt is configured in level mode. For edge mode the remote IRR has no
meaning.

As this is only meaningful for level triggered interrupts this won't cure
the potential spurious interrupt warning for edge triggered interrupts, but
the edge trigger case does not result in stale hardware state. This has to
be addressed at the vector/interrupt entry level seperately.

Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1893,6 +1893,43 @@ static int ioapic_set_affinity(struct ir
 	return ret;
 }
 
+/*
+ * Interrupt shutdown masks the ioapic pin, but the interrupt might already
+ * be on flight, but not yet serviced by the target CPU. That means
+ * __synchronize_hardirq() would return and claim that everything is calmed
+ * down. So free_irq() would proceed and deactivate the interrupt and free
+ * resources.
+ *
+ * Once the target CPU comes around to service it it will find a cleared
+ * vector and complain. While the spurious interrupt is harmless, the full
+ * release of resources might prevent the interrupt from being acknowledged
+ * which keeps the hardware in a weird state.
+ *
+ * Verify that the corresponding Remote-IRR bits are clear.
+ */
+static int ioapic_irq_inflight(struct irq_data *irqd)
+{
+	struct mp_chip_data *mcd = irqd->chip_data;
+	struct IO_APIC_route_entry rentry;
+	struct irq_pin_list *p;
+	int ret = 0;
+
+	raw_spin_lock(&ioapic_lock);
+	for_each_irq_pin(p, mcd->irq_2_pin) {
+		rentry = __ioapic_read_entry(p->apic, p->pin);
+		/*
+		 * The remote IRR is only valid in level trigger mode. It's
+		 * meaning is undefined for edge triggered interrupts.
+		 */
+		if (rentry.irr && rentry.trigger) {
+			ret = 1;
+			break;
+		}
+	}
+	raw_spin_unlock(&ioapic_lock);
+	return ret;
+}
+
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name			= "IO-APIC",
 	.irq_startup		= startup_ioapic_irq,
@@ -1902,6 +1939,7 @@ static struct irq_chip ioapic_chip __rea
 	.irq_eoi		= ioapic_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_inflight		= ioapic_irq_inflight,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -1914,6 +1952,7 @@ static struct irq_chip ioapic_ir_chip __
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_inflight		= ioapic_irq_inflight,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 


