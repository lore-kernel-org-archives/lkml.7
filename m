Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C4C2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MQeNgF/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEGNHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:07:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfEGNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:07:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so4167817pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmbbR+nEPRU8PAUrqs/Xp1Cybc4IWp6SjLWLlkBHpm0=;
        b=MQeNgF/ztfyfJPkOLp8v44evWaHK6oQNiqkbYk6h5b2kjyPiu6a9LJ5OzAeVCfV1bv
         eXov666QPajT8xgYjzaUgoDgyOvsb27oueOSiVnHWAqcG9Q6V47EeBKCQryKWP53/JtH
         G8SChDw3Fr+NIFF9Q/ph7KdV8veIMSpgTWz04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmbbR+nEPRU8PAUrqs/Xp1Cybc4IWp6SjLWLlkBHpm0=;
        b=bXNhnLybE5heH+/GDJWfChUi/dZb+eDyVxklP+a/vX3vgz/bUpGfneKaLJv2OtMaGl
         TZpFUdQcbvBdUYZVOeoVuIRAq5vGzl4CdpiggaumQ7Go/4V1jTwv9n0pJUFfkftkztf+
         FaFHEe5ZvHbXUlbv2rALYivnHqDMriXpdAzeBx3CbFXPcnkR5Rg/yxmNmhHS+3QcQUHg
         BbQurjNGpqaIFuUy/9ohnRsFDj6ahRuMjua1AIWzyAu3uU9WWiizzptBDVVJTUUrhBFx
         3ioknLw9TiMdRgnfN9TceWRA0gXI7RHwP79XuktmPUlc596UdxdYtlyrhv8jz37LdOY+
         o4mQ==
X-Gm-Message-State: APjAAAX4u0Abgnqdjq4nzH3/0vdMOV5ksF7n2O1iSPJunt6V7ZFQtsCP
        oqqjvV9gIRSWvmFHCC1QL4vH7g==
X-Google-Smtp-Source: APXvYqxLeInLf88kjLthLdkTwo1/yWUp+xFEYrpTiTrZa+Gcgm+ciJnRApUuxQzvX/3b2mjsA5Dy5Q==
X-Received: by 2002:aa7:92c4:: with SMTP id k4mr42376765pfa.183.1557234459930;
        Tue, 07 May 2019 06:07:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3682:cdb6:452:ecda:bdfa:452e])
        by smtp.gmail.com with ESMTPSA id w190sm21889823pfb.101.2019.05.07.06.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 06:07:39 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [DO NOT MERGE] [PATCH v2 3/3] arm64: rockchip: rk3399: nanopc-t4: Enable FriendlyELEC HD702E eDP panel
Date:   Tue,  7 May 2019 18:37:08 +0530
Message-Id: <20190507130708.11255-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190507130708.11255-1-jagan@amarulasolutions.com>
References: <20190507130708.11255-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FriendlyELEC HD702E is one of optional LCD panel for
NanoPC T4 eDP interface.

It features 800x1280 resolutions, with built in GT9271 captive
touchscreen and adjustable backlight via PWM.

eDP panel connections are:
- VCC3V3_SYS: 3.3V panel power supply
- GPIO4_C2: PWM0_BL pin
- GPIO4_D5_LCD_BL_EN: Backlight enable pin
- VCC12V0_SYS: 12V backlight power supply
- Touchscreen connected via I2C4
- GPIO1_C4_TP_INT: touchscreen interrupt pin
- GPIO1_B5_TP_RST: touchscreen reset pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- use force-hpd and delete-property for edp
- use generic backlight brightness
- add simple-panel fallback compatible

 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
index 931c3dbf1b7d..4cacd09658dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -46,6 +46,14 @@
 		};
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		enable-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;	/* GPIO4_D5_LCD_BL_EN */
+		pwms = <&pwm0 0 25000 0>;
+		power-supply = <&vcc12v0_sys>;
+		status = "okay";
+	};
+
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
@@ -64,6 +72,18 @@
 		fan-supply = <&vcc12v0_sys>;
 		pwms = <&pwm1 0 50000 0>;
 	};
+
+	panel {
+		compatible ="friendlyarm,hd702e", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&vcc3v3_sys>;
+
+		port {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&edp_out_panel>;
+			};
+		};
+	};
 };
 
 &cpu_thermal {
@@ -94,6 +114,25 @@
 	};
 };
 
+&edp {
+	status = "okay";
+	force-hpd;
+	/delete-property/ pinctrl-0;
+
+	ports {
+		edp_out: port@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_out_panel: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
+
 &gpu_thermal {
 	trips {
 		gpu_warm: gpu_warm {
@@ -130,6 +169,17 @@
 	};
 };
 
+&i2c4 {
+	touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PC4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;	/* GPIO1_C4_TP_INT */
+		reset-gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;	/* GPIO1_B5_TP_RST */
+	};
+};
+
 &sdhci {
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
-- 
2.18.0.321.gffc6fa0e3

