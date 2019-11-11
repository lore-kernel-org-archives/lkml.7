Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3412C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921B720842
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfKKDFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:05:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:54342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfKKDEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:04:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DFF5B157;
        Mon, 11 Nov 2019 03:04:50 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Date:   Mon, 11 Nov 2019 04:04:32 +0100
Message-Id: <20191111030434.29977-6-afaerber@suse.de>
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
 This could be squashed into the original RTD1195 patch.
 
 arch/arm/boot/dts/rtd1195.dtsi | 52 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index a8cc2d23e7ef..3439647ecf97 100644
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
+		rbus: r-bus@18000000 {
+			compatible = "simple-bus";
+			reg = <0x18000000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x18000000 0x100000>;
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

