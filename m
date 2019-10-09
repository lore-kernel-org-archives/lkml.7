Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E0220859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfJIB2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:28:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:41440 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfJIB2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:28:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 18:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="345212608"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 08 Oct 2019 18:28:27 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        michal.simek@xilinx.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
Date:   Wed,  9 Oct 2019 09:28:18 +0800
Message-Id: <20191009012818.32763-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

The current arasan sdhci PHY configuration isn't compatible
with the PHY on Intel's LGM(Lightning Mountain) SoC devices.

Therefore, add a new compatible, to adapt the Intel's LGM
SDXC PHY with arasan-sdhc controller to configure the PHY.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 7023cbec4017..55de839a8a5e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -120,6 +120,12 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_emmc_soc_ctl_map = {
 	.hiword_update = false,
 };
 
+static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
+	.baseclkfreq = { .reg = 0x80, .width = 8, .shift = 2 },
+	.clockmultiplier = { .reg = 0, .width = -1, .shift = -1 },
+	.hiword_update = false,
+};
+
 /**
  * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
  *
@@ -384,6 +390,11 @@ static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
 	.pdata = &sdhci_arasan_cqe_pdata,
 };
 
+static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
+	.soc_ctl_map = &intel_lgm_sdxc_soc_ctl_map,
+	.pdata = &sdhci_arasan_cqe_pdata,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -489,6 +500,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "intel,lgm-sdhci-5.1-emmc",
 		.data = &intel_lgm_emmc_data,
 	},
+	{
+		.compatible = "intel,lgm-sdhci-5.1-sdxc",
+		.data = &intel_lgm_sdxc_data,
+	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
-- 
2.11.0

