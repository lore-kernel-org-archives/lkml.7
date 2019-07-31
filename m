Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B953C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01664217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572636;
	bh=EsbU7FhMDiMHsTwK1j/DREvZJJOA4ZKdXGogS6LkVDU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=p2YGWEc5yVqTelmbfhxMEYTJ4O+G0/oiWwRwej5cqpOE47E9dMlnv8MxLSwenOjfi
	 qgkHqPmrkcL6ZCJII0YeeK3He0ozEz3RXR9jvFyFu87xtEUQUheT+s2M9AMHeu36AN
	 4WI8+7Zx0vw4QKglY0s5h71cRFi1SpnPHDFIoXHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfGaLae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36012 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbfGaLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Oc00lErgK9TOIwDxfVL0TGkToNOIUPKLzcyDE4l8jTo=; b=MWl7ooSDiy8l
        ZsfUmwvPp4rcYzXloF5d28C1TXqzuFMWJ810qZ/0v1KdizN5/T0Zsx78LlaNpT0z6MLwpKJjTPhPR
        U5qxJ51R5u7pfTmCvaJrmn92PN1OtazSkegLpgphoQgyXBEo+x3+IYE5RNWF5q+GRz1sqH/nIg3YG
        5YRLo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmnl-0001ns-5M; Wed, 31 Jul 2019 11:29:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8D5682742CC3; Wed, 31 Jul 2019 12:29:48 +0100 (BST)
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
Subject: Applied "ASoC: fsl_audmix: use devm_platform_ioremap_resource() to simplify code" to the asoc tree
In-Reply-To: <20190727150738.54764-9-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190731112948.8D5682742CC3@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_audmix: use devm_platform_ioremap_resource() to simplify code

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

From 959bb6b54d708652fe06097feecc3acd4d6b8c89 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 27 Jul 2019 23:07:12 +0800
Subject: [PATCH] ASoC: fsl_audmix: use devm_platform_ioremap_resource() to
 simplify code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190727150738.54764-9-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 3897a54a11fe..c7e4e9757dce 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -458,7 +458,6 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fsl_audmix *priv;
-	struct resource *res;
 	const char *mdrv;
 	const struct of_device_id *of_id;
 	void __iomem *regs;
@@ -475,8 +474,7 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Get the addresses */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.20.1

