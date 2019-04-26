Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D0CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64742084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271756;
	bh=ugCL4TDUu0KqWKfzLqQvJ3b06v/gG36C2a4eGi9kpZs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=psZ1fj99OXFaEr01RtMsNoSVZq/g3C2TkoqjDaUkMO3HpjrO+MGXlgRodcUYIMceh
	 JJe0J/m2n21rtsPGOcJ+Y/tll4OUYWS05UXtcaF5HxQBVRuow53GFiTJ8NIJdDPon+
	 s1L9fWS9D6sRE5m854P7djGIGeY//74qxuhB+Rdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDZJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:42:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47166 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfDZJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pvCODXlQoa7TVtRSnA/7Gos9zGNsXkD9D1F9YTTGjGY=; b=xLPa9MlLkqr5
        yFUqq6VoNpojlNNHJd7OnskLdX2umoDORn//2rMgwdhZZR/AuJoIinchvIOyA/0kRLbubLngOMqYT
        2QOcQfT70AkVT4Nfpk1gvh7TQJzcvUbbxNMEGPT21hA1CP27LUAEdhykfOoLmWFyEL3KrI4O2DXpq
        xclJo=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxM2-0003L9-Iw; Fri, 26 Apr 2019 09:41:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 93330441D3B; Fri, 26 Apr 2019 10:41:13 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500-ext: Constify ab8500_ext_regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094113.93330441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:41:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500-ext: Constify ab8500_ext_regulator_ops

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

From 8e5be4f7e142daa47303ee8238b891833024e7df Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:06:56 +0800
Subject: [PATCH] regulator: ab8500-ext: Constify ab8500_ext_regulator_ops

ab8500_ext_regulator_ops never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500-ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index f232a7a90fd5..95704446d89e 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -718,7 +718,7 @@ static int ab8500_ext_list_voltage(struct regulator_dev *rdev,
 	return -EINVAL;
 }
 
-static struct regulator_ops ab8500_ext_regulator_ops = {
+static const struct regulator_ops ab8500_ext_regulator_ops = {
 	.enable			= ab8500_ext_regulator_enable,
 	.disable		= ab8500_ext_regulator_disable,
 	.is_enabled		= ab8500_ext_regulator_is_enabled,
-- 
2.20.1

