Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D0D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ufbw0xkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfCMWXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:23:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43794 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfCMWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552515797; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G7zhCx/BerdbwA8GfBduIewhiSNU08ttLXwS6iOQtJ0=;
        b=Ufbw0xkPaFofImCzGyzlFkJv8BJUmpGRTig304MfWueKnMrBDqMEBrQZ2EyoYGIV9y0Mei
        PEcOw/lQ7sUCApBZY1HCpyEtEcnq63ww7rRfLcJFruhkjzqITWOtBegj7Dkk+WdvW0+nx+
        QGdmySwuesHEVy509wOvRL8odF90hnc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 07/12] mtd: rawnand: ingenic: Rename jz4780_bch_init to jz4780_bch_reset
Date:   Wed, 13 Mar 2019 23:22:54 +0100
Message-Id: <20190313222259.28704-7-paul@crapouillou.net>
In-Reply-To: <20190313222259.28704-1-paul@crapouillou.net>
References: <20190313222259.28704-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jz4780_bch_init name was confusing, as it suggested that its content
should be executed once at init time, whereas what the function really
does is reset the hardware for a new ECC operation.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v5: New patch

 drivers/mtd/nand/raw/ingenic/jz4780_bch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
index fdf483a49f7b..7635753bd7ea 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
@@ -69,8 +69,8 @@ struct jz4780_bch {
 	struct mutex lock;
 };
 
-static void jz4780_bch_init(struct jz4780_bch *bch,
-			    struct jz4780_bch_params *params, bool encode)
+static void jz4780_bch_reset(struct jz4780_bch *bch,
+			     struct jz4780_bch_params *params, bool encode)
 {
 	u32 reg;
 
@@ -183,7 +183,8 @@ int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *param
 	int ret = 0;
 
 	mutex_lock(&bch->lock);
-	jz4780_bch_init(bch, params, true);
+
+	jz4780_bch_reset(bch, params, true);
 	jz4780_bch_write_data(bch, buf, params->size);
 
 	if (jz4780_bch_wait_complete(bch, BCH_BHINT_ENCF, NULL)) {
@@ -220,7 +221,7 @@ int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
 
 	mutex_lock(&bch->lock);
 
-	jz4780_bch_init(bch, params, false);
+	jz4780_bch_reset(bch, params, false);
 	jz4780_bch_write_data(bch, buf, params->size);
 	jz4780_bch_write_data(bch, ecc_code, params->bytes);
 
-- 
2.11.0

