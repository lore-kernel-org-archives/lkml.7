Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F5C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F4C20833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG50kJM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfDURuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:50:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44757 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDURtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:49:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id y12so2187894plk.11;
        Sun, 21 Apr 2019 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Hedjd6/QrfwVr6rJtP3KtvrNawuf3a3CTYMY8X3Q9M=;
        b=eG50kJM/D9i2y8Mhka+SYhJWuH1ivdQBonHmv8qSta0lrQQwL7+WocaemINuqRn7Kg
         BV1hhdcJeuCvgneKLawuhBc3aUlytMYIrJAOX/Qb38Qk2U+M9kKrUUHKakUcTiIvYJrb
         o3QqzSJMBRTk7DN+p0N02yc4MoFMI95VLOMBsXCh2m8gH6e6STpRisiZHNq7r47kkG5t
         jhbyrz9Ct18eF0/ZZ6CbEnwqZyMaXyz2awFzzAMXkQuWgKH9x/1d5y6hI0HS4EQYR2fi
         Cbpd7Fbib1+tIJElr0Jq2il7O+7w142OhwwwaP/ZsTYkFkmRs78f6TVZlsR7icTQi+fS
         rgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Hedjd6/QrfwVr6rJtP3KtvrNawuf3a3CTYMY8X3Q9M=;
        b=p6TkFNWyA2hZY/10fn32NEReNPwYSKVApbHEyI/bT0zz6CmVymnnUj///KNtUERqo7
         F1pJKC3dH/cQ5eiJkIZeqk1X0SFwjml6mOcmw29qDTl2hy+QvymmlfbB0qeeI2X2ynmD
         YmOUNRrfSIrG/x98m+4OZ5NKWTzTA3nVts6jyrv2xTsuYX8bh/myx+b5NDkcUB/gxeq0
         w/PRkULy7YSG3FLy0v7WlsInEoFDVAjKGAURLzsiBw8sJHJWDR1HQ6kYYaQWhBHoL5Nv
         zupqvxZva/7mq0naLxTpvXLQV3a5fu2EP5XOrbQOBaSX6gVT6m0TLDKJQ4ez2xYA5lds
         PnUg==
X-Gm-Message-State: APjAAAWioTPbtx3AY7AQEVvdCDgsyRjkSwIf2Vo+yM9uOwF0lMvCx3af
        ofj+qbmHA57roMQI5kHSGu0=
X-Google-Smtp-Source: APXvYqwRjpEbFeJKmNItY7bG4fMgAC8e4jErZDaRvH8XJ4h7e7ir9hP3UbtZoblzM/TZwvtRp6Vw4Q==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr15321619pld.172.1555868975303;
        Sun, 21 Apr 2019 10:49:35 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g63sm16279233pfc.127.2019.04.21.10.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 10:49:34 -0700 (PDT)
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
Subject: [PATCH v1 2/5] mfd: max77620: Support Maxim 77663
Date:   Sun, 21 Apr 2019 20:48:31 +0300
Message-Id: <20190421174834.9366-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421174834.9366-1-digetx@gmail.com>
References: <20190421174834.9366-1-digetx@gmail.com>
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
 drivers/mfd/max77620.c       | 68 +++++++++++++++++++++++++++++++++++-
 include/linux/mfd/max77620.h |  1 +
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index d8ddd1a6f304..3b6dded0595c 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -111,6 +111,25 @@ static const struct mfd_cell max20024_children[] = {
 	},
 };
 
+static const struct mfd_cell max77663_children[] = {
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
@@ -171,6 +190,35 @@ static const struct regmap_config max20024_regmap_config = {
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
@@ -237,6 +285,9 @@ static int max77620_get_fps_period_reg_value(struct max77620_chip *chip,
 	case MAX20024:
 		fps_min_period = MAX20024_FPS_PERIOD_MIN_US;
 		break;
+	case MAX77663:
+		fps_min_period = MAX20024_FPS_PERIOD_MIN_US;
+		break;
 	case MAX77620:
 		fps_min_period = MAX77620_FPS_PERIOD_MIN_US;
 		break;
@@ -274,6 +325,9 @@ static int max77620_config_fps(struct max77620_chip *chip,
 	case MAX77620:
 		fps_max_period = MAX77620_FPS_PERIOD_MAX_US;
 		break;
+	case MAX77663:
+		fps_max_period = MAX20024_FPS_PERIOD_MAX_US;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -375,6 +429,9 @@ static int max77620_initialise_fps(struct max77620_chip *chip)
 	}
 
 skip_fps:
+	if (chip->chip_id == MAX77663)
+		return 0;
+
 	/* Enable wake on EN0 pin */
 	ret = regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG2,
 				 MAX77620_ONOFFCNFG2_WK_EN0,
@@ -453,6 +510,11 @@ static int max77620_probe(struct i2c_client *client,
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
@@ -546,6 +608,9 @@ static int max77620_i2c_suspend(struct device *dev)
 		return ret;
 	}
 
+	if (chip->chip_id == MAX77663)
+		goto out;
+
 	/* Disable WK_EN0 */
 	ret = regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG2,
 				 MAX77620_ONOFFCNFG2_WK_EN0, 0);
@@ -581,7 +646,7 @@ static int max77620_i2c_resume(struct device *dev)
 	 * For MAX20024: No need to configure WKEN0 on resume as
 	 * it is configured on Init.
 	 */
-	if (chip->chip_id == MAX20024)
+	if (chip->chip_id == MAX20024 || chip->chip_id == MAX77663)
 		goto out;
 
 	/* Enable WK_EN0 */
@@ -603,6 +668,7 @@ static int max77620_i2c_resume(struct device *dev)
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

