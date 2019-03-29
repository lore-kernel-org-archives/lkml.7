Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7147C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6855206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RpKgE+4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfC2OWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:22:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfC2OWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:22:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TEMJ3R088227;
        Fri, 29 Mar 2019 09:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553869339;
        bh=Hf1I4JL1YAW4skLKsE8vMoLluuuGG356tCZImQjB+Fg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RpKgE+4roYaHkQz6Iw7bPxpvh+rpbmXSk8ITgnscXTGctvbg6SWMMOWdDgr/urN2y
         iyPg6uAqMDCV46Rmk+oMrECB2pcYhYw1yfGLpEzrNeFkcPzzxHGblu4VZ7LsTGjxgj
         P9gCq0gbmFfqa0E+0Yb/oLIoQ5bkBVsiVxdHnNQs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TEMJo8096411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:22:19 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 09:22:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 09:22:19 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TEMFPI097780;
        Fri, 29 Mar 2019 09:22:17 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under special conditions
Date:   Fri, 29 Mar 2019 19:52:01 +0530
Message-ID: <20190329142202.15000-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190329142202.15000-1-faiz_abbas@ti.com>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers on TI devices requires the HISPD bit to be cleared
even in some high speed modes. Add a quirk that facilitates this
requirement.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..ed4ed6054ddf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1916,18 +1916,30 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
-		if (ios->timing == MMC_TIMING_SD_HS ||
-		     ios->timing == MMC_TIMING_MMC_HS ||
-		     ios->timing == MMC_TIMING_MMC_HS400 ||
-		     ios->timing == MMC_TIMING_MMC_HS200 ||
-		     ios->timing == MMC_TIMING_MMC_DDR52 ||
-		     ios->timing == MMC_TIMING_UHS_SDR50 ||
-		     ios->timing == MMC_TIMING_UHS_SDR104 ||
-		     ios->timing == MMC_TIMING_UHS_DDR50 ||
-		     ios->timing == MMC_TIMING_UHS_SDR25)
-			ctrl |= SDHCI_CTRL_HISPD;
-		else
-			ctrl &= ~SDHCI_CTRL_HISPD;
+		if ((host->quirks2 & SDHCI_QUIRK2_TI_HISPD_BIT)) {
+			if (ios->timing == MMC_TIMING_MMC_HS400 ||
+			    ios->timing == MMC_TIMING_MMC_HS200 ||
+			    ios->timing == MMC_TIMING_MMC_DDR52 ||
+			    ios->timing == MMC_TIMING_UHS_SDR50 ||
+			    ios->timing == MMC_TIMING_UHS_SDR104 ||
+			    ios->timing == MMC_TIMING_UHS_DDR50)
+				ctrl |= SDHCI_CTRL_HISPD;
+			else
+				ctrl &= ~SDHCI_CTRL_HISPD;
+		} else {
+			if (ios->timing == MMC_TIMING_SD_HS ||
+			    ios->timing == MMC_TIMING_MMC_HS ||
+			    ios->timing == MMC_TIMING_MMC_HS400 ||
+			    ios->timing == MMC_TIMING_MMC_HS200 ||
+			    ios->timing == MMC_TIMING_MMC_DDR52 ||
+			    ios->timing == MMC_TIMING_UHS_SDR50 ||
+			    ios->timing == MMC_TIMING_UHS_SDR104 ||
+			    ios->timing == MMC_TIMING_UHS_DDR50 ||
+			    ios->timing == MMC_TIMING_UHS_SDR25)
+				ctrl |= SDHCI_CTRL_HISPD;
+			else
+				ctrl &= ~SDHCI_CTRL_HISPD;
+		}
 	}
 
 	if (host->version >= SDHCI_SPEC_300) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..aac026c5e184 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -485,6 +485,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Some TI devices need the high speed bit disabled even in high speed modes */
+#define SDHCI_QUIRK2_TI_HISPD_BIT			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.19.2

