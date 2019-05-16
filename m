Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA71C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A600D20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UEIXbPkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfEPPNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:13:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfEPPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:13:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so4027302wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwTuo9cmOBgLtYKY6tIim7Qw2ueucrmJKldtrpo1E+Y=;
        b=UEIXbPkC0myO/R8zz+1+yUD/Q5UNbeXQFQrtPdEteSSLrLwX/C9QqW0eoPGbHdLw1u
         yL1vNOm1OfYJJUk7Qnvw/ZnCISmv7Agd2/HeO27ECus6Xx1frxbByuv9fnY2YNzkgziz
         uukXc5YH3b4iGErd0z3e9bqjCn7bQxeTek3vcUxJc//EdAtSI/EoJcg77vTD43pX/+JF
         pC5oO3hKti5JOrvJe2wzmSWhFckYB2PDxDIm7dr21YXZjc7JC5B/xRrnHSrI3tKH2vvG
         u8KDzLYHQ5hqU9gqm+fAvS8d5v2LLgQ65I3k5X7WU3M+de19aZOXjJy7FqUjLGfVtlNW
         D/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwTuo9cmOBgLtYKY6tIim7Qw2ueucrmJKldtrpo1E+Y=;
        b=d1yNC6gU2PAR/+EyzrQ9B/pmAYTykLUMxt8F86sH3navmdRnWb0gATo09GajXjhbT+
         U7X1tEbu8sbtOcyJ+qv4bkZGsMutPbtg6AcOQEFlE3gKyhjmOcw9DCIdK/R5vSh7EOgP
         X+LxZ+qAGRxFHc5fg47yu2d+QB8/DdDXO8qLRdJCX8fLnW47lib2LO+bKw2fgToBuv7Y
         SMr33qU5ks7Eh2NpzMxXzJ5VdG+b+XUkEv6GE8yn0dcXf3xcX0z5SO53e6/bYha3bBzR
         UitUc9jFF8TEv4siHWoG/wuSR17v2qQSP40ozvn2g1HJ4ORk+DHjG02oAymfoDov2Nes
         QjIQ==
X-Gm-Message-State: APjAAAWIuPD7UyBS/SwAc2VUMHM/bM0geLCTyB9O+nNQcwqPhbxPSF6v
        bYnQTPvXgZdXHHEG1Iv8Jfl26Q==
X-Google-Smtp-Source: APXvYqxtX0A2PAeunKpL7XXFo1SfjQP7HuVm6uvMgg+h/dgz2iYpPyM3craEvwnREeu3sykqjWru0g==
X-Received: by 2002:a1c:d182:: with SMTP id i124mr7089369wmg.102.1558019628440;
        Thu, 16 May 2019 08:13:48 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 17sm6968126wrk.91.2019.05.16.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:13:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: meson: add output support in pinconf
Date:   Thu, 16 May 2019 17:13:39 +0200
Message-Id: <20190516151339.25846-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516151339.25846-1-jbrunet@baylibre.com>
References: <20190516151339.25846-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinconf support for PIN_CONFIG_OUTPUT_ENABLE and PIN_CONFIG_OUTPUT
in the meson pinctrl driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 182 ++++++++++++++++++--------
 1 file changed, 127 insertions(+), 55 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 33b4b141baac..410eb7559016 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -174,6 +174,88 @@ int meson_pmx_get_groups(struct pinctrl_dev *pcdev, unsigned selector,
 	return 0;
 }
 
