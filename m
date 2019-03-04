Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4009AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE1C20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688261;
	bh=Mv4H7Oo0Wnz0J5Vi55kE9/anan7MoHin7VTB79+CAvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DyNPH8rNBmIffyGflabzkAlTt1aVwtdQb6HPSNZWCfgcUs/FxUdG6hs+r8kcU0RRm
	 4tkaF0ILoEHU8/7WFQ4Wz8NeuUlTDqYt/bsZWhup8LOx/rAG8ODvldO9RDXCAmzMfY
	 YPdMVt4yoXhy74Zx6ghjXtVrnqu9vDvlQK6gr7j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCDIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfCDIa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3E220836;
        Mon,  4 Mar 2019 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688257;
        bh=Mv4H7Oo0Wnz0J5Vi55kE9/anan7MoHin7VTB79+CAvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkV+RRndNaDajkE/O39vdABfWFSHjOED9AFDiqBVzID2TsoC/lwgLlEvzN71T+2Sf
         EerL3jo3k4eZOPYOt6h7EEhvCseTi8ndhER/bgUR6KeOIWnxKQsesyXRL46NjaPdJh
         cPbp+UgF3HEVBiNwuFTppDPm54tXzBRpfiwETQgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        stable@kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 67/78] mmc: tmio: fix access width of Block Count Register
Date:   Mon,  4 Mar 2019 09:22:50 +0100
Message-Id: <20190304081628.581153012@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

commit 5603731a15ef9ca317c122cc8c959f1dee1798b4 upstream.

In R-Car Gen2 or later, the maximum number of transfer blocks are
changed from 0xFFFF to 0xFFFFFFFF. Therefore, Block Count Register
should use iowrite32().

If another system (U-boot, Hypervisor OS, etc) uses bit[31:16], this
value will not be cleared. So, SD/MMC card initialization fails.

So, check for the bigger register and use apropriate write. Also, mark
the register as extended on Gen2.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[wsa: use max_blk_count in if(), add Gen2, update commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@kernel.org
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
[Ulf: Fixed build error]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |    1 +
 drivers/mmc/host/tmio_mmc.h              |    5 +++++
 drivers/mmc/host/tmio_mmc_core.c         |    6 +++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -68,6 +68,7 @@ static const struct renesas_sdhi_of_data
 	.scc_offset	= 0x0300,
 	.taps		= rcar_gen2_scc_taps,
 	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
+	.max_blk_count  = 0xffffffff,
 };
 
 /* Definitions for sampling clocks */
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -279,6 +279,11 @@ static inline void sd_ctrl_write32_as_16
 	iowrite16(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
+static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
+{
+	iowrite32(val, host->ctl + (addr << host->bus_shift));
+}
+
 static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
 				       const u32 *buf, int count)
 {
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -46,6 +46,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mmc/sdio.h>
 #include <linux/scatterlist.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/swiotlb.h>
 #include <linux/workqueue.h>
@@ -777,7 +778,10 @@ static int tmio_mmc_start_data(struct tm
 
 	/* Set transfer length / blocksize */
 	sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
-	sd_ctrl_write16(host, CTL_XFER_BLK_COUNT, data->blocks);
+	if (host->mmc->max_blk_count >= SZ_64K)
+		sd_ctrl_write32(host, CTL_XFER_BLK_COUNT, data->blocks);
+	else
+		sd_ctrl_write16(host, CTL_XFER_BLK_COUNT, data->blocks);
 
 	tmio_mmc_start_dma(host, data);
 


