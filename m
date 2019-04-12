Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93796C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B1F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0wX2LM9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDLByi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:54:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDLByi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:54:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so4267541plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PV9y/LjvZV0f2+Sb4JbEcSaWuXw7nxo4jbyNdyngN94=;
        b=0wX2LM9R0j5nn8XV1buOZTN84FgJN3gaTZcGVDxQpxj/sBgkKdNwbsBaBLRTXJ3WeB
         nLaKq+kg2vGcCsNvTa+zdacVPoRiZjvoXBPOEdogp7ZiuhmtaEUsTm4k3pkqgcnYRyE5
         fQ3n1D8tEribJ8nR719k5TLn55JptzPBA5ii6ywlR5cXIuLN7uuc71gqFFFYt/nrjBZd
         Db2jb20AcyOcCxuo+HWeOZSZAvO5jQ7JthPQ9ri2ojpY2ima9J18DvNIN7tfysG2QxYt
         rCi8Lq8EpLRkV+gJ9LSuqMfVkw0eV3oDzTmV44ETMUaCZmAUFYf1pUj1h2vgXhHCcJR7
         oa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PV9y/LjvZV0f2+Sb4JbEcSaWuXw7nxo4jbyNdyngN94=;
        b=O9F28t7i1/acsep9NuGDm9jn2kuhrGzljEn5p2FB/hECYn7SPcXbJnoLgvgWiLhMO0
         zud0aRwPPmrcs6DQbgraE9LbfXknsCc3mms/s+TgAxifWIFe2IoUtpwPrYI+5qLnsuvt
         qyEvGfOxWm99XQKL+KUO5KHgV5pbJ7R9ZWnSb7obIwPEI6lg5oCUIID78Eww0zELcn61
         Csm+e8KQPXiMbr0iMndpPdET2D69kuqM5M7sXe9P07P33yjrSTkwSb4hpcPqWJvS5m5M
         gJM8KKgDGtRxleb6G2fzrJuAM/hq0GDaL0E7LRQlvDjAaaFCOKlklXzQMNsiqjDIZeQA
         MrKw==
X-Gm-Message-State: APjAAAX5oiVmdMD5cZbay5j/bhK8UPLCPPVNJHhjQK8OritUbUkSQFc7
        XP3sJClAqpdWYaIPOBXuvahcWg==
X-Google-Smtp-Source: APXvYqzh4xfZCgrbSz5POeqbxiaubJ8lxEoWXi2tvgKhwOAz3g6dFGTPBpbJRa2REWbAQAQ4dOxvXQ==
X-Received: by 2002:a17:902:6b8b:: with SMTP id p11mr30219047plk.225.1555034077623;
        Thu, 11 Apr 2019 18:54:37 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id y12sm105977016pgq.64.2019.04.11.18.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 18:54:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: dbx500-prcmu: Remove unused fields from struct dbx500_regulator_info
Date:   Fri, 12 Apr 2019 09:54:21 +0800
Message-Id: <20190412015421.27078-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412015421.27078-1-axel.lin@ingics.com>
References: <20190412015421.27078-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *dev is assigned but not used, remove it.
Current driver is using devm_regulator_register(), so no neeed to save
*rdev for clean up. Use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/db8500-prcmu.c | 10 +++++-----
 drivers/regulator/dbx500-prcmu.h |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index c2a3ccfc510e..eb317663f875 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -439,6 +439,7 @@ static int db8500_regulator_probe(struct platform_device *pdev)
 	struct regulator_init_data *db8500_init_data;
 	struct dbx500_regulator_info *info;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int err, i;
 
 	db8500_init_data = dev_get_platdata(&pdev->dev);
@@ -446,17 +447,16 @@ static int db8500_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
 		/* assign per-regulator data */
 		info = &dbx500_regulator_info[i];
-		info->dev = &pdev->dev;
 
 		config.driver_data = info;
 		config.dev = &pdev->dev;
 		if (db8500_init_data)
 			config.init_data = &db8500_init_data[i];
 
-		info->rdev = devm_regulator_register(&pdev->dev, &info->desc,
-						     &config);
-		if (IS_ERR(info->rdev)) {
-			err = PTR_ERR(info->rdev);
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			err = PTR_ERR(rdev);
 			dev_err(&pdev->dev, "failed to register %s: err %i\n",
 				info->desc.name, err);
 			return err;
diff --git a/drivers/regulator/dbx500-prcmu.h b/drivers/regulator/dbx500-prcmu.h
index c8e51ace9f06..6e20dab611ac 100644
--- a/drivers/regulator/dbx500-prcmu.h
+++ b/drivers/regulator/dbx500-prcmu.h
@@ -15,18 +15,14 @@
 
 /**
  * struct dbx500_regulator_info - dbx500 regulator information
- * @dev: device pointer
  * @desc: regulator description
- * @rdev: regulator device pointer
  * @is_enabled: status of the regulator
  * @epod_id: id for EPOD (power domain)
  * @is_ramret: RAM retention switch for EPOD (power domain)
  *
  */
 struct dbx500_regulator_info {
-	struct device *dev;
 	struct regulator_desc desc;
-	struct regulator_dev *rdev;
 	bool is_enabled;
 	u16 epod_id;
 	bool is_ramret;
-- 
2.17.1

