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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB8C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE32A2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYcX3Nh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfLISUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:20:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLISUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:20:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so17377625wru.4;
        Mon, 09 Dec 2019 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLlmAEfS4L9u8haRdPnweq0VSUcLpaHdR2XchPJNbS8=;
        b=PYcX3Nh1snHfT8JsgHpyX2NWOTbezNdwxQ2ChVo9oLdWhQpzwyIzKdK3KoA6ehfl8P
         /bggQ6Syjbl7cwQGDr9f/7UzdZLPOd5JV1zCPOLaKlHVV2wNegD04fgD5mQR3ZLkd+mx
         tS+RSHmuYcP0cxJEM7xn9XOk5ve93JvMyCq17gK83Rx/Uu2nnmRKNB+aFi8I8KqrZ0A5
         GwMsqoQun/MoQBgxqJs40Ge5FakV+FdTGGp7ZrI6Pmge1TwBp0gTZCpdeWCR1V85bFRq
         Pws2Vi5/nhRqkqiL/Ut4dUJEuZdv9LT1SQgRezJp05ssWwaRU6w3taBQe4u8+SzIXgVT
         MgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLlmAEfS4L9u8haRdPnweq0VSUcLpaHdR2XchPJNbS8=;
        b=uhLCQ2AgPoC4yzSuP+psSKfT3wJ67qbOsTDTh6J5/Cylq7gKN78VSYg3FnZSUIwNt5
         TNj7F1Fc99TmGbTjKP1ixYbbK02TGHuPctdX9OcXRb1wLwiKmsSvg/LxZ0BWyq4JGT0G
         0dY/5qWIsuMvwFK32wH+ELS4TqtxVVzPBvdZIk9h2uCQYGc0/DmPo5AMg9MBZY+n5Hp0
         XyOMhTJqmsRR/C6a+Rx+d4nozqIM79FI/DmkNGWRMIFuplTLhWCtCXn2aUzkVp+QrhVG
         AfnDvNBBbqtbF/XeTr9jfROVhun78U6hqfVTJYZgX8oRM285dnRkHvEdyA/jt80g1A+y
         0/Pg==
X-Gm-Message-State: APjAAAVfj6bFUYoZWJ0SZPXd9Gw1qaluPb036cm2aa+2pSdel3KutBUU
        0T65Y6D1CwMLXw6umF7ohyU=
X-Google-Smtp-Source: APXvYqywgzQTu50MZa6zMok/CjMF2/kh5sldWniuwz5GIgCWPd6ExEvG5lIpT5xRZpXmMmdPOQb5XA==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr3651948wrq.123.1575915634420;
        Mon, 09 Dec 2019 10:20:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id n14sm188261wmi.26.2019.12.09.10.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:20:33 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/3] arm64: dts: allwiner: Fix typo in dual licensed SPDX identifier
Date:   Mon,  9 Dec 2019 19:20:22 +0100
Message-Id: <20191209182024.20509-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dual licensed SPDX identifier the "OR" should
be uppercase.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts          | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index f335f7482a73..84b7e9936300 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2019 Clément Péron <peron.clem@gmail.com>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 4ed3fc2c7734..1c66304fc551 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2019 Ondřej Jirman <megous@megous.com>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index e098a2475f2d..8844968f7227 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2018 Jagan Teki <jagan@openedev.com>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 12e17567ab56..2bd863561282 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2018 Amarula Solutions
  * Author: Jagan Teki <jagan@amarulasolutions.com>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index df4cbd7ef96c..caccebe3389b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2018 Amarula Solutions
  * Author: Jagan Teki <jagan@amarulasolutions.com>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 74899ede00fb..3238323d5a71 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index bccfe1e65b6a..891ad616302c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2019 Jernej Skrabec <jernej.skrabec@siol.net>
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 29824081b43b..b8f51d95ca8c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  */
-- 
2.20.1

