Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE20EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB3A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N25Gji3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfCYQUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:20:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41989 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCYQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:20:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so6666166pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSR/BJWg/GVA0u+GWLzSUPGYC9skUYYpoMZYhOu6/oc=;
        b=N25Gji3PX/XwSmld2CZjvweB/dcsuNKfA/8ms5a6bsh+fXclgRvybEgQ7JPl9nUJnK
         U8Ns7s09/F5Q1r8igHNZ3Ql2ThqVn/pXIsV9kcd/6WdY8CmZ801/Hr7UA2Jp1k6RUTWp
         ZJFi5TXViB4pT7ft5WMlpuDAF6J2AK+I4zRU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSR/BJWg/GVA0u+GWLzSUPGYC9skUYYpoMZYhOu6/oc=;
        b=dwImGUuc0DXrFpgRi/o4+eAHtnMnQLZYS6V+n/JnAlXtr4JpXrMYgw0JUFHmXx0TSu
         BC+5dhbun+6JsuqVx9e2n1qYqYBg8z/yG2w0UeM9+hy/nXVmDYdazHVN96nryA0iglJv
         0vuVP/QpO3/0d/PejhVELqvjvNoocVgmI70uVdihPl/+WWaM3l1FJhajzgCb6aUPa+WF
         LGrcKauQ9Vv/W72xljN4OpBF+0nTDB1hI0a8z2W33GuO1oBiG2R+HZRfxi/vMhkHCA4i
         rjL8/aO6aU8IoVWzi2hY8oGx82iUeGkr1GiZ2R6e0fQAc6Z8xzyHB7RJQiItMZbSdlCw
         Jv6g==
X-Gm-Message-State: APjAAAVBh3pT45L3wfXdfCP+SprwUOeet7RCylY56eTKHhYODnI8CwbA
        GnyAZQ/8DEkNJJuUwSiRTl5KmA==
X-Google-Smtp-Source: APXvYqxbIvFdYlStTXS4UWl4r2Ys0A0AkTMbMG1ALe5MXedLmKoM1Ld7O2ONFYZzyaHCycvQ7krYOg==
X-Received: by 2002:aa7:8615:: with SMTP id p21mr1778635pfn.98.1553530835263;
        Mon, 25 Mar 2019 09:20:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm25879790pfh.168.2019.03.25.09.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:20:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Add device tree for rk3288-veyron-mighty
Date:   Mon, 25 Mar 2019 09:20:05 -0700
Message-Id: <20190325162005.99391-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325162005.99391-1-dianders@chromium.org>
References: <20190325162005.99391-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mighty is basically the same Chromebook as Jaq but it has a full-sized
SD slot and some different (slightly more rugged) plastics around it.
Like Jaq, Mighty may show up with various different brandings but all
of them have the same board inside.

In the downstream kernel Mighty and Jaq share a "dtsi" and Mighty just
adds the SD write protect (needed for a full-sized SD slot).  We'll do
this upstream by just including the Jaq dts and make the changes.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Directly include the jaq dts and just specify diffs.

 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/rk3288-veyron-mighty.dts | 34 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-mighty.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aeaf3298..48282ebfb3da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -909,6 +909,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-veyron-jaq.dtb \
 	rk3288-veyron-jerry.dtb \
 	rk3288-veyron-mickey.dtb \
+	rk3288-veyron-mighty.dtb \
 	rk3288-veyron-minnie.dtb \
 	rk3288-veyron-pinky.dtb \
 	rk3288-veyron-speedy.dtb \
diff --git a/arch/arm/boot/dts/rk3288-veyron-mighty.dts b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
new file mode 100644
index 000000000000..f640857cbdae
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Veyron Mighty Rev 1+ board device tree source
+ *
+ * Copyright 2015 Google, Inc
+ */
+
+/dts-v1/;
+
+#include "rk3288-veyron-jaq.dts"
+
+/ {
+	model = "Google Mighty";
+	compatible = "google,veyron-mighty-rev5", "google,veyron-mighty-rev4",
+		     "google,veyron-mighty-rev3", "google,veyron-mighty-rev2",
+		     "google,veyron-mighty-rev1", "google,veyron-mighty",
+		     "google,veyron", "rockchip,rk3288";
+};
+
+&sdmmc {
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+			&sdmmc_wp_gpio &sdmmc_bus4>;
+	wp-gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+
+	/delete-property/ disable-wp;
+};
+
+&pinctrl {
+	sdmmc {
+		sdmmc_wp_gpio: sdmmc-wp-gpio {
+			rockchip,pins = <7 10 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
-- 
2.21.0.392.gf8f6787159e-goog

