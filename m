Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B4C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D3D208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271664;
	bh=4p1Pi4pZsoEPqt9DBJNIZ0iwd/ToTxdJnjDwN0alzl0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qjWssXMNnIydQTcg8kw7VMkykFqY0J5pngS2+RMH8FzSqHyoGR7pgHmFhg7vlAi9l
	 2+X5FcJLrdqYrnLXD5V/zq1cNx2SCE6WaHKS6xLkZUETjP97UB1slMZDLGhnHXbkkR
	 G5ypLoR/L1ehvexdJZLSBL6hcVzXkVWXcpHbrv9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDZJlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:41:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDZJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=q+zwuou8U8DvhcL65NHTR7cDygSOpux/5Y2Z7hQw9JI=; b=v8h8Y8AYfBah
        ygPQjqMROzeE+1HRfJujvZemFftF4ZhvTxqGQHCO7tL444zK7mCUf5xF99rEpoUCj5er/pm3IRvUf
        PXm8Mf94riZEpl6YPezi9hChYxry62gyUG4K/BKe+Il12Q6E+uRi8MqXRn/EEJyYphTONQ/zio5U2
        5YXKQ=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLn-0003Kf-06; Fri, 26 Apr 2019 09:40:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CED7C441D3B; Fri, 26 Apr 2019 10:40:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct tps6524x" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094057.CED7C441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct tps6524x

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

From 7a8b0e66df5ad04d0acf31d43b37be46504b9fbc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 13 Apr 2019 15:30:02 +0800
Subject: [PATCH] regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct
 tps6524x

Current code is using devm_regulator_register() so we don't need to store
*rdev for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6524x-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index c09223c34dbf..740aeccdfb1f 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -137,7 +137,6 @@ struct tps6524x {
 	struct spi_device	*spi;
 	struct mutex		lock;
 	struct regulator_desc	desc[N_REGULATORS];
-	struct regulator_dev	*rdev[N_REGULATORS];
 };
 
 static int __read_reg(struct tps6524x *hw, int reg)
@@ -584,6 +583,7 @@ static int pmic_probe(struct spi_device *spi)
 	const struct supply_info *info = supply_info;
 	struct regulator_init_data *init_data;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int i;
 
 	init_data = dev_get_platdata(dev);
@@ -616,10 +616,9 @@ static int pmic_probe(struct spi_device *spi)
 		config.init_data = init_data;
 		config.driver_data = hw;
 
-		hw->rdev[i] = devm_regulator_register(dev, &hw->desc[i],
-						      &config);
-		if (IS_ERR(hw->rdev[i]))
-			return PTR_ERR(hw->rdev[i]);
+		rdev = devm_regulator_register(dev, &hw->desc[i], &config);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
 	}
 
 	return 0;
-- 
2.20.1

