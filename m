Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168CF20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCHNNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:13:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54517 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbfCHNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:12:50 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x28DAlDV012655;
        Fri, 8 Mar 2019 14:12:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r3gx52qpp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Mar 2019 14:12:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79E5D31;
        Fri,  8 Mar 2019 13:12:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FBD25572;
        Fri,  8 Mar 2019 13:12:38 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Mar 2019
 14:12:38 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Mar 2019
 14:12:37 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  2/2] spi: spi-mem: stm32-qspi: add suspend/resume support
Date:   Fri, 8 Mar 2019 14:12:21 +0100
Message-ID: <1552050741-27739-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552050741-27739-1-git-send-email-ludovic.Barre@st.com>
References: <1552050741-27739-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds suspend and resume support for spi-stm32-qspi
drivers.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 7354f9d..3e8ca10 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -101,6 +102,9 @@ struct stm32_qspi {
 	struct completion data_completion;
 	u32 fmode;
 
+	u32 cr_reg;
+	u32 dcr_reg;
+
 	/*
 	 * to protect device configuration, could be different between
 	 * 2 flash access (bk1, bk2)
@@ -355,7 +359,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	struct spi_controller *ctrl = spi->master;
 	struct stm32_qspi *qspi = spi_controller_get_devdata(ctrl);
 	struct stm32_qspi_flash *flash;
-	u32 cr, presc;
+	u32 presc;
 
 	if (ctrl->busy)
 		return -EBUSY;
@@ -371,11 +375,12 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	flash->presc = presc;
 
 	mutex_lock(&qspi->lock);
-	cr = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_SSHIFT | CR_EN;
-	writel_relaxed(cr, qspi->io_base + QSPI_CR);
+	qspi->cr_reg = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_SSHIFT | CR_EN;
+	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
-	writel_relaxed(DCR_FSIZE_MASK, qspi->io_base + QSPI_DCR);
+	qspi->dcr_reg = DCR_FSIZE_MASK;
+	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
 	mutex_unlock(&qspi->lock);
 
 	return 0;
@@ -489,6 +494,31 @@ static int stm32_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stm32_qspi_suspend(struct device *dev)
+{
+	struct stm32_qspi *qspi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(qspi->clk);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_qspi_resume(struct device *dev)
+{
+	struct stm32_qspi *qspi = dev_get_drvdata(dev);
+
+	pinctrl_pm_select_default_state(dev);
+	clk_prepare_enable(qspi->clk);
+
+	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
+	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
+
 static const struct of_device_id stm32_qspi_match[] = {
 	{.compatible = "st,stm32f469-qspi"},
 	{}
@@ -501,6 +531,7 @@ static struct platform_driver stm32_qspi_driver = {
 	.driver	= {
 		.name = "stm32-qspi",
 		.of_match_table = stm32_qspi_match,
+		.pm = &stm32_qspi_pm_ops,
 	},
 };
 module_platform_driver(stm32_qspi_driver);
-- 
2.7.4

