Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C053C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B3A20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCGQj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:39:29 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59569 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbfCGQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:39:26 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27GaOn9030342;
        Thu, 7 Mar 2019 17:39:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315ut65j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 17:39:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 232EB31;
        Thu,  7 Mar 2019 16:39:13 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F09C5548E;
        Thu,  7 Mar 2019 16:39:12 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:39:12 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:39:13 +0100
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
Subject: [PATCH V2 5/6] mmc: mmci: stm32: define get_dctrl_cfg
Date:   Thu, 7 Mar 2019 17:39:01 +0100
Message-ID: <1551976742-4358-6-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
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
 drivers/mmc/host/mmci_stm32_sdmmc.c | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bfc6e54..4d33c4f 100644
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
index cfbfc6f..4c710e1 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -265,10 +265,29 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
 	}
 }
 
+static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
+{
+	u32 datactrl;
+
+	datactrl = mmci_dctrl_blksz(host) | mmci_dctrl_dir(host);
+	datactrl |= mmci_dctrl_sdio(host) | mmci_dctrl_ddr(host);
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

