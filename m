Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C2C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5410320874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfHZPjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37489 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733084AbfHZPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so15806828wrt.4;
        Mon, 26 Aug 2019 08:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dEBK2/0QEjcEIbTow6H8atvD57XckSzsqrktuuuwiQ=;
        b=OCAKU52hK0T9S5eI8kcxW8qWsy1dxmabdatM9GOKmljpRiGV7rh40tItEnLXAubjor
         pXP4TsTuocQv8aS1Kj+CunwsuEPDcPGYMsMwoNqhnkYS322+gi/ckEvWY5Aan9PpWmly
         sQy9WcfzjSFx6rGMLOmqbqAoIQ5XD3ve1vyymO/9k2hMVGvR0dNZ4C3yQDYS7PSj6E84
         q0BGUvUW2PtK06jjonMPhozUJROfquf31Bt2cbk+lgh0lLyA6CPPzjBSiZlL8AG1a7Qu
         A928hqRPP+fwLk5Z1yfjMcc/I+hKgwB2WgCarzA7VCNEqYiVHf5/Nsdr/mg9lHusT9xX
         DWEA==
X-Gm-Message-State: APjAAAXf5dcKiaIugP31VLO9+/dWrMqd8hcbTey4ZiS3VtyB+QPj+gn3
        2fEx+/7/0Y0eDn94dLNNNsP4cLdPD64=
X-Google-Smtp-Source: APXvYqwjXotGvt0EQ3krMpcIpOWZidN92OK/jBtmB2hqylriN76aoWIA6r+Xj3p2ErKfcs5YQG1CBQ==
X-Received: by 2002:a5d:63d0:: with SMTP id c16mr23237426wrw.22.1566833932617;
        Mon, 26 Aug 2019 08:38:52 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:52 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/12] ARM: dts: imx7d: cl-som-imx7: add WiLink8 WLAN support
Date:   Mon, 26 Aug 2019 16:37:58 +0100
Message-Id: <20190826153800.35400-10-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add / enable TI's WiLink8 WLAN module on SDIO2.

Notes:
* power is always enabled (because of bluetooth)
* the downstream delay of 70ms after power-on
  doesn't seem to reliably work, hence it was
  bumped to 700ms

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index a16cbb070a12..4cb36decef3d 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -28,6 +28,24 @@
 		compatible = "smsc,usb3503";
 		reset-gpios = <&pca9555 6 GPIO_ACTIVE_LOW>;
 	};
+
+	pwrseq_ti_wifi: ti-wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pca9555 0 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <700>;
+		/* 10μs during shutdown, but 60μs between two enables */
+		power-off-delay-us = "60";
+	};
+
+	reg_ti_wifi: regulator-ti-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "wilink-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca9555 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
 };
 
 &cpu0 {
@@ -232,6 +250,31 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_ti_wifi>;
+	mmc-pwrseq = <&pwrseq_ti_wifi>;
+	non-removable;
+	cap-power-off-card;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_wlcore>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -308,6 +351,23 @@
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x19
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
+		>;
+	};
+
+	pinctrl_usdhc2_wlcore: usdhc2wlcoregrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO15__GPIO1_IO15		0x34
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-- 
2.23.0.rc1

