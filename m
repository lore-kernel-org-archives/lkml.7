Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF2E2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hL8n26ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbfDRM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38310 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388933AbfDRM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so2687382wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/KHPhCyo/i9fFtJl8kxXo82v7RLLCe/0uJM5mRwBhY=;
        b=hL8n26ae1xCfJvBWjrzOctGEIPekWegTBkl5uOX35rLmcoHt1irSDvQJkvrCLQ8j40
         65YEGT/N2xcFHZf6iuAZihJKg4XDIKgj0cQfl+bKmVkQ9ompUjvd9Q7sCYD9UQtGklt/
         iDayy7lw42GxBdGDCo+tN03cNG/3fLbkH7hMU7+BMZ709j4DPcByDQ1Zw6Wx2COgtsnm
         o9F2VkCBt6dhZ+ztzyF0UAI2Hg4VWvpEWSlv7pQPUK8f+qle2vAxkQwSkHv2y2pGvVXn
         oD9RljWkxlbztXh6c0o2Pn8kKAoOw+xpS5lWZu00Sb9HCu5ingwR7u/EKCk2qV8MwDF4
         BT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/KHPhCyo/i9fFtJl8kxXo82v7RLLCe/0uJM5mRwBhY=;
        b=tZVLbG95lb5ciSuNgARlq/tMP/f9H368U1G1O6ff/m2AaI39h9TjMxSPfKf9SNQJlQ
         TmGmFZw5zoot31Dpjjpuihk6QRJcYovXXbVVwqx+tgoCEagDcWlKQ9wvS70RSFX0/1W7
         ZQIaXuJpLLMzB8HLERf/nUEfPbpSgwfSIarBHUDmbrpwlRonB22uSDWxROXOewEdlX8l
         DjTujSLaJ8PxidlO+uChvzpnWNzHdQOb4h2fvjZlpUUFxx8LGzyOsrBrtssZQoI1Otex
         pkxM06Hgh5skqHegS+lVMn/LXqey3w/fyHzuhwCB5foNdRyxQDbDzeAt3kM3IA7ScKb4
         BtAg==
X-Gm-Message-State: APjAAAUZPUySTRv0CKcffjgcBk4Mx2ZL5XcuQ3eXnAlph7evaclmGvC0
        ggeg43sPGQPrHiQAR+LhebzmEg==
X-Google-Smtp-Source: APXvYqxOpX5NV1u66JQhM1CG5NcRPdKkJdr/2ZYZnOFWEjEYnUr0nPt9jqFxGhq3eoGM2q2Sn8D5yw==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr2875088wmj.62.1555590448565;
        Thu, 18 Apr 2019 05:27:28 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:27 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 4/6] arm64: dts: meson: fix mmc v2 chips max frequencies
Date:   Thu, 18 Apr 2019 14:27:12 +0200
Message-Id: <20190418122714.30805-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the datasheets, emmc v2 chips (gxbb and gxl) don't support
more that 100Mhz in UHS-1 SD modes and HS in SDIO.

Align the max-frequency to 100MHz for UHS-1 and 50MHz for HS

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         | 5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi             | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi         | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi            | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi        | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts           | 4 ++--
 13 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 016641a41694..a9b778571cf5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -164,7 +164,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -184,7 +184,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index ade2ee09ae96..be81f8958717 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -273,7 +273,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <200000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -301,8 +301,7 @@
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	max-frequency = <200000000>;
+	max-frequency = <100000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 25105ac96d55..3c54f26eef15 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -235,7 +235,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 0be0f2a5d2fe..e8f925871edf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -165,7 +165,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index ad4d50bd9d77..623bcb6594b1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -126,7 +126,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -151,7 +151,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 2d2db783c44c..b0d74ab619b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -183,7 +183,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -208,7 +208,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index 70433e023fda..3a1484e5b8e1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -160,7 +160,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index b0f22cdb586c..4b8ce738e213 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -237,7 +237,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 9cbdb85fb591..26907ac82930 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -180,7 +180,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index bc811a2faf42..e3c16f50814b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -114,7 +114,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -134,7 +134,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 3f086ed7de05..27beb813015b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -329,7 +329,7 @@
 	#size-cells = <0>;
 
 	bus-width = <4>;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -353,7 +353,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 25f3b6b14043..96fdb1856b7b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -144,7 +144,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 7fa20a8ede17..3d499675c9a8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -143,7 +143,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 
 	non-removable;
 	disable-wp;
@@ -167,7 +167,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <50000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
-- 
2.20.1

