Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20349C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E896721835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="uBQeH1QF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfJGLnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:43:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45418 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJGLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:43:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so8449979pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnZBYfnQqIKed2UQ8HcNQI/BpCmJn++X3gPwaT+ycjk=;
        b=uBQeH1QFZEfILxXV7kRDAQC+mobdNn1y/F3W6dHwDuBn5lipQ5J8fj0UYGkYwLQT6m
         0e86TNBATaEncjWxxqtrYfLqVr3Ednmm671QLmFgd2mULuX9x4h5PkFVi7nyQDWapYdS
         m6Uu7qvJyJX5slSjvxA6Z1pC3eGi77Bkgo0V9ewQI2ACyZZpHAhcMeSmSw7vAv4S2GZh
         vepreMbJwJcERXyDh935Z3e33itZPWYpylx/HYzdpfA2Igx4cKqTOTSBPY8fh2DkqWKq
         AtDbL6UWX3K3HFLZ5GDINlZJLVINOV8WcCpY93N9g+CEa8GE2pbMyh+r7GcKyCEMk5IH
         tVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnZBYfnQqIKed2UQ8HcNQI/BpCmJn++X3gPwaT+ycjk=;
        b=TM5jNagdW5RVPTiP4P3ACcFQ9mAaCYLT2UFKLtlaNLkYBzwOOSPHBIOgIMtidWa4e7
         EpcNwgA3OvQ93iZ7o4d9XOEKFzmUJjUkiEnK/aJ5VgjjwY+fIHHOC0GjN52qgWG1ss7X
         8Kk6/qXZV9DXYUNsyJZHnM8FamfwGyiUULw2LcTahmoTt7SiU23sJKqS0WRjaHkkJTnH
         /kiBBMEyKbTAJkEF6Zbtr3QNhDdE5dE8aSIKTqqwV1csfdEjEHU5vOmT0ZtY9mmjNJ+w
         G876lFF78LipI9kCWVw1JxffubtcxwrWsPJeQan/gpmkgvGvf3xk6oRd8XAYChE5ckYo
         vNqQ==
X-Gm-Message-State: APjAAAWXzBUHeD5+Bx/1wPWNFz/5GsPj59tdBtP0xvHRDpnULnskdrF7
        QAksqIF3nLuQ7v1gsIaE7ndogvgmoMg=
X-Google-Smtp-Source: APXvYqxXtYIrHjCJk9K8uXIYRXUOAraF5V9vbHQfykuAxsxiob4yLROUrZQ/al9VnSPx6rKi8korzg==
X-Received: by 2002:a65:514c:: with SMTP id g12mr30288978pgq.76.1570448619566;
        Mon, 07 Oct 2019 04:43:39 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id p1sm19188297pfb.112.2019.10.07.04.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 04:43:38 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pbias: Get rid of struct pbias_regulator_data
Date:   Mon,  7 Oct 2019 19:43:20 +0800
Message-Id: <20191007114320.20977-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the desc field is really used, so use struct regulator_desc instead.
Then struct pbias_regulator_data can be removed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pbias-regulator.c | 69 +++++++++++------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index a59811060bdc..bfc15dd3f730 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -38,15 +38,6 @@ struct pbias_reg_info {
 	int n_voltages;
 };
 
-struct pbias_regulator_data {
-	struct regulator_desc desc;
-	void __iomem *pbias_addr;
-	struct regulator_dev *dev;
-	struct regmap *syscon;
-	const struct pbias_reg_info *info;
-	int voltage;
-};
-
 struct pbias_of_data {
 	unsigned int offset;
 };
@@ -157,13 +148,13 @@ MODULE_DEVICE_TABLE(of, pbias_of_match);
 static int pbias_regulator_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct pbias_regulator_data *drvdata;
 	struct resource *res;
 	struct regulator_config cfg = { };
+	struct regulator_desc *desc;
+	struct regulator_dev *rdev;
 	struct regmap *syscon;
 	const struct pbias_reg_info *info;
-	int ret = 0;
-	int count, idx, data_idx = 0;
+	int ret, count, idx;
 	const struct pbias_of_data *data;
 	unsigned int offset;
 
@@ -172,10 +163,8 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	if (count < 0)
 		return count;
 
-	drvdata = devm_kcalloc(&pdev->dev,
-			       count, sizeof(struct pbias_regulator_data),
-			       GFP_KERNEL);
-	if (!drvdata)
+	desc = devm_kcalloc(&pdev->dev, count, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		return -ENOMEM;
 
 	syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
@@ -198,7 +187,7 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	cfg.regmap = syscon;
 	cfg.dev = &pdev->dev;
 
-	for (idx = 0; idx < PBIAS_NUM_REGS && data_idx < count; idx++) {
+	for (idx = 0; idx < PBIAS_NUM_REGS && count; idx++) {
 		if (!pbias_matches[idx].init_data ||
 			!pbias_matches[idx].of_node)
 			continue;
@@ -207,41 +196,35 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		if (!info)
 			return -ENODEV;
 
-		drvdata[data_idx].syscon = syscon;
-		drvdata[data_idx].info = info;
-		drvdata[data_idx].desc.name = info->name;
-		drvdata[data_idx].desc.owner = THIS_MODULE;
-		drvdata[data_idx].desc.type = REGULATOR_VOLTAGE;
-		drvdata[data_idx].desc.ops = &pbias_regulator_voltage_ops;
-		drvdata[data_idx].desc.volt_table = info->pbias_volt_table;
-		drvdata[data_idx].desc.n_voltages = info->n_voltages;
-		drvdata[data_idx].desc.enable_time = info->enable_time;
-		drvdata[data_idx].desc.vsel_reg = offset;
-		drvdata[data_idx].desc.vsel_mask = info->vmode;
-		drvdata[data_idx].desc.enable_reg = offset;
-		drvdata[data_idx].desc.enable_mask = info->enable_mask;
-		drvdata[data_idx].desc.enable_val = info->enable;
-		drvdata[data_idx].desc.disable_val = info->disable_val;
+		desc->name = info->name;
+		desc->owner = THIS_MODULE;
+		desc->type = REGULATOR_VOLTAGE;
+		desc->ops = &pbias_regulator_voltage_ops;
+		desc->volt_table = info->pbias_volt_table;
+		desc->n_voltages = info->n_voltages;
+		desc->enable_time = info->enable_time;
+		desc->vsel_reg = offset;
+		desc->vsel_mask = info->vmode;
+		desc->enable_reg = offset;
+		desc->enable_mask = info->enable_mask;
+		desc->enable_val = info->enable;
+		desc->disable_val = info->disable_val;
 
 		cfg.init_data = pbias_matches[idx].init_data;
-		cfg.driver_data = &drvdata[data_idx];
 		cfg.of_node = pbias_matches[idx].of_node;
 
-		drvdata[data_idx].dev = devm_regulator_register(&pdev->dev,
-					&drvdata[data_idx].desc, &cfg);
-		if (IS_ERR(drvdata[data_idx].dev)) {
-			ret = PTR_ERR(drvdata[data_idx].dev);
+		rdev = devm_regulator_register(&pdev->dev, desc, &cfg);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
 			dev_err(&pdev->dev,
 				"Failed to register regulator: %d\n", ret);
-			goto err_regulator;
+			return ret;
 		}
-		data_idx++;
+		desc++;
+		count--;
 	}
 
-	platform_set_drvdata(pdev, drvdata);
-
-err_regulator:
-	return ret;
+	return 0;
 }
 
 static struct platform_driver pbias_regulator_driver = {
-- 
2.20.1

