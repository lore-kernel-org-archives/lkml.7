Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F89C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4328420896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OutOUoS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDVTTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:19:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40345 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfDVTS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:18:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so11228851ljq.7;
        Mon, 22 Apr 2019 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pht/1vjvg2q3MB1Rd06xLxNqPL9m9lhaJlJmlWaCpSg=;
        b=OutOUoS9sP/PJIiLPB3hAHNHq792ITn/30CV5OWyX1JP/XoY/0bi2GaGZBUiDf8ICU
         mNn6QA1+1AExBxDHGpJN0/fKVgpdtYbeEh68xoTGiK30v62cfuPBMJc9v1/lxOvRZyPT
         PBtITDHRD334W6rnQiKdAMYf09qSRo7/KzOZP7APrL67O2/WI7fdiVYl7C5ZCj+Vx7yE
         XsnzfpuWNVoqsdChWiudrK1y2Vs9e/zivBRfY9LZ74MRSPIUvzaaXJOpsH7iw/sf3rmr
         +z9KKLWMYGfYJjCpj8Nej8oqvJ1AJKxm2jnbn98eNcIWTruj4WxvKQO32CF2nM3+2Rhk
         9bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pht/1vjvg2q3MB1Rd06xLxNqPL9m9lhaJlJmlWaCpSg=;
        b=G+3MxPZauPkH15Max5CWl6jN87tKGgRAyZ3Bns4lbRJcQ0A87sziocsT3qxep93pWy
         vTmNsKAwYSLodaBsBztWusP1zRhO1PVhGsuiTBhh/MZZwe9c40FudfD8m0oNI2uSCkJg
         16mKHp4aKakuROeb5SJEX9mFMR2Tsf7WSdJxWq9C9B9cPB31xsAN+l2lqMb4R3zuFhfH
         cVr8IK+zYTJx0YxWXO4Fde+imZSc2UnTrHID+DxszKvEboDWKYKJriVdupjuyuDcmaeO
         yKQLf8yZ4Qw8AEZIi/HAufnesH3X7YmIx2LYJhNIIN4Fz/jJVhZEGAZwyg8qGMhjJvBt
         lrAQ==
X-Gm-Message-State: APjAAAWBMvTzgIHO+r5rhkZNfAhSYfmgM4LTnZ2NXS74l3no672Fhr3C
        nov46gLiNA7Df0saMGzvDQw=
X-Google-Smtp-Source: APXvYqz0ec+77GNlCE90c8yTtQpQhW6IyxgP98PBJU8/iVc/SFY501BioKILCu8/UE2gs82cxKyk8A==
X-Received: by 2002:a2e:74f:: with SMTP id i15mr10748083ljd.156.1555960737006;
        Mon, 22 Apr 2019 12:18:57 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l13sm2848762lji.39.2019.04.22.12.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:18:56 -0700 (PDT)
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
Subject: [PATCH v2 6/7] mfd: max77620: Support device-tree properly
Date:   Mon, 22 Apr 2019 22:13:49 +0300
Message-Id: <20190422191350.27527-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422191350.27527-1-digetx@gmail.com>
References: <20190422191350.27527-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some unknown reason the driver for Max77620 doesn't wire up the
device-tree support properly and nothing in kernel creates I2C device
for the driver (and never did), moreover device-tree files for NVIDIA
Tegra210/186/194 boards already have nodes for Max77620. Hence add the
missing of_match_table to make driver actually usable.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max77620.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 9b0009c29610..b7a058069808 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -37,6 +37,10 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+struct max77620_desc {
+	enum max77620_chip_id chip_id;
+};
+
 static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
 };
@@ -487,6 +491,7 @@ static int max77620_probe(struct i2c_client *client,
 	const struct regmap_config *rmap_config;
 	struct max77620_chip *chip;
 	const struct mfd_cell *mfd_cells;
+	const struct max77620_desc *desc;
 	int n_mfd_cells;
 	int ret;
 
@@ -500,6 +505,10 @@ static int max77620_probe(struct i2c_client *client,
 	chip->chip_irq = client->irq;
 	chip->chip_id = (enum max77620_chip_id)id->driver_data;
 
+	desc = of_device_get_match_data(&client->dev);
+	if (desc)
+		chip->chip_id = desc->chip_id;
+
 	switch (chip->chip_id) {
 	case MAX77620:
 		mfd_cells = max77620_children;
@@ -673,6 +682,25 @@ static const struct i2c_device_id max77620_id[] = {
 	{},
 };
 
+static const struct max77620_desc max77620_desc = {
+	.chip_id = MAX77620,
+};
+
+static const struct max77620_desc max20024_desc = {
+	.chip_id = MAX20024,
+};
+
+static const struct max77620_desc max77663_desc = {
+	.chip_id = MAX77663,
+};
+
+static const struct of_device_id max77620_of_match[] = {
+	{ .compatible = "maxim,max77620", .data = &max77620_desc },
+	{ .compatible = "maxim,max20024", .data = &max20024_desc },
+	{ .compatible = "maxim,max77663", .data = &max77663_desc },
+	{ },
+};
+
 static const struct dev_pm_ops max77620_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(max77620_i2c_suspend, max77620_i2c_resume)
 };
@@ -681,6 +709,7 @@ static struct i2c_driver max77620_driver = {
 	.driver = {
 		.name = "max77620",
 		.pm = &max77620_pm_ops,
+		.of_match_table = of_match_ptr(max77620_of_match),
 	},
 	.probe = max77620_probe,
 	.id_table = max77620_id,
-- 
2.21.0

