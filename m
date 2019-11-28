Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B421775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pVsJFFRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK1LDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:03:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36688 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfK1LDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:03:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASB3evs123699;
        Thu, 28 Nov 2019 05:03:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574939020;
        bh=G96lW8XNsMp0RCszSNiwmH6PxDUpSoDquzZ72SszgDw=;
        h=From:To:CC:Subject:Date;
        b=pVsJFFRuHqFhC9MmNzDD4mn0Ic+KsF8oobuqf9se6ypuwlP9zEEvMkVrs/dM0pN3m
         +DuUVms3dCzJO1TIYDSIwt5zVIX/XMe5lh8Pyu0hBS1GO1tdKcikV+6n2X1FOWwnrQ
         hrDQMXsdGzl3r/uN+DdnJYXYU2pIY1Urg//F/QSw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASB3eNf051366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 05:03:40 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 05:03:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 05:03:40 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASB3bFE081207;
        Thu, 28 Nov 2019 05:03:38 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <faiz_abbas@ti.com>
Subject: [PATCH] Revert "mmc: sdhci: Fix incorrect switch to HS mode"
Date:   Thu, 28 Nov 2019 16:34:22 +0530
Message-ID: <20191128110422.25917-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37.

This commit aims to treat SD High speed and SDR25 as the same while
setting UHS Timings in HOST_CONTROL2 which leads to failures with some
SD cards in AM65x. Revert this commit.

The issue this commit was trying to fix can be implemented in a platform
specific callback instead of common sdhci code.

Cc: <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2e5dba..296d955ede59 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1882,9 +1882,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 	else if (timing == MMC_TIMING_UHS_SDR12)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-	else if (timing == MMC_TIMING_SD_HS ||
-		 timing == MMC_TIMING_MMC_HS ||
-		 timing == MMC_TIMING_UHS_SDR25)
+	else if (timing == MMC_TIMING_UHS_SDR25)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 	else if (timing == MMC_TIMING_UHS_SDR50)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-- 
2.19.2

