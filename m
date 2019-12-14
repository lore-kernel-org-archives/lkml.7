Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964F1C00454
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E86A2465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujMHJWNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLNN0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 08:26:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41706 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 08:26:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so1747214wrw.8;
        Sat, 14 Dec 2019 05:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvGlD5kPVTONmWTHdpaxbRMm/71Q6Yy4dcoeO1YH8dE=;
        b=ujMHJWNUwGcEg58M5xky4eCEQulioq+bUebi+7IQ6CK59ZinoFgikEMLhleIoQQ8kI
         RS5VC4ycAadZG3m8A5nie06k0goclK+2ef8qukWD1mUo/3sbojPagfzw7lrR2tIYuC5f
         tYJSfmnoEk3esCPCOeVP9/s5xbHf8bh/N+UEF0cXwot7NT9pqNF/qlU2v7P3Et2X7469
         XnRdeo22aixZ+YO3e4TQaCFCg1EB04Rj2ze5j0a7RPlsmzCR17mXACIcypa/Pnndk8dF
         hbdRD0CxBqq0VMBVYc4JpDSNo1AwVxkT1VvF/1J1TLdTnmqXIPC6RlriMBto+vvi64Ow
         X8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvGlD5kPVTONmWTHdpaxbRMm/71Q6Yy4dcoeO1YH8dE=;
        b=OReZ1j4DnhSvuvAHIdrygQ94izGibCUpDob5J25CJaYf20meV7f4cqnxrn9ca010O1
         277fqSEqy/dpWDXwZd1OJ1QevYCQnueQWZc34m16x64PMuEOqC1qHqSvxAyZ1lGPbHVu
         KR+y6X+xrHLZ5+YR1LSOGy2LlXdwlT7F5f2MIQr6yeePW+0pbefYa3W6wUgppcrn43We
         7wZf978+WnxiOaaCL6rejL0rWKQ9uCeudfZcm8l+h7FLFrxCer+Hna44eQPGtLeNzK2B
         +EFSHDHuAEVr/QZs5PDJgUitZHacAAvM76FyTMKAC1rB6Nh0LlCOLTuLzGNa88DQJ6yW
         sTPg==
X-Gm-Message-State: APjAAAXdjqubA2Ys8qclECM5fUj96IRWvFXnoo/viMvPjcnunmaJBghi
        bRk3eR+PTTc1v/PSWyKmRaE=
X-Google-Smtp-Source: APXvYqyP44yq+IRE0YnGCPJUV5ruEA+Y0HOJdzxXa5REdibu3JoLLBLxdjGgaDYPrmoy6iARusRctQ==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr17803023wrx.87.1576330008281;
        Sat, 14 Dec 2019 05:26:48 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id o194sm4247383wme.45.2019.12.14.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 05:26:47 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/3] arm64: dts: allwinner: Fix wrong license header
Date:   Sat, 14 Dec 2019 14:26:40 +0100
Message-Id: <20191214132642.29564-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers specify that files are under dual-licensed GPL2.0+
and X11. But in fact, it turns out that the full licenses texts
associated are GPL2.0+ and MIT.

Fix license headers to reflect real licenses associated.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi                       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts          | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts             | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi            | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi                   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi                    | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index f0349ef4bfdd..22396406c5f9 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -2,7 +2,7 @@
  * Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 208373efee49..e19fbe066c9e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -2,7 +2,7 @@
  * Copyright (c) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 9b9d9157128c..311475159def 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -2,7 +2,7 @@
  * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 0a2570575e1f..c98c4fca57de 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -2,7 +2,7 @@
  * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index f54a415f2e3b..ee419b028e2d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -3,7 +3,7 @@
  * Copyright (C) 2017-2018 Samuel Holland <samuel@sholland.org>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
index d5b6e8159a33..311525ff82df 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -2,7 +2,7 @@
  * Copyright (c) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 409523cb0950..6ba9f9052be5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -2,7 +2,7 @@
  * Copyright (c) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 920103ec0046..612f4c295549 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -5,7 +5,7 @@
  *   Copyright (c) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 9d20e13f0c02..a578a276d555 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -5,7 +5,7 @@
  *   Copyright (c) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 27e48234f1c2..0dfee8b7f523 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -4,7 +4,7 @@
  *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 1c7dde84e54d..7037ec9df4a1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index 57a6f45036c1..fa56e232f380 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -2,7 +2,7 @@
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index e126c1c9f05c..74f5d8b3eb8a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -2,7 +2,7 @@
  * Copyright (C) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index d9b3ed257088..05c1c26ce6e6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -5,7 +5,7 @@
  *   Copyright (C) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index dacf61399527..93b104f2f9f5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -2,7 +2,7 @@
  * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 7c775a918a4e..620a3171c3e8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -2,7 +2,7 @@
  * Copyright (C) 2016 ARM Ltd.
  *
  * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
+ * of the GPL or the MIT license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
-- 
2.20.1

