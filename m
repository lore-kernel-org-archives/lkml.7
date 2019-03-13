Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE10C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603EE21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Dygq6t/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCMWXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:23:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43726 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCMWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552515791; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6EJFR+TqRZTLvxsvCZm5wHwzIKtug3gHV03/GvftwkE=;
        b=Dygq6t/s1J066bvo6edY7/gUjbCkN3lfTK6vcYmcFkG+8NfL9hAnzzLCXoLUZcU/qmEVe7
        pdfVsnbAvmCr28qVbfC3aLRDi8Hdw8AcSa7BeLrjN3VVUlJgrEFpQlBDWkwWsBqz86l6Ce
        zYGzFQ03HM0huUP72l+6xC9UyMcb+Bo=
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
Subject: [PATCH v5 03/12] dt-bindings: mtd: ingenic: Use standard ecc-engine property
Date:   Wed, 13 Mar 2019 23:22:50 +0100
Message-Id: <20190313222259.28704-3-paul@crapouillou.net>
In-Reply-To: <20190313222259.28704-1-paul@crapouillou.net>
References: <20190313222259.28704-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ingenic,bch-controller' property is now deprecated and the
'ecc-engine' property should be used instead.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v5: New patch

 Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
index 5a45cc54f46d..c02259353327 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
@@ -14,7 +14,7 @@ Required NAND controller device properties:
   an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC bank).
 
 Optional NAND controller device properties:
-- ingenic,bch-controller: To make use of the hardware ECC controller, this
+- ecc-engine: To make use of the hardware ECC controller, this
   property must contain a phandle for the ECC controller node. The required
   properties for this node are described below. If this is not specified,
   software ECC will be used instead.
@@ -48,7 +48,7 @@ nemc: nemc@13410000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ingenic,bch-controller = <&bch>;
+		ecc-engine = <&bch>;
 
 		nand@1 {
 			reg = <1>;
-- 
2.11.0

