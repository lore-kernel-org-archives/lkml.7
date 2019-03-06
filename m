Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C58C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE94420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CFZP2QHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfCFRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:01:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfCFRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:01:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so9079133pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmEPyf6mfoIHCeuROjKnk+NZQhF+HOsxvLugnKm3fkg=;
        b=CFZP2QHwquCrz4chV3Yu8VJdLuUVuAr2Vg0tbfUEkCw5lhVfijjPO9XKPXln/emDhX
         0BnZuIRe9BE6TkcAZLRMaFaJlXq/Sg2/RISMFxWCY6Me7XJg24LzGAmwiQgNZKqEmkMV
         SVNQV3JlY68KmLz6Xgk/MX+Gb4/x9OgHtN37c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmEPyf6mfoIHCeuROjKnk+NZQhF+HOsxvLugnKm3fkg=;
        b=UfN6wcuS7rnJrqbH42OVwyLgqTZ8wRAPfOnysqf1FqzN6yOr+QKnS2soRnYoJ2bF7t
         oywBh0TahJkbLt/Z8TYHrKslTAn1884D2AcEmQhULaM7FBl0LHw0fL/KQFMP/sD1TgX+
         TsoWuxWuUBdmVA2AgJTgyc2jHLZ6A1+n9kdjE2UPcxjkO2SiDZVNfoM9+iyuwnonm8vc
         Ba2JxiZV2f6wiWGsdmhFafUGCUsBqVOsd+QfRDUoOgBRTbhsmLCAba38kkiUxd3P2Be+
         m/9vTLDB5cGA+J4v7Y+b56Rq8BkhU0Op11/ovCtz+FG7E4vpgnyki7t3rEOQIcu3PBwH
         U8oA==
X-Gm-Message-State: APjAAAU0bKQuvJGQHIWiyNjWi31IDR6m7VN3zDuYNA6h54cmO4MEP0Dl
        NV/8XhAAaBhBcVVJ5FnrGKoW8A==
X-Google-Smtp-Source: APXvYqyJwg9Tq8/5RG30HWvlo2uKltsF4lB1Y/MQcad/AAVDK/oVga7I5me4srWCXKt/JlnLFCInOA==
X-Received: by 2002:a17:902:8690:: with SMTP id g16mr7866603plo.284.1551891700762;
        Wed, 06 Mar 2019 09:01:40 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:27b8:fdbf:6489:a238:847b:3486])
        by smtp.gmail.com with ESMTPSA id t10sm7797916pfa.151.2019.03.06.09.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:01:40 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] arm64: allwinner: a64: Add Oceanic 5205 5inMFD initial support
Date:   Wed,  6 Mar 2019 22:31:10 +0530
Message-Id: <20190306170110.27342-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190306170110.27342-1-jagan@amarulasolutions.com>
References: <20190306170110.27342-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oceanic 5205 5inMFD is a 5 inch Multi function display baseboard
designed to mount SoPine SOM.

Key features:
- Allwinner A64 Cortex-A53
- Mali-400MP2 GPU
- AXP803 PMIC
- 2GB DDR3 RAM
- SD Slot
- SPI-NOR flash
- EMAC, RTL8211E
- MCP2515 CAN
- 4-lane, MIPI-DSI panel
- Goodix 911 CTP
- USB Host
- 12V DC power supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- rename model to "Oceanic 5205 5inMFD"
- rename compatible to "oceanic,5205-5inmfd"
- rename dts to sun50i-a64-oceanic-5205-5inmfd.dts
- add emac node

 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 0b0917111099..e4dce2f6fa3a 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5205-5inmfd.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
new file mode 100644
index 000000000000..6a2154525d1e
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
+ * Copyright (C) 2019 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a64-sopine.dtsi"
+
+/ {
+	model = "Oceanic 5205 5inMFD";
+	compatible = "oceanic,5205-5inmfd", "allwinner,sun50i-a64";
+
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dc1sw>;
+	allwinner,tx-delay-ps = <600>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&reg_dc1sw {
+	regulator-name = "vcc-phy";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.18.0.321.gffc6fa0e3

