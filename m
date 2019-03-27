Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFD12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LuoeiBXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbfC0F5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7033 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbfC0F5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10d20000>; Tue, 26 Mar 2019 22:57:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:43 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:42 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:42 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10d30001>; Tue, 26 Mar 2019 22:57:41 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 23/26] spi: tegra114: add support for gpio based cs
Date:   Tue, 26 Mar 2019 22:56:44 -0700
Message-ID: <1553666207-11414-23-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666258; bh=/86OHmZnYJfA0YFuZZCn2gQJnXRXfxAICbV/k0gmLhI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LuoeiBXIO6ajTocBdJc0kSAfj/isD+sOiGM6dPL9iye6Shke6OR+S5SCKqGX9FeDq
         THHPWJnygwVQnNHV/akzW31CPXfxxq5XCmooFB+mBod7JXbfnaGYZDhYX/Ql9tXJo5
         wvhbAJyauZ2Dg1m2ajdI8vf7m+pY9fQti+EDzCTESFrxl0PxO60U7EL6EA/NeMGovv
         TSmzxBDgmIOsKisrWw8bA5yKNM8MCchNL60wZgGMQPNU96K4muOFiELDr4GzKGlQdv
         FcBpqsBRN2/CkVkaQ1y4k58ssV4qQO5OUPz4lA2+r+l965EaoqP0IaOmlQ3TuBwSL+
         j+Fj0gk0qpIFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds supports for chip select control using GPIO if valid
CS gpio exists rather than controlling from the SPI controller.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 725d60364ec6..9b216e9d6079 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -23,6 +23,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -178,6 +179,10 @@ struct tegra_spi_client_data {
 	int rx_clk_tap_delay;
 };
 
+struct tegra_spi_client_state {
+	bool cs_gpio_valid;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -781,6 +786,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 command1;
@@ -849,6 +855,12 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
 		}
 
+		if (cstate->cs_gpio_valid) {
+			int val = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
+
+			gpio_set_value(spi->cs_gpio, val);
+		}
+
 		if (tspi->last_used_cs != spi->chip_select) {
 			if (cdata && cdata->tx_clk_tap_delay)
 				tx_tap = cdata->tx_clk_tap_delay;
@@ -950,7 +962,12 @@ static struct tegra_spi_client_data
 static void tegra_spi_cleanup(struct spi_device *spi)
 {
 	struct tegra_spi_client_data *cdata = spi->controller_data;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 
+	spi->controller_state = NULL;
+	if (cstate && cstate->cs_gpio_valid)
+		gpio_free(spi->cs_gpio);
+	kfree(cstate);
 	spi->controller_data = NULL;
 	if (spi->dev.of_node)
 		kfree(cdata);
@@ -960,6 +977,7 @@ static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -970,11 +988,41 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
+	if (!cstate) {
+		cstate = kzalloc(sizeof(*cstate), GFP_KERNEL);
+		if (!cstate)
+			return -ENOMEM;
+		spi->controller_state = cstate;
+	}
+
 	if (!cdata) {
 		cdata = tegra_spi_parse_cdata_dt(spi);
 		spi->controller_data = cdata;
 	}
 
+	if (spi->master->cs_gpios && gpio_is_valid(spi->cs_gpio)) {
+		if (!cstate->cs_gpio_valid) {
+			int gpio_flag = GPIOF_OUT_INIT_HIGH;
+
+			if (spi->mode & SPI_CS_HIGH)
+				gpio_flag = GPIOF_OUT_INIT_LOW;
+
+			ret = gpio_request_one(spi->cs_gpio, gpio_flag,
+					       "cs_gpio");
+			if (ret < 0) {
+				dev_err(&spi->dev,
+					"GPIO request failed: %d\n", ret);
+				tegra_spi_cleanup(spi);
+				return ret;
+			}
+			cstate->cs_gpio_valid = true;
+		} else {
+			int val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
+
+			gpio_set_value(spi->cs_gpio, val);
+		}
+	}
+
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -1034,9 +1082,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
+	struct tegra_spi_client_state *cstate = spi->controller_state;
 	int single_xfer;
 	int ret;
 	bool skip = false;
+	int cs_val;
 
 	msg->status = 0;
 	msg->actual_length = 0;
@@ -1093,7 +1143,10 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		msg->actual_length += xfer->len;
 
 complete_xfer:
+		cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 		if (ret < 0 || skip) {
+			if (cstate->cs_gpio_valid)
+				gpio_set_value(spi->cs_gpio, cs_val);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
@@ -1103,11 +1156,15 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			if (xfer->cs_change)
 				tspi->cs_control = spi;
 			else {
+				if (cstate->cs_gpio_valid)
+					gpio_set_value(spi->cs_gpio, cs_val);
 				tegra_spi_writel(tspi, tspi->def_command1_reg,
 						SPI_COMMAND1);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
 			}
 		} else if (xfer->cs_change) {
+			if (cstate->cs_gpio_valid)
+				gpio_set_value(spi->cs_gpio, cs_val);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
-- 
2.7.4

