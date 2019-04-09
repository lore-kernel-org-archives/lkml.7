Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E8C282DE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2BD213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDICLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:11:45 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:26741 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfDICLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:11:40 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x3929vUj032141;
        Tue, 9 Apr 2019 10:09:58 +0800 (GMT-8)
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
Subject: [PATCH v2 1/4] mfd: Add Macronix MX25F0A MFD controller driver
Date:   Tue,  9 Apr 2019 10:29:57 +0800
Message-Id: <1554777000-10542-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
References: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x3929vUj032141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Macronix MX25F0A multifunction device controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mfd/Kconfig              |   9 ++
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/mxic-mx25f0a.c       |  84 +++++++++++++++++++
 include/linux/mfd/mxic-mx25f0a.h | 175 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 drivers/mfd/mxic-mx25f0a.c
 create mode 100644 include/linux/mfd/mxic-mx25f0a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 26ad646..7e99e93 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -823,6 +823,15 @@ config MFD_MAX8998
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_MXIC_MX25F0A
+	tristate "Macronix mx25f0a multifunction device support"
+	select MFD_CORE
+	help
+	  This supports for Macronix mx25f0a multifunction device controller
+	  for raw nand or spi. You have to select individual components like
+	  raw nand controller or spi host controller under the corresponding
+	  menus.
+
 config MFD_MT6397
 	tristate "MediaTek MT6397 PMIC Support"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b4569ed7..dcfe8fd 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -163,6 +163,7 @@ max8925-objs			:= max8925-core.o max8925-i2c.o
 obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
 obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
 obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
+obj-$(CONFIG_MFD_MXIC_MX25F0A)	+= mxic-mx25f0a.o
 
 pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
