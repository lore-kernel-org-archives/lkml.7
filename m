Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4312DC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50120859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfDVEsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:48:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDVEsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:48:35 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hIQpt-0001y2-By; Mon, 22 Apr 2019 04:45:47 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linus.walleij@linaro.org, hotwater438@tutanota.com,
        hdegoede@redhat.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
Date:   Mon, 22 Apr 2019 12:45:39 +0800
Message-Id: <20190422044539.16085-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a939bb57cd47 ("pinctrl: intel: implement gpio_irq_enable") was
added because clearing interrupt status bit is required to avoid
unexpected behavior.

Turns out the unmask callback also needs the fix, which can solve weird
IRQ triggering issues on I2C touchpad ELAN1200.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 35 ++++-----------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3b1818184207..53878604537e 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -913,35 +913,6 @@ static void intel_gpio_irq_ack(struct irq_data *d)
 	}
 }
 
-static void intel_gpio_irq_enable(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	const struct intel_community *community;
-	const struct intel_padgroup *padgrp;
-	int pin;
-
-	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
-	if (pin >= 0) {
-		unsigned int gpp, gpp_offset, is_offset;
-		unsigned long flags;
-		u32 value;
-
-		gpp = padgrp->reg_num;
-		gpp_offset = padgroup_offset(padgrp, pin);
-		is_offset = community->is_offset + gpp * 4;
-
-		raw_spin_lock_irqsave(&pctrl->lock, flags);
-		/* Clear interrupt status first to avoid unexpected interrupt */
-		writel(BIT(gpp_offset), community->regs + is_offset);
-
-		value = readl(community->regs + community->ie_offset + gpp * 4);
-		value |= BIT(gpp_offset);
-		writel(value, community->regs + community->ie_offset + gpp * 4);
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-	}
-}
-
 static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -963,6 +934,11 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 		reg = community->regs + community->ie_offset + gpp * 4;
 
 		raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+		/* Clear interrupt status first to avoid unexpected interrupt */
+		if (!mask)
+			writel(BIT(gpp_offset), community->regs + community->is_offset + gpp * 4);
+
 		value = readl(reg);
 		if (mask)
 			value &= ~BIT(gpp_offset);
@@ -1106,7 +1082,6 @@ static irqreturn_t intel_gpio_irq(int irq, void *data)
 
 static struct irq_chip intel_gpio_irqchip = {
 	.name = "intel-gpio",
-	.irq_enable = intel_gpio_irq_enable,
 	.irq_ack = intel_gpio_irq_ack,
 	.irq_mask = intel_gpio_irq_mask,
 	.irq_unmask = intel_gpio_irq_unmask,
-- 
2.17.1

