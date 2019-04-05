Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B269CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766422184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N9Gcv/VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfDEAPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:15:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11316 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfDEAOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69de50000>; Thu, 04 Apr 2019 17:14:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:31 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:31 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:31 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de60002>; Thu, 04 Apr 2019 17:14:30 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 12/20] spi: tegra114: add support for LSBYTE_FIRST
Date:   Thu, 4 Apr 2019 17:14:11 -0700
Message-ID: <1554423259-26056-12-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423269; bh=2E8oRAtPhJTeCHSxIlRHTV5Bt06fc2aYd4dB6HrI5sU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=N9Gcv/VTVJ5o9J38waU6cG59gTFfNZcCL2N1zvlvMUP6G+t9Nj/EU/Tu5FI2H5yBl
         G5ZLV/HeCjUgdWtsuzZLwE10GWOmlIEfOYtlqovqm9mhjz05KcDqQ6vnMMOU92d0uk
         mpsUUnk/9N67omfzTY7wr8buidJkLwgMKDKNHhdN+NCFx9cU6ukwapEMyKUnXk2LAL
         7if7C+LG5dhXUMuta2CXHKQApvvoskabiiYr2TcO8WYNdXV8+FAhMC3QBuq4DeNt8t
         IQFfeNdBekHHteBArAxxdeV8ZYUUiXwpIyvGpG1RkOfEZka+nvwyOZaIojpFM9xR1T
         ilbc3LHeCTvtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI devices expects SPI transfers to be in Least significant byte
first order and some devices expect Most significant byte first order.

This patch adds SPI_LSBYTE_FIRST to the supported SPI mode list and also
configures Tegra SPI controller accordingly.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 212bb90aa0cb..d3b95bba2361 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -755,6 +755,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_LSBIT_FE;
 
+		if (spi->mode & SPI_LSBYTE_FIRST)
+			command1 |= SPI_LSBYTE_FE;
+		else
+			command1 &= ~SPI_LSBYTE_FE;
+
 		if (spi->mode & SPI_3WIRE)
 			command1 |= SPI_BIDIROE;
 		else
@@ -1164,7 +1169,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE |
+			    SPI_LSBYTE_FIRST;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.7.4

