Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4AAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37960206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J/G0CEgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKUOPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:15:23 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39375 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKUOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:15:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id t103so1526408pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28NKNs8dkxykNhTWIYrgk/H7+AdKWGipA1r9x9pF6H4=;
        b=J/G0CEgF9pu6Q6u9K+4b5CMj2oIcyKeAgWEYWZ0KAnAY96q/ia7+hOU23ZCPcya8W9
         5DVbOFfuzqcPZ1wF1T6MFehBWp+QDmEsXPUlYJxliXC9SoZXX7qy+zl/V5GB8TjasSzR
         UPWAiqGvq8dXtx67JR2gb0mQTI1gU+bJp5pgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28NKNs8dkxykNhTWIYrgk/H7+AdKWGipA1r9x9pF6H4=;
        b=j6CDU+jTV8hXYEbg6AfI6OjyTmdNftrVppihCRd5fuapTCi9KnryClgkx5x+Yet6kZ
         +ytow4FTXwTQzjQ2AF46YpoQlp9w7D/d3bhDxpxjgMGWX0Rv8d4xoqnOEi5QRtWj5TbM
         cH0G/S889ypzUeH3dziHxPL0lbKoxkNS3y+NDxOGTeEqXCbOpWz5IWhFG/OIxqInlQG3
         uTVaSMoDxROthcdzwDpMmKcE7vTg73o375cymZ3TldzEZ2iqA8J97/PcgKji3Bm8264e
         ROIK+nOnZ+4Qy9xbPquDMZxwRw9EUMh6BiO6VTKr/mGK5ebDymm6RSYnQZhvCRXKQhr7
         GK6A==
X-Gm-Message-State: APjAAAWysByMJ6VweUTfSk5Cl4YKyjekmISA7wVRTy9dhb18vZd+OxCC
        +vWv6+JM+gT7BKp0kXQpL27J/Q==
X-Google-Smtp-Source: APXvYqwrzn/yAW5BCNIum3Ewx8sgniyuYqnWVlppsp/WOPJZ/C2fWYKta18r1cYdnI9p8rKvOjCuKA==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr8695155pls.94.1574345721637;
        Thu, 21 Nov 2019 06:15:21 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id w138sm4072304pfc.68.2019.11.21.06.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:15:20 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 4/5] ARM: dts: rockchip: Add Radxa Dalang Carrier board
Date:   Thu, 21 Nov 2019 19:44:44 +0530
Message-Id: <20191121141445.28712-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191121141445.28712-1-jagan@amarulasolutions.com>
References: <20191121141445.28712-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carrier board often referred as baseboard. For making
complete SBC or any other industrial boards, these
carrier boards will used with associated SOMs.

Radxa has Dalang carrier board which supports on board
peripherals, ports like USB-2.0, USB-3.0, HDMI, MIPI DSI/CSI,
eDP, Ethernet, WiFi, PCIe, USB-C, 40-Pin GPIO header and etc.

Right now Dalang carrier board is using with two variants
SBC, like
Rock Pi N10 => VMARC RK3399Por SOM + Dalang carrier board
Rock Pi N8  => VMARC RK3288 SOM + Dalang carrier board(+codec)

So add this carrier board dtsi as a separate file in
ARM directory, so-that the same can reuse it in both
rk3288, rk3399pro variants of Rockchip SOMs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- use dalang carrier board as product name
- s/rockchip-radxa-carrierboard.dtsi/rockchip-radxa-dalang-carrier.dtsi

 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
new file mode 100644
index 000000000000..df3712aedf8a
--- /dev/null
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2019 Radxa Limited
+ * Copyright (c) 2019 Amarula Solutions(India)
+ */
+
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&gmac {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <140>;
+	i2c-scl-falling-time-ns = <30>;
+};
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	vqmmc-supply = <&vccio_sd>;
+	max-frequency = <150000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins =
+				<4 RK_PD6 0 &pcfg_pull_up>;
+		};
+	};
+};
-- 
2.18.0.321.gffc6fa0e3

