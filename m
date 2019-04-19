Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9489C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F2F218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmw+8qN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfDSTO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43807 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfDSTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so7952675wrx.10;
        Fri, 19 Apr 2019 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKVrYG5fLNMq4oH61B/TjfI3DotxPxjhCoHU0PS1JtQ=;
        b=Fmw+8qN7tfPH2V88rzY0I30wZ5901KlVIJ5/XnYPdTSySXV3OaXpjJAWDicCRUG+vQ
         g0Lpey8lZAvzvI/4ZHbaG2aXi2sHom8ayzkRFJdZQpk5NH2eB6TTugThntly7zpqBZw9
         bu0q0CmxPC08bIly9hQt5ljgZfYJ7B1XsRvj9iKVGpLb3lLv4mzjQOjC+v49+g0SufC/
         QIjThzyGkVCnipdumYWcap8C994gWpEDuDhkPupp+WUfydcqAZ0/2WDKEGQ/GfsNeu4L
         K3h/dAEjvRNxXOTXQom7CjAh5+kg+LWVeHVNhVnx/oFZmUEH6v7Or4Gg7qjqYI3j8vTt
         zFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKVrYG5fLNMq4oH61B/TjfI3DotxPxjhCoHU0PS1JtQ=;
        b=kphQe8lWP1G/CjJJ3TyF5V1IAwgRhcdtT6DHaSow+Rhg3FPUft25X9pAzS0PM1Gs01
         gUbj+yLW8jtSP4W28ojU4JogZdQ+c1BFfy6PkvxdFMTDBjIl8nNhary4/+u/i6RYzQFZ
         acwTEajYRcTdBBpDK7OeOrmz8g6t2T7W5ZuX97gzuVEXv02Iav8uBNBAM4pV14+WjMTI
         BzJiv2wTIwGDMxO7l81OVb5cIkSmi5D4r7qmL+NlTnOzZOK7Oi7Y9JVg99X4Aip4ig/6
         VZ3dfFBRp9SKICEIAa2EDK1JnTk0pvO4Kwuo1rHuC9bTJPOddfXGbkTrLezoDZ+LegTM
         pySg==
X-Gm-Message-State: APjAAAWsH/o/Iy1TVjLec58o8NGbJgcROUeEg851aspYQdzVxusl2476
        5fEjb2WqrtAuoITVUz7BP/4=
X-Google-Smtp-Source: APXvYqw0SfIPTdkzmi2hHA0afL8ILH0rUVdUVu94UsPI92T2uHoU3QcbDdsI02m4rGRPDxwvH5YoGQ==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr4259360wrr.27.1555701261219;
        Fri, 19 Apr 2019 12:14:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z18sm8131149wrr.90.2019.04.19.12.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:14:19 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/5] arm64: dts: allwinner: Add SPDIF node for Allwinner H6
Date:   Fri, 19 Apr 2019 21:17:28 +0200
Message-Id: <20190419191730.9437-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419191730.9437-1-peron.clem@gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).

Only one pinmuxing is available so set it as default.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index ad2077830f73..6c1debf11e5c 100644
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
@@ -391,6 +414,21 @@
 			};
 		};
 
+		spdif: spdif@5093000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-spdif";
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

