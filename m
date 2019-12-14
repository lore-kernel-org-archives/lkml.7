Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092CC2D0CA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5861624658
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRkA+6qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLNN0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 08:26:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37161 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfLNN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 08:26:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so1663578wmf.2;
        Sat, 14 Dec 2019 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wq33jM3x02eHZQgjnJnfIIMER7XKwdVI1dmuxCz9aVA=;
        b=rRkA+6qP2z8riusQtyEMzfUaOn6MpLEGZlaQ36h0iJX6u0RzGOGPsCfjRFrPOoGrOL
         jxXWhbm9CXn1Zln2WOYDQRmkoDq5C6/M4Ztzhv40mCYQ424YeQKStfRPg0UqcBgpBZHy
         S02p/wdcrIO+RVU4v/PlkJYF+eTGMvWhPFpXabo2DiiJuJ8ArAvUB7Z8KRMg+NdFeXNR
         k45HL4nLPPwmpof+pFKDeMLiYqhi6S8UyUGVLvr4sdYmeiCmpc8Ob2XA2k4vQL7eN6Ig
         Hn7a1YLnv20LnFtSw8QxDGVpJqPvIi1qbD0aqWD9lXk8BPaNin5y0bLG7nusYkvHv4UM
         jG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wq33jM3x02eHZQgjnJnfIIMER7XKwdVI1dmuxCz9aVA=;
        b=eD6hrwISBPsQ7yLVzG9SCeOWXMDWsg9VfWr4jAypbshJoGywTLrZz7aXbZU7h4RpNM
         3wnS+j2xiXTTWMQvqoBg/5FpjruR0eWCdRqnZ20HKlnTI6BQaS65389kKSdV3WvHpbNu
         5GYt3gMFuwUGKisXvB23wdyfBMxa3/eT4T1JdWx2w/87Wr3sq9UHoI5IF11ItMCb6i4f
         IvN7BYMpfGATBp84t0hBJm3TDXxtei4vAn1hwny686aWnia1eO7VDV8b0mlp+Kgrx/H9
         VOnkUs95KB68u08hawQjVBqUqHN0RkM7jXflc2mF7H42QFQtK9XwPfJG9S33/1okVQFz
         ZPBQ==
X-Gm-Message-State: APjAAAUjEmU8KgY8aKdmoXLsHvNf/DURqwaf2rRsDc+M/B8B5cckJTN/
        tAMtrq/7hogi/6qZjA/kc6M=
X-Google-Smtp-Source: APXvYqxMvWK2sPaexIDmvj9lFcFw4yvvJsoOgR4bUNCZmT+9TGVtBols5tU3V3LtMifoJD1DuCkRrg==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr8560081wme.73.1576330009856;
        Sat, 14 Dec 2019 05:26:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id o194sm4247383wme.45.2019.12.14.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 05:26:49 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/3] arm64: dts: allwinner: unify header comment style
Date:   Sat, 14 Dec 2019 14:26:42 +0100
Message-Id: <20191214132642.29564-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191214132642.29564-1-peron.clem@gmail.com>
References: <20191214132642.29564-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner device tree files used different comment style for
copyright notice.

Update this to keep a coherency.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi                | 4 +---
 .../boot/dts/allwinner/sun50i-a64-amarula-relic.dts      | 6 ++----
 .../arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts  | 4 +---
 .../dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts     | 8 +++-----
 .../boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts     | 6 ++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts   | 4 +---
 .../arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 6 ++----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts  | 7 ++-----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts    | 7 ++-----
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 9 +++------
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi     | 9 +++------
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts     | 9 +++------
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi            | 8 +++-----
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts | 4 ++--
 .../boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi    | 4 ++--
 .../boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts | 6 ++----
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    | 6 ++----
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts  | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 4 +---
 .../boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      | 9 +++------
 .../boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts  | 9 +++------
 .../boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi             | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts  | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts   | 4 +---
 .../boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts      | 4 +---
 .../boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts   | 6 ++----
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi    | 6 ++----
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts     | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts    | 4 +---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi             | 4 +---
 34 files changed, 59 insertions(+), 130 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index f4f2c70fde5c..10e9186a76bf 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
- */
+// Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
 
 /*
  * AXP803 Integrated Power Management Chip
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 5634245d11db..ac979de19013 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2018 Amarula Solutions B.V.
- * Author: Jagan Teki <jagan@amarulasolutions.com>
- */
+// Copyright (C) 2018 Amarula Solutions B.V.
+// Author: Jagan Teki <jagan@amarulasolutions.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 76d0399b7737..2e00c44c7178 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2016 ARM Ltd.
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 4e7d4532e498..e7b64a5f8c13 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
- */
+// Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 787ebd805a3b..577f9e1d08a1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
- * Copyright (C) 2019 Amarula Solutions B.V.
- * Author: Jagan Teki <jagan@amarulasolutions.com>
- */
+// Copyright (C) 2019 Oceanic Systems (UK) Ltd.
+// Copyright (C) 2019 Amarula Solutions B.V.
+// Author: Jagan Teki <jagan@amarulasolutions.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
index 12f8c62c4f52..efb20846de49 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2018 Martin Ayotte <martinayotte@gmail.com>
- * Copyright (C) 2019 Sunil Mohan Adapa <sunil@medhas.org>
- */
+// Copyright (C) 2018 Martin Ayotte <martinayotte@gmail.com>
+// Copyright (C) 2019 Sunil Mohan Adapa <sunil@medhas.org>
 
 #include "sun50i-a64-olinuxino.dts"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 62f58233292e..0463564ae552 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
