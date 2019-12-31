Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CEC2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D62206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Xf+YTt7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfLaNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:06:24 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56300 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfLaNGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:06:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so1171631pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXe17pB2YX4+a+B1E8N8lDCTkuNeVa3zzzOGyzeuSys=;
        b=Xf+YTt7DfVvRCedUsAinpV3gLCg7SQWb27vKaMoWf0AxV5Ig7mLEyrsAaBoKisMnpo
         kGQVw1Tzx4RxuNcQ8CW292dVNXAccfNluNAT1XJL9XHIe1o5EriOTeHp6Z/Izy71lKNf
         ieLQ7eq/kP+w1W9qC/RIQ3WAHWZG3kTzWynY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXe17pB2YX4+a+B1E8N8lDCTkuNeVa3zzzOGyzeuSys=;
        b=E6YCpKVWTRvWoZpN2AUSN2t9bUQTf9YwUYWucRwPNorOQqlp0lPfhfhafB77TKLuva
         kjU0v+S5hoIVDW9cB0PTZQiFUYdII/kDtf6YnFx48LswjEkTQKRetsHglPF6W/SHXK0K
         QZjzfYlG9AaPAcXADqvl/No91eUqOFX5yPdaCnENEe47FfCrsRjsbx/haVzHj2yUv6og
         lJs+DIuoCYwDfQxLvxCbcWw5iPILbPI4kE/bJwlmNjPVQSLTUntFpJ3O1Y/RwMPt63TY
         ca0aNVQZxEFvwxm3RA1TGwhn68CwNZa568trwVor7EaITiM2Qj53v2txBzrhE1guiGvM
         B2Og==
X-Gm-Message-State: APjAAAUbbHlDs0hZ5ADXHwvlNQ72GRUXkQWkYol6Ie8LyB/J+h5J9rv0
        UKQQ7Q51IZDh0CqXigk3O//uLw==
X-Google-Smtp-Source: APXvYqwgs9Bcy+Z1Q95DxDdQGebtt2lr2Jj5jnrCw2RqXNwEkWy7kQOj9wu1KDy5cwYGG9UM+31XiA==
X-Received: by 2002:a17:90a:e657:: with SMTP id ep23mr5986713pjb.105.1577797582087;
        Tue, 31 Dec 2019 05:06:22 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:06:21 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 8/9] ARM: dts: sun8i: r40: Add MIPI DSI pipeline
Date:   Tue, 31 Dec 2019 18:35:27 +0530
Message-Id: <20191231130528.20669-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
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
Changes for v3:
- drop clock-names in dsi node

 arch/arm/boot/dts/sun8i-r40.dtsi | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 3faa35d43afa..4c61e93d9a0b 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -628,6 +628,7 @@
 
 					tcon_top_mixer0_out_tcon_lcd0: endpoint@0 {
 						reg = <0>;
+						remote-endpoint = <&tcon_lcd0_in_tcon_top_mixer0>;
 					};
 
 					tcon_top_mixer0_out_tcon_lcd1: endpoint@1 {
@@ -706,6 +707,45 @@
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
@@ -803,6 +843,38 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun8i-r40-mipi-dsi",
+				     "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>;
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

