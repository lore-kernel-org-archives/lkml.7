Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6529DC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DB420855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfKQHVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 02:21:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfKQHVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:21:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5C95B25F;
        Sun, 17 Nov 2019 07:21:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 4/8] ARM: dts: rtd1195: Introduce r-bus
Date:   Sun, 17 Nov 2019 08:21:05 +0100
Message-Id: <20191117072109.20402-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191117072109.20402-1-afaerber@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Model Realtek's register bus in DT.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3: from RTD1395 v1
 * Fixed r-bus size from 0x100000 to 0x70000 in reg and ranges (James)
 * Renamed bus node from r-bus to bus (Rob)
 
 arch/arm/boot/dts/rtd1195.dtsi | 52 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index 4e3866fe8f6e..f5174f828a28 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -92,28 +92,36 @@
 		         <0x18100000 0x18100000 0x01000000>,
 		         <0x40000000 0x40000000 0xc0000000>;
 
-		wdt: watchdog@18007680 {
-			compatible = "realtek,rtd1295-watchdog";
-			reg = <0x18007680 0x100>;
-			clocks = <&osc27M>;
-		};
-
-		uart0: serial@18007800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x18007800 0x400>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <27000000>;
-			status = "disabled";
-		};
-
-		uart1: serial@1801b200 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x1801b200 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <27000000>;
-			status = "disabled";
+		rbus: bus@18000000 {
+			compatible = "simple-bus";
+			reg = <0x18000000 0x70000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x18000000 0x70000>;
+
+			wdt: watchdog@7680 {
+				compatible = "realtek,rtd1295-watchdog";
+				reg = <0x7680 0x100>;
+				clocks = <&osc27M>;
+			};
+
+			uart0: serial@7800 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x7800 0x400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <27000000>;
+				status = "disabled";
+			};
+
+			uart1: serial@1b200 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x1b200 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <27000000>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ff011000 {
-- 
2.16.4

