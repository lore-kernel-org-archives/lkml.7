Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B84F20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VZTRqa9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfCBFUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:20:55 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15121 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfCBFUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:53 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12b30000>; Fri, 01 Mar 2019 21:20:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Mar 2019 21:20:52 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:52 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:51 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12b10000>; Fri, 01 Mar 2019 21:20:51 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 08/11] mmc: tegra: add Tegra186 WAR for CQE
Date:   Fri, 1 Mar 2019 21:20:22 -0800
Message-ID: <1551504025-3541-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504051; bh=1B+N7uE+HVqMozipQL4sMXKkt7WcnsWeT4TSmtt5PYo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VZTRqa9sAIkv/NVS8AO5Ymz3T2BA+H6Z0Xc+Z7oQRHovXrOr3cE3LWAOvu0sckU/q
         Cg9CZd4K3Byo4o5OT3E2oMIYOx57fScP+sP+rqQQjgWEIQxxFbH2mTjQYVsKIHf3pP
         IS9VgXdNwfDBDt4SHhmOdYemgbnqxCTm5KY+Ia4YiyGB6/qogLBMkK4b+Jj8nLE34h
         4vSUzMoedLOQGxlhI1GLx+OE0L15ImqV7xOUctn45GSYM0QoqJLYVmzLgwP7DKeqGR
         gobFcTsgi8oQxa49N9k+51gcMCqSn6X08dW959cCx/itYchCVofaCYTsp0gPoIGFd5
         pfT6ltka32Wkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 design has a known bug where CQE does not generated task
complete interrupt for data transfer tasks issued after DCMD task
with R1b response type and results in timeout.

SW WAR is to set CMD_TIMING to 1 in task descriptor for DCMDs with
R1b response type. This bug and SW WAR is applicable only for
Tegra186 and not for Tegra194.

This patch adds this WAR to Tegra186.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2086e0eced88..2b63626dc2fa 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -116,6 +116,7 @@ struct sdhci_tegra_soc_data {
 	u32 nvquirks;
 	u8 min_tap_delay;
 	u8 max_tap_delay;
+	u32 cqequirks;
 };
 
 /* Magic pull up and pull down pad calibration offsets */
@@ -1354,6 +1355,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 		    NVQUIRK_ENABLE_SDR104,
 	.min_tap_delay = 84,
 	.max_tap_delay = 136,
+	.cqequirks = CQHCI_QUIRK_CMD_TIMING_R1B_DCMD,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
@@ -1383,6 +1385,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	struct cqhci_host *cq_host;
 	bool dma64;
 	int ret;
@@ -1407,6 +1410,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 
 	cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
 	cq_host->ops = &sdhci_tegra_cqhci_ops;
+	cq_host->quirks = soc_data->cqequirks;
 
 	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
 	if (dma64)
-- 
2.7.4

