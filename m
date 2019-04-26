Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA312084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271973;
	bh=I8BxiUhAA4FAdpMo9K5V9h2j8od2JFLl2YTxhFPX3nU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=09oMjYoIjAZB3IGhHqekscOQEdvtIEnCNpjjHGXjBIbPjqbJ0CJOfJSKZs9+4SbSP
	 yV2L8yuhK/JE88G4TNmo5swqVC64KtMW4YZ/EL9WH1sY3MyU52Rx+2pxPDXAwFYqIw
	 49CTCP/lBfCzvLtMNDzOTLjT18PaEFhYIzJFVpr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfDZJqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:46:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfDZJqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QbG6TVehOxvmLSmKg7kBE1f9BLeSxRMIzXjwwqLBKSw=; b=tf8CNoEziASD
        UOjieW6hOhN2YQFBNuHk5xP3iELdj5RlW5sM9GM0m7n8QjmWmObnPrrdW4VwRShf7defqCe/n1Teg
        qyvkrRwSHADGv34rbzi440Pl5V0svGJ9yCDjKDV7PPonTvdnTwQliBw7QcEKDUOQUOLj/qAMFeqQA
        U7PW0=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxQl-0003T7-FC; Fri, 26 Apr 2019 09:46:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4AC7A441D3C; Fri, 26 Apr 2019 10:46:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: hi655x: Constify regulators array" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094606.4AC7A441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:46:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: hi655x: Constify regulators array

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

From 784816d46aae28f84a3ec5461b6cf69b6f02d62a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 8 Apr 2019 20:09:32 +0800
Subject: [PATCH] regulator: hi655x: Constify regulators array

The regulators array should never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi655x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index bba24a6fdb1e..460ae70d8b04 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -158,7 +158,7 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	.ctrl_mask = cmask,                                      \
 }
 
-static struct hi655x_regulator regulators[] = {
+static const struct hi655x_regulator regulators[] = {
 	HI655X_LDO_LINEAR(LDO2, 0x72, 0x07, 0x29, 0x2a, 0x2b, 0x01,
 			  2500000, 8, 100000),
 	HI655X_LDO(LDO7, 0x78, 0x07, 0x29, 0x2a, 0x2b, 0x06, ldo7_voltages),
-- 
2.20.1

