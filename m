Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F71C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE27220867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h43kBO4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfJEOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:19:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38993 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJEOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id e1so5424583pgj.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sUB0RooONzqGELXbytY+LCL6wUVKNVeZUfz3wJVzw4=;
        b=h43kBO4gkvkkFs9AcbIQ2JN0yVcInn0HaBvXKvfGyM9qcSJgl/vsmd1u+bgYJOE0cx
         3qeTR/2h78QA02/D/R+EcsDBWI1dkXb4qutu8bWvyVpXe4iCghv3OV5MdTu357cqf9d3
         1jAGQ/5oRtDxAiYN9K3zXBPrxycQVfbLe414o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sUB0RooONzqGELXbytY+LCL6wUVKNVeZUfz3wJVzw4=;
        b=eCAsAdUhaRd92Q3PBaeDi/l0Zw0NxqPE+ikaGJtkwFNj2OS9h48EOGxNG1+cNRV2wy
         1bYznutDgvStjGFKk7Blybj+3wWiXJYf7E3zQGgLrUMALbw2tqeG0cr3JlkATJjZcrVV
         18rLxYu2YkGGrBlFe0oOR5PhUly6VzdWE4FX0Z8ZIMQXLRIGaLA481Dhb5RxFbYSHWCn
         K5Tgc5jYBCY4Lb8z7WNfeuWIR8UIfZmK+rGywX0jX+rHxhBIwVWOvNQ6d+987lRq2C6/
         t0LqGewr77VVE5e1AmpeONNRW0UvOL62HR/YXhNgkptsq5wgv5OAegTCnJ2+hpXkbZFJ
         tBQA==
X-Gm-Message-State: APjAAAX7Yr1XUOOz2uu83p3c9xswF2Sf5O4sGaHcHlVJermz/G19dcW1
        LYA6nWcxzT6fL+XIj2iT6BdTog==
X-Google-Smtp-Source: APXvYqx10j7PRU3fLEOZ4azx/txsZuy2oIBSXEvFfbkS6wRKhiOEl3gRVIzJmlphFdU23Kz8OymjUg==
X-Received: by 2002:a63:d34c:: with SMTP id u12mr1238630pgi.88.1570285184885;
        Sat, 05 Oct 2019 07:19:44 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y138sm8977604pfb.174.2019.10.05.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:44 -0700 (PDT)
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
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 5/6] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Date:   Sat,  5 Oct 2019 19:49:12 +0530
Message-Id: <20191005141913.22020-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191005141913.22020-1-jagan@amarulasolutions.com>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 69128a6dfc46..ad4170b8aee0 100644
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
@@ -1003,6 +1009,38 @@
 			status = "disabled";
 		};
 
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
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

