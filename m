Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9277AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DC1218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710608;
	bh=ZB704bNPOTk1fsKGwJGdcHCzS42Q0vdTB4MSRiictgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uU8yWSdsD4dzMLRd1RcLXmtf7H0tRZ00rhy3pBu9UEkb8/eRrxPwCCsc5D1DfK/o1
	 iKVuUeh1G9NIrqY8cfS3SYh01NIc8aIot83Ay+OpT1+b4Zocuw28bz8bgTSz9FGMxv
	 CshWJMyU/7z21csh8TYHxUIdg7fTdV7dDEoPqvHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbfC0SQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389816AbfC0SQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010EE21738;
        Wed, 27 Mar 2019 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710600;
        bh=ZB704bNPOTk1fsKGwJGdcHCzS42Q0vdTB4MSRiictgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqrS6WGDitWW/n3G8pPiBVqUGGP2vsc78yb45DNst9gwyhipMKa5UyLF0NI/oEfRK
         KI7+LiSg2R2QC5UYgpQZWFiS0ZEXmx+OV47GJBPj4EQnLwyx0HrfyyapLeXUWBMVo7
         QjteJtky7WZ80YlD5J7/EJSJ1YlWMVMkLvTLDFaY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 008/123] gpio: gpio-omap: fix level interrupt idling
Date:   Wed, 27 Mar 2019 14:14:32 -0400
Message-Id: <20190327181628.15899-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit d01849f7deba81f4959fd9e51bf20dbf46987d1c ]

Tony notes that the GPIO module does not idle when level interrupts are
in use, as the wakeup appears to get stuck.

After extensive investigation, it appears that the wakeup will only be
cleared if the interrupt status register is cleared while the interrupt
is enabled. However, we are currently clearing it with the interrupt
disabled for level-based interrupts.

It is acknowledged that this observed behaviour conflicts with a
statement in the TRM:

CAUTION
  After servicing the interrupt, the status bit in the interrupt status
  register (GPIOi.GPIO_IRQSTATUS_0 or GPIOi.GPIO_IRQSTATUS_1) must be
  reset and the interrupt line released (by setting the corresponding
  bit of the interrupt status register to 1) before enabling an
  interrupt for the GPIO channel in the interrupt-enable register
  (GPIOi.GPIO_IRQSTATUS_SET_0 or GPIOi.GPIO_IRQSTATUS_SET_1) to prevent
  the occurrence of unexpected interrupts when enabling an interrupt
  for the GPIO channel.

However, this does not appear to be a practical problem.

Further, as reported by Grygorii Strashko <grygorii.strashko@ti.com>,
the TI Android kernel tree has an earlier similar patch as "GPIO: OMAP:
Fix the sequence to clear the IRQ status" saying:

 if the status is cleared after disabling the IRQ then sWAKEUP will not
 be cleared and gates the module transition

When we unmask the level interrupt after the interrupt has been handled,
enable the interrupt and only then clear the interrupt. If the interrupt
is still pending, the hardware will re-assert the interrupt status.

Should the caution note in the TRM prove to be a problem, we could
use a clear-enable-clear sequence instead.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[tony@atomide.com: updated comments based on an earlier TI patch]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-omap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3233b72b6828..148e81eea35a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -841,14 +841,16 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	if (trigger)
 		omap_set_gpio_triggering(bank, offset, trigger);
 
-	/* For level-triggered GPIOs, the clearing must be done after
-	 * the HW source is cleared, thus after the handler has run */
-	if (bank->level_mask & BIT(offset)) {
-		omap_set_gpio_irqenable(bank, offset, 0);
+	omap_set_gpio_irqenable(bank, offset, 1);
+
+	/*
+	 * For level-triggered GPIOs, clearing must be done after the source
+	 * is cleared, thus after the handler has run. OMAP4 needs this done
+	 * after enabing the interrupt to clear the wakeup status.
+	 */
+	if (bank->level_mask & BIT(offset))
 		omap_clear_gpio_irqstatus(bank, offset);
-	}
 
-	omap_set_gpio_irqenable(bank, offset, 1);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-- 
2.19.1

