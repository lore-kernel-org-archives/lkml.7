Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93015CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA9E21D80
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfJ1J3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:29:45 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:61724 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbfJ1J3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:29:44 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x9S9TQPP013435;
        Mon, 28 Oct 2019 17:29:29 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw
Subject: [PATCH v2 3/4] mtd: rawnand: Add support manufacturer specific suspend/resume operation
Date:   Mon, 28 Oct 2019 17:55:26 +0800
Message-Id: <1572256527-5074-4-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x9S9TQPP013435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch nand_suspend() & nand_resume() for manufacturer specific
suspend/resume operation.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_base.c | 9 +++++++--
 include/linux/mtd/rawnand.h      | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 5e318ff..2a9c5bb 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4323,6 +4323,8 @@ static int nand_suspend(struct mtd_info *mtd)
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	mutex_lock(&chip->lock);
+	if (chip->_suspend)
+		chip->_suspend(chip);
 	chip->suspended = 1;
 	mutex_unlock(&chip->lock);
 
@@ -4338,11 +4340,14 @@ static void nand_resume(struct mtd_info *mtd)
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	mutex_lock(&chip->lock);
-	if (chip->suspended)
+	if (chip->suspended) {
+		if (chip->_resume)
+			chip->_resume(chip);
 		chip->suspended = 0;
-	else
+	} else {
 		pr_err("%s called for a chip which is not in suspended state\n",
 			__func__);
+	}
 	mutex_unlock(&chip->lock);
 }
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 2430ecd..6b14041 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1117,6 +1117,8 @@ struct nand_chip {
 
 	struct mutex lock;
 	unsigned int suspended : 1;
+	int (*_suspend)(struct nand_chip *chip);
+	void (*_resume)(struct nand_chip *chip);
 
 	uint8_t *oob_poi;
 	struct nand_controller *controller;
-- 
1.9.1

