Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F62D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfCZV1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:27:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:22518 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfCZV1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:27:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 14:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="135039056"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2019 14:27:09 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 1/2] EDAC, altera: Less Intrusive Error Injection
Date:   Tue, 26 Mar 2019 16:29:30 -0500
Message-Id: <1553635771-32693-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Improve the Arria10 and Stratix10 error injection routine
by reading the data and changing just 1 bit before writing
back out. Previous routine would overwrite the first bytes
to 0 then change 1 bit but this method is less intrusive.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 30 +++++++++++++-----------------
 drivers/edac/altera_edac.h |  2 +-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5ff263850cc7..acb3006df631 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1762,28 +1762,24 @@ static ssize_t altr_edac_a10_device_trig2(struct file *file,
 	if (trig_type == ALTR_UE_TRIGGER_CHAR) {
 		writel(priv->ue_set_mask, set_addr);
 	} else {
-		/* Setup write of 0 to first 4 bytes */
-		writel(0x0, drvdata->base + ECC_BLK_WDATA0_OFST);
-		writel(0x0, drvdata->base + ECC_BLK_WDATA1_OFST);
-		writel(0x0, drvdata->base + ECC_BLK_WDATA2_OFST);
-		writel(0x0, drvdata->base + ECC_BLK_WDATA3_OFST);
-		/* Setup write of 4 bytes */
+		/* Setup read/write of 4 bytes */
 		writel(ECC_WORD_WRITE, drvdata->base + ECC_BLK_DBYTECTRL_OFST);
 		/* Setup Address to 0 */
-		writel(0x0, drvdata->base + ECC_BLK_ADDRESS_OFST);
-		/* Setup accctrl to write & data override */
-		writel(ECC_WRITE_DOVR, drvdata->base + ECC_BLK_ACCCTRL_OFST);
-		/* Kick it. */
-		writel(ECC_XACT_KICK, drvdata->base + ECC_BLK_STARTACC_OFST);
-		/* Setup accctrl to read & ecc override */
-		writel(ECC_READ_EOVR, drvdata->base + ECC_BLK_ACCCTRL_OFST);
+		writel(0, drvdata->base + ECC_BLK_ADDRESS_OFST);
+		/* Setup accctrl to read & ecc & data override */
+		writel(ECC_READ_EDOVR, drvdata->base + ECC_BLK_ACCCTRL_OFST);
 		/* Kick it. */
 		writel(ECC_XACT_KICK, drvdata->base + ECC_BLK_STARTACC_OFST);
 		/* Setup write for single bit change */
-		writel(0x1, drvdata->base + ECC_BLK_WDATA0_OFST);
-		writel(0x0, drvdata->base + ECC_BLK_WDATA1_OFST);
-		writel(0x0, drvdata->base + ECC_BLK_WDATA2_OFST);
-		writel(0x0, drvdata->base + ECC_BLK_WDATA3_OFST);
+		writel(readl(drvdata->base + ECC_BLK_RDATA0_OFST) ^ 0x1,
+		       drvdata->base + ECC_BLK_WDATA0_OFST);
+		writel(readl(drvdata->base + ECC_BLK_RDATA1_OFST),
+		       drvdata->base + ECC_BLK_WDATA1_OFST);
+		writel(readl(drvdata->base + ECC_BLK_RDATA2_OFST),
+		       drvdata->base + ECC_BLK_WDATA2_OFST);
+		writel(readl(drvdata->base + ECC_BLK_RDATA3_OFST),
+		       drvdata->base + ECC_BLK_WDATA3_OFST);
+
 		/* Copy Read ECC to Write ECC */
 		writel(readl(drvdata->base + ECC_BLK_RECC0_OFST),
 		       drvdata->base + ECC_BLK_WECC0_OFST);
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 60513f201ffb..1532ec9c3510 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -321,7 +321,7 @@ struct altr_sdram_mc_data {
 #define ECC_BLK_STARTACC_OFST             0x7C
 
 #define ECC_XACT_KICK                     0x10000
-#define ECC_WORD_WRITE                    0xF
+#define ECC_WORD_WRITE                    0xFF
 #define ECC_WRITE_DOVR                    0x101
 #define ECC_WRITE_EDOVR                   0x103
 #define ECC_READ_EOVR                     0x2
-- 
2.7.4

