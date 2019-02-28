Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8995BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0A22171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="kdBh48IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfB1NlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32980 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbfB1NlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so9805891plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CUId/4aLHLz2W4p4NH5icc1gKNfqgcQjHhLUY8ec5l0=;
        b=kdBh48IV5llxWKNrXYX7BDfccY29OXgIlJ5BNPQbB7Qxmo+NmDyTG+3cth4OVQtdMv
         RxsZNypXxmfMJbd7jBQWVKGbvl1HkpPFojw/RwcEL4letd5vDjatpQtr6uUWgao5kJ0A
         AlamDG+Gt6QqxnlHwuVi4Y2TdCOo50asE/sJM4SHyAY4Sfi1ciFOop9H3qfl6f0TH2hu
         Dp6sM6KbefrZa3x04Qtkaw6WIoAgwjOy6LMs+L8FyhNVAFgTlrhS0890qAJElMXp/wmk
         V/6uNzpR/kpEgX+ue4izyyE8sHN4iUX8K+w3vJyicoqHPtTBhra7yxATaDT93TZybvpp
         pxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CUId/4aLHLz2W4p4NH5icc1gKNfqgcQjHhLUY8ec5l0=;
        b=AB/6LZohLGRCNi0YdS0L/anRua6KG8SRBQ22U63bfj4vQupzgIFI+TVlvEooN44HJu
         szhfRmBBcYZE4nXk9y9Xhz8lzG/6hI55ZXPnZhlrIV7pS15MIg3Uy22lhZKXuoNhs/rM
         P9zpngYqa3Yn5penLEBd9ZjZSe1MLtsMc0lE39IAfxIrmi2xNzeQhuCYliNR6yZNb4wt
         hQZ0oSvFZyBTrXQc1JxF7dkERmQzh3wQx/EQ0N8xsOWHaIB5RQLuHS9IosuiZhytJ3SF
         ENNkNKgz8gbBTPngm9yzxbW18HyIbnMhK928xDOJS8ednhTZY6dC+MDdgxqs0aKjPUn9
         rBQQ==
X-Gm-Message-State: AHQUAuarR0Mk6IcunkWwuJs3NoeCrzuztMFBxzhY6B1mm62HYubFvwDA
        ZkUglt972ypFWEh7/l0kY/k7lg==
X-Google-Smtp-Source: AHgI3IY+9zog1HyPMsuGVAMO+oPkocjD17fLivG8bcTo91OhJgntTAzo6ptyGHoJZg3dDN8Ngh3nGA==
X-Received: by 2002:a17:902:129:: with SMTP id 38mr8095680plb.140.1551361265295;
        Thu, 28 Feb 2019 05:41:05 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:04 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 05/11] regulator: lp872x: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:16 +0800
Message-Id: <20190228134022.32625-6-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228134022.32625-1-axel.lin@ingics.com>
References: <20190228134022.32625-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp872x.c | 70 ++++++--------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index f8f875bad7dd..ca95257ce252 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -353,64 +353,6 @@ static int lp872x_buck_get_voltage_sel(struct regulator_dev *rdev)
 	return val & LP872X_VOUT_M;
 }
 
-static int lp8725_buck_set_current_limit(struct regulator_dev *rdev,
-					int min_uA, int max_uA)
-{
-	struct lp872x *lp = rdev_get_drvdata(rdev);
-	enum lp872x_regulator_id buck = rdev_get_id(rdev);
-	int i;
-	u8 addr;
-
-	switch (buck) {
-	case LP8725_ID_BUCK1:
-		addr = LP8725_BUCK1_VOUT2;
-		break;
-	case LP8725_ID_BUCK2:
-		addr = LP8725_BUCK2_VOUT2;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	for (i = ARRAY_SIZE(lp8725_buck_uA) - 1; i >= 0; i--) {
-		if (lp8725_buck_uA[i] >= min_uA &&
-			lp8725_buck_uA[i] <= max_uA)
-			return lp872x_update_bits(lp, addr,
-						  LP8725_BUCK_CL_M,
-						  i << LP8725_BUCK_CL_S);
-	}
-
-	return -EINVAL;
-}
-
-static int lp8725_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	struct lp872x *lp = rdev_get_drvdata(rdev);
-	enum lp872x_regulator_id buck = rdev_get_id(rdev);
-	u8 addr, val;
-	int ret;
-
-	switch (buck) {
-	case LP8725_ID_BUCK1:
-		addr = LP8725_BUCK1_VOUT2;
-		break;
-	case LP8725_ID_BUCK2:
-		addr = LP8725_BUCK2_VOUT2;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = lp872x_read_byte(lp, addr, &val);
-	if (ret)
-		return ret;
-
-	val = (val & LP8725_BUCK_CL_M) >> LP8725_BUCK_CL_S;
-
-	return (val < ARRAY_SIZE(lp8725_buck_uA)) ?
-			lp8725_buck_uA[val] : -EINVAL;
-}
-
 static int lp872x_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct lp872x *lp = rdev_get_drvdata(rdev);
@@ -513,8 +455,8 @@ static const struct regulator_ops lp8725_buck_ops = {
 	.enable_time = lp872x_regulator_enable_time,
 	.set_mode = lp872x_buck_set_mode,
 	.get_mode = lp872x_buck_get_mode,
-	.set_current_limit = lp8725_buck_set_current_limit,
-	.get_current_limit = lp8725_buck_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_desc lp8720_regulator_desc[] = {
@@ -712,6 +654,10 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
 		.owner = THIS_MODULE,
 		.enable_reg = LP872X_GENERAL_CFG,
 		.enable_mask = LP8725_BUCK1_EN_M,
+		.curr_table = lp8725_buck_uA,
+		.n_current_limits = ARRAY_SIZE(lp8725_buck_uA),
+		.csel_reg = LP8725_BUCK1_VOUT2,
+		.csel_mask = LP8725_BUCK_CL_M,
 	},
 	{
 		.name = "buck2",
@@ -724,6 +670,10 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
 		.owner = THIS_MODULE,
 		.enable_reg = LP872X_GENERAL_CFG,
 		.enable_mask = LP8725_BUCK2_EN_M,
+		.curr_table = lp8725_buck_uA,
+		.n_current_limits = ARRAY_SIZE(lp8725_buck_uA),
+		.csel_reg = LP8725_BUCK2_VOUT2,
+		.csel_mask = LP8725_BUCK_CL_M,
 	},
 };
 
-- 
2.17.1

