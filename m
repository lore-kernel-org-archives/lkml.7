Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2C20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688524;
	bh=1AQyJefjqICQvaUcCxu7U4iQtSFS8/RWRCVpUZQg3HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yoCh1VsWqo1zYZVkoLUCpvT3o64yxO9F7GgRr7fKkC1cxL0ZIjaLukZSfAvP4ua1f
	 ob4r1JkJd24tMLvBrwRzuYjz1Eot4hw23uu5RlJwW8H4sM/7MC3jdoFJfSh+qxgv2Q
	 dPiEZ7ukPF6h9J9gshOfCEOdckPC8ihxV/vAqL3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCDIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfCDIfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7BD220836;
        Mon,  4 Mar 2019 08:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688517;
        bh=1AQyJefjqICQvaUcCxu7U4iQtSFS8/RWRCVpUZQg3HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0w3AA2JXSleq+JNeadJiEaY7KiUigO1tp8Lgr5QrJ0HiMDpq93lsDRX1AQa0+J4HP
         1CDqpWAxCUu7qOkIT7DPFkU11N65gjGEmZuv0VqbHGoK/fS3cRowpdKRvbWdKh8q7+
         iSFfCR2QSmnL5NvaPRkjPTItjnzDNWEwVV656gZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 69/88] mmc: tmio_mmc_core: dont claim spurious interrupts
Date:   Mon,  4 Mar 2019 09:22:52 +0100
Message-Id: <20190304081633.321251160@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/mmc/host/tmio_mmc_core.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -618,7 +618,7 @@ static bool __tmio_mmc_sdcard_irq(struct
 	return false;
 }
 
-static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
+static bool __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
@@ -626,7 +626,7 @@ static void __tmio_mmc_sdio_irq(struct t
 	unsigned int sdio_status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
-		return;
+		return false;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
@@ -639,6 +639,8 @@ static void __tmio_mmc_sdio_irq(struct t
 
 	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
 		mmc_signal_sdio_irq(mmc);
+
+	return ireg;
 }
 
 irqreturn_t tmio_mmc_irq(int irq, void *devid)
@@ -657,9 +659,10 @@ irqreturn_t tmio_mmc_irq(int irq, void *
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	__tmio_mmc_sdio_irq(host);
+	if (__tmio_mmc_sdio_irq(host))
+		return IRQ_HANDLED;
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_irq);
 


