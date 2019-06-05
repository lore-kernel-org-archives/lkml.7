Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D24C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DEF20872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZx3rwDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFEUnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:43:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34094 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfFEUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:43:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so1615pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPhO1CL2QNYrFXmyPQgCjLUUu5vqgdBLRQDp0Dy3EaY=;
        b=HZx3rwDyN9lohAC8Lsx842/QIB9gDl7Ro/yIKCYQijq1qgWib8gDItv6Wj+OGyLA0m
         9QhbFR5pub9Ua7SBMWhc3ZUx/brP5Cbd2oJPlaYSYUKBIPpmH4DKVR+hDZytDQBZ6WID
         GrVRhIkAm+cLW6T6WoTWQpI4RHpWS1SQR9efE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPhO1CL2QNYrFXmyPQgCjLUUu5vqgdBLRQDp0Dy3EaY=;
        b=ecSoqEg5SFB+DDAR/D1hEX0vECqEXTHcRE+BMypHtKu9TtPv96gjQQCIkRJmsfNhMv
         l2heuH8cjqPwRT/bzCbtzQmj8UcVggf5SRn/TF9iwykE0Egkmu5uPHPXNCFQdIMfyFPr
         yDIWzz4W3Fh4VUtY1oEcI8Zgfw6zhOwZxACH32AeqFf8Z06aqCjp8rPpK6gInRwwyrlP
         qGSTSS2oV5kyG5j8Q52rop3ZdyK/s8kbNL96T7i6aq3PrDN1mjaZbrNBw+sk2Q1A5Ujh
         1/e9AiSnzrhaAl1SdhIRPMeA0PYGdPADEJxd9eg5GGvDIw1IjAZYmbR+AdQRMdsirJpg
         N1/A==
X-Gm-Message-State: APjAAAXhMP4GmgEwmJfAKSCpVgwU5Xv5JKkKQbop514S0xx1+gv95zd9
        eT7Gh0HEl9/ddbyXeOb6rh+ycg==
X-Google-Smtp-Source: APXvYqw8OaJ5XCmYYrFY2R93/vr1AH/RUNaTy1eqaGrtdWbTg0hiNdeTvlLiBUKg5HpkZp5KSXYsVg==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr47670119pjj.44.1559767411253;
        Wed, 05 Jun 2019 13:43:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i5sm16360733pfk.49.2019.06.05.13.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:43:30 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on veyron
Date:   Wed,  5 Jun 2019 13:43:20 -0700
Message-Id: <20190605204320.22343-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190605204320.22343-1-mka@chromium.org>
References: <20190605204320.22343-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables wake up on Bluetooth activity when the device is
suspended. The BT_HOST_WAKE signal is only connected on devices
with BT module that are connected through UART.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index cc4c3595f145..145cac7c0847 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -23,6 +23,31 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	bt_activity: bt-activity {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake>;
+
+		/*
+		 * HACK: until we have an LPM driver, we'll use an
+		 * ugly GPIO key to allow Bluetooth to wake from S3.
+		 * This is expected to only be used by BT modules that
+		 * use UART for comms.  For BT modules that talk over
+		 * SDIO we should use a wakeup mechanism related to SDIO.
+		 *
+		 * Use KEY_RESERVED here since that will work as a wakeup but
+		 * doesn't get reported to higher levels (so doesn't confuse
+		 * Chrome).
+		 */
+		bt-wake {
+			label = "BT Wakeup";
+			gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_RESERVED>;
+			wakeup-source;
+		};
+
+	};
+
 	power_button: power-button {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -555,6 +580,10 @@
 			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		bt_host_wake: bt-host-wake {
+			rockchip,pins = <4 31 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		/*
 		 * We run sdio0 at max speed; bump up drive strength.
 		 * We also have external pulls, so disable the internal ones.
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

