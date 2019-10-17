Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B9ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D271214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408845AbfJQKU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:20:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbfJQKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:20:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL2tK-0005xN-5a; Thu, 17 Oct 2019 12:20:22 +0200
Message-Id: <20191017101938.412489856@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 17 Oct 2019 12:19:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sebastian Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [patch 2/2] x86/ioapic: Rename misnamed functions
References: <20191017101900.925994783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioapic_irqd_[un]mask() are misnomers as both functions do way more than
masking and unmasking the interrupt line. Both deal with the moving the
affinity of the interrupt within interrupt context. The mask/unmask is just
a tiny part of the functionality.

Rename them to ioapic_prepare/finish_move(), fixup the call sites and
rename the related variables in the code to reflect what this is about.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1725,7 +1725,7 @@ static bool io_apic_level_ack_pending(st
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	/* If we are moving the irq we need to mask it */
 	if (unlikely(irqd_is_setaffinity_pending(data))) {
@@ -1736,9 +1736,9 @@ static inline bool ioapic_irqd_mask(stru
 	return false;
 }
 
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
-	if (unlikely(masked)) {
+	if (unlikely(moveit)) {
 		/* Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
@@ -1773,11 +1773,11 @@ static inline void ioapic_irqd_unmask(st
 	}
 }
 #else
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	return false;
 }
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 }
 #endif
@@ -1786,11 +1786,11 @@ static void ioapic_ack_level(struct irq_
 {
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	unsigned long v;
-	bool masked;
+	bool moveit;
 	int i;
 
 	irq_complete_move(cfg);
-	masked = ioapic_irqd_mask(irq_data);
+	moveit = ioapic_prepare_move(irq_data);
 
 	/*
 	 * It appears there is an erratum which affects at least version 0x11
@@ -1845,7 +1845,7 @@ static void ioapic_ack_level(struct irq_
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)


