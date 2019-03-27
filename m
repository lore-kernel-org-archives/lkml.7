Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4E12070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oXI9FNA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfC0F6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:58:51 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6234 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733041AbfC0F5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10c00000>; Tue, 26 Mar 2019 22:57:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:22 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:22 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10bf0009>; Tue, 26 Mar 2019 22:57:21 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 12/26] spi: tegra114: add SPI_LSB_FIRST support
Date:   Tue, 26 Mar 2019 22:56:33 -0700
Message-ID: <1553666207-11414-12-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666240; bh=WzENTHCRfV1Ar8i1tgLhzT35ys8oaN1gLEZymgIl3jE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oXI9FNA8IZ47oJrstEU7HzSCPD7U5o309RME92Tcgg8jZNBblrLvw2/bCSn5QmUKs
         ZoBlAbJOLvuFwd0XyOt1vowD9VkZz68VrMPqk2cH+amkUnLoNFE79JGW9H8Hg2ge23
         +4Cv7MMyY/q+tdCRlgbw28T2oUFVE1KJ8VQGYzzssZFuDDU6lLE8hu2Gl8xaHng54q
         DPRqNOCGiWRtRlQAT3s2YUQQFR17ZCmXBp3s01DgcfgvqwpO5zhzl7+IQ0pMdb0Z7L
         Vl7Hwy7cDtZsaToiYd15AHaie7ASQiYb2Y6rKazD5AG11DLl0aJtMhByWAbmTvrWwf
         563fOstPPtCvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI controller supports lsb first mode. Default is MSB bit first
and on selection of SPI_LSB_FIRST through SPI mode transmission happens
with LSB bit first.

This patch adds SPI_LSB_FIRST flag to mode_bits and also configures it
on request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 0e228f1e910e..d39f7b05b824 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -750,6 +750,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else if (req_mode == SPI_MODE_3)
 			command1 |= SPI_CONTROL_MODE_3;
 
+		if (spi->mode & SPI_LSB_FIRST)
+			command1 |= SPI_LSBIT_FE;
+		else
+			command1 &= ~SPI_LSBIT_FE;
+
 		if (tspi->cs_control) {
 			if (tspi->cs_control != spi)
 				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
@@ -1137,7 +1142,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.7.4

