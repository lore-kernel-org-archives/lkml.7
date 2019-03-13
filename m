Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E10C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F2321019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tyewH6yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCMWXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:23:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43794 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfCMWXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552515800; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0umgjSAPrTZHFT4VpZbszTj7Bzav/Y3LXeJO+vVz6yA=;
        b=tyewH6yfT0LVN8q1HoBLNeCJnJvMQYi58WT2KddE7M00vCmLYjnTrpZJpU7iD3JFtzL21J
        hhWEBpH5wkUvQlgU/PLzYxpjsb3t/Ar3bKqyrfyFpYzYp2LufDE6/+UNx2rL9iLYpIufW/
        pGOQQbfcHhLVAxhSWTwGeMNen12i+Pc=
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
Subject: [PATCH v5 09/12] mtd: rawnand: ingenic: Make use of ecc-engine property
Date:   Wed, 13 Mar 2019 23:22:56 +0100
Message-Id: <20190313222259.28704-9-paul@crapouillou.net>
In-Reply-To: <20190313222259.28704-1-paul@crapouillou.net>
References: <20190313222259.28704-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'ecc-engine' standard property instead of the custom
'ingenic,bch-controller' custom property, which is now deprecated.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v5: New patch

 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index d7f3a8c3abea..30436ca6628a 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -82,9 +82,9 @@ static struct ingenic_ecc *ingenic_ecc_get(struct device_node *np)
 
 /**
  * of_ingenic_ecc_get() - get the ECC controller from a DT node
- * @of_node: the node that contains a bch-controller property.
+ * @of_node: the node that contains a ecc-engine property.
  *
- * Get the bch-controller property from the given device tree
+ * Get the ecc-engine property from the given device tree
  * node and pass it to ingenic_ecc_get to do the work.
  *
  * Return: a pointer to ingenic_ecc, errors are encoded into the pointer.
@@ -95,7 +95,14 @@ struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *of_node)
 	struct ingenic_ecc *ecc = NULL;
 	struct device_node *np;
 
-	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
+	np = of_parse_phandle(of_node, "ecc-engine", 0);
+
+	/*
+	 * If the ecc-engine property is not found, check for the deprecated
+	 * ingenic,bch-controller property
+	 */
+	if (!np)
+		np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
 
 	if (np) {
 		ecc = ingenic_ecc_get(np);
-- 
2.11.0

