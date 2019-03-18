Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F159C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BCE20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920725;
	bh=6y/w4ZM7ASxP+mIzwotr+wbo/tPYotuEhRcmJvsbzVU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LsoEhJASoDWhuv78I/B7PAv4q/Yb9IljNAEao5h22KthQJwwE4GfTmF1hTGcFXGun
	 ByRIDCtMLHQbx/Gg34INSbnuL2of+qR8XLKvBpoDHdV5KXhVlISUgZ5X9lzcOM5OmH
	 lcB5NA9HlwiPPJXcJpoEqt1/v6i+hQL8OrDJPGxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfCROvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfCROvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EzsDiUt4l5zrT1KJkIZXbBrB0h2v6sci3INyo+xxvvE=; b=piNpnalz5qJl
        6w1BOogShx7bgjOw0v4Wn8Wn/ek5FjyrtAjoOy0L0AGu+9glNwZVX9sGTImdaZ5XPsaAV4THlpt/m
        Wf9XJtmHqJa3Qpovpou0UGKlOfg5pqtA/lE1EzPW2CoLffJPXTQWAwN8blN9oQwdFgjHvqKVg/Qua
        UrOAI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcB-0005p6-4T; Mon, 18 Mar 2019 14:51:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A9ED91128874; Mon, 18 Mar 2019 14:51:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: cpcap: Convert to use of_device_get_match_data" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145146.A9ED91128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: cpcap: Convert to use of_device_get_match_data

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

From f4192c2cc923ecd79da6cc1619794164fbafcbc4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 16 Mar 2019 22:35:58 +0800
Subject: [PATCH] regulator: cpcap: Convert to use of_device_get_match_data

Use of_device_get_match_data to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/cpcap-regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c9d805d7a979..d3284361e594 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -505,16 +505,12 @@ MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
 static int cpcap_regulator_probe(struct platform_device *pdev)
 {
 	struct cpcap_ddata *ddata;
-	const struct of_device_id *match;
+	const struct cpcap_regulator *match_data;
 	struct regulator_config config;
 	int i;
 
-	match = of_match_device(of_match_ptr(cpcap_regulator_id_table),
-				&pdev->dev);
-	if (!match)
-		return -EINVAL;
-
-	if (!match->data) {
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data) {
 		dev_err(&pdev->dev, "no configuration data found\n");
 
 		return -ENODEV;
@@ -529,7 +525,7 @@ static int cpcap_regulator_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	ddata->dev = &pdev->dev;
-	ddata->soc = match->data;
+	ddata->soc = match_data;
 	platform_set_drvdata(pdev, ddata);
 
 	memset(&config, 0, sizeof(config));
-- 
2.20.1

