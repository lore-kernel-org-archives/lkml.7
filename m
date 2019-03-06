Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C97C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A1C20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am6u+R1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfCFWlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:41:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39243 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfCFWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:41:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so11802318edc.6;
        Wed, 06 Mar 2019 14:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=Am6u+R1M57Q77JRUcnj6M+Mc/Ryk4ODwE1rBV2WoxlGBGSI1gv6riDoxOS2W9uBYMb
         ZHKwVlkm6mKPq3v9ksR2z6ITHXXGL1eYQ44eFhmbJJ9oWrLH+HtDev79xDBdhT4D0iUQ
         QuQNyvPX039BWl3lVct9QcJpHLZMfXkJ9hNojAlXyADMAtXoIiIABsYgq6mBRzHfS/r5
         mtYO2c49zhMbBVrmLz0FrC0EHdFnEPH8Qt6OHH+U8BeCnIAPT9DlXQKINUieLXltrH4t
         TQc2KruI3s2MVI35dYjqqjr595TO5NVsTU2vV8o6B8DbdPdI8GIJ6moIj0HzPPl0KUKB
         hrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=Z7KM7SCP5UhXn4UhD606bP5DCOInJh/IUpeIq+UYdy+9yKnNJC1NwJctv1jjJxoDyg
         Nsun4x9SX5yaQAtSdS/OO3n4sbKRtK5aIq51nKyL9TrS03wx5Jm50gUCyZgsf9h+CPaa
         CmWnC2K3AF4H/LR5IJWVP4xiicdPIc9qMkdSETFd3h/hNw0ZnSLPa31YtwomSEFjo5he
         ry8hOgOPgnlhTPolYgNzRmuEUOcqO3xnR9KyH6J5UFld9eA8Bvh1ONxqmOHBDBBTWUpp
         87zuWvVhW3e5tumEjj1BcKFNvg8bLFXZK79XtKaS6JeGnHhS9YqDKt3B8xj5AA8TK4IT
         E2mQ==
X-Gm-Message-State: APjAAAXyWCqVDJbzg0mh/hzLYvcBxUvIiUifmNywdzaA6uz4FUwbR6ld
        N5G50OsXUeKYa3Iwqp1HB/A=
X-Google-Smtp-Source: APXvYqx8YiJr1dlwgs7sisLyVrfa3nMX358pNStosFeKeS5f9coAkaq2pWbcqjSLHapx331ao4XO5w==
X-Received: by 2002:a50:b786:: with SMTP id h6mr25369459ede.85.1551912086698;
        Wed, 06 Mar 2019 14:41:26 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm801356edz.58.2019.03.06.14.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:41:26 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] ARM: dts: rockchip: add rk3066 hdmi nodes
Date:   Wed,  6 Mar 2019 23:41:11 +0100
Message-Id: <20190306224113.24853-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190306224113.24853-1-jbx6244@gmail.com>
References: <20190306224113.24853-1-jbx6244@gmail.com>
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

