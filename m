Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A012C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F562075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZI30UY6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfC0F5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17592 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbfC0F5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10bb0001>; Tue, 26 Mar 2019 22:57:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:11 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:11 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:11 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10b50002>; Tue, 26 Mar 2019 22:57:10 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 06/26] spi: tegra114: terminate dma and reset on transfer timeout
Date:   Tue, 26 Mar 2019 22:56:27 -0700
Message-ID: <1553666207-11414-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666235; bh=i8+ndFb16vHMuRawNGbZAarN3wV094Dxo/2p5bGP8Z4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZI30UY6atBAsnOp5Gv7GSj14N2NbaxSBiVIUugbyTlZ7j8usygD/+/OvPlE2r2Nac
         ntg7LMlUUDlE13ao8WvKP1jiOPmYWb7HgIJjl2i1gGOUZhC5w/CiS81TvgVRAnYJqa
         zujLPDyG53S38UA8Meev0Aw/W8yFpQgdzOpDJio9SOx7vLOhnYcrLxWCT7UidPJY1P
         ZMA8x8o7JHDeW8woq05JgvhV8gzoElYMGxO//FsKXadyFgZseQE4va4lg4zPEkx/Oy
         IPJ+FzOt5ND0rU9XJX5ZGhmiuvByvmmjRt4be4G1N9q9Lb4XkBTsdWml6sJK/bqPQq
         Bh5txVnWtU4eA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: terminate DMA and perform controller reset on transfer timeout
to clear the FIFO's and errors.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 716587b663a3..0d20fc489134 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -871,7 +871,16 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (WARN_ON(ret == 0)) {
 			dev_err(tspi->dev,
 				"spi transfer timeout, err %d\n", ret);
+			if (tspi->is_curr_dma_xfer &&
+			    (tspi->cur_direction & DATA_DIR_TX))
+				dmaengine_terminate_all(tspi->tx_dma_chan);
+			if (tspi->is_curr_dma_xfer &&
+			    (tspi->cur_direction & DATA_DIR_RX))
+				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			reset_control_assert(tspi->rst);
+			udelay(2);
+			reset_control_deassert(tspi->rst);
 			goto complete_xfer;
 		}
 
-- 
2.7.4

