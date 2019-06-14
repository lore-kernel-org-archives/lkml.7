Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E250C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62921848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NxRS0jSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFNQoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:44:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36395 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfFNQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:44:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so272447plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKv8CY3ZfTC87OfgidzsL+oxrJ/KYUyR5hJ1sg73Mj4=;
        b=NxRS0jSVSMU9QoyAVgh1BVsCGJofm5X4ZtviIzOFd68haxBmO9IG1AsOz1N5feSORY
         i+tcwa3vVkGsoDIMkTvG0L84o/R4WE3qfnWtL53buXPBMM6UJcoU3K8bhunfzCsBWVAm
         ot7YEz/Kc+CgmTNQYUMdBtJDxOVKmHYufJMgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKv8CY3ZfTC87OfgidzsL+oxrJ/KYUyR5hJ1sg73Mj4=;
        b=EPjlSCr6rIv5f5RxzyXiRIo+io6y3RtM3HxbrJ2b/jXEw37cY4BmlhwrrMaQiA3W2z
         /VDKHgiUV5xNt+VCsi+NyLeefSjXFVCLZZ8ZujILFfkat8e6GjIJqObnfKjv02657lLD
         5NKDi6Q7HNj5003llS7vdZd7GtuuNfaLsLeSDnjXMImb7E+828MUTotMBG8SRJQ7NlN/
         r4BseK1OmcaKKPubU1jhMVjdNORlMz2WUvhCO8itRQNSR0IuSiRD/PhrsWqpvjr1hFCY
         7vKjyWf2gq6ck5z5zUFNyq5piSXcAY6f02klBl20Vj6ytVqdjHFNKrFQjnQN9qN92sZA
         Pgaw==
X-Gm-Message-State: APjAAAXO4YHfah5AiSWfDhE7pRIW41R81eY/eiekVIduPVZltAdYf5cO
        NbPoNVsXhY9/1vHxkmgOK9yPdg==
X-Google-Smtp-Source: APXvYqxMiswcOeVpyj6jjn8GX8TtC9BLtw38K+dIqWFzUkLrUCWAVI2CE4J1QmRx2OADdXWb0ZNg+w==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr16384176plp.168.1560530653656;
        Fri, 14 Jun 2019 09:44:13 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:44:13 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 8/9] ARM: dts: sun8i: r40: Add MIPI DSI pipeline
Date:   Fri, 14 Jun 2019 22:13:23 +0530
Message-Id: <20190614164324.9427-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI DSI pipeline for Allwinner R40.

Unlike conventional Display pipeline in allwinner, R40 have
TCON TCOP which would interact various block like muxes,
tcon lcd, tcon_tv for better pipeline fitting.

For MIPI DSI pipeline, we have to configure the tcon_lcd0
block which would interact with tcon_top for upper pipeline
connections and dsi block for lower pipeline connections.

So, this patch created that pipeline by adding new nodes
for tcon_lcd0, dsi, dphy and connet them to make proper
pipeline fitting.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 219d2dca16b3..eb6b2960c700 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -623,6 +623,7 @@
 
 					tcon_top_mixer0_out_tcon_lcd0: endpoint@0 {
 						reg = <0>;
+						remote-endpoint = <&tcon_lcd0_in_tcon_top_mixer0>;
 					};
 
 					tcon_top_mixer0_out_tcon_lcd1: endpoint@1 {
@@ -701,6 +702,45 @@
 			};
 		};
 
+		tcon_lcd0: lcd-controller@1c71000 {
+			compatible = "allwinner,sun8i-r40-tcon-lcd";
+			reg = <0x01c71000 0x1000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_LCD0>, <&ccu CLK_TCON_LCD0>;
+			clock-names = "ahb", "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_TCON_LCD0>, <&ccu RST_BUS_LVDS>;
+			reset-names = "lcd", "lvds";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_lcd0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon_lcd0_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_lcd0>;
+					};
+				};
+
+				tcon_lcd0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon_lcd0_out_dsi_out: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon_lcd0_out>;
+					};
+				};
+			};
+		};
+
 		tcon_tv0: lcd-controller@1c73000 {
 			compatible = "allwinner,sun8i-r40-tcon-tv";
 			reg = <0x01c73000 0x1000>;
@@ -798,6 +838,39 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun8i-r40-mipi-dsi",
+				     "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port {
+				dsi_in_tcon_lcd0_out: endpoint {
+					remote-endpoint = <&tcon_lcd0_out_dsi_out>;
+				};
+			};
+		};
+
+		dphy: d-phy@1ca1000 {
+			compatible = "allwinner,sun8i-r40-mipi-dphy",
+				     "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01ca1000 0x1000>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&tcon_top CLK_TCON_TOP_DSI>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun8i-r40-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3

