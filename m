Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE49C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA5921D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BSv5Bycm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfJDJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:01:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37643 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfJDJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:01:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so5007937wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gKlncKkeKiOPhKAIhttqbr6HYS2dTyRQP+4Baa5xLmI=;
        b=BSv5Bycmn4XtgAhc6+7VYH4IbEvzSwbW2t+hZmS2GoP+VLplDuZF103AwDwHjtjW4V
         q4gJrMYJPkkiFHyNjhp/zm0QuBXfOMO5PaXUJhdIy6XUuxufRovFlvp2C59lEyXSuvcw
         Kd29tObmyi6qJDb17C09EvX7ko4jurraqABZsn16WrjpHBkZXTUL3PhTE7A3JnDzBVdc
         fLZi1uUHFLh7oLJHx3RB87oPPEUtd4gPkmF/WB6hHoKv97bLTJE3UuqZiQmAH9Q4sDeC
         t1nRvr7AZnpwjKwqB4XY1L3eX9sLtponVvNE2z2Td6P1RqQGnYNQcDR4wu2joV7BI4IQ
         scKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gKlncKkeKiOPhKAIhttqbr6HYS2dTyRQP+4Baa5xLmI=;
        b=dJwRzQQhaZkW8NG8vd5wYFfP3vxJqQ7fA+h7rLM+vVKLKhQHEI2goDYnZ+sCb/6aSe
         fu6JSJklvL2HGdYmfLFZsEGJL9D00YrC7ccoTU5izxwARCE0TeSPZidiz7f0xCMwB3gp
         l8OAkvGMC8rkNyHDGmCgA4CmkTaVMpJ4wFNXnsuiepbV4shH0Q8EufB7qeHvrnrpIZzF
         pV7Pd6hUnbWkbbGEh3Fw4qlYQc0UpZ8nUm2kK7Tr4QDzC50TWWjK55fcnMQlTPCVo53A
         RaPunRks5Mr5RDWtZs9QpTGBY0PcWT1SBGUn7sLFGpulEUQxbDjEOr1J5mV0XDSWh11Q
         idIg==
X-Gm-Message-State: APjAAAWvgqcxgJSwEx6W2Kf2oRrn4sePXo9ht3E5nNSAJBpG51EzQQPR
        PAAUqBWqs44e/xe1HIZhWCXE6Q==
X-Google-Smtp-Source: APXvYqx8aNzo3ZYZjTc1LIfBgqGsmtdQFK4IhoYvZX3PB6pFJxFE5P7+1MnQrQAZfG0vVA7IaIiSbA==
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr9701863wme.135.1570179681779;
        Fri, 04 Oct 2019 02:01:21 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:21 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
Date:   Fri,  4 Oct 2019 11:01:11 +0200
Message-Id: <20191004090114.30694-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal thermal zone for two temperature sensor
One is located close to the DDR and the other one is
located close to the PLLs (between the CPU and GPU)

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0660d9ef6a86..a98c16e163c2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -94,6 +95,61 @@
 		#size-cells = <2>;
 		ranges;
 
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				thermal-sensors = <&cpu_temp>;
+
+				trips {
+					cpu_passive: cpu-passive {
+						temperature = <85000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "passive";
+					};
+
+					cpu_hot: cpu-hot {
+						temperature = <95000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "hot";
+					};
+
+					cpu_critical: cpu-critical {
+						temperature = <110000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "critical";
+					};
+				};
+			};
+
+			ddr_thermal: ddr-thermal {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				thermal-sensors = <&ddr_temp>;
+
+				trips {
+					ddr_passive: ddr-passive {
+						temperature = <85000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "passive";
+					};
+
+					ddr_critical: ddr-critical {
+						temperature = <110000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map {
+						trip = <&ddr_passive>;
+						cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
+
 		ethmac: ethernet@ff3f0000 {
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
@@ -2412,6 +2468,7 @@
 			assigned-clock-rates = <0>, /* Do Nothing */
 					       <800000000>,
 					       <0>; /* Do Nothing */
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.17.1

