Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B04F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfC0JGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:06:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52323 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732429AbfC0JGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:06:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R91b5O013747;
        Wed, 27 Mar 2019 10:05:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rf4yc1uxk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Mar 2019 10:05:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA40049;
        Wed, 27 Mar 2019 09:05:49 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C03462B66;
        Wed, 27 Mar 2019 09:05:49 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Mar
 2019 10:05:49 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 27 Mar
 2019 10:05:47 +0100
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
Subject: [PATCH V4 5/5] mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback
Date:   Wed, 27 Mar 2019 10:05:32 +0100
Message-ID: <1553677532-3539-6-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_05:,,
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
 drivers/mmc/host/mmci.c | 26 ++------------------------
 drivers/mmc/host/mmci.h |  7 -------
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a818511..5b2cf77 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -60,7 +60,6 @@ static struct variant_data variant_arm = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
@@ -80,7 +79,6 @@ static struct variant_data variant_arm_extended_fifo = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -100,7 +98,6 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -121,7 +118,6 @@ static struct variant_data variant_u300 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
@@ -147,7 +143,6 @@ static struct variant_data variant_nomadik = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -176,7 +171,6 @@ static struct variant_data variant_ux500 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -210,11 +204,9 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
-	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.f_max			= 100000000,
 	.signal_direction	= true,
@@ -245,7 +237,6 @@ static struct variant_data variant_stm32 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -289,10 +280,8 @@ static struct variant_data variant_qcom = {
 	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
-	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
-	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -1007,7 +996,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	unsigned int datactrl, timeout, irqmask;
 	unsigned long long clks;
 	void __iomem *base;
-	int blksz_bits;
 
 	dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
 		data->blksz, data->blocks, data->flags);
@@ -1025,18 +1013,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
-
-	if (data->flags & MMC_DATA_READ)
-		datactrl |= MCI_DPSM_DIRECTION;
+	datactrl = host->ops->get_datactrl_cfg(host);
+	datactrl |= host->data->flags & MMC_DATA_READ ? MCI_DPSM_DIRECTION : 0;
 
 	if (host->mmc->card && mmc_card_sdio(host->mmc->card)) {
 		u32 clk;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 82e9f94..4f071bd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -280,12 +280,8 @@ struct mmci_host;
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
- * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
- * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
- *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
- * @datactrl_dpsm_enable: enable value for DPSM
  * @datactrl_first: true if data must be setup before send command
  * @datacnt_useless: true if you could not use datacnt register to read
  *		     remaining data
@@ -330,14 +326,11 @@ struct variant_data {
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
-	unsigned int		datactrl_dpsm_enable;
 	u8			datactrl_first:1;
 	u8			datacnt_useless:1;
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

