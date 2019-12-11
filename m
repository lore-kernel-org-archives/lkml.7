Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9BC214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576083307;
	bh=Dfj0LoBfhscX9YCcy/VWTYvBaTJ4Yp6DmhKGkcShSvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=njlCwrdySV4XtE+kXtWvOWJVX0cLfCzjYEVENqPndqyA/Vh7RGmcNA63rsfPb1XzW
	 sMNapWsy1c6ESx5fqUTfjDcPOt7/WdmLZSpOTpqkXaIlsTu8Rwrfz+Aenj0x3lV4hw
	 Wfw2cTLnk/4Y1zB60QUatpts3PaDXrJiFJ2BCeKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfLKQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:55:06 -0500
Received: from foss.arm.com ([217.140.110.172]:39432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfLKQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:55:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600D630E;
        Wed, 11 Dec 2019 08:55:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4AF93F52E;
        Wed, 11 Dec 2019 08:55:04 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:55:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77650: add of_match table" to the regulator tree
In-Reply-To: <20191210100725.11005-1-brgl@bgdev.pl>
Message-Id: <applied-20191210100725.11005-1-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: add of_match table

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 100a21100bbb2bbc82fc4273e152c96e5c6c5d12 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 10 Dec 2019 11:07:25 +0100
Subject: [PATCH] regulator: max77650: add of_match table

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the regulator driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20191210100725.11005-1-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index e57fc9197d62..ac89a412f665 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -386,9 +386,16 @@ static int max77650_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id max77650_regulator_of_match[] = {
+	{ .compatible = "maxim,max77650-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_regulator_of_match);
+
 static struct platform_driver max77650_regulator_driver = {
 	.driver = {
 		.name = "max77650-regulator",
+		.of_match_table = max77650_regulator_of_match,
 	},
 	.probe = max77650_regulator_probe,
 };
-- 
2.20.1

