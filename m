Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC419C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE7521874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0A8vzPEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCUMBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:01:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44465 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:00:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so4033770pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TscW1eDX80dzlSVeGXE1WWMUcyOADw0SvtB+O9khGMQ=;
        b=0A8vzPErvtsHTyZpIZOcm7t5CSLyYEN1MrQmGw+my7pbso/LD98Mzm+gG3hijuE0Ad
         xBjRVuCFAp38YSaGjpIpX6Th14vI3U6enrC58VuhYSGU5xnt6qbfBgmHCbLkrgvHiLaP
         R0o3pBGKn00jA7qgW84wmmjWvWG6B2a1c+vUjeAMpKK9cYng9bLujL8QCeJYu8q4LwhO
         uh9bdC2ln7+4iM5vhHpDs2cp44qTk4hu7WwrwgL9FGB03pEHXCcEMgN8QUik9O3g2VoR
         tPM9kmxKiahhSC8X4LtrJP3jTApy01J+AA4IyN3kOQCVzpIf8RhpDOSNO6xydU01LHyC
         UDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TscW1eDX80dzlSVeGXE1WWMUcyOADw0SvtB+O9khGMQ=;
        b=ffAftiTsrBRYHcI0gQQmh/clMJ1K9I6Bjg/Dx7zllsygx6kkEByEaiUokpqPIAq9gL
         C6u6AJsdT7KyuLY1w4oueLkOSg+Yu+7PyfpGbH5i3VIo695gprGZpW6Yq0pwUtyQnkl3
         v2IMuIrYEchAIrOtA4/4ysbh8ZPTXR54xC71BdI07uMCLpoIl42Q4yILxnyaA6IoOIsO
         fcwNrmL900X9wJhz/bRc7+uincb/A0wtdW1bcnznS5n7Cruc8AqU7+CEcnmgcI5pYhLH
         gvpgOScoTvTRSqi4zUFUqHpSYBqDyiu23Yj3x1kJO03OFjZBnbuuj9DfgtIuHcEUMOs+
         5Utw==
X-Gm-Message-State: APjAAAV+Su1jOFRgVZy/26kUBHBsCFhGy5+GB32/5/MCPk2uqaTwKUXt
        0PfQqvymDgXnssHrFV9c8QLbHw==
X-Google-Smtp-Source: APXvYqzZRKYbHN1qzSJy41APX0hOSl++HWuDw2mJm/JtOs5LPpCqrWUBwjuxiJTJcVwAI0TCcRa3DQ==
X-Received: by 2002:a65:5c49:: with SMTP id v9mr3028275pgr.150.1553169658290;
        Thu, 21 Mar 2019 05:00:58 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id 71sm8256258pgc.23.2019.03.21.05.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 05:00:57 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: tps65132: Remove unneeded fields from struct tps65132_regulator
Date:   Thu, 21 Mar 2019 20:00:37 +0800
Message-Id: <20190321120038.12013-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fields are not really need, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65132-regulator.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 73978dd440f7..1f627e161b99 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -55,10 +55,7 @@ struct tps65132_reg_pdata {
 
 struct tps65132_regulator {
 	struct device *dev;
-	struct regmap *rmap;
-	struct regulator_desc *rdesc[TPS65132_MAX_REGULATORS];
 	struct tps65132_reg_pdata reg_pdata[TPS65132_MAX_REGULATORS];
-	struct regulator_dev *rdev[TPS65132_MAX_REGULATORS];
 };
 
 static int tps65132_regulator_enable(struct regulator_dev *rdev)
@@ -225,6 +222,8 @@ static int tps65132_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct tps65132_regulator *tps;
+	struct regulator_dev *rdev;
+	struct regmap *rmap;
 	struct regulator_config config = { };
 	int id;
 	int ret;
@@ -233,9 +232,9 @@ static int tps65132_probe(struct i2c_client *client,
 	if (!tps)
 		return -ENOMEM;
 
-	tps->rmap = devm_regmap_init_i2c(client, &tps65132_regmap_config);
-	if (IS_ERR(tps->rmap)) {
-		ret = PTR_ERR(tps->rmap);
+	rmap = devm_regmap_init_i2c(client, &tps65132_regmap_config);
+	if (IS_ERR(rmap)) {
+		ret = PTR_ERR(rmap);
 		dev_err(dev, "regmap init failed: %d\n", ret);
 		return ret;
 	}
@@ -244,18 +243,16 @@ static int tps65132_probe(struct i2c_client *client,
 	tps->dev = dev;
 
 	for (id = 0; id < TPS65132_MAX_REGULATORS; ++id) {
-		tps->rdesc[id] = &tps_regs_desc[id];
-
-		config.regmap = tps->rmap;
+		config.regmap = rmap;
 		config.dev = dev;
 		config.driver_data = tps;
 
-		tps->rdev[id] = devm_regulator_register(dev,
-					tps->rdesc[id], &config);
-		if (IS_ERR(tps->rdev[id])) {
-			ret = PTR_ERR(tps->rdev[id]);
+		rdev = devm_regulator_register(dev, &tps_regs_desc[id],
+					       &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
 			dev_err(dev, "regulator %s register failed: %d\n",
-				tps->rdesc[id]->name, ret);
+				tps_regs_desc[id].name, ret);
 			return ret;
 		}
 	}
-- 
2.17.1

