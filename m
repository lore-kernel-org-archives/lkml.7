Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7044C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BCE2184E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GbreWjYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfDEAQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:16:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7954 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfDEAOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69dd50000>; Thu, 04 Apr 2019 17:14:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 17:14:24 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:24 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:23 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:23 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69ddf0005>; Thu, 04 Apr 2019 17:14:23 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 03/20] spi: tegra114: de-assert CS before SPI mode change
Date:   Thu, 4 Apr 2019 17:14:02 -0700
Message-ID: <1554423259-26056-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423253; bh=uIAQF2g5FNKo8JrlD3pO1xqsu0+8eQiDxMjFKhGUl8Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GbreWjYH/s5thtBSwljyRfzku0zcj9LHy+aS/CmefrtzLZI42fTFGuFpcpeubtreI
         xuSNBuRSSjy5IzPy8bvb3I/c20MIqTChYB1BsBKGmIQjF6yniX0BT9atROpMo7UMam
         hwsgzxmimjj35HpgwhUdxeMOKrkITDqBcJOqRRMAtV1fHl/fq1nH7eGn3ZCUOZN+q1
         Vfp7nKeOKuKUUibdxE8W3rpK399kzyrYyIeBNOE9xjMj2KwDerQO2tEHGUN2x8FbGt
         dy/fzJtcSAJoAVeWia2vujm4ypiI6pusx70Zee9xCpZo4UltfKPtVrZsyxlaqcOr45
         EUTwlkOZ0xH5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SW CS, during the transfer completion CS is de-asserted by writing
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
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 3042521c3785..c60e40cab0a0 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -863,6 +863,19 @@ static void tegra_spi_transfer_delay(int delay)
 	udelay(delay % 1000);
 }
 
+static void tegra_spi_transfer_end(struct spi_device *spi)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
+
+	if (cs_val)
+		tspi->command1_reg |= SPI_CS_SW_VAL;
+	else
+		tspi->command1_reg &= ~SPI_CS_SW_VAL;
+	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
+}
+
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -925,8 +938,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 
 complete_xfer:
 		if (ret < 0 || skip) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
@@ -934,13 +946,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			if (xfer->cs_change)
 				tspi->cs_control = spi;
 			else {
-				tegra_spi_writel(tspi, tspi->def_command1_reg,
-						SPI_COMMAND1);
+				tegra_spi_transfer_end(spi);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
 			}
 		} else if (xfer->cs_change) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 		}
 
-- 
2.7.4

