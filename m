Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2651C22316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfKSCTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:19:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:58010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbfKSCTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:19:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C6F1B328;
        Tue, 19 Nov 2019 02:19:23 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 3/8] arm64: dts: realtek: rtd129x: Add irq muxes and UART interrupts
Date:   Tue, 19 Nov 2019 03:19:12 +0100
Message-Id: <20191119021917.15917-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191119021917.15917-1-afaerber@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iso and misc IRQ mux DT nodes to RTD129x SoC family.

Update the UART DT nodes with interrupts from these muxes,
so that UART0 can be used without earlycon.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3 -> v4:
 * Rebased onto chip-info and r-bus
 * Dropped schema-violating second interrupts for UART1 and UART2
 
 v2 -> v3:
 * Added nodes to rtd129x.dtsi instead of rtd1295.dtsi
 * Adopted misc compatible string
 * Renamed node label from irq_mux to misc_irq_mux for clarity
 
 v1 -> v2:
 * Rebased
 
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 7d56c9f5d48a..188b4f256917 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -86,6 +86,14 @@
 				#reset-cells = <1>;
 			};
 
+			iso_irq_mux: interrupt-controller@7000 {
+				compatible = "realtek,rtd1295-iso-irq-mux";
+				reg = <0x7000 0x100>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
 			iso_reset: reset-controller@7088 {
 				compatible = "snps,dw-low-reset";
 				reg = <0x7088 0x4>;
@@ -105,6 +113,8 @@
 				reg-io-width = <4>;
 				clock-frequency = <27000000>;
 				resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
+				interrupt-parent = <&iso_irq_mux>;
+				interrupts = <2>;
 				status = "disabled";
 			};
 
@@ -115,6 +125,14 @@
 				      <0x171d8 0x4>;
 			};
 
+			misc_irq_mux: interrupt-controller@1b000 {
+				compatible = "realtek,rtd1295-misc-irq-mux";
+				reg = <0x1b000 0x100>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
 			uart1: serial@1b200 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x1b200 0x100>;
@@ -122,6 +140,8 @@
 				reg-io-width = <4>;
 				clock-frequency = <432000000>;
 				resets = <&reset2 RTD1295_RSTN_UR1>;
+				interrupt-parent = <&misc_irq_mux>;
+				interrupts = <3>;
 				status = "disabled";
 			};
 
@@ -132,6 +152,8 @@
 				reg-io-width = <4>;
 				clock-frequency = <432000000>;
 				resets = <&reset2 RTD1295_RSTN_UR2>;
+				interrupt-parent = <&misc_irq_mux>;
+				interrupts = <8>;
 				status = "disabled";
 			};
 		};
-- 
2.16.4

