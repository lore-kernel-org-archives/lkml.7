Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1689E206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371504;
	bh=s5VVglbny1kb5bbMuMVerXh7U9jbjrBvb2f4kwYgiI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5j9KUnz3olaoz5b3ZxeBzFvUjbbouddrrVGMHPA+ISnG01nvMe/4XV4ygJK8LAlR
	 5URU3vjcgedpf52Jk0U/MInswKp3DUmLKq4A3W4JEFofBT/cKrUlJdsv/rF22j/H+A
	 uFB0awsCKKheEGLpKz+QvCg/bO9sB53EHL3Rd+sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfDDJvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbfDDIyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:54:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DD72183E;
        Thu,  4 Apr 2019 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368079;
        bh=s5VVglbny1kb5bbMuMVerXh7U9jbjrBvb2f4kwYgiI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsjYI9CQCLNZrAaF5e32jX42zbZusE5yS8Cy/peglgWExOGZiYfNFbrbz04jPkQLS
         2Ps66jSWNrUTNyaR7XiryHrHR00NBSsh7jCqRB6dCJJ4633fv5z4mghEE+VVVLhFTu
         kk50D5Id5xL45G+Kue/j+onede3tHr9uQWgm138Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 013/121] gpio: gpio-omap: fix level interrupt idling
Date:   Thu,  4 Apr 2019 10:46:41 +0200
Message-Id: <20190404084546.036701156@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



