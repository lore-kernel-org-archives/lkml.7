Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC9EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697732183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CgJbQmAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbfDRMsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:48:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37223 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388910AbfDRMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:48:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so2846883wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f79/K51LupqeZAm2DqoXz3a+qDgU+HmR0YhdnRYI5Gs=;
        b=CgJbQmAJuLOc83DShGAokim3QMyBbW6+VvfzAa+ABragd3qNu2wmirCK+th3Od4ZaN
         GU100DkpChadWUShSOhDppgwuCTiHliA0DwtX3ISpl7yik4oBwJDVqJ977obdOjXPtDV
         qQeS/p7m7Uk5wOptwqYCKmaydN++B2g1T8AA0zWvb12c4ExNg9Zb+rybclQSfoG3dscL
         nXzA9P6sUUISznlcQCDSRIlLPtBoXccme1mDQ5lQnm/oADhxPPnxFo4F7PKlyMyI9YKT
         l+cjpySHx1LLb4tlNaZ4DUrCEpBiVK8nXBJlFQzCQsCCZH3Y1N5gtg7PJbEv2BTNPjdS
         i6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f79/K51LupqeZAm2DqoXz3a+qDgU+HmR0YhdnRYI5Gs=;
        b=IGl6wIef7mu2E9Sz8632hHmUG0o87S8ba9rHeCx0VDanE1zf7jNweqCeMMq/Q9Ew2p
         eZQKjNfdTGIfQGtif8Mvv0BNCAC8AofCicfP97YZvm+ofH9JdtwfFwMCPLSvxfYMpTJl
         a0DaKzNM6IBIojbDvZuhLlFQKxa+SIwdv8ODusHam24YwSd9tGZ49hrZIbzuV1rWKmML
         XPv5Ufho1c1sCV3PBTzpzn+LRNqPXQe80waESWnH4kjsB3QtpBKt2SmMDYs7mkWM2r4c
         eF51n8Kq4ivhW/JrDCPjSyzDG5krVmYszdJWwnnUL1c225ZXX+NItvVYQBi65pMSGBzV
         lDlQ==
X-Gm-Message-State: APjAAAV12u0t9ZO0vN87bGedjs4sVlBezRipk2FYPzn4ybB76BSlevUB
        q1OIhZbhZBEAs1wyGNWT6+8TGw==
X-Google-Smtp-Source: APXvYqyyqIGCNgYhN66olXaJ4wV1UOZ5LYDC23b7LOZmY4Jk4J2x+ByECSarVWNbks6YUDsakncSSQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr61117811wrn.148.1555591686114;
        Thu, 18 Apr 2019 05:48:06 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17sm1256823wrw.70.2019.04.18.05.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:48:05 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] pinctrl: meson: add support of drive-strength-uA
