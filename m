Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5243C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfCYRCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:02:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15507 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbfCYRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:02:07 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PGwMCJ031508;
        Mon, 25 Mar 2019 18:01:57 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddht4y4f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Mar 2019 18:01:57 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74EB838;
        Mon, 25 Mar 2019 17:01:56 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 571FB1120;
        Mon, 25 Mar 2019 17:01:56 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 25 Mar
 2019 18:01:56 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 25 Mar
 2019 18:01:56 +0100
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
Subject: [PATCH V2 1/2] spi: stm32-qspi: add spi_master_put in release function
Date:   Mon, 25 Mar 2019 18:01:39 +0100
Message-ID: <1553533300-29999-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553533300-29999-1-git-send-email-ludovic.Barre@st.com>
References: <1553533300-29999-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds spi_master_put in release function
to drop the controller's refcount.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 46 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 7879a52..9875139 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -93,6 +93,7 @@ struct stm32_qspi_flash {
 
 struct stm32_qspi {
 	struct device *dev;
+	struct spi_controller *ctrl;
 	void __iomem *io_base;
 	void __iomem *mm_base;
 	resource_size_t mm_size;
@@ -400,6 +401,7 @@ static void stm32_qspi_release(struct stm32_qspi *qspi)
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
 	mutex_destroy(&qspi->lock);
 	clk_disable_unprepare(qspi->clk);
+	spi_master_put(qspi->ctrl);
 }
 
 static int stm32_qspi_probe(struct platform_device *pdev)
@@ -416,43 +418,54 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qspi = spi_controller_get_devdata(ctrl);
+	qspi->ctrl = ctrl;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi");
 	qspi->io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qspi->io_base))
-		return PTR_ERR(qspi->io_base);
+	if (IS_ERR(qspi->io_base)) {
+		ret = PTR_ERR(qspi->io_base);
+		goto err;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
 	qspi->mm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qspi->mm_base))
-		return PTR_ERR(qspi->mm_base);
+	if (IS_ERR(qspi->mm_base)) {
+		ret = PTR_ERR(qspi->mm_base);
+		goto err;
+	}
 
 	qspi->mm_size = resource_size(res);
-	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ)
-		return -EINVAL;
+	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		return ret;
+		goto err;
 	}
 
 	init_completion(&qspi->data_completion);
 
 	qspi->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(qspi->clk))
-		return PTR_ERR(qspi->clk);
+	if (IS_ERR(qspi->clk)) {
+		ret = PTR_ERR(qspi->clk);
+		goto err;
+	}
 
 	qspi->clk_rate = clk_get_rate(qspi->clk);
-	if (!qspi->clk_rate)
-		return -EINVAL;
+	if (!qspi->clk_rate) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = clk_prepare_enable(qspi->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
-		return ret;
+		goto err;
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
@@ -475,14 +488,11 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	ctrl->dev.of_node = dev->of_node;
 
 	ret = devm_spi_register_master(dev, ctrl);
-	if (ret)
-		goto err_spi_register;
-
-	return 0;
+	if (!ret)
+		return 0;
 
-err_spi_register:
+err:
 	stm32_qspi_release(qspi);
-
 	return ret;
 }
 
-- 
2.7.4

