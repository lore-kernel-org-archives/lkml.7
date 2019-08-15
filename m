Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CAC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1962084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPyImWLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfHOC7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:59:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46862 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHOC7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:59:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so514768plz.13;
        Wed, 14 Aug 2019 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=jtcbQSdvzy5cT1Z921sK+U6eJuTaITvB/5Row+mcI0c=;
        b=VPyImWLVUBR+YJhKD3akvkpU0i5ENU919XA+N261pXNLUFFifIFgh984CAi1BGK4vs
         lsmnqso8RLiJ5hSxAWHUja3jeCIOxoGHPfWnJrn/ovMXJpj1WRuNX3c75AJSx0/FKszp
         hJAAFWhE0XnpJm7uZ9mmm2LOPKDYV/PtMHUuZa6siu7IYpg/BQ8eGkZAbHfGeNJXuSpJ
         qZeRdMNSciFbNM8VytVYUqIkSC0J+/9HhlcbAEmm69zb06ksFXU42GNGPno9eAHvtbYJ
         ImoEBwmnFdXq0/QO62cuWxg+JxAHIe9UZFsxbrod04OUUk9CQAXBMJN8OsJE7pXhtlp8
         G/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=jtcbQSdvzy5cT1Z921sK+U6eJuTaITvB/5Row+mcI0c=;
        b=ii6svZe9OAQ1mb0C1TYhIpCM/F2AfWjPtn81myySO0d41jkMh0Yam2eSJCjU2b2huL
         MBcyi3jLXBeWYx4uOVCpsBmBWW7ku1IK7WAP50/udFzVENF1CuUvFBMNmeiU3cxi4u/o
         pneanLxXxaZ6/qVJZpn3xkNamSdftHYBb6LLYSqViVOyw1Snccf0OIbf2ehhjdxFsZrc
         2+lmOK+xQ86IxaCgqKDhfgOc+TLt8y5Egpx99ZPcG+75zGqC+56eZe8MgYFZA1SW5P5c
         NmTYY6Y7UpNkckm1xLwVvZRDgamFNR7n6ogVg/q56vGwkXOApXiSyAeqIv9lzel9uYGN
         T7lQ==
X-Gm-Message-State: APjAAAWlzJ7qVCt027O19bypMSb54+CWp7KfVxV5kPloh9i2aC7y78vn
        cYNEL5TAO4aRDt0BKCZMvHs=
X-Google-Smtp-Source: APXvYqwQlvrnAQc0lPUHt/zfuAZ+tW3qd3Tcao4Wz1WqTtmVKnHjXDaxSx8tYi4gb6lsRg/sGGftXQ==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr2413435ply.261.1565837982100;
        Wed, 14 Aug 2019 19:59:42 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id k5sm954439pgo.45.2019.08.14.19.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 19:59:41 -0700 (PDT)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>, Jonas Karlman <jonas@kwiboo.se>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomohiro Mayama <parly-gh@iris.mystia.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: rockchip: fix vcc_host_5v regulator for usb3 host
Date:   Thu, 15 Aug 2019 10:59:19 +0800
Message-Id: <20190815025919.5194-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to rock64 schemetic V2 and V3, the VCC_HOST_5V output is
controlled by USB_20_HOST_DRV, which is the same as VCC_HOST1_5V.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 7cfd5ca6cc85..bd4ad1635e0b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -35,9 +35,9 @@
 	vcc_host_5v: vcc-host-5v-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&usb30_host_drv>;
+		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host_5v";
 		regulator-always-on;
 		regulator-boot-on;
@@ -320,12 +320,6 @@
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-
-	usb3 {
-		usb30_host_drv: usb30-host-drv {
-			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
 };
 
 &sdmmc {
-- 
2.17.1

