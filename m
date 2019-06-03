Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E5C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC6227AD1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFCCTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:19:18 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:12474 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFCCTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:19:18 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x532JBjk041764;
        Mon, 3 Jun 2019 10:19:11 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org, vigneshr@ti.com, tglx@linutronix.de,
        frieder.schrempf@kontron.de, allison@lohutok.net
Cc:     juliensu@mxic.com.tw, masonccyang@mxic.com.tw
Subject: [PATCH v3] mtd: rawnand: Add Macronix NAND read retry support
Date:   Mon,  3 Jun 2019 10:42:04 +0800
Message-Id: <1559529724-5454-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x532JBjk041764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Macronix NAND read retry.

Macronix NANDs support specific read operation for data recovery,
which can be enabled with a SET_FEATURE.
Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
to see if this high-reliability function is supported.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index fad57c3..58511ae 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -8,6 +8,50 @@
 
 #include "internals.h"
 
+#define MACRONIX_READ_RETRY_BIT BIT(0)
+#define MACRONIX_NUM_READ_RETRY_MODES 6
+
+struct nand_onfi_vendor_macronix {
+	u8 reserved;
+	u8 reliability_func;
+} __packed;
+
+static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
+{
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
+
+	if (!chip->parameters.supports_set_get_features ||
+	    !test_bit(ONFI_FEATURE_ADDR_READ_RETRY,
+		      chip->parameters.set_feature_list))
+		return -ENOTSUPP;
+
+	feature[0] = mode;
+	return nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
+}
+
+static void macronix_nand_onfi_init(struct nand_chip *chip)
+{
+	struct nand_parameters *p = &chip->parameters;
+	struct nand_onfi_vendor_macronix *mxic;
+
+	if (!p->onfi)
+		return;
+
+	mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
+	if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
+		return;
+
+	chip->read_retries = MACRONIX_NUM_READ_RETRY_MODES;
+	chip->setup_read_retry = macronix_nand_setup_read_retry;
+
+	if (p->supports_set_get_features) {
+		bitmap_set(p->set_feature_list,
+			   ONFI_FEATURE_ADDR_READ_RETRY, 1);
+		bitmap_set(p->get_feature_list,
+			   ONFI_FEATURE_ADDR_READ_RETRY, 1);
+	}
+}
+
 /*
  * Macronix AC series does not support using SET/GET_FEATURES to change
  * the timings unlike what is declared in the parameter page. Unflag
@@ -56,6 +100,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
 
 	macronix_nand_fix_broken_get_timings(chip);
+	macronix_nand_onfi_init(chip);
 
 	return 0;
 }
-- 
1.9.1

