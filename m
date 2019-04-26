Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3A02084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271960;
	bh=wEzHlnIYYy3+cbyIkBF8oZfb36ujIDJ4gCszpo6m2OU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=f+xZbZCGW3A0taVsyRKsAFWZqSVtTcBlMP7SRdnCzsabJdFvFD6LzDGhqMfYlwbXD
	 b8AJn+4CArj0WhKKTgbXlG4P+r88d7wZS6QmU7G5MbX2xShziybQb2QYTusdPx0G5j
	 yHJg3t6Whf77cl2o21w9xb6aUxdRn690EsnyX6Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDZJp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:45:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfDZJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bK3wjfx2/zbC1galWJ5AQXsN4RrCXPQtqtkXr6htEA8=; b=Xz0t3p6c/2Q3
        L+PO/GV+UieocOzJLY1Atz8Of40EJwzWfmGFnim+2DcTw5fkJEkY0qcdQ82fh/j0orCDdw7/AkgB3
        pmT86jD48LlKn9csIYnjRr6DGUkz6T4MLZTXUHg4ad5R8Q0os18aK4tPhMmGliNJfFVhKWjyv2DTU
        pjh3g=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxQX-0003SU-Gq; Fri, 26 Apr 2019 09:45:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 74FAD441D3B; Fri, 26 Apr 2019 10:45:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Applied "regulator: vexpress: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094552.74FAD441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:45:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vexpress: Constify regulator_ops

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

From ab54a4d7b0dd5f36cb6c2da83894590bc8bda5a5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Apr 2019 00:19:37 +0800
Subject: [PATCH] regulator: vexpress: Constify regulator_ops

vexpress_regulator_ops_ro and vexpress_regulator_ops are never changed,
make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/vexpress-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index c810cbbd463f..ca4230fe9e77 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -46,11 +46,11 @@ static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 	return regmap_write(reg->regmap, 0, min_uV);
 }
 
-static struct regulator_ops vexpress_regulator_ops_ro = {
+static const struct regulator_ops vexpress_regulator_ops_ro = {
 	.get_voltage = vexpress_regulator_get_voltage,
 };
 
-static struct regulator_ops vexpress_regulator_ops = {
+static const struct regulator_ops vexpress_regulator_ops = {
 	.get_voltage = vexpress_regulator_get_voltage,
 	.set_voltage = vexpress_regulator_set_voltage,
 };
-- 
2.20.1

