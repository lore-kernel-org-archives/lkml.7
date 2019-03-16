Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA186C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B245321916
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FGjrw2AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCPOgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:36:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36342 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:36:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so1493585pff.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ma8ToWIh2Q4ntHbn/E6N2vOLZIQ60K0FwKGV2yq0Kuo=;
        b=FGjrw2ALclBcpnr/tgsPjugkPXFPHbyidDawrh2CKmWH82B6B1OcBqq5sLpwHh/KD+
         KHOekSBDRzNSFV1ImS1RqI2+iaSHJppEzCFti3Jd0nEL8vOjVJb9jyaEsM89veQuS+Lo
         zX5Tj3ISWVciu7s4QIDVU8sl3+dgAY4SK3jpiYHWLubbeUHfqtVeCk1ubiWs6s/3Qnan
         BSfkiXSlrkgPsuko7ZNK2PmZUtrzgcPK/lBGnSght+XjEw9YT22yZbMw4SWztvVLJiI6
         M2k0B2QmEPKcLxESH7g5UrKvSrq4DU7JMe355SxJgXu9HWBTOd3bTJi1BraaBZ3sP/91
         vgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ma8ToWIh2Q4ntHbn/E6N2vOLZIQ60K0FwKGV2yq0Kuo=;
        b=Z+TGWYEaFpQWvAEF1YkJI2xFWxJ0hpejws9FhXT1Aphzy9T1uEIeaIGCueFQ4XrVAN
         ZuxomWHr39oTbGNCpRVCZdbKYW0qa7Y36HQ9yM6qmpHbdf0/YqBu9dvDt9+JLSjrTYMG
         6kUZG0vHB/lg0vnZPWWPSrZFZVM4/u7JpiaMMIGldhyghlZUCJPJRyqh8l548kRQd1qW
         22UlbyMknHwR0MOoolaWSEnUX2GqEkDAR1d8n4VohHGsV3x+O1O++1ErqpTdgE09Nbpw
         7ObcIx5xVNU4cMJRaQy9IMD8Z23oBodhBrK0K/ddT9Si2zRBUr0oVd9ORUs5UnYFb9oP
         3zLg==
X-Gm-Message-State: APjAAAXQ0427/aJhwaoWM7PKVY4NC6ynI2396adVztgREm2tgAylJsmt
        KgD2bIgC9/M+RCzGcG+G0DXOgA==
X-Google-Smtp-Source: APXvYqwqeF0Wm5cwU9HqjgWvxGc09SMH5Zu22+cz62f1Dr7PUaN58aN9vmbAGzhOZAOilW09DOq4Og==
X-Received: by 2002:a62:6d81:: with SMTP id i123mr9639922pfc.235.1552746973414;
        Sat, 16 Mar 2019 07:36:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-209-125.dynamic-ip.hinet.net. [36.239.209.125])
        by smtp.gmail.com with ESMTPSA id r6sm5727479pgp.46.2019.03.16.07.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 07:36:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: cpcap: Convert to use of_device_get_match_data
Date:   Sat, 16 Mar 2019 22:35:58 +0800
Message-Id: <20190316143558.26620-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316143558.26620-1-axel.lin@ingics.com>
References: <20190316143558.26620-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/cpcap-regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c9d805d7a979..d3284361e594 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -505,16 +505,12 @@ MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
 static int cpcap_regulator_probe(struct platform_device *pdev)
 {
 	struct cpcap_ddata *ddata;
-	const struct of_device_id *match;
+	const struct cpcap_regulator *match_data;
 	struct regulator_config config;
 	int i;
 
-	match = of_match_device(of_match_ptr(cpcap_regulator_id_table),
-				&pdev->dev);
-	if (!match)
-		return -EINVAL;
-
-	if (!match->data) {
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data) {
 		dev_err(&pdev->dev, "no configuration data found\n");
 
 		return -ENODEV;
@@ -529,7 +525,7 @@ static int cpcap_regulator_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	ddata->dev = &pdev->dev;
-	ddata->soc = match->data;
+	ddata->soc = match_data;
 	platform_set_drvdata(pdev, ddata);
 
 	memset(&config, 0, sizeof(config));
-- 
2.17.1

