Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D75C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5637A206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDcLVbJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLISUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:20:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35204 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLISUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:20:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id c20so349767wmb.0;
        Mon, 09 Dec 2019 10:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wpg4ypWzi7biO5WyjpAtCQhzPwFyoNkxfYfAncftY+s=;
        b=GDcLVbJ8dLyl3XoK5SpC5yM1Mbwzg4xiRW1Hjed25hangncOEnPR3sfP8+uK9ZsZQI
         guib6yZZO7zlGe9DPV3qZzqKmALfcZSdupr7wQWmIKdU88g0K3xLNfpmjUOANNahwn1b
         lPhYO3QBWtZWR6qptTyG8dC+9U3kba7/Exe9n2qHmiFCL3TeGyJR6IzzLtIGIRbY1ur1
         0ZYAuiEoW5f6kxeDKkJw/giQnwMNeSY+WjWDpn6qz5Is7qbQyvoqerbM2Jf1zHwO9xvj
         vdENZ3lIfzpOi86UAzgXcJQTLQXo0VMT3vJOvy+hfK9UD+C3mYLDKTmqGwIPMs62wRym
         w9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wpg4ypWzi7biO5WyjpAtCQhzPwFyoNkxfYfAncftY+s=;
        b=lrt9DGR5zoqCECfK01qPNWEQiE+QeFl2yXMBnG/lykQp8KxMmLYaxjUrbvJY4+QUZg
         Rp+3mN/uOgTIC9PqssdmkkvQNedaUEO5ICA2ivpqihyIcDwYvt2IAizrCU2HVIhL5wIT
         DUrKKdEys0daYoeVo2Hu8qwcCs8O1dr2mazK4xharCpu05VNjv0cCVWeektF4PXrwKkr
         7SqcCbrZkf60dflh7iNhuen3wTD412MeWb3VJkQ5lWfTfO5X6syR1cG9cOFMn8iT++Hx
         NvNNXkpUNbQZUGX99LKH9V3oU+0mlgSfkm9UUxE1aVuqW1aJDSqeG6ND9AW1kvq5AU+R
         9FSQ==
X-Gm-Message-State: APjAAAXTN1qq97bSL/3Ns8B6N4csPczcUe7Q1/8O6SfCmgh2JPj12CEG
        fyQwbUAfBveI1FcdX8uDtTc=
X-Google-Smtp-Source: APXvYqxeQCFTIPsop9FOVTIUHRVKwNl1vdDqSRTQPby0eSCBlnuvFqW5WZF98dG0S1S4IWWqVj1tRw==
X-Received: by 2002:a1c:b406:: with SMTP id d6mr391154wmf.52.1575915637782;
        Mon, 09 Dec 2019 10:20:37 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id n14sm188261wmi.26.2019.12.09.10.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:20:37 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: unify header comment style
Date:   Mon,  9 Dec 2019 19:20:24 +0100
Message-Id: <20191209182024.20509-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209182024.20509-1-peron.clem@gmail.com>
References: <20191209182024.20509-1-peron.clem@gmail.com>
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
index 0e13e75132ac..5e5b8e65e02f 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index ca733651cb83..6aa91e70cd0b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2016 ARM Ltd.
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index f913b31b84c5..0bb30847f337 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index 96ab0227e82d..9462c941cd21 100644
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
index d630059fa61b..0c30b7c97806 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
- */
+// Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 492158ac3179..0c0bc73846f4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index 3c1ebf2f119b..32f4736d64bd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (c) 2016 ARM Ltd.
- */
+// Copyright (c) 2016 ARM Ltd.
 
 #include "sun50i-a64-pine64.dts"
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 86223f65cdc3..54e7d524d38b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index 48ac9c726e91..49b1c3296213 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index 2291e7f9fe74..88b2b839aee8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index eb388c096152..3360b1dd3133 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index c924090331d0..3e0323fc592c 100644
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
index 5bec574fa108..6c5ae5d758b2 100644
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
index 3691c37630e7..b35fb6d38e48 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (C) 2017 Antony Antony <antony@phenome.org>
- * Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2017 Antony Antony <antony@phenome.org>
+// Copyright (C) 2016 ARM Ltd.
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index e5c1e29306a8..6e666b02e16f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
- */
+// Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 8b40954f7308..6fb36ea20906 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2016 ARM Ltd.
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 2b6bcebe25ee..da6f9601a780 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
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
index db6ea7b58999..28b15c9d59ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -1,9 +1,6 @@
-/*
- * Copyright (C) 2016 ARM Ltd.
- * Copyright (C) 2018 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR X11)
- */
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+// Copyright (C) 2016 ARM Ltd.
+// Copyright (C) 2018 Hauke Mehrtens <hauke@hauke-m.de>
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index a7ea6c2eeac1..7601c28a65d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
- */
+// Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 80e1371fbde8..f755a3a54b0c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright (C) 2016 ARM Ltd.
- */
+// Copyright (C) 2016 ARM Ltd.
 
 #include <arm/sunxi-h3-h5.dtsi>
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 84b7e9936300..e561b29c2be8 100644
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
index 1c66304fc551..8a2d3849520a 100644
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
index 3238323d5a71..acb3d7f5061c 100644
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
index 891ad616302c..f7b52c359037 100644
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
index b8f51d95ca8c..dd0dbbd39a36 100644
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

