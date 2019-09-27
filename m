Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBBE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hDxy/YRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfI0MsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:48:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50332 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0MsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:48:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so6476149wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9YGH/6YIzv9K3Mh8Ek1+NGOAz5VU0/WuYChxnvTMt8w=;
        b=hDxy/YRBspG0UsSQWGlFqgvS2mZSISRc0P+ym8WjN83WN3p6w5of5YxEmAQzevScLO
         8IDs68ixRtxeAGWv7HYDzCm/wtJDyTOXBsWhowLWClhZTaQ31cT2Jn2WmkFDHCN58fCy
         lgQhI/+0Jb4llEQUf8ueqYRquLjEFP9fQk9SxnEZwDTzP/xLSgq9iVy/7C4BDHz6Oetf
         LDpbqM3FTEAMXqLLcZjaXDXUT5Y+HYx/XOnDKSUmtNrjhNkgeVHHXk9MVecBmVmDmH1Z
         FWsyNWIPIqf3gUUUmvrtXYjaE77OQR1k5Gry9Hk9wt+LK0AdVWJVHDKdWEQQF78eVLC1
         H5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YGH/6YIzv9K3Mh8Ek1+NGOAz5VU0/WuYChxnvTMt8w=;
        b=Agkg5CKeoHPDRvYSKJ7yBT9j39zoKDA4dXQn19MOyf2FaxpGiXtjbovp2EcdfnwxAy
         uHWtGncCiIarKj2q+4+06PjLQSTEf+LRk5jpRhJBJuQkT2G6EFcHRzR20g5/xNkgQb73
         CNaq7RTSR1eT3uMgCdbQ2GN+z8PWYf+Nzt6uC7qdQoONTbkGCZCCi3ih01oSE86PPoLM
         PgaAQwRpRZAnOTtV6lou8hAccGAML8DJ3OmEii8QcLuFsv8/EA1E/6CJW7l+5YPXMzKo
         5NPDo3AT+pF+LnCVWNhF+q0d3cu8AWVM/6LafPAHwveMlzTq54hFh/kYUr2/KzKhm7QU
         qjAA==
X-Gm-Message-State: APjAAAX02FXakj1d1YJMpnkbgMRpPkMI/8AIGF6Wqm3BDEzB6G6OX/Tb
        NZSx3cGMewXvuh0tgrHsGFi+Fw==
X-Google-Smtp-Source: APXvYqyY3lKAG/G3yQXF4Lie9vPhJPBWwgvXUx43AW6KRlI8rPISvgVud1MhXeVCFgb48yCZHCwW8w==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr7054051wmc.111.1569588480357;
        Fri, 27 Sep 2019 05:48:00 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:47:59 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 6/7] arm64: dts: amlogic: g12b: add missing cooling info
Date:   Fri, 27 Sep 2019 14:47:49 +0200
Message-Id: <20190927124750.12467-9-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing #colling-cells field for G12B SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 98ae8a7c8b41..4bb89bce758f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -49,6 +49,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -57,6 +58,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu100: cpu@100 {
@@ -65,6 +67,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu101: cpu@101 {
@@ -73,6 +76,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu102: cpu@102 {
@@ -81,6 +85,7 @@
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu103: cpu@103 {
@@ -89,6 +94,7 @@
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
@@ -219,3 +225,26 @@
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
+
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_passive>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
-- 
2.17.1

