Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0AE21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfC1KA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:00:57 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50876 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1KAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:00:54 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2S9wlJM052359;
        Thu, 28 Mar 2019 17:58:50 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com
Cc:     juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 3/7] spi: Patch Macronix MX25F0A SPI controller driver
Date:   Thu, 28 Mar 2019 18:18:34 +0800
Message-Id: <1553768318-23149-4-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2S9wlJM052359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch a MFD driver for Macronix MX25F0A SPI controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/spi/spi-mxic.c | 159 +------------------------------------------------
 1 file changed, 3 insertions(+), 156 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e41ae6e..fbebf89 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -9,163 +9,11 @@
 //
 
 #include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/mfd/mxic-mx25f0a.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
-#define HC_CFG			0x0
-#define HC_CFG_IF_CFG(x)	((x) << 27)
-#define HC_CFG_DUAL_SLAVE	BIT(31)
-#define HC_CFG_INDIVIDUAL	BIT(30)
-#define HC_CFG_NIO(x)		(((x) / 4) << 27)
-#define HC_CFG_TYPE(s, t)	((t) << (23 + ((s) * 2)))
-#define HC_CFG_TYPE_SPI_NOR	0
-#define HC_CFG_TYPE_SPI_NAND	1
-#define HC_CFG_TYPE_SPI_RAM	2
-#define HC_CFG_TYPE_RAW_NAND	3
-#define HC_CFG_SLV_ACT(x)	((x) << 21)
-#define HC_CFG_CLK_PH_EN	BIT(20)
-#define HC_CFG_CLK_POL_INV	BIT(19)
-#define HC_CFG_BIG_ENDIAN	BIT(18)
-#define HC_CFG_DATA_PASS	BIT(17)
-#define HC_CFG_IDLE_SIO_LVL(x)	((x) << 16)
-#define HC_CFG_MAN_START_EN	BIT(3)
-#define HC_CFG_MAN_START	BIT(2)
-#define HC_CFG_MAN_CS_EN	BIT(1)
-#define HC_CFG_MAN_CS_ASSERT	BIT(0)
-
-#define INT_STS			0x4
-#define INT_STS_EN		0x8
-#define INT_SIG_EN		0xc
-#define INT_STS_ALL		GENMASK(31, 0)
-#define INT_RDY_PIN		BIT(26)
-#define INT_RDY_SR		BIT(25)
-#define INT_LNR_SUSP		BIT(24)
-#define INT_ECC_ERR		BIT(17)
-#define INT_CRC_ERR		BIT(16)
-#define INT_LWR_DIS		BIT(12)
-#define INT_LRD_DIS		BIT(11)
-#define INT_SDMA_INT		BIT(10)
-#define INT_DMA_FINISH		BIT(9)
-#define INT_RX_NOT_FULL		BIT(3)
-#define INT_RX_NOT_EMPTY	BIT(2)
-#define INT_TX_NOT_FULL		BIT(1)
-#define INT_TX_EMPTY		BIT(0)
-
-#define HC_EN			0x10
-#define HC_EN_BIT		BIT(0)
-
-#define TXD(x)			(0x14 + ((x) * 4))
-#define RXD			0x24
-
-#define SS_CTRL(s)		(0x30 + ((s) * 4))
-#define LRD_CFG			0x44
-#define LWR_CFG			0x80
-#define RWW_CFG			0x70
-#define OP_READ			BIT(23)
-#define OP_DUMMY_CYC(x)		((x) << 17)
-#define OP_ADDR_BYTES(x)	((x) << 14)
-#define OP_CMD_BYTES(x)		(((x) - 1) << 13)
-#define OP_OCTA_CRC_EN		BIT(12)
-#define OP_DQS_EN		BIT(11)
-#define OP_ENHC_EN		BIT(10)
-#define OP_PREAMBLE_EN		BIT(9)
-#define OP_DATA_DDR		BIT(8)
-#define OP_DATA_BUSW(x)		((x) << 6)
-#define OP_ADDR_DDR		BIT(5)
-#define OP_ADDR_BUSW(x)		((x) << 3)
-#define OP_CMD_DDR		BIT(2)
-#define OP_CMD_BUSW(x)		(x)
-#define OP_BUSW_1		0
-#define OP_BUSW_2		1
-#define OP_BUSW_4		2
-#define OP_BUSW_8		3
-
-#define OCTA_CRC		0x38
-#define OCTA_CRC_IN_EN(s)	BIT(3 + ((s) * 16))
-#define OCTA_CRC_CHUNK(s, x)	((fls((x) / 32)) << (1 + ((s) * 16)))
-#define OCTA_CRC_OUT_EN(s)	BIT(0 + ((s) * 16))
-
-#define ONFI_DIN_CNT(s)		(0x3c + (s))
-
-#define LRD_CTRL		0x48
-#define RWW_CTRL		0x74
-#define LWR_CTRL		0x84
-#define LMODE_EN		BIT(31)
-#define LMODE_SLV_ACT(x)	((x) << 21)
-#define LMODE_CMD1(x)		((x) << 8)
-#define LMODE_CMD0(x)		(x)
-
-#define LRD_ADDR		0x4c
-#define LWR_ADDR		0x88
-#define LRD_RANGE		0x50
-#define LWR_RANGE		0x8c
-
-#define AXI_SLV_ADDR		0x54
-
-#define DMAC_RD_CFG		0x58
-#define DMAC_WR_CFG		0x94
-#define DMAC_CFG_PERIPH_EN	BIT(31)
-#define DMAC_CFG_ALLFLUSH_EN	BIT(30)
-#define DMAC_CFG_LASTFLUSH_EN	BIT(29)
-#define DMAC_CFG_QE(x)		(((x) + 1) << 16)
-#define DMAC_CFG_BURST_LEN(x)	(((x) + 1) << 12)
-#define DMAC_CFG_BURST_SZ(x)	((x) << 8)
-#define DMAC_CFG_DIR_READ	BIT(1)
-#define DMAC_CFG_START		BIT(0)
-
-#define DMAC_RD_CNT		0x5c
-#define DMAC_WR_CNT		0x98
-
-#define SDMA_ADDR		0x60
-
-#define DMAM_CFG		0x64
-#define DMAM_CFG_START		BIT(31)
-#define DMAM_CFG_CONT		BIT(30)
-#define DMAM_CFG_SDMA_GAP(x)	(fls((x) / 8192) << 2)
-#define DMAM_CFG_DIR_READ	BIT(1)
-#define DMAM_CFG_EN		BIT(0)
-
-#define DMAM_CNT		0x68
-
-#define LNR_TIMER_TH		0x6c
-
-#define RDM_CFG0		0x78
-#define RDM_CFG0_POLY(x)	(x)
-
-#define RDM_CFG1		0x7c
-#define RDM_CFG1_RDM_EN		BIT(31)
-#define RDM_CFG1_SEED(x)	(x)
-
-#define LWR_SUSP_CTRL		0x90
-#define LWR_SUSP_CTRL_EN	BIT(31)
-
-#define DMAS_CTRL		0x9c
-#define DMAS_CTRL_DIR_READ	BIT(31)
-#define DMAS_CTRL_EN		BIT(30)
-
-#define DATA_STROB		0xa0
-#define DATA_STROB_EDO_EN	BIT(2)
-#define DATA_STROB_INV_POL	BIT(1)
-#define DATA_STROB_DELAY_2CYC	BIT(0)
-
-#define IDLY_CODE(x)		(0xa4 + ((x) * 4))
-#define IDLY_CODE_VAL(x, v)	((v) << (((x) % 4) * 8))
-
-#define GPIO			0xc4
-#define GPIO_PT(x)		BIT(3 + ((x) * 16))
-#define GPIO_RESET(x)		BIT(2 + ((x) * 16))
-#define GPIO_HOLDB(x)		BIT(1 + ((x) * 16))
-#define GPIO_WPB(x)		BIT((x) * 16)
-
-#define HC_VER			0xd0
-
-#define HW_TEST(x)		(0xe0 + ((x) * 4))
-
 struct mxic_spi {
 	struct clk *ps_clk;
 	struct clk *send_clk;
@@ -525,8 +373,8 @@ static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 
 static int mxic_spi_probe(struct platform_device *pdev)
 {
+	struct mx25f0a_mfd *mxic_mfd = dev_get_drvdata(pdev->dev.parent);
 	struct spi_master *master;
-	struct resource *res;
 	struct mxic_spi *mxic;
 	int ret;
 
@@ -552,8 +400,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(mxic->send_dly_clk))
 		return PTR_ERR(mxic->send_dly_clk);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	mxic->regs = devm_ioremap_resource(&pdev->dev, res);
+	mxic->regs = mxic_mfd->base;
 	if (IS_ERR(mxic->regs))
 		return PTR_ERR(mxic->regs);
 
-- 
1.9.1

