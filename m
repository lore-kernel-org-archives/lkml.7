Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF8EC04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03164206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du9QBVx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfEEPsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:48:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46612 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfEEPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:48:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so8990540ljk.13;
        Sun, 05 May 2019 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41DabjnJIx0/nAlWApyFydSFjFrClaGFU5yvbMASC+k=;
        b=du9QBVx7fQO8dOhzr5qjdRxOuGxMd6AMxcLbbziKI8Q/QXHidgHafmNXnUiWUa2ONM
         oXRZyZwXeXFC+yIP/SvYnm3t4EFOXBAamgs8gsQcEm9sEhgypxvt3hlluqSLPqLg8e7d
         ZJ4YWbzApxVklod+oJo+7LiXs4eDDa4VJnvvGOer4PdZbAfxC9kBqWcRRRGnJG3zWud9
         fRjwfPlSDkUUOEMQLUfgy/wQCMPBcCGCmzhCSSresxgn4bBjsjvIOeXqW9tG8zwRfaTQ
         gmiLc3c1EQKQ2X7lUqzLhZ1wkghrpLfp0G0gsxVayzc/qOqwTqZ1I5xebDaBzo27BvPp
         YKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41DabjnJIx0/nAlWApyFydSFjFrClaGFU5yvbMASC+k=;
        b=nrxtuJU/Rb8Lo+gmUTdMlMCRnykwDIVegrb8gCXvVBWnWTnmfrhqSqwDkDQYJxStgo
         HrNJo+P1JoI0wnFaXs7hdrF5iybde+T6Mfg5DTqBqmX9ALKFcqvhtah39baZaswA+fiv
         F10lzPq4qgYE1Y8x6Xgie1EDpnfMz+85+NzQaPHie+93N4gD8c5lrYOAtKvRfYKueHMe
         RO/aYsRvonrxgxm9k0ZYBbuvGOwxOWv1sGd2wIILlwiZuuDVqXWZxoDYNqfqze4e2Zn4
         0OcjmPsW5GRe/2e3qWDZxQMmNd/91hm6LjNQeyHBMtFv5/tNxGWglbSPbH3hlwSTj08c
         JMrQ==
X-Gm-Message-State: APjAAAWbxhAELynp5Etf286QfWTk4tcnN0LLW7d6nUXLTDQsU8ZcQG62
        OiYIFJkBkSKcGZ0uiw3V1Bg=
X-Google-Smtp-Source: APXvYqz+pUjDvC56PjDofrmDism6cjpZLpfTeS8Ec86Pp22u61qg3hmIBSg8EgYBOS5f/nxqPAU4Mw==
X-Received: by 2002:a2e:4a09:: with SMTP id x9mr9617051lja.19.1557071316655;
        Sun, 05 May 2019 08:48:36 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d16sm1595278lfi.75.2019.05.05.08.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:48:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] mfd: max77620: Support Maxim 77663
Date:   Sun,  5 May 2019 18:43:23 +0300
Message-Id: <20190505154325.30026-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505154325.30026-1-digetx@gmail.com>
References: <20190505154325.30026-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Maxim 77663 using the Max77620 driver. The hardware
is very similar to Max77663/20024, although there are couple minor
differences.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max77620.c       | 69 +++++++++++++++++++++++++++++++++++-
 include/linux/mfd/max77620.h |  1 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index d8ddd1a6f304..c2d88a5eca7a 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -111,6 +111,26 @@ static const struct mfd_cell max20024_children[] = {
 	},
 };
 
+static const struct mfd_cell max77663_children[] = {
+	{ .name = "max77620-pinctrl", },
+	{ .name = "max77620-clock", },
+	{ .name = "max77663-pmic", },
+	{ .name = "max77620-watchdog", },
+	{
+		.name = "max77620-gpio",
+		.resources = gpio_resources,
+		.num_resources = ARRAY_SIZE(gpio_resources),
+	}, {
+		.name = "max77620-rtc",
+		.resources = rtc_resources,
+		.num_resources = ARRAY_SIZE(rtc_resources),
+	}, {
+		.name = "max77663-power",
+		.resources = power_resources,
+		.num_resources = ARRAY_SIZE(power_resources),
+	},
+};
+
 static const struct regmap_range max77620_readable_ranges[] = {
 	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
 };
