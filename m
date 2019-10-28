Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BCFCA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D186D20717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfJ1J3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:29:39 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:61717 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbfJ1J3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:29:39 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x9S9TQPN013435;
        Mon, 28 Oct 2019 17:29:27 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw
Subject: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock operatoin
Date:   Mon, 28 Oct 2019 17:55:24 +0800
Message-Id: <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x9S9TQPN013435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nand_lock() & nand_unlock() for manufacturer specific lock & unlock
operation while the device supports Block Protection function.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_base.c | 32 ++++++++++++++++++++++++++++++--
 include/linux/mtd/rawnand.h      |  3 +++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 5c2c30a..5e318ff 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4356,6 +4356,34 @@ static void nand_shutdown(struct mtd_info *mtd)
 	nand_suspend(mtd);
 }
 
+/**
+ * nand_lock - [MTD Interface] Lock the NAND flash
+ * @mtd: MTD device structure
+ */
+static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (!chip->_lock)
+		return -ENOTSUPP;
+
+	return chip->_lock(chip, ofs, len);
+}
+
+/**
+ * nand_unlock - [MTD Interface] Unlock the NAND flash
+ * @mtd: MTD device structure
+ */
+static int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (!chip->_unlock)
+		return -ENOTSUPP;
+
+	return chip->_unlock(chip, ofs, len);
+}
+
 /* Set default functions */
 static void nand_set_defaults(struct nand_chip *chip)
 {
@@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip *chip)
 	mtd->_read_oob = nand_read_oob;
 	mtd->_write_oob = nand_write_oob;
 	mtd->_sync = nand_sync;
-	mtd->_lock = NULL;
-	mtd->_unlock = NULL;
+	mtd->_lock = nand_lock;
+	mtd->_unlock = nand_unlock;
 	mtd->_suspend = nand_suspend;
 	mtd->_resume = nand_resume;
 	mtd->_reboot = nand_shutdown;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4ab9bcc..2430ecd 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1136,6 +1136,9 @@ struct nand_chip {
 		const struct nand_manufacturer *desc;
 		void *priv;
 	} manufacturer;
+
+	int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
+	int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
 };
 
 extern const struct mtd_ooblayout_ops nand_ooblayout_sp_ops;
-- 
1.9.1

