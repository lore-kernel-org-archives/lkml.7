Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8380AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528552183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="th8r1i2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfC2H3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:29:39 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64916 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2H3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:29:39 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2T7SQaF002537;
        Fri, 29 Mar 2019 16:28:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2T7SQaF002537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553844516;
        bh=P6nAEpSTptxVwF6npdz1nlZ/dvqEunlZJ0obGeCKvZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th8r1i2+a2zln0j9kTQYqaeuf4y0Z1EB5HdND9w8CxVyYXnX/MRnjLuukzhQhyVaJ
         Tywo013QZOiJjFaokK7B8U/dFcWE0TqO90yJmcw1qSTsYRtK4MWcPGratgKJL5Cc5T
         sO6cxmLNWL5vXTPKsE+mnXGiy63XHtv7HWwmo2HPY1xGwLcFt7BFg1Lr9TO7TDz/fR
         Th9PEMpzum3noSK2q3A/zIcYfb01138vdRNJ46zMl2YPzzyI62iP8U4lihkOp9RO+n
         g76iALn9B8ReI1QbCw8jey5BlW/h6v7Wt6hXwZADS02grSJ4bVrX4UJd0GeccDWgHt
         1chK/wGUKn6kQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH v4 8/9] mtd: rawnand: denali: remove DENALI_NR_BANKS macro
Date:   Fri, 29 Mar 2019 16:28:20 +0900
Message-Id: <1553844501-7119-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553844501-7119-1-git-send-email-yamada.masahiro@socionext.com>
References: <1553844501-7119-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the runtime-detected denali->nbanks instead of hard-coded
DENALI_NR_BANKS (=4).

The actual number of banks depends on the IP configuration, and
can be less than DENALI_NR_BANKS. It is pointless to touch
registers of unsupported banks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 687feab..6d0ee5e 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -40,7 +40,6 @@
 #define DENALI_BANK(denali)	((denali)->active_bank << 24)
 
 #define DENALI_INVALID_BANK	-1
-#define DENALI_NR_BANKS		4
 
 static struct denali_chip *to_denali_chip(struct nand_chip *chip)
 {
@@ -92,7 +91,7 @@ static void denali_enable_irq(struct denali_controller *denali)
 {
 	int i;
 
-	for (i = 0; i < DENALI_NR_BANKS; i++)
+	for (i = 0; i < denali->nbanks; i++)
 		iowrite32(U32_MAX, denali->reg + INTR_EN(i));
 	iowrite32(GLOBAL_INT_EN_FLAG, denali->reg + GLOBAL_INT_ENABLE);
 }
@@ -101,7 +100,7 @@ static void denali_disable_irq(struct denali_controller *denali)
 {
 	int i;
 
-	for (i = 0; i < DENALI_NR_BANKS; i++)
+	for (i = 0; i < denali->nbanks; i++)
 		iowrite32(0, denali->reg + INTR_EN(i));
 	iowrite32(0, denali->reg + GLOBAL_INT_ENABLE);
 }
@@ -117,7 +116,7 @@ static void denali_clear_irq_all(struct denali_controller *denali)
 {
 	int i;
 
-	for (i = 0; i < DENALI_NR_BANKS; i++)
+	for (i = 0; i < denali->nbanks; i++)
 		denali_clear_irq(denali, i, U32_MAX);
 }
 
@@ -130,7 +129,7 @@ static irqreturn_t denali_isr(int irq, void *dev_id)
 
 	spin_lock(&denali->irq_lock);
 
-	for (i = 0; i < DENALI_NR_BANKS; i++) {
+	for (i = 0; i < denali->nbanks; i++) {
 		irq_status = ioread32(denali->reg + INTR_STATUS(i));
 		if (irq_status)
 			ret = IRQ_HANDLED;
-- 
2.7.4

