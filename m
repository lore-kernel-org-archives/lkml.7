Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A68F217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KbHFlaqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfFMSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:54:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42317 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfFMSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:54:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so23771pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/4U16vvQGase4vs4TRs7L3uRB2ytO65pgimZPKYacA=;
        b=KbHFlaqMD2kqOC6eLMSZ/P/yNXg/rG2kkuDRU+E2oafp+sX5bCe/oyFFZWkokEFdpe
         KxLjoFo/XZKKnGHd8TH/oXi57kQ8/LCJ5yGIfggd39uHXR5u6PdisOd4M8IFVVS0QZfU
         0OVEi5vRXM7yY32N6shvO8wFE7A+MLq8ZD3PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/4U16vvQGase4vs4TRs7L3uRB2ytO65pgimZPKYacA=;
        b=lPqF0GWClzxMAgvR4ZzQGutkFi4CKP6KmUf2As8UsQBLTj8Izlornzee1RwzOZDqTy
         O3tNthIegxyq3f4KS3LAqIPQWgEZa3EprH3yDn2qQ8ygxGZYZfXVdi+Jp0tTaJ34HzUF
         QrvgXK5PNyrkXeZTZsub66hJEvTYtVcKt1YIO16cWOsVsI7SZt4R/AG/pyd62SsZlFKc
         JSSBCU/kbzb39yiLOJAJz2VzWJXcFTMnl1e5HUpDQbFU2VI+TioYmm+QapA0EyWCoEzU
         hbRPaWvmKPxQd7oIqlbodVgKv+lXuJVwP/g6ON3mo31JIvKuj2+pHFbTnO1GW9xk7fYk
         uWfQ==
X-Gm-Message-State: APjAAAW1dfnj/rm7az/xVQVB9JK9UM7KFD2oaWZvQ/8pgo6j976fOfon
        QwWiBMOSZwdmyg4TYT4WTUWQSQ==
X-Google-Smtp-Source: APXvYqxT+brkKX51G25d0U8KdaLgp4yzQxdSegwAI+SiWhaPnsQQo4LdoqiNNX1Bt+Ys7OneEcILbw==
X-Received: by 2002:a63:4d63:: with SMTP id n35mr2616452pgl.43.1560452064500;
        Thu, 13 Jun 2019 11:54:24 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:54:24 -0700 (PDT)
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
Subject: [PATCH 8/9] ARM: dts: sun8i: r40: Add MIPI DSI pipeline
Date:   Fri, 14 Jun 2019 00:22:40 +0530
Message-Id: <20190613185241.22800-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
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
index 12576536df4a..3ea2451151ff 100644
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
+			clocks = <&ccu CLK_BUS_TCON_LCD0>, <&tcon_top CLK_TCON_TOP_LCD0>;
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
+				 <&ccu CLK_DSI_DPHY>;
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

