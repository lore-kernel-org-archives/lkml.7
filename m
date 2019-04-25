Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDCC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E74B206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sjxa+hx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfDYP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:57:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42746 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfDYP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:57:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3PFvXc0130829;
        Thu, 25 Apr 2019 10:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556207853;
        bh=ieA7z+0Mo0A5cYXdl7wbpLcDZbeNK5pdWrNVFG0jHjM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sjxa+hx5r215lws9vv7ReZPH19QCnTwX4MsILGOJlEGi1qQeiKPvbsEF3+WSFbi7A
         m9umy/cjdJS5HNjTzOZuQalb9rJR26e6MgJwGBguz2rDJO1pN85DzzxQEisPOx7FRb
         V6Le5Jw4uwJh843ejSCwt7Maa0G89lVmkRXx73+I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3PFvXUN006983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Apr 2019 10:57:33 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Apr 2019 10:57:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Apr 2019 10:57:33 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3PFvRWq029003;
        Thu, 25 Apr 2019 10:57:31 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
Date:   Thu, 25 Apr 2019 21:27:27 +0530
Message-ID: <20190425155727.20010-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190425155727.20010-1-faiz_abbas@ti.com>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 866a9082705f..613b151a73c5 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -205,8 +205,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
-	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
-			   SLOTTYPE_MASK);
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
+			   ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2

