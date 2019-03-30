Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8575C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B992218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlzAXK0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfC3J44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:56:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42234 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfC3J4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:56:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so4051482edc.9;
        Sat, 30 Mar 2019 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=HlzAXK0womW+Hf9QD73UxMsBj2WICfrLQScI+NOIwpLCyjN81HO15fehq+cNUEQ1US
         7HChdWkGKIM0+VT6z8DCHaAfMidI4L1dh0Wf4BSdqhytNfiRUgSFIgqMv77SQjDobP77
         6QtjOQ1uJJLDmHnM9W7BbPKqy7oOfSzlgJM81EvLw+Ya/Kyu2DV1BZrT+A5GZMKE+OCz
         10WJst8IFMWwZZgiwrfuUDLVqivLmxhliT9f1R4rNTjnTlgRgVjYRd49I61cMdgd2EFR
         wV66f1Gx18uxQxstZ6D3lDxKogiCVxtKUB4zxdq24hZG/9Y5979i3FNBUGkYF01Llxgx
         gJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=tRyEdvIbEFqDG+KjS0Kt438/ip88TqIxKDuqJS7OC8AwG5P5Q9b3qULUSZZHW3Qs9B
         J0QyE4zc66x0JeJRqp6YR6DUawmX2Els3v/NUXSxNUM7SHqetLrbyeV5eMZBE258sDSs
         g4AcLHZ2HLWfe34gH/E4LWvU9HW1J0LiN0ZgcjPzm6xAFJDkijTYZ0wuN8nxR0HPWxn3
         /+198N/Ao9a7HvDh1Xn+OMi0pfl0HN9O7FY9GMZ9JTAUJSS742rRa8IqufJmXXr6qiqk
         lGTPpqt/mAtuhVzsuqX7LUQApileWDliLA3HlbayiAAqgAWls2cwqP1n6k+tpXnQzCJ9
         xcwg==
X-Gm-Message-State: APjAAAWi4NV4kj3s4QTLsDT/mth8MFoXIIZXtwkKcBdPnbJrsvoI0gZw
        v6BzrbOuXPjGHWEMf2udOpugCs7D
X-Google-Smtp-Source: APXvYqx8xE1kifuBFQ7GziX/ADjOZkRLAIcZkENI0mvPq1mHQZLG9oiDkEkX1tBYWyFn9J1lA+UHgg==
X-Received: by 2002:a17:906:583:: with SMTP id 3mr7637305ejn.217.1553939811795;
        Sat, 30 Mar 2019 02:56:51 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b34sm1087921edd.24.2019.03.30.02.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 02:56:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] ARM: dts: rockchip: add rk3066 hdmi nodes
Date:   Sat, 30 Mar 2019 10:56:37 +0100
Message-Id: <20190330095639.14626-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190330095639.14626-1-jbx6244@gmail.com>
References: <20190330095639.14626-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

This patch adds the hdmi nodes to rk3066.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 653127a37..9c43b985a 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -80,6 +80,10 @@
 		vop0_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop0_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop0>;
+			};
 		};
 	};
 
@@ -101,6 +105,44 @@
 		vop1_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop1_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop1>;
+			};
+		};
+	};
+
+	hdmi: hdmi@10116000 {
+		compatible = "rockchip,rk3066-hdmi";
+		reg = <0x10116000 0x2000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HDMI>;
+		clock-names = "hclk";
+		power-domains = <&power RK3066_PD_VIO>;
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in: port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				hdmi_in_vop0: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vop0_out_hdmi>;
+				};
+				hdmi_in_vop1: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&vop1_out_hdmi>;
+				};
+			};
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
@@ -415,6 +457,16 @@
 			};
 		};
 
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_out: pwm0-out {
 				rockchip,pins = <RK_GPIO0 3 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.11.0

