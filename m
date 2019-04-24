Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BBAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD83218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnVPoX4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfDXWtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:49:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33909 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfDXWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id y16so7627161ljg.1;
        Wed, 24 Apr 2019 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qb30F3csxPMWkF7SUL4LY++a+c/C+BjbyqzAzgW0ngI=;
        b=GnVPoX4wjGW29Mn+/bzbvUiYx2G+0/RjIJRAgujgPbO/Q9U0no+tqduDD/x8cqb2qz
         Uq69/PmiPxyg1+sfvfczzaIOJO7uh5Cwnu1mPmgUCgP5ZJfqjMImg0u+aID4q12y5S0B
         cvpg5Ofec+7zFtjcrkBARAhIytOFGMU+COZW8ekRq+1Fk11LE/k3LsaXqhWRJTLsPyGT
         c2kZU3rlMzVo1zBYioSoPqS4ymayJgJA3p58gXMBStthpUsD+r6xYI8bdM3vk+vIUyqg
         j/8DJcGE89xOYbvPt7xdMvjRHEqIgKYR8hVKcYOZCbKBCudr+bcSGpbiyR6yzytUhrGJ
         I0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qb30F3csxPMWkF7SUL4LY++a+c/C+BjbyqzAzgW0ngI=;
        b=eEPPvQs3ufEz8iXZ4ky5eXjGWxDFX59W+el0TCyHfxQyQubSXDSHis+vhwcP1guwTt
         /0PrxTb3W4s1tAHyrkqe0+Hx8s2Ygkc6MPqB6PGzby1vhNZrajVE6gHzyfDOWZGZnbmj
         Q6L8pfuKi/i6qz+XLVh3KorovcaiZnFiwRH6g/b0xt4OxERh94zn+k5x1zkXr/h2Q9Gv
         UxRCT4EJMSthVfrcib9XNmWxjp+ZJ/0QMXSrv6MOYD6AmKqFueaTnoSKQjSQQ52cwwCh
         npdIRvY6cdNhyS4g2OV6wR0xOpn8gWlx+zTRx0H+LPOFDCoplayEHzUCmQ2IywnLv1fa
         AvSw==
X-Gm-Message-State: APjAAAWJcQrVBqUWN5CG3eI5U63UxbRmHblHjampy0gchtXImS8ZdRtb
        tB6+bH9EVHCIy9CO5vAsTtE=
X-Google-Smtp-Source: APXvYqxg5+DJ+yNzHU1rMIIbivfXlF8nPhjHWF0r6nNdhdwuKKoKxi2iZ20d0sjn3KPK0+XZ7kXW5Q==
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr19006445ljk.129.1556146182369;
        Wed, 24 Apr 2019 15:49:42 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:41 -0700 (PDT)
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
Subject: [PATCH v3 2/6] mfd: max77620: Support Maxim 77663
Date:   Thu, 25 Apr 2019 01:48:56 +0300
Message-Id: <20190424224900.8018-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424224900.8018-1-digetx@gmail.com>
References: <20190424224900.8018-1-digetx@gmail.com>
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
index d8ddd1a6f304..9b0009c29610 100644
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
@@ -237,6 +286,9 @@ static int max77620_get_fps_period_reg_value(struct max77620_chip *chip,
 	case MAX20024:
 		fps_min_period = MAX20024_FPS_PERIOD_MIN_US;
 		break;
+	case MAX77663:
+		fps_min_period = MAX20024_FPS_PERIOD_MIN_US;
+		break;
 	case MAX77620:
 		fps_min_period = MAX77620_FPS_PERIOD_MIN_US;
 		break;
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

