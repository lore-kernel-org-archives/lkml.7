Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15622084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266533;
	bh=6eTY2yO3tl+Y54QH0z3V0PVZtS8wZHxDfgUyK96xVzU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LBHDFilwOw6HBPi6XE32UZTGv3Q2kPP9TMnx4/cqZvu/JAH3t/X3wb3D7873yg2Dw
	 2dyro07nuzh53oD5WP4K7RivZSesNdG8xJVn789uHMg9VlIX5u1fkjqapWb8Srykgm
	 85vBcxaX9R7Y/vcB/CRn8gRBYifAeSj6ACYh7kWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfDCEmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfDCEmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GLSjERMINTVj8yJRocPeebdC0jZaXUafitvIU9qQeDw=; b=o7IezE3xpPbT
        Y8WVX5c8fzwgpYrygrHyvM5Vt0eqEtlbEkxUWRebsKl5fHl2SYpRpchtTwjpdPeJ/d+bSK0+H0znq
        BAtpaOU01RTCdzDVKGGGG3y4swaRyT6ok3GwKp0E1RBoVuED66DrKPiR1ijc9sOjzyccQXnQ05aOv
        7yOGM=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXiv-000406-Ng; Wed, 03 Apr 2019 04:42:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D2924440082; Wed,  3 Apr 2019 05:42:02 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lm363x: Use proper data type for regmap_read arguments" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190403044202.D2924440082@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:42:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lm363x: Use proper data type for regmap_read arguments

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

From 8a76f107216f770c0f6e6ea13bb962fbe4568b5f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 2 Apr 2019 20:13:47 +0800
Subject: [PATCH] regulator: lm363x: Use proper data type for regmap_read
 arguments

regmap_read() takes unsigned int reg and unsigned int *val arguments,
use proper data type for these arguments.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lm363x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index c876e161052a..ebec91b55ceb 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -48,7 +48,7 @@ static const int ldo_cont_enable_time[] = {
 static int lm363x_regulator_enable_time(struct regulator_dev *rdev)
 {
 	enum lm363x_regulator_id id = rdev_get_id(rdev);
-	u8 val, addr, mask;
+	unsigned int val, addr, mask;
 
 	switch (id) {
 	case LM3631_LDO_CONT:
@@ -71,7 +71,7 @@ static int lm363x_regulator_enable_time(struct regulator_dev *rdev)
 		return 0;
 	}
 
-	if (regmap_read(rdev->regmap, addr, (unsigned int *)&val))
+	if (regmap_read(rdev->regmap, addr, &val))
 		return -EINVAL;
 
 	val = (val & mask) >> LM3631_ENTIME_SHIFT;
-- 
2.20.1

