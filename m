Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825792083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="RFUocR9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCLQeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:34:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38986 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:34:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so2224532pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f/zsEZeqMZdnHG0gnDPSHsocMzMCL9dk/SiJdqz46P0=;
        b=RFUocR9v8b7o3J64hVebo1qnGKNJEfpeU/KwhCpkewnpQwfwp2o2NmGrBXxxN0lQXN
         bYaMn7c+gVwKS9+8GSHyEov8dkG9fi1rmPbc9e6pRFrrSdzYgSdASkvxwH/1wFIiAfI/
         Zh4p299WjZmEqWFoU1tPJjxSleG2X54ItZCCHvt06NQFkc1x1Tr8wcGFHR001Znzd8GL
         jw+hCFKWOrUcwfM+H0PWOJZgiGylMjzqF5ewrCIkA7ruqlC2ny/VSgDBVIrdrQdU2Y61
         mHEbp4YjwoophLQzasS1Gh5FlLNWE2srns1FStCVzIs79tWQLhdjKCQxB+AW/hzMpUix
         rJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f/zsEZeqMZdnHG0gnDPSHsocMzMCL9dk/SiJdqz46P0=;
        b=bBLqRKqG6RSleprg5XrfHkjopnfjj3witwokWRGzaEOS8bkd3DIJyt7Kmp/DDSYfTT
         9OPeLKjAb6EZtmp+HRlX3HOoiMCAQqZAL19JDE43iLQ9dlxn+RCQBY6HbkoaQ5uieORE
         qqa3ScKf3R3uFBLovPjPMm7jOdNkVxjaD2+7cjHbPtu+ATC/4OBJo2bJZ5mSyU22Byt/
         3wsn4TEK7zbGf9MuTcBopnpbIpPOFys0slAeFvtm4aw9lRzwXw+FUb9fK1bwzm+TvdPm
         4wdWySvjHCkbhA8/OPRdyLXJsEAe1xKXfVHbkS4aVaoKZ6HQTieionBOdoiN6mGzSO2u
         tcyg==
X-Gm-Message-State: APjAAAXCkFx4/JUZCf4cml3GYJxY+Y/JCnhf9+FQhgnWPAEEWIzF2F4Q
        LV9IqgT5lDtHhR60bqq59sJ7Aw==
X-Google-Smtp-Source: APXvYqyrAFyBSBgPpU/SZs6SXbkXTU6cKHm04CqLFSs5phBUUOKhwOuDsPDewjcbFis0pYQCqeIIIQ==
X-Received: by 2002:a17:902:a24:: with SMTP id 33mr28059314plo.275.1552408456646;
        Tue, 12 Mar 2019 09:34:16 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s79sm17447467pfa.61.2019.03.12.09.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:34:15 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/4] regulator: wm831x-isink: Convert to use regulator_set/get_current_limit_regmap
Date:   Wed, 13 Mar 2019 00:33:56 +0800
Message-Id: <20190312163357.27785-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312163357.27785-1-axel.lin@ingics.com>
References: <20190312163357.27785-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/wm831x-core.c            |  2 +-
 drivers/regulator/wm831x-isink.c     | 45 +++++-----------------------
 include/linux/mfd/wm831x/regulator.h |  2 +-
 3 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index 25fbbaf39cb9..21bae64e0451 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -34,7 +34,7 @@
 /* Current settings - values are 2*2^(reg_val/4) microamps.  These are
  * exported since they are used by multiple drivers.
  */
-int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1] = {
+const unsigned int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1] = {
 	2,
 	2,
 	3,
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 676a4701c986..c4bc3d3361aa 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -92,48 +92,12 @@ static int wm831x_isink_is_enabled(struct regulator_dev *rdev)
 		return 0;
 }
 
-static int wm831x_isink_set_current(struct regulator_dev *rdev,
-				    int min_uA, int max_uA)
-{
-	struct wm831x_isink *isink = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = isink->wm831x;
-	int ret, i;
-
-	for (i = ARRAY_SIZE(wm831x_isinkv_values) - 1; i >= 0; i--) {
-		int val = wm831x_isinkv_values[i];
-		if (min_uA <= val && val <= max_uA) {
-			ret = wm831x_set_bits(wm831x, isink->reg,
-					      WM831X_CS1_ISEL_MASK, i);
-			return ret;
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int wm831x_isink_get_current(struct regulator_dev *rdev)
-{
-	struct wm831x_isink *isink = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = isink->wm831x;
-	int ret;
-
-	ret = wm831x_reg_read(wm831x, isink->reg);
-	if (ret < 0)
-		return ret;
-
-	ret &= WM831X_CS1_ISEL_MASK;
-	if (ret > WM831X_ISINK_MAX_ISEL)
-		ret = WM831X_ISINK_MAX_ISEL;
-
-	return wm831x_isinkv_values[ret];
-}
-
 static const struct regulator_ops wm831x_isink_ops = {
 	.is_enabled = wm831x_isink_is_enabled,
 	.enable = wm831x_isink_enable,
 	.disable = wm831x_isink_disable,
-	.set_current_limit = wm831x_isink_set_current,
-	.get_current_limit = wm831x_isink_get_current,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static irqreturn_t wm831x_isink_irq(int irq, void *data)
@@ -187,10 +151,15 @@ static int wm831x_isink_probe(struct platform_device *pdev)
 	isink->desc.ops = &wm831x_isink_ops;
 	isink->desc.type = REGULATOR_CURRENT;
 	isink->desc.owner = THIS_MODULE;
+	isink->desc.curr_table = wm831x_isinkv_values,
+	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values),
+	isink->desc.csel_reg = isink->reg,
+	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK,
 
 	config.dev = pdev->dev.parent;
 	config.init_data = pdata->isink[id];
 	config.driver_data = isink;
+	config.regmap = wm831x->regmap;
 
 	isink->regulator = devm_regulator_register(&pdev->dev, &isink->desc,
 						   &config);
diff --git a/include/linux/mfd/wm831x/regulator.h b/include/linux/mfd/wm831x/regulator.h
index 955d30fc6a27..30c587a0624c 100644
--- a/include/linux/mfd/wm831x/regulator.h
+++ b/include/linux/mfd/wm831x/regulator.h
@@ -1213,6 +1213,6 @@
 #define WM831X_LDO1_OK_WIDTH                         1  /* LDO1_OK */
 
 #define WM831X_ISINK_MAX_ISEL 55
-extern int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1];
+extern const unsigned int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1];
 
 #endif
-- 
2.17.1

