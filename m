Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F69AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2CC20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406409AbfHIJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:33:46 -0400
Received: from shell.v3.sk ([90.176.6.54]:52052 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406334AbfHIJdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:33:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 604C0D63BE;
        Fri,  9 Aug 2019 11:33:41 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TFE3FGQ-rvhL; Fri,  9 Aug 2019 11:33:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A2766D63C0;
        Fri,  9 Aug 2019 11:32:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GNjWBU_CdbXf; Fri,  9 Aug 2019 11:32:33 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E4165D63D5;
        Fri,  9 Aug 2019 11:32:25 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 19/19] ARM: dts: mmp3: Add MMP3 SoC dts file
Date:   Fri,  9 Aug 2019 11:31:58 +0200
Message-Id: <20190809093158.7969-20-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describes most of the hardware found on Marvell MMP3, aka PXA2128, aka
Armada 620. Missing bits are the LCD controller, HSIC controllers,
Audio and GPU. Will be completed once bindings and drivers settle.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 534 ++++++++++++++++++++++++++++++++++++
 1 file changed, 534 insertions(+)
 create mode 100644 arch/arm/boot/dts/mmp3.dtsi

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
new file mode 100644
index 0000000000000..5a6275257ebdd
--- /dev/null
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ *  Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <dt-bindings/clock/marvell,mmp2.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+
+	aliases {
+		serial0 =3D &uart1;
+		serial1 =3D &uart2;
+		serial2 =3D &uart3;
+		serial3 =3D &uart4;
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		enable-method =3D "marvell,mmp3-smp";
+
+		cpu@0 {
+			compatible =3D "marvell,pj4b";
+			device_type =3D "cpu";
+			next-level-cache =3D <&l2>;
+			reg =3D <0>;
+		};
+
+		cpu@1 {
+			compatible =3D "marvell,pj4b";
+			device_type =3D "cpu";
+			next-level-cache =3D <&l2>;
+			reg =3D <1>;
+		};
+	};
+
+	soc {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "simple-bus";
+		interrupt-parent =3D <&gic>;
+		ranges;
+
+		axi@d4200000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			reg =3D <0xd4200000 0x00200000>;
+			ranges;
+
+			interrupt-controller@d4282000 {
+				compatible =3D "marvell,mmp3-intc";
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0xd4282000 0x1000>,
+				      <0xd4284000 0x100>;
+				mrvl,intc-nr-irqs =3D <64>;
+			};
+
+			pmic_mux: interrupt-controller@d4282150 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x150 0x4>, <0x168 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <4>;
+			};
+
+			rtc_mux: interrupt-controller@d4282154 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x154 0x4>, <0x16c 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <2>;
+			};
+
+			hsi3_mux: interrupt-controller@d42821bc {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x1bc 0x4>, <0x1a4 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <3>;
+			};
+
+			gpu_mux: interrupt-controller@d42821c0 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x1c0 0x4>, <0x1a8 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <3>;
+			};
+
+			twsi_mux: interrupt-controller@d4282158 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x158 0x4>, <0x170 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <5>;
+			};
+
+			hsi2_mux: interrupt-controller@d42821c4 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x1c4 0x4>, <0x1ac 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <2>;
+			};
+
+			dxo_mux: interrupt-controller@d42821c8 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x1c8 0x4>, <0x1b0 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <2>;
+			};
+
+			misc1_mux: interrupt-controller@d428215c {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x15c 0x4>, <0x174 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <31>;
+			};
+
+			ci_mux: interrupt-controller@d42821cc {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x1cc 0x4>, <0x1b4 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <2>;
+			};
+
+			ssp_mux: interrupt-controller@d4282160 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x160 0x4>, <0x178 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <2>;
+			};
+
+			hsi1_mux: interrupt-controller@d4282184 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x184 0x4>, <0x17c 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <4>;
+			};
+
+			misc2_mux: interrupt-controller@d4282188 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x188 0x4>, <0x180 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <20>;
+			};
+
+			hsi0_mux: interrupt-controller@d42821d0 {
+				compatible =3D "mrvl,mmp2-mux-intc";
+				interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+				reg =3D <0x1d0 0x4>, <0x1b8 0x4>;
+				reg-names =3D "mux status", "mux mask";
+				mrvl,intc-nr-irqs =3D <5>;
+			};
+
+			usb_otg_phy0: usb-otg-phy@d4207000 {
+				compatible =3D "marvell,mmp3-usb-phy";
+				reg =3D <0xd4207000 0x40>;
+				#phy-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			usb_otg0: usb-otg@d4208000 {
+				compatible =3D "marvell,pxau2o-ehci";
+				reg =3D <0xd4208000 0x200>;
+				interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_USB>;
+				clock-names =3D "USBCLK";
+				phys =3D <&usb_otg_phy0>;
+				phy-names =3D "usb";
+				status =3D "disabled";
+			};
+
+			mmc1: mmc@d4280000 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4280000 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH0>;
+				clock-names =3D "io";
+				interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			mmc2: mmc@d4280800 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4280800 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH1>;
+				clock-names =3D "io";
+				interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			mmc3: mmc@d4281000 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4281000 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH2>;
+				clock-names =3D "io";
+				interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			mmc4: mmc@d4281800 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4281800 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH3>;
+				clock-names =3D "io";
+				interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			camera0: camera@d420a000 {
+				compatible =3D "marvell,mmp2-ccic";
+				reg =3D <0xd420a000 0x800>;
+				interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_CCIC0>;
+				clock-names =3D "axi";
+				#clock-cells =3D <0>;
+				clock-output-names =3D "mclk";
+				status =3D "disabled";
+			};
+
+			camera1: camera@d420a800 {
+				compatible =3D "marvell,mmp2-ccic";
+				reg =3D <0xd420a800 0x800>;
+				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_CCIC1>;
+				clock-names =3D "axi";
+				#clock-cells =3D <0>;
+				clock-output-names =3D "mclk";
+				status =3D "disabled";
+			};
+		};
+
+		apb@d4000000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			reg =3D <0xd4000000 0x00200000>;
+			ranges;
+
+			timer: timer@d4014000 {
+				compatible =3D "mrvl,mmp-timer";
+				reg =3D <0xd4014000 0x100>;
+				interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_TIMER>;
+			};
+
+			uart1: uart@d4030000 {
+				compatible =3D "mrvl,mmp-uart";
+				reg =3D <0xd4030000 0x1000>;
+				interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_UART0>;
+				resets =3D <&soc_clocks MMP2_CLK_UART0>;
+				reg-shift =3D <2>;
+				status =3D "disabled";
+			};
+
+			uart2: uart@d4017000 {
+				compatible =3D "mrvl,mmp-uart";
+				reg =3D <0xd4017000 0x1000>;
+				interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_UART1>;
+				resets =3D <&soc_clocks MMP2_CLK_UART1>;
+				reg-shift =3D <2>;
+				status =3D "disabled";
+			};
+
+			uart3: uart@d4018000 {
+				compatible =3D "mrvl,mmp-uart";
+				reg =3D <0xd4018000 0x1000>;
+				interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_UART2>;
+				resets =3D <&soc_clocks MMP2_CLK_UART2>;
+				reg-shift =3D <2>;
+				status =3D "disabled";
+			};
+
+			uart4: uart@d4016000 {
+				compatible =3D "mrvl,mmp-uart";
+				reg =3D <0xd4016000 0x1000>;
+				interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_UART3>;
+				resets =3D <&soc_clocks MMP2_CLK_UART3>;
+				reg-shift =3D <2>;
+				status =3D "disabled";
+			};
+
+			gpio: gpio@d4019000 {
+				compatible =3D "marvell,mmp2-gpio";
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				reg =3D <0xd4019000 0x1000>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names =3D "gpio_mux";
+				clocks =3D <&soc_clocks MMP2_CLK_GPIO>;
+				resets =3D <&soc_clocks MMP2_CLK_GPIO>;
+				interrupt-controller;
+				#interrupt-cells =3D <2>;
+				ranges;
+
+				gcb0: gpio@d4019000 {
+					reg =3D <0xd4019000 0x4>;
+				};
+
+				gcb1: gpio@d4019004 {
+					reg =3D <0xd4019004 0x4>;
+				};
+
+				gcb2: gpio@d4019008 {
+					reg =3D <0xd4019008 0x4>;
+				};
+
+				gcb3: gpio@d4019100 {
+					reg =3D <0xd4019100 0x4>;
+				};
+
+				gcb4: gpio@d4019104 {
+					reg =3D <0xd4019104 0x4>;
+				};
+
+				gcb5: gpio@d4019108 {
+					reg =3D <0xd4019108 0x4>;
+				};
+			};
+
+			twsi1: i2c@d4011000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4011000 0x1000>;
+				interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI0>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI0>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				mrvl,i2c-fast-mode;
+				status =3D "disabled";
+			};
+
+			twsi2: i2c@d4031000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4031000 0x1000>;
+				interrupt-parent =3D <&twsi_mux>;
+				interrupts =3D <0>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI1>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI1>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			twsi3: i2c@d4032000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4032000 0x1000>;
+				interrupt-parent =3D <&twsi_mux>;
+				interrupts =3D <1>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI2>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI2>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			twsi4: i2c@d4033000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4033000 0x1000>;
+				interrupt-parent =3D <&twsi_mux>;
+				interrupts =3D <2>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI3>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI3>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+
+			twsi5: i2c@d4033800 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4033800 0x1000>;
+				interrupt-parent =3D <&twsi_mux>;
+				interrupts =3D <3>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI4>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI4>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			twsi6: i2c@d4034000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4034000 0x1000>;
+				interrupt-parent =3D <&twsi_mux>;
+				interrupts =3D <4>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI5>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI5>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			rtc: rtc@d4010000 {
+				compatible =3D "mrvl,mmp-rtc";
+				reg =3D <0xd4010000 0x1000>;
+				interrupts =3D <1 0>;
+				interrupt-names =3D "rtc 1Hz", "rtc alarm";
+				interrupt-parent =3D <&rtc_mux>;
+				clocks =3D <&soc_clocks MMP2_CLK_RTC>;
+				resets =3D <&soc_clocks MMP2_CLK_RTC>;
+				status =3D "disabled";
+			};
+
+			ssp1: spi@d4035000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4035000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP0>;
+				interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			ssp2: spi@d4036000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4036000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP1>;
+				interrupts =3D <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			ssp3: spi@d4037000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4037000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP2>;
+				interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			ssp4: spi@d4039000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4039000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP3>;
+				interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+		};
+
+		l2: l2-cache-controller@d0020000 {
+			compatible =3D "marvell,tauros3-cache", "arm,pl310-cache";
+			reg =3D <0xd0020000 0x1000>;
+			cache-unified;
+			cache-level =3D <2>;
+		};
+
+		soc_clocks: clocks {
+			compatible =3D "marvell,mmp2-clock";
+			reg =3D <0xd4050000 0x1000>,
+			      <0xd4282800 0x400>,
+			      <0xd4015000 0x1000>;
+			reg-names =3D "mpmu", "apmu", "apbc";
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+			#power-domain-cells =3D <1>;
+		};
+
+		snoop-control-unit@e0000000 {
+			compatible =3D "arm,arm11mp-scu";
+			reg =3D <0xe0000000 0x100>;
+		};
+
+		gic: interrupt-controller@e0001000 {
+			compatible =3D "arm,arm11mp-gic";
+			interrupt-controller;
+			#interrupt-cells =3D <3>;
+			reg =3D <0xe0001000 0x1000>,
+			      <0xe0000100 0x100>;
+		};
+
+		local-timer@e0000600 {
+			compatible =3D "arm,arm11mp-twd-timer";
+			interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
+			reg =3D <0xe0000600 0x20>;
+		};
+
+		watchdog@2c000620 {
+			compatible =3D "arm,arm11mp-twd-wdt";
+			reg =3D <0xe0000620 0x20>;
+			interrupts =3D <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
+		};
+	};
+};
--=20
2.21.0

