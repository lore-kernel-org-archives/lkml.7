Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2276FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C76206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491564;
	bh=5rYT6J7t5CIWAD3D/3Gllo/cCwpnd7w/WAHu9/kfawM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=T8BZ/3FHKgPvUGb8DTAeYu9bNZ9tcyVQaWfitr07pIG0pVIoTeVs7MyD1N9/GuLxo
	 8F5MISppLxfzsUyCBSiaUKyfyA+7gYTi/pXpO33fvI7rCusyEioMFMUficbsFVQPNQ
	 EDsyaWsRcpjS2T4e1hvmo+aENOj5yNrL/dsUHUp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfCMPjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfCMPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hBNxWOYJs3vCcxGwuayZtqBJ6dzlIMyiqwSIKuWWeH8=; b=pC9ho3AHd2XL
        uejHdiu0HHGrmuF16yiDkhZkNgyxQnw3Wnms2OhGKocqm5hJhEqjXgZkR4SUTyfpQVkOAoW+K0An3
        qyeOk+3+b/G8EKafuEW6MdT8AzKJ/Rgpa1zcCTKin6GRvlMkfBT9M+Bxkahz7ockZIWTrH4qPmDHV
        rdqKs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yO-0003Sn-1y; Wed, 13 Mar 2019 15:39:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 89A591128B97; Wed, 13 Mar 2019 15:39:15 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max14577: Get rid of match_init_data/match_of_node functions" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153915.89A591128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max14577: Get rid of match_init_data/match_of_node functions

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ae15c519a6b97fff087cf69502bdf8fc8892f4be Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 12 Mar 2019 23:52:41 +0800
Subject: [PATCH] regulator: max14577: Get rid of match_init_data/match_of_node
 functions

This driver has been converted to use regulator core's simplified DT
parsing code. So the match_init_data/match_of_node functions are not
necessary now, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max14577-regulator.c | 55 --------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 85a88a9e4d42..07a150c9bbf2 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -155,58 +155,6 @@ static const struct regulator_desc max77836_supported_regulators[] = {
 	[MAX77836_LDO2] = MAX77836_LDO_REG(2),
 };
 
-#ifdef CONFIG_OF
-static struct of_regulator_match max14577_regulator_matches[] = {
-	{ .name	= "SAFEOUT", },
-	{ .name = "CHARGER", },
-};
-
-static struct of_regulator_match max77836_regulator_matches[] = {
-	{ .name	= "SAFEOUT", },
-	{ .name = "CHARGER", },
-	{ .name = "LDO1", },
-	{ .name = "LDO2", },
-};
-
-static inline struct regulator_init_data *match_init_data(int index,
-		enum maxim_device_type dev_type)
-{
-	switch (dev_type) {
-	case MAXIM_DEVICE_TYPE_MAX77836:
-		return max77836_regulator_matches[index].init_data;
-
-	case MAXIM_DEVICE_TYPE_MAX14577:
-	default:
-		return max14577_regulator_matches[index].init_data;
-	}
-}
-
-static inline struct device_node *match_of_node(int index,
-		enum maxim_device_type dev_type)
-{
-	switch (dev_type) {
-	case MAXIM_DEVICE_TYPE_MAX77836:
-		return max77836_regulator_matches[index].of_node;
-
-	case MAXIM_DEVICE_TYPE_MAX14577:
-	default:
-		return max14577_regulator_matches[index].of_node;
-	}
-}
-#else /* CONFIG_OF */
-static inline struct regulator_init_data *match_init_data(int index,
-		enum maxim_device_type dev_type)
-{
-	return NULL;
-}
-
-static inline struct device_node *match_of_node(int index,
-		enum maxim_device_type dev_type)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
-
 /**
  * Registers for regulators of max77836 use different I2C slave addresses so
  * different regmaps must be used for them.
@@ -265,9 +213,6 @@ static int max14577_regulator_probe(struct platform_device *pdev)
 		if (pdata && pdata->regulators) {
 			config.init_data = pdata->regulators[i].initdata;
 			config.of_node = pdata->regulators[i].of_node;
-		} else {
-			config.init_data = match_init_data(i, dev_type);
-			config.of_node = match_of_node(i, dev_type);
 		}
 		config.regmap = max14577_get_regmap(max14577,
 				supported_regulators[i].id);
-- 
2.20.1

