Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1765521904
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="hD602jRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCPOgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:36:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:36:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so5547903pfn.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=f/xEf4d7jtACwjKyCGodv18qa48OZ5uXhFpxSzNQ4nw=;
        b=hD602jRIp1ifSbn7Cf/6ScYW/Uw5+ApS5W2ZU1Ckg45cd2IYMQjoKhYouAF0U0PUwy
         +pzRUGiPZ+OMmYUXmx5vkdj8/iOudWuspe2FBW1IkOeo7s9JmMl7DHsYe5H8FN00F58o
         hDAI0yDGjBH2FK992HzIETkQu32mBw08SXYCoqAN84KmtXk4193iBSrkfLB8Vv4uKAPf
         CQzC5gPaCh+GUBhQvd8p01//6hZM3xB1XPy5+Q88PqXqzuA+HjVwHbmgLfVIpAihqcwR
         PSiORh5wqlGDn3Op5m3HpLdWxK5UTtNkWlXgPnYpVBFeacQWuEQjTqiXV9wy2uKOmX4t
         NXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f/xEf4d7jtACwjKyCGodv18qa48OZ5uXhFpxSzNQ4nw=;
        b=bgwdqTVgvZRDfbJS/5MZtJPepKZlD3aQApNZ6RmRlKq1RC3h8IR/e0E/MWLhTN41I/
         6pr0VCMg+aQke3c8uWsDEx6yBxF27dEP1jSL9OxXSW1kXQqUTbOHecy+FtLfAJf/MSob
         8NT5O8aFfXQOxn5uyXnQZwkorWy4+nEXnF2OWJWRLYPNG/zjQdf0AMmDIvooiJlTN4ol
         gxx19auj3zvlwvCSefoPfekjWmtCeij2jQDNTwbMdP9i6EfxI7Eo/XnJ4WZkTP/c/DPE
         3F6F5sWADeBWcfMSpUcNv/qGhUWihidDYaeFmGoMoSa9zEe2X7F6q0FvaViPN5PZs/iT
         5VkA==
X-Gm-Message-State: APjAAAVoBnLBwPs2kkDY/JlidRi70laFl9dyrc2kFFfxxrlq2qvQGgMt
        Fq4sJYqCQNm9yoFy2weA9T3Kkw==
X-Google-Smtp-Source: APXvYqzroF9Iods0YtRx1WUdDluLnasjH3ve5+MHGgP4LLXhN53GUqgWjiZbs9HwW3JZkAR++nM2pA==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr8685726pgl.16.1552746970426;
        Sat, 16 Mar 2019 07:36:10 -0700 (PDT)
Received: from localhost.localdomain (36-239-209-125.dynamic-ip.hinet.net. [36.239.209.125])
        by smtp.gmail.com with ESMTPSA id r6sm5727479pgp.46.2019.03.16.07.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 07:36:09 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: cpcap: Remove unneeded init_data setting
Date:   Sat, 16 Mar 2019 22:35:57 +0800
Message-Id: <20190316143558.26620-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using regulator core's simplified DT parsing code,
so regulator will call regulator_of_get_init_data() to get init_data.
No need to set config.init_data. In additional, current code does not
properly set the init_data setting, so just remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/cpcap-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index e7dab5c4d1d1..c9d805d7a979 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -507,7 +507,6 @@ static int cpcap_regulator_probe(struct platform_device *pdev)
 	struct cpcap_ddata *ddata;
 	const struct of_device_id *match;
 	struct regulator_config config;
-	struct regulator_init_data init_data;
 	int i;
 
 	match = of_match_device(of_match_ptr(cpcap_regulator_id_table),
@@ -534,10 +533,8 @@ static int cpcap_regulator_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 
 	memset(&config, 0, sizeof(config));
-	memset(&init_data, 0, sizeof(init_data));
 	config.dev = &pdev->dev;
 	config.regmap = ddata->reg;
-	config.init_data = &init_data;
 
 	for (i = 0; i < CPCAP_NR_REGULATORS; i++) {
 		const struct cpcap_regulator *regulator = &ddata->soc[i];
-- 
2.17.1

