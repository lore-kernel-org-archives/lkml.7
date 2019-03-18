Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BC120857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894474;
	bh=nAAo/1LX2vXq7A+NRWcsLlsTs41CH3ARrF4ZrQWe5aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NlQEH6PDlSBSWhXFbfN/5HqMx0dqUsPjldmCxPWvZ0WPS91o3zobTsPWE9EPvYjZg
	 ZRK38vSxsqr1QFCfaUyUSvy3G9VOH1vgRlkMGHagrxAbayFVlzpw7NjfUTX2Po3fGv
	 tz+4vMMA8QD/gWj+3EiTG2KOh4MRmwMX2U6xvOQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCRHed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:33 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40928 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfCRHeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:15 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 18D7D5FDF4; Mon, 18 Mar 2019 15:34:12 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: sunxi: h3/h5: Add device node for SID
Date:   Mon, 18 Mar 2019 15:33:54 +0800
Message-Id: <20190318073354.12151-7-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318073354.12151-1-wens@kernel.org>
References: <20190318073354.12151-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The device tree binding already lists compatible strings for these two
SoCs. Add a device node for them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi              | 4 ++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 959d265e7254..e37c30e811d3 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -231,3 +231,7 @@
 &rtc {
 	compatible = "allwinner,sun8i-h3-rtc";
 };
+
+&sid {
+	compatible = "allwinner,sun8i-h3-sid";
+};
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index d74a6cbbfdf4..e2100b673a51 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -227,6 +227,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom@1c14000 {
+			/* compatible and clocks are in per SoC .dtsi file */
+			reg = <0x1c14000 0x400>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 96acafd3a852..f002a496d7cb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -209,3 +209,7 @@
 &rtc {
 	compatible = "allwinner,sun50i-h5-rtc";
 };
+
+&sid {
+	compatible = "allwinner,sun50i-h5-sid";
+};
-- 
2.20.1

