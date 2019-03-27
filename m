Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B2C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB8F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="BqeXeSVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfC0AZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:25:23 -0400
Received: from vps.xff.cz ([195.181.215.36]:53616 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732019AbfC0AZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553646306; bh=XeJO4BlnuiJHnl+F5QEbu+5ZsF1rCA6R8IPqgTmgSPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqeXeSVn0Tm9kkyMncY4nQvM1C+HeyhN0QrVpQdYxTsXy5Yinpk0TUY46EzDvG+4l
         e7HHp57EL49HJhEh+Vy3VBztp3NCgCHZzFt926T7Vje/U7SIKJRMUYmFYLQDfaTAwB
         gwid2tdIajZCX3B3ky/x3hRzzwvslkowF+lEKfeU=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        mark.rutland@arm.com
Cc:     Ziping Chen <techping.chan@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 1/4] input: sun4i-a10-lradc-keys: Add support for A83T
Date:   Wed, 27 Mar 2019 01:24:58 +0100
Message-Id: <20190327002501.4630-2-megous@megous.com>
In-Reply-To: <20190327002501.4630-1-megous@megous.com>
References: <20190327002501.4630-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziping Chen <techping.chan@gmail.com>

Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC,
however, the A10 SoC's vref of lradc internally is divided by 2/3 and
the A83T SoC's vref of lradc internally is divided by 3/4, thus add
a hardware variant for it to be compatible with various devices.

Signed-off-by: Ziping Chen <techping.chan@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 38 ++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 57272df34cd5..df3eec72a9b2 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -46,6 +46,7 @@
 #define CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
 #define KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
 #define LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
+#define HOLD_KEY_EN(x)		((x) << 7)
 #define HOLD_EN(x)		((x) << 6)
 #define LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
 #define SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
@@ -63,6 +64,25 @@
 #define	CHAN0_KEYDOWN_IRQ	BIT(1)
 #define CHAN0_DATA_IRQ		BIT(0)
 
+/* struct lradc_variant - Describe sun4i-a10-lradc-keys hardware variant
+ * @divisor_numerator:		The numerator of lradc Vref internally divisor
+ * @divisor_denominator:	The denominator of lradc Vref internally divisor
+ */
+struct lradc_variant {
+	u8 divisor_numerator;
+	u8 divisor_denominator;
+};
+
+static const struct lradc_variant lradc_variant_a10 = {
+	.divisor_numerator = 2,
+	.divisor_denominator = 3
+};
+
+static const struct lradc_variant r_lradc_variant_a83t = {
+	.divisor_numerator = 3,
+	.divisor_denominator = 4
+};
+
 struct sun4i_lradc_keymap {
 	u32 voltage;
 	u32 keycode;
@@ -74,6 +94,7 @@ struct sun4i_lradc_data {
 	void __iomem *base;
 	struct regulator *vref_supply;
 	struct sun4i_lradc_keymap *chan0_map;
+	const struct lradc_variant *variant;
 	u32 chan0_map_count;
 	u32 chan0_keycode;
 	u32 vref;
@@ -128,9 +149,9 @@ static int sun4i_lradc_open(struct input_dev *dev)
 	if (error)
 		return error;
 
-	/* lradc Vref internally is divided by 2/3 */
-	lradc->vref = regulator_get_voltage(lradc->vref_supply) * 2 / 3;
-
+	lradc->vref = regulator_get_voltage(lradc->vref_supply) *
+		      lradc->variant->divisor_numerator /
+		      lradc->variant->divisor_denominator;
 	/*
 	 * Set sample time to 4 ms / 250 Hz. Wait 2 * 4 ms for key to
 	 * stabilize on press, wait (1 + 1) * 4 ms for key release
@@ -222,6 +243,12 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	lradc->variant = of_device_get_match_data(&pdev->dev);
+	if (!lradc->variant) {
+		dev_err(&pdev->dev, "Missing sun4i-a10-lradc-keys variant\n");
+		return -EINVAL;
+	}
+
 	lradc->vref_supply = devm_regulator_get(dev, "vref");
 	if (IS_ERR(lradc->vref_supply))
 		return PTR_ERR(lradc->vref_supply);
@@ -265,7 +292,10 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_lradc_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-lradc-keys", },
+	{ .compatible = "allwinner,sun4i-a10-lradc-keys",
+		.data = &lradc_variant_a10 },
+	{ .compatible = "allwinner,sun8i-a83t-r-lradc",
+		.data = &r_lradc_variant_a83t },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
-- 
2.21.0

