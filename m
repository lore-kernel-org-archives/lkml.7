Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70F920663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405704AbfJXKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:13:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391927AbfJXKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:13:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iNa7E-0002oh-6Z; Thu, 24 Oct 2019 12:13:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B9EF21C0087;
        Thu, 24 Oct 2019 12:13:11 +0200 (CEST)
Date:   Thu, 24 Oct 2019 10:13:11 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Rename misnamed functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191017101938.412489856@linutronix.de>
References: <20191017101938.412489856@linutronix.de>
MIME-Version: 1.0
Message-ID: <157191199146.29376.13205140020620411699.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2579a4eefc04d1c23eef8f3f0db3309f955e5792
Gitweb:        https://git.kernel.org/tip/2579a4eefc04d1c23eef8f3f0db3309f955e5792
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 17 Oct 2019 12:19:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Oct 2019 12:09:21 +02:00

x86/ioapic: Rename misnamed functions

ioapic_irqd_[un]mask() are misnomers as both functions do way more than
masking and unmasking the interrupt line. Both deal with the moving the
affinity of the interrupt within interrupt context. The mask/unmask is just
a tiny part of the functionality.

Rename them to ioapic_prepare/finish_move(), fixup the call sites and
rename the related variables in the code to reflect what this is about.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20191017101938.412489856@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index f0262cb..913c886 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1725,7 +1725,7 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	/* If we are moving the IRQ we need to mask it */
 	if (unlikely(irqd_is_setaffinity_pending(data))) {
@@ -1736,9 +1736,9 @@ static inline bool ioapic_irqd_mask(struct irq_data *data)
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
@@ -1773,11 +1773,11 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
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
@@ -1786,11 +1786,11 @@ static void ioapic_ack_level(struct irq_data *irq_data)
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
@@ -1845,7 +1845,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)
