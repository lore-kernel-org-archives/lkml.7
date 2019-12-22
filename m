Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91228C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6887321655
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aN/z+SvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLVN34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:29:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so7446676pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xq2qov66+ZKQzbRfM2Ia41hD0OqHDHdZrt8IUGMciys=;
        b=aN/z+SvOEIOG7pKfL3EAs/o2YJxa4fGDyhDurxf9BFee4oUQOYmh5YDzvcR0++/wgO
         /UTCY/yccmcyFCUrb3G+F+ufbTU4HXVCd7avRL5pQXSUmTfQVhcoU3sY2/gnEzWFBgd2
         V4V2g8nvEvUnNSKNJoHUWTG97hocXPGtyNhps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xq2qov66+ZKQzbRfM2Ia41hD0OqHDHdZrt8IUGMciys=;
        b=BVXAVAWeJmW0+ogUl5XvBSoHL47qSLrqyq2zLox/Bv+YqJIsLSiA8ogYc4eZVQheSQ
         rGkAYstReXXWHoubJCdeJkNrs8r1LmBWMIIbRyuMLxz1ashSqatkfH+LL7xVozQR+pfV
         qoHMb849aYyhLD9rJNRpW/LW9Oabxw6a1S1IPEow5Gs4PRMxNnQjiCAzFSES3hbAkH06
         cbrnNyQ5tFuj8jd1AW0afGFISpW13q60C3HribK8e8j1+ala2c3X3euF7aMjVAO4VjVo
         B76a6dRCQk4Gs+l0DmjxE3i2m1CSZgqRbIWInoMPg4Qa5ghrY3R+rLrRblzy3r2Lg22y
         ic1g==
X-Gm-Message-State: APjAAAU8awMkGmWEzjYmbNx4k5eUH9tzT68Vr0C+EzGbR5Girn4HnX1u
        PxAbw3bpR3sCYdXV1SFheM/49w==
X-Google-Smtp-Source: APXvYqxHOIWV1QpzQpqIk+oG3B9jfIK2/Lz4J3qY5Xg5MsBrwBHFlLSPubYChCJEMqxNWmsb1jEwpA==
X-Received: by 2002:a63:e911:: with SMTP id i17mr26186191pgh.42.1577021395126;
        Sun, 22 Dec 2019 05:29:55 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:54 -0800 (PST)
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
Subject: [PATCH v14 6/7] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Date:   Sun, 22 Dec 2019 18:52:28 +0530
Message-Id: <20191222132229.30276-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
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
Changes for v14:
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

