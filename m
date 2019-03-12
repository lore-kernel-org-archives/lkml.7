Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60752147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="pkfq31qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCLPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:48:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40249 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfCLPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:48:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so2123200pgo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GBeiotPEUXIQIpSG4JyMtK50/Y6RIlIjJ666gVLv4w8=;
        b=pkfq31qR2dLHLRQ3aeyW9Buq8BjbPwdms5NhYuxwrSuwBBoobePBrXo5n+hn0CgJWo
         t1hvxRzH2Q/yC0PlOOZ5L6sHG4MilwwY5aLlGeCLdmt36W+vXjhCUn/pRknmlYtu8Rp5
         P0nCxbsKedFL19Zz0vfaLoq/x6Smc9fTlI/jAMHuCWqywg2sj3vs0yRcR2N50jPvDHxv
         7Cg01Dj4RXY77X8FT73h/xY83nR45aVhWnx67ZbobhGqqYNz9feYyhktmPs+2AgXjbNM
         iXaM163eL3sEs7yYXGbMv3eNOCu1NUTiZOBHvPMLWCmvUNaVn52sBtRCHL5ABQHQgfMw
         hByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GBeiotPEUXIQIpSG4JyMtK50/Y6RIlIjJ666gVLv4w8=;
        b=D+pMU59v0deFqnIWmUAgUlLD70IKYLFuc3onypB/B7fC3b0iRCZ11VzS08KoYDNGji
         JEtIASg3b/Uz0TJ7dgo9nvR+2qudROJURIp91HFD+Rcw+0soVMlSpY/iyfudr9tmTlTO
         iiGAxKmrvfZ4yim+SfIBL7a5C11mMWmLsZAZLHhXB2wEgChSOwSTu6rOmYnMqqmWicv3
         c1tWbXN/VnZeyoKzRLMtFJlOGmQj9Xb74dv9lWQ8u4TeTLKwqMwDHHVpuw8SLvBW8rDI
         Xd5vMF/sTmH5TYMSH7z5VFnL67zistB8/7kSpmVaysaKOD+nZDmCgNj4zdXVWJYjTT1P
         higg==
X-Gm-Message-State: APjAAAU8Jai32fMAKE1d8um1UwyjnsqxTXV494GRw7kpfO9xNJvOOUgc
        0Ffvq4/UovBn7RTzGrKlTMcl5Q==
X-Google-Smtp-Source: APXvYqwY3N84rCBNFuz8G1jV225O+PMTG8EA/DtUEwj7cjc93yB0Ou5HGOtzjUvFQMbnO7611QXSKA==
X-Received: by 2002:a63:6a08:: with SMTP id f8mr36040150pgc.165.1552405698474;
        Tue, 12 Mar 2019 08:48:18 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id f192sm24468352pfc.180.2019.03.12.08.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:48:17 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9055: Convert to regulator core's simplified DT parsing code
Date:   Tue, 12 Mar 2019 23:47:59 +0800
Message-Id: <20190312154759.13774-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312154759.13774-1-axel.lin@ingics.com>
References: <20190312154759.13774-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9055-regulator.c | 67 +++-------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 3c6fac793658..b7b4dddf5509 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -338,6 +338,8 @@ static const struct regulator_ops da9055_ldo_ops = {
 {\
 	.reg_desc = {\
 		.name = #_id,\
+		.of_match = of_match_ptr(#_id),\
+		.regulators_node = of_match_ptr("regulators"),\
 		.ops = &da9055_ldo_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9055_ID_##_id,\
@@ -366,6 +368,8 @@ static const struct regulator_ops da9055_ldo_ops = {
 {\
 	.reg_desc = {\
 		.name = #_id,\
+		.of_match = of_match_ptr(#_id),\
+		.regulators_node = of_match_ptr("regulators"),\
 		.ops = &da9055_buck_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9055_ID_##_id,\
@@ -507,59 +511,6 @@ static inline struct da9055_regulator_info *find_regulator_info(int id)
 	return NULL;
 }
 
-#ifdef CONFIG_OF
-static struct of_regulator_match da9055_reg_matches[] = {
-	{ .name = "BUCK1", },
-	{ .name = "BUCK2", },
-	{ .name = "LDO1", },
-	{ .name = "LDO2", },
-	{ .name = "LDO3", },
-	{ .name = "LDO4", },
-	{ .name = "LDO5", },
-	{ .name = "LDO6", },
-};
-
-static int da9055_regulator_dt_init(struct platform_device *pdev,
-				    struct da9055_regulator *regulator,
-				    struct regulator_config *config,
-				    int regid)
-{
-	struct device_node *nproot, *np;
-	int ret;
-
-	nproot = of_node_get(pdev->dev.parent->of_node);
-	if (!nproot)
-		return -ENODEV;
-
-	np = of_get_child_by_name(nproot, "regulators");
-	if (!np)
-		return -ENODEV;
-
-	ret = of_regulator_match(&pdev->dev, np, &da9055_reg_matches[regid], 1);
-	of_node_put(nproot);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error matching regulator: %d\n", ret);
-		return ret;
-	}
-
-	config->init_data = da9055_reg_matches[regid].init_data;
-	config->of_node = da9055_reg_matches[regid].of_node;
-
-	if (!config->of_node)
-		return -ENODEV;
-
-	return 0;
-}
-#else
-static inline int da9055_regulator_dt_init(struct platform_device *pdev,
-				       struct da9055_regulator *regulator,
-				       struct regulator_config *config,
-				       int regid)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_OF */
-
 static int da9055_regulator_probe(struct platform_device *pdev)
 {
 	struct regulator_config config = { };
@@ -580,18 +531,12 @@ static int da9055_regulator_probe(struct platform_device *pdev)
 	}
 
 	regulator->da9055 = da9055;
-	config.dev = &pdev->dev;
+	config.dev = da9055->dev;
 	config.driver_data = regulator;
 	config.regmap = da9055->regmap;
 
-	if (pdata) {
+	if (pdata)
 		config.init_data = pdata->regulators[pdev->id];
-	} else {
-		ret = da9055_regulator_dt_init(pdev, regulator, &config,
-					       pdev->id);
-		if (ret < 0)
-			return ret;
-	}
 
 	ret = da9055_gpio_init(regulator, &config, pdata, pdev->id);
 	if (ret < 0)
-- 
2.17.1