diff --git a/drivers/mfd/mxic-mx25f0a.c b/drivers/mfd/mxic-mx25f0a.c
new file mode 100644
index 0000000..a884d97
--- /dev/null
+++ b/drivers/mfd/mxic-mx25f0a.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// Author:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//
+
+#include <linux/clk.h>
+#include <linux/mfd/mxic-mx25f0a.h>
+#include <linux/mfd/core.h>
+
+static const struct mfd_cell mx25f0a_nand_ctlr = {
+	.name = "mxic-nand-ctlr",
+	.of_compatible = "mxicy,mx25f0a-nand-ctlr",
+};
+
+static const struct mfd_cell mx25f0a_spi_ctlr = {
+	.name = "mxic-spi",
+	.of_compatible = "mxicy,mx25f0a-spi",
+};
+
+static int mx25f0a_mfd_probe(struct platform_device *pdev)
+{
+	const struct mfd_cell *cell;
+	struct mx25f0a_mfd *mxic;
+	struct resource *res;
+	int ret;
+
+	ret = of_device_is_compatible(pdev->dev.of_node->child,
+				      "jedec,spi-nor");
+	if (ret)
+		cell = &mx25f0a_spi_ctlr;
+	else
+		cell = &mx25f0a_nand_ctlr;
+
+	mxic = devm_kzalloc(&pdev->dev, sizeof(*mxic), GFP_KERNEL);
+	if (!mxic)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	mxic->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mxic->regs))
+		return PTR_ERR(mxic->regs);
+
+	if (cell == &mx25f0a_spi_ctlr) {
+		mxic->ps_clk = devm_clk_get(&pdev->dev, "ps_clk");
+		if (IS_ERR(mxic->ps_clk))
+			return PTR_ERR(mxic->ps_clk);
+
+		mxic->send_clk = devm_clk_get(&pdev->dev, "send_clk");
+		if (IS_ERR(mxic->send_clk))
+			return PTR_ERR(mxic->send_clk);
+
+		mxic->send_dly_clk = devm_clk_get(&pdev->dev, "send_dly_clk");
+		if (IS_ERR(mxic->send_dly_clk))
+			return PTR_ERR(mxic->send_dly_clk);
+	}
+
+	platform_set_drvdata(pdev, mxic);
+
+	ret = devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
+
+	return ret;
+}
+
+static const struct of_device_id mx25f0a_mfd_of_match[] = {
+	{ .compatible = "mxic,mx25f0a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mx25f0a_mfd_of_match);
+
+static struct platform_driver mx25f0a_mfd_driver = {
+	.probe		= mx25f0a_mfd_probe,
+	.driver = {
+		.name =	"mx25f0a-mfd",
+		.of_match_table = mx25f0a_mfd_of_match,
+	},
+};
+module_platform_driver(mx25f0a_mfd_driver);
+
+MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
+MODULE_DESCRIPTION("MX25F0A controller MFD driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/mxic-mx25f0a.h b/include/linux/mfd/mxic-mx25f0a.h
new file mode 100644
index 0000000..cb7bf19
--- /dev/null
+++ b/include/linux/mfd/mxic-mx25f0a.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// Author:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//
+
+#ifndef __MFD_MXIC_MX25F0A_H
+#define __MFD_MXIC_MX25F0A_H
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#define HC_CFG			0x0
+#define HC_CFG_IF_CFG(x)	((x) << 27)
+#define HC_CFG_DUAL_SLAVE	BIT(31)
+#define HC_CFG_INDIVIDUAL	BIT(30)
+#define HC_CFG_NIO(x)		(((x) / 4) << 27)
+#define HC_CFG_TYPE(s, t)	((t) << (23 + ((s) * 2)))
+#define HC_CFG_TYPE_SPI_NOR	0
+#define HC_CFG_TYPE_SPI_NAND	1
+#define HC_CFG_TYPE_SPI_RAM	2
+#define HC_CFG_TYPE_RAW_NAND	3
+#define HC_CFG_SLV_ACT(x)	((x) << 21)
+#define HC_CFG_CLK_PH_EN	BIT(20)
+#define HC_CFG_CLK_POL_INV	BIT(19)
+#define HC_CFG_BIG_ENDIAN	BIT(18)
+#define HC_CFG_DATA_PASS	BIT(17)
+#define HC_CFG_IDLE_SIO_LVL(x)	((x) << 16)
+#define HC_CFG_MAN_START_EN	BIT(3)
+#define HC_CFG_MAN_START	BIT(2)
+#define HC_CFG_MAN_CS_EN	BIT(1)
+#define HC_CFG_MAN_CS_ASSERT	BIT(0)
+
+#define INT_STS			0x4
+#define INT_STS_EN		0x8
+#define INT_SIG_EN		0xc
+#define INT_STS_ALL		GENMASK(31, 0)
+#define INT_RDY_PIN		BIT(26)
+#define INT_RDY_SR		BIT(25)
+#define INT_LNR_SUSP		BIT(24)
+#define INT_ECC_ERR		BIT(17)
+#define INT_CRC_ERR		BIT(16)
+#define INT_LWR_DIS		BIT(12)
+#define INT_LRD_DIS		BIT(11)
+#define INT_SDMA_INT		BIT(10)
+#define INT_DMA_FINISH		BIT(9)
+#define INT_RX_NOT_FULL		BIT(3)
+#define INT_RX_NOT_EMPTY	BIT(2)
+#define INT_TX_NOT_FULL		BIT(1)
+#define INT_TX_EMPTY		BIT(0)
+
+#define HC_EN			0x10
+#define HC_EN_BIT		BIT(0)
+
+#define TXD(x)			(0x14 + ((x) * 4))
+#define RXD			0x24
+
+#define SS_CTRL(s)		(0x30 + ((s) * 4))
+#define LRD_CFG			0x44
+#define LWR_CFG			0x80
+#define RWW_CFG			0x70
+#define OP_READ			BIT(23)
+#define OP_DUMMY_CYC(x)		((x) << 17)
+#define OP_ADDR_BYTES(x)	((x) << 14)
+#define OP_CMD_BYTES(x)		(((x) - 1) << 13)
+#define OP_OCTA_CRC_EN		BIT(12)
+#define OP_DQS_EN		BIT(11)
+#define OP_ENHC_EN		BIT(10)
+#define OP_PREAMBLE_EN		BIT(9)
+#define OP_DATA_DDR		BIT(8)
+#define OP_DATA_BUSW(x)		((x) << 6)
+#define OP_ADDR_DDR		BIT(5)
+#define OP_ADDR_BUSW(x)		((x) << 3)
+#define OP_CMD_DDR		BIT(2)
+#define OP_CMD_BUSW(x)		(x)
+#define OP_BUSW_1		0
+#define OP_BUSW_2		1
+#define OP_BUSW_4		2
+#define OP_BUSW_8		3
+
+#define OCTA_CRC		0x38
+#define OCTA_CRC_IN_EN(s)	BIT(3 + ((s) * 16))
+#define OCTA_CRC_CHUNK(s, x)	((fls((x) / 32)) << (1 + ((s) * 16)))
+#define OCTA_CRC_OUT_EN(s)	BIT(0 + ((s) * 16))
+
+#define ONFI_DIN_CNT(s)		(0x3c + (s))
+
+#define LRD_CTRL		0x48
+#define RWW_CTRL		0x74
+#define LWR_CTRL		0x84
+#define LMODE_EN		BIT(31)
+#define LMODE_SLV_ACT(x)	((x) << 21)
+#define LMODE_CMD1(x)		((x) << 8)
+#define LMODE_CMD0(x)		(x)
+
+#define LRD_ADDR		0x4c
+#define LWR_ADDR		0x88
+#define LRD_RANGE		0x50
+#define LWR_RANGE		0x8c
+
+#define AXI_SLV_ADDR		0x54
+
+#define DMAC_RD_CFG		0x58
+#define DMAC_WR_CFG		0x94
+#define DMAC_CFG_PERIPH_EN	BIT(31)
+#define DMAC_CFG_ALLFLUSH_EN	BIT(30)
+#define DMAC_CFG_LASTFLUSH_EN	BIT(29)
+#define DMAC_CFG_QE(x)		(((x) + 1) << 16)
+#define DMAC_CFG_BURST_LEN(x)	(((x) + 1) << 12)
+#define DMAC_CFG_BURST_SZ(x)	((x) << 8)
+#define DMAC_CFG_DIR_READ	BIT(1)
+#define DMAC_CFG_START		BIT(0)
+
+#define DMAC_RD_CNT		0x5c
+#define DMAC_WR_CNT		0x98
+
+#define SDMA_ADDR		0x60
+
+#define DMAM_CFG		0x64
+#define DMAM_CFG_START		BIT(31)
+#define DMAM_CFG_CONT		BIT(30)
+#define DMAM_CFG_SDMA_GAP(x)	(fls((x) / 8192) << 2)
+#define DMAM_CFG_DIR_READ	BIT(1)
+#define DMAM_CFG_EN		BIT(0)
+
+#define DMAM_CNT		0x68
+
+#define LNR_TIMER_TH		0x6c
+
+#define RDM_CFG0		0x78
+#define RDM_CFG0_POLY(x)	(x)
+
+#define RDM_CFG1		0x7c
+#define RDM_CFG1_RDM_EN		BIT(31)
+#define RDM_CFG1_SEED(x)	(x)
+
+#define LWR_SUSP_CTRL		0x90
+#define LWR_SUSP_CTRL_EN	BIT(31)
+
+#define DMAS_CTRL		0x9c
+#define DMAS_CTRL_DIR_READ	BIT(31)
+#define DMAS_CTRL_EN		BIT(30)
+
+#define DATA_STROB		0xa0
+#define DATA_STROB_EDO_EN	BIT(2)
+#define DATA_STROB_INV_POL	BIT(1)
+#define DATA_STROB_DELAY_2CYC	BIT(0)
+
+#define IDLY_CODE(x)		(0xa4 + ((x) * 4))
+#define IDLY_CODE_VAL(x, v)	((v) << (((x) % 4) * 8))
+
+#define GPIO			0xc4
+#define GPIO_PT(x)		BIT(3 + ((x) * 16))
+#define GPIO_RESET(x)		BIT(2 + ((x) * 16))
+#define GPIO_HOLDB(x)		BIT(1 + ((x) * 16))
+#define GPIO_WPB(x)		BIT((x) * 16)
+
+#define HC_VER			0xd0
+
+#define HW_TEST(x)		(0xe0 + ((x) * 4))
+
+struct mx25f0a_mfd {
+	void __iomem *regs;
+	struct clk *ps_clk;
+	struct clk *send_clk;
+	struct clk *send_dly_clk;
+};
+
+#endif // __MFD_MXIC_MX25F0A_H
-- 
1.9.1

