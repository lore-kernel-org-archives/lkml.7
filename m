Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA913C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802C5206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfD0PPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33028 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbfD0PPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:20 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2q-00014L-13; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004dH-CD; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        "Simon Horman" <horms+renesas@verge.net.au>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.345337550@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 175/202] mmc: tmio_mmc_core: don't claim spurious
 interrupts
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 5c27ff5db1491a947264d6d4e4cbe43ae6535bae upstream.

I have encountered an interrupt storm during the eMMC chip probing (and
the chip finally didn't get detected).  It turned out that U-Boot left
the DMAC interrupts enabled while the Linux driver  didn't use those.
The SDHI driver's interrupt handler somehow assumes that, even if an
SDIO interrupt didn't happen, it should return IRQ_HANDLED.  I think
that if none of the enabled interrupts happened and got handled, we
should return IRQ_NONE -- that way the kernel IRQ code recoginizes
a spurious interrupt and masks it off pretty quickly...

Fixes: 7729c7a232a9 ("mmc: tmio: Provide separate interrupt handlers")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16:
 - tmio_mmc_sdio_irq() can be used directly as an interrupt handler, so
   make it return IRQ_NONE for unhandled interrupts
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -639,7 +639,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, v
 	unsigned int ireg, status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
@@ -649,7 +649,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, v
 	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
 		mmc_signal_sdio_irq(mmc);
 
-	return IRQ_HANDLED;
+	return ireg ? IRQ_HANDLED : IRQ_NONE;
 }
 EXPORT_SYMBOL(tmio_mmc_sdio_irq);
 
@@ -666,9 +666,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	tmio_mmc_sdio_irq(irq, devid);
-
-	return IRQ_HANDLED;
+	return tmio_mmc_sdio_irq(irq, devid);
 }
 EXPORT_SYMBOL(tmio_mmc_irq);
 

