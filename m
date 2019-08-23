Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F74233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="psJnyGdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404540AbfHWIOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:14:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404407AbfHWIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:14:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so8212669wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWIXIHsRRnjSYQ3AsI0iEQhYAJ00xnlwPbNZjsDVxCk=;
        b=psJnyGdCUXOnfYhGt0XNOWkMUB9iTLmvzy2FunTubobkCZMC/dGNrnlFFi24eGzliT
         BztwYjuP49mrhDHf0UBfGn5WW5yy3WIWcp6h4zGhOoPpGj4sRGjRqrBahzfEpMIHgD5t
         b97JICc4ZeulSUnS2spPGRerGT8lXEpm4ScewXrf4OMcYp3JMZN8vWxmUH5i37ZQq04n
         KLwG3LBPOtMBj6qDdgE9sPSgDsrliznHHFc+cFAOCLQmDCmu7ZU07czDmLBWjv4g7VGm
         JmXwl4pjAsNDqHSfAxPAyUu8aqwEJkcysERuGTyVz396wNuOe936uhdy75Gtnui1hFhj
         dGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWIXIHsRRnjSYQ3AsI0iEQhYAJ00xnlwPbNZjsDVxCk=;
        b=W45K+Cncdrq/dkym64HIW6UJ5v8nQxzdr7i+TfnJtpti59o6dA/rqGVB6yAOt6LD+d
         fgMmjh/rjGOe4vvQXKZWHtR45xkuIcEQwa9ZAylZyaf8MbYDipLrctvFLUp9/NrmorGH
         Afw77XX4loql+dJhFLNZASDLzz+sltmWmBNtg0ueiIGh1oG4yshnBBGuGKibzzuLScPN
         1teWNMoAE4woFGxsC4NIc82B//GSqCDSqwBjmmpK7XPpmQce1V9Oy1pPWv5WnviXbILL
         SNz2tvf/he155fdUY5QdOQVe+lTuSh7xwh6rmzrahXNGb6pfT7cOLPf5yRJ84iNDaD5S
         NieQ==
X-Gm-Message-State: APjAAAXlDdd37/UIQot8Cfo0PQ8rWZ5P2HO2fQb9kQ2wprKhv6Yu6CXy
        0ZJZ+EfjvHvLrmVk1lMI/6S1xQ==
X-Google-Smtp-Source: APXvYqw/tJbGfOMT0u4Ry9S5gyhMfZG5NLVl9v2ufDFsaia6+nJjrVPT+0ExheOJXEdqvRW6bnQPyQ==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr3522090wmg.158.1566548072267;
        Fri, 23 Aug 2019 01:14:32 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 74sm3632535wma.15.2019.08.23.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 01:14:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: khadas-vim3: add support for the SM1 based VIM3
Date:   Fri, 23 Aug 2019 10:14:27 +0200
Message-Id: <20190823081427.17228-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823081427.17228-1-narmstrong@baylibre.com>
References: <20190823081427.17228-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic SM1 based Khadas VIM3, sharing all the same features
as the G12B based one, but:
- a different DVFS support since only a single cluster is available
- audio is still not available on SM1

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-sm1-khadas-vim3.dts     | 69 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index edbf128e7707..33690b2ae2e1 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3.dts
new file mode 100644
index 000000000000..3eb9cc5915d9
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3.dts
@@ -0,0 +1,69 @@
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
+	compatible = "khadas,vim3", "amlogic,sm1";
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

