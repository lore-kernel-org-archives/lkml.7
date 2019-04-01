Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626220828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108824;
	bh=RATkRBX8ssGUV3+yClyZKPEryTmOus0NsgOV2eDicas=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LbP8ZNqMbkwcXq9X4dEvdPmQOi4rCOVroPV2HiGy26ccVg7WvSp+mWiMn+cUY/gPc
	 pt+okyV+dgzIiZYsphARdJ2E/8LIrkxx+X4W+ZLA9tdeTn29xaMMNar48RWERfs/XK
	 C8smVHmp31CU/t0UpP0Fq62RJJMOuPvSh0uuZkz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDAIxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:53:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60106 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDAIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3QPhFhmE0ml+4JaT1PMB7kxWHKqox11kjU6710vxBbg=; b=dlbyBQQBcn2y
        lxYF95vnqVpzY+/bBYErY+Vb6nd0FseNIDzH9Kt/Z+7a4gX8vUQtbmPmCi2XbvN7oUHBmbBN2RhAw
        FEBuCFj8kt0t9QSbAODrQlM4uTIkwYKoUem5vpIep5+060JxGjD7hqCKs/xJifSzItFRsRNkl0jHv
        /YhI8=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshH-0008Oa-Rd; Mon, 01 Apr 2019 08:53:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C96B7440082; Mon,  1 Apr 2019 09:53:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: regmap-irq: fix getting type default values" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190401085336.C96B7440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: regmap-irq: fix getting type default values

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From 8293488205f145aeefbec76f231303c8e32647a2 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 28 Mar 2019 16:22:18 +0000
Subject: [PATCH] regmap: regmap-irq: fix getting type default values

Checking for value of type default value just after allocating will
always be zero and the type register default values will never be read,
so fix this!

Without this patch setting irq type will be silently ignored.
Patch "regmap: regmap-irq: Remove default irq type setting from core"
did remove the default mask but it forgot to remove the check before
reading the default type register.

Fixes: 84267d1b18ab ("regmap: regmap-irq: Remove default irq type setting from core")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 1bd1145ad8b5..b476918c5e50 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -664,9 +664,6 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 	if (chip->num_type_reg && !chip->type_in_mask) {
 		for (i = 0; i < chip->num_type_reg; ++i) {
-			if (!d->type_buf_def[i])
-				continue;
-
 			reg = chip->type_base +
 				(i * map->reg_stride * d->type_reg_stride);
 
-- 
2.20.1

