Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85203C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D720830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfCZJLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:11:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbfCZJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:11:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q95mot004983;
        Tue, 26 Mar 2019 10:11:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddht8x6p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 10:11:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 228D442;
        Tue, 26 Mar 2019 09:11:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE0084DE4;
        Tue, 26 Mar 2019 09:11:22 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 10:11:22 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 10:11:22 +0100
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
Subject: [PATCH V3 4/5] mmc: mmci: stm32: define get_dctrl_cfg
Date:   Tue, 26 Mar 2019 10:11:09 +0100
Message-ID: <1553591470-31419-5-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch defines get_dctrl_cfg callback for sdmmc variant.
sdmmc variant has specific stm32 transfer modes.
sdmmc data transfer mode selection could be:
-Block data transfer ending on block count.
-SDIO multibyte data transfer.
-MMC Stream data transfer (not used).
-Block data transfer ending with STOP_TRANSMISSION command.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h             |  5 +++++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index c614ea7..fd24fdb 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -131,6 +131,11 @@
 /* Control register extensions in the Qualcomm versions */
 #define MCI_DPSM_QCOM_DATA_PEND	BIT(17)
 #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
+/* Control register extensions in STM32 versions */
+#define MCI_DPSM_STM32_MODE_BLOCK	(0 << 2)
+#define MCI_DPSM_STM32_MODE_SDIO	(1 << 2)
+#define MCI_DPSM_STM32_MODE_STREAM	(2 << 2)
+#define MCI_DPSM_STM32_MODE_BLOCK_STOP	(3 << 2)
 
 #define MMCIDATACNT		0x030
 #define MMCISTATUS		0x034
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index cfbfc6f..8e83ae6 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -265,10 +265,28 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
 	}
 }
 
+static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
+{
+	u32 datactrl;
+
+	datactrl = mmci_dctrl_blksz(host);
+
+	if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
+	    host->data->blocks == 1)
+		datactrl |= MCI_DPSM_STM32_MODE_SDIO;
+	else if (host->data->stop && !host->mrq->sbc)
+		datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
+	else
+		datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
+
+	return datactrl;
+}
+
 static struct mmci_host_ops sdmmc_variant_ops = {
 	.validate_data = sdmmc_idma_validate_data,
 	.prep_data = sdmmc_idma_prep_data,
 	.unprep_data = sdmmc_idma_unprep_data,
+	.get_datactrl_cfg = sdmmc_get_dctrl_cfg,
 	.dma_setup = sdmmc_idma_setup,
 	.dma_start = sdmmc_idma_start,
 	.dma_finalize = sdmmc_idma_finalize,
-- 
2.7.4