+static int meson_pinconf_set_gpio_bit(struct meson_pinctrl *pc,
+				      unsigned int pin,
+				      unsigned int reg_type,
+				      bool arg)
+{
+	struct meson_bank *bank;
+	unsigned int reg, bit;
+	int ret;
+
+	ret = meson_get_bank(pc, pin, &bank);
+	if (ret)
+		return ret;
+
+	meson_calc_reg_and_bit(bank, pin, reg_type, &reg, &bit);
+	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
+				  arg ? BIT(bit) : 0);
+}
+
+static int meson_pinconf_get_gpio_bit(struct meson_pinctrl *pc,
+				      unsigned int pin,
+				      unsigned int reg_type)
+{
+	struct meson_bank *bank;
+	unsigned int reg, bit, val;
+	int ret;
+
+	ret = meson_get_bank(pc, pin, &bank);
+	if (ret)
+		return ret;
+
+	meson_calc_reg_and_bit(bank, pin, reg_type, &reg, &bit);
+	ret = regmap_read(pc->reg_gpio, reg, &val);
+	if (ret)
+		return ret;
+
+	return BIT(bit) & val ? 1 : 0;
+}
+
+static int meson_pinconf_set_output(struct meson_pinctrl *pc,
+				    unsigned int pin,
+				    bool out)
+{
+	return meson_pinconf_set_gpio_bit(pc, pin, REG_DIR, !out);
+}
+
+static int meson_pinconf_get_output(struct meson_pinctrl *pc,
+				    unsigned int pin)
+{
+	int ret = meson_pinconf_get_gpio_bit(pc, pin, REG_DIR);
+
+	if (ret < 0)
+		return ret;
+
+	return !ret;
+}
+
+static int meson_pinconf_set_drive(struct meson_pinctrl *pc,
+				   unsigned int pin,
+				   bool high)
+{
+	return meson_pinconf_set_gpio_bit(pc, pin, REG_OUT, high);
+}
+
+static int meson_pinconf_get_drive(struct meson_pinctrl *pc,
+				   unsigned int pin)
+{
+	return meson_pinconf_get_gpio_bit(pc, pin, REG_OUT);
+}
+
+static int meson_pinconf_set_output_drive(struct meson_pinctrl *pc,
+					  unsigned int pin,
+					  bool high)
+{
+	int ret;
+
+	ret = meson_pinconf_set_output(pc, pin, true);
+	if (ret)
+		return ret;
+
+	return meson_pinconf_set_drive(pc, pin, high);
+}
+
 static int meson_pinconf_disable_bias(struct meson_pinctrl *pc,
 				      unsigned int pin)
 {
@@ -267,39 +349,48 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 {
 	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
 	enum pin_config_param param;
-	unsigned int drive_strength_ua;
+	unsigned int arg = 0;
 	int i, ret;
 
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
 
+		switch (param) {
+		case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		case PIN_CONFIG_OUTPUT_ENABLE:
+		case PIN_CONFIG_OUTPUT:
+			arg = pinconf_to_config_argument(configs[i]);
+			break;
+
+		default:
+			break;
+		}
+
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
 			ret = meson_pinconf_disable_bias(pc, pin);
-			if (ret)
-				return ret;
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
 			ret = meson_pinconf_enable_bias(pc, pin, true);
-			if (ret)
-				return ret;
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			ret = meson_pinconf_enable_bias(pc, pin, false);
-			if (ret)
-				return ret;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH_UA:
-			drive_strength_ua =
-				pinconf_to_config_argument(configs[i]);
-			ret = meson_pinconf_set_drive_strength
-				(pc, pin, drive_strength_ua);
-			if (ret)
-				return ret;
+			ret = meson_pinconf_set_drive_strength(pc, pin, arg);
+			break;
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			ret = meson_pinconf_set_output(pc, pin, arg);
+			break;
+		case PIN_CONFIG_OUTPUT:
+			ret = meson_pinconf_set_output_drive(pc, pin, arg);
 			break;
 		default:
-			return -ENOTSUPP;
+			ret = -ENOTSUPP;
 		}
+
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -403,6 +494,24 @@ static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 		if (ret)
 			return ret;
 		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		ret = meson_pinconf_get_output(pc, pin);
+		if (ret <= 0)
+			return -EINVAL;
+		arg = 1;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		ret = meson_pinconf_get_output(pc, pin);
+		if (ret <= 0)
+			return -EINVAL;
+
+		ret = meson_pinconf_get_drive(pc, pin);
+		if (ret < 0)
+			return -EINVAL;
+
+		arg = ret;
+		break;
+
 	default:
 		return -ENOTSUPP;
 	}
@@ -447,56 +556,19 @@ static const struct pinconf_ops meson_pinconf_ops = {
 
 static int meson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit;
-	struct meson_bank *bank;
-	int ret;
-
-	ret = meson_get_bank(pc, gpio, &bank);
-	if (ret)
-		return ret;
-
-	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
-
-	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit), BIT(bit));
+	return meson_pinconf_set_output(gpiochip_get_data(chip), gpio, false);
 }
 
 static int meson_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 				       int value)
 {
-	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit;
-	struct meson_bank *bank;
-	int ret;
-
-	ret = meson_get_bank(pc, gpio, &bank);
-	if (ret)
-		return ret;
-
-	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
-	ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
-	if (ret)
-		return ret;
-
-	meson_calc_reg_and_bit(bank, gpio, REG_OUT, &reg, &bit);
-	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
-				  value ? BIT(bit) : 0);
+	return meson_pinconf_set_output_drive(gpiochip_get_data(chip),
+					      gpio, value);
 }
 
 static void meson_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
 {
-	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit;
-	struct meson_bank *bank;
-	int ret;
-
-	ret = meson_get_bank(pc, gpio, &bank);
-	if (ret)
-		return;
-
-	meson_calc_reg_and_bit(bank, gpio, REG_OUT, &reg, &bit);
-	regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
-			   value ? BIT(bit) : 0);
+	meson_pinconf_set_drive(gpiochip_get_data(chip), gpio, value);
 }
 
 static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
-- 
2.20.1

