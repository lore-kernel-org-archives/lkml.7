Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B8CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8FD21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763619;
	bh=LcgLSAhMXWi6ZgRt4C1++suODvNUMXt3J+PL2fQp0HM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nfhbGsOWe7jfaB6ofa4ot6ZFy7WBizcKCLxQgU13ztvzWWsH2zT2Fr9jfM7m6ozNt
	 lE4f4CMNqWledl12w3eqTsbuJ2f2PYOPtGjdbsn1KntlnzAqWo/BBTJnG2yff/Pe2I
	 vHOimk/Uf1/c2Lp7RjIFxvFssytAypZE0syyRI3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfEBCTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfEBCTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JSlPcUnFqX1tN5EF+WG+3VLibdvupztBzoEMjhd4pBY=; b=g7HBSZHxEi41
        FbJOFo6XXTQJJ4jd7ljgytbHAlajKmV+/HndsXkAQtOvo+vHj106e0vJhsG1vuijAWw29aiNl3EzG
        l/oQinOz18TveSp+rV+4A6u9ko4jCwW9hCw7RotfC5h/NLZMi2ntyWQSGKNgQlD9a849ZiCNpPHal
        mCKTk=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1IX-0005qB-G5; Thu, 02 May 2019 02:18:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 39C17441D3C; Thu,  2 May 2019 03:18:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     alsa-devel@alsa-project.org,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Timur Tabi <timur@kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Subject: Applied "ASoC: fsl_audmix: cache pdev->dev pointer" to the asoc tree
In-Reply-To:  <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021806.39C17441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_audmix: cache pdev->dev pointer

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 62be484f7ad8443c393293a415392fbf3190c864 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 10 Apr 2019 11:06:39 +0000
Subject: [PATCH] ASoC: fsl_audmix: cache pdev->dev pointer

There should be no trouble to understand dev = pdev->dev.
This can save some space to have more print info or save
some wrapped lines.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index dc802d5c4ccd..3897a54a11fe 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -456,6 +456,7 @@ MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
 
 static int fsl_audmix_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct fsl_audmix *priv;
 	struct resource *res;
 	const char *mdrv;
@@ -463,52 +464,50 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	int ret;
 
-	of_id = of_match_device(fsl_audmix_ids, &pdev->dev);
+	of_id = of_match_device(fsl_audmix_ids, dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
 	mdrv = of_id->data;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	/* Get the addresses */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "ipg", regs,
+	priv->regmap = devm_regmap_init_mmio_clk(dev, "ipg", regs,
 						 &fsl_audmix_regmap_config);
 	if (IS_ERR(priv->regmap)) {
-		dev_err(&pdev->dev, "failed to init regmap\n");
+		dev_err(dev, "failed to init regmap\n");
 		return PTR_ERR(priv->regmap);
 	}
 
-	priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	priv->ipg_clk = devm_clk_get(dev, "ipg");
 	if (IS_ERR(priv->ipg_clk)) {
-		dev_err(&pdev->dev, "failed to get ipg clock\n");
+		dev_err(dev, "failed to get ipg clock\n");
 		return PTR_ERR(priv->ipg_clk);
 	}
 
 	platform_set_drvdata(pdev, priv);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_audmix_component,
+	ret = devm_snd_soc_register_component(dev, &fsl_audmix_component,
 					      fsl_audmix_dai,
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
+		dev_err(dev, "failed to register ASoC DAI\n");
 		return ret;
 	}
 
-	priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
-						   0);
+	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
 	if (IS_ERR(priv->pdev)) {
 		ret = PTR_ERR(priv->pdev);
-		dev_err(&pdev->dev, "failed to register platform %s: %d\n",
-			mdrv, ret);
+		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
 	}
 
 	return ret;
-- 
2.20.1

