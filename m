Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200B7C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB9D20867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JfzUU/55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfJDJB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:01:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39833 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbfJDJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:01:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so6154696wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhXs6wUTS9va5GBBPxgaGywhOz0cCImkUJC6MQ6iTnU=;
        b=JfzUU/55kQq5nD+ZLn3bLOI0F2/3jkG6qDmgUNVl1g7jdDYai2si2/JGxcZAIkjIvL
         wYoroINmrbRvQI8o02a5ng5aZPBf6AMNSCbIt2lxZMUdFy1aQewhJ6abmtICuikfg+TO
         rUr+Lml6iaUznsO5dMUSIoVB46b7426KBe3J12sx6HORU9Aqr8lsnU899mjeEXFX4bRr
         7Ww5+jvRb/Oev2fiMRcYrLfA1AFZbKN0VUdO8ssCPkS8qNACthwlVDV0R9gDcSjG2Tmn
         5XdCEsBflBo+3vnU87piw5PS0ihoDaUb9/JjfKErcxKBB6mLCPm9aNI8gPPYheqrby5B
         VRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hhXs6wUTS9va5GBBPxgaGywhOz0cCImkUJC6MQ6iTnU=;
        b=KHzytr1+xEtBJncbwIvtbHM4yoN/KpyifmZ/pacXZsy316hTdTs1VIkI8uey0R6+AY
         suH4Yq0xkqqWFHn8gDa0LIvnxNjh7AOiRngtvl/7WWEjsWsDhs9uPZmTW0egMV2CO7+E
         ln86TCoQSq96X2hNoZfoL9hi8sPKRLv1ltfAg0Bj4dgdSLSv2RE1qxfhoWArK5eGcVUV
         /IpFRuOmJCfyZH7J/uZd8TTTvR1JkZm0VvSzQV8e3azjLDRS+zK5F2I2IWhdh4thP9gX
         gXNi//dKEYCRNy5lyBqL+0drKj4eyKGb5FrUSZCwfBD4v3D4khPzKya2eggMyU7Vim5M
         ULQA==
X-Gm-Message-State: APjAAAXeSOcVXy4ZeaOtCcOPbfVFpiAZiV8T5FqNwkBkjn51+/yYENaf
        dx0ft9SL+QnyYwHio6CLLZLe5Q==
X-Google-Smtp-Source: APXvYqx3ANd3JSC4dmn8iEi+vP/O2TkbdGEiwSZ7uKVt38ptoDgZ9MC6kne/ujlpccqO7cuphtXGFg==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr11388390wrn.16.1570179682980;
        Fri, 04 Oct 2019 02:01:22 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:22 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 5/7] arm64: dts: amlogic: g12a: add cooling properties
Date:   Fri,  4 Oct 2019 11:01:12 +0200
Message-Id: <20191004090114.30694-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing #colling-cells field for G12A SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

