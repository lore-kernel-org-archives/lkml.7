Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07826C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ABB2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uu/dKJAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfENLP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:15:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfENLPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so906195wru.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PmCFTzBJ4fs8y0qiuFVvAwddCVo0DZXmaQNkhQWVB8=;
        b=Uu/dKJAACTCSPoaMBykcb1jhzR6NQdU5X3M3Iqo8ur2XHFPW9hN41ntSyPszCnBA0i
         rJNLkKM/PzQkC5t/MqSUZymm3TqU9K8ayGtmHdOjKy45+F81t/gyJXEq0eIipi3icA+b
         cRht1cA2Bobr7DqX7tGf5iUMyfcKHts+BSX9aAtpYOfsKp/NDOGN+fOEs57ybI00EPtT
         d84qs1HFbgHgsD1TLONHHimGXVKKh6UA2WsFY5WPmGcrB3T58z3Frq4Rf44AwRtjClV2
         OOPHlRvatDrRi8c0oi+7y0x0AzoRPArA98y9QMLNWMMoWlV6EVHJ7IAMuJf9EZqspPFl
         JJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PmCFTzBJ4fs8y0qiuFVvAwddCVo0DZXmaQNkhQWVB8=;
        b=rfS21MK3Araf4vkbQl3U02tPMZW4biLsjH+TmYYmfFlwBf9N9jk/OlsfoFeRQweNu0
         UytKe57arO7TGTuG6dlpLK7nmWLx+/899TKZuKBEWXchdf6Fx5qSy2gr2u15w2iSPqDm
         V9mnJp65SLmKjV55VSQkPNVllKiCaT1NiFstMRHaqr7vpvRxFbjiCfXKHXyoPKAfqvXI
         C/Ic0u4AUM4x8ybc+IZUaIkaqtzMYEp8TyDbZiP2KTUPaPEBXhBw3rXRpYojgJPRfjCJ
         TBWpsJ54YujJwcWP3VQ+qX0ubY2g8iV/ZqOeCqCJiyx3SD9ANiSAsGJgXjRB5yvxP87Z
         25PA==
X-Gm-Message-State: APjAAAVPaj5zU6GnQHgnqCFFsojgcw97IPZhhvMGPLzGbB2otFAugebu
        +DnKoD6ccGSlNml7CWl7Q4aPTA==
X-Google-Smtp-Source: APXvYqxWEQ76CdEqyDUjW65FDD+k6AlKSTc6H/6M1oeIwaGEmV77qDEOLGLrNHJtjhF/wf5lVQEihw==
X-Received: by 2002:a5d:5501:: with SMTP id b1mr2026694wrv.222.1557832522344;
        Tue, 14 May 2019 04:15:22 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:21 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] arm64: dts: meson: g12a: add spdifouts
Date:   Tue, 14 May 2019 13:15:07 +0200
Message-Id: <20190514111510.23299-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514111510.23299-1-jbrunet@baylibre.com>
References: <20190514111510.23299-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devices nodes and pinctrl definitions for the spdif outputs of
the g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 825e874918c2..fa10d6fbf370 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -643,6 +643,33 @@
 						};
 					};
 
+					spdif_out_h_pins: spdif-out-h {
+						mux {
+							groups = "spdif_out_h";
+							function = "spdif_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
+					spdif_out_a11_pins: spdif-out-a11 {
+						mux {
+							groups = "spdif_out_a11";
+							function = "spdif_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
+					spdif_out_a13_pins: spdif-out-a13 {
+						mux {
+							groups = "spdif_out_a13";
+							function = "spdif_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
 					tdm_a_din0_pins: tdm-a-din0 {
 						mux {
 							groups = "tdm_a_din0";
@@ -1306,6 +1333,18 @@
 					status = "disabled";
 				};
 
+				spdifout: audio-controller@480 {
+					compatible = "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg = <0x0 0x480 0x0 0x50>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFOUT";
+					clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+					clock-names = "pclk", "mclk";
+					status = "disabled";
+				};
+
 				tdmout_a: audio-controller@500 {
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x500 0x0 0x40>;
@@ -1347,6 +1386,18 @@
 						      "lrclk", "lrclk_sel";
 					status = "disabled";
 				};
+
+				spdifout_b: audio-controller@680 {
+					compatible = "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg = <0x0 0x680 0x0 0x50>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFOUT_B";
+					clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
+					clock-names = "pclk", "mclk";
+					status = "disabled";
+				};
 			};
 
 			usb3_pcie_phy: phy@46000 {
@@ -1500,6 +1551,15 @@
 						};
 					};
 
+					spdif_ao_out_pins: spdif_ao_out {
+						mux {
+							groups = "spdif_ao_out";
+							function = "spdif_ao_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
 					tdm_ao_b_din1_pins: tdm-ao-b-din1 {
 						mux {
 							groups = "tdm_ao_b_din1";
-- 
2.20.1

