Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B195CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BE420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCGQjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:39:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbfCGQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:39:18 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27GaOn8030342;
        Thu, 7 Mar 2019 17:39:09 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315ut65a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 17:39:09 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12A8434;
        Thu,  7 Mar 2019 16:39:09 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E365D548F;
        Thu,  7 Mar 2019 16:39:08 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:39:08 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:39:08 +0100
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
Subject: [PATCH V2 2/6] mmc: mmci: add helper functions to define datactrl value for variants
Date:   Thu, 7 Mar 2019 17:38:58 +0100
Message-ID: <1551976742-4358-3-git-send-email-ludovic.Barre@st.com>
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

This patch adds default helper functions to define datactrl value.
Each variant could use these helpers to define datactrl and adds
their specific field.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 25 +++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9e6a2c1..28b76c5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -983,6 +983,31 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	mmci_unprep_data(host, data, err);
 }
 
+u32 mmci_dctrl_blksz(struct mmci_host *host)
+{
+	return (ffs(host->data->blksz) - 1) << 4;
+}
+
+u32 mmci_dctrl_dir(struct mmci_host *host)
+{
+	return host->data->flags & MMC_DATA_READ ? MCI_DPSM_DIRECTION : 0;
+}
+
+u32 mmci_dctrl_ddr(struct mmci_host *host)
+{
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
+	    host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
+		return host->variant->datactrl_mask_ddrmode;
+	return 0;
+}
+
+u32 mmci_dctrl_sdio(struct mmci_host *host)
+{
+	if (host->mmc->card && mmc_card_sdio(host->mmc->card))
+		return host->variant->datactrl_mask_sdio;
+	return 0;
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a59049b..32ae41d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -430,6 +430,11 @@ struct mmci_host {
 void mmci_write_clkreg(struct mmci_host *host, u32 clk);
 void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
 
+u32 mmci_dctrl_blksz(struct mmci_host *host);
+u32 mmci_dctrl_dir(struct mmci_host *host);
+u32 mmci_dctrl_ddr(struct mmci_host *host);
+u32 mmci_dctrl_sdio(struct mmci_host *host);
+
 #ifdef CONFIG_DMA_ENGINE
 int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
-- 
2.7.4

