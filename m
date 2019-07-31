Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B2721726
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572725;
	bh=Y2n7dbDqGV6uqqEwVq3ZCvpfJoC9TRvZMP5mR3HvqpI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=k3L1no4EIzDC2pm+DZRBHtUT8PlRbTu5GGuch4C/IaikZ6q+Oq9etBUdVVSDFd/NE
	 1nzQis0JJZduBB/WHfcehU+nds1+giXCUDEB698CNUl75sRBiwkU4FhYOC8xtlkPOx
	 VRK6n4BrBCdea7q7sgMEVQV1G+ZdQdca9f+OW4YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfGaLcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:32:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfGaLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HscMAvIX3nC1A3wZxhpv5ijj3BAWn08doYWBJT7hs3k=; b=grOJoe/8CxJa
        MiZrqP3xAvE6R/4WQliP9ZQiMhZtnER68XbzuPepELZRXw2Gpi1e7G4R80yVTDXWizpvf81ZXej+B
        aT93nWJWGoocUYD66gFVQ67LB9o1fC+J5TLNcUYlilDYNJDHtGhKdGBFDPZJ2qvZT9tw5MRnMw4lK
        P3Lp4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmne-0001lN-AJ; Wed, 31 Jul 2019 11:29:42 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7EF382742CC3; Wed, 31 Jul 2019 12:29:41 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, baohua@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        daniel@zonque.org, eric@anholt.net, festevam@gmail.com,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        haojian.zhuang@gmail.com, Hulk Robot <hulkci@huawei.com>,
        jbrunet@baylibre.com, jcmvbkbc@gmail.com, jonathanh@nvidia.com,
        kernel@pengutronix.de, khilman@baylibre.com, lgirdwood@gmail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, michal.simek@xilinx.com,
        mripard@kernel.org, nicoleotsuka@gmail.com, olivier.moysan@st.com,
        paul@crapouillou.net, perex@perex.cz, rjui@broadcom.com,
        robert.jarzmik@free.fr, sbranden@broadcom.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        thierry.reding@gmail.com, timur@kernel.org, tiwai@suse.com,
        wahrenst@gmx.net, wens@csie.org, Xiubo.Lee@gmail.com,
        yamada.masahiro@socionext.com
Subject: Applied "ASoC: mmp-sspa: use devm_platform_ioremap_resource() to simplify code" to the asoc tree
In-Reply-To: <20190727150738.54764-19-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190731112941.7EF382742CC3@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:41 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mmp-sspa: use devm_platform_ioremap_resource() to simplify code

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 72d09322e709c5c2d7112d6a19ec9f3846d3609d Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 27 Jul 2019 23:07:22 +0800
Subject: [PATCH] ASoC: mmp-sspa: use devm_platform_ioremap_resource() to
 simplify code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190727150738.54764-19-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mmp-sspa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 72f4364b2d20..e3e5425b5c62 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -399,7 +399,6 @@ static const struct snd_soc_component_driver mmp_sspa_component = {
 static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 {
 	struct sspa_priv *priv;
-	struct resource *res;
 
 	priv = devm_kzalloc(&pdev->dev,
 				sizeof(struct sspa_priv), GFP_KERNEL);
@@ -417,8 +416,7 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 	if (priv->dma_params == NULL)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->sspa->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	priv->sspa->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->sspa->mmio_base))
 		return PTR_ERR(priv->sspa->mmio_base);
 
-- 
2.20.1

