Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B17920857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kJpmr1vC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbfCASx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:53:27 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40152 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfCASx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xmii2DYBLYEKgyM1Mxh0i8K7QVLFqLzjtZe4FCQS/Ig=; b=kJpmr1vClTsC4yQj8lvIiSzIOZ
        2PHPx6qH6NsSmIU0GWPk3UIxDekbmzJQlnhKqvfH64H6py98lVWsfZN9VKoGfmNPfwYUkOyDLt6F0
        363thBxRMQWBrK+Z5H17GYVCNBA0ACcQYIpQs7MD+inRcvwl7plWLKHP8GQifFEs96RE=;
Received: from p200300ccfbcd34001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcd:3400:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gznHY-0001k2-7A; Fri, 01 Mar 2019 19:53:16 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gznHZ-00070a-Hy; Fri, 01 Mar 2019 19:53:17 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] ARM: sun8i: h3: bluetooth for Banana Pi M2 Zero board
Date:   Fri,  1 Mar 2019 19:52:12 +0100
Message-Id: <20190301185212.26837-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Banana Pi M2 Zero board has an AP6212 BT+Wifi combo chip
with broadcom internals attached to UART1 and some gpios.
This addition is in line with similar boards

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
changes in v2: remove pinctrl things
 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 1db2541135a7..57432d0500b1 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -69,6 +69,8 @@
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -122,7 +124,20 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vcc3v3>;
+		vddio-supply = <&reg_vcc3v3>;
+		device-wakeup-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
+		host-wakeup-gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+		shutdown-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	};
+
 };
 
 &usb_otg {
-- 
2.11.0

