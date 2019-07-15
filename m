Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD36C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39BD206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199711;
	bh=J5CGiNAyjbtytYgCSGAGzgLgo3EC2yQtYiNaOXOi1S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ItUlZVbodMPkL4e+1MHI8pKb9fvgXOSMfm1aF+Pup0oCIhdW8MHGALE+yGn7N2DFC
	 WZOhuV3y7fiRTbNGs7DS1n7TTLffBwASqkOq87Q+bdjLxfs39B6UUWse3bZIR1noC3
	 yPm1rptTzO8ttXktdKbg5dmaajsE2g9npH7X62g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfGOOIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388499AbfGOOI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:08:28 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB182081C;
        Mon, 15 Jul 2019 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199707;
        bh=J5CGiNAyjbtytYgCSGAGzgLgo3EC2yQtYiNaOXOi1S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTFZneb334xt4bCDM9FDCuVbh1uvoEwHN3JPfvPRLKHH+DDdWqVgdw1BoYcInLoDJ
         6XnOGTiF5n1xOi63axPFkcz6SYRGE6Jy14laJTEewl7VdVheWNQgXEtYQ8EUzF2wPk
         I9m0LhK7F45fCfR4kHIYcEL/wNZuW+f3UUZBMdFU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 079/219] gpio: omap: ensure irq is enabled before wakeup
Date:   Mon, 15 Jul 2019 10:01:20 -0400
Message-Id: <20190715140341.6443-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit c859e0d479b3b4f6132fc12637c51e01492f31f6 ]

Documentation states:

  NOTE: There must be a correlation between the wake-up enable and
  interrupt-enable registers. If a GPIO pin has a wake-up configured
  on it, it must also have the corresponding interrupt enabled (on
  one of the two interrupt lines).

Ensure that this condition is always satisfied by enabling the detection
events after enabling the interrupt, and disabling the detection before
disabling the interrupt.  This ensures interrupt/wakeup events can not
happen until both the wakeup and interrupt enables correlate.

If we do any clearing, clear between the interrupt enable/disable and
trigger setting.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-omap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0708e50a27f0..233245bc693c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -838,9 +838,9 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->irq_usage &= ~(BIT(offset));
-	omap_set_gpio_irqenable(bank, offset, 0);
-	omap_clear_gpio_irqstatus(bank, offset);
 	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+	omap_clear_gpio_irqstatus(bank, offset);
+	omap_set_gpio_irqenable(bank, offset, 0);
 	if (!LINE_USED(bank->mod_usage, offset))
 		omap_clear_gpio_debounce(bank, offset);
 	omap_disable_gpio_module(bank, offset);
@@ -876,8 +876,8 @@ static void omap_gpio_mask_irq(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	omap_set_gpio_irqenable(bank, offset, 0);
 	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+	omap_set_gpio_irqenable(bank, offset, 0);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
@@ -889,9 +889,6 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	if (trigger)
-		omap_set_gpio_triggering(bank, offset, trigger);
-
 	omap_set_gpio_irqenable(bank, offset, 1);
 
 	/*
@@ -899,9 +896,13 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	 * is cleared, thus after the handler has run. OMAP4 needs this done
 	 * after enabing the interrupt to clear the wakeup status.
 	 */
-	if (bank->level_mask & BIT(offset))
+	if (bank->regs->leveldetect0 && bank->regs->wkup_en &&
+	    trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
 		omap_clear_gpio_irqstatus(bank, offset);
 
+	if (trigger)
+		omap_set_gpio_triggering(bank, offset, trigger);
+
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-- 
2.20.1

