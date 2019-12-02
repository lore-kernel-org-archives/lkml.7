Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB9DC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7E32070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLBK31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:29:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfLBK3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3A61B29F;
        Mon,  2 Dec 2019 10:29:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org
Subject: [PATCH v2 4/9] arm64: dts: realtek: rtd129x: Carve out boot ROM from memory
Date:   Mon,  2 Dec 2019 11:29:05 +0100
Message-Id: <20191202102910.26916-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202102910.26916-1-afaerber@suse.de>
References: <20191202102910.26916-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DS418j, MeLE V9, PROBOX2 AVA, Zidoo X9S and DS418 /memory nodes
to exclude 0..0x1efff from reg entry and update unit address to match.
Add this region to /soc ranges and for now just update the /memreserve/s.

Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 72a7786c0a0d ("ARM64: dts: Add Realtek RTD1295 and Zidoo X9S")
Fixes: d938a964a966 ("arm64: dts: realtek: Add ProBox2 Ava")
Fixes: a9ce6f854581 ("arm64: dts: realtek: Add MeLE V9")
Fixes: cf976f660ee8 ("arm64: dts: realtek: Add RTD1293 and Synology DS418j")
Fixes: 5133636e41a2 ("arm64: dts: realtek: Add RTD1296 and Synology DS418")
Cc: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts      | 6 +++---
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts     | 6 +++---
 arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts | 6 +++---
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts   | 4 ++--
 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts       | 4 ++--
 arch/arm64/boot/dts/realtek/rtd129x.dtsi            | 9 +++++----
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts b/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
index b2dd583146b4..b2e44c6c2d22 100644
--- a/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
- * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2017-2019 Andreas Färber
  */
 
 /dts-v1/;
@@ -11,9 +11,9 @@
 	compatible = "synology,ds418j", "realtek,rtd1293";
 	model = "Synology DiskStation DS418j";
 
-	memory@0 {
+	memory@1f000 {
 		device_type = "memory";
-		reg = <0x0 0x40000000>;
+		reg = <0x1f000 0x3ffe1000>; /* boot ROM to 1 GiB */
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts b/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
index bd584e99fff9..cf4a57c012a8 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2017-2019 Andreas Färber
  *
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
@@ -12,9 +12,9 @@
 	compatible = "mele,v9", "realtek,rtd1295";
 	model = "MeLE V9";
 
-	memory@0 {
+	memory@1f000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x1f000 0x7ffe1000>; /* boot ROM to 2 GiB */
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts b/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
index 8e2b0e75298a..14161c3f304d 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2017-2019 Andreas Färber
  *
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
@@ -12,9 +12,9 @@
 	compatible = "probox2,ava", "realtek,rtd1295";
 	model = "PROBOX2 AVA";
 
-	memory@0 {
+	memory@1f000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x1f000 0x7ffe1000>; /* boot ROM to 2 GiB */
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
index e98e508b9514..4beb37bb9522 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
@@ -11,9 +11,9 @@
 	compatible = "zidoo,x9s", "realtek,rtd1295";
 	model = "Zidoo X9S";
 
-	memory@0 {
+	memory@1f000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x1f000 0x7ffe1000>; /* boot ROM to 2 GiB */
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts b/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
index 5a051a52bf88..cc706d13da8b 100644
--- a/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
@@ -11,9 +11,9 @@
 	compatible = "synology,ds418", "realtek,rtd1296";
 	model = "Synology DiskStation DS418";
 
-	memory@0 {
+	memory@1f000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x1f000 0x7ffe1000>; /* boot ROM to 2 GiB */
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 5e755dda7abb..0de9e675be16 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -5,8 +5,8 @@
  * Copyright (c) 2016-2019 Andreas Färber
  */
 
-/memreserve/	0x0000000000000000 0x0000000000030000;
-/memreserve/	0x0000000000030000 0x00000000000d0000;
+/memreserve/	0x0000000000000000 0x000000000001f000;
+/memreserve/	0x000000000001f000 0x00000000000e1000;
 /memreserve/	0x0000000001b00000 0x00000000004be000;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -52,8 +52,9 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		/* Exclude up to 2 GiB of RAM */
-		ranges = <0x80000000 0x80000000 0x80000000>;
+		ranges = <0x00000000 0x00000000 0x0001f000>, /* boot ROM */
+			 /* Exclude up to 2 GiB of RAM */
+			 <0x80000000 0x80000000 0x80000000>;
 
 		rbus: bus@98000000 {
 			compatible = "simple-bus";
-- 
2.16.4

