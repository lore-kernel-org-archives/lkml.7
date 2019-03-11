Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6004C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CD72084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eJLW49Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCKSCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:02:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13910 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfCKSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:02:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c86a2c60000>; Mon, 11 Mar 2019 11:02:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Mar 2019 11:02:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Mar 2019 11:02:47 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Mar
 2019 18:02:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Mar 2019 18:02:47 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.53]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c86a2c60003>; Mon, 11 Mar 2019 11:02:46 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 07/10] mmc: tegra: add Tegra186 WAR for CQE
Date:   Mon, 11 Mar 2019 11:02:36 -0700
Message-ID: <1552327359-8036-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552327366; bh=etkmK3KmFQ4A1/OcAzD4cpdR7F7bV4NetlK3LELBQfY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eJLW49YofxAzO4smzlAwqn6cwcuOaZi5X0ptruyxUFcy42Eu7M7GJk00WHIiNIiH3
         gim3AZBWrGVrswhYFM1e6mUCa+8nmy1e14WOFmA6HWXo3vP0XB/p9O6k1rKn2yGPB2
         JEsWF1/3g3UvYaZGu47mG7dS5CBXYrL6d/dgInXPRNfghNgrTVVPuFP+RME+S5YGFB
         kALfnsAnQKUOquxcvfSzBwNeFKqTQqAvDxLBRWM27x1RHSA2YXwjYVA7F7j8gkZXn9
         Wq4yK/iqy19FrMuRToaVQNS6Y6CzM1JnYVw3nceJEvkrVhiO1tc8vM7iq+SkVp4Bt8
         25jlAmT2S5DJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 CQHCI host has a known bug where CQHCI controller selects
DATA_PRESENT_SELECT bit to 1 for DCMDs with R1B response type and
since DCMD does not trigger any data transfer, DCMD task complete
happens leaving the DATA FSM of host controller in wait state for
the data.

This effects the data transfer tasks issued after the DCMDs with
R1b response type resulting in timeout.

SW WAR is to set CMD_TIMING to 1 in DCMD task descriptor. This bug
and SW WAR is applicable only for Tegra186 and not for Tegra194.

This patch implements this WAR thru NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING
for Tegra186 and also implements get_dcmd_cmd_timing cqhci_host_ops
interface to specify the CMD_TIMING bit depending on the NVQUIRK.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f1aa0591112a..1ac0ca37ce95 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -106,6 +106,7 @@
 #define NVQUIRK_HAS_PADCALIB				BIT(6)
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
+#define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -1123,6 +1124,21 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static u8 sdhci_tegra_cqe_dcmd_cmd_timing(struct mmc_host *mmc,
+					  struct mmc_request *mrq)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(mmc_priv(mmc));
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+
+	if (soc_data->nvquirks & NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING)
+		return 1;
+	else if (mrq->cmd->flags & MMC_RSP_R1B)
+		return 0;
+	else
+		return 1;
+}
+
 static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -1164,6 +1180,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
+	.get_dcmd_cmd_timing = sdhci_tegra_cqe_dcmd_cmd_timing,
 };
 
 static const struct sdhci_ops tegra_sdhci_ops = {
@@ -1345,7 +1362,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
-		    NVQUIRK_ENABLE_SDR104,
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING,
 	.min_tap_delay = 84,
 	.max_tap_delay = 136,
 };
-- 
2.7.4

