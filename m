Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4CEC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912F6217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICfWIVfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfEVBPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:15:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39461 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfEVBPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:15:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so376432pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgkPEB5XZ9b9X9cOU2xEF1BiqUs2NT/hLhDQBCKndyY=;
        b=ICfWIVfagetutSTP2wJda5tntZ8oDmNuRYEHtIPXtdZzblw9wcwSioYM0Cl1uKgkyF
         eJrq8x30tUjUiVJEBeuEd9L85/PFaHhXwWMjpn7vaV1+M+wlxyrehiIS3gi6zDtjpq1L
         xzg91FyV/tV0HK5AFOt2jNiDTc+/0XPZfAP9f1e24a7tRWBC0fYvNU3NCzvMrvlIQv6L
         b9nmQy2ntC5zKewyeT1UrrN/oNPxmokx7+8J0II081WOZUXWNLUDrQLiDU2dX6RxQ3h5
         UTBsgH9nKnYynRkx4mvTI26Rb00Pt2Guq1VdML4bEstoJaBj06kEcJNeUqHxWP753buF
         /yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zgkPEB5XZ9b9X9cOU2xEF1BiqUs2NT/hLhDQBCKndyY=;
        b=bEg/mNRVMVyRpkEiMHzEr68dfaDR9lp4YZeXHhy/sVq6BWLEFB1o7o2AwR4DIkx9RC
         96KJVItAiIiaSPHFy6o4ugszjU1I2KDrVKwms6yl+DBSzGYHGv7IcGrokRQ1tikjR4lr
         otaC7/2tgdeW6RaKMQDoudHPj8p8FcI7SwuQy90V5UHBtYIc1MiID5x1dMMF3NN90pHL
         Gi0dqXJO5M/if0akndi1Sb2fcHk2ENFwXj3ETTmpkhx8nQuM9HqHR8ZRiqDjidVrOcHM
         EpLISqlmFGD6fv7lK86yyHykViAoIQJDO5iiyCZ//p8FuYqZUJTy7V6wVAnAh7blkssA
         HYnA==
X-Gm-Message-State: APjAAAXyaY8PhclSLYztQ+S9wXOO4GVqXKGmYGQvKp1VIGiaK0pWK14a
        Jeurr8tFHWvv1CRApHXZXwbTvt5xqkw=
X-Google-Smtp-Source: APXvYqyx8/oA3ktN+AkwStd05O6l9Bb3JYPNrV5Ae9KzmW2T5Zkj8tfBYP+awEYofc0F9+pw0uAlhg==
X-Received: by 2002:a63:4c54:: with SMTP id m20mr87048720pgl.316.1558487740876;
        Tue, 21 May 2019 18:15:40 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e184sm31756061pfa.169.2019.05.21.18.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:15:40 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 1/3] clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
Date:   Wed, 22 May 2019 09:15:01 +0800
Message-Id: <20190522011504.19342-2-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522011504.19342-1-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resources() automatically requests resources and devm_ wrappers
do better error handling and unmapping of the I/O region when needed,
that would make drivers more clean and simple.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/clk/sprd/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index e038b0447206..9ce690999eaa 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -42,6 +42,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 	struct regmap *regmap;
+	struct resource *res;
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
@@ -50,7 +51,11 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			return PTR_ERR(regmap);
 		}
 	} else {
-		base = of_iomap(node, 0);
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
 		regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       &sprdclk_regmap_config);
 		if (IS_ERR_OR_NULL(regmap)) {
-- 
2.17.1

