Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611389;
	bh=YusBWNd1m2h9+bvVZMpufMXf7IIcuLypMIal2VyLILA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VvSMMQntLNykcwKj+1tem5fzBM6ueWv5rUlQCFzuB9vQcwUvvKmpZ1VW2R5yEPLkT
	 x0UmyT7kQMhfclOFCLkdHcMWRM1FAzhQVCdzthRBcRTQP4AvUwY/GL5UafQaW4f3Bd
	 D7//6N2gx+vffpteFplbOhgE2F5MAGwZs7w5OB6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfCZOnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731859AbfCZOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NrSmLC3B5CqhSksoqOXZFsAD66Zcqz+zRpzq4f7YvbE=; b=NlOpRQtvTllw
        sF3x/Q/vPqCxLcJWX+6OC/cXR56OrqaWoZ2Jr5s+nDCG4gcHxE8de6ud1oWqAQSMyCTMxkCcEznju
        VN2Byak+9/gSfj8d9Y50bw0r+zIiOtV1SU+taUpNntbSzGpD6vr7DOXJjKlWeORHYUzDESZJwlCef
        oB63k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nI6-0007jC-0r; Tue, 26 Mar 2019 14:43:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2C7B81121B57; Tue, 26 Mar 2019 14:43:01 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65217: Fix off-by-one for latest seletor of tps65217_uv1_ranges" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190326144301.2C7B81121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:43:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65217: Fix off-by-one for latest seletor of tps65217_uv1_ranges

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

From 0b5e200cc7ee339694693a6d89816b66ccbd663a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 24 Mar 2019 14:00:04 +0800
Subject: [PATCH] regulator: tps65217: Fix off-by-one for latest seletor of
 tps65217_uv1_ranges

According to the datasheet the latest seletor 11 1111b = 3.3 V.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65217-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index d84fab616abf..546fb5cf2023 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -61,7 +61,7 @@ static const struct regulator_linear_range tps65217_uv1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1550000, 25, 30, 50000),
 	REGULATOR_LINEAR_RANGE(1850000, 31, 52, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 53, 55, 100000),
-	REGULATOR_LINEAR_RANGE(3300000, 56, 62, 0),
+	REGULATOR_LINEAR_RANGE(3300000, 56, 63, 0),
 };
 
 static const struct regulator_linear_range tps65217_uv2_ranges[] = {
-- 
2.20.1

