Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4532070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLBK3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:29:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfLBK3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 925BEB297;
        Mon,  2 Dec 2019 10:29:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/9] arm64: dts: realtek: rtd129x: Use reserved-memory for RPC regions
Date:   Mon,  2 Dec 2019 11:29:03 +0100
Message-Id: <20191202102910.26916-3-afaerber@suse.de>
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

Move /reserved-memory node from RTD1295 to RTD129x DT.
Convert RPC /memreserve/s into /reserved-memory nodes.

Fixes: 72a7786c0a0d ("ARM64: dts: Add Realtek RTD1295 and Zidoo X9S")
Fixes: f8b3436dad5c ("arm64: dts: realtek: Factor out common RTD129x parts")
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 * Added Fixes headers
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 13 +------------
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 34f6cc6f16fe..1402abe80ea1 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -2,7 +2,7 @@
 /*
  * Realtek RTD1295 SoC
  *
- * Copyright (c) 2016-2017 Andreas Färber
+ * Copyright (c) 2016-2019 Andreas Färber
  */
 
 #include "rtd129x.dtsi"
@@ -47,17 +47,6 @@
 		};
 	};
 
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		tee@10100000 {
-			reg = <0x10100000 0xf00000>;
-			no-map;
-		};
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 4433114476f5..8d80cca945bc 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -2,14 +2,12 @@
 /*
  * Realtek RTD1293/RTD1295/RTD1296 SoC
  *
- * Copyright (c) 2016-2017 Andreas Färber
+ * Copyright (c) 2016-2019 Andreas Färber
  */
 
 /memreserve/	0x0000000000000000 0x0000000000030000;
-/memreserve/	0x000000000001f000 0x0000000000001000;
 /memreserve/	0x0000000000030000 0x00000000000d0000;
 /memreserve/	0x0000000001b00000 0x00000000004be000;
-/memreserve/	0x0000000001ffe000 0x0000000000004000;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/realtek,rtd1295.h>
@@ -19,6 +17,25 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rpc_comm: rpc@1f000 {
+			reg = <0x1f000 0x1000>;
+		};
+
+		rpc_ringbuf: rpc@1ffe000 {
+			reg = <0x1ffe000 0x4000>;
+		};
+
+		tee: tee@10100000 {
+			reg = <0x10100000 0xf00000>;
+			no-map;
+		};
+	};
+
 	arm_pmu: arm-pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.16.4

