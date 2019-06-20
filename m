Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708D6C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498AF205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N8+of+nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfFTSVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:21:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35822 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfFTSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:21:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so1726616plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZ2NT1GSY4hpKU63g205EVnDgpZqQ6NY0FJ4sZy9GQw=;
        b=N8+of+nlHpwHnPETt6oXJ7W/ISn1rEby0yhxwKLPl3dnUC8wZeby8eohp1yM1lyhiI
         x1r64JlKADc6skDXTaWeczVmFQOP637oOFQPTxG4i4mTwasaHuHWN3LjIw9Bblp/K7gK
         lx2iUnn6VmSWj/jQNH3bgFhRFTt+Qhzhdh6XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZ2NT1GSY4hpKU63g205EVnDgpZqQ6NY0FJ4sZy9GQw=;
        b=dD2aluEC81o8HEGALZ19LfDQ+GcYAMC5pr8CqPyjA8Aj803+cyUw3wc9UW0j1JojQc
         /fVBAG3UxQp34glOBk4AC7/4ih07b4IjVwgvnc9NfR8OlvYS0tvWQh+bqXWdEwnD5BPs
         dk4k5DkhpK0TRq8z2mNZfwoZKeOrMUdQ2MRJdYABWEZAX/LxtrLwDHDkvgn4PZfJzKGL
         NcjN9R1OSsamt/xA+f7qrCGhkXl3Av0FLcVhLablNpiZMin/pSzhLFneGlVfDtJEOHig
         LkUsceCg4SnRdSB0KLTqYD6PcDpxax6+b/fqDJ0/Y4HEucSoKc2AUAJucdP2L/H4Z2yV
         hygQ==
X-Gm-Message-State: APjAAAU0FijGhp8goLhK2SXzsClyNd0Y/DF6epR01PWTb67peAVj7A+6
        Kvv57wh30SDAXvGId8uPrSJCpg==
X-Google-Smtp-Source: APXvYqzhWDEoiLHEFAdu8IpSss+cbmdlR5vKAYaFqg89xARSeVwy0J/o2mSyNDJeF6hfVFRzRyob/w==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12mr10696711plt.87.1561054877425;
        Thu, 20 Jun 2019 11:21:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 188sm178081pfe.30.2019.06.20.11.21.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 11:21:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     heiko@sntech.de
Cc:     enric.balletbo@collabora.com, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Revert "ARM: dts: rockchip: add startup delay to rk3288-veyron panel-regulators"
Date:   Thu, 20 Jun 2019 11:20:56 -0700
Message-Id: <20190620182056.61552-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1f45e8c6d0161f044d679f242fe7514e2625af4a.

This 100 ms mystery delay is not on downstream kernels and no longer
seems needed on upstream kernels either [1].  Presumably something in the
meantime has made things better.  A few possibilities for patches that
have landed in the meantime that could have made this better are
commit 3157694d8c7f ("pwm-backlight: Add support for PWM delays
proprieties."), commit 5fb5caee92ba ("pwm-backlight: Enable/disable
the PWM before/after LCD enable toggle."), and commit 6d5922dd0d60
("ARM: dts: rockchip: set PWM delay backlight settings for Veyron")

Let's revert and get our 100 ms back.

[1] https://lkml.kernel.org/r/2226970.BAPq4liE1j@diego

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 1 -
 arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 1 -
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 -
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index fcd119168cb6..5411ce148890 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -24,7 +24,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
-		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index 164561f04c1d..82ac9d23480e 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -26,7 +26,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
-		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index b2cc70a08554..f29501d8ff07 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -33,7 +33,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
-		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index 9b140db04456..a0f6fefc95f1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -24,7 +24,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
-		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
-- 
2.22.0.410.gd8fdbe21b5-goog

