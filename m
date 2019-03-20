Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7400A21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553102999;
	bh=DctZP3eiEeBhywZCzbXr3Non8a+EIttpMxAXP1W6NWM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hOFOzV9CbbQT3qjEAGJR4ruhykWJ07ZMn7yJzPK4cMITd7pTDavPEe1vMdxBbR17k
	 9qOg/oFibK3Aps7ZrevhJ1i9Jl47kxmLIczI0XKkcWzXPcUtGJHnnygbZ38hXj9/0z
	 w+elu+CfjsKUY7MNmRKL7WfrKT+9jMA4i68IFYpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfCTR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44108 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCTR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yhbpyTWJ2NNjelWcU/HUG1rS5pWRRczRoGi4fPOJ8Hw=; b=A1SQE7rTcAV+
        uIgBGy3VgaTylpBxMlOoYsthnmKPpbRrMPFbDC8oR0VGrAimhkE1fdJAT2eSfZRRdU4oJ4BzIfre+
        bHXekAlCOvLluCxlOvFg/qcACyBkNTmEPPjGQEudwuLqn4VsfxntcdSVWZXQBNpv9XS3Mi/ZJDoHN
        HNuf8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2E-00019H-9p; Wed, 20 Mar 2019 17:29:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7C7411126E4C; Wed, 20 Mar 2019 17:29:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rn5t618: Constify regulator_desc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190320172949.7C7411126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rn5t618: Constify regulator_desc

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

From c22938562fd891cf1fa95690a6eb6cc9d9a1fbbd Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 20 Mar 2019 20:10:57 +0800
Subject: [PATCH] regulator: rn5t618: Constify regulator_desc

The regulator_desc never need to be modified, so define them as const as a
hint to the compiler that they can go into .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rn5t618-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index 790a4a73ea2c..a79c0c43b9f8 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -46,7 +46,7 @@ static const struct regulator_ops rn5t618_reg_ops = {
 		.vsel_mask	= (vmask),				\
 	}
 
-static struct regulator_desc rn5t567_regulators[] = {
+static const struct regulator_desc rn5t567_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
 	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
@@ -63,7 +63,7 @@ static struct regulator_desc rn5t567_regulators[] = {
 	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
 };
 
-static struct regulator_desc rn5t618_regulators[] = {
+static const struct regulator_desc rn5t618_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
 	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
@@ -79,7 +79,7 @@ static struct regulator_desc rn5t618_regulators[] = {
 	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
 };
 
-static struct regulator_desc rc5t619_regulators[] = {
+static const struct regulator_desc rc5t619_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
 	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
@@ -107,7 +107,7 @@ static int rn5t618_regulator_probe(struct platform_device *pdev)
 	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	struct regulator_desc *regulators;
+	const struct regulator_desc *regulators;
 	int i;
 	int num_regulators = 0;
 
-- 
2.20.1

