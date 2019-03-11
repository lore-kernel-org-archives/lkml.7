Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD792075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aYCKIJPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfCKPDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:03:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46897 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCKPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:03:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so1786509pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ysitMl37W5wvDTaO55M/bquP5eX6f+fWiuhxScsiSvI=;
        b=aYCKIJPbDtW9gx9YYp4eNdKogfeqwQGkAF+HXkZUilq/ur0wRb9mGjt5qMyAeYOuI3
         f6rFiPJPWuMzfl5Ew6k5sgsCVn+NzmK//CJSnMLny2rxGRbU3mphM4onrDwvbbfUyw+t
         lF4eW4i4Dh3DrmV1tUt9OHspuYz9ByhCgOzvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ysitMl37W5wvDTaO55M/bquP5eX6f+fWiuhxScsiSvI=;
        b=RIJZz5qwy+90fU6HS/JrzaoowQ1Apj0841yRRMAXyz9i/zobtWVgllSre7Aj1arFEg
         tL2UiDYHqe+AS9ACHoDxpGZK0s4bkA7/KQSRHIFy5hcEpPHGmQXCip2wdXnDxnUfi7uD
         SpG8CJBz8tEXxiQNWI1T9X2mlUZ1F7Dbv138ZXA/WOxGunmCs92nKiOqKtCFVzGXmLLC
         BxuPUKej4V0QQSpACh/DEPBjScMLPeeXZj3/6lmzDaVmtUoQxwKbza+z6Ke/PQD5Gir+
         7zpQycHxSpg9t+MFt5963VdBxu0SCgyk4z4Re1tWu3w/0ZucP7ZDfyuLVgWtV4el9qhn
         /Myg==
X-Gm-Message-State: APjAAAUVWXE7TDX9VsroiHi3c3XqHrQ53MvUHVblsK7pMXFoJGGBG6Nm
        /xnCwEN6tixLRfqGzCPG/tqAUQ==
X-Google-Smtp-Source: APXvYqxMKPWhmDkwbjkdOybHYp9nV7KRRh/NXpzDkZzZQ/QbrK9DlEkC1IbXWY1n+h0coxmTqbz6Xg==
X-Received: by 2002:a63:561f:: with SMTP id k31mr2962862pgb.319.1552316628400;
        Mon, 11 Mar 2019 08:03:48 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id x5sm7594531pgp.68.2019.03.11.08.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 08:03:47 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Akash Gajjar <akash@openedev.com>
Subject: [PATCH 1/3] arm64: dts: rockchip: rk3399: rock960: Rename vcc_sys into vcc5v0_sys
Date:   Mon, 11 Mar 2019 20:33:30 +0530
Message-Id: <20190311150332.19492-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is always better practice to follow regulator naming conventions
as per the schematics for future references.

So, rename vcc_sys into vcc5v0_sys as per rk3399 power diagram of
rock960 schematics.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 2927db4dda9d..a268ec9f6b5e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -26,9 +26,9 @@
 		regulator-always-on;
 	};
 
-	vcc_sys: vcc-sys {
+	vcc5v0_sys: vcc5v0-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
+		regulator-name = "vcc5v0_sys";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
@@ -40,7 +40,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
@@ -64,7 +64,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 };
 
@@ -123,7 +123,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 		status = "okay";
 
 		regulator-state-mem {
@@ -141,7 +141,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 		regulator-state-mem {
 			regulator-off-in-suspend;
 		};
@@ -159,16 +159,16 @@
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
 
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
 		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc_sys>;
-		vcc10-supply = <&vcc_sys>;
-		vcc11-supply = <&vcc_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc5v0_sys>;
 		vcc12-supply = <&vcc3v3_sys>;
 		vddio-supply = <&vcc_1v8>;
 
-- 
2.18.0.321.gffc6fa0e3

