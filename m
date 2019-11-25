Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24019C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FB22082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="AdTowmH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfKYM0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:26:54 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:8802 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKYM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574684802;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FE3YTNBZJw09OfFMruUyGjBqTQQASJnpNVVwMZ0e80Y=;
        b=AdTowmH/B/timyCGqphvSIQUW606Ilx8S3ljiG/lYRFKsnfLs/bmeRH82t49XeyCoL
        sj3zqohZZ3WXwV7FEY1CWGKITAN8w+4nTo9sWGXY4dRdn/sXOgR1PkQj2i8SBrCvLrvC
        76GY2ngtpNRb2dlxSDpjKYn8oVJ8cIB8lVAGiD5AK0CLHXwU1tMLiwdsgH45wwCQpBZX
        d8Gy02WJpyF2XQk4JZUheBUqpobvxt7OPhKF6yLofiMrgUKfl4KiW3p1u6nNyjgaUQGO
        Lgi3dM0YOyN+fcEurducipFtpZ9uyff7oc7OTBvo+VJyEqYX9eulwFXbrY9tZUALm+3w
        VrRQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPCQg0FO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 13:26:42 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/5] ARM: dts: ux500: Rename generic pin configs according to pin group
Date:   Mon, 25 Nov 2019 13:22:53 +0100
Message-Id: <20191125122256.53482-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125122256.53482-1-stephan@gerhold.net>
References: <20191125122256.53482-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some components (e.g. SDI, I2C) can be used with different pin assignments.
Before we can add the alternative configurations, we need to rename the
current configurations to more generic names.

Each pin configuration usually configures one specific pin group.
Therefore we rename the configurations to use the pin group as name.
Make up for the slightly longer names by removing the "_mode" suffix.

Rename all existing uses to use the new labels.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi | 58 ++++++++++-----------
 arch/arm/boot/dts/ste-href.dtsi           | 62 +++++++++++++----------
 arch/arm/boot/dts/ste-snowball.dts        | 52 +++++++++----------
 3 files changed, 90 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
