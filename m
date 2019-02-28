Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A102C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5730821850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="twzs4tRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfB1NlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42559 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbfB1NlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so9750511pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ZKs6yBEOfe+P+8sRx2zeIsnE5c3JoZZPoDrsE9tKTQ=;
        b=twzs4tRHB9VuMTpUZGEsRLv0+ulA4jqFls0F9MZxk5pNZ3TxpG6ekjFkfJoS9WgHA9
         BcpIbF/a/gW26C0u5u6R+CrCRLse+8BSJXc5fuhdgqFFzMhD4mvTDtBzz7OtmCOiDITe
         9f/KPn3WwXuTsNmMtLECSQmrNIcc20bIKON4ct8EUpWXtfWY5WK5wXNyFcjfDXg5zOmE
         rK0n9El0kIgYvPYFTtYUJQ+gzjofkLQssbIr3G3MetMecPv651GcVDQ+oExvW8Pu4rAg
         nfWJRxrOj4cOWLbkibBQNZgzgWMoB2fYHadTMMGnAr/MBPQCfsKpruxe21QF47BkeqKQ
         /i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ZKs6yBEOfe+P+8sRx2zeIsnE5c3JoZZPoDrsE9tKTQ=;
        b=SVUEblzXFi7P5Tzzp62cVK52isGiTChzza4wqjiGu5K7qf1aQOInk/wK2RF0Q/VYEe
         FqTRJTmRSr9e6pvl8YgLS/jUzjComVdXSQnJ5J/iZ/jqu+thE+DgPmvjLYX9vIzZ4U2h
         UtJMCGQPRLrjW1P5B52F2Rs/osnejiPNkLRRztljWPTS9AOaBTdl0+ClILTx/uQnmhHk
         VizCBD1Hkwr6p3B8yCv7WL0YBvqNWxzUuHpz6Np0M4Cn6fmGyOkBkkAMZm4RDyUGtpDk
         vGb5IE4UbyUlwufGx979Vx+GGKXJKq3mUk/V0JpIkVFnYzazpY4tfnxdb/h/U98c6hhW
         8mHw==
X-Gm-Message-State: AHQUAuY0DtWqRINvTOAR/EB6Y16YXSCP7XHFMTAzf8v9d8KtiVSog9zz
        9ngv4/bPjqTQ/1Yl4Y1ZOMEkQQ==
X-Google-Smtp-Source: AHgI3IYsYYaFyOe2FzxgGnPNdI/FNNbLw8/foZthoEoM+qm93YBKVVQqngsyzmm7qtpgRgPflLcAAw==
X-Received: by 2002:a62:864c:: with SMTP id x73mr7534666pfd.49.1551361269681;
        Thu, 28 Feb 2019 05:41:09 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:08 -0800 (PST)
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
Subject: [PATCH 06/11] regulator: lp873x: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:17 +0800
Message-Id: <20190228134022.32625-7-axel.lin@ingics.com>
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
 drivers/regulator/lp873x-regulator.c | 45 ++++------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 70651fec8fd9..b55de293ca7a 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -39,6 +39,10 @@
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
+			.curr_table	= lp873x_buck_uA,		\
+			.n_current_limits = ARRAY_SIZE(lp873x_buck_uA),	\
+			.csel_reg	= (_cr),			\
+			.csel_mask	= LP873X_BUCK0_CTRL_2_BUCK0_ILIM,\
 		},							\
 		.ctrl2_reg = _cr,					\
 	}
@@ -108,43 +112,6 @@ static int lp873x_buck_set_ramp_delay(struct regulator_dev *rdev,
 	return 0;
 }
 
-static int lp873x_buck_set_current_limit(struct regulator_dev *rdev,
-					 int min_uA, int max_uA)
-{
-	int id = rdev_get_id(rdev);
-	struct lp873x *lp873 = rdev_get_drvdata(rdev);
-	int i;
-
-	for (i = ARRAY_SIZE(lp873x_buck_uA) - 1; i >= 0; i--) {
-		if (lp873x_buck_uA[i] >= min_uA &&
-		    lp873x_buck_uA[i] <= max_uA)
-			return regmap_update_bits(lp873->regmap,
-						  regulators[id].ctrl2_reg,
-						  LP873X_BUCK0_CTRL_2_BUCK0_ILIM,
-						  i << __ffs(LP873X_BUCK0_CTRL_2_BUCK0_ILIM));
-	}
-
-	return -EINVAL;
-}
-
-static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	int id = rdev_get_id(rdev);
-	struct lp873x *lp873 = rdev_get_drvdata(rdev);
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(lp873->regmap, regulators[id].ctrl2_reg, &val);
-	if (ret)
-		return ret;
-
-	val = (val & LP873X_BUCK0_CTRL_2_BUCK0_ILIM) >>
-	       __ffs(LP873X_BUCK0_CTRL_2_BUCK0_ILIM);
-
-	return (val < ARRAY_SIZE(lp873x_buck_uA)) ?
-			lp873x_buck_uA[val] : -EINVAL;
-}
-
 /* Operations permitted on BUCK0, BUCK1 */
 static const struct regulator_ops lp873x_buck01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -156,8 +123,8 @@ static const struct regulator_ops lp873x_buck01_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= lp873x_buck_set_ramp_delay,
-	.set_current_limit	= lp873x_buck_set_current_limit,
-	.get_current_limit	= lp873x_buck_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 };
 
 /* Operations permitted on LDO0 and LDO1 */
-- 
2.17.1

