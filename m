Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0332C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6812186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0DWvam2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDLOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:12:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34218 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfDLOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:12:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so5230828pfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=azKxIzMgxSgb98AAyQuWDMiwTVGcGS7UuzzPJpbLdXw=;
        b=0DWvam2VOUBgJEOb9SUlBLfwj28zSRhmcMQ5pp5lp8n56XIpc0cNBfzdPhvjkllZH/
         EpAuxY3DxN7+ynL7+XbLCC9ZSYnwf/4clbRShQCLCjbkBvMOQG7v1ofn7AMszK4D0M7H
         ZERgPyGO+2XAK0aVtJ7a2iiGem6HwftYQTjfo19Ylv1O9WkYfsamDFYTK8skQHUaEJmR
         +KZw1jzYyaJ/gVgitjeG13eyB02mYgMSPunDSu+thi3E67q+SlCUdNzBLzslfoWWWDk7
         AOkQlpo78i7pBfo1NhwSBW3+m1dDR6MJXFNQnf1KQDFkNapwmQ3bCbbf5PInQyqm01GL
         cVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azKxIzMgxSgb98AAyQuWDMiwTVGcGS7UuzzPJpbLdXw=;
        b=t1A8qENdYwEuu8G4ARXuM4tGibxD54YBmacBdOuGVa1BI0L60doRr5ijFI2ooZ59o2
         Y/ZNHQUysJtQvteN4B8ZiXKodBDtyow4XldhnIZ4rIUkOt0///uSrbF3lLeWcl1YUEAF
         ly/NM2fFdEKqrjaFj7yzL6IfklzeOqQ/PuUyvvVEfOqrt/IWaD/h/gjielKVgfKkOG83
         mtPQ6doUcquHdawHW3wFNRNZMuoa0GZ35JGgWmD3E5WphrCtZfdBCHJl670nGFREzIt9
         KvofesT5NSc+Icmp2gy5c2bC0YLoiKG41nt3TUGa//0WvxmMftiQ/G5iP7y43g2/bdGE
         2CzA==
X-Gm-Message-State: APjAAAUp4ca27RIue6m4MxXiZGqOXzBIFkTE5Ol58sra3u008HRDF8Y+
        1plEEjG1nD8w0xqlftcGXCfa3Q==
X-Google-Smtp-Source: APXvYqw46cv/llf70r1Mu6Wqv7zyuwUOJg11Y9zPdot57xjC/jmmXCop0M9XDm9resr1mheyg3dZQQ==
X-Received: by 2002:a65:4083:: with SMTP id t3mr27484628pgp.332.1555078333582;
        Fri, 12 Apr 2019 07:12:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id j67sm76750819pfc.72.2019.04.12.07.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:12:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: ab8500: Remove *regulator from struct ab8500_regulator_info
Date:   Fri, 12 Apr 2019 22:11:58 +0800
Message-Id: <20190412141158.21246-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412141158.21246-1-axel.lin@ingics.com>
References: <20190412141158.21246-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code is using devm_regulator_register() so we don't need to save
*regulator for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab8500.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 6b9a3463f1fd..3fcb4cbaab02 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -44,7 +44,6 @@ struct ab8500_shared_mode {
  * struct ab8500_regulator_info - ab8500 regulator information
  * @dev: device pointer
  * @desc: regulator description
- * @regulator_dev: regulator device
  * @shared_mode: used when mode is shared between two regulators
  * @load_lp_uA: maximum load in idle (low power) mode
  * @update_bank: bank to control on/off
@@ -65,7 +64,6 @@ struct ab8500_shared_mode {
 struct ab8500_regulator_info {
 	struct device		*dev;
 	struct regulator_desc	desc;
-	struct regulator_dev	*regulator;
 	struct ab8500_shared_mode *shared_mode;
 	int load_lp_uA;
 	u8 update_bank;
@@ -1600,6 +1598,7 @@ static int ab8500_regulator_register(struct platform_device *pdev,
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_regulator_info *info = NULL;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 
 	/* assign per-regulator data */
 	info = &abx500_regulator.info[id];
@@ -1621,12 +1620,11 @@ static int ab8500_regulator_register(struct platform_device *pdev,
 	}
 
 	/* register regulator with framework */
-	info->regulator = devm_regulator_register(&pdev->dev, &info->desc,
-						&config);
-	if (IS_ERR(info->regulator)) {
+	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "failed to register regulator %s\n",
 			info->desc.name);
-		return PTR_ERR(info->regulator);
+		return PTR_ERR(rdev);
 	}
 
 	return 0;
-- 
2.17.1

