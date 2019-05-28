Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B8220B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mycHXKdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfE1J7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:59:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1J7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:59:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4S9xE30078207;
        Tue, 28 May 2019 04:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559037554;
        bh=Cp4y+AFCMfEq5wOuYkfYOdyUBX/LWntNSFazYsuZwQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mycHXKdcgqlPcqxZFnKEnd/0HaP6hO4PaYXSe/RVkR2W5I/U+Nan1yBG/aawPbSIE
         bn9N+zGmvpVw9KUUSwuEpH+m9zHJ57Kyol9vGbJD+H+LbmP10QKStvtVwww+NUAUbG
         5059M6zt2TiLB9sDabolflWVvqSEEWQB+OEYh0Qs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4S9xErV019732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 04:59:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 04:59:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 04:59:13 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4S9x7u9117581;
        Tue, 28 May 2019 04:59:12 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v3 2/3] mmc: sdhci_am654: Improve whitespace utilisation with regmap_*() calls
Date:   Tue, 28 May 2019 15:29:27 +0530
Message-ID: <20190528095928.26452-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190528095928.26452-1-faiz_abbas@ti.com>
References: <20190528095928.26452-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line wrapping with the regmap_*() functions is way more conservative
than required by the 80 character rule. Expand the function calls out to
use less number of lines.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 3222ea4d584d..3c32d9fb6e1e 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -88,8 +88,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	int ret;
 
 	if (sdhci_am654->dll_on) {
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   ENDLL_MASK, 0);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
 
 		sdhci_am654->dll_on = false;
 	}
@@ -101,8 +100,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 		val = (1 << OTAPDLYENA_SHIFT) |
 		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
-				   mask, val);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 		switch (clock) {
 		case 200000000:
 			sel50 = 0;
@@ -120,8 +118,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		/* Configure PHY DLL frequency */
 		mask = SEL50_MASK | SEL100_MASK;
 		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
-				   mask, val);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 		/* Configure DLL TRIM */
 		mask = DLL_TRIM_ICP_MASK;
 		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
@@ -129,20 +126,17 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		/* Configure DLL driver strength */
 		mask |= DR_TY_MASK;
 		val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   mask, val);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
 		/* Enable DLL */
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   ENDLL_MASK, 0x1 << ENDLL_SHIFT);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
+				   0x1 << ENDLL_SHIFT);
 		/*
 		 * Poll for DLL ready. Use a one second timeout.
 		 * Works in all experiments done so far
 		 */
-		ret = regmap_read_poll_timeout(sdhci_am654->base,
-					 PHY_STAT1, val,
-					 val & DLLRDY_MASK,
-					 1000, 1000000);
-
+		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
+					       val, val & DLLRDY_MASK, 1000,
+					       1000000);
 		sdhci_am654->dll_on = true;
 	}
 }
@@ -208,8 +202,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 
 	/* Reset OTAP to default value */
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
-				   mask, 0x0);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, 0x0);
 
 	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
 	if (~val & CALDONE_MASK) {
@@ -223,15 +216,14 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	}
 
 	/* Enable pins by setting IO mux to 0 */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-			   IOMUX_ENABLE_MASK, 0);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, IOMUX_ENABLE_MASK, 0);
 
 	/* Set slot type based on SD or eMMC */
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
-	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
-			   SLOTTYPE_MASK, ctl_cfg_2);
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
+			   ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2

