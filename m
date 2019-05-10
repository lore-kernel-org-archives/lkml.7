Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA96C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3236217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hHOxhui/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfEJDmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:42:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60536 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfEJDmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:42:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gIl0052819;
        Thu, 9 May 2019 22:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557459738;
        bh=9WENuppZV6fWDstTismJkuJrMr+VEXrDG+r1KBph3n8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hHOxhui/mBfbONA26oipz0laI+Wal5TOAXlo1vzxpGI2cflayBjWgG6SiMwUQAZfz
         lwtOw/geUZaTHNRyFyWBWaX7LgHLdiRy21I8x5hU0digCaVbmcc4gAgUINon+IfkL4
         G31QF0qlZ/D4OF2xQaMiWT9dkSbVbCg9f4+TwSQA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4A3gInp129524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 May 2019 22:42:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 9 May
 2019 22:42:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 9 May 2019 22:42:17 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gD2p002845;
        Thu, 9 May 2019 22:42:16 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 1/3] mmc: sdhci_am654: Improve line wrapping with regmap_*() calls
Date:   Fri, 10 May 2019 09:12:26 +0530
Message-ID: <20190510034228.32211-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190510034228.32211-1-faiz_abbas@ti.com>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
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
index a91c0b45c48d..337c24b8f4a8 100644
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
-			   ctl_cfg_2, SLOTTYPE_MASK);
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
+			   SLOTTYPE_MASK);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2

