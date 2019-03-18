Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD705C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED5E205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCRPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:49:03 -0400
Received: from sauhun.de ([88.99.104.3]:36870 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfCRPtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:49:01 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 2220D4A134E;
        Mon, 18 Mar 2019 16:49:00 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 6/6] regulator: da9063: platform_data is gone, depend on OF
Date:   Mon, 18 Mar 2019 16:47:58 +0100
Message-Id: <20190318154759.21978-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With OF being the only configuration possibility left, depend on it to
simplify some code.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/regulator/Kconfig            |  2 +-
 drivers/regulator/da9063-regulator.c | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b7f249ee5e68..6663cd6cb96c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -256,7 +256,7 @@ config REGULATOR_DA9062
 
 config REGULATOR_DA9063
 	tristate "Dialog Semiconductor DA9063 regulators"
-	depends on MFD_DA9063
+	depends on MFD_DA9063 && OF
 	help
 	  Say y here to support the BUCKs and LDOs regulators found on
 	  DA9063 PMICs.
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index c05859ad63d8..2eda8d985756 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -681,7 +681,6 @@ static const struct regulator_init_data *da9063_get_regulator_initdata(
 	return NULL;
 }
 
-#ifdef CONFIG_OF
 static struct of_regulator_match da9063_matches[] = {
 	[DA9063_ID_BCORE1]           = { .name = "bcore1"           },
 	[DA9063_ID_BCORE2]           = { .name = "bcore2"           },
@@ -759,15 +758,6 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 	*da9063_reg_matches = da9063_matches;
 	return pdata;
 }
-#else
-static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
-		struct platform_device *pdev,
-		struct of_regulator_match **da9063_reg_matches)
-{
-	*da9063_reg_matches = NULL;
-	return ERR_PTR(-ENODEV);
-}
-#endif
 
 static int da9063_regulator_probe(struct platform_device *pdev)
 {
-- 
2.11.0

