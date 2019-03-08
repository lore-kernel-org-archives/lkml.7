Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4672085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QWdThOdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCHSMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:12:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43774 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfCHSMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:12:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so14743153pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUKQaODABn/oZOf+onZ5rneyapc1XbYqiZDDzJ++KSE=;
        b=QWdThOdHurz8h6fibdN4+5+ShZDElRmH2KDA2naXuuPSpiev29/DefNwsT7WoyJocJ
         uGg0YXcgoRmAbWGN2Jc3n+BCu2/4f5VOS05vaweuRttfOndgJUpwApXqREvBONTOWdX2
         48BVZDtjpubpaoG6qUeHvR+t9Tknrn+lz4klQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUKQaODABn/oZOf+onZ5rneyapc1XbYqiZDDzJ++KSE=;
        b=qH91uVSI843HHvfkoc+yIHJopPwHetDNYRtfH2gh4jc6dp6cppLEmwQi/Uyayz48OB
         dQB3672S9Ly5iaM0PthkuVZfPu/UMSGQZVJt/Zb6kirLQjoIbTixXEYvYGuSVh+rokLo
         EiuxUcthGJE90+bAL22uKqLY6KNJLtJ4LXAcLQmHscjiM2lR1+Plqp3jKdPhljFI6vwA
         mMAiL/BR7R2tLnLEY+CLknY5GY1n/qMrntnBrlHCd6AnbV3UyAcS2mPRns80ncD4wFfV
         swmiVCZ68TnShmPXP5j3vg6o5nO1ChQ+xJ0dNdh5j6WxZ1VVxH2zyNenGSL4mjXzY7rW
         IDlg==
X-Gm-Message-State: APjAAAUKY3chqXqtNQpcGtUm7aCPousIVa72gdPHVGxMULK4b1P8soYG
        B5QM8Bzf9+SHUUmjheGA90vU7rpnWhc=
X-Google-Smtp-Source: APXvYqzE6vKZU1Mk2eZz4romYtdZwDHJLpXP9EmDjgloa3Jss3s5xLvTW0k92lwU4+RtmvilcEzImg==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr17841845pgn.274.1552068741679;
        Fri, 08 Mar 2019 10:12:21 -0800 (PST)
Received: from localhost.localdomain ([183.82.225.164])
        by smtp.gmail.com with ESMTPSA id h13sm13783465pfn.114.2019.03.08.10.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:12:20 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Akash Gajjar <akash@openedev.com>
Subject: [PATCH] arm64: dts: rockchip: Add Nanopi NEO4 initial support
Date:   Fri,  8 Mar 2019 23:42:02 +0530
Message-Id: <20190308181202.11607-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FriendlyElec NanoPi NEO4 is known to be a revision 4 based
NanoPi4 series of boards.

Most of know peripherals are shared between Nanopi M4 vs NEO4, except
- 1GB DDR3
- USB Host ports
- Missing DSI port
- USB 2.0 Host with USB2PHY0 (no USB2PH1)

Add support for it, by reusing existing rk3399-nanopi4.dtsi

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 .../devicetree/bindings/arm/rockchip.yaml     |  1 +
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-nanopi-neo4.dts  | 50 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 061a03edf9c8..543237b7b297 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -97,6 +97,7 @@ properties:
           - enum:
               - friendlyarm,nanopc-t4
               - friendlyarm,nanopi-m4
+              - friendlyarm,nanopi-neo4
           - const: rockchip,rk3399
 
       - description: GeekBuying GeekBox
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1b28fa72ea0b..186281fb70dd 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts
new file mode 100644
index 000000000000..195410b089b9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "rk3399-nanopi4.dtsi"
+
+/ {
+	model = "FriendlyARM NanoPi NEO4";
+	compatible = "friendlyarm,nanopi-neo4", "rockchip,rk3399";
+
+	vdd_5v: vdd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5v0_core: vcc5v0-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_core";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vdd_5v>;
+	};
+
+	vcc5v0_usb1: vcc5v0-usb1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb1";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&vcc3v3_sys {
+	vin-supply = <&vcc5v0_core>;
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_usb1>;
+};
+
+&vbus_typec {
+	regulator-always-on;
+	vin-supply = <&vdd_5v>;
+};
-- 
2.18.0.321.gffc6fa0e3

