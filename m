Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E83CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03421D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fuZKY1Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfJ0QSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:18:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39843 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfJ0QSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:18:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so6674233wme.4;
        Sun, 27 Oct 2019 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2pKUClZPs6kJxYKVc9s3ay4DPVtu8eC20YF9cqpcPI=;
        b=fuZKY1Gwot9PXbdi2F0wFKeeUjfJaM8qcBUEEIAcOoEfGOkP8ISPg68uLOAqKjU/zV
         gxOYOedqSMEtXUZ/eVc8E3Z4snEmY16p65SFrIFEZ+ssrsOhiQIp8qEW988N7tm4j+v8
         GKm3RY37S7u35/GOsMJcLlw7oHLwyN1CIZJJdQ6aVEXHYHe3fgzAhztZ0+dMg0sMb5Dd
         NS8ced3UpEBqX+np36zo2dGDKSrgrbr/e4ibJhaaxF40LwkbsNHnTl6mbCVIXgL6tpdG
         fQnKelPXoQs/met8AQg2y3NtSoU4xbqyKSYTagtJpy+89PYHPkwqKy/NbM6IintphWGW
         hSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2pKUClZPs6kJxYKVc9s3ay4DPVtu8eC20YF9cqpcPI=;
        b=OTyxTu7LH42QKVt/8NomroryCbdzd1423CsCnZQeTOxncmixnHW/KMrRhbMYCk9+WR
         je+R1FpbGilCTysEgM2sv8uWdCRO/qQ9HBqkl2SvlSsL+Gw6txQGBVG7Myvj9J/921aC
         qUF2piUToP4ZKpfB/eGD5cH4fODH5xPZR+CdywA738OorkWwLSqC7lKPWuKGFms7DG1+
         n26S9RfuY7u0JdM0xzma0QanOWEmiTj30OT7irzX4S2z9+K5QoHlgzu8nK0WOHGIvJm4
         xJ3fkJ62DXtpED4j5YOGtte2H2IqaBQKbKGyuqSQ1hF8QBZnlLnIoGRxUDit41Jjqjbx
         KBmg==
X-Gm-Message-State: APjAAAVXnIMa1tSxP4mLscCqk3pROROXHBBgWI6+yN/6ruKMqaEMthbo
        vx3SamuCFC/WjrVMMkXxSuk=
X-Google-Smtp-Source: APXvYqzdDF+BTs3CmnmqR/OMrHlFL2KK0vQNMdUQU2ukI3jHraGwiggiPz8BvE9c9Q3Z2hXogtSkKg==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr12265207wmb.102.1572193093558;
        Sun, 27 Oct 2019 09:18:13 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j14sm9585014wrj.35.2019.10.27.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:18:12 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: clock: meson8b: add the clock inputs
Date:   Sun, 27 Oct 2019 17:18:01 +0100
Message-Id: <20191027161805.1176321-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
References: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock controller on Meson8/Meson8b/Meson8m2 has three (known)
inputs:
- "xtal": the main 24MHz crystal
- "ddr_pll": some of the audio clocks use the output of the DDR PLL as
  input
- "clk_32k": an optional clock signal which can be connected to GPIOAO_6
  (which then has to be switched to the CLK_32K_IN function)

Add the inputs to the documentation so we can wire up these inputs in a
follow-up patch.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/clock/amlogic,meson8b-clkc.txt       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
index 4d94091c1d2d..cc51e4746b3b 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
@@ -11,6 +11,11 @@ Required Properties:
 	- "amlogic,meson8m2-clkc" for Meson8m2 (S812) SoCs
 - #clock-cells: should be 1.
 - #reset-cells: should be 1.
+- clocks: list of clock phandles, one for each entry in clock-names
+- clock-names: should contain the following:
+  * "xtal": the 24MHz system oscillator
+  * "ddr_pll": the DDR PLL clock
+  * "clk_32k": (if present) the 32kHz clock signal from GPIOAO_6 (CLK_32K_IN)
 
 Parent node should have the following properties :
 - compatible: "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
-- 
2.23.0

