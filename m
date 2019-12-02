Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45AD2071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfLBSXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:23:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:35906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbfLBSWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC072AE53;
        Mon,  2 Dec 2019 18:22:13 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 01/14] ARM: dts: rtd1195: Introduce iso and misc syscon
Date:   Mon,  2 Dec 2019 19:21:51 +0100
Message-Id: <20191202182205.14629-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202182205.14629-1-afaerber@suse.de>
References: <20191202182205.14629-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group watchdog and UART0 into an Isolation syscon mfd node.
Group UART1 into a Miscellaneous syscon mfd node.

Cc: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/rtd1195.dtsi | 58 +++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index a8f7b9caacba..a74f530dc439 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -100,28 +100,22 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x18000000 0x70000>;
 
-			wdt: watchdog@7680 {
-				compatible = "realtek,rtd1295-watchdog";
-				reg = <0x7680 0x100>;
-				clocks = <&osc27M>;
-			};
-
-			uart0: serial@7800 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0x7800 0x400>;
-				reg-shift = <2>;
+			iso: syscon@7000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x7000 0x1000>;
 				reg-io-width = <4>;
-				clock-frequency = <27000000>;
-				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x7000 0x1000>;
 			};
 
-			uart1: serial@1b200 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0x1b200 0x100>;
-				reg-shift = <2>;
+			misc: syscon@1b000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1b000 0x1000>;
 				reg-io-width = <4>;
-				clock-frequency = <27000000>;
-				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1b000 0x1000>;
 			};
 		};
 
@@ -137,3 +131,31 @@
 		};
 	};
 };
+
+&iso {
+	wdt: watchdog@680 {
+		compatible = "realtek,rtd1295-watchdog";
+		reg = <0x680 0x100>;
+		clocks = <&osc27M>;
+	};
+
+	uart0: serial@800 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x800 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <27000000>;
+		status = "disabled";
+	};
+};
+
+&misc {
+	uart1: serial@200 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x200 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <27000000>;
+		status = "disabled";
+	};
+};
-- 
2.16.4

