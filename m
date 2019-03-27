Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F72E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j/YsHbxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfC0F5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6275 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfC0F5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10d70001>; Tue, 26 Mar 2019 22:57:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:45 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:44 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:44 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10d60001>; Tue, 26 Mar 2019 22:57:44 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is reset to its default
Date:   Tue, 26 Mar 2019 22:56:45 -0700
Message-ID: <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666263; bh=qqcxJt6Vkn8IPNbfhZkyYZ2kfpA+TQeqAqxGiomjZbY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=j/YsHbxJBF8Tt7C+TuyXooW6iNYA4KM+B6lpkBm9ej7etjTtdle8lJ3RRj5t4lE+T
         NGD2K3aNngR5QNoHMPZq2qbh/2pYH9sYSch7neZq6RrI7vj2BnOe8PG1JV6Iiu6xLl
         BsMc4rz7Tot9hH4recMkPu7e7ODZ9DiEHFdxSrQrvH+8iVbZrJEwoxJTylu6Z8EC+v
         XHppunBEnmaSr1DzwoUMrHzcuDn8Do83W7JBojOwTyTboNzAhF/xVv01uzVuD7CBbv
         xs7Ixeome1T9ahFqvXG/QyNodoLH/+umw00dvbd7nAnibwHcgV41uqBDYzP/67ZvoG
         vB2tVec/+Bqtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SW CS, during transfer completion CS is de-asserted by writing the
default command1 register value to SPI_COMMAND1 register. With this both
mode and CS state are set at the same time and if current transfer mode
is different to default SPI mode and if mode change happens prior to CS
de-assert, clock polarity can change while CS is active before transfer
finishes.

This causes Slave to see spurious clock edges resulting in data mismatch.

This patch fixes this by de-asserting CS before writing SPI_COMMAND1 to
its default value so through out the transfer it will be in same SPI mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 9b216e9d6079..e1669ab3b0fe 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1147,6 +1147,12 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (ret < 0 || skip) {
 			if (cstate->cs_gpio_valid)
 				gpio_set_value(spi->cs_gpio, cs_val);
+			if (cs_val && !tspi->use_hw_based_cs)
+				tspi->command1_reg |= SPI_CS_SW_VAL;
+			else
+				tspi->command1_reg &= ~SPI_CS_SW_VAL;
+			tegra_spi_writel(tspi, tspi->command1_reg,
+					 SPI_COMMAND1);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
@@ -1158,6 +1164,12 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			else {
 				if (cstate->cs_gpio_valid)
 					gpio_set_value(spi->cs_gpio, cs_val);
+				if (cs_val && !tspi->use_hw_based_cs)
+					tspi->command1_reg |= SPI_CS_SW_VAL;
+				else
+					tspi->command1_reg &= ~SPI_CS_SW_VAL;
+				tegra_spi_writel(tspi, tspi->command1_reg,
+						 SPI_COMMAND1);
 				tegra_spi_writel(tspi, tspi->def_command1_reg,
 						SPI_COMMAND1);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
@@ -1165,6 +1177,12 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		} else if (xfer->cs_change) {
 			if (cstate->cs_gpio_valid)
 				gpio_set_value(spi->cs_gpio, cs_val);
+			if (cs_val && !tspi->use_hw_based_cs)
+				tspi->command1_reg |= SPI_CS_SW_VAL;
+			else
+				tspi->command1_reg &= ~SPI_CS_SW_VAL;
+			tegra_spi_writel(tspi, tspi->command1_reg,
+					 SPI_COMMAND1);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
-- 
2.7.4

