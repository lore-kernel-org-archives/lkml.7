Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34622C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41AE217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bwBL01xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfDEAQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:16:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11299 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfDEAOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69dde0000>; Thu, 04 Apr 2019 17:14:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:24 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:24 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de00001>; Thu, 04 Apr 2019 17:14:24 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 04/20] spi: tegra114: avoid reset call in atomic context
Date:   Thu, 4 Apr 2019 17:14:03 -0700
Message-ID: <1554423259-26056-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423262; bh=qObac6JMJVBXTxA9Ra3/+zALzffwl/l3Fv1nnWBF378=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bwBL01xj97QGyTdOfTAapknkRzpMMLwKmBX4Dz+Aj3yGhpoBBmTdD7cbWfxqdyK9m
         c/A2UXQQiW4B2pU1MF5fhNEnduOEk0v7SPriV9YmuclD9l3mebXb7B4Z+HqWX8nP9R
         RUd1M7/d8cmLPm/uMolWAvFyrMdf9z9Srj1D7qB2ejd1HpKSyiL9Nce9P63BlEYgzL
         0kYYeahXW/W5xQB9CyoN749ydBg25nMUiA65HMDpAZWB72Rn24i6ukiRfMczvSgAHq
         CP35jRlDMeYaX2T8w2HflegysVBozzzo4SDjlCtwbX8zNVXu9YtK16G9c7jlmZWv1C
         /4qbQukARonBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves SPI controller reset out of spin lock.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index c60e40cab0a0..d928a2c92a3d 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -974,11 +974,12 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
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
@@ -1047,11 +1048,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
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