@@ -171,6 +191,35 @@ static const struct regmap_config max20024_regmap_config = {
 	.volatile_table = &max77620_volatile_table,
 };
 
+static const struct regmap_range max77663_readable_ranges[] = {
+	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_CID5),
+};
+
+static const struct regmap_access_table max77663_readable_table = {
+	.yes_ranges = max77663_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77663_readable_ranges),
+};
+
+static const struct regmap_range max77663_writable_ranges[] = {
+	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_CID5),
+};
+
+static const struct regmap_access_table max77663_writable_table = {
+	.yes_ranges = max77663_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77663_writable_ranges),
+};
+
+static const struct regmap_config max77663_regmap_config = {
+	.name = "power-slave",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77620_REG_CID5 + 1,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &max77663_readable_table,
+	.wr_table = &max77663_writable_table,
+	.volatile_table = &max77620_volatile_table,
+};
+
 /*
  * MAX77620 and MAX20024 has the following steps of the interrupt handling
  * for TOP interrupts:
@@ -240,6 +289,9 @@ static int max77620_get_fps_period_reg_value(struct max77620_chip *chip,
 	case MAX77620:
 		fps_min_period = MAX77620_FPS_PERIOD_MIN_US;
 		break;
+	case MAX77663:
+		fps_min_period = MAX20024_FPS_PERIOD_MIN_US;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -274,6 +326,9 @@ static int max77620_config_fps(struct max77620_chip *chip,
 	case MAX77620:
 		fps_max_period = MAX77620_FPS_PERIOD_MAX_US;
 		break;
+	case MAX77663:
+		fps_max_period = MAX20024_FPS_PERIOD_MAX_US;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -375,6 +430,9 @@ static int max77620_initialise_fps(struct max77620_chip *chip)
 	}
 
 skip_fps:
+	if (chip->chip_id == MAX77663)
+		return 0;
+
 	/* Enable wake on EN0 pin */
 	ret = regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG2,
 				 MAX77620_ONOFFCNFG2_WK_EN0,
@@ -453,6 +511,11 @@ static int max77620_probe(struct i2c_client *client,
 		n_mfd_cells = ARRAY_SIZE(max20024_children);
 		rmap_config = &max20024_regmap_config;
 		break;
+	case MAX77663:
+		mfd_cells = max77663_children;
+		n_mfd_cells = ARRAY_SIZE(max77663_children);
+		rmap_config = &max77663_regmap_config;
+		break;
 	default:
 		dev_err(chip->dev, "ChipID is invalid %d\n", chip->chip_id);
 		return -EINVAL;
@@ -546,6 +609,9 @@ static int max77620_i2c_suspend(struct device *dev)
 		return ret;
 	}
 
+	if (chip->chip_id == MAX77663)
+		goto out;
+
 	/* Disable WK_EN0 */
 	ret = regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG2,
 				 MAX77620_ONOFFCNFG2_WK_EN0, 0);
@@ -581,7 +647,7 @@ static int max77620_i2c_resume(struct device *dev)
 	 * For MAX20024: No need to configure WKEN0 on resume as
 	 * it is configured on Init.
 	 */
-	if (chip->chip_id == MAX20024)
+	if (chip->chip_id == MAX20024 || chip->chip_id == MAX77663)
 		goto out;
 
 	/* Enable WK_EN0 */
@@ -603,6 +669,7 @@ static int max77620_i2c_resume(struct device *dev)
 static const struct i2c_device_id max77620_id[] = {
 	{"max77620", MAX77620},
 	{"max20024", MAX20024},
+	{"max77663", MAX77663},
 	{},
 };
 
diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index b4fd5a7c2aaa..82407fe85ca2 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -324,6 +324,7 @@ enum max77620_fps_src {
 enum max77620_chip_id {
 	MAX77620,
 	MAX20024,
+	MAX77663,
 };
 
 struct max77620_chip {
-- 
2.21.0

