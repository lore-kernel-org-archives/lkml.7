Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625AD21872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmM/YPd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfDKVp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:45:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33672 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:45:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so2867033wmi.0;
        Thu, 11 Apr 2019 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nf6OU8Al/mJlL06i5Ldod7GFzDf/F0dAuUkuELsAL+4=;
        b=mmM/YPd6deyfysNcaGBmW8rDxDvidiY0kHbKWlV2C3owwrB7VAjDjVqA+c2lPmSf3Z
         yXgoDywG+w651wYVDe0hUMPLRZZxIG+2d1r2Bx2MkL0FUfv48c8/CrN3V/69VX6tOk5A
         KSm7SB1H+Gstttl5zGhoDQZYKrFH2NFpCuXnMBxTeGe9JSZ/px7Cn4VqXEQFwqgkdLXv
         vcwNJiMXavDcO76bfMLt0zl5QCyp+gz5djKre5FAFSi3+pKMeBrm7P7iWt0rixEBv9wn
         fhnXZ67PfKWe25pVJKw7zAk4z+OhI3nzXpR/yjxSGutN7ElVKSwbCTYjWDTC3hn2L1pZ
         GGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nf6OU8Al/mJlL06i5Ldod7GFzDf/F0dAuUkuELsAL+4=;
        b=MnnF9PluTmoSTXl6fluZbEbBzXtwlx46nZiS75SvvwBYMshVFqvoPGY5ulcvcKcns+
         O16XPzsNnbevBLGfJLxc6oNNlemL1WQxo715ujim58h53J+2zF/o3l3zMuigen1fkkON
         +8Z9q4mN07sMPcfp4Xcka/VEdBovwRE5NpTkWFKpboRnUPPiCcfBax6YjYo5IemkvKKg
         YrX33SMnWAlBuBHvJKL+C1zQeMQhpKN8kRUwJynE8ccn4ZLWXDyQA8+FcFRFdZR4m1m6
         w69N5MStbeZGS912FCPWCLWnfZuXy5tp6p7/wO95hC5apyurWoga0GA/WOdhLDA5lzM3
         slkA==
X-Gm-Message-State: APjAAAW2r5flk1Ss+/tdK1qILvDHAxcLUagkDegAoFHX6reUNpIP3Y6P
        NSojv0DVGhFducAbZ/NmdHg=
X-Google-Smtp-Source: APXvYqzWdQdPWN8xVDqibwotfg551teNj8wR8ECuX7KxAlrbIAzVNhlXL1mRVjKDJbcWwIbxENON/Q==
X-Received: by 2002:a05:600c:ca:: with SMTP id u10mr8419199wmm.122.1555019100299;
        Thu, 11 Apr 2019 14:45:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id a22sm5952961wmj.44.2019.04.11.14.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:44:59 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/4] arm64: dts: allwinner: Add SPDIF node for Allwinner H6
Date:   Thu, 11 Apr 2019 23:44:20 +0200
Message-Id: <20190411214422.2267-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411214422.2267-1-peron.clem@gmail.com>
References: <20190411214422.2267-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).

Add this node in the SoC device-tree and as they are only one pinmuxing
available set it as default.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index ad2077830f73..5e850b359be5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -83,6 +83,24 @@
 		method = "smc";
 	};
 
+	sound_spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -264,6 +282,11 @@
 				bias-pull-up;
 			};
 
+			spdif_tx_pin: spdif-tx-pin {
+				pins = "PH7";
+				function = "spdif";
+			};
+
 			uart0_ph_pins: uart0-ph-pins {
 				pins = "PH0", "PH1";
 				function = "uart0";
@@ -391,6 +414,22 @@
 			};
 		};
 
+		spdif: spdif@5093000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-spdif",
+				     "allwinner,sun8i-h3-spdif";
+			reg = <0x05093000 0x400>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			clock-names = "apb", "spdif";
+			resets = <&ccu RST_BUS_SPDIF>;
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spdif_tx_pin>;
+			status = "disabled";
+		};
+
 		usb2otg: usb@5100000 {
 			compatible = "allwinner,sun50i-h6-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.17.1

