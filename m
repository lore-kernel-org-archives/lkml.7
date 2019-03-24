Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F95C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3648218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EdcFhVHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfCXEpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:45:33 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3229 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfCXEp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:45:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c970b6b0000>; Sat, 23 Mar 2019 21:45:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 23 Mar 2019 21:45:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 23 Mar 2019 21:45:28 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 24 Mar 2019 04:45:28 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.175]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c970b660002>; Sat, 23 Mar 2019 21:45:27 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 07/10] mmc: tegra: add Tegra186 WAR for CQE
Date:   Sat, 23 Mar 2019 21:45:24 -0700
Message-ID: <1553402727-23130-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553402731; bh=XvBEM1ou6Cwc/840ianCBD/pVbq5vUB1W3wg0h5pFzQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EdcFhVHU7+/YmfQOkoEkA0Utd3ZSxgJu5vQ+ShnzN4nvd1JCUvEehdRPaiiM7GBJs
         ZT8qxEWtMe0rMou6Ffnmd+QhF1zSOFKxSRyy9d+8l76cHW0qDJTS4FEGyYvmzTHlAS
         bKnN1vQtgqXb5GsJq7bUtV3zauzliKqLiQxdJTeFOK0TfdfJk2g9upIYg5YWSdDfYO
         G/35HBTBDgVa7Zm/aysvl7q48VG3Nmahu9pa8+fQmiZMQuZTxwhCOMimhZvOz+VrMD
         3s3vqwtREbYel2TWsACQfNLYtlXdvSp06o0eh/Pq3GDHU5FteZcECnKcmoHsogvZRm
         ll6/Bx0MA4aaQ==
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
for Tegra186 and also implements update_dcmd_desc of cqhci_host_ops
interface to set CMD_TIMING bit depending on the NVQUIRK.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f1aa0591112a..2f08b6e480df 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -106,6 +106,7 @@
 #define NVQUIRK_HAS_PADCALIB				BIT(6)
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
+#define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -1123,6 +1124,18 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
+					 struct mmc_request *mrq, u64 *data)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(mmc_priv(mmc));
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+
+	if (soc_data->nvquirks & NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING &&
+	    mrq->cmd->flags & MMC_RSP_R1B)
+		*data |= CQHCI_CMD_TIMING(1);
+}
+
 static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -1164,6 +1177,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
+	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
 };
 
 static const struct sdhci_ops tegra_sdhci_ops = {
@@ -1345,7 +1359,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
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