Date:   Thu, 18 Apr 2019 14:47:58 +0200
Message-Id: <20190418124758.24022-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418124758.24022-1-glaroque@baylibre.com>
References: <20190418124758.24022-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drive-strength-uA is a new feature needed for G12A SoC.
the default DS setting after boot is usually 500uA and it is not enough for
many functions. We need to be able to set the drive strength to reliably
enable things like MMC, I2C, etc ...

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c |  36 ++---
 drivers/pinctrl/meson/pinctrl-meson.c      | 166 ++++++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h      |  20 ++-
 3 files changed, 163 insertions(+), 59 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index d494492e98e9..3475cd7bd2af 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1304,28 +1304,28 @@ static struct meson_pmx_func meson_g12a_aobus_functions[] = {
 };
 
 static struct meson_bank meson_g12a_periphs_banks[] = {
-	/* name  first  last  irq  pullen  pull  dir  out  in */
-	BANK("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
-	     4,  0,  4,  0,  12,  0,  13, 0,  14, 0),
-	BANK("H",    GPIOH_0,    GPIOH_8, 28, 36,
-	     3,  0,  3,  0,  9,  0,  10,  0,  11,  0),
-	BANK("BOOT", BOOT_0,     BOOT_15,  37, 52,
-	     0,  0,  0,  0,  0, 0,  1, 0,  2, 0),
-	BANK("C",    GPIOC_0,    GPIOC_7,  53, 60,
-	     1,  0,  1,  0,  3, 0,  4, 0,  5, 0),
-	BANK("A",    GPIOA_0,    GPIOA_15,  61, 76,
-	     5,  0,  5,  0,  16,  0,  17,  0,  18,  0),
-	BANK("X",    GPIOX_0,    GPIOX_19,   77, 96,
-	     2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
+	/* name  first  last  irq  pullen  pull  dir  out  in  ds */
+	BANK_DS("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
+		4,  0,  4,  0,  12,  0,  13, 0,  14, 0, 5, 0),
+	BANK_DS("H",    GPIOH_0,    GPIOH_8, 28, 36,
+		3,  0,  3,  0,  9,  0,  10,  0,  11,  0, 4, 0),
+	BANK_DS("BOOT", BOOT_0,     BOOT_15,  37, 52,
+		0,  0,  0,  0,  0, 0,  1, 0,  2, 0, 0, 0),
+	BANK_DS("C",    GPIOC_0,    GPIOC_7,  53, 60,
+		1,  0,  1,  0,  3, 0,  4, 0,  5, 0, 1, 0),
+	BANK_DS("A",    GPIOA_0,    GPIOA_15,  61, 76,
+		5,  0,  5,  0,  16,  0,  17,  0,  18,  0, 6, 0),
+	BANK_DS("X",    GPIOX_0,    GPIOX_19,   77, 96,
+		2,  0,  2,  0,  6,  0,  7,  0,  8,  0, 2, 0),
 };
 
 static struct meson_bank meson_g12a_aobus_banks[] = {
-	/* name  first  last  irq  pullen  pull  dir  out  in  */
-	BANK("AO",   GPIOAO_0,  GPIOAO_11,  0, 11,
-	     3,  0,  2, 0,  0,  0,  4, 0,  1,  0),
+	/* name  first  last  irq  pullen  pull  dir  out  in  ds */
+	BANK_DS("AO", GPIOAO_0, GPIOAO_11, 0, 11, 3, 0, 2, 0, 0, 0, 4, 0, 1, 0,
+		0, 0),
 	/* GPIOE actually located in the AO bank */
-	BANK("E",   GPIOE_0,  GPIOE_2,   97, 99,
-	     3,  16,  2, 16,  0,  16,  4, 16,  1,  16),
+	BANK_DS("E", GPIOE_0, GPIOE_2, 97, 99, 3, 16, 2, 16, 0, 16, 4, 16, 1,
+		16, 1, 0),
 };
 
 static struct meson_pmx_bank meson_g12a_periphs_pmx_banks[] = {
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 96a4a72708e4..5108e5aa6514 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -174,62 +174,106 @@ int meson_pmx_get_groups(struct pinctrl_dev *pcdev, unsigned selector,
 	return 0;
 }
 
-static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
-			     unsigned long *configs, unsigned num_configs)
+static int meson_pinconf_set_bias(struct meson_pinctrl *pc, unsigned int pin,
+				  enum pin_config_param conf)
+{
+	struct meson_bank *bank;
+	unsigned int reg, bit, val = 0;
+	int ret;
+
+	ret = meson_get_bank(pc, pin, &bank);
+	if (ret)
+		return ret;
+
+	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+
+	if (conf == PIN_CONFIG_BIAS_DISABLE) {
+		ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit),	0);
+		if (ret)
+			return ret;
+	} else {
+		meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+		if (conf == PIN_CONFIG_BIAS_PULL_UP)
+			val = BIT(bit);
+
+		ret = regmap_update_bits(pc->reg_pull, reg, BIT(bit), val);
+		if (ret)
+			return ret;
+
+		meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+		ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit),
+					 BIT(bit));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int meson_pinconf_set_drive_strength(struct meson_pinctrl *pc,
+					    unsigned int pin, u16 arg)
 {
-	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
 	struct meson_bank *bank;
-	enum pin_config_param param;
 	unsigned int reg, bit;
-	int i, ret;
+	unsigned int ds_val;
+	int ret;
+
+	if (!pc->reg_ds) {
+		dev_err(pc->dev, "drive-strength not supported\n");
+		return -ENOTSUPP;
+	}
 
 	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
+	meson_calc_reg_and_bit(bank, pin, REG_DS, &reg, &bit);
+	bit = bit << 1;
+
+	if (arg <= 500) {
+		ds_val = MESON_PINCONF_DRV_500UA;
+	} else if (arg <= 2500) {
+		ds_val = MESON_PINCONF_DRV_2500UA;
+	} else if (arg <= 3000) {
+		ds_val = MESON_PINCONF_DRV_3000UA;
+	} else if (arg <= 4000) {
+		ds_val = MESON_PINCONF_DRV_4000UA;
+	} else {
+		dev_warn_once(pc->dev,
+			      "pin %u: invalid drive-strength : %d , default to 4mA\n",
+			      pin, arg);
+		ds_val = MESON_PINCONF_DRV_4000UA;
+	}
+
+	ret = regmap_update_bits(pc->reg_ds, reg, 0x3 << bit, ds_val << bit);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
+			     unsigned long *configs, unsigned num_configs)
+{
+	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
+	enum pin_config_param param;
+	unsigned int arg;
+	int i, ret;
+
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
-			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
-					       &bit);
-			ret = regmap_update_bits(pc->reg_pullen, reg,
-						 BIT(bit), 0);
-			if (ret)
-				return ret;
-			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			dev_dbg(pc->dev, "pin %u: enable pull-up\n", pin);
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
-					       &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pullen, reg,
-						 BIT(bit), BIT(bit));
-			if (ret)
-				return ret;
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pull, reg,
-						 BIT(bit), BIT(bit));
-			if (ret)
-				return ret;
-			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			dev_dbg(pc->dev, "pin %u: enable pull-down\n", pin);
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
-					       &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pullen, reg,
-						 BIT(bit), BIT(bit));
+			ret = meson_pinconf_set_bias(pc, pin, param);
 			if (ret)
 				return ret;
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pull, reg,
-						 BIT(bit), 0);
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH_UA:
+			arg = pinconf_to_config_argument(configs[i]);
+			ret = meson_pinconf_set_drive_strength(pc, pin, arg);
 			if (ret)
 				return ret;
 			break;
