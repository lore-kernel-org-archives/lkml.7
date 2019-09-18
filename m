Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F8CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F03921907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfIRHb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:31:57 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:18802 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfIRHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:31:57 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x8I7VoOd060926;
        Wed, 18 Sep 2019 15:31:50 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com
Cc:     marcel.ziswiler@toradex.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw, tglx@linutronix.de
Subject: [PATCH RFC 1/3] mtd: rawnand: Add support manufacturer postponed initialization
Date:   Wed, 18 Sep 2019 15:56:24 +0800
Message-Id: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com x8I7VoOd060926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manufacturer postponed initialization is for MTD default call-back
function replacement for vendor soecific operation, i.e.,
_lock/_unlock, _suspend/_resume and so on.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/internals.h |  4 ++++
 drivers/mtd/nand/raw/nand_base.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index cba6fe7..505dd46 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -42,6 +42,9 @@
  *	     is here to let vendor specific code release those resources.
  * @fixup_onfi_param_page: apply vendor specific fixups to the ONFI parameter
  *			   page. This is called after the checksum is verified.
+ * @post_init: postponed initialization is for MTD default call-back function
+ *	       replacement for vendor specific operation i.e., _lock/_unlock,
+ *	       _suspend/_resume and so on.
  */
 struct nand_manufacturer_ops {
 	void (*detect)(struct nand_chip *chip);
@@ -49,6 +52,7 @@ struct nand_manufacturer_ops {
 	void (*cleanup)(struct nand_chip *chip);
 	void (*fixup_onfi_param_page)(struct nand_chip *chip,
 				      struct nand_onfi_params *p);
+	void (*post_init)(struct nand_chip *chip);
 };
 
 /**
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 91f046d..7835b81 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4619,6 +4619,21 @@ static int nand_manufacturer_init(struct nand_chip *chip)
 }
 
 /*
+ * Manufacturer postponed initialization. This function is called for all NANDs
+ * whose MTD default call-back function replacement is needed.
+ * Manufacturer drivers should put all their specific postponed initialization
+ * code in their ->post_init() hook.
+ */
+static void nand_manufacturer_post_init(struct nand_chip *chip)
+{
+	if (!chip->manufacturer.desc || !chip->manufacturer.desc->ops ||
+	    !chip->manufacturer.desc->ops->post_init)
+		return;
+
+	return chip->manufacturer.desc->ops->post_init(chip);
+}
+
+/*
  * Manufacturer cleanup. This function is called for all NANDs including
  * ONFI and JEDEC compliant ones.
  * Manufacturer drivers should put all their specific cleanup code in their
@@ -5812,6 +5827,10 @@ static int nand_scan_tail(struct nand_chip *chip)
 			goto err_nanddev_cleanup;
 	}
 
+	nand_select_target(chip, 0);
+	nand_manufacturer_post_init(chip);
+	nand_deselect_target(chip);
+
 	/* Check, if we should skip the bad block table scan */
 	if (chip->options & NAND_SKIP_BBTSCAN)
 		return 0;
-- 
1.9.1

