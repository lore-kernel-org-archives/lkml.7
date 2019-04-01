Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CEAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D437C206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108855;
	bh=pNB6i1KlTz7zWDWZDOQKMRC6eeqLCvZVLT3DyqePWFE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tSydD+UHgSt9vlM8qYgct1Rr3QdiR+kVj4y4a35qeoGk4Be+nMovzWvkayeKtt36Q
	 Yx0vSjYnaXYnYwscPCh0IJnTNUAnhO9KvUI0xFhfuxnvq4IdkzVhFgrOlzqnvQw2Uv
	 fwCVm40OFzsCJtMl/LdvJ6XtkHX0iS48iU1V1/Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfDAIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60682 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfDAIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ySiNyxZk1R4D18xcuGneQkLNPRQnhNJGqkF++kAuTPs=; b=Z4XglvrNmaD6
        hJ/LhDWpgiRAOXu8MqIGoU6wkHRQCRfbbfcGPFoqp18BfwyHSDHUqkmuRR0bPViSaan92KAZc0+Da
        UQ3c16t2hhy//RFYb9NR7kcDQaxBvpendXahaMegdlgkpF+ptlbY9BhvdhN7S9YF6/gl4yKElsqz7
        ijmM4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshc-0008P8-57; Mon, 01 Apr 2019 08:54:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 44DF4440082; Mon,  1 Apr 2019 09:53:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps6507x: Constify tps6507x_pmic_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190401085357.44DF4440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6507x: Constify tps6507x_pmic_ops

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

From 646e268e66ec8664317ae677a3b774b7dc812c84 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Mar 2019 20:02:23 +0800
Subject: [PATCH] regulator: tps6507x: Constify tps6507x_pmic_ops

The tps6507x_pmic_ops never need to be modified, make it const so compiler
can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6507x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index c179a3a221af..2b3064faaaf3 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -349,7 +349,7 @@ static int tps6507x_pmic_set_voltage_sel(struct regulator_dev *dev,
 	return tps6507x_pmic_reg_write(tps, reg, data);
 }
 
-static struct regulator_ops tps6507x_pmic_ops = {
+static const struct regulator_ops tps6507x_pmic_ops = {
 	.is_enabled = tps6507x_pmic_is_enabled,
 	.enable = tps6507x_pmic_enable,
 	.disable = tps6507x_pmic_disable,
-- 
2.20.1

