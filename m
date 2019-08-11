Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C7CC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 09:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7871208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHKJFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 05:05:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38925 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfHKJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 05:05:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so48012110pgi.6;
        Sun, 11 Aug 2019 02:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3Ifly1foxb2daR0o6J+zTU4WYUy2bJbtxT4XK1OLrg=;
        b=ZpSGyTg+Pc1nyUjFA5ewHi+L4znya+bvuCp4OFK9cnPbtQUappIWG/yKt0Pc/i5EBr
         rBxo+jdFT6gFnvSxV22jBemcjuNqjA0sr+sF0fn62bZzmdChaCIn6nZiiAwz9sDmbia+
         6WjwKP6VWvNkgKTGhYfabk9LdlOk3z6B1zVKEnBRwaZWZ3XRte24R1bgmOII+hqJyd2d
         FKDPEUPPXxSlT6CwT8QAjDukEOR4jli0c6rOVTMyP3bhw+yjTj1JCHZihZSpAZ7l5YQg
         748HBKpMKmhlZwOZyfALA2XBOaV5+0OIagSRGjqekRqJ8gH2O55rXPVZ5i2RuW6rPNl9
         l+tg==
X-Gm-Message-State: APjAAAXpb1KtFSLgnGoNtVoxNiKNGpQCaJEBRav4pg1jR2Oqz2L1tiFM
        NooDALi2lmVKJz8oj2fmiHo=
X-Google-Smtp-Source: APXvYqzoJpamqQrzP8NyckFzL5RrUb9B9dABDLWUcQmAOLk12/iQmd2UHC7uYVwNwUU2GfMYhuCiLQ==
X-Received: by 2002:a62:c584:: with SMTP id j126mr527338pfg.21.1565514318668;
        Sun, 11 Aug 2019 02:05:18 -0700 (PDT)
Received: from archbox.localdomain ([203.88.145.156])
        by smtp.gmail.com with ESMTPSA id r75sm129923096pfc.18.2019.08.11.02.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Aug 2019 02:05:18 -0700 (PDT)
From:   Bhushan Shah <bshah@kde.org>
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhushan Shah <bshah@kde.org>
Subject: [PATCH 1/2] arm64: allwinner: h6: add I2C nodes
Date:   Sun, 11 Aug 2019 14:35:02 +0530
Message-Id: <20190811090503.32396-2-bshah@kde.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190811090503.32396-1-bshah@kde.org>
References: <20190811090503.32396-1-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree nodes for i2c0 to i2c2, and also add relevant pinctrl
nodes.

Suggested-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Bhushan Shah <bshah@kde.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index bcecca17d61d..1d9ad3ec0b65 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -329,6 +329,21 @@
 				function = "hdmi";
 			};
 
+			i2c0_pins: i2c0-pins {
+				pins = "PD25", "PD26";
+				function = "i2c0";
+			};
+
+			i2c1_pins: i2c1-pins {
+				pins = "PH5", "PH6";
+				function = "i2c1";
+			};
+
+			i2c2_pins: i2c2-pins {
+				pins = "PD23", "PD24";
+				function = "i2c2";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
@@ -464,6 +479,45 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c@5002000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x05002000 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@5002400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x05002400 0x400>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@5002800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x05002800 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		emac: ethernet@5020000 {
 			compatible = "allwinner,sun50i-h6-emac",
 				     "allwinner,sun50i-a64-emac";
-- 
2.17.1

