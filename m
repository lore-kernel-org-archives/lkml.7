Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD53AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFDF22419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZqDzjSyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfKTLlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:41:15 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:42046 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfKTLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:41:14 -0500
Received: by mail-pj1-f65.google.com with SMTP id y21so4006731pjn.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVPX3M80KZd4Q7MyVkxEYzA1D5QxK+GgoYXRS5JRiWY=;
        b=ZqDzjSyu/fJt3pgq1ysJiWYhXrLyTzhXDBrZ5o4XvAGgFy+WV2rmWSXsYxD8QUEJ4V
         bMdu4rEg/t/AiDp//7xaPwe5NjRNz14aO2qUAQtJIB3nUvAZ4iqXm40CwYWN37Gde2+b
         OrcCSVDSB5DHAKYBmCSe89OkQu0/k0kqQoSbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVPX3M80KZd4Q7MyVkxEYzA1D5QxK+GgoYXRS5JRiWY=;
        b=rKMAANBpd9Qfy/oqPJQIrmFfC4dWMl/0xw6fwWVCGtmHpmJfPtgcHGByI6Ga8swm71
         w75Inn/Mya9Zp/2B8SFH+l9BvdnfcmDYx914/HPAZKoK7iYReuzZ8CeJfaNNeA5Nf8zd
         f2yq86r0JW0xCRId2SsAA26nk76xsbiZHRXS5Wg5BEShQcR1aUsZq/Qf4WY3wQmiWxeU
         /WEjMh+s8OfqACLosHjXhbSs5TM5pxev/jrelWlCzMyduqyaVOv29eCNiQZDAbNPpj3d
         +D/GibW5ciKTt73UU4b/CeYU02yp9eCVoKNSU/kbJQ5D7qcMupb/GPneaG6cjvcGq0tD
         XAPA==
X-Gm-Message-State: APjAAAW07/ha7AJ+PFRhHOIy/v518zfFILXEZ/tMy0Xdn2p5AhRS6rMy
        gNFoNi6ezcmTX/cL+uafnxqFfQ==
X-Google-Smtp-Source: APXvYqwqL32dNuB7yaQ+9XBJponJe+hREoVt+opsUP7F+TjCrG3qhm4CRk19jTvicZ+iQ7HWGEShhA==
X-Received: by 2002:a17:902:d901:: with SMTP id c1mr2461318plz.93.1574250073423;
        Wed, 20 Nov 2019 03:41:13 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id h185sm13492850pgc.87.2019.11.20.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:41:12 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/5] ARM: dts: rockchip: Add Radxa Carrier board
Date:   Wed, 20 Nov 2019 17:09:22 +0530
Message-Id: <20191120113923.11685-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191120113923.11685-1-jagan@amarulasolutions.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carrier board often referred as baseboard. For making
complete SBC, the associated SOM will mount on top of
this carrier board.

Radxa has a carrier board which supports on board
peripherals, ports like USB-2.0, USB-3.0, HDMI, MIPI DSI/CSI,
eDP, Ethernet, PCIe, USB-C, 40-Pin GPIO header and etc.

Currently this carrier board can be used together with
VMARC RK3399Por SOM for making Rock PI N10 SBC.

So add this carrier board dtsi as a separate file in
ARM directory, so-that the same can reuse it in both
arm32 and arm64 variants of Rockchip SOMs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../boot/dts/rockchip-radxa-carrierboard.dtsi | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi

diff --git a/arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi b/arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi
new file mode 100644
index 000000000000..df3712aedf8a
--- /dev/null
+++ b/arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi
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

