Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B314E2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="unCsOIxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCGNyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:54:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37939 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:54:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so11311129pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=b89LhYysiz/DutXCJFhO0whFUgo3BHhXHIJtXItmXV0=;
        b=unCsOIxED420hnkVpwymmix9turwEjfQggFWgwifAgC/J2qX2sfOCz58+kAMlAnL5E
         Q/dxMppIWSlO4+EbCIwOIA6RJ9kuZexRORyP7dJqJItwRONq/8NuF+7VsYddIKUCwFxk
         NEwLv+MNXf9rvE+iUkCv/hXlR0GtyU+BnyAN71e0BHIef2KxZCNbZZmX4EYoXiMvCl7N
         pvFjlHqXlBU84LCdefX8AXE/WzC7VqB4TNZmGNlk4XTrT1lnETE4BFva+SKndYYPJm9U
         CQFEr8j0w1leRbcmyZH81FxHth8fQBuGQuqdmtHgkjvmA4wSDxaJy1fPii7AOB9QqSvD
         voCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b89LhYysiz/DutXCJFhO0whFUgo3BHhXHIJtXItmXV0=;
        b=ROEBqna7aw0ise0UFlcBRYVyOuqzDj/rFvwEY3/OMIjsa8Y0oMr2uMyPs5qBoUAY8C
         Ou/vvZtmbKKWCnt40xzHi9+BoxVCnCgQniU9LDO/Ig79n/AM5mD/7ZSaUO2QJE7AW9tR
         mjgYDmP85RaDRDsnpZL5wvjIY81ptb0we/w8D9rs5CYG2NGCMoIkgZ6RbZ8PAM8PyRW5
         K2J/xHrueGcLxvxWf9F62ctCQRzvXW/Q+y8aYyuZsaef0wS5YRiObGVNglqTvXV2gWcu
         P4VPPdZ7SleIDwl5TmTpKUCm6hSYWEz32ajErJyptQ7Y/F+vn258izda7q5oUxydBl4V
         oLCg==
X-Gm-Message-State: APjAAAVf3iIBgG74+GPPgxVaLnrXXqjU5NvR66DlcVwHFRKTqKwHfMqP
        K/R+zjKA7ydtLu/VngNw6yRmnQ==
X-Google-Smtp-Source: APXvYqwhL3RKmp/HnJF5lg7VEXWWmIB6P0oouiELAzYuxQhPGCGpuFyG6WaGL4kNeUbondx41CH6FQ==
X-Received: by 2002:a63:104e:: with SMTP id 14mr11420995pgq.185.1551966848291;
        Thu, 07 Mar 2019 05:54:08 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id i13sm6539728pfo.106.2019.03.07.05.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 05:54:07 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: ab3100: Remove ab3100_regulators_remove function
Date:   Thu,  7 Mar 2019 21:53:56 +0800
Message-Id: <20190307135356.15736-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code is using devm_regulator_register() so it is not necessary
to save reg->rdev for clean up. Remove *rdev from struct ab3100_regulator,
then ab3100_regulators_remove() can be removed as well.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab3100.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index de2644490f0d..c92966a79a7e 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -48,7 +48,6 @@
  * @regreg: regulator register number in the AB3100
  */
 struct ab3100_regulator {
-	struct regulator_dev *rdev;
 	struct device *dev;
 	struct ab3100_platform_data *plfdata;
 	u8 regreg;
@@ -545,8 +544,6 @@ static int ab3100_regulator_register(struct platform_device *pdev,
 		return err;
 	}
 
-	/* Then set a pointer back to the registered regulator */
-	reg->rdev = rdev;
 	return 0;
 }
 
@@ -609,18 +606,6 @@ static const u8 ab3100_reg_initvals[] = {
 	LDO_D_SETTING,
 };
 
-static int ab3100_regulators_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
-		struct ab3100_regulator *reg = &ab3100_regulators[i];
-
-		reg->rdev = NULL;
-	}
-	return 0;
-}
-
 static int
 ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
 {
@@ -647,10 +632,8 @@ ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
 			pdev, NULL, ab3100_regulator_matches[i].init_data,
 			ab3100_regulator_matches[i].of_node,
 			(unsigned long)ab3100_regulator_matches[i].driver_data);
-		if (err) {
-			ab3100_regulators_remove(pdev);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -709,10 +692,8 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 
 		err = ab3100_regulator_register(pdev, plfdata, NULL, NULL,
 						desc->id);
-		if (err) {
-			ab3100_regulators_remove(pdev);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -723,7 +704,6 @@ static struct platform_driver ab3100_regulators_driver = {
 		.name  = "ab3100-regulators",
 	},
 	.probe = ab3100_regulators_probe,
-	.remove = ab3100_regulators_remove,
 };
 
 static __init int ab3100_regulators_init(void)
-- 
2.17.1

