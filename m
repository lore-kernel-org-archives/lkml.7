Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1368B206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="pUZFrc1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfDAL43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:56:29 -0400
Received: from vps.xff.cz ([195.181.215.36]:57812 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfDAL4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554119780; bh=hhF1qepjMux1hFRYfmsYEogKzg6tvv/0wEv22DWszBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUZFrc1u8SJBnT84ySmexh3x5zZChB9nRS5LsNUrIO1q/L8EjMw8AZUo8GaNR+PRY
         OJ4k+3G28gu4SMBuWNFDCbjzOKh45EukN2I4DdeR5fioq75vYJlLgq9Zuwxkm7YkM7
         pcqqnYJ+6l237El4xl0z8Y/VdoWycqNTG9uGCOIs=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 5/5] ARM: dts: sun8i: tbs-a711: Enable UART2 (for NEO-6M GPS module)
Date:   Mon,  1 Apr 2019 13:56:16 +0200
Message-Id: <20190401115616.21337-6-megous@megous.com>
In-Reply-To: <20190401115616.21337-1-megous@megous.com>
References: <20190401115616.21337-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

TBS A711 tablet contains u-blox NEO-6M module connected to UART2.
Enable UART2 to gain access to the module from userspace.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index d70fe04b66f0..fd170bc45927 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -98,6 +98,13 @@
 		};
 	};
 
+	reg_gps: reg-gps {
+		compatible = "regulator-fixed";
+		regulator-name = "gps";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
 	reg_vbat: reg-vbat {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
@@ -422,6 +429,20 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pb_pins>;
+	status = "okay";
+
+	gnss {
+		compatible = "u-blox,neo-6m";
+
+		v-bckp-supply = <&reg_rtc_ldo>;
+		vcc-supply = <&reg_gps>;
+		current-speed = <9600>;
+	};
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.21.0

