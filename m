Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF0DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A753020873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfJNSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:39:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40322 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbfJNSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:38:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iK5F7-0005bM-Mt; Mon, 14 Oct 2019 20:38:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 44F311C0489;
        Mon, 14 Oct 2019 20:38:48 +0200 (CEST)
Date:   Mon, 14 Oct 2019 18:38:48 -0000
From:   "tip-bot2 for Talel Shenhar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/al-fic: Add support for irq retrigger
Cc:     Talel Shenhar <talel@amazon.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568018358-18985-1-git-send-email-talel@amazon.com>
References: <1568018358-18985-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Message-ID: <157107832821.12254.3146433351737655073.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9c426b770bd088f18899f836093d810a83b59b98
Gitweb:        https://git.kernel.org/tip/9c426b770bd088f18899f836093d810a83b59b98
Author:        Talel Shenhar <talel@amazon.com>
AuthorDate:    Mon, 09 Sep 2019 11:39:18 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 09 Sep 2019 18:11:47 +01:00

irqchip/al-fic: Add support for irq retrigger

Introduce interrupts retrigger support for Amazon's Annapurna Labs Fabric
Interrupt Controller.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1568018358-18985-1-git-send-email-talel@amazon.com
---
 drivers/irqchip/irq-al-fic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 1a57cee..0b0a737 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -15,6 +15,7 @@
 
 /* FIC Registers */
 #define AL_FIC_CAUSE		0x00
+#define AL_FIC_SET_CAUSE	0x08
 #define AL_FIC_MASK		0x10
 #define AL_FIC_CONTROL		0x28
 
@@ -126,6 +127,16 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static int al_fic_irq_retrigger(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct al_fic *fic = gc->private;
+
+	writel_relaxed(BIT(data->hwirq), fic->base + AL_FIC_SET_CAUSE);
+
+	return 1;
+}
+
 static int al_fic_register(struct device_node *node,
 			   struct al_fic *fic)
 {
@@ -159,6 +170,7 @@ static int al_fic_register(struct device_node *node,
 	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
 	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
 	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
+	gc->chip_types->chip.irq_retrigger = al_fic_irq_retrigger;
 	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
 	gc->private = fic;
 
