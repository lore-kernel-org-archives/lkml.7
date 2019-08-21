Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F208CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86F4233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ALAt9vKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfHUOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbfHUOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so2330784wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VILxG9P9ws6XZOAdFDkus8qgGuY3lecIRlYPtFgj9WU=;
        b=ALAt9vKcOrUxqtlLvaArXeD0i2K7pTIcp65CDzCCzBE+nTT+Tf6zUkCyWFV2eHT0W/
         RXwOlIfL+xEYFFyCdyrDfQ3KBGdXFm8NG4KAzwz4ouVDtL/5IE7U+tT7bLxhuXhndxDM
         qrTlUWq81UOg5jLdwQtOWfFWCUZ/QDFhY+xR/f178K38mNMFfrlV6SUMu1S6q8wOVYWb
         h1o9nxMaaHsgraLx5MrQ+cd5nsXx2BgDnVkaGuS6LmcQMb4s9jUTyquAkc/W1SWoWXJ2
         scRolwzLqrU04OajJ//qBA+g6HLBWBhGC2G1SOtkpiOWXpDoNkfL9bP2xv/8cxl0xGjx
         cBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VILxG9P9ws6XZOAdFDkus8qgGuY3lecIRlYPtFgj9WU=;
        b=AztqwxBNgZ60/miaUZHjX5WnGMcXPXufNKkSK78+00YpOV67S2Swwrg6XMIzewe0w3
         PsdEH50YZ1fIVdfJMsRUDz7GLU5XVA3igKqumESWXy4Hw77+1v4m666wCbiYvlZZZfW5
         aPf8KI8CooN7nP7KytuY9EAk6ZunD9Czu3k2muimO9LEljZXXglRf0pS4HFrnjTLSTEv
         vtKVH19a5cGwqMdJGus+qMFFidV2sJ8BjjTJ6CegeUW7Pa+kFqTILTwGuSJuwaMM9GQo
         8HoTYX1HhSDygcw1SDs9rVZRYsEA/BPn5xVg/dbg8dfOl2wyXZLrlH+5T9vZhnlHEXVl
         3LdA==
X-Gm-Message-State: APjAAAUbbPnXQYJkBjSbRgoJNZ2QBDO8S2bu/zMG5sMIe59fnf34B0Ij
        9IoVu6Ec5URtNE+OszqjsN8TeA==
X-Google-Smtp-Source: APXvYqwKh9Y2bLzMXUTYcYlInnpK1fTupIoe1aanAgESLEmPjdL5D9kHXCy27XEcN2pzMgbJ+uj4dA==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr307916wmf.156.1566397269128;
        Wed, 21 Aug 2019 07:21:09 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 14/14] arm64: dts: meson: fix boards regulators states format
Date:   Wed, 21 Aug 2019 16:20:43 +0200
Message-Id: <20190821142043.14649-15-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-odroidc2.dt.yaml: gpio-regulator-tf_io: states:0: Additional items are not allowed (1800000, 1 were unexpected)
meson-gxbb-odroidc2.dt.yaml: gpio-regulator-tf_io: states:0: [3300000, 0, 1800000, 1] is too long
meson-gxbb-nexbox-a95x.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
meson-gxbb-nexbox-a95x.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
meson-gxbb-p200.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
meson-gxbb-p200.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
meson-gxl-s905x-hwacom-amazetv.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
meson-gxl-s905x-hwacom-amazetv.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
meson-gxbb-p201.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
meson-gxbb-p201.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
meson-g12b-odroid-n2.dt.yaml: gpio-regulator-tf_io: states:0: Additional items are not allowed (1800000, 1 were unexpected)
meson-g12b-odroid-n2.dt.yaml: gpio-regulator-tf_io: states:0: [3300000, 0, 1800000, 1] is too long
meson-gxl-s905x-nexbox-a95x.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
meson-gxl-s905x-nexbox-a95x.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts          | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts        | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts           | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi              | 4 ++--
 .../arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts   | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 81780ffcc7f0..dc35e2982c71 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -65,8 +65,8 @@
 		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0>;
 
-		states = <3300000 0
-			  1800000 1>;
+		states = <3300000 0>,
+			 <1800000 1>;
 	};
 
 	flash_1v8: regulator-flash_1v8 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index b636912a2715..afcf8a9f667b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -75,8 +75,8 @@
 		gpios-states = <1>;
 
 		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
-		states = <1800000 0
-			  3300000 1>;
+		states = <1800000 0>,
+			 <3300000 1>;
 	};
 
 	vddio_boot: regulator-vddio_boot {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 9972b1515da6..6039adda12ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -77,8 +77,8 @@
 		gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0>;
 
-		states = <3300000 0
-			  1800000 1>;
+		states = <3300000 0>,
+			 <1800000 1>;
 	};
 
 	vcc1v8: regulator-vcc1v8 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index e8f925871edf..89f7b41b0e9e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -46,8 +46,8 @@
 		gpios-states = <1>;
 
 		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
-		states = <1800000 0
-			  3300000 1>;
+		states = <1800000 0>,
+			 <3300000 1>;
 
 		regulator-settling-time-up-us = <10000>;
 		regulator-settling-time-down-us = <150000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index 796baea7a0bf..c8d74e61dec1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -38,8 +38,8 @@
 		gpios-states = <1>;
 
 		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
-		states = <1800000 0
-			  3300000 1>;
+		states = <1800000 0>,
+			 <3300000 1>;
 	};
 
 	vddio_boot: regulator-vddio_boot {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 26907ac82930..c433a031841f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -38,8 +38,8 @@
 		gpios-states = <1>;
 
 		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
-		states = <1800000 0
-			  3300000 1>;
+		states = <1800000 0>,
+			 <3300000 1>;
 	};
 
 	vddio_boot: regulator-vddio_boot {
-- 
2.22.0

