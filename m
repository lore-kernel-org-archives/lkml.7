Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A699CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202DC21906
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NztH2lX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfJUQRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:17:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51994 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfJUQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:17:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so6833653wme.1;
        Mon, 21 Oct 2019 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lkDRxLx0e64Dw8F83EKAXaoP6GxpGN0qeMyvz3hwbCs=;
        b=NztH2lX/cIvVrXrCMiwfb5TW5vyGJtlgX/seuc3mVoXS+8ENIlD59Yhxxj/C7aH6nc
         D+l9KX/juO+goIqOHhPocDMBmP6S0JVCbSCWIABAUsLNlkQHw9ii0yFiJpKtKYPm8u/7
         VxSzHvKgHCei4sK4xixE4Ndh1b0yD4nfRgCS8xy9+a+zl9ZOM8DxmvVAixwpQaGhu8At
         uDqErRV911Yk4Q/tSfAeni6XtjJqhO18KQmOGl0FtMgK2lbDw4VYvWd0DXBCaV9O7wys
         qix7a+/+Gebgaqzv7lN9vZdHUw283LBYjW73y1J3olsct47xK4dec46+b/7LDAWCmZ0S
         22+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lkDRxLx0e64Dw8F83EKAXaoP6GxpGN0qeMyvz3hwbCs=;
        b=YNkqXxwijHdWzs+SrmaU8zukmYcgJr8L8a17hQ1QF5oMoyPf12+CsMWOqaGlizl/nV
         +oyoLLakcfFNPh54gRXDLUEpni4yEsC5qUSCHtc85RfHNWiv0fTC8JPUVZOrE1uR0ron
         Pf24/rhA/xExRkA1TowDs4YcMROsGpV523whTGgO+LBrkD8pMnEYL+W9VH3ukteDlhbN
         zpTr1aevF4aGBhcYKeJiSNQiyshNt26VRSk3zZ4+tlHs+qM3AP6YQKdy2qBgsezQ7TwR
         +SMwEOqYxxM/KqkQFHZoQIUEHOyRf7fMhYujAF84713RyWlfk2Zx8DEDQcr5O0TWeJUy
         Z0+A==
X-Gm-Message-State: APjAAAW/HY5iJYtAKsNuvmRSDenJYLg6sIZ+VJEh9If+Zy1zhgivLdJP
        UyTZv7gfMFGx7vDL/K1RMgop498p0vI=
X-Google-Smtp-Source: APXvYqz2VNVLwqP8eX2RHxP4bsTLipg6R6lxPysdf+/BDn6HVwxksnvhAJe3roQx/CZZZfh0pceirg==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr6595987wmi.174.1571674634775;
        Mon, 21 Oct 2019 09:17:14 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id 79sm23848976wmb.7.2019.10.21.09.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 09:17:14 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: colibri-imx6ull: add extcon for usbotg1
Date:   Mon, 21 Oct 2019 19:16:54 +0300
Message-Id: <20191021161654.14353-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161654.14353-1-igor.opaniuk@gmail.com>
References: <20191021161654.14353-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Add extcon usb gpio configuration for support dual roles for usbotg1.

USB host/gadget switching test (1. USB NIC emulation; 2. USB storage):

[   52.491957] ci_hdrc ci_hdrc.1: switching to gadget role
[   52.502911] mxs_phy 20c9000.usbphy: vbus is not valid
[   56.749160] using random self ethernet address
[   56.758637] using random host ethernet address
[   65.768968] usb0: HOST MAC 00:14:2d:ff:ff:fe
[   65.887980] usb0: MAC 00:14:2d:ff:ff:ff
[   66.294961] configfs-gadget gadget: high-speed config #1: c
[   78.741971] ci_hdrc ci_hdrc.1: switching to host role
[   78.747522] ci_hdrc ci_hdrc.1: EHCI Host Controller
[   78.790174] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus
number 2
[   78.868498] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index a78849fd2afa..988f1a800d5a 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -29,6 +29,14 @@
 		clock-frequency = <16000000>;
 	};
 
+	extcon_usbc_det: usbc_det {
+		compatible = "linux,extcon-usb-gpio";
+		debounce = <25>;
+		id-gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
+	};
+
 	panel: panel {
 		compatible = "edt,et057090dhu";
 		backlight = <&bl>;
@@ -150,6 +158,7 @@
 };
 
 &usbotg1 {
+	extcon = <&extcon_usbc_det &extcon_usbc_det>;
 	status = "okay";
 };
 
-- 
2.17.1

