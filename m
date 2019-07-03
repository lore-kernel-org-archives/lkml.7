Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85188C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C22184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zuRQgDTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfGCIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:18:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfGCISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:18:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638IGQh3200764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:18:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638IGQh3200764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562141896;
        bh=vp+CaGX8omwfOenrCtnhfcI6zKh5+zB0SXwKe1LMHaU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zuRQgDTd2Y9ImQk8U0kUDqxhT8UB9KygpmMnDEMsUU9vO1AYD4fkQTLWb0dD8M1Re
         nq7El7+NnZR/u9PsPHx+mxvwo3Nfv7z038zmFAum+Jv1zRR7L/SSusxuXTo2gYDyGY
         r4tyVjHL9ZK0QghAVC3vs/NEp5mzAX1Kd4YWYqzQux60O5jZpHGpbUsHHIi1My4GPT
         SJe/o99Is6Fy8qK4UKno+59yvypHukTCdmKTzrawrOLPSggN5VONpZa6TUJEZBXnM8
         bMYi896Azb8uGlEKb2s/J4ucVtfS3GYMNePACypC4tkUF4sTRwfs6B0moKGt22CLKI
         qvW1DK783pznw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638IFv33200759;
        Wed, 3 Jul 2019 01:18:15 -0700
Date:   Wed, 3 Jul 2019 01:18:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-dfe0cf8b51b07e56ded571e3de0a4a9382517231@git.kernel.org>
Cc:     tglx@linutronix.de, marc.zyngier@arm.com, hpa@zytor.com,
        mingo@kernel.org, Robert.Hodaszi@digi.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          marc.zyngier@arm.com, Robert.Hodaszi@digi.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190628111440.370295517@linutronix.de>
References: <20190628111440.370295517@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/ioapic: Implement irq_get_irqchip_state()
 callback
Git-Commit-ID: dfe0cf8b51b07e56ded571e3de0a4a9382517231
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dfe0cf8b51b07e56ded571e3de0a4a9382517231
Gitweb:     https://git.kernel.org/tip/dfe0cf8b51b07e56ded571e3de0a4a9382517231
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 13:11:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:12:30 +0200

x86/ioapic: Implement irq_get_irqchip_state() callback

When an interrupt is shut down in free_irq() there might be an inflight
interrupt pending in the IO-APIC remote IRR which is not yet serviced. That
means the interrupt has been sent to the target CPUs local APIC, but the
target CPU is in a state which delays the servicing.

So free_irq() would proceed to free resources and to clear the vector
because synchronize_hardirq() does not see an interrupt handler in
progress.

That can trigger a spurious interrupt warning, which is harmless and just
confuses users, but it also can leave the remote IRR in a stale state
because once the handler is invoked the interrupt resources might be freed
already and therefore acknowledgement is not possible anymore.

Implement the irq_get_irqchip_state() callback for the IO-APIC irq chip. The
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
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190628111440.370295517@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1bb864798800..c7bb6c69f21c 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1894,6 +1894,50 @@ static int ioapic_set_affinity(struct irq_data *irq_data,
 	return ret;
 }
 
+/*
+ * Interrupt shutdown masks the ioapic pin, but the interrupt might already
+ * be in flight, but not yet serviced by the target CPU. That means
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
+static int ioapic_irq_get_chip_state(struct irq_data *irqd,
+				   enum irqchip_irq_state which,
+				   bool *state)
+{
+	struct mp_chip_data *mcd = irqd->chip_data;
+	struct IO_APIC_route_entry rentry;
+	struct irq_pin_list *p;
+
+	if (which != IRQCHIP_STATE_ACTIVE)
+		return -EINVAL;
+
+	*state = false;
+	raw_spin_lock(&ioapic_lock);
+	for_each_irq_pin(p, mcd->irq_2_pin) {
+		rentry = __ioapic_read_entry(p->apic, p->pin);
+		/*
+		 * The remote IRR is only valid in level trigger mode. It's
+		 * meaning is undefined for edge triggered interrupts and
+		 * irrelevant because the IO-APIC treats them as fire and
+		 * forget.
+		 */
+		if (rentry.irr && rentry.trigger) {
+			*state = true;
+			break;
+		}
+	}
+	raw_spin_unlock(&ioapic_lock);
+	return 0;
+}
+
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name			= "IO-APIC",
 	.irq_startup		= startup_ioapic_irq,
@@ -1903,6 +1947,7 @@ static struct irq_chip ioapic_chip __read_mostly = {
 	.irq_eoi		= ioapic_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -1915,6 +1960,7 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
