Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFDC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9BA206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ckHocCML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfGaMkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:40:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37671 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfGaMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:40:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so59667677wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WizoPIpJaKEOM8keVQY+4BOKIt1ZSfvce2lQKnegAL4=;
        b=ckHocCMLDHqzBF6s9DOcxp+6e/eLz9YRUmG9keahMxrmfPKFZUV/54T/2IjBgXhhe0
         YffPVI0DLYjh2Bwamhr2sdgPK2TeDL31oVVgfEsEx3NYWpMCAQDgl9yCkSSdC57R2Vi/
         2IBm0Utoyeb2vMeF21sPvlom7FAQMWAoL2SDGG3jmrf+qQp4cffFACh11pM47cAPI8Ez
         apIzhenEoWSRlCdTv+7KnkobDyJhqM9BQX6qASZUpQsxugBjfkyYJWiPcK8hWBYr149b
         sTbWuoB7rWeybmX1uPGoIjMnDAVJbA3Z/fNTuuRVb7ZTTcbFU17pTI9FwXaKgdT2VUo+
         NzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WizoPIpJaKEOM8keVQY+4BOKIt1ZSfvce2lQKnegAL4=;
        b=EifE4b66pENk7edXy9nnLvNqxMcmQk+maoX0mHdGF4e5yf/Qm/W/wqJtlAgyaJcKUw
         9Hgt/Dz+L+i1UZk7MDyb509EARfW4cmbe91x63e3Z9w6kUb+J1P064+Z5/xLUuB6khcl
         tz/yYyQJg8osC2r3Pu06waMaIXHEZ1OVquFfFKwsAIN9+X0RuLYcf+Pk+tqFeQF9mCJm
         qdXuSffi/e5mE6J/t2Ax7d9VXZ8wWWA/iptvUlzl8nnEaSUeuWNGLg8oYgw9/U7wQqJ8
         bLevGF/QQEc8IJnr6sI96wuJxTBaqGfmL+0/8K72AY+kfbno0oC2druOvMbDP1PiLVGV
         6Kkw==
X-Gm-Message-State: APjAAAXMVqDqzvXTUR6e0Amoxr+Gb0LAa1q6aE3juCbnxtYzIiE5UPjS
        NDIVVVDQ6i/RIzJPaRTM7DdBhQ==
X-Google-Smtp-Source: APXvYqwDPOxco6g/MHBgaf8q6x2onNr51cb1t1+BxEgPGrv/rv4Hu0+/MZkWCY9T61/xK0sYnPpWFA==
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr108079706wmg.158.1564576808108;
        Wed, 31 Jul 2019 05:40:08 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm62504271wmg.46.2019.07.31.05.40.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:40:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/6] arm64: dts: meson-g12b: support a311d and s922x cpu operating points
Date:   Wed, 31 Jul 2019 14:39:59 +0200
Message-Id: <20190731124000.22072-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124000.22072-1-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Meson g12b ships with a low-speed (S922X) and high-speed (A311D) variant
so remove cpu_opp_table nodes in meson-g12b.dtsi and create two new dtsi
that can be included in device-specific dts files. Opp points were taken
from the vendor BSP kernel.

Also make meson-g12b-odroid-n2.dts include the new meson-g12b-s922x.dtsi.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 149 ++++++++++++++++++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |   2 +-
 .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 124 +++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   | 115 --------------
 4 files changed, 274 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
new file mode 100644
index 000000000000..d61f43052a34
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12b.dtsi"
+
+/ {
+	cpu_opp_table_0: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-667000000 {
+			opp-hz = /bits/ 64 <667000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <761000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <781000>;
+		};
+
+		opp-1398000000 {
+			opp-hz = /bits/ 64 <1398000000>;
+			opp-microvolt = <811000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <861000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <901000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <951000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1001000>;
+		};
+	};
+
+	cpub_opp_table_1: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-667000000 {
+			opp-hz = /bits/ 64 <667000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <751000>;
+		};
+
+		opp-1398000000 {
+			opp-hz = /bits/ 64 <1398000000>;
+			opp-microvolt = <771000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <771000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <781000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <791000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <831000>;
+		};
+
+                opp-1908000000 {
+                        opp-hz = /bits/ 64 <1908000000>;
+                        opp-microvolt = <861000>;
+                };
+
+                opp-2016000000 {
+                        opp-hz = /bits/ 64 <2016000000>;
+                        opp-microvolt = <911000>;
+                };
+
+                opp-2108000000 {
+                        opp-hz = /bits/ 64 <2108000000>;
+                        opp-microvolt = <951000>;
+                };
+
+                opp-2208000000 {
+                        opp-hz = /bits/ 64 <2208000000>;
+                        opp-microvolt = <1011000>;
+                };
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 777bfb938854..6cfc2c69bb4f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include "meson-g12b.dtsi"
+#include "meson-g12b-s922x.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
new file mode 100644
index 000000000000..046cc332d07f
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12b.dtsi"
+
+/ {
+	cpu_opp_table_0: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-667000000 {
+			opp-hz = /bits/ 64 <667000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1398000000 {
+			opp-hz = /bits/ 64 <1398000000>;
+			opp-microvolt = <761000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <791000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <831000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <861000>;
+		};
+
+		opp-1896000000 {
+			opp-hz = /bits/ 64 <1896000000>;
+			opp-microvolt = <981000>;
+		};
+	};
+
+	cpub_opp_table_1: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <751000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <751000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <751000>;
+		};
+
+		opp-667000000 {
+			opp-hz = /bits/ 64 <667000000>;
+			opp-microvolt = <751000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <771000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <771000>;
+		};
+
+		opp-1398000000 {
+			opp-hz = /bits/ 64 <1398000000>;
+			opp-microvolt = <791000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <821000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <861000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <891000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 98ae8a7c8b41..d5edbc1a1991 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -95,121 +95,6 @@
 			compatible = "cache";
 		};
 	};
-
-	cpu_opp_table_0: opp-table-0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-666666666 {
-			opp-hz = /bits/ 64 <666666666>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-1200000000 {
-			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-1398000000 {
-			opp-hz = /bits/ 64 <1398000000>;
-			opp-microvolt = <761000>;
-		};
-
-		opp-1512000000 {
-			opp-hz = /bits/ 64 <1512000000>;
-			opp-microvolt = <791000>;
-		};
-
-		opp-1608000000 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <831000>;
-		};
-
-		opp-1704000000 {
-			opp-hz = /bits/ 64 <1704000000>;
-			opp-microvolt = <861000>;
-		};
-
-		opp-1896000000 {
-			opp-hz = /bits/ 64 <1896000000>;
-			opp-microvolt = <981000>;
-		};
-	};
-
-	cpub_opp_table_1: opp-table-1 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-666666666 {
-			opp-hz = /bits/ 64 <666666666>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-1200000000 {
-			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <771000>;
-		};
-
-		opp-1398000000 {
-			opp-hz = /bits/ 64 <1398000000>;
-			opp-microvolt = <791000>;
-		};
-
-		opp-1512000000 {
-			opp-hz = /bits/ 64 <1512000000>;
-			opp-microvolt = <821000>;
-		};
-
-		opp-1608000000 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <861000>;
-		};
-
-		opp-1704000000 {
-			opp-hz = /bits/ 64 <1704000000>;
-			opp-microvolt = <891000>;
-		};
-	};
 };
 
 &clkc {
-- 
2.22.0

