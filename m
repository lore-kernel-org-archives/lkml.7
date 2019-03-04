Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2252C2184E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCDKRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:17:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55650 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfCDKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:17:27 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24AGGPt013514;
        Mon, 4 Mar 2019 11:17:16 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhkmtr7v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:17:16 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CF3B31;
        Mon,  4 Mar 2019 10:17:15 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5893926B5;
        Mon,  4 Mar 2019 10:17:15 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 4 Mar 2019
 11:17:15 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 4 Mar 2019
 11:17:14 +0100
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
Subject: [PATCH  5/5] mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback
Date:   Mon, 4 Mar 2019 11:17:05 +0100
Message-ID: <1551694625-6414-6-git-send-email-ludovic.Barre@st.com>
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

This patch allows to get datactrl configuration specific
at variant. This introduce more flexibility on datactlr
value.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 13 +------------
 drivers/mmc/host/mmci.h |  5 -----
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e1d3f42..fe424ae 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -221,7 +221,6 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
-	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.f_max			= 100000000,
 	.signal_direction	= true,
@@ -296,7 +295,6 @@ static struct variant_data variant_qcom = {
 	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
-	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
@@ -1026,7 +1024,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	unsigned int datactrl, timeout, irqmask;
 	unsigned long long clks;
 	void __iomem *base;
-	int blksz_bits;
 
 	dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
 		data->blksz, data->blocks, data->flags);
@@ -1044,15 +1041,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	writel(timeout, base + MMCIDATATIMER);
 	writel(host->size, base + MMCIDATALENGTH);
 
-	blksz_bits = ffs(data->blksz) - 1;
-	BUG_ON(1 << blksz_bits != data->blksz);
-
-	if (variant->blksz_datactrl16)
-		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
-	else if (variant->blksz_datactrl4)
-		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
-	else
-		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
+	datactrl = host->ops->get_datactrl_cfg(host);
 
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index eb5d99af..fb5a83f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -280,9 +280,6 @@ struct mmci_host;
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
- * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
- * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
- *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
  * @datactrl_dpsm_enable: enable value for DPSM
@@ -336,8 +333,6 @@ struct variant_data {
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
 	u8			stm32_clkdiv:1;
-	u8			blksz_datactrl16:1;
-	u8			blksz_datactrl4:1;
 	u32			pwrreg_powerup;
 	u32			f_max;
 	u8			signal_direction:1;
-- 
2.7.4

