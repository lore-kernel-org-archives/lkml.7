Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E75C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9668324689
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578343883;
	bh=C6S3DHbgWb4rL0yLOyP0vQDDV/1zs995qmbwathEQHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=hCDA1CWWxjL8cKfXtBolY6J15/zO7QrHmB/0STOKmZW2H8XvDCj9IOWH7zHuSf+Nv
	 k+yZQ994CktUm2Sb95i+A6qC6A0NNBDebhnBz/mDR9GDuncSPY1rlIyQ5sQbkBIhaM
	 5SAKDgOD7TxMdAxX9GStDS1pqVz+qokBhSzlXmGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgAFUvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:51:22 -0500
Received: from foss.arm.com ([217.140.110.172]:49270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgAFUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:51:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72D17106F;
        Mon,  6 Jan 2020 12:51:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01EC3F534;
        Mon,  6 Jan 2020 12:51:20 -0800 (PST)
Date:   Mon, 06 Jan 2020 20:51:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc:     broonie@kernel.org, fengsheng <fengsheng5@huawei.com>,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: use "smp_mb()" to avoid sending spi data error" to the spi tree
In-Reply-To: <1578019930-55858-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-Id: <applied-1578019930-55858-1-git-send-email-kong.kongxinwei@hisilicon.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: use "smp_mb()" to avoid sending spi data error

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bfda044533b213985bc62bd7ca96f2b984d21b80 Mon Sep 17 00:00:00 2001
From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Date: Fri, 3 Jan 2020 10:52:10 +0800
Subject: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error

Because of out-of-order execution about some CPU architecture,
In this debug stage we find Completing spi interrupt enable ->
prodrucing TXEI interrupt -> running "interrupt_transfer" function
will prior to set "dw->rx and dws->rx_end" data, so this patch add
memory barrier to enable dw->rx and dw->rx_end to be visible and
solve to send SPI data error.
eg:
it will fix to this following low possibility error in testing environment
which using SPI control to connect TPM Modules

kernel: tpm tpm0: Operation Timed out
kernel: tpm tpm0: tpm_relinquish_locality: : error -1

Signed-off-by: fengsheng <fengsheng5@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Link: https://lore.kernel.org/r/1578019930-55858-1-git-send-email-kong.kongxinwei@hisilicon.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c547ae38ed69..310492e21b33 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -297,6 +297,9 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->len = transfer->len;
 	spin_unlock_irqrestore(&dws->buf_lock, flags);
 
+	/* Ensure dw->rx and dw->rx_end are visible */
+	smp_mb();
+
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-- 
2.20.1

