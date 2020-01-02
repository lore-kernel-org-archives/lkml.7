Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F3E20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005322;
	bh=Y6oTPyUWl/LYXYiiXw8VnlrTivTKYu9uWlex9b/y5nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CpYGF6MvFk1kZT/24U3Y3FGWYBunDTELG9R65MS+HdkEkhoUkfonvdTXUJ0Oa9Vxh
	 wexM46PI3iw/tJ35xAypQec12GbOiJxX3XWwQk2Eu4dqtMaJ8Ao8LjGoYIAOLI5ut1
	 lgGLAcV78N8ucH2JGXI7ZzuU0kv56m5gsiQzSdf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgABW1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgABW1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:27:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE68C227BF;
        Thu,  2 Jan 2020 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004065;
        bh=Y6oTPyUWl/LYXYiiXw8VnlrTivTKYu9uWlex9b/y5nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1EFye4ZUPkbTtozRiyJMeb1/7nhGMU/OPx/WYYQ/MPmDivnfzMtdMSeituEv8LkT
         LxgpzOAtOGLCqTYOW0iJgizoWqRBA5JcZEIbLf51nSozgfhrjdLF0Iv6mW7lMSd//O
         oubu0Yjryqsb7Roaq5Rsr98Isk01MJ19YeNtUCAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yizhuo <yzhai003@ucr.edu>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 023/171] regulator: max8907: Fix the usage of uninitialized variable in max8907_regulator_probe()
Date:   Thu,  2 Jan 2020 23:05:54 +0100
Message-Id: <20200102220550.302864063@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 5e941db5ccaf..c7e70cfb581f 100644
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



