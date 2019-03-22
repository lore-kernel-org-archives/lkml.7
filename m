Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C329218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfCVOgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:36:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5351 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728310AbfCVOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:36:26 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MEXJpO012137;
        Fri, 22 Mar 2019 15:36:14 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8q5bvdue-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Mar 2019 15:36:14 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A530F31;
        Fri, 22 Mar 2019 14:36:13 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7089B5154;
        Fri, 22 Mar 2019 14:36:13 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Mar
 2019 15:36:13 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 22 Mar
 2019 15:36:13 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 2/2] spi: stm32-qspi: add dma support
Date:   Fri, 22 Mar 2019 15:35:54 +0100
Message-ID: <1553265354-16433-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
References: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds the dma support for the stm32-qspi hardware.
The memory buffer constraints (lowmem, vmalloc, kmap) are taken into
account by framework. In read mode, the memory map is preferred vs
dma (due to better throughput). If the dma transfer fails the buffer
is sent by polling.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 134 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 983584d..11a89aa 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -5,6 +5,8 @@
  */
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -84,6 +86,7 @@
 #define STM32_FIFO_TIMEOUT_US 30000
 #define STM32_BUSY_TIMEOUT_US 100000
 #define STM32_ABT_TIMEOUT_US 100000
+#define STM32_COMP_TIMEOUT_MS 1000
 
 struct stm32_qspi_flash {
 	struct stm32_qspi *qspi;
@@ -94,6 +97,7 @@ struct stm32_qspi_flash {
 struct stm32_qspi {
 	struct device *dev;
 	struct spi_controller *ctrl;
+	phys_addr_t phys_base;
 	void __iomem *io_base;
 	void __iomem *mm_base;
 	resource_size_t mm_size;
@@ -103,6 +107,10 @@ struct stm32_qspi {
 	struct completion data_completion;
 	u32 fmode;
 
+	struct dma_chan *dma_chtx;
+	struct dma_chan *dma_chrx;
+	struct completion dma_completion;
+
 	u32 cr_reg;
 	u32 dcr_reg;
 
@@ -181,6 +189,81 @@ static int stm32_qspi_tx_mm(struct stm32_qspi *qspi,
 	return 0;
 }
 
+static void stm32_qspi_dma_callback(void *arg)
+{
+	struct completion *dma_completion = arg;
+
+	complete(dma_completion);
+}
+
+static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
+			     const struct spi_mem_op *op)
+{
+	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction dma_dir;
+	struct dma_chan *dma_ch;
+	struct sg_table sgt;
+	dma_cookie_t cookie;
+	u32 cr, t_out;
+	int err;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dma_dir = DMA_DEV_TO_MEM;
+		dma_ch = qspi->dma_chrx;
+	} else {
+		dma_dir = DMA_MEM_TO_DEV;
+		dma_ch = qspi->dma_chtx;
+	}
+
+	/*
+	 * spi_map_buf return -EINVAL if the buffer is not DMA-able
+	 * (DMA-able: in vmalloc | kmap | virt_addr_valid)
+	 */
+	err = spi_controller_dma_map_mem_op_data(qspi->ctrl, op, &sgt);
+	if (err)
+		return err;
+
+	desc = dmaengine_prep_slave_sg(dma_ch, sgt.sgl, sgt.nents,
+				       dma_dir, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		err = -ENOMEM;
+		goto out_unmap;
+	}
+
+	cr = readl_relaxed(qspi->io_base + QSPI_CR);
+
+	reinit_completion(&qspi->dma_completion);
+	desc->callback = stm32_qspi_dma_callback;
+	desc->callback_param = &qspi->dma_completion;
+	cookie = dmaengine_submit(desc);
+	err = dma_submit_error(cookie);
+	if (err)
+		goto out;
+
+	dma_async_issue_pending(dma_ch);
+
+	writel_relaxed(cr | CR_DMAEN, qspi->io_base + QSPI_CR);
+
+	t_out = sgt.nents * STM32_COMP_TIMEOUT_MS;
+	if (!wait_for_completion_interruptible_timeout(&qspi->dma_completion,
+						       msecs_to_jiffies(t_out)))
+		err = -ETIMEDOUT;
+
+	if (dma_async_is_tx_complete(dma_ch, cookie,
+				     NULL, NULL) != DMA_COMPLETE)
+		err = -ETIMEDOUT;
+
+	if (err)
+		dmaengine_terminate_all(dma_ch);
+
+out:
+	writel_relaxed(cr & ~CR_DMAEN, qspi->io_base + QSPI_CR);
+out_unmap:
+	spi_controller_dma_unmap_mem_op_data(qspi->ctrl, op, &sgt);
+
+	return err;
+}
+
 static int stm32_qspi_tx(struct stm32_qspi *qspi, const struct spi_mem_op *op)
 {
 	if (!op->data.nbytes)
@@ -188,6 +271,10 @@ static int stm32_qspi_tx(struct stm32_qspi *qspi, const struct spi_mem_op *op)
 
 	if (qspi->fmode == CCR_FMODE_MM)
 		return stm32_qspi_tx_mm(qspi, op);
+	else if ((op->data.dir == SPI_MEM_DATA_IN && qspi->dma_chrx) ||
+		 (op->data.dir == SPI_MEM_DATA_OUT && qspi->dma_chtx))
+		if (!stm32_qspi_tx_dma(qspi, op))
+			return 0;
 
 	return stm32_qspi_tx_poll(qspi, op);
 }
@@ -218,7 +305,7 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	writel_relaxed(cr | CR_TCIE | CR_TEIE, qspi->io_base + QSPI_CR);
 
 	if (!wait_for_completion_interruptible_timeout(&qspi->data_completion,
-						msecs_to_jiffies(1000))) {
+				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS))) {
 		err = -ETIMEDOUT;
 	} else {
 		sr = readl_relaxed(qspi->io_base + QSPI_SR);
@@ -387,6 +474,49 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
+{
+	struct dma_slave_config dma_cfg;
+	struct device *dev = qspi->dev;
+
+	memset(&dma_cfg, 0, sizeof(dma_cfg));
+
+	dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_cfg.src_addr = qspi->phys_base + QSPI_DR;
+	dma_cfg.dst_addr = qspi->phys_base + QSPI_DR;
+	dma_cfg.src_maxburst = 4;
+	dma_cfg.dst_maxburst = 4;
+
+	qspi->dma_chrx = dma_request_slave_channel(dev, "rx");
+	if (qspi->dma_chrx) {
+		if (dmaengine_slave_config(qspi->dma_chrx, &dma_cfg)) {
+			dev_err(dev, "dma rx config failed\n");
+			dma_release_channel(qspi->dma_chrx);
+			qspi->dma_chrx = NULL;
+		}
+	}
+
+	qspi->dma_chtx = dma_request_slave_channel(dev, "tx");
+	if (qspi->dma_chtx) {
+		if (dmaengine_slave_config(qspi->dma_chtx, &dma_cfg)) {
+			dev_err(dev, "dma tx config failed\n");
+			dma_release_channel(qspi->dma_chtx);
+			qspi->dma_chtx = NULL;
+		}
+	}
+
+	init_completion(&qspi->dma_completion);
+}
+
+static void stm32_qspi_dma_free(struct stm32_qspi *qspi)
+{
+	if (qspi->dma_chtx)
+		dma_release_channel(qspi->dma_chtx);
+	if (qspi->dma_chrx)
+		dma_release_channel(qspi->dma_chrx);
+}
+
 /*
  * no special host constraint, so use default spi_mem_default_supports_op
  * to check supported mode.
@@ -399,6 +529,7 @@ static void stm32_qspi_release(struct stm32_qspi *qspi)
 {
 	/* disable qspi */
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
+	stm32_qspi_dma_free(qspi);
 	mutex_destroy(&qspi->lock);
 	clk_disable_unprepare(qspi->clk);
 	spi_master_put(qspi->ctrl);
@@ -479,6 +610,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	qspi->dev = dev;
 	platform_set_drvdata(pdev, qspi);
+	stm32_qspi_dma_setup(qspi);
 	mutex_init(&qspi->lock);
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
-- 
2.7.4

