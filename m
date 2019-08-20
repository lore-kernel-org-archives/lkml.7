Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A1C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A638230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322915;
	bh=67Dok6C1lYLaSwzeVg9VxGoXI1+FpJcWS2BS7sDjcwo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1IxQBsfjd6paWQjU5iPw6kkHB5jUvr11+aR+yPU4cqSQh1hS0lny4xrUKsl8Ddq5h
	 sb5PRHRtniLddq+OQIFGCQOS7fx65CjD4XufZbLd+2MbkDz95ZjnoSog1Kfy0y7c9W
	 Ck7+ZVHJhapwFhlFe8eZvZ7BxNjbL17f0Md4+vqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfHTRlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:12 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:35071 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfHTRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:10 -0400
Received: by mail-wr1-f99.google.com with SMTP id k2so13269348wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=/oUZyaSFvnTru9mrXf/nQ0HyOhv4Yfcc/8s9tsBFwA8=;
        b=ip6sLcxfEgVe9YXFcWFUheEJlurMPUOkySGZxfNUeDrNI4cW50DETvJOkedDRVXbNs
         EoCiM0OUs5afweDU657i59S47rkjKI3XhSb/n6Fv4UQfDFdDSUu4EDgm8/l/5w+3dCrV
         nogLJpTTxUxwQWQSf36GCioQgtUnXaalQG18Drt0XsUIEejgcHtpG197Kc2hq0D0rYih
         1yTHxzQTkYp6vqBcBNlm+FG4+aCmQIFxDrJSyRraMcXRkBL300Smqy5gyyAiJyRUZWO2
         G0ftt7YaJo9Hxmo4CW56gtUrDFACn3zP24I1n7oTu4Z4De9QBtlYtPIgdQrGjcabg5xp
         1OMQ==
X-Gm-Message-State: APjAAAVXrD7Hq0sMfpqwTy6TWO2NGXyCgzdN04sssUrcFcLhSQmpI3WX
        fX0MSZzFMipdRFxPrv9D5ClRFA1D/Y9wjzKIcjXzEIqAQp4l1ADlTnhsdOQSSzvXGQ==
X-Google-Smtp-Source: APXvYqwbv2bKM1rrIA+jKyCyDKah2dpXSy5LRhlLaJMLEG6Vxf3igLhSeBTEMkKCmbkcbCpVmYaYhNTJ5hT5
X-Received: by 2002:a5d:528a:: with SMTP id c10mr34277580wrv.111.1566322868042;
        Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id y17sm353193wrs.53.2019.08.20.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0883-00033O-PC; Tue, 20 Aug 2019 17:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 407F2274314F; Tue, 20 Aug 2019 18:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Switch to devm for PCM register" to the asoc tree
In-Reply-To: <606d271187091e858e8c15e20555af0b79798fe1.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174107.407F2274314F@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Switch to devm for PCM register

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

From a49d24e7d8d4fd4edf59e6373983e0bf4a2cca15 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:09 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Switch to devm for PCM register

Since the introduction of the driver, a new managed helper for the
dmaengine PCM registration has been created. Let's use it to simplify a bit
our probe and remove functions.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/606d271187091e858e8c15e20555af0b79798fe1.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d97d694c48df..70608fa30bf2 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1154,7 +1154,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		goto err_suspend;
@@ -1183,8 +1183,6 @@ static int sun4i_i2s_remove(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_i2s_runtime_suspend(&pdev->dev);
-- 
2.20.1