@@ -275,12 +319,51 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 	return conf;
 }
 
+static int meson_pinconf_get_drive_strength(struct meson_pinctrl *pc,
+					    unsigned int pin, u16 *arg)
+{
+	struct meson_bank *bank;
+	unsigned int reg, bit;
+	unsigned int val;
+	int ret;
+
+	ret = meson_get_bank(pc, pin, &bank);
+	if (ret)
+		return ret;
+
+	meson_calc_reg_and_bit(bank, pin, REG_DS, &reg, &bit);
+
+	ret = regmap_read(pc->reg_ds, reg, &val);
+	if (ret)
+		return ret;
+
+	switch ((val >> bit) & 0x3) {
+	case MESON_PINCONF_DRV_500UA:
+		*arg = 500;
+		break;
+	case MESON_PINCONF_DRV_2500UA:
+		*arg = 2500;
+		break;
+	case MESON_PINCONF_DRV_3000UA:
+		*arg = 3000;
+		break;
+	case MESON_PINCONF_DRV_4000UA:
+		*arg = 4000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 			     unsigned long *config)
 {
 	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	u16 arg;
+	int ret;
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -291,6 +374,11 @@ static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 		else
 			return -EINVAL;
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		ret = meson_pinconf_get_drive_strength(pc, pin, &arg);
+		if (ret)
+			return ret;
+		break;
 	default:
 		return -ENOTSUPP;
 	}
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 5eaab925f427..1a88103dcb9b 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -71,9 +71,20 @@ enum meson_reg_type {
 	REG_DIR,
 	REG_OUT,
 	REG_IN,
+	REG_DS,
 	NUM_REG,
 };
 
+/**
+ * enum meson_pinconf_drv - value of drive-strength supported
+ */
+enum meson_pinconf_drv {
+	MESON_PINCONF_DRV_500UA,
+	MESON_PINCONF_DRV_2500UA,
+	MESON_PINCONF_DRV_3000UA,
+	MESON_PINCONF_DRV_4000UA,
+};
+
 /**
  * struct meson bank
  *
@@ -132,7 +143,8 @@ struct meson_pinctrl {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)	\
+#define BANK_DS(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib,     \
+		dsr, dsb)                                                      \
 	{								\
 		.name		= n,					\
 		.first		= f,					\
@@ -145,8 +157,12 @@ struct meson_pinctrl {
 			[REG_DIR]	= { dr, db },			\
 			[REG_OUT]	= { or, ob },			\
 			[REG_IN]	= { ir, ib },			\
+			[REG_DS]	= { dsr, dsb },			\
 		},							\
-	 }
+	}
+
+#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
+	BANK_DS(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib, 0, 0)
 
 #define MESON_PIN(x) PINCTRL_PIN(x, #x)
 
-- 
2.17.1

