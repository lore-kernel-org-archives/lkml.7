Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6BCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7B218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="X3NG2gZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfDLMHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:07:37 -0400
Received: from vps.xff.cz ([195.181.215.36]:36296 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfDLMHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555070852; bh=WFbaY/ab3k+0ZHOWo2EasW7vJ3s0iDUZXCsIpwTIRIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3NG2gZ1tWyE43GGH18yEjSfpKSSgRFoCSpWHWzTMvGshVLlyBe9VEOhZTWP7GWUQ
         ZpZ+H3mUGUQBLDNJGleTNbtI4jUNUekVq6s/gdHqD9dxtzTOiWnw4vAOVEUYOiqgvK
         IE44NZuNRPRMrrCCaeNubsijIWxJbnX7qyaf+TOo=
From:   megous@megous.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] rtc: sun6i: Add support for H6 RTC
Date:   Fri, 12 Apr 2019 14:07:29 +0200
Message-Id: <20190412120730.473-3-megous@megous.com>
In-Reply-To: <20190412120730.473-1-megous@megous.com>
References: <20190412120730.473-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

RTC on H6 is mostly the same as on H5 and H3. It has slight differences
mostly in features that are not yet supported by this driver.

Some differences are already stated in the comments in existing code.
One other difference is that H6 has extra bit in LOSC_CTRL_REG, called
EXT_LOSC_EN to enable/disable external low speed crystal oscillator.

It also has bit EXT_LOSC_STA in LOSC_AUTO_SWT_STA_REG, to check whether
external low speed oscillator is working correctly.

This patch adds support for enabling LOSC when necessary:

- during reparenting
- when probing the clock

H6 also has capacbility to automatically reparent RTC clock from
external crystal oscillator, to internal RC oscillator, if external
oscillator fails. This is enabled by default. Disable it during
probe.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/rtc/rtc-sun6i.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 11f56de52179..7375a530c565 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -41,9 +41,11 @@
 /* Control register */
 #define SUN6I_LOSC_CTRL				0x0000
 #define SUN6I_LOSC_CTRL_KEY			(0x16aa << 16)
+#define SUN6I_LOSC_CTRL_AUTO_SWT_BYPASS		BIT(15)
 #define SUN6I_LOSC_CTRL_ALM_DHMS_ACC		BIT(9)
 #define SUN6I_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
 #define SUN6I_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
+#define SUN6I_LOSC_CTRL_EXT_LOSC_EN		BIT(4)
 #define SUN6I_LOSC_CTRL_EXT_OSC			BIT(0)
 #define SUN6I_LOSC_CTRL_ACC_MASK		GENMASK(9, 7)
 
@@ -137,6 +139,8 @@ struct sun6i_rtc_clk_data {
 	unsigned int has_prescaler : 1;
 	unsigned int has_out_clk : 1;
 	unsigned int export_iosc : 1;
+	unsigned int has_losc_en : 1;
+	unsigned int has_auto_swt : 1;
 };
 
 struct sun6i_rtc_dev {
@@ -199,6 +203,10 @@ static int sun6i_rtc_osc_set_parent(struct clk_hw *hw, u8 index)
 	val &= ~SUN6I_LOSC_CTRL_EXT_OSC;
 	val |= SUN6I_LOSC_CTRL_KEY;
 	val |= index ? SUN6I_LOSC_CTRL_EXT_OSC : 0;
+	if (rtc->data->has_losc_en) {
+		val &= ~SUN6I_LOSC_CTRL_EXT_LOSC_EN;
+		val |= index ? SUN6I_LOSC_CTRL_EXT_LOSC_EN : 0;
+	}
 	writel(val, rtc->base + SUN6I_LOSC_CTRL);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
@@ -224,6 +232,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	const char *iosc_name = "rtc-int-osc";
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
+	u32 reg;
 
 	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -244,9 +253,18 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		goto err;
 	}
 
+	reg = SUN6I_LOSC_CTRL_KEY;
+	if (rtc->data->has_auto_swt) {
+		/* Bypass auto-switch to int osc, on ext losc failure */
+		reg |= SUN6I_LOSC_CTRL_AUTO_SWT_BYPASS;
+		writel(reg, rtc->base + SUN6I_LOSC_CTRL);
+	}
+
 	/* Switch to the external, more precise, oscillator */
-	writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
-	       rtc->base + SUN6I_LOSC_CTRL);
+	reg |= SUN6I_LOSC_CTRL_EXT_OSC;
+	if (rtc->data->has_losc_en)
+		reg |= SUN6I_LOSC_CTRL_EXT_LOSC_EN;
+	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
 
 	/* Yes, I know, this is ugly. */
 	sun6i_rtc = rtc;
@@ -354,6 +372,23 @@ CLK_OF_DECLARE_DRIVER(sun8i_h3_rtc_clk, "allwinner,sun8i-h3-rtc",
 CLK_OF_DECLARE_DRIVER(sun50i_h5_rtc_clk, "allwinner,sun50i-h5-rtc",
 		      sun8i_h3_rtc_clk_init);
 
+static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
+	.rc_osc_rate = 16000000,
+	.fixed_prescaler = 32,
+	.has_prescaler = 1,
+	.has_out_clk = 1,
+	.export_iosc = 1,
+	.has_losc_en = 1,
+	.has_auto_swt = 1,
+};
+
+static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun50i_h6_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun50i_h6_rtc_clk, "allwinner,sun50i-h6-rtc",
+		      sun50i_h6_rtc_clk_init);
+
 static const struct sun6i_rtc_clk_data sun8i_v3_rtc_data = {
 	.rc_osc_rate = 32000,
 	.has_out_clk = 1,
@@ -683,6 +718,7 @@ static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun8i-h3-rtc" },
 	{ .compatible = "allwinner,sun8i-v3-rtc" },
 	{ .compatible = "allwinner,sun50i-h5-rtc" },
+	{ .compatible = "allwinner,sun50i-h6-rtc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.21.0

