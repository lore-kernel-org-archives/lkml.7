Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6B42070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oM39EhrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfC0F6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:58:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6262 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733251AbfC0F5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10ce0000>; Tue, 26 Mar 2019 22:57:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:36 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:36 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:36 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10ce0001>; Tue, 26 Mar 2019 22:57:35 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 20/26] spi: tegra114: add support for tuning HW CS timing
Date:   Tue, 26 Mar 2019 22:56:41 -0700
Message-ID: <1553666207-11414-20-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666255; bh=GK+sDhPMw03lTs35xJuVfysz/Evjc1/5Qm35wIZmiSc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oM39EhrF3ROOQgHRpeUWMcQCh6KY0l3OEDY3NxfqkBiZuNi3bnUioUeSkGB9PKUMx
         2fsryg3zyp7F2qHdhbP1Wkf7/REzzWZhc/CF6HF3JuRcpUwc28nMqZzr9wMmHfDJB/
         EjrpQlnKQtg/GL6GHK+jklS25XKNzw1G6xPtaLhbd6dG2caXL8v8UsQFi+/CbfFiLO
         zK17N3GD2jhQqO45W7sDHLvzOuJ04VMEb+ztqlW2uFkpxtSg5lT/OtpicQuRNjufK1
         1fy2mk1oPIX6lhq01T28aVkKEt3l9mi79O6GWKT/FclzPXyM14wx1ea/AAEpvqsKGi
         Er4cvOeFBTMMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some slaves may need certain CS setup time, hold time, CS inactive
delay between the packets. Tegra SPI controller supports configuring
these CS timing parameters and are applicable when using HW CS.

This patch adds support for configuring these HW CS timing parameters
through device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 86c34f02d13a..e01962344bde 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -95,8 +95,10 @@
 		(reg = (((val) & 0x1) << ((cs) * 8 + 5)) |	\
 			((reg) & ~(1 << ((cs) * 8 + 5))))
 #define SPI_SET_CYCLES_BETWEEN_PACKETS(reg, cs, val)		\
-		(reg = (((val) & 0xF) << ((cs) * 8)) |		\
-			((reg) & ~(0xF << ((cs) * 8))))
+		(reg = (((val) & 0x1F) << ((cs) * 8)) |		\
+			((reg) & ~(0x1F << ((cs) * 8))))
+#define MAX_SETUP_HOLD_CYCLES			16
+#define MAX_INACTIVE_CYCLES			32
 
 #define SPI_TRANS_STATUS			0x010
 #define SPI_BLK_CNT(val)			(((val) >> 0) & 0xFFFF)
@@ -169,6 +171,9 @@ struct tegra_spi_soc_data {
 
 struct tegra_spi_client_data {
 	bool is_hw_based_cs;
+	int cs_setup_clk_count;
+	int cs_hold_clk_count;
+	int cs_inactive_cycles;
 };
 
 struct tegra_spi_data {
@@ -210,6 +215,8 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					spi_cs_timing1;
+	u32					spi_cs_timing2;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -727,6 +734,43 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
+static void tegra_spi_set_hw_cs_timing(struct spi_device *spi)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
+	u32 setup_dly;
+	u32 hold_dly;
+	u32 setup_hold;
+	u32 spi_cs_timing;
+	u32 inactive_cycles;
+	u8 cs_state;
+
+	setup_dly = min(cdata->cs_setup_clk_count, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min(cdata->cs_hold_clk_count, MAX_SETUP_HOLD_CYCLES);
+	setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
+	spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
+					  spi->chip_select,
+					  setup_hold);
+	if (tspi->spi_cs_timing1 != spi_cs_timing) {
+		tspi->spi_cs_timing1 = spi_cs_timing;
+		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING1);
+	}
+
+	spi_cs_timing = tspi->spi_cs_timing2;
+	inactive_cycles = min(cdata->cs_inactive_cycles, MAX_INACTIVE_CYCLES);
+	if (inactive_cycles)
+		inactive_cycles--;
+	cs_state = inactive_cycles ? 0 : 1;
+	SPI_SET_CS_ACTIVE_BETWEEN_PACKETS(spi_cs_timing, spi->chip_select,
+					  cs_state);
+	SPI_SET_CYCLES_BETWEEN_PACKETS(spi_cs_timing, spi->chip_select,
+				       inactive_cycles);
+	if (tspi->spi_cs_timing2 != spi_cs_timing) {
+		tspi->spi_cs_timing2 = spi_cs_timing;
+		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING2);
+	}
+}
+
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t, bool is_first_of_msg,
 		bool is_single_xfer)
@@ -784,8 +828,10 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
 		tspi->use_hw_based_cs = false;
-		if (cdata && cdata->is_hw_based_cs && is_single_xfer)
+		if (cdata && cdata->is_hw_based_cs && is_single_xfer) {
 			tspi->use_hw_based_cs = true;
+			tegra_spi_set_hw_cs_timing(spi);
+		}
 
 		if (!tspi->use_hw_based_cs) {
 			command1 |= SPI_CS_SW_HW;
@@ -871,7 +917,12 @@ static struct tegra_spi_client_data
 
 	if (of_property_read_bool(slave_np, "nvidia,enable-hw-based-cs"))
 		cdata->is_hw_based_cs = true;
-
+	of_property_read_u32(slave_np, "nvidia,cs-setup-clk-count",
+			     &cdata->cs_setup_clk_count);
+	of_property_read_u32(slave_np, "nvidia,cs-hold-clk-count",
+			     &cdata->cs_hold_clk_count);
+	of_property_read_u32(slave_np, "nvidia,cs-inactive-cycles",
+			     &cdata->cs_inactive_cycles);
 	return cdata;
 }
 
@@ -1326,6 +1377,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 	tspi->def_command1_reg  = SPI_M_S;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
+	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
+	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
-- 
2.7.4

