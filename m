Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF966C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA06921019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fzPWFM2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfCMWXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:23:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43612 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552515784; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=M0Xj2kk23SnRTXLNt+74nDq03LVAY47qlGUEW7OnrvM=;
        b=fzPWFM2xxEnt6mdtIdst7zDIKdgi3caNlZJB0UEYUruRIYbG+6HxB2aHwkDf5Lxgv0UtVF
        vTDwGKjcQdN/b+ML2slecGrhyen8ROEHHaEw7zG/ELES/OiukqOObL/mTWvh8oIu5v7uHp
        EOXTpi5JciCn15VbbxbPoZi0QiugK54=
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
Subject: [PATCH v5 01/12] dt-bindings: mtd: ingenic: Add compatible strings for JZ4740 and JZ4725B
Date:   Wed, 13 Mar 2019 23:22:48 +0100
Message-Id: <20190313222259.28704-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings to probe the jz4780-nand and jz4780-bch drivers
from devicetree on the JZ4725B and JZ4740 SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2: - Change 'ingenic,jz4725b-nand' compatible string to
          'ingenic,jz4740-nand' to reflect driver change
        - Add 'ingenic,jz4740-bch' compatible string
        - Document 'ingenic,oob-layout' property
    
    v3: - Removed 'ingenic,oob-layout' property
        - Update compatible strings to what the driver supports
    
    v4: No change
    
    v5: No change

 Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
index 29ea5853ca91..a5b940f18bf6 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
@@ -6,7 +6,10 @@ memory-controllers/ingenic,jz4780-nemc.txt), and thus NAND device nodes must
 be children of the NEMC node.
 
 Required NAND controller device properties:
-- compatible: Should be set to "ingenic,jz4780-nand".
+- compatible: Should be one of:
+  * ingenic,jz4740-nand
+  * ingenic,jz4725b-nand
+  * ingenic,jz4780-nand
 - reg: For each bank with a NAND chip attached, should specify a bank number,
   an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC bank).
 
@@ -72,7 +75,10 @@ NAND devices. The following is a description of the device properties for a
 BCH controller.
 
 Required BCH properties:
-- compatible: Should be set to "ingenic,jz4780-bch".
+- compatible: Should be one of:
+  * ingenic,jz4740-ecc
+  * ingenic,jz4725b-bch
+  * ingenic,jz4780-bch
 - reg: Should specify the BCH controller registers location and length.
 - clocks: Clock for the BCH controller.
 
-- 
2.11.0

