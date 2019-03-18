Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C9720880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920709;
	bh=dLn/LiQYi9Swoxs9krKCWLmLe0zbAUi42ZS59oAZSl4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rOOweXGjkxnexaTNc3Jq1/HcpUtLh848IIJkcylpx8PkF+goIrne+K0SRP3h1JGBl
	 vSdE9sTm3eZr/X6gzYfWzvoAvny6Cxu5Mh42ZT77UYbC40N42ET+QvcsY4irQ53pn6
	 kpqatjfyguGISrBYz1UNMRS0xWkZssjYdFIbr6H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCROvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfCROvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TxDjSVOSR69eUFOucS9QKg1wJ8hsEQR4fM9waS/TIT0=; b=RSehrDYD3Sjq
        E30Jzy7PcGdTZTmjqCtiURotaDdUEpuAolbyL3vauHIZwbg6Ll3hilc45tlA7isJ2aFpbO/4sWvy0
        BbU/87kvQ4AzxmmEl1fITQVjAQnP6QVv5o5E4mDV743jafqrrIIxqfYn07rb5Z23HKUivwSB/4Alk
        H8C/A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tc1-0005oH-7T; Mon, 18 Mar 2019 14:51:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AE02E112887B; Mon, 18 Mar 2019 14:51:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp87565: Fix missing register for LP87565_BUCK_0" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145136.AE02E112887B@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp87565: Fix missing register for LP87565_BUCK_0

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

From d1a6cbdf1e597917cb642c655512d91b71a35d22 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 1 Mar 2019 14:16:40 +0800
Subject: [PATCH] regulator: lp87565: Fix missing register for LP87565_BUCK_0

LP87565_BUCK_0 is missed, fix it.

Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regulators")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 4ed41731a5b1..0418e478c6dc 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -193,7 +193,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, min_idx = LP87565_BUCK_1, max_idx = LP87565_BUCK_3;
+	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
 
 	platform_set_drvdata(pdev, lp87565);
 
-- 
2.20.1

