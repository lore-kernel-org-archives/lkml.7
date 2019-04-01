Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89E820896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140239;
	bh=6/mc2BIe2Q5/PJ8ncuqevamgTJpAqc2qX+N5lKQGt2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EpEnXyYymGotZNTaQCp28oixmEMgx2E8xQ98PjvzgjU5FP3TGZg0+RWmlqcTW3VB6
	 DUpmETANi27Nw4puD/IxZxlyt99MzyBlJgoyTtXnsVU9PTlif6w4yOB2z8sZRPpDKg
	 RmxsNr8gHbcy4IHNptQZJ1CxYrtGnTNGAim/PXQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfDARhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387448AbfDARhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5D920830;
        Mon,  1 Apr 2019 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140234;
        bh=6/mc2BIe2Q5/PJ8ncuqevamgTJpAqc2qX+N5lKQGt2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZChewAxaLp6nJDWOZ3Rk1LkqfIw8yIuwJCzYJlHB28PiY/qxM7gZnwd9DOPTYWGA
         z/tjBbFlkLB4ChUIBGhmV+fUI9ICF6B1mvbBWH6rsAypF+pwCFs+9q12uyIc1nIyIB
         N+0lDueZsg7sOnciFIixIxzbGD2oO6Nhwm0Oqgik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3.18 06/50] mmc: tmio_mmc_core: dont claim spurious interrupts
Date:   Mon,  1 Apr 2019 19:02:49 +0200
Message-Id: <20190401170041.809745055@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/tmio_mmc_pio.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -714,7 +714,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, v
 	unsigned int sdio_status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
@@ -728,7 +728,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, v
 	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
 		mmc_signal_sdio_irq(mmc);
 
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(ireg);
 }
 EXPORT_SYMBOL(tmio_mmc_sdio_irq);
 
@@ -745,9 +745,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	tmio_mmc_sdio_irq(irq, devid);
-
-	return IRQ_HANDLED;
+	return tmio_mmc_sdio_irq(irq, devid);
 }
 EXPORT_SYMBOL(tmio_mmc_irq);
 


