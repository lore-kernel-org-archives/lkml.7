Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB16C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0630207FA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iIpMQceQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfKIQUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 11:20:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfKIQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 11:20:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so10206577wrs.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FUTvuHG7RmVULQblIGKFdlRxrJihRtMr5+M5nviapzc=;
        b=iIpMQceQDp83AaTgM0Ijo2lb+sgszk5y/ZtmzGISrJ/5wBosxJJB5rNer3vOVnN/bC
         zaFXVrmVEbZbn38WdZkI7J2m0N6jQzbO8pqj92Ynxo5ocBZBR/iy5jCCGRcA8tB5sm8q
         94kRqjeRhf5m0BGxpmdcRaLD+N7NwxrgaqtxrV+acv0lPjSm11C8WkHPIJbLjm91MDS7
         tQKL2zgjCMPG2ggsbiw6GzvrtYsqxcN8CbkzNPu343f7UGMQW7fpurfXva12j/Ljyr+l
         eM8PeJr0HmKZpGm6+vxhEYVc5sHO3asYefwYnrYWq1+FUeUHJdWfk8q0+x7R+w6LHkMC
         ofDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FUTvuHG7RmVULQblIGKFdlRxrJihRtMr5+M5nviapzc=;
        b=lMccGD1ImZf8SDhghoYykO3CPIjuyqGrdpKYecRc1+Zyr3kC70r1RnGQchy9UEGX8S
         GesmX/dOJHTETrCmp3V0tntxt/Xzbi5D5A2A2sxVbd+nQmhh2zE11g8TfVlpKC2sd6kF
         yx+rKMh9wt/Rzj89La54Daw06Lfd1rmd7QFXKIXfYEzJKDMb7uA4r+82iJ11CSZ3t922
         SqiD75fE37Dp4ze4n2MG3YgDCguN+L3HbRzLGO3/BY3DDsSB12mZObTDJlAN/7NKnviR
         DEHfkXFLxj62tGyZGAK7IThSesej4medVMHaKmx/13mS3LwVXLZdpj/XL1FP11qkNnKe
         ybrA==
X-Gm-Message-State: APjAAAVCArKw3xMvRWd5uaGtYxP0zKE0+mqi6JuyTi8lc4DwWlYcwJ1u
        ybh8SN1pSJr+uJd2O4zJnziQRQ==
X-Google-Smtp-Source: APXvYqx7kZ0kg2+3jDFLqaaAswuDyDwE5cPxU4i/4bbMzb/uVjFv9kYBH76BzgIx2RYKSAGbyw5xKw==
X-Received: by 2002:adf:f489:: with SMTP id l9mr10294183wro.337.1573316446135;
        Sat, 09 Nov 2019 08:20:46 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v8sm14534975wra.79.2019.11.09.08.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Nov 2019 08:20:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 1/2] ARM64: dts: sun50i-h6-pine-h64: state that the DT supports the modelA
Date:   Sat,  9 Nov 2019 16:20:32 +0000
Message-Id: <1573316433-40669-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
References: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sun50i-h6-pine-h64 DT does not specify which model (A or B)
it supports.
When this file was created, only modelA was existing, but now both model
exists and with the time, this DT drifted to support the model B since it is
the most common one.
Furtheremore, some part of the model A does not work with it like ethernet and
HDMI connector (as confirmed by Jernej on IRC).

So it is time to settle the issue, and the easiest way was to state that
this DT is for model B.
Easiest since only a small name changes is required.
Doing the opposite (stating this file is for model A) will add changes (for
ethernet and HDMI) and so, will break too many setup.

But as asked by the maintainer this patch state this file is for model A.
In the process this patch adds the missing compoments to made it work on
model A.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |  4 ++--
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 8a1e38a1d7ab..b8ec616c2538 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -599,9 +599,9 @@ properties:
           - const: pine64,pine64-plus
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineH64
+      - description: Pine64 PineH64 model A
         items:
-          - const: pine64,pine-h64
+          - const: pine64,pine-h64-modelA
           - const: allwinner,sun50i-h6
 
       - description: Pine64 LTS
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 74899ede00fb..1d9afde4d3d7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -10,8 +10,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64";
-	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
+	model = "Pine H64 model A";
+	compatible = "pine64,pine-h64-modelA", "allwinner,sun50i-h6";
 
 	aliases {
 		ethernet0 = &emac;
@@ -22,9 +22,10 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	connector {
+	hdmi_connector: connector {
 		compatible = "hdmi-connector";
 		type = "a";
+		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 
 		port {
 			hdmi_con_in: endpoint {
@@ -52,6 +53,16 @@
 		};
 	};
 
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usb_vbus: vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb-vbus";
@@ -68,7 +79,7 @@
 	pinctrl-0 = <&ext_rgmii_pins>;
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
-	phy-supply = <&reg_aldo2>;
+	phy-supply = <&reg_gmac_3v3>;
 	allwinner,rx-delay-ps = <200>;
 	allwinner,tx-delay-ps = <200>;
 	status = "okay";
-- 
2.23.0

