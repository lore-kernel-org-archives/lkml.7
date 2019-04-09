Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA0A2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mcu+dEi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDIXON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:14:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39786 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDIXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:14:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so289692pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DN/IL7SKReF6bM5dBuLM75iU7gDu5ilsrW7u40dJ73k=;
        b=Mcu+dEi5K/5OewwUdmSbE2gfVEiiUalhfdEBxE1oOJuBfBI1S5v9uF5F+VhUEFvbSo
         4Owcq20tohmosvBPeU/xxpnt/pB4LTPMFKa/ehScX2eO5w9F+jm56oRrUYz9njt7Ceh5
         9aWlXubTplCGofzOeqTPYWv1zXDHMILhhruIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DN/IL7SKReF6bM5dBuLM75iU7gDu5ilsrW7u40dJ73k=;
        b=lRLn/PUrPSUNRFhQGSGW9tEy6c5StTHAlIfB9l7RBAuglH1UARosUc8uyAJW0B3kwo
         LfqPSy6YLqRXxbAK0ruPCcXh574z0iGCcTii/rtHFd7ivMsKMHlxebY7Zq+NvflixFqC
         gCgGoaKyPzElcW75ld3gNarkM7fkPG9WI4epCBekGvnAboaXhZ3b29r1Wwxh5+bYD0FO
         y4BortnaFl83ydgfeDSRMgxMOVRtmNw3wRbtEA3NJQBvyZpROrA1t07rEIWkQpJAZmkr
         ytsNL3dDlL+eD673VeqGczX7bxbzEO+5dnhANPjV3UA28CYW4bj7DYOLITQ0crt1p3gN
         G6iQ==
X-Gm-Message-State: APjAAAXTjfcKp8Q09vDhItaNfT0oEU/W2QCgj/JIAvySDPp3vXE4cyis
        bCSHBpdiXSfyAEd4EX0nsvXZ9Q==
X-Google-Smtp-Source: APXvYqy1jXAsoR/7nOJIQ5N6/rUHZc8uFoiffvYDGQdD1UyP0lEka0IsbVSEnTC8h68QHTvLRTHu6w==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr36674783pgc.78.1554851652419;
        Tue, 09 Apr 2019 16:14:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i68sm8748680pfj.96.2019.04.09.16.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 16:14:11 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: rockchip: Add BT_EN to the power sequence for veyron
Date:   Tue,  9 Apr 2019 16:14:05 -0700
Message-Id: <20190409231405.189335-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO D5 (BT_ENABLE_L) as reset-GPIO to the power sequence for the
Bluetooth/WiFi module. On devices with a Broadcom module the signal
needs to be asserted to use Bluetooth.

Note that BT_ENABLE_L is a misnomer in the schematics, the signal
actually is active-high.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 0bc2409f6903..a4cd851dc313 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -62,12 +62,19 @@
 		pinctrl-0 = <&bt_enable_l>, <&wifi_enable_h>;
 
 		/*
-		 * On the module itself this is one of these (depending
-		 * on the actual card populated):
+		 * Depending on the actual card populated GPIO4 D4 and D5
+		 * correspond to one of these signals on the module:
+		 *
+		 * D4:
 		 * - SDIO_RESET_L_WL_REG_ON
 		 * - PDN (power down when low)
+		 *
+		 * D5:
+		 * - BT_I2S_WS_BT_RFDISABLE_L
+		 * - No connect
 		 */
-		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>,
+			      <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;
 	};
 
 	vcc_5v: vcc-5v {
-- 
2.21.0.392.gf8f6787159e-goog

