Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6524D24650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qaT1g3Qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLRTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:10:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50579 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfLRTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:10:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so1315691pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5rz72YPbxV0B26OX0MAGWfHxZgDOqp0oOHgAxqpqbs=;
        b=qaT1g3QmNSjlk34e0bfdy9ok+w4z7oyVUgr/NLUWpn0Oeeg4030IT0FUAPHxkGLpW2
         nm5uqYdeYz0gdfZQX7XhcduE2jn0as8ipVFztZ+l9wYNbFSw+xeZctKwIMzniClzk8y9
         /E3IE7wjWrfw9HxDHrayx0rahNLm4pOONqFW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5rz72YPbxV0B26OX0MAGWfHxZgDOqp0oOHgAxqpqbs=;
        b=A/TsWW6QMlcwbw+ZUXNe4SVhsrjxOGwg9MPc0kOr9+BDbqm+cXbBOyrdi+DQ/raxR+
         cJ+ATB8WwmHHOCcX3QXXwDABIF0XWSBQJwdtgsI4bTl/S7v2RGtyfnQw8W+a5zmW9caV
         zNH9MERFHn+WLsLx7F+NW8mtYq02p9w6rUQ2WqkarzB/KoohMcsx8/jhhlt5QSi40Jfw
         YD1SlPkto3wZYz0tPeJMa5zyp3LqOwJnmRbfXojUNwzpRz/KQ0bA8OrsRouhhjFmF14I
         RRLKVi8iMScpMwCG5PUrqVD8zymQ2uEdpaWqWXtkSHOzGhm3AbdzZCVhDteEWB53/RA9
         TGWA==
X-Gm-Message-State: APjAAAWtwRw7SgdKlE0OjQ+bI0iemL6oPPXr1JCNMjkPZ+5W/2kavlhy
        7EPzc8mR0xs85sv+WWBh7mzqKA==
X-Google-Smtp-Source: APXvYqzccrxMy1V4bhDCzwLVd/gItseX9VcdLFb7kIF0/DVHj/GS9ICbTrMaOY4u6QU+QI9+PyR5Mg==
X-Received: by 2002:a17:90a:cb08:: with SMTP id z8mr3892894pjt.86.1576696253896;
        Wed, 18 Dec 2019 11:10:53 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:78ea:e014:edb4:e862])
        by smtp.gmail.com with ESMTPSA id q7sm3745855pjd.3.2019.12.18.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:10:53 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v13 6/7] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Date:   Thu, 19 Dec 2019 00:40:16 +0530
Message-Id: <20191218191017.2895-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191218191017.2895-1-jagan@amarulasolutions.com>
References: <20191218191017.2895-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI DSI pipeline for Allwinner A64.

- dsi node, with A64 compatible since it doesn't support
  DSI_SCLK gating unlike A33
- dphy node, with A64 compatible with A33 fallback since
  DPHY on A64 and A33 is similar
- finally, attach the dsi_in to tcon0 for complete MIPI DSI

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
Changes for v13:
- none 

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 27e48234f1c2..1db8378f59a4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -382,6 +382,12 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon0>;
+						allwinner,tcon-channel = <1>;
+					};
 				};
 			};
 		};
@@ -1014,6 +1020,37 @@
 			status = "disabled";
 		};
 
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>;
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port {
+				dsi_in_tcon0: endpoint {
+					remote-endpoint = <&tcon0_out_dsi>;
+				};
+			};
+		};
+
+		dphy: d-phy@1ca1000 {
+			compatible = "allwinner,sun50i-a64-mipi-dphy",
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
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3