index fbc41cacf690..b3ef91b98207 100644
--- a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
@@ -8,7 +8,7 @@
 &pinctrl {
 	/* Settings for all UART default and sleep states */
 	uart0 {
-		uart0_default_mode: uart0_default {
+		u0_a_1_default: u0_a_1_default {
 			default_mux {
 				function = "u0";
 				groups = "u0_a_1";
@@ -23,7 +23,7 @@
 			};
 		};
 
-		uart0_sleep_mode: uart0_sleep {
+		u0_a_1_sleep: u0_a_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -40,7 +40,7 @@
 	};
 
 	uart1 {
-		uart1_default_mode: uart1_default {
+		u1rxtx_a_1_default: u1rxtx_a_1_default {
 			default_mux {
 				function = "u1";
 				groups = "u1rxtx_a_1";
@@ -55,7 +55,7 @@
 			};
 		};
 
-		uart1_sleep_mode: uart1_sleep {
+		u1rxtx_a_1_sleep: u1rxtx_a_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO4_AH6"; /* RXD */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -68,7 +68,7 @@
 	};
 
 	uart2 {
-		uart2_default_mode: uart2_default {
+		u2rxtx_c_1_default: u2rxtx_c_1_default {
 			default_mux {
 				function = "u2";
 				groups = "u2rxtx_c_1";
@@ -83,7 +83,7 @@
 			};
 		};
 
-		uart2_sleep_mode: uart2_sleep {
+		u2rxtx_c_1_sleep: u2rxtx_c_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO29_W2"; /* RXD */
 				ste,config = <&in_wkup_pdis>;
@@ -97,7 +97,7 @@
 
 	/* Settings for all I2C default and sleep states */
 	i2c0 {
-		i2c0_default_mode: i2c_default {
+		i2c0_a_1_default: i2c0_a_1_default {
 			default_mux {
 				function = "i2c0";
 				groups = "i2c0_a_1";
@@ -108,7 +108,7 @@
 			};
 		};
 
-		i2c0_sleep_mode: i2c_sleep {
+		i2c0_a_1_sleep: i2c0_a_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -117,7 +117,7 @@
 	};
 
 	i2c1 {
-		i2c1_default_mode: i2c_default {
+		i2c1_b_2_default: i2c1_b_2_default {
 			default_mux {
 				function = "i2c1";
 				groups = "i2c1_b_2";
@@ -128,7 +128,7 @@
 			};
 		};
 
-		i2c1_sleep_mode: i2c_sleep {
+		i2c1_b_2_sleep: i2c1_b_2_sleep {
 			sleep_cfg1 {
 				pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -137,7 +137,7 @@
 	};
 
 	i2c2 {
-		i2c2_default_mode: i2c_default {
+		i2c2_b_2_default: i2c2_b_2_default {
 			default_mux {
 				function = "i2c2";
 				groups = "i2c2_b_2";
@@ -148,7 +148,7 @@
 			};
 		};
 
-		i2c2_sleep_mode: i2c_sleep {
+		i2c2_b_2_sleep: i2c2_b_2_sleep {
 			sleep_cfg1 {
 				pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -157,7 +157,7 @@
 	};
 
 	i2c3 {
-		i2c3_default_mode: i2c_default {
+		i2c3_c_2_default: i2c3_c_2_default {
 			default_mux {
 				function = "i2c3";
 				groups = "i2c3_c_2";
@@ -168,7 +168,7 @@
 			};
 		};
 
-		i2c3_sleep_mode: i2c_sleep {
+		i2c3_c_2_sleep: i2c3_c_2_sleep {
 			sleep_cfg1 {
 				pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -181,7 +181,7 @@
 	 * enable I2C4 and UART1 at the same time.
 	 */
 	i2c4 {
-		i2c4_default_mode: i2c_default {
+		i2c4_b_1_default: i2c4_b_1_default {
 			default_mux {
 				function = "i2c4";
 				groups = "i2c4_b_1";
@@ -192,7 +192,7 @@
 			};
 		};
 
-		i2c4_sleep_mode: i2c_sleep {
+		i2c4_b_1_sleep: i2c4_b_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
 				ste,config = <&slpm_in_wkup_pdis>;
@@ -203,7 +203,7 @@
 	/* Settings for all MMC/SD/SDIO default and sleep states */
 	sdi0 {
 		/* This is the external SD card slot, 4 bits wide */
-		sdi0_default_mode: sdi0_default {
+		mc0_a_1_default: mc0_a_1_default {
 			default_mux {
 				function = "mc0";
 				groups = "mc0_a_1";
@@ -234,7 +234,7 @@
 			};
 		};
 
-		sdi0_sleep_mode: sdi0_sleep {
+		mc0_a_1_sleep: mc0_a_1_sleep {
 			sleep_cfg1 {
 				pins =
 				"GPIO18_AC2", /* CMDDIR */
@@ -261,7 +261,7 @@
 
 	sdi1 {
 		/* This is the WLAN SDIO 4 bits wide */
-		sdi1_default_mode: sdi1_default {
+		mc1_a_1_default: mc1_a_1_default {
 			default_mux {
 				function = "mc1";
 				groups = "mc1_a_1";
@@ -285,7 +285,7 @@
 			};
 		};
 
-		sdi1_sleep_mode: sdi1_sleep {
+		mc1_a_1_sleep: mc1_a_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO208_AH16"; /* CLK */
 				ste,config = <&slpm_out_lo_wkup_pdis>;
@@ -305,7 +305,7 @@
 
 	sdi2 {
 		/* This is the eMMC 8 bits wide, usually PoP eMMC */
-		sdi2_default_mode: sdi2_default {
+		mc2_a_1_default: mc2_a_1_default {
 			default_mux {
 				function = "mc2";
 				groups = "mc2_a_1";
@@ -333,7 +333,7 @@
 			};
 		};
 
-		sdi2_sleep_mode: sdi2_sleep {
+		mc2_a_1_sleep: mc2_a_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO128_A5"; /* CLK */
 				ste,config = <&out_lo_wkup_pdis>;
@@ -361,7 +361,7 @@
 
 	sdi4 {
 		/* This is the eMMC 8 bits wide, usually PCB-mounted eMMC */
-		sdi4_default_mode: sdi4_default {
+		mc4_a_1_default: mc4_a_1_default {
 			default_mux {
 				function = "mc4";
 				groups = "mc4_a_1";
@@ -389,7 +389,7 @@
 			};
 		};
 
-		sdi4_sleep_mode: sdi4_sleep {
+		mc4_a_1_sleep: mc4_a_1_sleep {
 			sleep_cfg1 {
 				pins = "GPIO203_AE23"; /* CLK */
 				ste,config = <&out_lo_wkup_pdis>;
@@ -416,7 +416,7 @@
 	 * cannot be muxed onto any pins.
 	 */
 	msp0 {
-		msp0_default_mode: msp0_default {
+		msp0txrxtfstck_a_1_default: msp0txrxtfstck_a_1_default {
 			default_msp0_mux {
 				function = "msp0";
 				groups = "msp0txrx_a_1", "msp0tfstck_a_1";
@@ -433,7 +433,7 @@
 	};
 
 	msp1 {
-		msp1_default_mode: msp1_default {
+		msp1txrx_a_1_default: msp1txrx_a_1_default {
 			default_mux {
 				function = "msp1";
 				groups = "msp1txrx_a_1", "msp1_a_1";
@@ -453,7 +453,7 @@
 	};
 
 	msp2 {
-		msp2_default_mode: msp2_default {
+		msp2_a_1_default: msp2_a_1_default {
 			/* MSP2 usually used for HDMI audio */
 			default_mux {
 				function = "msp2";
@@ -474,7 +474,7 @@
 	};
 
 	musb {
-		musb_default_mode: musb_default {
+		usb_a_1_default: usb_a_1_default {
 			default_mux {
 				function = "usb";
 				groups = "usb_a_1";
@@ -500,7 +500,7 @@
 			};
 		};
 
-		musb_sleep_mode: musb_sleep {
+		usb_a_1_sleep: usb_a_1_sleep {
 			sleep_cfg1 {
 				pins =
 				"GPIO256_AF28", /* NXT */
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 4f6acbd8c040..7613a40421d5 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -16,41 +16,41 @@
 	soc {
 		uart@80120000 {
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart0_default_mode>;
-			pinctrl-1 = <&uart0_sleep_mode>;
+			pinctrl-0 = <&u0_a_1_default>;
+			pinctrl-1 = <&u0_a_1_sleep>;
 			status = "okay";
 		};
 
 		/* This UART is unused and thus left disabled */
 		uart@80121000 {
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart1_default_mode>;
-			pinctrl-1 = <&uart1_sleep_mode>;
+			pinctrl-0 = <&u1rxtx_a_1_default>;
+			pinctrl-1 = <&u1rxtx_a_1_sleep>;
 		};
 
 		uart@80007000 {
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart2_default_mode>;
-			pinctrl-1 = <&uart2_sleep_mode>;
+			pinctrl-0 = <&u2rxtx_c_1_default>;
+			pinctrl-1 = <&u2rxtx_c_1_sleep>;
 			status = "okay";
 		};
 
 		i2c@80004000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c0_default_mode>;
-			pinctrl-1 = <&i2c0_sleep_mode>;
+			pinctrl-0 = <&i2c0_a_1_default>;
+			pinctrl-1 = <&i2c0_a_1_sleep>;
 		};
 
 		i2c@80122000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c1_default_mode>;
-			pinctrl-1 = <&i2c1_sleep_mode>;
+			pinctrl-0 = <&i2c1_b_2_default>;
+			pinctrl-1 = <&i2c1_b_2_sleep>;
 		};
 
 		i2c@80128000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c2_default_mode>;
-			pinctrl-1 = <&i2c2_sleep_mode>;
+			pinctrl-0 = <&i2c2_b_2_default>;
+			pinctrl-1 = <&i2c2_b_2_sleep>;
 			lp5521@33 {
 				compatible = "national,lp5521";
 				reg = <0x33>;
@@ -96,8 +96,8 @@
 
 		i2c@80110000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c3_default_mode>;
-			pinctrl-1 = <&i2c3_sleep_mode>;
+			pinctrl-0 = <&i2c3_c_2_default>;
+			pinctrl-1 = <&i2c3_c_2_sleep>;
 		};
 
 		/* ST6G3244ME level translator for 1.8/2.9 V */
@@ -132,8 +132,8 @@
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi0_default_mode>;
-			pinctrl-1 = <&sdi0_sleep_mode>;
+			pinctrl-0 = <&mc0_a_1_default &sdi0_default_mode>;
+			pinctrl-1 = <&mc0_a_1_sleep>;
 
 			status = "okay";
 		};
@@ -145,8 +145,8 @@
 			bus-width = <4>;
 			non-removable;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi1_default_mode>;
-			pinctrl-1 = <&sdi1_sleep_mode>;
+			pinctrl-0 = <&mc1_a_1_default>;
+			pinctrl-1 = <&mc1_a_1_sleep>;
 
 			status = "okay";
 		};
@@ -160,8 +160,8 @@
 			non-removable;
 			vmmc-supply = <&db8500_vsmps2_reg>;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi2_default_mode>;
-			pinctrl-1 = <&sdi2_sleep_mode>;
+			pinctrl-0 = <&mc2_a_1_default>;
+			pinctrl-1 = <&mc2_a_1_sleep>;
 
 			status = "okay";
 		};
@@ -175,27 +175,27 @@
 			non-removable;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi4_default_mode>;
-			pinctrl-1 = <&sdi4_sleep_mode>;
+			pinctrl-0 = <&mc4_a_1_default>;
+			pinctrl-1 = <&mc4_a_1_sleep>;
 
 			status = "okay";
 		};
 
 		msp0: msp@80123000 {
 			pinctrl-names = "default";
-			pinctrl-0 = <&msp0_default_mode>;
+			pinctrl-0 = <&msp0txrxtfstck_a_1_default>;
 			status = "okay";
 		};
 
 		msp1: msp@80124000 {
 			pinctrl-names = "default";
-			pinctrl-0 = <&msp1_default_mode>;
+			pinctrl-0 = <&msp1txrx_a_1_default>;
 			status = "okay";
 		};
 
 		msp2: msp@80117000 {
 			pinctrl-names = "default";
-			pinctrl-0 = <&msp2_default_mode>;
+			pinctrl-0 = <&msp2_a_1_default>;
 		};
 
 		msp3: msp@80125000 {
@@ -209,8 +209,8 @@
 
 				ab8500_usb {
 					pinctrl-names = "default", "sleep";
-					pinctrl-0 = <&musb_default_mode>;
-					pinctrl-1 = <&musb_sleep_mode>;
+					pinctrl-0 = <&usb_a_1_default>;
+					pinctrl-1 = <&usb_a_1_sleep>;
 				};
 
 				ab8500-regulators {
@@ -257,6 +257,14 @@
 			};
 		};
 
+		pinctrl {
+			sdi0 {
+				sdi0_default_mode: sdi0_default {
+					/* Some boards set additional settings here */
+				};
+			};
+		};
+
 		mcde@a0350000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lcd_default_mode>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 566b35ac0d0c..8b80dcdf6e5b 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -156,19 +156,19 @@
 
 		msp0: msp@80123000 {
 			pinctrl-names = "default";
-			pinctrl-0 = <&msp0_default_mode>;
+			pinctrl-0 = <&msp0txrxtfstck_a_1_default>;
 			status = "okay";
 		};
 
 		msp1: msp@80124000 {
 			pinctrl-names = "default";
-			pinctrl-0 = <&msp1_default_mode>;
+			pinctrl-0 = <&msp1txrx_a_1_default>;
 			status = "okay";
 		};
 
 		msp2: msp@80117000 {
 			pinctrl-names = "default";
-			pinctrl-0 = <&msp2_default_mode>;
+			pinctrl-0 = <&msp2_a_1_default>;
 		};
 
 		msp3: msp@80125000 {
@@ -238,8 +238,8 @@
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi0_default_mode>;
-			pinctrl-1 = <&sdi0_sleep_mode>;
+			pinctrl-0 = <&mc0_a_1_default &sdi0_default_mode>;
+			pinctrl-1 = <&mc0_a_1_sleep>;
 
 			/* GPIO218 MMC_CD */
 			cd-gpios  = <&gpio6 26 GPIO_ACTIVE_LOW>;
@@ -253,8 +253,8 @@
 			max-frequency = <100000000>;
 			bus-width = <4>;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi1_default_mode>;
-			pinctrl-1 = <&sdi1_sleep_mode>;
+			pinctrl-0 = <&mc1_a_1_default>;
+			pinctrl-1 = <&mc1_a_1_sleep>;
 
 			status = "okay";
 		};
@@ -263,7 +263,7 @@
 		sdi2_per3@80005000 {
 			arm,primecell-periphid = <0x10480180>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&sdi2_sleep_mode>;
+			pinctrl-0 = <&mc2_a_1_sleep>;
 
 			status = "okay";
 		};
@@ -276,49 +276,49 @@
 			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdi4_default_mode>;
-			pinctrl-1 = <&sdi4_sleep_mode>;
+			pinctrl-0 = <&mc4_a_1_default>;
+			pinctrl-1 = <&mc4_a_1_sleep>;
 
 			status = "okay";
 		};
 
 		uart@80120000 {
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart0_default_mode>;
-			pinctrl-1 = <&uart0_sleep_mode>;
+			pinctrl-0 = <&u0_a_1_default>;
+			pinctrl-1 = <&u0_a_1_sleep>;
 			status = "okay";
 		};
 
 		/* This UART is unused and thus left disabled */
 		uart@80121000 {
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart1_default_mode>;
-			pinctrl-1 = <&uart1_sleep_mode>;
+			pinctrl-0 = <&u1rxtx_a_1_default>;
+			pinctrl-1 = <&u1rxtx_a_1_sleep>;
 		};
 
 		uart@80007000 {
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart2_default_mode>;
-			pinctrl-1 = <&uart2_sleep_mode>;
+			pinctrl-0 = <&u2rxtx_c_1_default>;
+			pinctrl-1 = <&u2rxtx_c_1_sleep>;
 			status = "okay";
 		};
 
 		i2c@80004000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c0_default_mode>;
-			pinctrl-1 = <&i2c0_sleep_mode>;
+			pinctrl-0 = <&i2c0_a_1_default>;
+			pinctrl-1 = <&i2c0_a_1_sleep>;
 		};
 
 		i2c@80122000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c1_default_mode>;
-			pinctrl-1 = <&i2c1_sleep_mode>;
+			pinctrl-0 = <&i2c1_b_2_default>;
+			pinctrl-1 = <&i2c1_b_2_sleep>;
 		};
 
 		i2c@80128000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c2_default_mode>;
-			pinctrl-1 = <&i2c2_sleep_mode>;
+			pinctrl-0 = <&i2c2_b_2_default>;
+			pinctrl-1 = <&i2c2_b_2_sleep>;
 			lsm303dlh@18 {
 				/* Accelerometer */
 				compatible = "st,lsm303dlh-accel";
@@ -367,8 +367,8 @@
 
 		i2c@80110000 {
 			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c3_default_mode>;
-			pinctrl-1 = <&i2c3_sleep_mode>;
+			pinctrl-0 = <&i2c3_c_2_default>;
+			pinctrl-1 = <&i2c3_c_2_sleep>;
 		};
 
 		spi@80002000 {
@@ -402,8 +402,8 @@
 
 				ab8500_usb {
 					pinctrl-names = "default", "sleep";
-					pinctrl-0 = <&musb_default_mode>;
-					pinctrl-1 = <&musb_sleep_mode>;
+					pinctrl-0 = <&usb_a_1_default>;
+					pinctrl-1 = <&usb_a_1_sleep>;
 				};
 
 				ext_regulators: ab8500-ext-regulators {
-- 
2.24.0