- */
+// Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 48bea0b526fa..72120e45f35e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
- * Copyright (C) 2017-2018 Samuel Holland <samuel@sholland.org>
- */
+// Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
+// Copyright (C) 2017-2018 Samuel Holland <samuel@sholland.org>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 72d6961dc312..302e24be0a31 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -1,8 +1,5 @@
-/*
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- *
- * Copyright (c) 2018 ARM Ltd.
- */
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2018 ARM Ltd.
 
 #include "sun50i-a64-sopine-baseboard.dts"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
index 2fb8cef0309e..b26181cf9095 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2016 ARM Ltd.
 
 #include "sun50i-a64-pine64.dts"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 830ab9beb3b2..6f817cfcccb9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2016 ARM Ltd.
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 78c82a665c84..2d0b3c6cc143 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
- * Copyright (C) 2018 Vasily Khoruzhick <anarsoul@gmail.com>
- *
- */
+// Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+// Copyright (C) 2018 Vasily Khoruzhick <anarsoul@gmail.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index e5b29f37ffd1..2f6ea9f3f6a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * Based on sun50i-a64-pine64.dts, which is:
- *   Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+// Based on sun50i-a64-pine64.dts, which is:
+//   Copyright (c) 2016 ARM Ltd.
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 1733306c469e..f1204fc4223c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * Based on sun50i-a64-pine64.dts, which is:
- *   Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+// Based on sun50i-a64-pine64.dts, which is:
+//   Copyright (c) 2016 ARM Ltd.
 
 #include "sun50i-a64.dtsi"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 970415106dcf..421454c8add7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -1,9 +1,6 @@
-/*
- * Copyright (C) Harald Geyer <harald@ccbib.org>
- * based on sun50i-a64-olinuxino.dts by Jagan Teki <jteki@openedev.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
- */
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) Harald Geyer <harald@ccbib.org>
+// based on sun50i-a64-olinuxino.dts by Jagan Teki <jteki@openedev.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index ceacb093d258..ab42c0664b3e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2016 ARM Ltd.
- * based on the Allwinner H3 dtsi:
- *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
- */
+// Copyright (C) 2016 ARM Ltd.
+// based on the Allwinner H3 dtsi:
+//    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
 #include <dt-bindings/clock/sun8i-de2.h>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
index d6cc6592cfa3..076a0b983101 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+// Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
+
 /*
  * DTS for Emlid Neutis N5 Dev board.
- *
- * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
index 7df7308ec9f0..fc570011495f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+// Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
+
 /*
  * DTSI for Emlid Neutis N5 SoM.
- *
- * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
index d68bdfea2271..64d35daf2023 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2018 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
+// Copyright (C) 2018 BayLibre, SAS
+// Author: Neil Armstrong <narmstrong@baylibre.com>
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index b65094488820..4f9ba53ffaae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Antony Antony <antony@phenome.org>
- * Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2017 Antony Antony <antony@phenome.org>
+// Copyright (C) 2016 ARM Ltd.
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index ee0aa49bce1e..b059e20813bd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
- */
+// Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 22df6dc44c79..70b5f0998421 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2016 ARM Ltd.
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index d9e3be17d842..cb44bfa5981f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * Based on sun50i-h5-orangepi-pc2.dts, which is:
- *   Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+// Based on sun50i-h5-orangepi-pc2.dts, which is:
+//   Copyright (C) 2016 ARM Ltd.
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index 08829849bc0d..ef5ca6444220 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -1,9 +1,6 @@
-/*
- * Copyright (C) 2016 ARM Ltd.
- * Copyright (C) 2018 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2016 ARM Ltd.
+// Copyright (C) 2018 Hauke Mehrtens <hauke@hauke-m.de>
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index 54d360198622..c95a68541309 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
- */
+// Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 83d177aff06e..3e724788dd3e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2016 ARM Ltd.
 
 #include <arm/sunxi-h3-h5.dtsi>
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 9957b81996ba..df6d872c34e2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2019 Clément Péron <peron.clem@gmail.com>
- */
+// Copyright (C) 2019 Clément Péron <peron.clem@gmail.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 735a959cf399..c311eee52a35 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2019 Ondřej Jirman <megous@megous.com>
- */
+// Copyright (C) 2019 Ondřej Jirman <megous@megous.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index 8844968f7227..e7ca75c0d0f7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2018 Jagan Teki <jagan@openedev.com>
- */
+// Copyright (C) 2018 Jagan Teki <jagan@openedev.com>
 
 #include "sun50i-h6-orangepi.dtsi"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 2bd863561282..83aab7368889 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2018 Amarula Solutions
- * Author: Jagan Teki <jagan@amarulasolutions.com>
- */
+// Copyright (C) 2018 Amarula Solutions
+// Author: Jagan Teki <jagan@amarulasolutions.com>
 
 #include "sun50i-h6-orangepi.dtsi"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index caccebe3389b..37f4c57597d4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2018 Amarula Solutions
- * Author: Jagan Teki <jagan@amarulasolutions.com>
- */
+// Copyright (C) 2018 Amarula Solutions
+// Author: Jagan Teki <jagan@amarulasolutions.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index e1f5784e1566..d1c2aa5b3a20 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
- */
+// Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 260dac597d6c..83e6cb0e59ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Jernej Skrabec <jernej.skrabec@siol.net>
- */
+// Copyright (c) 2019 Jernej Skrabec <jernej.skrabec@siol.net>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 8e5999cd08bb..6567dabbc0c7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
- */
+// Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun50i-h6-ccu.h>
-- 
2.20.1

