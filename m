Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE33217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hM5HszN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfI0MsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:48:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40693 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfI0Mr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:47:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so2583788wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7iwhASPxbBfW+q2EXnPK2zfjdwyLTY+27xuFNIdRtA=;
        b=hM5HszN16GCur2cmgDofM9AqaYy/8VHWlTMuTYKWxaoCpfe68AbKYf7EgP7AZTtGQV
         8QNDXtu1HjBkX9ECY6kbivdSZfVJYZTeKsZHaMbuU/sLrONewee0F1UjlotFAULK1C3o
         /z9KWEDWXZpk/LY86hLqVLE6JoiskNBmKHPiML4PpKE88HOBCkpaexIc0YGwOw4cno4Q
         15a8we+0SuJt2+CZCC9j4Ve9gg14S6DEGczcfLM/AVRpLfrWYM66YFp4YjgKfrzGxMe2
         zKPZJzJGzRWIyYFMG0tBMuhPFNRns/rx2Jrh4MfM3e20HwdEmYFkaqe2BP/3sAK2M08R
         nJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7iwhASPxbBfW+q2EXnPK2zfjdwyLTY+27xuFNIdRtA=;
        b=fIxMullGYKPdLxPAkkas80LrIGqIzDtoBRW2Fl6vZ12k0gC8iCBG5ZpxRSqOeStEVx
         ZvzB8myQwBQ9jiw7d2kpPTmboeivCZfmW5223EjPDKVPYLN4ReaQcwaXcA1CwzDIKQJD
         yXqSDo9za05hsG4MTEza/lYI52N7EFgzimX3Tqn4DO7nxualjymhDZWbWR1nvqd+tcb4
         he2JPQkZCYeXaHQm0poiKIH5bDWj586CMGMO+DZdQHdoBZRIlNtJlD1gu8jZ5aHTcuq/
         rkyQ8zFzXCk6GNgvTCBRmXuwp7RZRA/yz783SlI6IOj6GZvAD7G5qsIqiZJqEJDF1h7/
         0jvQ==
X-Gm-Message-State: APjAAAUamO3qgeFQ/4lFGHzRLeRXtF4U3I9r9nj6XqvkxRj/zxrtWWJ1
        MjEl9zMCyVGpf/L04Kn3Z7GT+Q==
X-Google-Smtp-Source: APXvYqwAZclia+Z3ixWm7xB2/jZuLwc25ZPoW5O3SUaOaSe4s8zlVe9XokOOM88zEMRzk8WB6E25Jw==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr2807206wrw.7.1569588476337;
        Fri, 27 Sep 2019 05:47:56 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:47:55 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 4/7] arm64: dts: meson: g12: Add minimal thermal zone
Date:   Fri, 27 Sep 2019 14:47:45 +0200
Message-Id: <20190927124750.12467-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal thermal zone for two temperature sensor
One is located close to the DDR and the other one is
located close to the PLLs (between the CPU and GPU)

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0660d9ef6a86..f98171949fcb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -94,6 +95,50 @@
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
@@ -2412,6 +2457,7 @@
 			assigned-clock-rates = <0>, /* Do Nothing */
 					       <800000000>,
 					       <0>; /* Do Nothing */
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.17.1

