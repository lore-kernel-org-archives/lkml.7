Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601DCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D2420870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708664;
	bh=vo822jbXOCPBNioXS4nRdAEkZz89KoByd2cn6+dR3HM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UnzGqx5lPar64Y4Eq5StpGTCHUY79fyEGZGlbWcy5BuqtnFLWIxEQpt+cp9uQg1/U
	 sROLnMObo0HZvr/svlfa2yxYKmqq7yt0HYA6z0D47g8qEanDXaXNOG0MhjMm9xEYMc
	 caeCFxfLmVoZBrD1Q4MWodNH4dKN3St3nnav0vMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDHHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:31:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1uiwfrlk24djJQDJcka1CpYBVUwPU5cQHE34sg+IKNY=; b=xeJa7zcDJcs/
        Ar7cexdmeXVsf2OXSoron/ZGX1pHqZHJ9qS/Gw3V4WNW9hqVis7bGh479vI9h7hKLNY1uDiPWOrzK
        o7aVcgUPIlve60xd1XOAKpA+QmLwtAxhkKdY8F93kloqOe37PdnlMn9kNsmhfxTif2qrCqGuI//y1
        J253E=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOk6-0003vd-Lt; Mon, 08 Apr 2019 07:30:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DB454441D3C; Mon,  8 Apr 2019 14:30:48 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718x7: Use rdev_get_id() to get regulator id" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190408073048.DB454441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:30:48 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Use rdev_get_id() to get regulator id

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

From 0a245f0efcb5f5d70f3512bfd0ed8277256503c5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 7 Apr 2019 17:03:02 +0800
Subject: [PATCH] regulator: bd718x7: Use rdev_get_id() to get regulator id

Use rdev_get_id() instead of directly access rdev->desc->id.
While at it also remove unneeded init for ramp_value variable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b2191be49670..fde4264da6ff 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -27,8 +27,8 @@
 static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 					   int ramp_delay)
 {
-	int id = rdev->desc->id;
-	unsigned int ramp_value = BUCK_RAMPRATE_10P00MV;
+	int id = rdev_get_id(rdev);
+	unsigned int ramp_value;
 
 	dev_dbg(&rdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
 		ramp_delay);
-- 
2.20.1

