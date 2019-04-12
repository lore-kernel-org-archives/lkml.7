Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34427C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045AF2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="oZOhl9lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLOHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:07:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37793 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:07:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so5199125ply.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G85O0T9gvT51n0IPVcKAhBnkwkcI2Ktvg3abwb8MQTw=;
        b=oZOhl9lks9xQeiZTfIDjI7EYhaklckELxEfaXUqoIJCvVd8ErnAMKcqoo2gYY4ywE6
         3JNF61eEByZMJ86D8iu2LqOhAcAf+NEFmBvO5NTbnvlyHAbSCc4uYA2gZRExTJjeYkZW
         SykoG5pVXlhsM/n3pG5+c23kbI/J4veTzxvx50O9LLnFtZCcuup9QbZ7Cvuge339rLS+
         /Mypc5gacs625b+LSmG2klciLhwHoC5PKqK3kP/ZhMdaqF3Ppef32bXkXSkNXH0n/gZ+
         JtevLQbxNlpB5x5pii//xsfxLYS5g8aHUgeLXgjd+7vMnwjvT7HwiYZKgUJt1FUq5zyF
         rEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G85O0T9gvT51n0IPVcKAhBnkwkcI2Ktvg3abwb8MQTw=;
        b=Bgnyjh3WyfHRlOhG/9dyj3Y5TWEEvjkk9sIVugKSBi26dntmtset0RVpEn5AV1pyZZ
         H3FQCzDJhFxGl0EB3gBG+5S1+LKkbU9VqAPtDgMCl9NY9f8I9Pq7kDP2yoL9Ipzvuf3N
         KlChlEnsEqxMgU7eJJ4J4TJg6IqCChRK2Fq8fhpAfBcXJEd9A1pbqij5kX0Z/T8jImt3
         7nx0/ztuiuc9msLugq3R8DpXFhm+obyWTQOEL7aIo+26FMcDJS7urVt7A7Gui8Qtplha
         dzCQ9Lew/BY/VV1w7dMWVf6PpBPq39VG7yQvd6nmYMHCzA7KrGFp1jn9d9TGX4urLiDc
         M+rw==
X-Gm-Message-State: APjAAAXWDH97iEY2fwKk31LiorZV9P9X+pMHk6mmQKgaxgu2k6fLLrVO
        yTOZwC12as7Pf4Tf/X0KSaNchA==
X-Google-Smtp-Source: APXvYqzFnD28Pm9ejb3THRgNAiCeHFOd10yMJcboIe+IOXdKzX3SPUy4iz4lQyI1DpTAHWAPEL12HQ==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr15487856pla.137.1555078036775;
        Fri, 12 Apr 2019 07:07:16 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id d68sm63862024pfg.16.2019.04.12.07.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:07:16 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: ab8500-ext: Remove *rdev from struct ab8500_ext_regulator_info
Date:   Fri, 12 Apr 2019 22:06:57 +0800
Message-Id: <20190412140658.11754-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412140658.11754-1-axel.lin@ingics.com>
References: <20190412140658.11754-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code is using devm_regulator_register() so we don't need to save
*rdev for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab8500-ext.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 2268c934d6be..8e5365869c82 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -479,7 +479,6 @@ static struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
  * struct ab8500_ext_regulator_info - ab8500 regulator information
  * @dev: device pointer
  * @desc: regulator description
- * @rdev: regulator device
  * @cfg: regulator configuration (extension of regulator FW configuration)
  * @update_bank: bank to control on/off
  * @update_reg: register to control on/off
@@ -495,7 +494,6 @@ static struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
 struct ab8500_ext_regulator_info {
 	struct device *dev;
 	struct regulator_desc desc;
-	struct regulator_dev *rdev;
 	struct ab8500_ext_regulator_cfg *cfg;
 	u8 update_bank;
 	u8 update_reg;
@@ -530,7 +528,7 @@ static int ab8500_ext_regulator_enable(struct regulator_dev *rdev)
 		info->update_bank, info->update_reg,
 		info->update_mask, regval);
 	if (ret < 0) {
-		dev_err(rdev_get_dev(info->rdev),
+		dev_err(rdev_get_dev(rdev),
 			"couldn't set enable bits for regulator\n");
 		return ret;
 	}
@@ -566,7 +564,7 @@ static int ab8500_ext_regulator_disable(struct regulator_dev *rdev)
 		info->update_bank, info->update_reg,
 		info->update_mask, regval);
 	if (ret < 0) {
-		dev_err(rdev_get_dev(info->rdev),
+		dev_err(rdev_get_dev(rdev),
 			"couldn't set disable bits for regulator\n");
 		return ret;
 	}
@@ -797,6 +795,7 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 	struct ab8500_regulator_platform_data *pdata = &ab8500_regulator_plat_data;
 	struct device_node *np = pdev->dev.of_node;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int i, err;
 
 	if (np) {
@@ -850,17 +849,15 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 			&pdata->ext_regulator[i];
 
 		/* register regulator with framework */
-		info->rdev = devm_regulator_register(&pdev->dev, &info->desc,
-						     &config);
-		if (IS_ERR(info->rdev)) {
-			err = PTR_ERR(info->rdev);
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
+					       &config);
+		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
 					info->desc.name);
-			return err;
+			return PTR_ERR(rdev);
 		}
 
-		dev_dbg(rdev_get_dev(info->rdev),
-			"%s-probed\n", info->desc.name);
+		dev_dbg(&pdev->dev, "%s-probed\n", info->desc.name);
 	}
 
 	return 0;
-- 
2.17.1

