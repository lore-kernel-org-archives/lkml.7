Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD892082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="iXU51xUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKYM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:26:48 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:13633 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574684802;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=niuhOuM+JdZl+szJXAmMZWQPgbpfEj8VKERS/Uxxhks=;
        b=iXU51xUFDHavqM+PiSUkmbyhqKdhKK4WjCdo/qYwr/WxE6YmUHqFhiHZNcTRUmEso5
        VO2ygNBQSCTO8uR65HkSs0ttu6Bq/h2ZUIXtzjGrRStXJUB+OQTpnI7pYvPegJJ/mO/d
        sdqDTBgU89wLdWvGfjghs5amg0sy3JwpFUn3oRD+QMbjr2KfhJkhrUribtEewaULqLiB
        vd/U1cVt/dLfJJjJOuo5zelsC0PbLIjjygLF4WP8Ab4lY+JtGbezV82YG6bVqfaFSy6V
        DL0WAM2rRiAYq6tGYZNDaBqO1prsC+6iKl/o8yOwDQ33ZPiWG90QSFS7HOkijrece+v4
        7EhA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPCQf0FN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 13:26:41 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/5] ARM: dts: ux500: Move generic pin configs out of ste-href-family-pinctrl.dtsi
Date:   Mon, 25 Nov 2019 13:22:52 +0100
Message-Id: <20191125122256.53482-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All existing Ux500 boards make use of ste-href-family-pinctrl.dtsi,
which contains shared pin configurations for UART, I2C and SDI.
Most of these can be also used for devices not based on HREF.

Move the generic pin configs into a new device tree include
"ste-dbx5x0-pinctrl.dtsi". There is no functional change (yet),
as a next step we will rename the pin configs to use more generic
names.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi     | 529 +++++++++++++++++
 .../arm/boot/dts/ste-href-family-pinctrl.dtsi | 532 +-----------------
 2 files changed, 530 insertions(+), 531 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
