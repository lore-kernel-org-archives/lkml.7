Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90B52146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K9an5A5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfI0MsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:48:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfI0MsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:48:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so6458871wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bn1Yyb+y0E2XtXZ6uMo4FglNk7nmGiqm3716bVhGUbI=;
        b=K9an5A5Gt5DdTP1cbKeOnKPTzPSiEKvpVGCm8o+7tsv9wzJAzXCZQBkX6JTSgHJ3Iy
         DPThePWfO71M0t+mxHEuEsRhkwldfeXD1BaL8mC/W6JKaUnbKMuInIXBTEV7efhLceyo
         58mKE6MqQ+fKAbEq0Qvoms8kWyqEzkdaSC7bjdiQnDtU9bdL9J1j6uB5mt4V0z5BjJSp
         mZnYJHg65mnQCBv67lKtmfTJsFQG0JL9F8DRFVW8T6IOiVEDmEkHNSVeaOS1pdwSnRD0
         TDWHkBhhgCdux/1r1YwrjhbyufN74ljk8VlruZdl4fsfZGa/EazKqD6ZS/P+FkEPJfQ+
         5/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bn1Yyb+y0E2XtXZ6uMo4FglNk7nmGiqm3716bVhGUbI=;
        b=CHom8ce9pqdBUmMVebUC5pwjVKDLGHoNuZ9Dy06K7H77BAHeJz9DlbOuc9211Vrem3
         j04tZ3p3HHL38eLKtdHGKycpSxHQGQ0MXj+tg3EVHWOektHu+Iv2bUHHxeV4ctuY5KTh
         F/rrNZvqZQgwT0dxioMnFpatLqFAVfYByXUnqqH2BdrkYU57nXyZmTXyVb90l/v6ievJ
         2DqXY+23Dgp7JoMDgk1EKoEKfduwCe0opfsDikO0TDGZBwPz/kzDuDIy1137T1L1G136
         PbhruxoO9LCpqgUdwqQ6pZATbXQov5hicLwka9M0LPsE05WlX+NZAoLVeBpWmtfIprgb
         Owuw==
X-Gm-Message-State: APjAAAXgUz5mDhd8zyujP2DS+6NttGE36CPyYuWv7YkuXz9qrfG2Njsj
        41nTMUZTvOR2iZnl2nE4Mm43vw==
X-Google-Smtp-Source: APXvYqyPHf/pDWgxGEyU6SfHL1TSMLHW+AfoTa4Fd6D5uufSUoyA3g3A7r6lbvJjccaS5BMtCqLChw==
X-Received: by 2002:a1c:4945:: with SMTP id w66mr6962094wma.40.1569588477438;
        Fri, 27 Sep 2019 05:47:57 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:47:56 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 5/7] arm64: dts: amlogic: g12a: add cooling properties
Date:   Fri, 27 Sep 2019 14:47:46 +0200
Message-Id: <20190927124750.12467-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing #colling-cells field for G12A SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 733a9d46fc4b..3ab6497548ca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -18,6 +18,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -26,6 +27,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -34,6 +36,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -42,6 +45,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
@@ -113,3 +117,23 @@
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
+
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_passive>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
-- 
2.17.1

