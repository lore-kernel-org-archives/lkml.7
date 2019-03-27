Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0523205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZpJwqJdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfC0F5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6957 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfC0F5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10a90000>; Tue, 26 Mar 2019 22:56:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:02 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:01 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:01 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:01 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10ab0001>; Tue, 26 Mar 2019 22:57:00 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 01/26] spi: tegra114: fix PIO transfer
Date:   Tue, 26 Mar 2019 22:56:22 -0700
Message-ID: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666217; bh=jnKCDS2+fDqhI4VcNWBwJ5VdZIxqBkvA13qxpCzyHjg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ZpJwqJdjFA+Uhw1ZZzUlNOH9xPq8lNWqN0BCcrgV0ay9r2/zvsC5AN1iauaAGae98
         TU6U/8UxcUoKDp/28KufsxY1mXQ/QwjxHPCYv4QYorMwngIMTkq4ByGCMpobfR0xs+
         I4vPKTLBg83EjDiqOL9s6ypznbV+dy1HL6itryNldrrOaAp5E/RbSE/xyGKzbT8Ojo
         M1oMEs1rucqt1co9ty7dkpc1ObJcjrfAX869o5J8SEKqOuR/L+1OG5pBZrfBh92xfm
         mXh0PM9ObD7UE8PuAxiRywnahDxLv9faOvBdBYZtJyfDBYWWIkIykAl2xadyCDLiRq
         h93BjKvMBcu4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: Use PIO bit in SPI_COMMAND1 register for PIO mode.

Current driver uses DMA_EN instead of PIO bit.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a76acedd7e2f..5a21bc808bb6 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -570,8 +570,9 @@ static int tegra_spi_start_cpu_based_transfer(
 
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

