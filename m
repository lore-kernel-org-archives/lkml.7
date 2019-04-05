Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB933C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7977E217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WncwU6KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfDEAOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6464 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfDEAOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69dee0000>; Thu, 04 Apr 2019 17:14:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:34 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:34 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:34 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de90000>; Thu, 04 Apr 2019 17:14:33 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 15/20] spi: tegra114: add support for hw based cs
Date:   Thu, 4 Apr 2019 17:14:14 -0700
Message-ID: <1554423259-26056-15-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423278; bh=JRUsxCMfpWHlDFuo7VUekAeVhb9AF9fKugnCNtKqUFs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WncwU6KMwSABTEDbUx7RwlC9/vhgSgjYpdumAjNpKK2citoIgcKBKWgwqSzNJwG8C
         wqePROFllJwlyXtBiSRJGKNMVHqRU2RMnAFQrKEv+wJm20AaL4s2U9ufhxa5KDP5O5
         jbsRrtcMjQxXRwHzltNgzmlN5M3lsal6oMUh+VLQPq4DsDIQdfsKqNhr9W5hctRVZ0
         fMNIpJ1fIwTpdXoCrxhEcBudN5IGExMdI5WfTCPjDVcty8NTU/dCa/cK3ruEXOrdJA
         Aeu6We1rTuqPCpuNBXwoldG86mQvKKV9ypfuBQMS4e46XK1gXc7FR0bVqA59wuWZ1L
         QnsPvcdO9Vvgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI controller supports both HW and SW based CS control
for SPI transfers.

This patch adds support for HW based CS control where CS is driven
to active state during the transfer and is driven inactive at the
end of the transfer directly by the HW.

This patch enables the use of HW based CS only for single transfers
without cs_change request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 209ec05a349f..5cc347b345b1 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -198,6 +198,7 @@ struct tegra_spi_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
+	bool					use_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -728,7 +729,8 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, bool is_first_of_msg)
+		struct spi_transfer *t, bool is_first_of_msg,
+		bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	struct tegra_spi_client_state *cstate = spi->controller_state;
@@ -787,11 +789,17 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
-		command1 |= SPI_CS_SW_HW;
-		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SW_VAL;
-		else
-			command1 &= ~SPI_CS_SW_VAL;
+		if (is_single_xfer && !(t->cs_change)) {
+			tspi->use_hw_based_cs = true;
+			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+		} else {
+			tspi->use_hw_based_cs = false;
+			command1 |= SPI_CS_SW_HW;
+			if (spi->mode & SPI_CS_HIGH)
+				command1 |= SPI_CS_SW_VAL;
+			else
+				command1 &= ~SPI_CS_SW_VAL;
+		}
 
 		if (cstate->cs_gpio_valid) {
 			int val = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
@@ -956,11 +964,14 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	if (cstate->cs_gpio_valid)
 		gpio_set_value(spi->cs_gpio, cs_val);
 
-	if (cs_val)
-		tspi->command1_reg |= SPI_CS_SW_VAL;
-	else
-		tspi->command1_reg &= ~SPI_CS_SW_VAL;
-	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	if (!tspi->use_hw_based_cs) {
+		if (cs_val)
+			tspi->command1_reg |= SPI_CS_SW_VAL;
+		else
+			tspi->command1_reg &= ~SPI_CS_SW_VAL;
+		tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	}
+
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
@@ -987,16 +998,19 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int ret;
 	bool skip = false;
+	int single_xfer;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
+	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
-		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
+		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
+						    single_xfer);
 
 		if (!xfer->len) {
 			ret = 0;
-- 
2.7.4

