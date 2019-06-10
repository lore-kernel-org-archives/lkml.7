Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A40C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F29D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTu/idBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390780AbfFJXvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:51:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37914 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390568AbfFJXvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:51:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so5852108pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqMs2GH/xtfTYsmih0pOOnY0fKcqNqNR+gJpdBUA/eM=;
        b=oTu/idBfwM1cB4tIJjf+zl14e9kVwF5wKkGI8f0gWvPvtxvoBBHvRGa73qrU+yzSHq
         KPNSfe+fwoY0dUPsoQQ3MDKwGQ+3l/w99DFGQKnWvDxraTmV8fFUjFINoYjoaLZ46Owp
         S53g33290impJ+/PSJ8HoyI5Qe/jQyR9QAr+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqMs2GH/xtfTYsmih0pOOnY0fKcqNqNR+gJpdBUA/eM=;
        b=rob3nKEtjlN/6N+XPuj0RiJ/YWTfH3Kynt5kHL4C3wQWrevPx8dYB+G7eY2Z2S4hue
         3nEHwvRSr8oO8H6dz3zs/Mqm5FuomzddutXULycHCooQQ85y/LoNgxOZgv9thLr+KX5x
         4Ok0yZ3aYjGjxdFXPxaPKRcUyudOxoHc/qmRD6iNh3osjefRJY7DvwcqnxU5cFkhUfNy
         Nhizxewyip1od+FsmwQMbZfBhxs0qSfrZZfZ/m0e6EsCInExBQy7LCmYOSr9AHfSi5We
         UQQeVAF0QERJ0k2GKPIfmbcIpsXDU/HcIdUBqqUQBn7cklAQ8J/jZU6lctrK4ft40kxj
         tlbg==
X-Gm-Message-State: APjAAAVvLRNlcwziVS4TAXOO3BZiYWlNu6Z7nnc38Htl1ppGC5uYOSP/
        6OCddDFpcHZsTlf/9D3AFnPSpQ==
X-Google-Smtp-Source: APXvYqzD2cF4pnRnha2FFCgMkbGrdDrfEXK5tQFC7u4b2ZqJZuPKjGHTPolqdv2vdZK1NcfWeh5WLA==
X-Received: by 2002:a17:90a:d983:: with SMTP id d3mr23473225pjv.88.1560210709380;
        Mon, 10 Jun 2019 16:51:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y5sm11427325pgv.12.2019.06.10.16.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:51:48 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on veyron
Date:   Mon, 10 Jun 2019 16:51:44 -0700
Message-Id: <20190610235144.34261-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Anderson <dianders@chromium.org>

This enables wake up on Bluetooth activity when the device is
suspended. The BT_HOST_WAKE signal is only connected on devices
with BT module that are connected through UART.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- attributed authorship to Doug
- use constant instead of literal for pin number
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 3257ca90f0e8..e2635ad574e7 100644
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
@@ -549,6 +574,10 @@
 			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		bt_host_wake: bt-host-wake {
+			rockchip,pins = <4 RK_PD7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		/*
 		 * We run sdio0 at max speed; bump up drive strength.
 		 * We also have external pulls, so disable the internal ones.
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

