Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF681C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1B206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfH0D7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:59:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:10570 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbfH0D7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:59:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 20:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="331686795"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2019 20:58:56 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        jwboyer@gmail.com, boris.brezillon@free-electrons.com,
        cyrille.pitchen@atmel.com, david.oberhollenzer@sigma-star.at,
        miquel.raynal@bootlin.com, tudor.ambarus@gmail.com,
        vigneshr@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 2/3] mtd: spi-nor: cadence-quadspi: disable DMA and DAC for Intel LGM
Date:   Tue, 27 Aug 2019 11:58:26 +0800
Message-Id: <20190827035827.21024-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

on Intel's Lightning Mountain(LGM) SoCs QSPI controller do not use
Direct Memory Access(DMA) and Direct Access Controller(DAC).

This patch introduces to properly disable the DMA and DAC
for data transfer instead it uses indirect data transfer.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/mtd/spi-nor/Kconfig           |  2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

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
index 67f15a1f16fd..69fa13e95110 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -517,12 +517,16 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
 	void __iomem *ahb_base = cqspi->ahb_base;
+	u32 trigger_address = cqspi->trigger_address;
 	unsigned int remaining = n_rx;
 	unsigned int mod_bytes = n_rx % 4;
 	unsigned int bytes_to_read = 0;
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!f_pdata->use_direct_mode)
+		writel(trigger_address, reg_base + CQSPI_REG_INDIRECTTRIGGER);
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -609,6 +613,14 @@ static int cqspi_write_setup(struct spi_nor *nor)
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
@@ -1171,7 +1183,8 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
+	if (!of_device_is_compatible(np, "intel,lgm-qspi"))
+		cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
 
 	return 0;
 }
@@ -1301,7 +1314,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 		f_pdata->registered = true;
 
 		if (mtd->size <= cqspi->ahb_size) {
-			f_pdata->use_direct_mode = true;
+			f_pdata->use_direct_mode =
+				!(of_device_is_compatible(np, "intel,lgm-qspi"));
 			dev_dbg(nor->dev, "using direct mode for %s\n",
 				mtd->name);
 
@@ -1347,7 +1361,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	/* Obtain QSPI clock. */
-	cqspi->clk = devm_clk_get(dev, NULL);
+	cqspi->clk = devm_clk_get(dev, "qspi");
 	if (IS_ERR(cqspi->clk)) {
 		dev_err(dev, "Cannot claim QSPI clock.\n");
 		return PTR_ERR(cqspi->clk);
@@ -1369,6 +1383,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cqspi->ahb_base);
 	}
 	cqspi->mmap_phys_base = (dma_addr_t)res_ahb->start;
+	cqspi->trigger_address = res_ahb->start;
 	cqspi->ahb_size = resource_size(res_ahb);
 
 	init_completion(&cqspi->transfer_complete);
-- 
2.11.0

