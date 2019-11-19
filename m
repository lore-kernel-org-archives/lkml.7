Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7A9214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141900;
	bh=AKjBnir9TlDMJlToyX9ECF1OlXxD7fOPgHiw+Fyj1nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t8SA1wdNh5EHTJYb84alU7ebgZc1RrQ9d282LB7z/uP/T4eEBHhdy5W5Cht0MLOFy
	 sy9X1MYt+CJXhyWrJoimjlk9/9bor3HvF9UvAwTfVsrOHyfd6JVxEBwEg69JqHVoAb
	 BNkJcaI1DwdmDHPBYGTiTjsbcITRCqbzlrK03ZmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfKSFiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbfKSFiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:38:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54118208C3;
        Tue, 19 Nov 2019 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141894;
        bh=AKjBnir9TlDMJlToyX9ECF1OlXxD7fOPgHiw+Fyj1nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxP/rfP/5dQIbNrPg8YObEk+K2Y5wZr1Gym/+FfX2Qk6SKEKKRX2S95Q0Tlkj0cep
         s6GIaX5eainVjb6UaQ3KIFGCFOEwb3T4lZpqzXdWTVpRJ5fNFsXdAgAuBdu60qbfvr
         vobrVuI2K4GLayc3d3Ycf1dQd6b7ejq0soY0a3xA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 267/422] ARM: dts: atmel: Fix I2C and SPI bus warnings
Date:   Tue, 19 Nov 2019 06:17:44 +0100
Message-Id: <20191119051416.290164667@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit c890ecdbe93d482512a911b299bfb009780a29c2 ]

dtc has new checks for I2C and SPI buses. Fix the warnings in node names
and unit-addresses.

arch/arm/boot/dts/at91-dvk_som60.dtb: Warning (i2c_bus_reg): /ahb/apb/i2c@f0018000/eeprom@87: I2C bus unit address format error, expected "57"
arch/arm/boot/dts/at91-dvk_som60.dtb: Warning (i2c_bus_reg): /ahb/apb/i2c@f0018000/ft5426@56: I2C bus unit address format error, expected "38"
arch/arm/boot/dts/at91-vinco.dtb: Warning (i2c_bus_reg): /ahb/apb/i2c@f8024000/rtc@64: I2C bus unit address format error, expected "32"
arch/arm/boot/dts/at91sam9260ek.dtb: Warning (spi_bus_reg): /ahb/apb/spi@fffc8000/mtd_dataflash@0: SPI bus unit address format error, expected "1"
arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb: Warning (spi_bus_reg): /ahb/apb/spi@fffc8000/mtd_dataflash@0: SPI bus unit address format error, expected "1"
arch/arm/boot/dts/at91sam9g20ek.dtb: Warning (spi_bus_reg): /ahb/apb/spi@fffc8000/mtd_dataflash@0: SPI bus unit address format error, expected "1"
arch/arm/boot/dts/at91sam9261ek.dtb: Warning (spi_bus_reg): /ahb/apb/spi@fffc8000/tsc2046@0: SPI bus unit address format error, expected "2"

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi     | 4 ++--
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi | 4 ++--
 arch/arm/boot/dts/at91-vinco.dts              | 2 +-
 arch/arm/boot/dts/at91sam9260ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9261ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
index bb86f17ed5ed1..21876da7c4425 100644
--- a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
+++ b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
@@ -70,9 +70,9 @@
 &i2c1 {
 	status = "okay";
 
-	eeprom@87 {
+	eeprom@57 {
 		compatible = "giantec,gt24c32a", "atmel,24c32";
-		reg = <87>;
+		reg = <0x57>;
 		pagesize = <32>;
 	};
 };
diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
index 4b9176dc5d029..df0f0cc575c18 100644
--- a/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
+++ b/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
@@ -59,9 +59,9 @@
 &i2c1 {
 	status = "okay";
 
-	ft5426@56 {
+	ft5426@38 {
 		compatible = "focaltech,ft5426", "edt,edt-ft5406";
-		reg = <56>;
+		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lcd_ctp_int>;
 
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index 1be9889a2b3a1..430277291e025 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -128,7 +128,7 @@
 			i2c2: i2c@f8024000 {
 				status = "okay";
 
-				rtc1: rtc@64 {
+				rtc1: rtc@32 {
 					compatible = "epson,rx8900";
 					reg = <0x32>;
 				};
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index d2b865f602932..07d1b571e6017 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -127,7 +127,7 @@
 
 			spi0: spi@fffc8000 {
 				cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
-				mtd_dataflash@0 {
+				mtd_dataflash@1 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <50000000>;
 					reg = <1>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index a29fc04940762..a57f2d435dcae 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -160,7 +160,7 @@
 					spi-max-frequency = <15000000>;
 				};
 
-				tsc2046@0 {
+				tsc2046@2 {
 					reg = <2>;
 					compatible = "ti,ads7843";
 					interrupts-extended = <&pioC 2 IRQ_TYPE_EDGE_BOTH>;
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 71df3adfc7ca1..ec1f17ab6753b 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -109,7 +109,7 @@
 
 			spi0: spi@fffc8000 {
 				cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
-				mtd_dataflash@0 {
+				mtd_dataflash@1 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <50000000>;
 					reg = <1>;
-- 
2.20.1



