Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D717C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1684720674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="HbQV5rcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfKYRFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:05:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:33329 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfKYRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574701539;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yN/4dwxR2rLJrfgok1uBLXq52iC/4EfyQceUfthKmpg=;
        b=HbQV5rcUoZhRJeN6fcgU3SmWz0M9etOWhKVRu8Q2+o9tWNUd3cWxv7iZDXq3cIZgFd
        CGjv9FONtir8dx+mCnHF33tHI7+/ZMWkCo9xsjdad+F1CuK9vQIcCfZnE5zfIag1sX8N
        3wosqrHzzMN9QrANyGdtQUzEr3ZbcE4pSXsafgZa6t0j9KQ9tNNo24YMBvB390VXc7W1
        j8fz71Xf2ELJZ86ib0O6qkljUM7uXBuGE6PVMByZyr5aFbo/dTk4WkxlwXcwshl4+re3
        UsSVRJq2ienXHSp7bEgXpvEMwaVPcGc8Rui3rDQe0c9XSZFkvjFIsPJIFY3Arao9nYH1
        gkzw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPH5c2r8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 18:05:38 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/4] ARM: dts: ux500: Move serial aliases to ste-dbx5x0.dtsi
Date:   Mon, 25 Nov 2019 18:04:27 +0100
Message-Id: <20191125170428.76069-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125170428.76069-1-stephan@gerhold.net>
References: <20191125170428.76069-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have aliases for I2C and SPI in ste-dbx5x0.dtsi,
it does not make much sense to keep only the aliases for UART
separately in each board device tree.

Considering that all boards set the same aliases for the serial
ports there is no reason to keep them separated either.

Move them to ste-dbx5x0.dtsi and remove the aliases from the
board-specific device tree parts.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi           | 3 +++
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts  | 7 -------
 arch/arm/boot/dts/ste-hrefprev60-tvk.dts    | 7 -------
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts | 7 -------
 arch/arm/boot/dts/ste-hrefv60plus-tvk.dts   | 7 -------
 arch/arm/boot/dts/ste-snowball.dts          | 7 -------
 6 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index ed91232a118a..841934093c3b 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -24,6 +24,9 @@
 		spi1 = &spi1;
 		spi2 = &spi2;
 		spi3 = &spi3;
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
index b78be5f4c212..d2405133860a 100644
--- a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
@@ -13,13 +13,6 @@
 	model = "ST-Ericsson HREF (pre-v60) and ST UIB";
 	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
 
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
-
 	soc {
 		/* Reset line for the BU21013 touchscreen */
 		i2c@80110000 {
diff --git a/arch/arm/boot/dts/ste-hrefprev60-tvk.dts b/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
index 60eed262d920..54b0f8282b2c 100644
--- a/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
@@ -10,11 +10,4 @@
 / {
 	model = "ST-Ericsson HREF (pre-v60) and TVK1281618 UIB";
 	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
-
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
 };
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
index 9be513aad549..36163c0b5267 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
@@ -15,13 +15,6 @@
 	model = "ST-Ericsson HREF (v60+) and ST UIB";
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
 
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
-
 	soc {
 		/* Reset line for the BU21013 touchscreen */
 		i2c@80110000 {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts b/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
index 73ea3100f186..cf59e9bb9a74 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
@@ -12,11 +12,4 @@
 / {
 	model = "ST-Ericsson HREF (v60+) and TVK1281618 UIB";
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
-
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
 };
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index ce136412b6da..f8dec3976c91 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -12,13 +12,6 @@
 	model = "Calao Systems Snowball platform with device tree";
 	compatible = "calaosystems,snowball-a9500", "st-ericsson,u9500";
 
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
-- 
2.24.0

