Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D482C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461612186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Hcyhh5f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDLByh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:54:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41165 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDLByg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:54:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so4286410plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QY6BxjoPl3IczGkDH7MSpIUV599g7iLVFsO+RDcEpY=;
        b=Hcyhh5f7Ys22zHXoPvUw/PXCPiHndqJvKG8OlC+lSgipJCd6taCq9fCYHIiUHNMTil
         ZVcJn+DnlXQgGorMizg3iXaMZZPXrKxvPt4S6JV9xizeE2UXIJQY/duwK8VNpNnVAiHe
         NxGDggnlsl9QYw76uKLKVk00aXYJCoPLA9egi0tIAz36hKjheqMe49XiV+q2Oez6yCwZ
         Fy65hQO5ESw6uJxfhMWVd31z/eCjgQuV5i1G7MhYlaqxhW2JkIphE2ecE91fRRxJz8PP
         VB9B8fxAoaA7iHcWdIJeuKP3uonQRSw2Qmu9bEUi9+8S2Oz1Pwze4mn0JNOHlxmNAh/c
         SD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QY6BxjoPl3IczGkDH7MSpIUV599g7iLVFsO+RDcEpY=;
        b=ijXm6JtXtejWTX9fZ3DXOaT4Iuz9Nrj9Wkkx9Lyp1CldNA/gsJQuxPJ72Aa7VvE2+C
         mVboDWU/WlPPLN+gCWncKIlKOlnYol3SFvJn4c5G3fV3a+he8ztJRzAC9XYShJOOoxrm
         IxsJ4mUOjXz4/cIHX91cTcdLs2l1CtCL6IVrWVfKrHP4nef2UU4a258QnrzOkQNstD6L
         WWOdpFcgCm9cPuztLDR7fdODV8fumGi+5OY6+COepI8yevLW/4TK8BzO1uPjrXn3g680
         gPEM6wnnIaNJ7ZIqFVZYapG/kg4y/wOz70atUN9VUE1hHWmgumAzzMx4s3ewI4gvzIAg
         2eQg==
X-Gm-Message-State: APjAAAW/iDbU7qQyZM70BcxNP0mLkFbQQDQa39cfYyLMXUTWxBzMDSnY
        8EEV8QyvevWXhjF1kbNbp5gCCQ==
X-Google-Smtp-Source: APXvYqy/qTzmOqINEOq+hRubT1aIuPY5It+RT+5i55R61jmIXKhe2z0c1dzaaQMjxThzzpKOM4HLFg==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr37766255plb.237.1555034075209;
        Thu, 11 Apr 2019 18:54:35 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id y12sm105977016pgq.64.2019.04.11.18.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 18:54:34 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: db8500-prcmu: Convert to use simplified DT parsing
