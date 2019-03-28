Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33863C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFDF2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfC1Xng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:43:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45306 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbfC1Xng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:43:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h9egC-0004cC-GK; Thu, 28 Mar 2019 23:43:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pm8001: clean up structurally dead code when PM8001_USE_MSIX is defined
Date:   Thu, 28 Mar 2019 23:43:28 +0000
Message-Id: <20190328234328.15860-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

When macro PM8001_USE_MSIX is defined there are redundant dead code
calls to pm8001_chip_intx_interrupt_{enable|disable}. Clean this up
by compiling in the appropriate enable/disable handlers for the
defined PM8001_USE_MSIX and undefined PM8001_USE_MSIX cases.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index e4209091c1da..7d81246a432b 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1204,6 +1204,7 @@ void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
 	}
 }
 
+#ifndef PM8001_USE_MSIX
 /**
  * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
@@ -1225,6 +1226,8 @@ pm8001_chip_intx_interrupt_disable(struct pm8001_hba_info *pm8001_ha)
 	pm8001_cw32(pm8001_ha, 0, MSGU_ODMR, ODMR_MASK_ALL);
 }
 
+#else
+
 /**
  * pm8001_chip_msix_interrupt_enable - enable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
@@ -1256,6 +1259,7 @@ pm8001_chip_msix_interrupt_disable(struct pm8001_hba_info *pm8001_ha,
 	msi_index += MSIX_TABLE_BASE;
 	pm8001_cw32(pm8001_ha, 0,  msi_index, MSIX_INTERRUPT_DISABLE);
 }
+#endif
 
 /**
  * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
@@ -1266,10 +1270,9 @@ pm8001_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 #ifdef PM8001_USE_MSIX
 	pm8001_chip_msix_interrupt_enable(pm8001_ha, 0);
-	return;
-#endif
+#else
 	pm8001_chip_intx_interrupt_enable(pm8001_ha);
-
+#endif
 }
 
 /**
@@ -1281,10 +1284,9 @@ pm8001_chip_interrupt_disable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 #ifdef PM8001_USE_MSIX
 	pm8001_chip_msix_interrupt_disable(pm8001_ha, 0);
-	return;
-#endif
+#else
 	pm8001_chip_intx_interrupt_disable(pm8001_ha);
-
+#endif
 }
 
 /**
-- 
2.20.1

