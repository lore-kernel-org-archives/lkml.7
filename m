Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1BEC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F7D22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z3RuttDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfH1OSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:18:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfH1OSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:18:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id o184so236805wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8fPXZy6s7fSXGNVXDgDu4BkBSj5SqALzh4Ghh1aBOk=;
        b=z3RuttDMt3zQy24jOPCzgIyuqq+QsAtA5zyPntuqSomsBiTTNZfb/86imnzx/8ah5e
         zYGzol3Lm6Mu0ZMr8k5Zh/0r40bfepyK2b23EV+Hj5f68+y7ocpHxwNXK5qu+rrZG1xd
         ttyT+uwd5HdpesNRcNxZ6+pQYPg6AwOP89g0gNxz4gX3BFBMVBNHFjRSBWCYRBpAw7Fb
         3nt27CVcWzGJ7LK9uVZOv9hHv6GufTEc0r67+PF16zBpYl1QMwD7BZ9lOzPXVympnp4I
         wxW4uobb0WlmK+ZcP0YrmFE4a9CcKqVaV/U0hja6BhmT08HvOMiLDaQGiWjmUTOMYhDk
         03Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8fPXZy6s7fSXGNVXDgDu4BkBSj5SqALzh4Ghh1aBOk=;
        b=L92SN1aSBB57/C+ggn893vP3+J0HaMPb9NndK+zF8dTemYvmXoNr/Y6hT2l+5Z+2lg
         lCR+Dwm67g7vkZiw0uiPtRetVn8xVH+r3NZt9jsds3pNv5XkbPM/5PSQW6CadpzKpVPQ
         YZZ/c/CQTzHL2OGzoFqPB+tkqDa3675qJEFmtsNCF1GHNo3fydIUvatNP5jGZL6tXvYb
         nnyz1ctNpMQGlULRmHv9ZJje0aZJVgn5k6aDLX1MS72jZEtIgHUuLMQOBYe/omoNdNLB
         4A5+2N9pTOySwpyFgy9Yl0kqOa+H4+6LvURNSxf5n/fhmLVDpL/xYBf3ZuDH2tSuB3He
         X7Ow==
X-Gm-Message-State: APjAAAWRAi8kaVri2yjVqX9SKHxNC9Q2bbRNAnKiAluIYUvaZsG9NUHN
        7qnM9NWHnGrhuolejvSAtLiRh0LmQp9lTg==
X-Google-Smtp-Source: APXvYqz//1qAjYnMY49bdNYUBOzbmJ/xbIX+Ea4PZTRK756pvLSdafxWSsysjqRMaSATj4WVGPBi3A==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr3858293wmb.95.1567001901362;
        Wed, 28 Aug 2019 07:18:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u8sm3022354wmj.3.2019.08.28.07.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:18:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: khadas-vim3: add support for the SM1 based VIM3L
Date:   Wed, 28 Aug 2019 16:18:16 +0200
Message-Id: <20190828141816.16328-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828141816.16328-1-narmstrong@baylibre.com>
References: <20190828141816.16328-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic SM1 based Khadas VIM3L, sharing all the same features
as the G12B based VIM3, but:
- a different DVFS support since only a single cluster is available
- audio is still not available on SM1

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index edbf128e7707..84afecba9ec0 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
new file mode 100644
index 000000000000..5233bd7cacfb
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1.dtsi"
+#include "meson-khadas-vim3.dtsi"
+
+/ {
+	compatible = "khadas,vim3l", "amlogic,sm1";
+	model = "Khadas VIM3L";
+
+	vddcpu: regulator-vddcpu {
+		/*
+		 * Silergy SY8030DEC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU";
+		regulator-min-microvolt = <690000>;
+		regulator-max-microvolt = <1050000>;
+
+		vin-supply = <&vsys_3v3>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU1_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu2 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU2_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu3 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU3_CLK>;
+	clock-latency = <50000>;
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
-- 
2.22.0

