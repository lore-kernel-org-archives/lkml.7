Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA2C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99AC2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLBK30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:29:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:57564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727430AbfLBK3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E18EB2B3;
        Mon,  2 Dec 2019 10:29:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 5/9] arm64: dts: realtek: rtd16xx: Carve out boot ROM from memory
Date:   Mon,  2 Dec 2019 11:29:06 +0100
Message-Id: <20191202102910.26916-6-afaerber@suse.de>
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

Update Mjolnir /memory node to exclude 0..0x2dfff from reg entry.
Add this region to /soc ranges instead.

Suggested-by: Rob Herring <robh@kernel.org>
Cc: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 TODO: Add Fixes header once RTD1619 has a stable -rc1 based commit hash.

 To be followed up by patch unshadowing more RAM from /soc 0x98000000..0xffffffff,
 once we know the higher RAM windows.
 
 v2: New
 
 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts | 5 +++--
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi        | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
index 44dd67e04335..90ed6681468f 100644
--- a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * Copyright (c) 2019 Realtek Semiconductor Corp.
+ * Copyright (c) 2019 Andreas Färber
  */
 
 /dts-v1/;
@@ -11,9 +12,9 @@
 	compatible = "realtek,mjolnir", "realtek,rtd1619";
 	model = "Realtek Mjolnir EVB";
 
-	memory@0 {
+	memory@2e000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x2e000 0x7ffd2000>; /* boot ROM to 2 GiB */
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
index c7bbf2c7bb7c..69cc0d941c8d 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -3,6 +3,7 @@
  * Realtek RTD16xx SoC family
  *
  * Copyright (c) 2019 Realtek Semiconductor Corp.
+ * Copyright (c) 2019 Andreas Färber
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -107,7 +108,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x98000000 0x98000000 0x68000000>;
+		ranges = <0x00000000 0x00000000 0x0002e000>, /* boot ROM */
+			 <0x98000000 0x98000000 0x68000000>;
 
 		rbus: bus@98000000 {
 			compatible = "simple-bus";
-- 
2.16.4

