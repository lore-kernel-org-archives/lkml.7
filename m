Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DE12084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="mz+kSZVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfCAGYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:24:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45884 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCAGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:24:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so10914973pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 22:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=iAzg2Q8cWeZyhce41BRki32Gq8ebOPoAL0+7Mg9Sob4=;
        b=mz+kSZVuXvt167L8j4mG3bSf4m/BUUUfkb4D/dHUl6sm8l5XKJJKBZix3YSWOoWKFQ
         82Kn8wuiDXfF/krH3D/94+3ci/3lWnfy6NWnw0k9xwE5RJvF9/7g8PL6lGiIhm+V1Vww
         TyA3+Qgh9Eu5sUdWwvcUjstUvmuEGHVfMRc5Y3fDyiifk6tBuUVPWmLethCEd+/7ugM9
         hY/4+MYr9nie86V4nt8vtCOSHFAF/rXxeggihzf6VkC9e0vVJSTumhexFxYOSC8nzEuh
         k5QgRLiOhJo1FpTWDv4ZD+qEYUUFc9JOhOU21xKEtBU36QbCCzmRJ3Sx4HQOvvde6jeX
         0gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iAzg2Q8cWeZyhce41BRki32Gq8ebOPoAL0+7Mg9Sob4=;
        b=enwmHS4sfoqAjkYJ1D6KE1P4H5fVvB5IJ0Pi1f5Ad5mVfg0IIJNt6Km2/91sLfL6WK
         4E3pp6YqilVMBzLEwlu5xKw9K4CDiEc8f1Q3XfHe/HQExWaecntKvzkp7fy6g/d5UZZZ
         BtPbI42C9CqGXaZmYHfujYvJXlabh8HWZp+pJ+aFV7hemc+5KHI+setafm5tLJwKglfh
         r2FTo/0bUWcNRaWPN0PJU6SrJAOBK/pYw0JFUDnBzGK1HQu97P0qZBE3bMkBVkW40Ove
         wsE39/z4h831wGrMRRBEeuPjG139U7HDB+3959qq+3+NKRkmVWLE/7Sph8YDZQXpMTcw
         3sOA==
X-Gm-Message-State: AHQUAuZY/M7EFZfMYP2UI6HxSeWwWcpLmEVtTe+9e74IVhZPWm4J4gh6
        SUXSemsR5o4xITrXVo/AcLPtQQ==
X-Google-Smtp-Source: AHgI3IZZr7FwylaTWCNaV6EYhLPRwKIrjv1zyzPzAb0IttgGaZk1Q5GhN1PYYCD1C4PoQfMtFvzx5w==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr3977806pfa.130.1551421488266;
        Thu, 28 Feb 2019 22:24:48 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e303-1426-0ded-295b-b15d-4a53.emome-ip6.hinet.net. [2001:b400:e303:1426:ded:295b:b15d:4a53])
        by smtp.gmail.com with ESMTPSA id g67sm55484909pfg.13.2019.02.28.22.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 22:24:47 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lp87565: Convert to use regulator_set/get_current_limit_regmap
Date:   Fri,  1 Mar 2019 14:24:32 +0800
Message-Id: <20190301062432.2322-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp87565-regulator.c | 47 ++++-----------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 0418e478c6dc..81eb4b890c0c 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -34,6 +34,10 @@
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
+			.curr_table = lp87565_buck_uA,			\
+			.n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
+			.csel_reg = (_cr),				\
+			.csel_mask = LP87565_BUCK_CTRL_2_ILIM,		\
 		},							\
 		.ctrl2_reg = _cr,					\
 	}
@@ -102,44 +106,7 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 	return 0;
 }
 
-static int lp87565_buck_set_current_limit(struct regulator_dev *rdev,
-					  int min_uA, int max_uA)
-{
-	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
-	int i;
-
-	for (i = ARRAY_SIZE(lp87565_buck_uA) - 1; i >= 0; i--) {
-		if (lp87565_buck_uA[i] >= min_uA &&
-		    lp87565_buck_uA[i] <= max_uA)
-			return regmap_update_bits(lp87565->regmap,
-						  regulators[id].ctrl2_reg,
-						  LP87565_BUCK_CTRL_2_ILIM,
-						  i << __ffs(LP87565_BUCK_CTRL_2_ILIM));
-	}
-
-	return -EINVAL;
-}
-
-static int lp87565_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(lp87565->regmap, regulators[id].ctrl2_reg, &val);
-	if (ret)
-		return ret;
-
-	val = (val & LP87565_BUCK_CTRL_2_ILIM) >>
-	       __ffs(LP87565_BUCK_CTRL_2_ILIM);
-
-	return (val < ARRAY_SIZE(lp87565_buck_uA)) ?
-			lp87565_buck_uA[val] : -EINVAL;
-}
-
-/* Operations permitted on BUCK0, BUCK1 */
+/* Operations permitted on BUCKs */
 static const struct regulator_ops lp87565_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -150,8 +117,8 @@ static const struct regulator_ops lp87565_buck_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= lp87565_buck_set_ramp_delay,
-	.set_current_limit	= lp87565_buck_set_current_limit,
-	.get_current_limit	= lp87565_buck_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 };
 
 static const struct lp87565_regulator regulators[] = {
-- 
2.17.1

