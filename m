Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4317C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90421019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCDKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:17:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbfCDKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:17:27 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24AGF7i013506;
        Mon, 4 Mar 2019 11:17:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhkmtr7k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:17:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B37138;
        Mon,  4 Mar 2019 10:17:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 139DE26B5;
        Mon,  4 Mar 2019 10:17:12 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 4 Mar 2019
 11:17:11 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 4 Mar 2019
 11:17:11 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
Date:   Mon, 4 Mar 2019 11:17:02 +0100
Message-ID: <1551694625-6414-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch defines get_dctrl_cfg callback for legacy variants
whatever DMA_ENGINE configuration.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..e1d3f42 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -47,11 +47,8 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
-#ifdef CONFIG_DMA_ENGINE
 void mmci_variant_init(struct mmci_host *host);
-#else
-static inline void mmci_variant_init(struct mmci_host *host) {}
-#endif
+void mmci_ux500v2_variant_init(struct mmci_host *host);
 
 #ifdef CONFIG_MMC_STM32_SDMMC
 void sdmmc_variant_init(struct mmci_host *host);
@@ -238,7 +235,7 @@ static struct variant_data variant_ux500v2 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
-	.init			= mmci_variant_init,
+	.init			= mmci_ux500v2_variant_init,
 };
 
 static struct variant_data variant_stm32 = {
@@ -624,6 +621,24 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
+u32 mmci_get_dctrl_cfg(struct mmci_host *host)
+{
+	struct variant_data *variant = host->variant;
+	int blksz_bits;
+
+	blksz_bits = ffs(host->data->blksz) - 1;
+	BUG_ON(1 << blksz_bits != host->data->blksz);
+
+	return variant->datactrl_dpsm_enable | blksz_bits << 4;
+}
+
+u32 mmci_ux500v2_get_dctrl_cfg(struct mmci_host *host)
+{
+	struct variant_data *variant = host->variant;
+
+	return variant->datactrl_dpsm_enable | (host->data->blksz << 16);
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -952,6 +967,7 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
 static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_datactrl_cfg = mmci_get_dctrl_cfg,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
@@ -959,12 +975,22 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_finalize = mmci_dmae_finalize,
 	.dma_error = mmci_dmae_error,
 };
+#else
+static struct mmci_host_ops mmci_variant_ops = {
+	.get_datactrl_cfg = mmci_get_dctrl_cfg,
+}
+#endif
 
 void mmci_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
 }
-#endif
+
+void mmci_ux500v2_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+	host->ops->get_datactrl_cfg = mmci_ux500v2_get_dctrl_cfg;
+}
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-- 
2.7.4

