Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A76C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5044B218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PRLyxsIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfDOVbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:31:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16547 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfDOVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f8160001>; Mon, 15 Apr 2019 14:31:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:30:57 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:56 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:56 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f80e0001>; Mon, 15 Apr 2019 14:30:56 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 6/9] spi: tegra114: add support for gpio based CS
Date:   Mon, 15 Apr 2019 14:30:31 -0700
Message-ID: <1555363834-32155-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363862; bh=ld/bvgO0SE0ec28H7xE6hBCApY2yacHzkTCV9Gykofc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PRLyxsIj+fzk/MgWFSuqhuK/8tMAdAKLT5R0u7dSab5IdP48y26mwj48Scn542A1m
         DsrDKow8A4tiLgOLbETBQnAYHFTIpgiarDHlmqv58PvtCyNWWPkg4pyVsIfKKucnhC
         HqJ4oiBGne3VHFtWNNZnp3foJJQxt8tNKrDk+OBns373H1ldtw5ExxbmPvLOmr5hUJ
         wWA1/XpysToleWA6Sw2kYH/OOUaTTjU38nmbTe7oh/h2WeHe0rlKEkQzvKRPkldJHy
         a3pV5z4AhVWd+6ejYRSsI+ix/hd+icxAujn6pz8kO/k5PjqDa03jqTkdoAXxbyEWSh
         6Ne5awRq0vpAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for GPIO based CS control through SPI core
function spi_set_cs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f4e39eb3857c..0b04eba242c0 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -781,6 +781,9 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
+		/* GPIO based chip select control */
+		spi_set_cs(spi, true);
+
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
 			command1 |= SPI_CS_SW_VAL;
@@ -869,6 +872,8 @@ static int tegra_spi_setup(struct spi_device *spi)
 	}
 
 	spin_lock_irqsave(&tspi->lock, flags);
+	/* GPIO based chip select control */
+	spi_set_cs(spi, false);
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi->chip_select);
@@ -898,6 +903,8 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
+	/* GPIO based chip select control */
+	spi_set_cs(spi, false);
 	if (cs_val)
 		tspi->command1_reg |= SPI_CS_SW_VAL;
 	else
-- 
2.7.4

