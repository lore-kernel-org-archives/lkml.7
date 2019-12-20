Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0906AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48852067C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYTTQMKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTMz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:55:29 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52999 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:55:29 -0500
Received: by mail-wm1-f46.google.com with SMTP id p9so8845033wmc.2;
        Fri, 20 Dec 2019 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=47U1otsxYlinLNAscqJD75X6EAli96RR6XYpuDRuenk=;
        b=BYTTQMKllgycraKHarnwqJf8SP4/xmLzv9sqBRHH5Jlky2jdi7TsjV0FpyLasstZXX
         Gnz3BQ23iT6rF2wjm8aR/p2cANBU5xasgeSZacD8RBsWIOq+FzDUv4aX3n0gqaDQZSum
         0bv0gkqK2DxGD83GZfUu3FCfcCg4GCvwM7HfxIMewlav5ZsxG80YBOic1rrgmF6LbfdP
         2/JEsjMRO+HLj3QEzUSrSWYCnOFYmB9rnwpUQ26KXVdU+1otPKfeJEF8+av//+18iQfd
         FU6qDpqC/QcHo+mezj/JB4lnKNSZNeRmWCsmSt+2mhAYAsCOmN/QVffUnH/Di1JHXZSE
         UxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=47U1otsxYlinLNAscqJD75X6EAli96RR6XYpuDRuenk=;
        b=MPLy/JTcMUbfTy/m9JqXoaUHHt+e83aIz03ymQl7bOrXt5LhmSHTdbzDYe6iPajiRo
         4kUsL+ssjNlSr+VxIllI76bdMfts8Eaw+HjqrnulvAt/fFM2RO42tMY67tZHIrsG9OKW
         ZUNbUqP7eFZKZR78AXYvKFhcW8tYOOVjh8O+VbNeOn79LLQQGDc+15vZnDeU2mXwMO9j
         zkJ9QPGV3o9vAkKdTK8PHK3T9p4e8xaP1EJ5vOtNVJboBG5LQ8ajo0TismImFGfiC0DI
         NyzgfdNEM+mf0qGJpyVehEGfZWhOTb6AxurxwBIx180IdQbm8W5NaqunKWjpL3j1aq5w
         8kKg==
X-Gm-Message-State: APjAAAUuz0+aiBV7w7tsgUiAlxhv0lFMINKgPeWpgvQOTwPrOG1jxVUc
        DFEwxY4My7jTg2aaz64Et6RR2BE7
X-Google-Smtp-Source: APXvYqyag6PPQfT7+x6ofkH7w6P6paES7VP6Wm61XxrDabaVQVUo7j2A4lOVwoTmjNVhlw0slPBRIg==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr16446761wmj.130.1576846526989;
        Fri, 20 Dec 2019 04:55:26 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k16sm10148078wru.0.2019.12.20.04.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 04:55:26 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3368-lion-haikou: remove identical &uart0 node
Date:   Fri, 20 Dec 2019 13:55:20 +0100
Message-Id: <20191220125520.29871-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove identical &uart0 node.
Sort nodes in alphabetical order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts | 76 ++++++++++------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index 8251f3c0d..93601fe05 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -64,47 +64,6 @@
 	};
 };
 
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	cd-gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	max-frequency = <25000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
-	rockchip,default-sample-phase = <90>;
-	vmmc-supply = <&vcc3v3_baseboard>;
-	status = "okay";
-};
-
-&spi2 {
-	cs-gpios = <0>, <&gpio2 RK_PC3 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	status = "okay";
-};
-
-&uart1 {
-	/* alternate function of GPIO5/6 */
-	status = "disabled";
-};
-
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&haikou_pin_hog>;
@@ -144,3 +103,38 @@
 		};
 	};
 };
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <25000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
+	rockchip,default-sample-phase = <90>;
+	vmmc-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&spi2 {
+	cs-gpios = <0>, <&gpio2 RK_PC3 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	status = "okay";
+};
+
+&uart1 {
+	/* alternate function of GPIO5/6 */
+	status = "disabled";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
-- 
2.11.0

