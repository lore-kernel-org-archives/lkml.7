Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5975CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B95D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="XoIQBeH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfCLPw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:52:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45713 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfCLPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:52:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id 125so2115698pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=P3whinzO+RjQuNihU8Txak/JqmSS/8Xm17HIFga/4Gg=;
        b=XoIQBeH614FnwKU/o2+T69v4Kg2r0soqCPgdtvqwu8Ob3H5zJbm1zfQOwdhMV4yCYL
         E8h2qVBRWEZpoknOGaesg59TccVWraZjHzxwa91qO7PROgRoqspPcgTFFoJH1taGtZEj
         5n143EV2V98aV+5IDCkB9DWzaCe+pkRkSUeTgYHbjEGzo5nuHE1P9/sWhe6qPCIz01ge
         d6ubPVsemyGYMNlBdQUTVQK0tJ7jlu17YQkAkzUKZjfl0kFC8lT1vOPtXkn8Qg5XfwLX
         y51xytLWoEx3LmnxCSV3tGuvye/hKiDWO2EXrZ1rTEHDOQYsGG5/P4JU8hrNBrZwHbKt
         MBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P3whinzO+RjQuNihU8Txak/JqmSS/8Xm17HIFga/4Gg=;
        b=rQVZFtLxXD36QUeK157I82G57c3Kz/w8Xj2Hfq53DumouYDfGK2nlwNKP3n5zgnzm/
         PN4/doM8p07v7xz4YjXcw7NM9hgy5aeWlKkNifNaDRqixS89Yp/fW2BqcDDPms8qy8Kw
         gEb6LiRdi17UD/2bFCUdUY+c4HG6+N22o5GzrUp7XYunfvmSwmNExLr4b8JWnXgijmh3
         ELs8M8fghPCLBSWJXB0ULZly7JUvZw4Vd16QpSeg3jzdpADvXWZSkpjSgli7xEDZRT9y
         IMBXA9ppvZlQ0njqVGz2BfsgEijmomJTq1zv9XArvCiBqDMLb7Tedamkx961tEbcvLjx
         NU8g==
X-Gm-Message-State: APjAAAXZK2XPqSaI+npM/6kah1aGW3l+Vkw14JQcVDvx0L3x2DDe7gwG
        dCTzH7jay3KZZ+ttHwr1gC87PcMLvXGyFQ==
X-Google-Smtp-Source: APXvYqwLxWHhC0ag1D6zAJ6JJS5GXbtg/oA9TI8o+UvFmj5yi8HwYtbeXHvXYrdUmS0TGnFzd04hCg==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr39720975plb.198.1552405973531;
        Tue, 12 Mar 2019 08:52:53 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id y22sm12116647pfn.136.2019.03.12.08.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:52:52 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max14577: Get rid of match_init_data/match_of_node functions
Date:   Tue, 12 Mar 2019 23:52:41 +0800
Message-Id: <20190312155241.17277-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has been converted to use regulator core's simplified DT
parsing code. So the match_init_data/match_of_node functions are not
necessary now, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max14577-regulator.c | 55 --------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 85a88a9e4d42..07a150c9bbf2 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -155,58 +155,6 @@ static const struct regulator_desc max77836_supported_regulators[] = {
 	[MAX77836_LDO2] = MAX77836_LDO_REG(2),
 };
 
-#ifdef CONFIG_OF
-static struct of_regulator_match max14577_regulator_matches[] = {
-	{ .name	= "SAFEOUT", },
-	{ .name = "CHARGER", },
-};
-
-static struct of_regulator_match max77836_regulator_matches[] = {
-	{ .name	= "SAFEOUT", },
-	{ .name = "CHARGER", },
-	{ .name = "LDO1", },
-	{ .name = "LDO2", },
-};
-
-static inline struct regulator_init_data *match_init_data(int index,
-		enum maxim_device_type dev_type)
-{
-	switch (dev_type) {
-	case MAXIM_DEVICE_TYPE_MAX77836:
-		return max77836_regulator_matches[index].init_data;
-
-	case MAXIM_DEVICE_TYPE_MAX14577:
-	default:
-		return max14577_regulator_matches[index].init_data;
-	}
-}
-
-static inline struct device_node *match_of_node(int index,
-		enum maxim_device_type dev_type)
-{
-	switch (dev_type) {
-	case MAXIM_DEVICE_TYPE_MAX77836:
-		return max77836_regulator_matches[index].of_node;
-
-	case MAXIM_DEVICE_TYPE_MAX14577:
-	default:
-		return max14577_regulator_matches[index].of_node;
-	}
-}
-#else /* CONFIG_OF */
-static inline struct regulator_init_data *match_init_data(int index,
-		enum maxim_device_type dev_type)
-{
-	return NULL;
-}
-
-static inline struct device_node *match_of_node(int index,
-		enum maxim_device_type dev_type)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
-
 /**
  * Registers for regulators of max77836 use different I2C slave addresses so
  * different regmaps must be used for them.
@@ -265,9 +213,6 @@ static int max14577_regulator_probe(struct platform_device *pdev)
 		if (pdata && pdata->regulators) {
 			config.init_data = pdata->regulators[i].initdata;
 			config.of_node = pdata->regulators[i].of_node;
-		} else {
-			config.init_data = match_init_data(i, dev_type);
-			config.of_node = match_of_node(i, dev_type);
 		}
 		config.regmap = max14577_get_regmap(max14577,
 				supported_regulators[i].id);
-- 
2.17.1

