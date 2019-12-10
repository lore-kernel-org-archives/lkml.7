Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128FEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5BA20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015976;
	bh=4kXjjOFfrXdAo6YkWOkkrF2W8LEiP/qW5gwyvKK11O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1i11GtZ6nLCtq6WVgjBEcfxJqjAvYuKcjfOueVBg/4mX8xb6HD6W/I84uOcKaWkSo
	 x4fdXOJuXrWV5pQ/jaWHK5cJze/U5MsZ9WrWp2GKyhSTFx6WrJXUqFnrQS6Wh1xKjM
	 XniF+cb749BIgJ6kmE/62kYG29gl98izjOwKVbcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfLJWMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbfLJWDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:03:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D252053B;
        Tue, 10 Dec 2019 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015412;
        bh=4kXjjOFfrXdAo6YkWOkkrF2W8LEiP/qW5gwyvKK11O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwDDaz/7bYPFHbSGTAGNBy/+fXS8J/g6mJlSE4sVjLwGwyKx97JMu0S3EljTRO3We
         Cp4bVRhHJ8D4sHTKCv0bOxOmiGRY/RDGo7zMdhZoMgZA4hnaQ+N5zdnLKUQ/lSRgo4
         v4USyzW61TZ/ZEmysdjHZvFqgMQbAFH7yKnEB8Tw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yizhuo <yzhai003@ucr.edu>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 025/130] regulator: max8907: Fix the usage of uninitialized variable in max8907_regulator_probe()
Date:   Tue, 10 Dec 2019 17:01:16 -0500
Message-Id: <20191210220301.13262-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

[ Upstream commit 472b39c3d1bba0616eb0e9a8fa3ad0f56927c7d7 ]

Inside function max8907_regulator_probe(), variable val could
be uninitialized if regmap_read() fails. However, val is used
later in the if statement to decide the content written to
"pmic", which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Link: https://lore.kernel.org/r/20191003175813.16415-1-yzhai003@ucr.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/max8907-regulator.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 860400d2cd859..a8f2f07239fb9 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -299,7 +299,10 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 	memcpy(pmic->desc, max8907_regulators, sizeof(pmic->desc));
 
 	/* Backwards compatibility with MAX8907B; SD1 uses different voltages */
-	regmap_read(max8907->regmap_gen, MAX8907_REG_II2RR, &val);
+	ret = regmap_read(max8907->regmap_gen, MAX8907_REG_II2RR, &val);
+	if (ret)
+		return ret;
+
 	if ((val & MAX8907_II2RR_VERSION_MASK) ==
 	    MAX8907_II2RR_VERSION_REV_B) {
 		pmic->desc[MAX8907_SD1].min_uV = 637500;
@@ -336,14 +339,20 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 		}
 
 		if (pmic->desc[i].ops == &max8907_ldo_ops) {
-			regmap_read(config.regmap, pmic->desc[i].enable_reg,
+			ret = regmap_read(config.regmap, pmic->desc[i].enable_reg,
 				    &val);
+			if (ret)
+				return ret;
+
 			if ((val & MAX8907_MASK_LDO_SEQ) !=
 			    MAX8907_MASK_LDO_SEQ)
 				pmic->desc[i].ops = &max8907_ldo_hwctl_ops;
 		} else if (pmic->desc[i].ops == &max8907_out5v_ops) {
-			regmap_read(config.regmap, pmic->desc[i].enable_reg,
+			ret = regmap_read(config.regmap, pmic->desc[i].enable_reg,
 				    &val);
+			if (ret)
+				return ret;
+
 			if ((val & (MAX8907_MASK_OUT5V_VINEN |
 						MAX8907_MASK_OUT5V_ENSRC)) !=
 			    MAX8907_MASK_OUT5V_ENSRC)
-- 
2.20.1

