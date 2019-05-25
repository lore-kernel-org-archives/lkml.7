Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC5FC28CC0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5750C2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7TtEChR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfEYQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45530 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfEYQXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so12774176wrq.12;
        Sat, 25 May 2019 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlop/tLKOAnYug0Dp9+i5+P1xnfuVjpNMnA0jr7cUrU=;
        b=I7TtEChRmmNj6VLSBCmaMIg1zu7RzzR2Ga+g89wPPkAc7JPfiS4+Fg+EMAgbEWdFjf
         InpqE8E/KGCaKzquF3SLe/yF/Yk3D/rfGZXpj0Gecf1DFjtsa/4xb+hKPoP644KGMtU3
         yXb2aN7EZ4xogv4qpSqOsRpSuRa9YeXNbjwGVqBFhWdzDzp0l9hym9Sc4o7ADgtt70NJ
         C/ACW4wRXgVi/Qr0TdwzxeXNpXyVgKKbMZ2iVYEAG0SC7nSfXcnc3eNwAMg9zEWWJ24g
         ggcLwnhi4gR5/SNmgxSm63gbJCes2IZ7tcExC/8g/9qng6fNyULrJuumkr/R2O0JgbtQ
         BTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlop/tLKOAnYug0Dp9+i5+P1xnfuVjpNMnA0jr7cUrU=;
        b=ttM5iPlMImhOJlHgpnYVaSzBE5sE2yhgOpzwmZIcUH3O9A80h1vt4MutXVHtrH8hYf
         1E3jxhREi0f+nrVJId1XHxlgJN0vVUO4OCLDM6DrgAdmej1Laf7sTOgCDZ5nZJFfmmJF
         +8jV1z2dsCpUo9uKHIvx5EnJOiG887PQFlQs7MY7p/6Zl9tvV5GzI5wLSxdqgiJBOeE8
         0Da7FxWpliSFL8kxvZyNoBCjMA1BLoftSChXLp0RfHGjmqS8znj1bwxRHBg5kZePxvOx
         vPXRnbjRlarR+CaB5MggwDsuyY7qpzkR5xSiGFj4gF+srK8P+PzBwflPbrKlOwds/glO
         sRkA==
X-Gm-Message-State: APjAAAU7rnfIP1sCKdHRvZlGFATkSlT5FZQ7XR8gWwdc/ymAM8bK/R2U
        QJG3v9WA6BMROFjePLjWJpY=
X-Google-Smtp-Source: APXvYqwCnYLX+Ua7LtZco21uxEOjlg/sf70RxAvq0yiaBVeuxuqAX8O5GRMhgBMAJtNYkNZSW6fLSA==
X-Received: by 2002:adf:aa09:: with SMTP id p9mr14856373wrd.59.1558801416931;
        Sat, 25 May 2019 09:23:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:36 -0700 (PDT)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 5/7] arm64: dts: allwinner: Add SPDIF node for Allwinner H6
Date:   Sat, 25 May 2019 18:23:21 +0200
Message-Id: <20190525162323.20216-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
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
index f4ea596c82ce..307d3c896ff2 100644
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

