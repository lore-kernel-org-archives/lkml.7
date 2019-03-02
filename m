Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C615EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD9620857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TUhlvNKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfCBFVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:21:02 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15131 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfCBFU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12b90000>; Fri, 01 Mar 2019 21:20:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Mar 2019 21:20:58 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:57 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:57 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12b70002>; Fri, 01 Mar 2019 21:20:57 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 10/11] mmc: tegra: fix CQE resume sequence
Date:   Fri, 1 Mar 2019 21:20:24 -0800
Message-ID: <1551504025-3541-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504057; bh=DV4Yb0Gbx+cmnhT168bdb37TlCyRQtmweHXGjuQjnMI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TUhlvNKEGdNOAR2JRRv4vyQ3wdxsvRPyLsKSIKqq+PTQbXqdy6+Ov/i4QKBn3aKnN
         pt4iiIimRCbPCz38qEYqUls6CyAhXKyQdkiexgQV6MGkOBBNvufWnJ9wYIHmq9OmNz
         6Q4tuqcNg9cyPDPWG8t7udHNUMAyZxccSJ0ePjBJHXJQaUcqsXjq8Rl2Msl1zd3/7F
         8HLEGCMAjX9dsnDhyi2/EuZt6iAi4m8FXZ8rsCimi1kTjiLkDPsbwN1UMNhL83WMmA
         86eu8iOCSWy35XpaZ653sNxulAs2TDGnREBg0ztoT3Mi5tIPj53rdeaK7wvF+0mcjD
         OGM4Vs+sisMWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra CQHCI/SDHCI design prevents write access to SDHCI block size
register when CQE is enabled and unhalted.

CQHCI driver enabled CQE prior to invoking sdhci_cqe_enable which
violates this Tegra specific host requirement.

This patch fixes this by configuring sdhci block registers prior
to CQE unhalt.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 71 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2b63626dc2fa..7063cfcdc590 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1126,23 +1126,75 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
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
+	if (!cq_host->activated) {
+		val = cqhci_readl(cq_host, CQHCI_CFG);
+		if (val & CQHCI_ENABLE)
+			cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
+				     CQHCI_CFG);
+		sdhci_cqe_enable(mmc);
+		if (val & CQHCI_ENABLE)
+			cqhci_writel(cq_host, val, CQHCI_CFG);
+	}
 
-	sdhci_cqe_enable(mmc);
+	/*
+	 * CMD CRC errors are seen sometimes with some eMMC devices when status
+	 * command is sent during transfer of last data block which is the
+	 * default case as send status command block counter (CBC) is 1.
+	 * So changing send status command block counter (CBC) to 0 to allow
+	 * send status command only when the data lines are idle.
+	 */
+	val = cqhci_readl(cq_host, CQHCI_SSC1);
+	val &= ~CQHCI_SSC1_CBC_MASK;
+	cqhci_writel(cq_host, val, CQHCI_SSC1);
 
-	if (cqcfg & CQHCI_ENABLE)
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 }
 
 static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
@@ -1167,6 +1219,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
+	.write_l    = tegra_cqhci_writel,
 };
 
 static const struct sdhci_ops tegra_sdhci_ops = {
-- 
2.7.4

