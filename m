Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4F2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5FE21841
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCRPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:48:58 -0400
Received: from sauhun.de ([88.99.104.3]:36808 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfCRPs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:48:57 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 22D224B20B8;
        Mon, 18 Mar 2019 16:48:56 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/6] regulator: da9063: remove platform_data support
Date:   Mon, 18 Mar 2019 16:47:53 +0100
Message-Id: <20190318154759.21978-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-kernel users anymore, so remove this outdated interface.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/regulator/da9063-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2b0c7a85306a..73c85039d0cf 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -730,7 +730,6 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 static int da9063_regulator_probe(struct platform_device *pdev)
 {
 	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
-	struct da9063_pdata *da9063_pdata = dev_get_platdata(da9063->dev);
 	struct of_regulator_match *da9063_reg_matches = NULL;
 	struct da9063_regulators_pdata *regl_pdata;
 	const struct da9063_dev_model *model;
@@ -740,11 +739,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 	bool bcores_merged, bmem_bio_merged;
 	int id, irq, n, n_regulators, ret, val;
 
-	regl_pdata = da9063_pdata ? da9063_pdata->regulators_pdata : NULL;
-
-	if (!regl_pdata)
-		regl_pdata = da9063_parse_regulators_dt(pdev,
-							&da9063_reg_matches);
+	regl_pdata = da9063_parse_regulators_dt(pdev, &da9063_reg_matches);
 
 	if (IS_ERR(regl_pdata) || regl_pdata->n_regulators == 0) {
 		dev_err(&pdev->dev,
-- 
2.11.0

