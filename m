Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4427B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="naCNHHhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfC0F7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:59:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6996 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733006AbfC0F5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10b90000>; Tue, 26 Mar 2019 22:57:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:18 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:18 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:18 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10bc0002>; Tue, 26 Mar 2019 22:57:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 10/26] spi: tegra114: avoid reset call in atomic context
Date:   Tue, 26 Mar 2019 22:56:31 -0700
Message-ID: <1553666207-11414-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666233; bh=dOcLXRlYLfLbnWb83E/qzVVgUeO0EyFlz/F9ooYBdVI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=naCNHHhrpSmwHaQucT7wQxWJ6rn4UePbf/JIck0AigxVqsVOKTvScN18SmBdlMyGo
         0dZWcrFQiFXbVG+6L6gbUE9ffNV2iBt52G8z60YnF49BI1WMLB1xMvugAJ+N6txY1s
         Bi+PrdsHuBtLGGaiP6OZWvGOR8u9bUTwU/mylvlqxeEfqe5TkQsl6bIBo1OCwDIFk3
         83blkGVm467xht65XJ45i9B17hbPbRGQRlyks8z/HHhYeQLZ3QJ0A7uvIYeArP99m+
         dtB0xCnByDKCule7/XSDcp7NFisiCB7lAuGiEFr6zX/EQNIDiuaBujbnqxcrwBgpHE
         cp23zQ8ZpLMSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: move SPI controller reset out of spin lock.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 268a790a663e..5523936b21f5 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -976,11 +976,12 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->command1_reg, tspi->dma_control_reg);
 		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
+		complete(&tspi->xfer_completion);
+		spin_unlock_irqrestore(&tspi->lock, flags);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-		complete(&tspi->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	if (tspi->cur_direction & DATA_DIR_RX)
@@ -1050,11 +1051,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->command1_reg, tspi->dma_control_reg);
 		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
+		complete(&tspi->xfer_completion);
+		spin_unlock_irqrestore(&tspi->lock, flags);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-		complete(&tspi->xfer_completion);
-		spin_unlock_irqrestore(&tspi->lock, flags);
 		return IRQ_HANDLED;
 	}
 
-- 
2.7.4

