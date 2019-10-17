Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF7FA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48816214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408838AbfJQKUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:20:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfJQKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:20:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL2tJ-0005xE-Sm; Thu, 17 Oct 2019 12:20:21 +0200
Message-Id: <20191017101938.321393687@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 17 Oct 2019 12:19:01 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sebastian Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [patch 1/2] x86/ioapic: Prevent inconsistent state when moving an
 interrupt
References: <20191017101900.925994783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an issue with threaded interrupts which are marked ONESHOT
and using the fasteoi handler.

  if (IS_ONESHOT())
    mask_irq();
  ....
  cond_unmask_eoi_irq()
    chip->irq_eoi();
      if (setaffinity_pending) {
         mask_ioapic();
         ...
	 move_affinity();
	 unmask_ioapic();
      }

So if setaffinity is pending the interrupt will be moved and then
unconditionally unmasked at the ioapic level, which is wrong in two
aspects:

 1) It should be kept masked up to the point where the threaded handler
    finished.

 2) The physical chip state and the software masked state are inconsistent

Guard both the mask and the unmask with a check for the software masked
state. If the line is marked masked then the ioapic line is also masked, so
both mask_ioapic() and unmask_ioapic() can be skipped safely.

Fixes: 3aa551c9b4c4 ("genirq: add threaded interrupt handler support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1729,7 +1729,8 @@ static inline bool ioapic_irqd_mask(stru
 {
 	/* If we are moving the irq we need to mask it */
 	if (unlikely(irqd_is_setaffinity_pending(data))) {
-		mask_ioapic_irq(data);
+		if (!irqd_irq_masked(data))
+			mask_ioapic_irq(data);
 		return true;
 	}
 	return false;
@@ -1766,7 +1767,9 @@ static inline void ioapic_irqd_unmask(st
 		 */
 		if (!io_apic_level_ack_pending(data->chip_data))
 			irq_move_masked_irq(data);
-		unmask_ioapic_irq(data);
+		/* If the irq is masked in the core, leave it */
+		if (!irqd_irq_masked(data))
+			unmask_ioapic_irq(data);
 	}
 }
 #else