new file mode 100644
index 000000000000..fbc41cacf690
--- /dev/null
+++ b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Linaro Ltd.
+ */
+
+#include "ste-nomadik-pinctrl.dtsi"
+
+&pinctrl {
+	/* Settings for all UART default and sleep states */
+	uart0 {
+		uart0_default_mode: uart0_default {
+			default_mux {
+				function = "u0";
+				groups = "u0_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
+				ste,config = <&in_pu>;
+			};
+			default_cfg2 {
+				pins = "GPIO1_AJ3", "GPIO3_AH3"; /* RTS+TXD */
+				ste,config = <&out_hi>;
+			};
+		};
+
+		uart0_sleep_mode: uart0_sleep {
+			sleep_cfg1 {
+				pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins = "GPIO1_AJ3"; /* RTS */
+				ste,config = <&slpm_out_hi_wkup_pdis>;
+			};
+			sleep_cfg3 {
+				pins = "GPIO3_AH3"; /* TXD */
+				ste,config = <&slpm_out_wkup_pdis>;
+			};
+		};
+	};
+
+	uart1 {
+		uart1_default_mode: uart1_default {
+			default_mux {
+				function = "u1";
+				groups = "u1rxtx_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO4_AH6"; /* RXD */
+				ste,config = <&in_pu>;
+			};
+			default_cfg2 {
+				pins = "GPIO5_AG6"; /* TXD */
+				ste,config = <&out_hi>;
+			};
+		};
+
+		uart1_sleep_mode: uart1_sleep {
+			sleep_cfg1 {
+				pins = "GPIO4_AH6"; /* RXD */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins = "GPIO5_AG6"; /* TXD */
+				ste,config = <&slpm_out_wkup_pdis>;
+			};
+		};
+	};
+
+	uart2 {
+		uart2_default_mode: uart2_default {
+			default_mux {
+				function = "u2";
+				groups = "u2rxtx_c_1";
+			};
+			default_cfg1 {
+				pins = "GPIO29_W2"; /* RXD */
+				ste,config = <&in_pu>;
+			};
+			default_cfg2 {
+				pins = "GPIO30_W3"; /* TXD */
+				ste,config = <&out_hi>;
+			};
+		};
+
+		uart2_sleep_mode: uart2_sleep {
+			sleep_cfg1 {
+				pins = "GPIO29_W2"; /* RXD */
+				ste,config = <&in_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins = "GPIO30_W3"; /* TXD */
+				ste,config = <&out_wkup_pdis>;
+			};
+		};
+	};
+
+	/* Settings for all I2C default and sleep states */
+	i2c0 {
+		i2c0_default_mode: i2c_default {
+			default_mux {
+				function = "i2c0";
+				groups = "i2c0_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		i2c0_sleep_mode: i2c_sleep {
+			sleep_cfg1 {
+				pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	i2c1 {
+		i2c1_default_mode: i2c_default {
+			default_mux {
+				function = "i2c1";
+				groups = "i2c1_b_2";
+			};
+			default_cfg1 {
+				pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		i2c1_sleep_mode: i2c_sleep {
+			sleep_cfg1 {
+				pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	i2c2 {
+		i2c2_default_mode: i2c_default {
+			default_mux {
+				function = "i2c2";
+				groups = "i2c2_b_2";
+			};
+			default_cfg1 {
+				pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		i2c2_sleep_mode: i2c_sleep {
+			sleep_cfg1 {
+				pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	i2c3 {
+		i2c3_default_mode: i2c_default {
+			default_mux {
+				function = "i2c3";
+				groups = "i2c3_c_2";
+			};
+			default_cfg1 {
+				pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		i2c3_sleep_mode: i2c_sleep {
+			sleep_cfg1 {
+				pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	/*
+	 * Activating I2C4 will conflict with UART1 about the same pins so do not
+	 * enable I2C4 and UART1 at the same time.
+	 */
+	i2c4 {
+		i2c4_default_mode: i2c_default {
+			default_mux {
+				function = "i2c4";
+				groups = "i2c4_b_1";
+			};
+			default_cfg1 {
+				pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		i2c4_sleep_mode: i2c_sleep {
+			sleep_cfg1 {
+				pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	/* Settings for all MMC/SD/SDIO default and sleep states */
+	sdi0 {
+		/* This is the external SD card slot, 4 bits wide */
+		sdi0_default_mode: sdi0_default {
+			default_mux {
+				function = "mc0";
+				groups = "mc0_a_1";
+			};
+			default_cfg1 {
+				pins =
+				"GPIO18_AC2", /* CMDDIR */
+				"GPIO19_AC1", /* DAT0DIR */
+				"GPIO20_AB4"; /* DAT2DIR */
+				ste,config = <&out_hi>;
+			};
+			default_cfg2 {
+				pins = "GPIO22_AA3"; /* FBCLK */
+				ste,config = <&in_nopull>;
+			};
+			default_cfg3 {
+				pins = "GPIO23_AA4"; /* CLK */
+				ste,config = <&out_lo>;
+			};
+			default_cfg4 {
+				pins =
+				"GPIO24_AB2", /* CMD */
+				"GPIO25_Y4", /* DAT0 */
+				"GPIO26_Y2", /* DAT1 */
+				"GPIO27_AA2", /* DAT2 */
+				"GPIO28_AA1"; /* DAT3 */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		sdi0_sleep_mode: sdi0_sleep {
+			sleep_cfg1 {
+				pins =
+				"GPIO18_AC2", /* CMDDIR */
+				"GPIO19_AC1", /* DAT0DIR */
+				"GPIO20_AB4"; /* DAT2DIR */
+				ste,config = <&slpm_out_hi_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins =
+				"GPIO22_AA3", /* FBCLK */
+				"GPIO24_AB2", /* CMD */
+				"GPIO25_Y4", /* DAT0 */
+				"GPIO26_Y2", /* DAT1 */
+				"GPIO27_AA2", /* DAT2 */
+				"GPIO28_AA1"; /* DAT3 */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+			sleep_cfg3 {
+				pins = "GPIO23_AA4"; /* CLK */
+				ste,config = <&slpm_out_lo_wkup_pdis>;
+			};
+		};
+	};
+
+	sdi1 {
+		/* This is the WLAN SDIO 4 bits wide */
+		sdi1_default_mode: sdi1_default {
+			default_mux {
+				function = "mc1";
+				groups = "mc1_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO208_AH16"; /* CLK */
+				ste,config = <&out_lo>;
+			};
+			default_cfg2 {
+				pins = "GPIO209_AG15"; /* FBCLK */
+				ste,config = <&in_nopull>;
+			};
+			default_cfg3 {
+				pins =
+				"GPIO210_AJ15", /* CMD */
+				"GPIO211_AG14", /* DAT0 */
+				"GPIO212_AF13", /* DAT1 */
+				"GPIO213_AG13", /* DAT2 */
+				"GPIO214_AH15"; /* DAT3 */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		sdi1_sleep_mode: sdi1_sleep {
+			sleep_cfg1 {
+				pins = "GPIO208_AH16"; /* CLK */
+				ste,config = <&slpm_out_lo_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins =
+				"GPIO209_AG15", /* FBCLK */
+				"GPIO210_AJ15", /* CMD */
+				"GPIO211_AG14", /* DAT0 */
+				"GPIO212_AF13", /* DAT1 */
+				"GPIO213_AG13", /* DAT2 */
+				"GPIO214_AH15"; /* DAT3 */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	sdi2 {
+		/* This is the eMMC 8 bits wide, usually PoP eMMC */
+		sdi2_default_mode: sdi2_default {
+			default_mux {
+				function = "mc2";
+				groups = "mc2_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO128_A5"; /* CLK */
+				ste,config = <&out_lo>;
+			};
+			default_cfg2 {
+				pins = "GPIO130_C8"; /* FBCLK */
+				ste,config = <&in_nopull>;
+			};
+			default_cfg3 {
+				pins =
+				"GPIO129_B4", /* CMD */
+				"GPIO131_A12", /* DAT0 */
+				"GPIO132_C10", /* DAT1 */
+				"GPIO133_B10", /* DAT2 */
+				"GPIO134_B9", /* DAT3 */
+				"GPIO135_A9", /* DAT4 */
+				"GPIO136_C7", /* DAT5 */
+				"GPIO137_A7", /* DAT6 */
+				"GPIO138_C5"; /* DAT7 */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		sdi2_sleep_mode: sdi2_sleep {
+			sleep_cfg1 {
+				pins = "GPIO128_A5"; /* CLK */
+				ste,config = <&out_lo_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins =
+				"GPIO130_C8", /* FBCLK */
+				"GPIO129_B4"; /* CMD */
+				ste,config = <&in_wkup_pdis_en>;
+			};
+			sleep_cfg3 {
+				pins =
+				"GPIO131_A12", /* DAT0 */
+				"GPIO132_C10", /* DAT1 */
+				"GPIO133_B10", /* DAT2 */
+				"GPIO134_B9", /* DAT3 */
+				"GPIO135_A9", /* DAT4 */
+				"GPIO136_C7", /* DAT5 */
+				"GPIO137_A7", /* DAT6 */
+				"GPIO138_C5"; /* DAT7 */
+				ste,config = <&in_wkup_pdis>;
+			};
+		};
+	};
+
+	sdi4 {
+		/* This is the eMMC 8 bits wide, usually PCB-mounted eMMC */
+		sdi4_default_mode: sdi4_default {
+			default_mux {
+				function = "mc4";
+				groups = "mc4_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO203_AE23"; /* CLK */
+				ste,config = <&out_lo>;
+			};
+			default_cfg2 {
+				pins = "GPIO202_AF25"; /* FBCLK */
+				ste,config = <&in_nopull>;
+			};
+			default_cfg3 {
+				pins =
+				"GPIO201_AF24", /* CMD */
+				"GPIO200_AH26", /* DAT0 */
+				"GPIO199_AH23", /* DAT1 */
+				"GPIO198_AG25", /* DAT2 */
+				"GPIO197_AH24", /* DAT3 */
+				"GPIO207_AJ23", /* DAT4 */
+				"GPIO206_AG24", /* DAT5 */
+				"GPIO205_AG23", /* DAT6 */
+				"GPIO204_AF23"; /* DAT7 */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		sdi4_sleep_mode: sdi4_sleep {
+			sleep_cfg1 {
+				pins = "GPIO203_AE23"; /* CLK */
+				ste,config = <&out_lo_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins =
+				"GPIO202_AF25", /* FBCLK */
+				"GPIO201_AF24", /* CMD */
+				"GPIO200_AH26", /* DAT0 */
+				"GPIO199_AH23", /* DAT1 */
+				"GPIO198_AG25", /* DAT2 */
+				"GPIO197_AH24", /* DAT3 */
+				"GPIO207_AJ23", /* DAT4 */
+				"GPIO206_AG24", /* DAT5 */
+				"GPIO205_AG23", /* DAT6 */
+				"GPIO204_AF23"; /* DAT7 */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
+	};
+
+	/*
+	 * Multi-rate serial ports (MSPs) - MSP3 output is internal and
+	 * cannot be muxed onto any pins.
+	 */
+	msp0 {
+		msp0_default_mode: msp0_default {
+			default_msp0_mux {
+				function = "msp0";
+				groups = "msp0txrx_a_1", "msp0tfstck_a_1";
+			};
+			default_msp0_cfg {
+				pins =
+				"GPIO12_AC4", /* TXD */
+				"GPIO15_AC3", /* RXD */
+				"GPIO13_AF3", /* TFS */
+				"GPIO14_AE3"; /* TCK */
+				ste,config = <&in_nopull>;
+			};
+		};
+	};
+
+	msp1 {
+		msp1_default_mode: msp1_default {
+			default_mux {
+				function = "msp1";
+				groups = "msp1txrx_a_1", "msp1_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO33_AF2";
+				ste,config = <&out_lo>;
+			};
+			default_cfg2 {
+				pins =
+				"GPIO34_AE1",
+				"GPIO35_AE2",
+				"GPIO36_AG2";
+				ste,config = <&in_nopull>;
+			};
+		};
+	};
+
+	msp2 {
+		msp2_default_mode: msp2_default {
+			/* MSP2 usually used for HDMI audio */
+			default_mux {
+				function = "msp2";
+				groups = "msp2_a_1";
+			};
+			default_cfg1 {
+				pins =
+				"GPIO193_AH27", /* TXD */
+				"GPIO194_AF27", /* TCK */
+				"GPIO195_AG28"; /* TFS */
+				ste,config = <&in_pd>;
+			};
+			default_cfg2 {
+				pins = "GPIO196_AG26"; /* RXD */
+				ste,config = <&out_lo>;
+			};
+		};
+	};
+
+	musb {
+		musb_default_mode: musb_default {
+			default_mux {
+				function = "usb";
+				groups = "usb_a_1";
+			};
+			default_cfg1 {
+				pins =
+				"GPIO256_AF28", /* NXT */
+				"GPIO258_AD29", /* XCLK */
+				"GPIO259_AC29", /* DIR */
+				"GPIO260_AD28", /* DAT7 */
+				"GPIO261_AD26", /* DAT6 */
+				"GPIO262_AE26", /* DAT5 */
+				"GPIO263_AG29", /* DAT4 */
+				"GPIO264_AE27", /* DAT3 */
+				"GPIO265_AD27", /* DAT2 */
+				"GPIO266_AC28", /* DAT1 */
+				"GPIO267_AC27"; /* DAT0 */
+				ste,config = <&in_nopull>;
+			};
+			default_cfg2 {
+				pins = "GPIO257_AE29"; /* STP */
+				ste,config = <&out_hi>;
+			};
+		};
+
+		musb_sleep_mode: musb_sleep {
+			sleep_cfg1 {
+				pins =
+				"GPIO256_AF28", /* NXT */
+				"GPIO258_AD29", /* XCLK */
+				"GPIO259_AC29"; /* DIR */
+				ste,config = <&slpm_wkup_pdis_en>;
+			};
+			sleep_cfg2 {
+				pins = "GPIO257_AE29"; /* STP */
+				ste,config = <&slpm_out_hi_wkup_pdis>;
+			};
+			sleep_cfg3 {
+				pins =
+				"GPIO260_AD28", /* DAT7 */
+				"GPIO261_AD26", /* DAT6 */
+				"GPIO262_AE26", /* DAT5 */
+				"GPIO263_AG29", /* DAT4 */
+				"GPIO264_AE27", /* DAT3 */
+				"GPIO265_AD27", /* DAT2 */
+				"GPIO266_AC28", /* DAT1 */
+				"GPIO267_AC27"; /* DAT0 */
+				ste,config = <&slpm_in_wkup_pdis_en>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 2c382d274ff6..434fa6baf71f 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -3,212 +3,11 @@
  * Copyright 2013 Linaro Ltd.
  */
 
-#include "ste-nomadik-pinctrl.dtsi"
+#include "ste-dbx5x0-pinctrl.dtsi"
 
 / {
 	soc {
 		pinctrl {
-			/* Settings for all UART default and sleep states */
-			uart0 {
-				uart0_default_mode: uart0_default {
-					default_mux {
-						function = "u0";
-						groups = "u0_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						pins = "GPIO1_AJ3", "GPIO3_AH3"; /* RTS+TXD */
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart0_sleep_mode: uart0_sleep {
-					sleep_cfg1 {
-						pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-
-					sleep_cfg2 {
-						pins = "GPIO1_AJ3"; /* RTS */
-						ste,config = <&slpm_out_hi_wkup_pdis>;
-					};
-
-					sleep_cfg3 {
-						pins = "GPIO3_AH3"; /* TXD */
-						ste,config = <&slpm_out_wkup_pdis>;
-					};
-				};
-			};
-
-			uart1 {
-				uart1_default_mode: uart1_default {
-					default_mux {
-						function = "u1";
-						groups = "u1rxtx_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO4_AH6"; /* RXD */
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						pins = "GPIO5_AG6"; /* TXD */
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart1_sleep_mode: uart1_sleep {
-					sleep_cfg1 {
-						pins = "GPIO4_AH6"; /* RXD */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-
-					sleep_cfg2 {
-						pins = "GPIO5_AG6"; /* TXD */
-						ste,config = <&slpm_out_wkup_pdis>;
-					};
-				};
-			};
-
-			uart2 {
-				uart2_default_mode: uart2_default {
-					default_mux {
-						function = "u2";
-						groups = "u2rxtx_c_1";
-					};
-					default_cfg1 {
-						pins = "GPIO29_W2"; /* RXD */
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						pins = "GPIO30_W3"; /* TXD */
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart2_sleep_mode: uart2_sleep {
-					sleep_cfg1 {
-						pins = "GPIO29_W2"; /* RXD */
-						ste,config = <&in_wkup_pdis>;
-					};
-
-					sleep_cfg2 {
-						pins = "GPIO30_W3"; /* TXD */
-						ste,config = <&out_wkup_pdis>;
-					};
-				};
-			};
-
-			/* Settings for all I2C default and sleep states */
-			i2c0 {
-				i2c0_default_mode: i2c_default {
-					default_mux {
-						function = "i2c0";
-						groups = "i2c0_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c0_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
-			i2c1 {
-				i2c1_default_mode: i2c_default {
-					default_mux {
-						function = "i2c1";
-						groups = "i2c1_b_2";
-					};
-					default_cfg1 {
-						pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c1_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
-			i2c2 {
-				i2c2_default_mode: i2c_default {
-					default_mux {
-						function = "i2c2";
-						groups = "i2c2_b_2";
-					};
-					default_cfg1 {
-						pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c2_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
-			i2c3 {
-				i2c3_default_mode: i2c_default {
-					default_mux {
-						function = "i2c3";
-						groups = "i2c3_c_2";
-					};
-					default_cfg1 {
-						pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c3_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
-			/*
-			 * Activating I2C4 will conflict with UART1 about the same pins so do not
-			 * enable I2C4 and UART1 at the same time.
-			 */
-			i2c4 {
-				i2c4_default_mode: i2c_default {
-					default_mux {
-						function = "i2c4";
-						groups = "i2c4_b_1";
-					};
-					default_cfg1 {
-						pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c4_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
 			/* Settings for all SPI default and sleep states */
 			spi2 {
 				spi2_default_mode: spi_default {
@@ -270,335 +69,6 @@
 				};
 			};
 
-			/* Settings for all MMC/SD/SDIO default and sleep states */
-			sdi0 {
-				/* This is the external SD card slot, 4 bits wide */
-				sdi0_default_mode: sdi0_default {
-					default_mux {
-						function = "mc0";
-						groups = "mc0_a_1";
-					};
-					default_cfg1 {
-						pins =
-						"GPIO18_AC2", /* CMDDIR */
-						"GPIO19_AC1", /* DAT0DIR */
-						"GPIO20_AB4"; /* DAT2DIR */
-						ste,config = <&out_hi>;
-					};
-					default_cfg2 {
-						pins = "GPIO22_AA3"; /* FBCLK */
-						ste,config = <&in_nopull>;
-					};
-					default_cfg3 {
-						pins = "GPIO23_AA4"; /* CLK */
-						ste,config = <&out_lo>;
-					};
-					default_cfg4 {
-						pins =
-						"GPIO24_AB2", /* CMD */
-						"GPIO25_Y4", /* DAT0 */
-						"GPIO26_Y2", /* DAT1 */
-						"GPIO27_AA2", /* DAT2 */
-						"GPIO28_AA1"; /* DAT3 */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				sdi0_sleep_mode: sdi0_sleep {
-					sleep_cfg1 {
-						pins =
-						"GPIO18_AC2", /* CMDDIR */
-						"GPIO19_AC1", /* DAT0DIR */
-						"GPIO20_AB4"; /* DAT2DIR */
-						ste,config = <&slpm_out_hi_wkup_pdis>;
-					};
-					sleep_cfg2 {
-						pins =
-						"GPIO22_AA3", /* FBCLK */
-						"GPIO24_AB2", /* CMD */
-						"GPIO25_Y4", /* DAT0 */
-						"GPIO26_Y2", /* DAT1 */
-						"GPIO27_AA2", /* DAT2 */
-						"GPIO28_AA1"; /* DAT3 */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-					sleep_cfg3 {
-						pins = "GPIO23_AA4"; /* CLK */
-						ste,config = <&slpm_out_lo_wkup_pdis>;
-					};
-				};
-			};
-
-			sdi1 {
-				/* This is the WLAN SDIO 4 bits wide */
-				sdi1_default_mode: sdi1_default {
-					default_mux {
-						function = "mc1";
-						groups = "mc1_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO208_AH16"; /* CLK */
-						ste,config = <&out_lo>;
-					};
-					default_cfg2 {
-						pins = "GPIO209_AG15"; /* FBCLK */
-						ste,config = <&in_nopull>;
-					};
-					default_cfg3 {
-						pins =
-						"GPIO210_AJ15", /* CMD */
-						"GPIO211_AG14", /* DAT0 */
-						"GPIO212_AF13", /* DAT1 */
-						"GPIO213_AG13", /* DAT2 */
-						"GPIO214_AH15"; /* DAT3 */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				sdi1_sleep_mode: sdi1_sleep {
-					sleep_cfg1 {
-						pins = "GPIO208_AH16"; /* CLK */
-						ste,config = <&slpm_out_lo_wkup_pdis>;
-					};
-					sleep_cfg2 {
-						pins =
-						"GPIO209_AG15", /* FBCLK */
-						"GPIO210_AJ15", /* CMD */
-						"GPIO211_AG14", /* DAT0 */
-						"GPIO212_AF13", /* DAT1 */
-						"GPIO213_AG13", /* DAT2 */
-						"GPIO214_AH15"; /* DAT3 */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
-			sdi2 {
-				/* This is the eMMC 8 bits wide, usually PoP eMMC */
-				sdi2_default_mode: sdi2_default {
-					default_mux {
-						function = "mc2";
-						groups = "mc2_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO128_A5"; /* CLK */
-						ste,config = <&out_lo>;
-					};
-					default_cfg2 {
-						pins = "GPIO130_C8"; /* FBCLK */
-						ste,config = <&in_nopull>;
-					};
-					default_cfg3 {
-						pins =
-						"GPIO129_B4", /* CMD */
-						"GPIO131_A12", /* DAT0 */
-						"GPIO132_C10", /* DAT1 */
-						"GPIO133_B10", /* DAT2 */
-						"GPIO134_B9", /* DAT3 */
-						"GPIO135_A9", /* DAT4 */
-						"GPIO136_C7", /* DAT5 */
-						"GPIO137_A7", /* DAT6 */
-						"GPIO138_C5"; /* DAT7 */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				sdi2_sleep_mode: sdi2_sleep {
-					sleep_cfg1 {
-						pins = "GPIO128_A5"; /* CLK */
-						ste,config = <&out_lo_wkup_pdis>;
-					};
-					sleep_cfg2 {
-						pins =
-						"GPIO130_C8", /* FBCLK */
-						"GPIO129_B4"; /* CMD */
-						ste,config = <&in_wkup_pdis_en>;
-					};
-					sleep_cfg3 {
-						pins =
-						"GPIO131_A12", /* DAT0 */
-						"GPIO132_C10", /* DAT1 */
-						"GPIO133_B10", /* DAT2 */
-						"GPIO134_B9", /* DAT3 */
-						"GPIO135_A9", /* DAT4 */
-						"GPIO136_C7", /* DAT5 */
-						"GPIO137_A7", /* DAT6 */
-						"GPIO138_C5"; /* DAT7 */
-						ste,config = <&in_wkup_pdis>;
-					};
-				};
-			};
-
-			sdi4 {
-				/* This is the eMMC 8 bits wide, usually PCB-mounted eMMC */
-				sdi4_default_mode: sdi4_default {
-					default_mux {
-						function = "mc4";
-						groups = "mc4_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO203_AE23"; /* CLK */
-						ste,config = <&out_lo>;
-					};
-					default_cfg2 {
-						pins = "GPIO202_AF25"; /* FBCLK */
-						ste,config = <&in_nopull>;
-					};
-					default_cfg3 {
-						pins =
-						"GPIO201_AF24", /* CMD */
-						"GPIO200_AH26", /* DAT0 */
-						"GPIO199_AH23", /* DAT1 */
-						"GPIO198_AG25", /* DAT2 */
-						"GPIO197_AH24", /* DAT3 */
-						"GPIO207_AJ23", /* DAT4 */
-						"GPIO206_AG24", /* DAT5 */
-						"GPIO205_AG23", /* DAT6 */
-						"GPIO204_AF23"; /* DAT7 */
-						ste,config = <&in_pu>;
-					};
-				};
-
-				sdi4_sleep_mode: sdi4_sleep {
-					sleep_cfg1 {
-						pins = "GPIO203_AE23"; /* CLK */
-						ste,config = <&out_lo_wkup_pdis>;
-					};
-					sleep_cfg2 {
-						pins =
-						"GPIO202_AF25", /* FBCLK */
-						"GPIO201_AF24", /* CMD */
-						"GPIO200_AH26", /* DAT0 */
-						"GPIO199_AH23", /* DAT1 */
-						"GPIO198_AG25", /* DAT2 */
-						"GPIO197_AH24", /* DAT3 */
-						"GPIO207_AJ23", /* DAT4 */
-						"GPIO206_AG24", /* DAT5 */
-						"GPIO205_AG23", /* DAT6 */
-						"GPIO204_AF23"; /* DAT7 */
-						ste,config = <&slpm_in_wkup_pdis>;
-					};
-				};
-			};
-
-			/*
-			 * Multi-rate serial ports (MSPs) - MSP3 output is internal and
-			 * cannot be muxed onto any pins.
-			 */
-			msp0 {
-				msp0_default_mode: msp0_default {
-					default_msp0_mux {
-						function = "msp0";
-						groups = "msp0txrx_a_1", "msp0tfstck_a_1";
-					};
-					default_msp0_cfg {
-						pins =
-						"GPIO12_AC4", /* TXD */
-						"GPIO15_AC3", /* RXD */
-						"GPIO13_AF3", /* TFS */
-						"GPIO14_AE3"; /* TCK */
-						ste,config = <&in_nopull>;
-					};
-				};
-			};
-
-			msp1 {
-				msp1_default_mode: msp1_default {
-					default_mux {
-						function = "msp1";
-						groups = "msp1txrx_a_1", "msp1_a_1";
-					};
-					default_cfg1 {
-						pins = "GPIO33_AF2";
-						ste,config = <&out_lo>;
-					};
-					default_cfg2 {
-						pins =
-						"GPIO34_AE1",
-						"GPIO35_AE2",
-						"GPIO36_AG2";
-						ste,config = <&in_nopull>;
-					};
-
-				};
-			};
-
-			msp2 {
-				msp2_default_mode: msp2_default {
-					/* MSP2 usually used for HDMI audio */
-					default_mux {
-						function = "msp2";
-						groups = "msp2_a_1";
-					};
-					default_cfg1 {
-						pins =
-						"GPIO193_AH27", /* TXD */
-						"GPIO194_AF27", /* TCK */
-						"GPIO195_AG28"; /* TFS */
-						ste,config = <&in_pd>;
-					};
-					default_cfg2 {
-						pins = "GPIO196_AG26"; /* RXD */
-						ste,config = <&out_lo>;
-					};
-				};
-			};
-
-
-			musb {
-				musb_default_mode: musb_default {
-					default_mux {
-						function = "usb";
-						groups = "usb_a_1";
-					};
-					default_cfg1 {
-						pins =
-						"GPIO256_AF28", /* NXT */
-						"GPIO258_AD29", /* XCLK */
-						"GPIO259_AC29", /* DIR */
-						"GPIO260_AD28", /* DAT7 */
-						"GPIO261_AD26", /* DAT6 */
-						"GPIO262_AE26", /* DAT5 */
-						"GPIO263_AG29", /* DAT4 */
-						"GPIO264_AE27", /* DAT3 */
-						"GPIO265_AD27", /* DAT2 */
-						"GPIO266_AC28", /* DAT1 */
-						"GPIO267_AC27"; /* DAT0 */
-						ste,config = <&in_nopull>;
-					};
-					default_cfg2 {
-						pins = "GPIO257_AE29"; /* STP */
-						ste,config = <&out_hi>;
-					};
-				};
-
-				musb_sleep_mode: musb_sleep {
-					sleep_cfg1 {
-						pins =
-						"GPIO256_AF28", /* NXT */
-						"GPIO258_AD29", /* XCLK */
-						"GPIO259_AC29"; /* DIR */
-						ste,config = <&slpm_wkup_pdis_en>;
-					};
-					sleep_cfg2 {
-						pins = "GPIO257_AE29"; /* STP */
-						ste,config = <&slpm_out_hi_wkup_pdis>;
-					};
-					sleep_cfg3 {
-						pins =
-						"GPIO260_AD28", /* DAT7 */
-						"GPIO261_AD26", /* DAT6 */
-						"GPIO262_AE26", /* DAT5 */
-						"GPIO263_AG29", /* DAT4 */
-						"GPIO264_AE27", /* DAT3 */
-						"GPIO265_AD27", /* DAT2 */
-						"GPIO266_AC28", /* DAT1 */
-						"GPIO267_AC27"; /* DAT0 */
-						ste,config = <&slpm_in_wkup_pdis_en>;
-					};
-				};
-			};
-
 			mcde {
 				lcd_default_mode: lcd_default {
 					default_mux1 {
-- 
2.24.0

