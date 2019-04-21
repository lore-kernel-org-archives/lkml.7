Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEF2C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0933F20859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYpgzt1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfDURuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:50:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40144 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfDURuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:50:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so4805181pgl.7;
        Sun, 21 Apr 2019 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XngrGjth1C4u1JF3ki/Z0d8/Cb8eKj/0LyuLu3Bf6s=;
        b=gYpgzt1cZQuFHqcAgH8LMayXoa0lgGQcPHe7bTj5t3/k6NmhTwOOO5SoiVXUgyd4qc
         E1+VT8Be9AqRh5JvQF35vtG3IqmQlQl7iB4otV8rV0QA92glBpKec7VvMRFwqXcHl7GZ
         UbGMJC853kvF5zhtPFYmNFRdP2TXz0X0gXqkJAhM6PljieAae+exqz+XTYgV69xudwRk
         kxzI5Mo4FZc+ZiX8lnw9YU2oo0rD42yek4HriAbYIwRmE2h4k3L1CkHjq0lHrNCFaw/s
         nMB39PaRG+Ww3u1Im6Pyemwi0VL2lyYnGG+5uINmb8TTBrIXqGSf94Jqi8w/RmRKNlwV
         eOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XngrGjth1C4u1JF3ki/Z0d8/Cb8eKj/0LyuLu3Bf6s=;
        b=eKfhR/SnDABvNT8PQsw6dbawUN3l/LbphsyoiegiWAAGuKAPxeCzmFNZFBqIeqclU4
         HP7lTZlG4VCcgEpngFT+GtdIf/a0rW9Vn1/GFO0D46qWjpFhrm94Ejx+7sqH13vcHQQL
         pfZ2APkINcYZPJ7uvSdmqg3YDXrkUJIr0vW/RyxwIaA0dmLxp5iYAYmH5XfoOBjMLxFN
         Js4Xi/kki/f/iAVtBg5W5yLaau2sLSITxzcCrxTujCGLIUZXH+Z8Kxl97WyXWdGRshV7
         POietsZW6YndqhP7XxvBjotGnxZ7EnYQmitdi4R6LAS375iKapFdhXPthZUja4kCOt3N
         sRsQ==
X-Gm-Message-State: APjAAAVomtFMYnKr7EDdbMT14zxYaZmfHTrgT7ICHr+Cq4DDjfvZJFqd
        6RbmXuLvHJaK4cmb0NyGX6g=
X-Google-Smtp-Source: APXvYqxfzVpPETgsBp56fStwItBQ2iQ0lfHVH/hEknbdadhWGdYFmjvvxy4rMoaHhrwN1PISKofM6g==
X-Received: by 2002:a63:4548:: with SMTP id u8mr14816579pgk.435.1555868999693;
        Sun, 21 Apr 2019 10:49:59 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g63sm16279233pfc.127.2019.04.21.10.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 10:49:59 -0700 (PDT)
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
Subject: [PATCH v1 5/5] mfd: max77620: Support device-tree properly
Date:   Sun, 21 Apr 2019 20:48:34 +0300
Message-Id: <20190421174834.9366-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421174834.9366-1-digetx@gmail.com>
References: <20190421174834.9366-1-digetx@gmail.com>
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
 drivers/mfd/max77620.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 3b6dded0595c..ef313604ca47 100644
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
@@ -486,6 +490,7 @@ static int max77620_probe(struct i2c_client *client,
 	const struct regmap_config *rmap_config;
 	struct max77620_chip *chip;
 	const struct mfd_cell *mfd_cells;
+	const struct max77620_desc *desc;
 	int n_mfd_cells;
 	int ret;
 
@@ -493,11 +498,13 @@ static int max77620_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
+	desc = of_device_get_match_data(&client->dev);
+
 	i2c_set_clientdata(client, chip);
 	chip->dev = &client->dev;
 	chip->irq_base = -1;
 	chip->chip_irq = client->irq;
-	chip->chip_id = (enum max77620_chip_id)id->driver_data;
+	chip->chip_id = desc->chip_id;
 
 	switch (chip->chip_id) {
 	case MAX77620:
@@ -665,11 +672,23 @@ static int max77620_i2c_resume(struct device *dev)
 }
 #endif
 
-static const struct i2c_device_id max77620_id[] = {
-	{"max77620", MAX77620},
-	{"max20024", MAX20024},
-	{"max77663", MAX77663},
-	{},
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
 };
 
 static const struct dev_pm_ops max77620_pm_ops = {
@@ -680,8 +699,8 @@ static struct i2c_driver max77620_driver = {
 	.driver = {
 		.name = "max77620",
 		.pm = &max77620_pm_ops,
+		.of_match_table = of_match_ptr(max77620_of_match),
 	},
 	.probe = max77620_probe,
-	.id_table = max77620_id,
 };
 builtin_i2c_driver(max77620_driver);
-- 
2.21.0

