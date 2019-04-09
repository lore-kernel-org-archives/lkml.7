Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABD0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0755213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDICLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:11:39 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:26742 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfDICLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:11:39 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x3929vUk032141;
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
Subject: [PATCH v2 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller driver
Date:   Tue,  9 Apr 2019 10:29:58 +0800
Message-Id: <1554777000-10542-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
References: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x3929vUk032141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Macronix MX25F0A NAND controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/Kconfig     |   6 +
 drivers/mtd/nand/raw/Makefile    |   1 +
 drivers/mtd/nand/raw/mxic_nand.c | 294 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
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
index 0000000..689fae2
--- /dev/null
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -0,0 +1,294 @@
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
+	struct mx25f0a_mfd *mfd;
+	struct nand_controller base;
+	struct nand_chip nand;
+};
+
+static void mxic_host_init(struct mxic_nand_ctlr *mxic)
+{
+	writel(DATA_STROB_EDO_EN, mxic->mfd->regs + DATA_STROB);
+	writel(INT_STS_ALL, mxic->mfd->regs + INT_STS_EN);
+	writel(0x0, mxic->mfd->regs + ONFI_DIN_CNT(0));
+	writel(HC_CFG_NIO(8) | HC_CFG_SLV_ACT(0) | HC_CFG_IDLE_SIO_LVL(1) |
+	       HC_CFG_TYPE(1, HC_CFG_TYPE_RAW_NAND) | HC_CFG_MAN_CS_EN,
+	       mxic->mfd->regs + HC_CFG);
+	writel(0x0, mxic->mfd->regs + HC_EN);
+}
+
+static int  mxic_nand_wait_ready(struct nand_chip *chip)
+{
+	struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
+	u32 sts;
+
+	return readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
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
+		writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
+		writel(HC_CFG_MAN_CS_ASSERT | readl(mxic->mfd->regs + HC_CFG),
+		       mxic->mfd->regs + HC_CFG);
+		break;
+
+	case -1:
+		writel(~HC_CFG_MAN_CS_ASSERT & readl(mxic->mfd->regs + HC_CFG),
+		       mxic->mfd->regs + HC_CFG);
+		writel(0, mxic->mfd->regs + HC_EN);
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
+		ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
+					 sts & INT_TX_EMPTY, 0, USEC_PER_SEC);
+		if (ret)
+			return ret;
+
+		writel(data, mxic->mfd->regs + TXD(nbytes % 4));
+
+		if (rxbuf) {
+			ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
+						 sts & INT_TX_EMPTY, 0,
+						 USEC_PER_SEC);
+			if (ret)
+				return ret;
+
+			ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
+						 sts & INT_RX_NOT_EMPTY, 0,
+						 USEC_PER_SEC);
+			if (ret)
+				return ret;
+
+			data = readl(mxic->mfd->regs + RXD);
+			data >>= (8 * (4 - nbytes));
+			memcpy(rxbuf + pos, &data, nbytes);
+			WARN_ON(readl(mxic->mfd->regs + INT_STS) &
+				INT_RX_NOT_EMPTY);
+		} else {
+			readl(mxic->mfd->regs + RXD);
+		}
+		WARN_ON(readl(mxic->mfd->regs + INT_STS) & INT_RX_NOT_EMPTY);
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
+			       mxic->mfd->regs + ONFI_DIN_CNT(0));
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
+		       OP_CMD_BYTES(1), mxic->mfd->regs + SS_CTRL(0));
+		writel(0, mxic->mfd->regs + HC_EN);
+		writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
+
+		mxic_nand_data_xfer(mxic, cmd_addr, NULL, len - 1);
+
+		mxic_nand_data_xfer(mxic, instr->ctx.data.buf.out, NULL,
+				    instr->ctx.data.len);
+
+		writel(0, mxic->mfd->regs + HC_EN);
+		writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
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
+		       mxic->mfd->regs + SS_CTRL(0));
+		writel(0, mxic->mfd->regs + HC_EN);
+		writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
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
+			writel(0x0, mxic->mfd->regs + ONFI_DIN_CNT(0));
+			writel(readl(mxic->mfd->regs + SS_CTRL(0)) | OP_READ,
+			       mxic->mfd->regs + SS_CTRL(0));
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
+	struct mx25f0a_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
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
+	mtd->dev.parent = pdev->dev.parent;
+	nand_chip->ecc.priv = NULL;
+	nand_set_flash_node(nand_chip, pdev->dev.parent->of_node);
+	nand_chip->priv = mxic;
+
+	mxic->mfd = mfd;
+
+	nand_chip->legacy.select_chip = mxic_nand_select_chip;
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
+static struct platform_driver mx25f0a_nand_driver = {
+	.probe		= mx25f0a_nand_probe,
+	.remove		= mx25f0a_nand_remove,
+	.driver		= {
+		.name	= "mxic-nand-ctlr",
+	},
+};
+module_platform_driver(mx25f0a_nand_driver);
+
+MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
+MODULE_DESCRIPTION("MX25F0A RAW NAND controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

