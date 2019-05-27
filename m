Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC139C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56D721848
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLE1iny4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfE0UKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37045 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfE0UKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so532717wmo.2;
        Mon, 27 May 2019 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtCxvhDjc6UIDNW85CWIxfeFRpcagFN9CHe3gjmJy+k=;
        b=aLE1iny4yG3QCT/zG491gC1RXU7vzr69elKMD8GQaEyJQ4YjjaXpQCTv/m7SwtQWTT
         qOfCWbDxi7OckkxwLbHzS3+YXZYJHdUzLuZCdP4RY/rG7w49JvzLb6LRX6jr+ph9SiqH
         BUuDczojLSivlQnaCGDi9VgWm/ZHpdc09A9RQ3/SZkDdUoPzMURenPRHR6MJQruRFDXM
         KiZCPYH4bQh0gsxm4wJMdS2ZdrnVbdtWnwuhtrTWgvBNdESrHelN/M4g/AxuEQPyJl4g
         tj8aRZtoFS2vR5rMuVcs+C+J2w7pMALclLGyJK53yhlQjHbfTpVM0sLD4a1uumOUq2nF
         9t+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtCxvhDjc6UIDNW85CWIxfeFRpcagFN9CHe3gjmJy+k=;
        b=PDhwiUnmzIzWtj4p6h2W8MqpW4OcOCF0qvC/Qg1yX3vvy9oakxmFp23kru0zlnGRD7
         hNrCkYsDKdWX3YlYhttHm+QmEUkRYY1tD8Lc6uWTCTNxrGwJY658WxxfSGKQPrkqcJep
         l4UZNnHkAhAYCosXVmah3V7vQN9sEpOwUlXYTLGFrCqDo8jnRQ8Ijk3cW+Fxv/PYgOiH
         POpydLRGwzT7+hjql0Rzfim5c5uGTEaMSd66rUU5M24WWLKU/wsm6tdEkh61QLdNppsZ
         idiOfVR9CrqwrLsjijMhOtKhjBNkdNqwywBhk7awsiUB5J7lqBFXRMo8hxJ9ZnsYd2xc
         8uRg==
X-Gm-Message-State: APjAAAVVBVqc84O6l1c0p5lB6YzB4mqL3XKg2xTAE97vV/1rqYJefWUm
        teYpZWJh6MC7g5O8bAL0pZ9jFhrf0Xyy7g==
X-Google-Smtp-Source: APXvYqxH3xB78DGBhf12PYNkbxwGH69xUEVnBP+LhdwkWmd176J8x+oCf/GMubBlZhUYOV/xcxXuIQ==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr464874wmh.55.1558987819118;
        Mon, 27 May 2019 13:10:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 5/7] arm64: dts: allwinner: Add SPDIF node for Allwinner H6
Date:   Mon, 27 May 2019 22:06:25 +0200
Message-Id: <20190527200627.8635-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
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
index f4ea596c82ce..e0ca23704719 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -83,6 +83,24 @@
 		method = "smc";
 	};
 
+	sound-spdif {
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
@@ -273,6 +291,11 @@
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
@@ -402,6 +425,21 @@
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
2.20.1

