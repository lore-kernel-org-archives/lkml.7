Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5256CC47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212532173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJJItz+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfKFOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:09:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38332 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbfKFOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:09:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so11477321plq.5;
        Wed, 06 Nov 2019 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtX1kXBG3vvdaUl4wOoaBRuLdri0yIVtwLf8lR4UWWQ=;
        b=iJJItz+vffO9tQoSQOlwaE50RW26dK4JczW15WHT5J+2/9N3eVa0f9yHMEICb8juR8
         IQ1Ai2MbmbLKBLUaeX2m5RG3VZuJQIpfXA8Q4FeAQ2w63BlC/d1f9BndQbxAsSXm8GeD
         VslHcXTxq91LT4jpeidzeOFR6Qb4ALGFfS+qf50qDzeOWFpiHD60S5AfCp9ATxMzuUcM
         xJIc+vQdYCUHMR9u61Gxt3iIJdupU81bv58oXJ0MQOKX9nLBsdJBL9kE6DmTL762yOFi
         N4FvQkQopxK1HKJjHEWAlOCRIxbQG8ZHk7qRNr6FhpWZTF9P5pojX8jwU0P1uUl1URzv
         PoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtX1kXBG3vvdaUl4wOoaBRuLdri0yIVtwLf8lR4UWWQ=;
        b=BafsWzqmpnTk+q8NfdjooXggJOMlkoM/aZ7Xtuz0FMTzXTxgae6EH7KUErM3Zzvhah
         luzZPxxTtG5eVbF74qSCjz/iGyZKthEZm2CIRh+KAtP1lQskqopdQBhFh7+0X7iNNvry
         bxKL6g2IAeiTMbnR+1VQ2lI1MepIfPwGEqh1ThY1/O/UfCSNjshrsrchDElNOQA1XdRQ
         JKWCqMwRjrjzgu7MR/WMQ4o2r2pP4/Gr0IsNBuFBy6X41QX4a3iQ1UYjqoYH2jvM8gWm
         DbIkH9MSrsvNojwVxpdiHk+ur76YlfuDhDKVbBTSTTDQQqCTRfNdFloukQm5Ct8wb5ev
         EDSg==
X-Gm-Message-State: APjAAAVLwWGQjRarpTCuwakGXZ+UX40m0TlGmuVEKb773PP/3QAlX7va
        nEaDkxPR0q/2kMSNxR9sp04=
X-Google-Smtp-Source: APXvYqygts/mak04562X0fgK/vvLZTbkPeSMoZr9mr+mopxFlmJTH31rJNGA97HB0NcP4AgDJFT0HQ==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr2924804pln.130.1573049339919;
        Wed, 06 Nov 2019 06:08:59 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id a16sm4707345pfc.56.2019.11.06.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:08:59 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 2/2] dt-bindings: mtd: mtk-quadspi: update bindings for mmap flash read
Date:   Wed,  6 Nov 2019 22:07:48 +0800
Message-Id: <20191106140748.13100-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106140748.13100-1-gch981213@gmail.com>
References: <20191106140748.13100-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update register descriptions and add an example binding using it.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt   | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index a12e3b5c495d..4860f6e96f5a 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -12,7 +12,10 @@ Required properties:
 		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
-- reg: 		  physical base address and length of the controller's register
+- reg: 		  Contains one or two entries, each of which is a tuple consisting of a
+		  physical address and length. The first entry is the address and length
+		  of the controller register set. The optional second entry is the address
+		  and length of the area where the nor flash is mapped to.
 - clocks: 	  the phandle of the clocks needed by the nor controller
 - clock-names: 	  the names of the clocks
 		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
@@ -48,3 +51,19 @@ nor_flash: spi@1100d000 {
 	};
 };
 
+nor_flash: spi@11014000 {
+	compatible = "mediatek,mt7629-nor",
+		     "mediatek,mt8173-nor";
+	reg = <0x11014000 0xe0>,
+	      <0x30000000 0x10000000>;
+	clocks = <&pericfg CLK_PERI_FLASH_PD>,
+		 <&topckgen CLK_TOP_FLASH_SEL>;
+	clock-names = "spi", "sf";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
-- 
2.21.0

