Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913D720717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbfJ1J34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:29:56 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:61742 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbfJ1J3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:29:55 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x9S9TQPQ013435;
        Mon, 28 Oct 2019 17:29:30 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw
Subject: [PATCH v2 4/4] mtd: rawnand: Add support Macronix deep power down mode
Date:   Mon, 28 Oct 2019 17:55:27 +0800
Message-Id: <1572256527-5074-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x9S9TQPQ013435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix AD series support deep power down mode for a minimum
power consumption state.

Patch nand_suspend() & nand_resume() by Macronix specific
deep power down mode command and exit it.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 72 +++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 13929bf..3098bc0 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -15,6 +15,8 @@
 #define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
 #define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
 
+#define NAND_CMD_POWER_DOWN 0xB9
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved;
 	u8 reliability_func;
@@ -137,13 +139,66 @@ static int mxic_nand_unlock(struct nand_chip *chip, loff_t ofs, uint64_t len)
 	return ret;
 }
 
+int nand_power_down_op(struct nand_chip *chip)
+{
+	int ret;
+
+	if (nand_has_exec_op(chip)) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_POWER_DOWN, 0),
+		};
+
+		struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
+
+		ret = nand_exec_op(chip, &op);
+		if (ret)
+			return ret;
+
+	} else {
+		chip->legacy.cmdfunc(chip, NAND_CMD_POWER_DOWN, -1, -1);
+	}
+
+	return 0;
+}
+
+static int mxic_nand_suspend(struct nand_chip *chip)
+{
+	int ret;
+
+	nand_select_target(chip, 0);
+	ret = nand_power_down_op(chip);
+	if (ret < 0)
+		pr_err("%s called for chip into suspend failed\n", __func__);
+	nand_deselect_target(chip);
+
+	return ret;
+}
+
+static void mxic_nand_resume(struct nand_chip *chip)
+{
+	/*
+	 * Toggle #CS pin to resume NAND device and don't care
+	 * of the others CLE, #WE, #RE pins status.
+	 * Here sending power down command to toggle #CS line.
+	 */
+	nand_select_target(chip, 0);
+	nand_power_down_op(chip);
+	nand_deselect_target(chip);
+}
+
 /*
- * Macronix NAND AC series support Block Protection by SET_FEATURES
+ * Macronix NAND AC & AD series support Block Protection by SET_FEATURES
  * to lock/unlock blocks.
  */
 static int macronix_nand_init(struct nand_chip *chip)
 {
-	bool blockprotected = false;
+	unsigned int i;
+	bool blockprotected = false, powerdown = false;
+	static const char * const power_down_dev[] = {
+		"MX30LF1G28AD",
+		"MX30LF2G28AD",
+		"MX30LF4G28AD",
+	};
 
 	if (nand_is_slc(chip))
 		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
@@ -153,6 +208,14 @@ static int macronix_nand_init(struct nand_chip *chip)
 
 	macronix_nand_onfi_init(chip);
 
+	for (i = 0; i < ARRAY_SIZE(power_down_dev); i++) {
+		if (!strcmp(power_down_dev[i], chip->parameters.model)) {
+			blockprotected = true;
+			powerdown = true;
+			break;
+		}
+	}
+
 	if (blockprotected) {
 		bitmap_set(chip->parameters.set_feature_list,
 			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
@@ -163,6 +226,11 @@ static int macronix_nand_init(struct nand_chip *chip)
 		chip->_unlock = mxic_nand_unlock;
 	}
 
+	if (powerdown) {
+		chip->_suspend = mxic_nand_suspend;
+		chip->_resume = mxic_nand_resume;
+	}
+
 	return 0;
 }
 
-- 
1.9.1

