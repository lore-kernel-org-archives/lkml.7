Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5929C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C1420880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742678;
	bh=EKkrJcdB8gSqNADUAUC7YSn6Wk8u5VjT6etIXLA7DDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vQm5k7PNGB+hWKJvbETN166HSs24NjM5oRsOlvij45YMj5TWNKhECrgsz6bZooArP
	 weTWZVDLVSzqLCkqvhiVFkmerY7Oq8KQ0NuJuTKjMinmiRda0cg9UgjqiQVUtdwA4w
	 mTB6Y50eey0js5zdWuDtI56hPd6pwPgNIeq8I4P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfDHQ55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:57:57 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:43768 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDHQ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:50 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id CEDA75FD8D; Tue,  9 Apr 2019 00:57:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 5/6] ARM: dts: sun8i: a83t: Add I2C2 pinmux setting for PE pins
Date:   Tue,  9 Apr 2019 00:57:43 +0800
Message-Id: <20190408165744.11672-6-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408165744.11672-1-wens@kernel.org>
References: <20190408165744.11672-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

I2C2 is available on the PE pingroup, on the same pins as the camera
sensor interface (CSI) controller's camera control interface pins.
This provides an option to use I2C2 instead of that control interface
to configure camera sensors.

Add a pinctrl node for it. The property /omit-if-no-ref/ is added to
keep the device tree blob size down if it is unused.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 0c52f945fd5f..350ea40ea560 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -723,6 +723,12 @@
 				function = "i2c1";
 			};
 
+			/omit-if-no-ref/
+			i2c2_pe_pins: i2c2-pe-pins {
+				pins = "PE14", "PE15";
+				function = "i2c2";
+			};
+
 			i2c2_ph_pins: i2c2-ph-pins {
 				pins = "PH4", "PH5";
 				function = "i2c2";
-- 
2.20.1

