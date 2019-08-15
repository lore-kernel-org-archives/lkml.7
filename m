Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13385C32759
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5B92064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um9fSX9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfHOINT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:13:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44205 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfHOINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:13:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so980661pfc.11;
        Thu, 15 Aug 2019 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wLap0Zy+ci+CJDpmUhxVRnZnzzmq1nqEQXj4qyza1yk=;
        b=Um9fSX9fZr03aGVR9n/2L2BbbywQnKhRAh4QrS5sagL2hVLXlD30pHM3LuzL1BoIn5
         YCrlu6fk5e5H6Lheqo7PNWlDFf6NLgVhZdsYutua0Ut3l68Z79njZbJFc2JHVVZYWGBy
         /t6FZeHHUFhkK6e4+44v6dEliHtgZoLYzWfsa1bmGMaO42B62KyF5R5+eYRQpGPJyjJJ
         jRSkPUvCfTYGWCkW/P1N/xf4Nq+cHCVXScD+coc2PtThtU+itgJWTF/Yf1AhDDzyF4j5
         tdaLxbEzEeohf1Fx+5bxzYU0kl/WD0nk04iUR3HxlzL0b6SDcpY0IFuCcJ2ddLqvD5l3
         cOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wLap0Zy+ci+CJDpmUhxVRnZnzzmq1nqEQXj4qyza1yk=;
        b=cTUGO/qCdkDFFa++l1k7On/VWi9KGpGmBTWFn4Ql9aiPSZxWSYCQw4RTVzdO8fVehY
         PHzIu+s+83hWVkTX7DwO55YKjfYADpkko4/vAlDFK8k+Uvvk8Gz0Q7ISHMDrFb25h0Xc
         /+z13lRMUAUPIo+nseuJvyoyqXwbNY+j5AEN+lsKW7njPtucsCT9A1WL3ZRLuFweCG2Z
         Zw9BVk2q+org+bSefFohEvYWi0uiEyWKnZDeKwrLN/hcyuqi87akbHdiHpQ5p8ma95d1
         TTonfoOGML3zPZsvjlgh7B2tvQ1ObwvuVTKz1PJNF9yVaqyA3x4urqW8IRepXYQ8CwCh
         KK6w==
X-Gm-Message-State: APjAAAVk6aIQDA0jdh/T6wjWwGBtAqdNvYRCZokdjtd+Aerz0EEhYe/K
        YomUa1ci2Yw45UsQor56xKQ=
X-Google-Smtp-Source: APXvYqxhSkqTwo55kHvwOxePBRXqzxO0xgOzn16baZ6D28WYL4ASlLZ/C50ueZXOn/sduDjLE5annQ==
X-Received: by 2002:a17:90a:35e3:: with SMTP id r90mr1195041pjb.34.1565856798082;
        Thu, 15 Aug 2019 01:13:18 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id h17sm2084786pfo.24.2019.08.15.01.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 01:13:17 -0700 (PDT)
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
Subject: [PATCH v2] arm: dts: rockchip: fix vcc_host_5v regulator for usb3 host
Date:   Thu, 15 Aug 2019 16:12:52 +0800
Message-Id: <20190815081252.27405-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to rock64 schemetic V2 and V3, the VCC_HOST_5V output is
controlled by USB_20_HOST_DRV, which is the same as VCC_HOST1_5V.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- remove enable-active-high property

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 7cfd5ca6cc85..62936b432f9a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -34,10 +34,9 @@
 
 	vcc_host_5v: vcc-host-5v-regulator {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&usb30_host_drv>;
+		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host_5v";
 		regulator-always-on;
 		regulator-boot-on;
@@ -320,12 +319,6 @@
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