Date:   Fri, 12 Apr 2019 09:54:20 +0800
Message-Id: <20190412015421.27078-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412015421.27078-1-axel.lin@ingics.com>
References: <20190412015421.27078-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simplify the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/db8500-prcmu.c | 139 ++++++++++---------------------
 1 file changed, 42 insertions(+), 97 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 863bd3de42a7..c2a3ccfc510e 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -214,6 +214,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VAPE] = {
 		.desc = {
 			.name	= "db8500-vape",
+			.of_match = of_match_ptr("db8500_vape"),
 			.id	= DB8500_REGULATOR_VAPE,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -223,6 +224,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VARM] = {
 		.desc = {
 			.name	= "db8500-varm",
+			.of_match = of_match_ptr("db8500_varm"),
 			.id	= DB8500_REGULATOR_VARM,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -232,6 +234,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VMODEM] = {
 		.desc = {
 			.name	= "db8500-vmodem",
+			.of_match = of_match_ptr("db8500_vmodem"),
 			.id	= DB8500_REGULATOR_VMODEM,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -241,6 +244,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VPLL] = {
 		.desc = {
 			.name	= "db8500-vpll",
+			.of_match = of_match_ptr("db8500_vpll"),
 			.id	= DB8500_REGULATOR_VPLL,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -250,6 +254,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VSMPS1] = {
 		.desc = {
 			.name	= "db8500-vsmps1",
+			.of_match = of_match_ptr("db8500_vsmps1"),
 			.id	= DB8500_REGULATOR_VSMPS1,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -259,6 +264,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VSMPS2] = {
 		.desc = {
 			.name	= "db8500-vsmps2",
+			.of_match = of_match_ptr("db8500_vsmps2"),
 			.id	= DB8500_REGULATOR_VSMPS2,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -271,6 +277,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VSMPS3] = {
 		.desc = {
 			.name	= "db8500-vsmps3",
+			.of_match = of_match_ptr("db8500_vsmps3"),
 			.id	= DB8500_REGULATOR_VSMPS3,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -280,6 +287,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VRF1] = {
 		.desc = {
 			.name	= "db8500-vrf1",
+			.of_match = of_match_ptr("db8500_vrf1"),
 			.id	= DB8500_REGULATOR_VRF1,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -289,6 +297,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SVAMMDSP] = {
 		.desc = {
 			.name	= "db8500-sva-mmdsp",
+			.of_match = of_match_ptr("db8500_sva_mmdsp"),
 			.id	= DB8500_REGULATOR_SWITCH_SVAMMDSP,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -299,6 +308,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SVAMMDSPRET] = {
 		.desc = {
 			.name	= "db8500-sva-mmdsp-ret",
+			.of_match = of_match_ptr("db8500_sva_mmdsp_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_SVAMMDSPRET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -310,6 +320,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SVAPIPE] = {
 		.desc = {
 			.name	= "db8500-sva-pipe",
+			.of_match = of_match_ptr("db8500_sva_pipe"),
 			.id	= DB8500_REGULATOR_SWITCH_SVAPIPE,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -320,6 +331,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SIAMMDSP] = {
 		.desc = {
 			.name	= "db8500-sia-mmdsp",
+			.of_match = of_match_ptr("db8500_sia_mmdsp"),
 			.id	= DB8500_REGULATOR_SWITCH_SIAMMDSP,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -330,6 +342,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SIAMMDSPRET] = {
 		.desc = {
 			.name	= "db8500-sia-mmdsp-ret",
+			.of_match = of_match_ptr("db8500_sia_mmdsp_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_SIAMMDSPRET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -341,6 +354,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SIAPIPE] = {
 		.desc = {
 			.name	= "db8500-sia-pipe",
+			.of_match = of_match_ptr("db8500_sia_pipe"),
 			.id	= DB8500_REGULATOR_SWITCH_SIAPIPE,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -351,6 +365,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SGA] = {
 		.desc = {
 			.name	= "db8500-sga",
+			.of_match = of_match_ptr("db8500_sga"),
 			.id	= DB8500_REGULATOR_SWITCH_SGA,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -361,6 +376,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_B2R2_MCDE] = {
 		.desc = {
 			.name	= "db8500-b2r2-mcde",
+			.of_match = of_match_ptr("db8500_b2r2_mcde"),
 			.id	= DB8500_REGULATOR_SWITCH_B2R2_MCDE,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -371,6 +387,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM12] = {
 		.desc = {
 			.name	= "db8500-esram12",
+			.of_match = of_match_ptr("db8500_esram12"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM12,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -382,6 +399,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM12RET] = {
 		.desc = {
 			.name	= "db8500-esram12-ret",
+			.of_match = of_match_ptr("db8500_esram12_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM12RET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -393,6 +411,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM34] = {
 		.desc = {
 			.name	= "db8500-esram34",
+			.of_match = of_match_ptr("db8500_esram34"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM34,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -404,6 +423,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM34RET] = {
 		.desc = {
 			.name	= "db8500-esram34-ret",
+			.of_match = of_match_ptr("db8500_esram34_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM34RET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -414,113 +434,38 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	},
 };
 
-static int db8500_regulator_register(struct platform_device *pdev,
-					struct regulator_init_data *init_data,
-					int id,
-					struct device_node *np)
+static int db8500_regulator_probe(struct platform_device *pdev)
 {
+	struct regulator_init_data *db8500_init_data;
 	struct dbx500_regulator_info *info;
 	struct regulator_config config = { };
-	int err;
-
-	/* assign per-regulator data */
-	info = &dbx500_regulator_info[id];
-	info->dev = &pdev->dev;
-
-	config.dev = &pdev->dev;
-	config.init_data = init_data;
-	config.driver_data = info;
-	config.of_node = np;
-
-	/* register with the regulator framework */
-	info->rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
-	if (IS_ERR(info->rdev)) {
-		err = PTR_ERR(info->rdev);
-		dev_err(&pdev->dev, "failed to register %s: err %i\n",
-			info->desc.name, err);
-		return err;
-	}
-
-	dev_dbg(rdev_get_dev(info->rdev),
-		"regulator-%s-probed\n", info->desc.name);
+	int err, i;
 
-	return 0;
-}
-
-static struct of_regulator_match db8500_regulator_matches[] = {
-	{ .name	= "db8500_vape",          .driver_data = (void *) DB8500_REGULATOR_VAPE, },
-	{ .name	= "db8500_varm",          .driver_data = (void *) DB8500_REGULATOR_VARM, },
-	{ .name	= "db8500_vmodem",        .driver_data = (void *) DB8500_REGULATOR_VMODEM, },
-	{ .name	= "db8500_vpll",          .driver_data = (void *) DB8500_REGULATOR_VPLL, },
-	{ .name	= "db8500_vsmps1",        .driver_data = (void *) DB8500_REGULATOR_VSMPS1, },
-	{ .name	= "db8500_vsmps2",        .driver_data = (void *) DB8500_REGULATOR_VSMPS2, },
-	{ .name	= "db8500_vsmps3",        .driver_data = (void *) DB8500_REGULATOR_VSMPS3, },
-	{ .name	= "db8500_vrf1",          .driver_data = (void *) DB8500_REGULATOR_VRF1, },
-	{ .name	= "db8500_sva_mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSP, },
-	{ .name	= "db8500_sva_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSPRET, },
-	{ .name	= "db8500_sva_pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAPIPE, },
-	{ .name	= "db8500_sia_mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSP, },
-	{ .name	= "db8500_sia_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSPRET, },
-	{ .name	= "db8500_sia_pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAPIPE, },
-	{ .name	= "db8500_sga",           .driver_data = (void *) DB8500_REGULATOR_SWITCH_SGA, },
-	{ .name	= "db8500_b2r2_mcde",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_B2R2_MCDE, },
-	{ .name	= "db8500_esram12",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12, },
-	{ .name	= "db8500_esram12_ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12RET, },
-	{ .name	= "db8500_esram34",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34, },
-	{ .name	= "db8500_esram34_ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34RET, },
-};
-
-static int
-db8500_regulator_of_probe(struct platform_device *pdev,
-			struct device_node *np)
-{
-	int i, err;
+	db8500_init_data = dev_get_platdata(&pdev->dev);
 
 	for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
-		err = db8500_regulator_register(
-			pdev, db8500_regulator_matches[i].init_data,
-			i, db8500_regulator_matches[i].of_node);
-		if (err)
+		/* assign per-regulator data */
+		info = &dbx500_regulator_info[i];
+		info->dev = &pdev->dev;
+
+		config.driver_data = info;
+		config.dev = &pdev->dev;
+		if (db8500_init_data)
+			config.init_data = &db8500_init_data[i];
+
+		info->rdev = devm_regulator_register(&pdev->dev, &info->desc,
+						     &config);
+		if (IS_ERR(info->rdev)) {
+			err = PTR_ERR(info->rdev);
+			dev_err(&pdev->dev, "failed to register %s: err %i\n",
+				info->desc.name, err);
 			return err;
-	}
-
-	return 0;
-}
-
-static int db8500_regulator_probe(struct platform_device *pdev)
-{
-	struct regulator_init_data *db8500_init_data =
-					dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
-	int i, err;
-
-	/* register all regulators */
-	if (np) {
-		err = of_regulator_match(&pdev->dev, np,
-					db8500_regulator_matches,
-					ARRAY_SIZE(db8500_regulator_matches));
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"Error parsing regulator init data: %d\n", err);
-			return err;
-		}
-
-		err = db8500_regulator_of_probe(pdev, np);
-		if (err)
-			return err;
-	} else {
-		for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
-			err = db8500_regulator_register(pdev,
-							&db8500_init_data[i],
-							i, NULL);
-			if (err)
-				return err;
 		}
+		dev_dbg(&pdev->dev, "regulator-%s-probed\n", info->desc.name);
 	}
 
-	err = ux500_regulator_debug_init(pdev,
-					 dbx500_regulator_info,
-					 ARRAY_SIZE(dbx500_regulator_info));
+	ux500_regulator_debug_init(pdev, dbx500_regulator_info,
+				   ARRAY_SIZE(dbx500_regulator_info));
 	return 0;
 }
 
-- 
2.17.1

