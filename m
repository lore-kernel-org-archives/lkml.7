Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED6C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942A420674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="pwFxMwL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfKYRFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:05:45 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:14092 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfKYRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574701539;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=53qG48IklGrDeQf7pc+hhg5H/dz6HcMn6cl+jKa+Pn8=;
        b=pwFxMwL50TeCnvhz7eQ8TwF4rizpX+wbZExt5+CjRobScgXTsK/3PgIjh6myKemVyb
        V7M6ZpSZfRv5rfqXBA6rnFAAdomI2nEnVZa+iNYq4qDFteEN1zvAT9Xh1ujK8aLHSZkD
        j9QbFbjLzai3g/DIhXGGxXpgm1JBq0hxIsGgk/bKQwVcPGjyUKLYk5l1NdoHs7rHFKwx
        1q0irm1zPjwxDFWetybSyc+lyD5IPpZHHiHlK9rS7vlal1k9tyY1APhcMfyzt6yNihbD
        Q3pghJnGSrxDdcsKFphf63gWsH1GHa96vt31RXHTIMGVKmv1XUCUzzmyr8gUORCFkRir
        nOSQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPH5b2r6
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 18:05:37 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/4] ARM: dts: ux500: Disable I2C/SPI buses by default
Date:   Mon, 25 Nov 2019 18:04:25 +0100
Message-Id: <20191125170428.76069-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, all 5 I2C and 6 SPI buses are probed and exposed
to user-space by default - even if they are not muxed to any pins
on the board. This means that user-space sees an I2C/SPI bus that
cannot be actually used properly.

In some cases this was used to put the corresponding pins into
a low power sleep mode - but even then the pins first need to be
configured by the board-specific device tree part.

Avoid exposing unconfigured devices to user-space by disabling
the I2C/SPI buses by default. Enable them in the board device trees
when needed.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi     | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi       |  4 ++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi |  1 +
 arch/arm/boot/dts/ste-snowball.dts    |  5 +++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index a53657b83288..899368aa6ff7 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -646,6 +646,8 @@
 			clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
 			clock-names = "i2cclk", "apb_pclk";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		i2c@80122000 {
@@ -662,6 +664,8 @@
 			clocks = <&prcc_kclk 1 2>, <&prcc_pclk 1 2>;
 			clock-names = "i2cclk", "apb_pclk";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		i2c@80128000 {
@@ -678,6 +682,8 @@
 			clocks = <&prcc_kclk 1 6>, <&prcc_pclk 1 6>;
 			clock-names = "i2cclk", "apb_pclk";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		i2c@80110000 {
@@ -694,6 +700,8 @@
 			clocks = <&prcc_kclk 2 0>, <&prcc_pclk 2 0>;
 			clock-names = "i2cclk", "apb_pclk";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		i2c@8012a000 {
@@ -710,6 +718,8 @@
 			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 10>;
 			clock-names = "i2cclk", "apb_pclk";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		spi@80002000 {
@@ -724,6 +734,8 @@
 			       <&dma 8 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		spi@80003000 {
@@ -738,6 +750,8 @@
 			       <&dma 9 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		spi@8011a000 {
@@ -753,6 +767,8 @@
 			       <&dma 0 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		spi@80112000 {
@@ -768,6 +784,8 @@
 			       <&dma 35 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		spi@80111000 {
@@ -783,6 +801,8 @@
 			       <&dma 33 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		spi@80129000 {
@@ -798,6 +818,8 @@
 			       <&dma 40 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 			power-domains = <&pm_domains DOMAIN_VAPE>;
+
+			status = "disabled";
 		};
 
 		ux500_serial0: uart@80120000 {
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 7613a40421d5..5eafd5d8a8cd 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -39,18 +39,21 @@
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c0_a_1_default>;
 			pinctrl-1 = <&i2c0_a_1_sleep>;
+			status = "okay";
 		};
 
 		i2c@80122000 {
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c1_b_2_default>;
 			pinctrl-1 = <&i2c1_b_2_sleep>;
+			status = "okay";
 		};
 
 		i2c@80128000 {
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c2_b_2_default>;
 			pinctrl-1 = <&i2c2_b_2_sleep>;
+			status = "okay";
 			lp5521@33 {
 				compatible = "national,lp5521";
 				reg = <0x33>;
@@ -98,6 +101,7 @@
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c3_c_2_default>;
 			pinctrl-1 = <&i2c3_c_2_sleep>;
+			status = "okay";
 		};
 
 		/* ST6G3244ME level translator for 1.8/2.9 V */
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index a036defdf164..937f942f0961 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -58,6 +58,7 @@
 			 */
 			pinctrl-names = "default";
 			pinctrl-0 = <&ssp0_hrefprev60_mode>;
+			status = "okay";
 		};
 
 		// External Micro SD slot
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 8b80dcdf6e5b..ce136412b6da 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -307,18 +307,21 @@
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c0_a_1_default>;
 			pinctrl-1 = <&i2c0_a_1_sleep>;
+			status = "okay";
 		};
 
 		i2c@80122000 {
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c1_b_2_default>;
 			pinctrl-1 = <&i2c1_b_2_sleep>;
+			status = "okay";
 		};
 
 		i2c@80128000 {
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c2_b_2_default>;
 			pinctrl-1 = <&i2c2_b_2_sleep>;
+			status = "okay";
 			lsm303dlh@18 {
 				/* Accelerometer */
 				compatible = "st,lsm303dlh-accel";
@@ -369,11 +372,13 @@
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c3_c_2_default>;
 			pinctrl-1 = <&i2c3_c_2_sleep>;
+			status = "okay";
 		};
 
 		spi@80002000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&ssp0_snowball_mode>;
+			status = "okay";
 		};
 
 		prcmu@80157000 {
-- 
2.24.0

