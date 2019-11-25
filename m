Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E720835
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="e3tFNUQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfKYRFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:05:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:36471 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfKYRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574701538;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=4T58iZwAhzibbxA38Ty05T3UHM/dV8EZ97kepZ5ETG4=;
        b=e3tFNUQ3QRft4m1yWhM4MZNgJI02fVLtm94kjCXvbTZD20xY3+ivne5k+umfg8veW3
        wiTfIfs+dJloDqNcuYbEI9uQ1LiTxb+jn6gP+QVkQY5JG6OsISZyj0R/5VxQRvdIHgx0
        Z37XsM7I5RtNrddj6l74XOFQwueb3gsPR6vY5WWhE4bZDOnzCQDG5nNMI6so4Ax40vMr
        w8SmjJzzCRsQUNe7K2asKr1fVhqsW7VMUqy9s7+1Ql27ehwr9ri0c9bcF/wsXhL0ptsG
        apumaNugBd/HmT1DL65iIb+BbjAII1iRBomWDJvvktBoDzbItGdNa7GkpXQT7Gdxz7Q3
        qGrg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPH5c2r7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 18:05:38 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/4] ARM: dts: ux500: Add aliases for I2C and SPI buses
Date:   Mon, 25 Nov 2019 18:04:26 +0100
Message-Id: <20191125170428.76069-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125170428.76069-1-stephan@gerhold.net>
References: <20191125170428.76069-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we disable the I2C/SPI buses by default, is is even more
important to assign aliases to the I2C/SPI device nodes.
Otherwise, enabling/disabling one of them will potentially change
all device IDs, e.g. i2c2 will be named i2c-0 if it is the only
enabled I2C bus.

Add aliases for the I2C and SPI buses to avoid this.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 35 +++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 899368aa6ff7..ed91232a118a 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -13,6 +13,19 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	/* This stablilizes the device enumeration */
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+	};
+
 	chosen {
 	};
 
@@ -633,7 +646,7 @@
 			};
 		};
 
-		i2c@80004000 {
+		i2c0: i2c@80004000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80004000 0x1000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -650,7 +663,7 @@
 			status = "disabled";
 		};
 
-		i2c@80122000 {
+		i2c1: i2c@80122000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80122000 0x1000>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -668,7 +681,7 @@
 			status = "disabled";
 		};
 
-		i2c@80128000 {
+		i2c2: i2c@80128000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80128000 0x1000>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -686,7 +699,7 @@
 			status = "disabled";
 		};
 
-		i2c@80110000 {
+		i2c3: i2c@80110000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80110000 0x1000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +717,7 @@
 			status = "disabled";
 		};
 
-		i2c@8012a000 {
+		i2c4: i2c@8012a000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x8012a000 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
@@ -722,7 +735,7 @@
 			status = "disabled";
 		};
 
-		spi@80002000 {
+		ssp0: spi@80002000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80002000 0x1000>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -738,7 +751,7 @@
 			status = "disabled";
 		};
 
-		spi@80003000 {
+		ssp1: spi@80003000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80003000 0x1000>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
@@ -754,7 +767,7 @@
 			status = "disabled";
 		};
 
-		spi@8011a000 {
+		spi0: spi@8011a000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x8011a000 0x1000>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -771,7 +784,7 @@
 			status = "disabled";
 		};
 
-		spi@80112000 {
+		spi1: spi@80112000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80112000 0x1000>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -788,7 +801,7 @@
 			status = "disabled";
 		};
 
-		spi@80111000 {
+		spi2: spi@80111000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80111000 0x1000>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -805,7 +818,7 @@
 			status = "disabled";
 		};
 
-		spi@80129000 {
+		spi3: spi@80129000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80129000 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.0

