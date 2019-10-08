Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F3C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A901B21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN9IOY1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfJHHmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:42:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45004 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfJHHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:41:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so8082543pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2fURBUxy7kUtYmeZp2XZ00W6cQyOn6QtabdpUGQ4D60=;
        b=eN9IOY1D4JQEhqeD44A6DLSptkIVd9EhQ/T4ofBMp9tMybypG0GD+jceTeEDFwcwV7
         pX90ySjQ5ypCgooLkJtxt3hhiI9btIxC2oZWRlJTA/XGY2xE465JEYP/jh6TVRHRbRei
         +iZFx52+vEmaikMY6Xd65ZTnvtPZZhVEITp09SG76jmRAi9ykhVh54pgk6wweIWH0A6k
         qZtrJhqn4zf9OSEs3ILwYWXfAdJ/tmC/KKvMP3qhdl5TIfCg2mwvzpbgxFFAB/Rklut/
         WC1HZnyvgj4kDwjviC8/NfJEL78LAc/JWbztrIUBvdsL14/6NBJ8/H6YV5r8icot/B+E
         9t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2fURBUxy7kUtYmeZp2XZ00W6cQyOn6QtabdpUGQ4D60=;
        b=cfgoW6/gfZmg9pz1uNy3XBkf3q//F8ivIZm9pEefmQWctYCQCjU/REqGueH361oAAO
         bhgjkpz6U8/7+/ETbeJzpZCbXXgf4+R6lpiAcP3nqGSw5j2q6u4xp+FFP2kehYkWiBR8
         ZfvHVyF2oz/z8OBn/VdVxudwr/Y0loRfoaWIt3z5yLHMCHE7yRC8Kpwx1Oxxuz5yrCvS
         y7/EKDlbj8LIyS/N3yWfiUn1gIwzbm401MFB/EPUpFyPrNNx0dDw/4XQeypOMwr553eh
         lRwKgJkvr2K6BnX7/Ah+u+7/Lp7A373qCPi4YjYS2jTXLsUwS5CaYkZKA9tbKCYZegBb
         AOjA==
X-Gm-Message-State: APjAAAWQjUVkWgFJZ16TBSy30QaNT7yIU/JflrCSpDv8i1I29txgCFDK
        U/J8F/z9moo099lCKcGoJJc2yA==
X-Google-Smtp-Source: APXvYqx4yx63wHZRg9innu1QmsE+S9mEbWtE9KI7zgBRFk/4iSCLPMEPKXa8fosu99z/4tYcXy5EOg==
X-Received: by 2002:a17:902:8c8d:: with SMTP id t13mr2644087plo.3.1570520519051;
        Tue, 08 Oct 2019 00:41:59 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y8sm18231363pge.21.2019.10.08.00.41.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 00:41:58 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: sprd: Change to use devm_platform_ioremap_resource()
Date:   Tue,  8 Oct 2019 15:41:39 +0800
Message-Id: <841d26a2adb4bf3b4423f82a41dd3f1346413db6.1570520268.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
References: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
In-Reply-To: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
References: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - None.
---
 drivers/clk/sprd/common.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 7ad5ba2..c0af477 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -42,7 +42,6 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 	struct regmap *regmap;
-	struct resource *res;
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
@@ -51,8 +50,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			return PTR_ERR(regmap);
 		}
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		base = devm_ioremap_resource(&pdev->dev, res);
+		base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
-- 
1.7.9.5

