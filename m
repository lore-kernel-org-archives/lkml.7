Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FC6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876E22173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfC1KA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:00:59 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50877 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfC1KA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:00:56 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2S9wlJL052359;
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
Subject: [PATCH 2/7] mtd: rawnand: Add Macronix MX25F0A NAND controller driver
Date:   Thu, 28 Mar 2019 18:18:33 +0800
Message-Id: <1553768318-23149-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2S9wlJL052359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Macronix MX25F0A NAND controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/Kconfig     |   6 +
 drivers/mtd/nand/raw/Makefile    |   1 +
 drivers/mtd/nand/raw/mxic_nand.c | 303 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index e604625..e0329cc 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -522,6 +522,12 @@ config MTD_NAND_QCOM
 	  Enables support for NAND flash chips on SoCs containing the EBI2 NAND
 	  controller. This controller is found on IPQ806x SoC.
 
+config MTD_NAND_MXIC
+	tristate "Macronix MX25F0A NAND controller"
+	depends on HAS_IOMEM
+	help
+	  This selects the Macronix MX25F0A NAND controller driver.
+
 config MTD_NAND_MTK
 	tristate "Support for NAND controller on MTK SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 5a5a72f..c8a6790 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
 obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
+obj-$(CONFIG_MTD_NAND_MXIC)		+= mxic_nand.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
 obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+= stm32_fmc2_nand.o
diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
new file mode 100644
index 0000000..03886b2
--- /dev/null
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// Authors:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//	zhengxunli <zhengxunli@mxic.com.tw>
+//
+
+#include <linux/mfd/mxic-mx25f0a.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/nand_ecc.h>
+
+#include "internals.h"
+
+struct mxic_nand_ctlr {
+	struct nand_controller base;
+	struct nand_chip nand;
+	void __iomem *regs;
+};
+
+static void mxic_host_init(struct mxic_nand_ctlr *mxic)
+{
+	writel(DATA_STROB_EDO_EN, mxic->regs + DATA_STROB);
+	writel(INT_STS_ALL, mxic->regs + INT_STS_EN);
+	writel(0x0, mxic->regs + ONFI_DIN_CNT(0));
+	writel(HC_CFG_NIO(8) | HC_CFG_SLV_ACT(0) | HC_CFG_IDLE_SIO_LVL(1) |
+	       HC_CFG_TYPE(1, HC_CFG_TYPE_RAW_NAND) | HC_CFG_MAN_CS_EN,
+	       mxic->regs + HC_CFG);
+	writel(0x0, mxic->regs + HC_EN);
+}
+
+static int  mxic_nand_wait_ready(struct nand_chip *chip)
+{
+	struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
+	u32 sts;
+
+	return readl_poll_timeout(mxic->regs + INT_STS, sts,
+				  sts & INT_RDY_PIN, 0, USEC_PER_SEC);
+}
+
+static void mxic_nand_select_chip(struct nand_chip *chip, int chipnr)
+{
+	struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
+
+	switch (chipnr) {
+	case 0:
+	case 1:
+		writel(HC_EN_BIT, mxic->regs + HC_EN);
+		writel(HC_CFG_MAN_CS_ASSERT | readl(mxic->regs + HC_CFG),
+		       mxic->regs + HC_CFG);
+		break;
+
+	case -1:
+		writel(~HC_CFG_MAN_CS_ASSERT & readl(mxic->regs + HC_CFG),
+		       mxic->regs + HC_CFG);
+		writel(0, mxic->regs + HC_EN);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int mxic_nand_data_xfer(struct mxic_nand_ctlr *mxic, const void *txbuf,
+			       void *rxbuf, unsigned int len)
+{
+	unsigned int pos = 0;
+
+	while (pos < len) {
+		unsigned int nbytes = len - pos;
+		u32 data = 0xffffffff;
+		u32 sts;
+		int ret;
+
+		if (nbytes > 4)
+			nbytes = 4;
+
+		if (txbuf)
+			memcpy(&data, txbuf + pos, nbytes);
+
+		ret = readl_poll_timeout(mxic->regs + INT_STS, sts,
+					 sts & INT_TX_EMPTY, 0, USEC_PER_SEC);
+		if (ret)
+			return ret;
+
+		writel(data, mxic->regs + TXD(nbytes % 4));
+
+		if (rxbuf) {
+			ret = readl_poll_timeout(mxic->regs + INT_STS, sts,
+						 sts & INT_TX_EMPTY, 0,
+						 USEC_PER_SEC);
+			if (ret)
+				return ret;
+
+			ret = readl_poll_timeout(mxic->regs + INT_STS, sts,
+						 sts & INT_RX_NOT_EMPTY, 0,
+						 USEC_PER_SEC);
+			if (ret)
+				return ret;
+
+			data = readl(mxic->regs + RXD);
+			data >>= (8 * (4 - nbytes));
+			memcpy(rxbuf + pos, &data, nbytes);
+			WARN_ON(readl(mxic->regs + INT_STS) & INT_RX_NOT_EMPTY);
+		} else {
+			readl(mxic->regs + RXD);
+		}
+		WARN_ON(readl(mxic->regs + INT_STS) & INT_RX_NOT_EMPTY);
+
+		pos += nbytes;
+	}
+
+	return 0;
+}
+
+static int mxic_nand_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op, bool check_only)
+{
+	struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
+	const struct nand_op_instr *instr = NULL;
+	int i, len = 0, ret = 0;
+	unsigned int op_id;
+	unsigned char cmdcnt = 0, addr_cnt = 0, cmd_addr[8] = {0};
+
+	for (op_id = 0; op_id < op->ninstrs; op_id++) {
+		instr = &op->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			cmd_addr[len++] = instr->ctx.cmd.opcode;
+			cmdcnt++;
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			for (i = 0; i < instr->ctx.addr.naddrs; i++)
+				cmd_addr[len++] = instr->ctx.addr.addrs[i];
+			addr_cnt = i;
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			writel(instr->ctx.data.len,
+			       mxic->regs + ONFI_DIN_CNT(0));
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			break;
+		}
+	}
+
+	if (op_id == 5 && instr->type == NAND_OP_WAITRDY_INSTR) {
+		/*
+		 * In case cmd-addr-data-cmd-wait in a sequence,
+		 * separate the 2'nd command, i.e,. nand_prog_page_op()
+		 */
+		writel(OP_CMD_BUSW(OP_BUSW_8) | OP_ADDR_BUSW(OP_BUSW_8) |
+		       OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
+		       OP_ADDR_BYTES(addr_cnt) |
+		       OP_CMD_BYTES(1), mxic->regs + SS_CTRL(0));
+		writel(0, mxic->regs + HC_EN);
+		writel(HC_EN_BIT, mxic->regs + HC_EN);
+
+		mxic_nand_data_xfer(mxic, cmd_addr, NULL, len - 1);
+
+		mxic_nand_data_xfer(mxic, instr->ctx.data.buf.out, NULL,
+				    instr->ctx.data.len);
+
+		writel(0, mxic->regs + HC_EN);
+		writel(HC_EN_BIT, mxic->regs + HC_EN);
+		mxic_nand_data_xfer(mxic, &cmd_addr[--len], NULL, 1);
+		ret = mxic_nand_wait_ready(chip);
+		if (ret)
+			goto err_out;
+		return ret;
+	}
+
+	if (len) {
+		writel(OP_CMD_BUSW(OP_BUSW_8) | OP_ADDR_BUSW(OP_BUSW_8) |
+		       OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
+		       OP_ADDR_BYTES(addr_cnt) |
+		       OP_CMD_BYTES(cmdcnt > 0 ? cmdcnt : 0),
+		       mxic->regs + SS_CTRL(0));
+		writel(0, mxic->regs + HC_EN);
+		writel(HC_EN_BIT, mxic->regs + HC_EN);
+
+		mxic_nand_data_xfer(mxic, cmd_addr, NULL, len);
+	}
+
+	for (op_id = 0; op_id < op->ninstrs; op_id++) {
+		instr = &op->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+		case NAND_OP_ADDR_INSTR:
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			writel(0x0, mxic->regs + ONFI_DIN_CNT(0));
+			writel(readl(mxic->regs + SS_CTRL(0)) | OP_READ,
+			       mxic->regs + SS_CTRL(0));
+			mxic_nand_data_xfer(mxic, NULL, instr->ctx.data.buf.in,
+					    instr->ctx.data.len);
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			mxic_nand_data_xfer(mxic, instr->ctx.data.buf.out, NULL,
+					    instr->ctx.data.len);
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			ret = mxic_nand_wait_ready(chip);
+			if (ret)
+				goto err_out;
+			break;
+		}
+	}
+
+err_out:
+	return ret;
+}
+
+static const struct nand_controller_ops mxic_nand_controller_ops = {
+	.exec_op = mxic_nand_exec_op,
+};
+
+static int mx25f0a_nand_probe(struct platform_device *pdev)
+{
+	struct mtd_info *mtd;
+	struct mx25f0a_mfd *mxic_mfd = dev_get_drvdata(pdev->dev.parent);
+	struct mxic_nand_ctlr *mxic;
+	struct nand_chip *nand_chip;
+	int err;
+
+	mxic = devm_kzalloc(&pdev->dev, sizeof(struct mxic_nand_ctlr),
+			    GFP_KERNEL);
+	if (!mxic)
+		return -ENOMEM;
+
+	nand_chip = &mxic->nand;
+	mtd = nand_to_mtd(nand_chip);
+	mtd->dev.parent = &pdev->dev;
+	nand_chip->ecc.priv = NULL;
+	nand_set_flash_node(nand_chip, pdev->dev.of_node);
+	nand_chip->priv = mxic;
+
+	mxic->regs = mxic_mfd->base;
+	if (IS_ERR(mxic->regs))
+		return PTR_ERR(mxic->regs);
+
+	nand_chip->legacy.select_chip = mxic_nand_select_chip;
+
+	mxic->base.ops = &mxic_nand_controller_ops;
+	nand_controller_init(&mxic->base);
+	nand_chip->controller = &mxic->base;
+
+	mxic_host_init(mxic);
+
+	err = nand_scan(nand_chip, 1);
+	if (err)
+		goto fail;
+
+	err = mtd_device_register(mtd, NULL, 0);
+	if (err)
+		goto fail;
+
+	platform_set_drvdata(pdev, mxic);
+
+	return 0;
+fail:
+	return err;
+}
+
+static int mx25f0a_nand_remove(struct platform_device *pdev)
+{
+	struct mxic_nand_ctlr *mxic = platform_get_drvdata(pdev);
+
+	nand_release(&mxic->nand);
+
+	return 0;
+}
+
+static const struct of_device_id mx25f0a_nand_ids[] = {
+	{ .compatible = "mxicy,mx25f0a-nand-ctlr", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mx25f0a_nand_ids);
+
+static struct platform_driver mx25f0a_nand_driver = {
+	.probe		= mx25f0a_nand_probe,
+	.remove		= mx25f0a_nand_remove,
+	.driver		= {
+		.name	= "mxic-nand-ctlr",
+		.of_match_table = mx25f0a_nand_ids,
+	},
+};
+module_platform_driver(mx25f0a_nand_driver);
+
+MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
+MODULE_DESCRIPTION("MX25F0A RAW NAND controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

