Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D92C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CCA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHSLye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:54:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:34089 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSLyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:54:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="189510281"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2019 04:54:30 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        jwboyer@gmail.com, boris.brezillon@free-electrons.com,
        cyrille.pitchen@atmel.com, david.oberhollenzer@sigma-star.at,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 2/2] mtd: spi-nor: cadence-quadspi: disable the DMA,DAC and auto poll
Date:   Mon, 19 Aug 2019 19:54:24 +0800
Message-Id: <20190819115424.41479-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190819115424.41479-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190819115424.41479-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

On Intel Lightening Mountain(LGM) SoCs QSPI controller do not use
Direct Memory Access(DMA), Direct Access Controller(DAC) and
auto-poll features. This patch introduces to properly disable DMA,
DAC for data transfer instead it uses indirect data transfer.
and also auto polling.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/mtd/spi-nor/Kconfig           |  2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c | 62 ++++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6de83277ce8b..ba2e372ae514 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -34,7 +34,7 @@ config SPI_ASPEED_SMC
 
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
-	depends on OF && (ARM || ARM64 || COMPILE_TEST)
+	depends on OF && (ARM || ARM64 || COMPILE_TEST || X86)
 	help
 	  Enable support for the Cadence Quad SPI Flash controller.
 
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 67f15a1f16fd..83ae28e055f4 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -67,6 +67,7 @@ struct cqspi_st {
 
 	void __iomem		*iobase;
 	void __iomem		*ahb_base;
+	resource_size_t		ahb_phy_addr;
 	resource_size_t		ahb_size;
 	struct completion	transfer_complete;
 	struct mutex		bus_mutex;
@@ -134,6 +135,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
 #define CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
 
+#define CQSPI_REG_WR_COMPLETION_CTRL	0x38
+#define CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL	BIT(14)
 #define CQSPI_REG_WR_INSTR			0x08
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB		0
 #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
@@ -214,6 +217,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_INDIRECTWRWATERMARK		0x74
 #define CQSPI_REG_INDIRECTWRSTARTADDR		0x78
 #define CQSPI_REG_INDIRECTWRBYTES		0x7C
+#define CQSPI_REG_INDIRECTTRIGGERADDRRANGE	0x80
 
 #define CQSPI_REG_CMDADDRESS			0x94
 #define CQSPI_REG_CMDREADDATALOWER		0xA0
@@ -470,6 +474,18 @@ static int cqspi_command_write_addr(struct spi_nor *nor,
 	return cqspi_exec_flash_cmd(cqspi, reg);
 }
 
+static int cqspi_disable_auto_poll(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	reg |= CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL;
+	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+
+	return 0;
+}
+
 static int cqspi_read_setup(struct spi_nor *nor)
 {
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
@@ -507,6 +523,11 @@ static int cqspi_read_setup(struct spi_nor *nor)
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+
+	/* Disable auto-polling */
+	if (!f_pdata->use_direct_mode)
+		cqspi_disable_auto_poll(cqspi);
+
 	return 0;
 }
 
@@ -517,12 +538,16 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
 	void __iomem *ahb_base = cqspi->ahb_base;
+	resource_size_t ahb_phy_addr = cqspi->ahb_phy_addr;
 	unsigned int remaining = n_rx;
 	unsigned int mod_bytes = n_rx % 4;
 	unsigned int bytes_to_read = 0;
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!f_pdata->use_direct_mode)
+		writel(ahb_phy_addr, reg_base + CQSPI_REG_INDIRECTTRIGGER);
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -609,6 +634,14 @@ static int cqspi_write_setup(struct spi_nor *nor)
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
 
+	/* Disable the DMA and direct access controller */
+	if (!f_pdata->use_direct_mode) {
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+		reg &= ~CQSPI_REG_CONFIG_DMA_MASK;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+	}
+
 	/* Set opcode. */
 	reg = nor->program_opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
 	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
@@ -619,6 +652,11 @@ static int cqspi_write_setup(struct spi_nor *nor)
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+
+	/* Disable auto-polling */
+	if (!f_pdata->use_direct_mode)
+		cqspi_disable_auto_poll(cqspi);
+
 	return 0;
 }
 
@@ -1165,13 +1203,16 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (of_property_read_u32(np, "cdns,trigger-address",
-				 &cqspi->trigger_address)) {
-		dev_err(&pdev->dev, "couldn't determine trigger-address\n");
-		return -ENXIO;
-	}
+	if (!of_device_is_compatible(np, "intel,lgm-qspi")) {
+		if (of_property_read_u32(np, "cdns,trigger-address",
+					 &cqspi->trigger_address)) {
+			dev_err(&pdev->dev,
+				"couldn't determine trigger-address\n");
+			return -ENXIO;
+		}
 
-	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
+		cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
+	}
 
 	return 0;
 }
@@ -1301,7 +1342,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 		f_pdata->registered = true;
 
 		if (mtd->size <= cqspi->ahb_size) {
-			f_pdata->use_direct_mode = true;
+			f_pdata->use_direct_mode =
+				!(of_device_is_compatible(np, "intel,lgm-qspi"));
 			dev_dbg(nor->dev, "using direct mode for %s\n",
 				mtd->name);
 
@@ -1347,7 +1389,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	/* Obtain QSPI clock. */
-	cqspi->clk = devm_clk_get(dev, NULL);
+	if (of_device_is_compatible(np, "intel,lgm-qspi"))
+		cqspi->clk = devm_clk_get(dev, "qspi");
+	else
+		cqspi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(cqspi->clk)) {
 		dev_err(dev, "Cannot claim QSPI clock.\n");
 		return PTR_ERR(cqspi->clk);
@@ -1369,6 +1414,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cqspi->ahb_base);
 	}
 	cqspi->mmap_phys_base = (dma_addr_t)res_ahb->start;
+	cqspi->ahb_phy_addr = res_ahb->start;
 	cqspi->ahb_size = resource_size(res_ahb);
 
 	init_completion(&cqspi->transfer_complete);
-- 
2.11.0

