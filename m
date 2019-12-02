Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7051C33C99
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AD020718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfLBSWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:22:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:35952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbfLBSWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14E9AAEC6;
        Mon,  2 Dec 2019 18:22:15 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 04/14] arm64: dts: realtek: rtd16xx: Introduce iso and misc syscon
Date:   Mon,  2 Dec 2019 19:21:54 +0100
Message-Id: <20191202182205.14629-5-afaerber@suse.de>
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

Group UART0 into an Isolation syscon mfd node.
Group UART1 and UART2 into a Miscellaneous syscon mfd node.

Cc: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 70 +++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
index 69cc0d941c8d..8f8f2b328cd1 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -118,34 +118,22 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x98000000 0x200000>;
 
-			uart0: serial0@7800 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0x7800 0x400>;
-				reg-shift = <2>;
+			iso: syscon@7000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x7000 0x1000>;
 				reg-io-width = <4>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency = <27000000>;
-				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x7000 0x1000>;
 			};
 
-			uart1: serial1@1b200 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0x1b200 0x400>;
-				reg-shift = <2>;
+			misc: syscon@1b000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1b000 0x1000>;
 				reg-io-width = <4>;
-				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency = <432000000>;
-				status = "disabled";
-			};
-
-			uart2: serial2@1b400 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0x1b400 0x400>;
-				reg-shift = <2>;
-				reg-io-width = <4>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency = <432000000>;
-				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1b000 0x1000>;
 			};
 		};
 
@@ -159,3 +147,37 @@
 		};
 	};
 };
+
+&iso {
+	uart0: serial0@800 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x800 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <27000000>;
+		status = "disabled";
+	};
+};
+
+&misc {
+	uart1: serial1@200 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x200 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+
+	uart2: serial2@400 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x400 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+};
-- 
2.16.4

