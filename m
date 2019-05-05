Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A3C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C592082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="T0nM1MFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfEENEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:04:38 -0400
Received: from onstation.org ([52.200.56.107]:46322 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfEENE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:04:29 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 8934845024;
        Sun,  5 May 2019 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1557061468;
        bh=nYW8yG0aVWdWMAc2ItybuQwpTJk6byq+6MIvbwCCb2I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T0nM1MFlR6V7e6fqNwvr92rnw8oTqALQqoebXCwaGBSuFMaIFNM0XmY8QBrQoh6PJ
         jiYOxw3COCdMciC4HeyOnORdaA1qPYw1XoKZ5xYu1SqRkN28Kcq3eUMANUQaxqtuhR
         uJJSgJ+F7lGssm6clGq6dw89hMc38GI6cHqXR4i0=
From:   Brian Masney <masneyb@onstation.org>
To:     robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: [PATCH RFC 5/6] ARM: dts: qcom: msm8974-hammerhead: add support for backlight
Date:   Sun,  5 May 2019 09:04:12 -0400
Message-Id: <20190505130413.32253-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190505130413.32253-1-masneyb@onstation.org>
References: <20190505130413.32253-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add necessary device tree nodes for the main LCD backlight.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This requires this series that I submitted to the LED / backlight
subsystem:
https://lore.kernel.org/lkml/20190424092505.6578-1-masneyb@onstation.org/
It's received 3 {Reviewed,Acked}-Bys, and has no outstanding change
requests, so I expect it'll be merged soon.

 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index b3b04736a159..b7cf4b1019e9 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -289,6 +289,16 @@
 			};
 		};
 
+		i2c11_pins: i2c11 {
+			mux {
+				pins = "gpio83", "gpio84";
+				function = "blsp_i2c11";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		i2c12_pins: i2c12 {
 			mux {
 				pins = "gpio87", "gpio88";
@@ -369,6 +379,30 @@
 		};
 	};
 
+	i2c@f9967000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c11_pins>;
+		clock-frequency = <355000>;
+		qcom,src-freq = <50000000>;
+
+		led-controller@38 {
+			compatible = "ti,lm3630a";
+			status = "ok";
+			reg = <0x38>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				led-sources = <0 1>;
+				label = "lcd-backlight";
+				default-brightness = <200>;
+			};
+		};
+	};
+
 	i2c@f9968000 {
 		status = "ok";
 		pinctrl-names = "default";
-- 
2.20.1

