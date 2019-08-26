Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67970C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4037D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbfHZPiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:38:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40108 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfHZPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id c5so16125017wmb.5;
        Mon, 26 Aug 2019 08:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/JN6uYb6Ltt98oMBprPmMJCQ9NUBW/kztrckS3ANvk=;
        b=C/Yo0orMvf4IG+QJOrsWt5xIUrf2v5jD0UxUCH13cZem3LihB8dGWppH+rfWbFSiZ0
         z1g0kXp7SG/fVNyipsTD4JrDQZFyAGHyZEdpbJjFBotomzyYdDa03LdOmwXtoIfD+uv1
         5+diKPHgnIp9msnR/9Q+nIsgU+gI8ozZ/lroQcGzUhkEg+pG1WDP6PnT8lFvhtL4yymE
         8+BFejpg34mBL+nSrNpspuFxCburY+yz6wvRE6VB0bLFcROnEWDd1E5OBMHrRbrDZrF8
         y05nixQlUstkmWn9fR2lzW7staLaTtlFzwTb8avWkObcV8j9SjcubFnsV+ai1q/VSZJd
         rNIQ==
X-Gm-Message-State: APjAAAW+Em/HG+uRPOc6wE1GkbpgLk1Fh2ANxVWhk4itrwqB66pYTdcW
        ivOWpVDx2dGEEA4xFmcpoO7bt7uzfZM=
X-Google-Smtp-Source: APXvYqz6k0m1OCGHUiJ4OnGEKQyzGpm4tnivwPcoBNTuZ+jjYF+s+0PdhAXAhI1A6chPPoWGfmhDAw==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr23715323wmj.25.1566833923520;
        Mon, 26 Aug 2019 08:38:43 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:42 -0700 (PDT)
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
Subject: [PATCH 01/12] ARM: dts: imx7d: cl-som-imx7 imx7d-sbc-imx7: move USB
Date:   Mon, 26 Aug 2019 16:37:49 +0100
Message-Id: <20190826153800.35400-1-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether and which USB port is enabled and how they
are powered is a function of the carrier board, not
of the SoM. Different carrier boards can have different
ports enabled / wired up, and power them differently;
so this should really move into the respective DTS.

Do so and update the USB power supply to reflect
the actual situation on the sbc-imx7 carrier board.

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 24 ------------------------
 arch/arm/boot/dts/imx7d-sbc-imx7.dts    | 13 +++++++++++++
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 62d5e9a4a781..6f7e85cf0c28 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -22,15 +22,6 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
-
-	reg_usb_otg1_vbus: regulator-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
 };
 
 &cpu0 {
@@ -193,13 +184,6 @@
 	status = "okay";
 };
 
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1>;
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -278,11 +262,3 @@
 		>;
 	};
 };
-
-&iomuxc_lpsr {
-	pinctrl_usbotg1: usbotg1grp {
-		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
index f8a868552707..aab646903de3 100644
--- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
@@ -15,6 +15,14 @@
 / {
 	model = "CompuLab SBC-iMX7";
 	compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
+
+	reg_usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &usdhc1 {
@@ -26,6 +34,11 @@
 	status = "okay";
 };
 
+&&usbotg1 {
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-- 
2.23.0.rc1

