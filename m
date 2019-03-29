Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752362054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfC2IMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:12:03 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:11827 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbfC2IMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:12:03 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id x2T80oOR092471;
        Fri, 29 Mar 2019 16:00:50 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2T804vi091366;
        Fri, 29 Mar 2019 16:00:06 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date:   Fri, 29 Mar 2019 16:20:05 +0800
Message-Id: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2T804vi091366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 drivers/spi/Kconfig           |   6 +
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-renesas-rpc.c | 640 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 647 insertions(+)
 create mode 100644 drivers/spi/spi-renesas-rpc.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f761655..1f52bcf 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -564,6 +564,12 @@ config SPI_RSPI
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
+config SPI_RENESAS_RPC
+	tristate "Renesas R-Car Gen3 RPC-IF controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  SPI driver for Renesas R-Car Gen3 RPC-IF.
+
 config SPI_QCOM_QSPI
 	tristate "QTI QSPI controller"
 	depends on ARCH_QCOM
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d8fc03c..b3a3deb 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
+obj-$(CONFIG_SPI_RENESAS_RPC)		+= spi-renesas-rpc.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
 spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
new file mode 100644
index 0000000..037f273
--- /dev/null
+++ b/drivers/spi/spi-renesas-rpc.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver
+//
+// Author:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//
+
+#include <linux/mfd/renesas-rpc.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include <asm/unaligned.h>
+
+struct rpc_spi {
+	struct clk *clk_rpc;
+	void __iomem *base;
+	void __iomem *dirmap;
+	void __iomem *wbuf;
+	struct regmap *regmap;
+	u32 cur_speed_hz;
+	u32 cmd;
+	u32 addr;
+	u32 dummy;
+	u32 smcr;
+	u32 smenr;
+	u32 xferlen;
+	u32 totalxferlen;
+	enum spi_mem_data_dir xfer_dir;
+	struct reset_control *rstc;
+};
+
+static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
+{
+	int ret;
+
+	if (rpc->cur_speed_hz == freq)
+		return 0;
+
+	ret = clk_set_rate(rpc->clk_rpc, freq);
+	if (ret)
+		return ret;
+
+	rpc->cur_speed_hz = freq;
+	return ret;
+}
+
+static void rpc_spi_hw_init(struct rpc_spi *rpc)
+{
+	//
+	// NOTE: The 0x260 are undocumented bits, but they must be set.
+	//	 RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
+	//	 0x0 : the delay is biggest,
+	//	 0x1 : the delay is 2nd biggest,
+	//	 On H3 ES1.x, the value should be 0, while on others,
+	//	 the value should be 6.
+	//
+	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
+				  RPC_PHYCNT_STRTIM(6) | 0x260);
+
+	//
+	// NOTE: The 0x1511144 are undocumented bits, but they must be set
+	//       for RPC_PHYOFFSET1.
+	//	 The 0x31 are undocumented bits, but they must be set
+	//	 for RPC_PHYOFFSET2.
+	//
+	regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) |
+		     0x1511144);
+	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
+		     RPC_PHYOFFSET2_OCTTMG(4));
+	regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
+		     RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
+	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
+		     RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
+		     RPC_CMNCR_BSZ(0));
+}
+
+static int wait_msg_xfer_end(struct rpc_spi *rpc)
+{
+	u32 sts;
+
+	return regmap_read_poll_timeout(rpc->regmap, RPC_CMNSR, sts,
+					sts & RPC_CMNSR_TEND, 0, USEC_PER_SEC);
+}
+
+static u8 rpc_bits_set(u32 nbytes)
+{
+	nbytes = clamp(nbytes, 1U, 4U);
+
+	return GENMASK(3, 4 - nbytes);
+}
+
+static int rpc_spi_io_xfer(struct rpc_spi *rpc,
+			   const void *tx_buf, void *rx_buf)
+{
+	u32 smenr, smcr, data, pos = 0;
+	int ret;
+
+	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
+	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
+	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
+	regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
+	regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
+	smenr = rpc->smenr;
+
+	if (tx_buf) {
+		while (pos < rpc->xferlen) {
+			u32 nbytes = rpc->xferlen - pos;
+
+			regmap_write(rpc->regmap, RPC_SMWDR0,
+				     get_unaligned((u32 *)(tx_buf + pos)));
+
+			smcr = rpc->smcr | RPC_SMCR_SPIE;
+
+			if (nbytes > 4) {
+				nbytes = 4;
+				smcr |= RPC_SMCR_SSLKP;
+			}
+
+			regmap_write(rpc->regmap, RPC_SMENR, smenr);
+			regmap_write(rpc->regmap, RPC_SMCR, smcr);
+			ret = wait_msg_xfer_end(rpc);
+			if (ret)
+				goto err_out;
+
+			pos += nbytes;
+			smenr = rpc->smenr & ~RPC_SMENR_CDE &
+					     ~RPC_SMENR_ADE(0xf);
+		}
+	} else if (rx_buf) {
+		//
+		// RPC-IF spoils the data for the commands without an address
+		// phase (like RDID) in the manual mode, so we'll have to work
+		// around this issue by using the external address space read
+		// mode instead.
+		//
+		if (!(smenr & RPC_SMENR_ADE(0xf)) && rpc->dirmap) {
+			regmap_update_bits(rpc->regmap, RPC_CMNCR,
+					   RPC_CMNCR_MD, 0);
+			regmap_write(rpc->regmap, RPC_DRCR,
+				     RPC_DRCR_RBURST(32) | RPC_DRCR_RBE);
+			regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
+			regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
+			regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
+			regmap_write(rpc->regmap, RPC_DROPR, 0);
+			regmap_write(rpc->regmap, RPC_DRENR, smenr);
+			memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);
+			regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
+		} else {
+			while (pos < rpc->xferlen) {
+				u32 nbytes = rpc->xferlen - pos;
+
+				if (nbytes > 4)
+					nbytes = 4;
+
+				regmap_write(rpc->regmap, RPC_SMENR, smenr);
+				regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr |
+					     RPC_SMCR_SPIE);
+				ret = wait_msg_xfer_end(rpc);
+				if (ret)
+					goto err_out;
+
+				regmap_read(rpc->regmap, RPC_SMRDR0, &data);
+				memcpy(rx_buf + pos, &data, nbytes);
+				pos += nbytes;
+
+				regmap_write(rpc->regmap, RPC_SMADR,
+					     rpc->addr + pos);
+			}
+		}
+	} else {
+		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
+		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
+		ret = wait_msg_xfer_end(rpc);
+		if (ret)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	return reset_control_reset(rpc->rstc);
+}
+
+static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
+					const struct spi_mem_op *op,
+					u64 *offs, size_t *len)
+{
+	struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
+
+	rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
+	rpc->smenr = RPC_SMENR_CDE |
+		     RPC_SMENR_CDB(ilog2(op->cmd.buswidth));
+	rpc->totalxferlen = 1;
+	rpc->xfer_dir = SPI_MEM_NO_DATA;
+	rpc->xferlen = 0;
+	rpc->addr = 0;
+
+	if (op->addr.nbytes) {
+		rpc->smenr |= RPC_SMENR_ADB(ilog2(op->addr.buswidth));
+		if (op->addr.nbytes == 4)
+			rpc->smenr |= RPC_SMENR_ADE(0xf);
+		else
+			rpc->smenr |= RPC_SMENR_ADE(0x7);
+
+		if (offs && len)
+			rpc->addr = *offs;
+		else
+			rpc->addr = op->addr.val;
+		rpc->totalxferlen += op->addr.nbytes;
+	}
+
+	if (op->dummy.nbytes) {
+		rpc->smenr |= RPC_SMENR_DME;
+		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
+		rpc->totalxferlen += op->dummy.nbytes;
+	}
+
+	if (op->data.nbytes || (offs && len)) {
+		switch (op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			rpc->smcr = RPC_SMCR_SPIRE;
+			rpc->xfer_dir = SPI_MEM_DATA_IN;
+			break;
+		case SPI_MEM_DATA_OUT:
+			rpc->smcr = RPC_SMCR_SPIWE;
+			rpc->xfer_dir = SPI_MEM_DATA_OUT;
+			break;
+		default:
+			break;
+		}
+
+		if (offs && len) {
+			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_set(*len)) |
+				      RPC_SMENR_SPIDB(ilog2(op->data.buswidth));
+			rpc->xferlen = *len;
+			rpc->totalxferlen += *len;
+		} else {
+			rpc->smenr |=
+				RPC_SMENR_SPIDE(rpc_bits_set(op->data.nbytes)) |
+				RPC_SMENR_SPIDB(ilog2(op->data.buswidth));
+			rpc->xferlen = op->data.nbytes;
+			rpc->totalxferlen += op->data.nbytes;
+		}
+	}
+}
+
+static bool rpc_spi_mem_supports_op(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
+	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
+	    op->addr.nbytes > 4)
+		return false;
+
+	return true;
+}
+
+static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				       u64 offs, size_t len, void *buf)
+{
+	struct rpc_spi *rpc =
+			spi_controller_get_devdata(desc->mem->spi->controller);
+	int ret;
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	if (len > 0x4000000)
+		len = 0x4000000;
+
+	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
+				    &desc->info.op_tmpl, &offs, &len);
+
+	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
+	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
+		     RPC_DRCR_RBE);
+
+	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
+	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
+	regmap_write(rpc->regmap, RPC_DROPR, 0);
+	regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr);
+	regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
+	regmap_write(rpc->regmap, RPC_DRDRENR, 0);
+
+	memcpy_fromio(buf, rpc->dirmap + desc->info.offset + offs, len);
+
+	return len;
+}
+
+static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+					u64 offs, size_t len, const void *buf)
+{
+	struct rpc_spi *rpc =
+			spi_controller_get_devdata(desc->mem->spi->controller);
+	int ret;
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	if (len > RPC_WBUF_SIZE)
+		len = RPC_WBUF_SIZE;
+
+	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
+				    &desc->info.op_tmpl, &offs, &len);
+
+	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
+
+	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
+
+	regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
+			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
+			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
+
+	memcpy_toio(rpc->wbuf, buf, len);
+
+	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
+	regmap_write(rpc->regmap, RPC_SMADR, offs);
+	regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
+	regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
+	ret = wait_msg_xfer_end(rpc);
+	if (ret)
+		goto err_out;
+
+	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
+
+	regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
+			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
+			   RPC_PHYCNT_STRTIM(6));
+
+	return len;
+
+err_out:
+	return reset_control_reset(rpc->rstc);
+}
+
+static int rpc_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct rpc_spi *rpc =
+			spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -ENOTSUPP;
+
+	if (!rpc_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	if (!rpc->dirmap &&
+	    desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	if (!rpc->wbuf &&
+	    desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int rpc_spi_mem_exec_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct rpc_spi *rpc = spi_controller_get_devdata(mem->spi->controller);
+	int ret;
+
+	ret = rpc_spi_set_freq(rpc, mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	rpc_spi_mem_set_prep_op_cfg(mem->spi, op, NULL, NULL);
+
+	ret = rpc_spi_io_xfer(rpc,
+			      op->data.dir == SPI_MEM_DATA_OUT ?
+			      op->data.buf.out : NULL,
+			      op->data.dir == SPI_MEM_DATA_IN ?
+			      op->data.buf.in : NULL);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops rpc_spi_mem_ops = {
+	.supports_op = rpc_spi_mem_supports_op,
+	.exec_op = rpc_spi_mem_exec_op,
+	.dirmap_create = rpc_spi_mem_dirmap_create,
+	.dirmap_read = rpc_spi_mem_dirmap_read,
+	.dirmap_write = rpc_spi_mem_dirmap_write,
+};
+
+static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
+				   struct spi_message *msg)
+{
+	struct spi_transfer *t, xfer[4] = { };
+	u32 i, xfercnt, xferpos = 0;
+
+	rpc->totalxferlen = 0;
+	rpc->xfer_dir = SPI_MEM_NO_DATA;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->tx_buf) {
+			xfer[xferpos].tx_buf = t->tx_buf;
+			xfer[xferpos].tx_nbits = t->tx_nbits;
+		}
+
+		if (t->rx_buf) {
+			xfer[xferpos].rx_buf = t->rx_buf;
+			xfer[xferpos].rx_nbits = t->rx_nbits;
+		}
+
+		if (t->len) {
+			xfer[xferpos++].len = t->len;
+			rpc->totalxferlen += t->len;
+		}
+
+		if (list_is_last(&t->transfer_list, &msg->transfers)) {
+			if (xferpos > 1) {
+				if (t->rx_buf) {
+					rpc->xfer_dir = SPI_MEM_DATA_IN;
+					rpc->smcr = RPC_SMCR_SPIRE;
+				} else if (t->tx_buf) {
+					rpc->xfer_dir = SPI_MEM_DATA_OUT;
+					rpc->smcr = RPC_SMCR_SPIWE;
+				}
+			}
+		}
+	}
+
+	xfercnt = xferpos;
+	rpc->xferlen = xfer[--xferpos].len;
+	rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
+	rpc->smenr = RPC_SMENR_CDE |
+		     RPC_SMENR_CDB(ilog2((unsigned int)xfer[0].tx_nbits));
+	rpc->addr = 0;
+
+	if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
+		rpc->smenr |=
+			RPC_SMENR_ADB(ilog2((unsigned int)xfer[1].tx_nbits));
+
+		for (i = 0; i < xfer[1].len; i++)
+			rpc->addr |= ((u8 *)xfer[1].tx_buf)[i] <<
+				     (8 * (xfer[1].len - i - 1));
+
+		if (xfer[1].len == 4)
+			rpc->smenr |= RPC_SMENR_ADE(0xf);
+		else
+			rpc->smenr |= RPC_SMENR_ADE(0x7);
+	}
+
+	if (xfercnt > 3 && xfer[2].len && xfer[2].tx_buf) {
+		rpc->smenr |= RPC_SMENR_DME;
+		rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);
+	}
+
+	for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
+		if (xfer[i].rx_buf) {
+			rpc->smenr |=
+				RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
+				RPC_SMENR_SPIDB(ilog2
+					((unsigned int)xfer[i].rx_nbits));
+		} else if (xfer[i].tx_buf) {
+			rpc->smenr |=
+				RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
+				RPC_SMENR_SPIDB(ilog2
+					((unsigned int)xfer[i].tx_nbits));
+		}
+	}
+}
+
+static inline int rpc_spi_xfer_message(struct rpc_spi *rpc,
+				       struct spi_transfer *data_xfer)
+{
+	int ret;
+
+	ret = rpc_spi_set_freq(rpc, data_xfer->speed_hz);
+	if (ret)
+		return ret;
+
+	ret = rpc_spi_io_xfer(rpc,
+			      rpc->xfer_dir == SPI_MEM_DATA_OUT ?
+			      data_xfer->tx_buf : NULL,
+			      rpc->xfer_dir == SPI_MEM_DATA_IN ?
+			      data_xfer->rx_buf : NULL);
+
+	return ret;
+}
+
+static int rpc_spi_transfer_one_message(struct spi_controller *ctlr,
+					struct spi_message *msg)
+{
+	struct rpc_spi *rpc = spi_controller_get_devdata(ctlr);
+	struct spi_transfer *data_xfer;
+	int ret;
+
+	rpc_spi_transfer_setup(rpc, msg);
+
+	data_xfer = list_last_entry(&msg->transfers, struct spi_transfer,
+				    transfer_list);
+
+	ret = rpc_spi_xfer_message(rpc, data_xfer);
+	if (ret)
+		goto out;
+
+	msg->status = 0;
+	msg->actual_length = rpc->totalxferlen;
+out:
+	spi_finalize_current_message(ctlr);
+	return 0;
+}
+
+static int rpc_spi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
+	struct rpc_spi *rpc;
+	int ret;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	rpc = spi_controller_get_devdata(ctlr);
+
+	ctlr->dev.of_node = pdev->dev.of_node;
+
+	rpc->clk_rpc = rpc_mfd->clk_rpc;
+	if (IS_ERR(rpc->clk_rpc))
+		return PTR_ERR(rpc->clk_rpc);
+
+	rpc->base = rpc_mfd->base;
+	if (IS_ERR(rpc->base))
+		return PTR_ERR(rpc->base);
+
+	rpc->regmap = rpc_mfd->regmap;
+	if (IS_ERR(rpc->regmap)) {
+		dev_err(&pdev->dev,
+			"failed to regmap for rpc-spi, error %ld\n",
+			PTR_ERR(rpc->regmap));
+		return PTR_ERR(rpc->regmap);
+	}
+
+	rpc->dirmap = rpc_mfd->dirmap;
+	if (IS_ERR(rpc->dirmap))
+		rpc->dirmap = NULL;
+
+	rpc->wbuf = rpc_mfd->wbuf;
+	if (IS_ERR(rpc->wbuf))
+		rpc->wbuf = NULL;
+
+	rpc->rstc = rpc_mfd->rstc;
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
+
+	pm_runtime_enable(&pdev->dev);
+	ctlr->auto_runtime_pm = true;
+
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &rpc_spi_mem_ops;
+	ctlr->transfer_one_message = rpc_spi_transfer_one_message;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
+
+	rpc_spi_hw_init(rpc);
+
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto err_put_ctlr;
+	}
+	return 0;
+
+err_put_ctlr:
+	spi_controller_put(ctlr);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int rpc_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	spi_unregister_controller(ctlr);
+
+	return 0;
+}
+
+static const struct of_device_id rpc_spi_of_ids[] = {
+	{ .compatible = "renesas,rcar-rpc-spi", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);
+
+#ifdef CONFIG_PM_SLEEP
+static int rpc_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(ctlr);
+}
+
+static int rpc_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_resume(ctlr);
+}
+
+static SIMPLE_DEV_PM_OPS(rpc_spi_pm_ops, rpc_spi_suspend, rpc_spi_resume);
+#define DEV_PM_OPS	(&rpc_spi_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
+static struct platform_driver rpc_spi_driver = {
+	.probe = rpc_spi_probe,
+	.remove = rpc_spi_remove,
+	.driver = {
+		.name = "rpc-spi",
+		.of_match_table = rpc_spi_of_ids,
+		.pm = DEV_PM_OPS,
+	},
+};
+module_platform_driver(rpc_spi_driver);
+
+MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
+MODULE_DESCRIPTION("Renesas R-Car Gen3 RPC-IF SPI controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

