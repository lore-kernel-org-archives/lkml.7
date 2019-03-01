Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DCC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6382084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="URExq/Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfCAS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:29:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389201AbfCAS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:29:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id g20so12346121wmh.5;
        Fri, 01 Mar 2019 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncNcJQwDfiPhDXs8lF0Szc4vWY35aZvZb7KgVFzyX5I=;
        b=URExq/MdU1CtB9n0eev3RNX3Z8rgbn1RYMpZ2oI5fDT+J5pVKYLAhSyO4OX1jSj+7m
         6OIXVKnWOaax2masO02Kx3eNwMHCic6tZj++1PUutHSBfngBvr0gtl6DZM2X7JfW2FBV
         3sTzOcQ/bE64OGaGAjZvpa6H4zK9WUq/qVAvX3GE5fSU5OhLo9iKFwjhFbv1cKPt083q
         UZcq8NKgIZF9aPnYkyP7B1sdDZowrbirUcb+evU78pKhsByLxOYabGNXV6GCcLlHWDns
         8GXCvpAB3uGK8dSU2UH2zjTpNLO8jD0pyHn/vgydwrrOJ1FFAf2PojP1aHIpo4csPH5H
         GqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncNcJQwDfiPhDXs8lF0Szc4vWY35aZvZb7KgVFzyX5I=;
        b=W0Seuec7TCgE3tjhbtcnvrc8zmIhRJveUbMrQIDmkzGBCF2vt/hjMvFXfcKekfVwwR
         Co3qpNAg9MdJ9RV2nzkCUcs5799ig4g/F1Gote43CAcHscczN3u9AsIeqvQX4AmnqUMr
         V+olqFyV8fu7y4Cu3VNu2Wv/fdhsCKt2x30RMqa2JQPjaU3I803qlFTBadaVbZSwZMrn
         RG7K5Eqpm6cdQcBcs8UEOH7aW8edf5SliQvJK64x+kRsodso6ASrrpZxE0K45h86PgfJ
         chfX9Mmi1W6nG0RePKL4DHOpqcZ938wdVnoJdKchBE9bOFlIGWyJDL6BbqVWf0e6bMoA
         zprw==
X-Gm-Message-State: AHQUAuZt7sjyO/J/tIxrZqaeoimESFXKeTFBiqB7iBl7BZq8Q2jzejtP
        UhpVY7HqbScRtzTt+6cm1eE=
X-Google-Smtp-Source: APXvYqyc6XRleJWg4NXBrYYv7pNcd/11bHNukuFm5PeHaiHZ58IoBn+q9XGMaaZaeGAuoA8TimxTTA==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr4125319wmh.51.1551464985881;
        Fri, 01 Mar 2019 10:29:45 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD7109200428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d710:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l18sm21221367wrv.20.2019.03.01.10.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 10:29:45 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     liang.yang@amlogic.com
Cc:     linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH nand-next 1/2] dt-bindings: nand: meson: add support for more SoCs
Date:   Fri,  1 Mar 2019 19:29:21 +0100
Message-Id: <20190301182922.8309-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Amlogic SoCs have a slightly different integration of the NFC
(NAND flash controller) than the new ones (GXL, GXM, AXG).

On GXL, AXG and newer the "NAND device clock" is shared with sd_emmc_c.
This requires muxing the signal of that clock between the sd_emmc_c
controller and the NAND controller. The "amlogic,mmc-syscon" property
exists for this purpose.

Older SoCs (Meson8, Meson8b, Meson8m2 and GXBB) have a dedicated "NAND
device clock". Thus we don't need to "amlogic,mmc-syscon" property for
muxing the clock on these older SoCs.

The clock implementation itself is also more advanced on newer SoCs
because the phase of the RX and TX clock can be controlled. Older SoCs
cannot change the phase of the "NAND device clock". Thus the "rx" and
"tx" clock-names are only required for the GXL, GXM and AXG SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
index 3983c11e062c..8766d4e82a74 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -5,6 +5,9 @@ the MTD NAND bindings.
 
 Required properties:
 - compatible : contains one of:
+  - "amlogic,meson8-nfc"
+  - "amlogic,meson8b-nfc"
+  - "amlogic,meson-gxbb-nfc"
   - "amlogic,meson-gxl-nfc"
   - "amlogic,meson-axg-nfc"
 - clocks     :
@@ -13,12 +16,13 @@ Required properties:
 
 - clock-names: Should contain the following:
 	"core" - NFC module gate clock
-	"device" - device clock from eMMC sub clock controller
-	"rx" - rx clock phase
-	"tx" - tx clock phase
+	"device" - NAND device clock
+	"rx" - rx clock phase, only used on the GXL, GXM and AXG SoCs.
+	"tx" - tx clock phase, only used on the GXL, GXM and AXG SoCs.
 
-- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
-				controller port C
+- amlogic,mmc-syscon	: Only used on the GXL, GXM and AXG SoCs.
+			  Required for NAND clocks, it's shared with SD/eMMC
+			  controller port C
 
 Optional children nodes:
 Children nodes represent the available nand chips.
-- 
2.21.0

