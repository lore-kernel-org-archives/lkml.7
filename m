Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12547C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EF1218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZOERn+IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfCXEpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:45:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3242 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfCXEpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:45:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c970b700000>; Sat, 23 Mar 2019 21:45:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 23 Mar 2019 21:45:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 23 Mar 2019 21:45:33 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:33 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:32 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 24 Mar 2019 04:45:33 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.175]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c970b6b0001>; Sat, 23 Mar 2019 21:45:32 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 09/10] mmc: tegra: fix CQE enable and resume sequence
Date:   Sat, 23 Mar 2019 21:45:26 -0700
Message-ID: <1553402727-23130-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553402736; bh=DguQa0ntN9xE9Z540e0bu31/uO1/gabW7rA3OEYVaGk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZOERn+IAlcHon3uzFmKJFwpVbgfhxr2kcVOAxvlv009ZNLVQgb8t40PrWntvXLdbx
         DdxeWNXBX3rDWeos1m0niJpLSF88myZ+nqPOWMJBDIHbJTjZms3I0JQj2doiywAPLA
         HWGzJZVG/Z6llZzVaTDb/JQTDm0K2Ed2TjwrYASQMVm2tjCNH1Llojiq3scb0R7HHD
         X4EeVUKtOsDPNrjREA4ayj2sB6EHXSrN2qQpCxLmkkLUTss3M2XvJZtUEGzpgYXwol
         5dWRFNXOZmCRKF01DvxBb4F1j0Jr5MJFFh0PKg+zCHWxkh05jz0RH0VV1wJxUPWo+q
         liYWUa5DPeQQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra CQHCI/SDHCI design prevents write access to SDHCI block size
register when CQE is enabled and unhalted.

CQHCI driver enables CQE prior to invoking sdhci_cqe_enable which
violates this Tegra specific host requirement.

This patch fixes this by configuring sdhci block registers prior
to CQE unhalt.

This patch also has a fix for retry of unhalt due to known Tegra
specific CQE resume bug where first unhalt might not succeed when
clear all tasks is performed prior to resume and need a second unhalt.

This patch also includes CQE enable fix for CMD CRC errors that
happen with the specific sandisk emmc device when status command
is sent during the transfer of last data block due to marginal timing.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 72 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2f08b6e480df..eafaaefab4a6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1124,6 +1124,43 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
+{
+	struct mmc_host *mmc = cq_host->mmc;
+	u8 ctrl;
+	ktime_t timeout;
+	bool timed_out;
+
+	/*
+	 * During CQE resume/unhalt, CQHCI driver unhalts CQE prior to
+	 * cqhci_host_ops enable where SDHCI DMA and BLOCK_SIZE registers need
+	 * to be re-configured.
+	 * Tegra CQHCI/SDHCI prevents write access to block size register when
+	 * CQE is unhalted. So handling CQE resume sequence here to configure
+	 * SDHCI block registers prior to exiting CQE halt state.
+	 */
+	if (reg == CQHCI_CTL && !(val & CQHCI_HALT) &&
+	    cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
+		sdhci_cqe_enable(mmc);
+		writel(val, cq_host->mmio + reg);
+		timeout = ktime_add_us(ktime_get(), 50);
+		while (1) {
+			timed_out = ktime_compare(ktime_get(), timeout) > 0;
+			ctrl = cqhci_readl(cq_host, CQHCI_CTL);
+			if (!(ctrl & CQHCI_HALT) || timed_out)
+				break;
+		}
+		/*
+		 * CQE usually resumes very quick, but incase if Tegra CQE
+		 * doesn't resume retry unhalt.
+		 */
+		if (timed_out)
+			writel(val, cq_host->mmio + reg);
+	} else {
+		writel(val, cq_host->mmio + reg);
+	}
+}
+
 static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
 					 struct mmc_request *mrq, u64 *data)
 {
@@ -1139,20 +1176,34 @@ static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
 static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
-	u32 cqcfg = 0;
+	u32 val;
 
 	/*
-	 * Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
-	 * registers when CQE is enabled.
+	 * Tegra CQHCI/SDMMC design prevents write access to sdhci block size
+	 * register when CQE is enabled and unhalted.
+	 * CQHCI driver enables CQE prior to activation, so disable CQE before
+	 * programming block size in sdhci controller and enable it back.
 	 */
-	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-	if (cqcfg & CQHCI_ENABLE)
-		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
-
-	sdhci_cqe_enable(mmc);
+	if (!cq_host->activated) {
+		val = cqhci_readl(cq_host, CQHCI_CFG);
+		if (val & CQHCI_ENABLE)
+			cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
+				     CQHCI_CFG);
+		sdhci_cqe_enable(mmc);
+		if (val & CQHCI_ENABLE)
+			cqhci_writel(cq_host, val, CQHCI_CFG);
+	}
 
-	if (cqcfg & CQHCI_ENABLE)
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+	/*
+	 * CMD CRC errors are seen sometimes with some eMMC devices when status
+	 * command is sent during transfer of last data block which is the
+	 * default case as send status command block counter (CBC) is 1.
+	 * Recommended fix to set CBC to 0 allowing send status command only
+	 * when data lines are idle.
+	 */
+	val = cqhci_readl(cq_host, CQHCI_SSC1);
+	val &= ~CQHCI_SSC1_CBC_MASK;
+	cqhci_writel(cq_host, val, CQHCI_SSC1);
 }
 
 static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
@@ -1174,6 +1225,7 @@ static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
 }
 
 static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
+	.write_l    = tegra_cqhci_writel,
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
-- 
2.7.4

