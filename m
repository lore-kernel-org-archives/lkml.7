Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED98620811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y3bBwXXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfCNQhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:37:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33071 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfCNQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:37:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so6601227wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EiWbWRN93h/NWe41N/AubEalZGmqmPngrZfTt6A0e4=;
        b=y3bBwXXV8JGLlzOQbd+ek2EZsz6sGBcS577RgoxHfKUPNETEg3rxbKiGGdcxUsyX5C
         ZIyOiVBz7xCBZ6R/EWITvppM/Cq9v28iaZh96lg9RfuZOkOTeX26kCMcNW8DeGLDKp+T
         GsYBdjnFiTUvKVQKZzKZ9rNbMRe46Pu4Yz7D9TffMpfnD6GTgOfS6pKiaaiXzhw4QCgr
         P7j4c+C47sAnc67Sq8dqMd9NXKQ8iS6EdBtOBy0zkkMZfyJQ6W1ThvF4/i2d0+YjKli1
         Fu9cBN67zAjlL0lshZxQf1Wq2LODGzXNAPoF5qLRLDmpiuHIehY2Q8O8n/bMRwYJsQ83
         WQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EiWbWRN93h/NWe41N/AubEalZGmqmPngrZfTt6A0e4=;
        b=Bi8qg2jJw3VRxmqCskK0XbcH+O9Eyohvy0iHHyEhdk8XdweGamNIlSg+J2e9tPCqor
         EmsBfUwL0GjQFYhGwcDs4XAunv/hyDVZSYk9G/VREUczeUD4W4cL5Rl3XI82CjvU0wfr
         A+nNSfW9udVFFkIZffazLPcYAL4XziDOfL1qctL2f5zFXAJl7bcoDGUex3y6XE/kv8kn
         OLGiCnA8Kz9uNIOZpFMTx+gofQa7oY7p82DwOKTznd0ZN1ymuxWzal4Hu/og76BV3ruc
         2lwDRscPmra3yH7r2Laha9sZcz4ZmgoTatpCIjKg8i9dtiHM5W5qBoou2WeDNzQ7pXgp
         6P5g==
X-Gm-Message-State: APjAAAXmQ+Qx0ZHqT5SVEBMteHbaJnpdHleNeEl5TDRhTNKvLlcPwETm
        OXoSpXxprUQYXhxey2orsLgO/g==
X-Google-Smtp-Source: APXvYqwu6WV9i0kuUBZZe/PXtw6z32e3GtZyWKzHd4ewkE97oTby5vPf22lq05IkNXuXMA6SYAtR2Q==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr34094780wrx.9.1552581457582;
        Thu, 14 Mar 2019 09:37:37 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u17sm45003315wrg.71.2019.03.14.09.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 09:37:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] pinctrl: meson: add support of drive-strength
Date:   Thu, 14 Mar 2019 17:37:25 +0100
Message-Id: <20190314163725.7918-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314163725.7918-1-jbrunet@baylibre.com>
References: <20190314163725.7918-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

drive-strength is a new feature needed for G12A SoC.
the default DS setting after boot is usually 0.5mA and it is not enough for
many functions. We need to be able to set the drive strength to reliably
enable things like MMC, I2C, etc ...

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c |  36 ++---
 drivers/pinctrl/meson/pinctrl-meson.c      | 166 ++++++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h      |  20 ++-
 3 files changed, 162 insertions(+), 60 deletions(-)

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
index 96a4a72708e4..786640f98f83 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -174,65 +174,108 @@ int meson_pmx_get_groups(struct pinctrl_dev *pcdev, unsigned selector,
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
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			arg = pinconf_to_config_argument(configs[i]);
+			ret = meson_pinconf_set_drive_strength(pc, pin, arg);
 			if (ret)
 				return ret;
-			break;
 		default:
 			return -ENOTSUPP;
 		}
@@ -275,12 +318,51 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
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
@@ -291,6 +373,10 @@ static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 		else
 			return -EINVAL;
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		ret = meson_pinconf_get_drive_strength(pc, pin, &arg);
+		if (ret)
+			return ret;
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
2.20.1

