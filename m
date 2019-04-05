Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53618C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15E2184E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fkj0KLH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfDEAOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6439 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDEAOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69de20000>; Thu, 04 Apr 2019 17:14:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 17:14:22 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:22 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:22 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69ddd000b>; Thu, 04 Apr 2019 17:14:21 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 01/20] spi: tegra114: fix PIO transfer
Date:   Thu, 4 Apr 2019 17:14:00 -0700
Message-ID: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423266; bh=yfcAvajdhtbmEYXty9MCa4MPZeE130DEL1zLdZw+OBA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=fkj0KLH4qliJMw0woji4BQ1z2o5e5ZW7ndyuwLZM4Vt/jgmm8Ga3WDm8jifEn53mR
         /Fvu1A45p+tyEcZBAT0OEKZ/VCt+7T4fvFpnHtO7QwmnskR6Ij9hSFH7HB/cEEqs+U
         iSXGa4w8VDKIeFTPiZFBhf6x2QAIn8FLWB/VdMt03LO8d6rZ++b3Tbq/pEKByiNJ8D
         CodU0cNb784gq7u8zxhYA3UaFkFj0f9ONAc4fFsOWuGFdDMmFjKgkChRktWlhNgcGj
         3wRkA0XQjfjghF0VfVFKUH3+RukfKuteTBfQhwLYSMGf6aqYoBzmYMYHaiBAojJA6p
         6wAiC1CFgWGEQ==
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
index 6bb40e46da91..ba1639310282 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -641,8 +641,9 @@ static int tegra_spi_start_cpu_based_transfer(
 
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

