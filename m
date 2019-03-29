Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A09C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F8218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfC2Xod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:44:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbfC2Xoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:44:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hA1Ae-0007tw-4H; Fri, 29 Mar 2019 23:44:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scsi: pm8001: clean up structurally dead code when PM8001_USE_MSIX is defined
Date:   Fri, 29 Mar 2019 23:44:22 +0000
Message-Id: <20190329234423.5611-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329234423.5611-1-colin.king@canonical.com>
References: <20190329234423.5611-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

When macro PM8001_USE_MSIX is defined there is redundant dead code
call to pm8001_cr32.  Clean this up for the defined PM8001_USE_MSIX and
undefined PM8001_USE_MSIX cases.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 7 ++++---
 drivers/scsi/pm8001/pm80xx_hwi.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index e4209091c1da..434498a78946 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4625,15 +4625,16 @@ static int pm8001_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
 
 static u32 pm8001_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
 {
-	u32 value;
 #ifdef PM8001_USE_MSIX
 	return 1;
-#endif
+#else
+	u32 value;
+
 	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
 	if (value)
 		return 1;
 	return 0;
-
+#endif
 }
 
 /**
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 536d2b4384f8..4a176e60307f 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4619,15 +4619,16 @@ static int pm80xx_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
 
 static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
 {
-	u32 value;
 #ifdef PM8001_USE_MSIX
 	return 1;
-#endif
+#else
+	u32 value;
+
 	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
 	if (value)
 		return 1;
 	return 0;
-
+#endif
 }
 
 /**
-- 
2.20.1

