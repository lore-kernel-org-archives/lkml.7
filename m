Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D1C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761D9217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="McgM5h/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDKB7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:59:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35685 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDKB7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:59:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so2537613plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 18:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DrevsH0dd7zYeHPKVruK4Dh9c/U5um+nzdIZSxK7Blo=;
        b=McgM5h/eX/cQru0WtH7bMyIVn2GWdg7V3sXDE+7LGX/l7tWC3IPb2TpS2tmgBN9gXY
         aY+WOIgZJ+NZBnArwPjC2b7ly4Hj8WPWra4+f2pYSHlu3xG/l389uT+3s6K7OY6ipT38
         F+rA+82m8KhQo0XPN2/G2TcIBQItoZLtEY9sXZ86DgoRLtFo1W0hskYRHcKqNM7aSR/g
         lQSJBC02oeK0+CeJ+ANlri+is50ij5A1ISbDUlupjTvLmmdjiZR2YtJYwWvRaMdGNSTx
         Xs4DKWV6AsWZ8LvoG8XXq4Tl5RAzu1igRj5Cgz3QRBKpAsUakTPu6GPgXuynekwy/CGt
         bJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DrevsH0dd7zYeHPKVruK4Dh9c/U5um+nzdIZSxK7Blo=;
        b=L8gSsN9C/x70LmYBrlwIr+kxm4SVgloslgABtCDJEuhPzzb66yFXkXOWHiwWVorAz4
         BLn9gj+XtgjeghZol3Kz+tbEgmlsr8w/IhKC4qsQ2d8QpSY4kMK/Ap1ETjDstB0+iEkE
         mQ0wE+HC6oYvC1UY24E07HM4Gwe32+N0x5rxiBFhAaeWyCVxIE4AZ4eu8/E9Z26dLRRg
         1Zqi8DInaP203EWTz+3tMvpD0wyqSurwkEW4p2OqrgCwCZCugOE+UPydPNhhdNAnc8fZ
         BHybHM8ySRkWr6K7aXksTABC6ueSTxRN8RdUcN0lUcJYbN/hHxGDUZmalhtpZezUHpVZ
         KEJA==
X-Gm-Message-State: APjAAAULfKIFwlD3svzQIHzY9FEw5FwKibNPn12laq8oObgChItBTbr5
        pbIZy6riiMvimneqDKo7HY5dLQ==
X-Google-Smtp-Source: APXvYqyq0GJQdU18yV2jjJiPYSuT94TZPIsqDPNloeuSbUWhyqM6XZB2vAfZ0oE//2VKoZdclEj4+A==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr47231025plm.202.1554947978181;
        Wed, 10 Apr 2019 18:59:38 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e193sm6612532pgc.53.2019.04.10.18.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 18:59:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: mcp16502: Remove setup_regulators function
Date:   Thu, 11 Apr 2019 09:59:23 +0800
Message-Id: <20190411015923.7157-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411015923.7157-1-axel.lin@ingics.com>
References: <20190411015923.7157-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a little bit odd current code pass struct regulator_config rather
than a pointer to setup_regulators. The setup_regulators is so simple and
only has one caller, so remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 37 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 9292ab8736c7..e5a02711cb46 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -427,36 +427,15 @@ static const struct regmap_config mcp16502_regmap_config = {
 	.wr_table	= &mcp16502_yes_reg_table,
 };
 
-/*
- * set_up_regulators() - initialize all regulators
- */
-static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
-			    struct regulator_config config)
-{
-	struct regulator_dev *rdev;
-	int i;
-
-	for (i = 0; i < NUM_REGULATORS; i++) {
-		rdev = devm_regulator_register(dev, &mcp16502_desc[i], &config);
-		if (IS_ERR(rdev)) {
-			dev_err(dev,
-				"failed to register %s regulator %ld\n",
-				mcp16502_desc[i].name, PTR_ERR(rdev));
-			return PTR_ERR(rdev);
-		}
-	}
-
-	return 0;
-}
-
 static int mcp16502_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	struct device *dev;
 	struct mcp16502 *mcp;
 	struct regmap *rmap;
-	int ret = 0;
+	int i, ret;
 
 	dev = &client->dev;
 	config.dev = dev;
@@ -482,9 +461,15 @@ static int mcp16502_probe(struct i2c_client *client,
 		return PTR_ERR(mcp->lpm);
 	}
 
-	ret = setup_regulators(mcp, dev, config);
-	if (ret != 0)
-		return ret;
+	for (i = 0; i < NUM_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev, &mcp16502_desc[i], &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev,
+				"failed to register %s regulator %ld\n",
+				mcp16502_desc[i].name, PTR_ERR(rdev));
+			return PTR_ERR(rdev);
+		}
+	}
 
 	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
 
-- 
2.17.1

