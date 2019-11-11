Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B3C17444
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7C2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKDEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:04:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:54314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfKKDEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:04:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4830B150;
        Mon, 11 Nov 2019 03:04:49 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: realtek: rtd129x: Introduce r-bus
Date:   Mon, 11 Nov 2019 04:04:30 +0100
Message-Id: <20191111030434.29977-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191111030434.29977-1-afaerber@suse.de>
References: <20191111030434.29977-1-afaerber@suse.de>
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
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 136 ++++++++++++++++---------------
 1 file changed, 72 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 8d80cca945bc..c4533a2555aa 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -55,70 +55,78 @@
 		/* Exclude up to 2 GiB of RAM */
 		ranges = <0x80000000 0x80000000 0x80000000>;
 
-		reset1: reset-controller@98000000 {
-			compatible = "snps,dw-low-reset";
-			reg = <0x98000000 0x4>;
-			#reset-cells = <1>;
-		};
-
-		reset2: reset-controller@98000004 {
-			compatible = "snps,dw-low-reset";
-			reg = <0x98000004 0x4>;
-			#reset-cells = <1>;
-		};
-
-		reset3: reset-controller@98000008 {
-			compatible = "snps,dw-low-reset";
-			reg = <0x98000008 0x4>;
-			#reset-cells = <1>;
-		};
-
-		reset4: reset-controller@98000050 {
-			compatible = "snps,dw-low-reset";
-			reg = <0x98000050 0x4>;
-			#reset-cells = <1>;
-		};
-
-		iso_reset: reset-controller@98007088 {
-			compatible = "snps,dw-low-reset";
-			reg = <0x98007088 0x4>;
-			#reset-cells = <1>;
-		};
-
-		wdt: watchdog@98007680 {
-			compatible = "realtek,rtd1295-watchdog";
-			reg = <0x98007680 0x100>;
-			clocks = <&osc27M>;
-		};
-
-		uart0: serial@98007800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x98007800 0x400>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <27000000>;
-			resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
-			status = "disabled";
-		};
-
-		uart1: serial@9801b200 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x9801b200 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <432000000>;
-			resets = <&reset2 RTD1295_RSTN_UR1>;
-			status = "disabled";
-		};
-
-		uart2: serial@9801b400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x9801b400 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <432000000>;
-			resets = <&reset2 RTD1295_RSTN_UR2>;
-			status = "disabled";
+		rbus: r-bus@98000000 {
+			compatible = "simple-bus";
+			reg = <0x98000000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x98000000 0x100000>;
+
+			reset1: reset-controller@0 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset2: reset-controller@4 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x4 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset3: reset-controller@8 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x8 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset4: reset-controller@50 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x50 0x4>;
+				#reset-cells = <1>;
+			};
+
+			iso_reset: reset-controller@7088 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x7088 0x4>;
+				#reset-cells = <1>;
+			};
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
+				resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
+				status = "disabled";
+			};
+
+			uart1: serial@1b200 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x1b200 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <432000000>;
+				resets = <&reset2 RTD1295_RSTN_UR1>;
+				status = "disabled";
+			};
+
+			uart2: serial@1b400 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x1b400 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <432000000>;
+				resets = <&reset2 RTD1295_RSTN_UR2>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ff011000 {
-- 
2.16.4

