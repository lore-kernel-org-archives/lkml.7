Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D84C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90B020651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711886;
	bh=nRFPWgn+ApEm2nSdtrIjyCnM/0Yvr3Zjdai6c/splQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0ENXAFq19DBqoPQL5rFM0qpLyXgUJGlkEr7vqTOCCUTnnrxYX49GmLaXgmjZRQLN
	 Yk/NwVuZxyNGny/xUdlt8YF2jRaC2K8nZQ/MwuReDLyHYUMDf+IpmFvXIe2lZtaL1Z
	 a3PXGEBfCBWNCuCK7R812VgUAxeHd8fhj15uQozo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbfC0SiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391505AbfC0SXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A582070B;
        Wed, 27 Mar 2019 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711011;
        bh=nRFPWgn+ApEm2nSdtrIjyCnM/0Yvr3Zjdai6c/splQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yb4EMw+06/J0kAkDmdhtVqjKPBr8dClslGDDBwlQaEbSocTaWXx6a8VJqgjThwGtu
         NuwuzEXU0iis2jBFxScxAhjHICFtcxcPH640WSppwNRCWBTEXiar9mV8PpTSUYSjev
         JFpn/SO4qvVCC96m00xFZx2/t2oue66jSLFs2ncw=
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
Subject: [PATCH AUTOSEL 4.4 05/63] gpio: gpio-omap: fix level interrupt idling
Date:   Wed, 27 Mar 2019 14:22:25 -0400
Message-Id: <20190327182323.18577-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
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
index f7fbb46d5d79..9943273ec981 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -872,14 +872,16 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
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

