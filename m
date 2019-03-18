Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7656C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E220850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920713;
	bh=Zy18pSZNEbunnQE//L8sdAhZ1NJ4Pr2aYkCN3COm4K8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=uEygEKwEpco+3A8EdAChRts5op855N3kCR0RX9uy9WuX1/LZ/H2OEDjARUtvGIxGQ
	 ZNmX/zZRcgVREjmx/T53lWTQC17eCiHRXC8k+zbGeuosmg+f4BONgTgp2+XLqTLBCn
	 rCppctaQc6Ge+RLKnEqrJmFE7NKyGKc7FS8TNsJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfCROvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfCROvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/0FWoo4LKnb3TaB8Fhmvs8nhkrT3OAFVqgb/OTKxYQc=; b=BKwNUTFFhdSe
        eQGwEntyvoaBMl3Y4gr6YxK6E9CQaF4gARaKs+2e7w7VjTCgtRAbt9ksHqNucVGPP7QQ0SHfTXfSa
        iMgWu4dPC7PPqVYpAlo4nplBSDI1Vf2kI2pG25mI9Nbfi1FKHRrbtPXxRSldCSMj+caCRA7Nzlwah
        NrU5I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tc7-0005oq-Qi; Mon, 18 Mar 2019 14:51:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 563A51128874; Mon, 18 Mar 2019 14:51:43 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77650: Use unsigned int for max77651_sbb1_regulator_volt_table" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145143.563A51128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:43 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Use unsigned int for max77651_sbb1_regulator_volt_table

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

From 5fe0ed24379698feb3852950ae7579aa85993c24 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 6 Mar 2019 09:42:01 +0800
Subject: [PATCH] regulator: max77650: Use unsigned int for
 max77651_sbb1_regulator_volt_table

Make it consistent as .volt_table should be const unsigned int *.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 31ebf34b01ec..5c4f86c98510 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -41,7 +41,7 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
-static const u32 max77651_sbb1_regulator_volt_table[] = {
+static const unsigned int max77651_sbb1_regulator_volt_table[] = {
 	2400000, 3200000, 4000000, 4800000,
 	2450000, 3250000, 4050000, 4850000,
 	2500000, 3300000, 4100000, 4900000,
-- 
2.20.1

