Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A65214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="dPf9WX4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCLPsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:48:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCLPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:48:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id m2so2130617pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=M7k1LWZlXu3jhaMlK15KgNsdQeYJfXIqJs9bsZio158=;
        b=dPf9WX4I6EHX/69ysyyGiaC+kBilkKcEz26WstpLoC2Fr+CP1IC90fFbKR+nhg3zyb
         P1zCLoL7xd4Jy5SPk09exiRYjgVK9OeWFbzFX+CJlC1N3E+b7DayJrSNGnWH7GBioCfV
         UZxRspxW4dFpbS7k48ToGap8AXYkZ+7pf8rMfTI5+H3s7Iu0QNL8GRSikRbouDcKPLms
         itAuFxYCEaVLLdUGHgVm+vT8qtNdmLuBqz0I/7CgPIGHUFeKauUluzJ3L93O64eeh1kj
         sg5+bXUgZp8El6M82gvSabrQhkXYRqhRaO9XVfYyepJwwhbEN0ojLnVt1lkqdMkKfcKx
         RRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M7k1LWZlXu3jhaMlK15KgNsdQeYJfXIqJs9bsZio158=;
        b=O/bNHNsjQDoBbGpIxGcpBMH9+fCvED2GAzbYX/QMloey8+ynN0KnyCSpaLEZGUeRxX
         IGEQzdB7KxF9QUllAxpkJrXi7jIWeiO3auA9yQruCoRSG1l4jVaozwVt2MpsD3fobcoq
         tVWu/k+r07hH71v7qKz6ImqnCf966HIz8R4mLM6X3ALJSDZzKEMKQNadJAym1mvA563k
         ptekbJj1b0X+LF2w4dcL+nvCc18y3N6eiJfXBvZChOf+DJVRXXr4c7clEJWFvJ6r7Ku3
         MopXYDsKRrOJ2iV9IMIgaqepUPL9tq3SHTw6ij/JVsdZeZ7y3LshYlfu+cxGCACxDnTh
         XiwQ==
X-Gm-Message-State: APjAAAWf1pXLr32PnlYcKnvR6iCAlHivhk6k0swLHiGhsbXdMf/FHwgL
        EgUVlI4rDxI9Mr5oG6Kf0zxuUg==
X-Google-Smtp-Source: APXvYqyVhFKahZMCM3+2SU2cUvwZJMHrv9k/YqzV19KUOBCJadYA5y2iOlijGW3i9Ysn5Hlgch+I5g==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr10897731plf.330.1552405695864;
        Tue, 12 Mar 2019 08:48:15 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id f192sm24468352pfc.180.2019.03.12.08.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:48:14 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: da9052: Convert to regulator core's simplified DT parsing code
Date:   Tue, 12 Mar 2019 23:47:58 +0800
Message-Id: <20190312154759.13774-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have this h/w, so please help testing it.
Thanks,
Axel

 drivers/regulator/da9052-regulator.c | 33 +++++-----------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index cefa3558236d..98d486372b8c 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -294,6 +294,8 @@ static const struct regulator_ops da9052_ldo_ops = {
 {\
 	.reg_desc = {\
 		.name = #_name,\
+		.of_match = of_match_ptr(#_name),\
+		.regulators_node = of_match_ptr("regulators"),\
 		.ops = &da9052_ldo_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -314,6 +316,8 @@ static const struct regulator_ops da9052_ldo_ops = {
 {\
 	.reg_desc = {\
 		.name = #_name,\
+		.of_match = of_match_ptr(#_name),\
+		.regulators_node = of_match_ptr("regulators"),\
 		.ops = &da9052_dcdc_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -417,36 +421,11 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	config.dev = &pdev->dev;
+	config.dev = da9052->dev;
 	config.driver_data = regulator;
 	config.regmap = da9052->regmap;
-	if (pdata) {
+	if (pdata)
 		config.init_data = pdata->regulators[cell->id];
-	} else {
-#ifdef CONFIG_OF
-		struct device_node *nproot = da9052->dev->of_node;
-		struct device_node *np;
-
-		if (!nproot)
-			return -ENODEV;
-
-		nproot = of_get_child_by_name(nproot, "regulators");
-		if (!nproot)
-			return -ENODEV;
-
-		for_each_child_of_node(nproot, np) {
-			if (of_node_name_eq(np,
-					 regulator->info->reg_desc.name)) {
-				config.init_data = of_get_regulator_init_data(
-					&pdev->dev, np,
-					&regulator->info->reg_desc);
-				config.of_node = np;
-				break;
-			}
-		}
-		of_node_put(nproot);
-#endif
-	}
 
 	regulator->rdev = devm_regulator_register(&pdev->dev,
 						  &regulator->info->reg_desc,
-- 
2.17.1

