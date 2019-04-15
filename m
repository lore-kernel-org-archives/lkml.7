Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC43A218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aJb7PFrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfDOVar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:30:47 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16516 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDOVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f8090003>; Mon, 15 Apr 2019 14:30:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 15 Apr 2019 14:30:44 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:44 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:44 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f800000a>; Mon, 15 Apr 2019 14:30:43 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 1/9] spi: tegra114: fix PIO transfer
Date:   Mon, 15 Apr 2019 14:30:26 -0700
Message-ID: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363849; bh=nbVXrbqv2urGZ3Y5Gipe5PPV6peKmW/6Qou8swlcXLs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=aJb7PFrr6785bFXRUU2T7yu89z/559Vsj/MAnSsYSKjMSP5VKIAaudWb6S9wmkFAi
         Y50l8iihmqgHcfdEkumoeXXAGLp2pS3Dxo5cYpso6pFTBIMeDxNPZiP6PHrJywdILm
         abmPKZyhwDyf0Y72YPR0AXGZjPDrkZN0y17CGWi5cluTPAvdNjlLf1uml6XyK3HOmh
         8moIDpdLc17NuuOtDic0ME2vY7Qg0M/vjyCzv7JmXOuDux9JnSnOOcKnOdttl0pAl4
         GtqdKVhF9HxpOFhZef3JF/+PrqnpDH16M0qh7kjaZT0VjtCDgAmqSNJMdSNyOx3nec
         3QxY11AD0ptxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes PIO mode transfer to use PIO bit in SPI_COMMAND1 register.
Current driver uses DMA_EN instead of PIO bit.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b8c6393e2190..b1f31bb16659 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -651,8 +651,9 @@ static int tegra_spi_start_cpu_based_transfer(
 
 	tspi->is_curr_dma_xfer = false;
 
-	val |= SPI_DMA_EN;
-	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
+	val = tspi->command1_reg;
+	val |= SPI_PIO;
+	tegra_spi_writel(tspi, val, SPI_COMMAND1);
 	return 0;
 }
 
-- 
2.7.4

