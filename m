Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA117C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1DB2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889332;
	bh=1cBHmf9oJeGTJjrJrTC4I6T99hz03uPfzUmh0hPCJr0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Gu7E0wybqMr6cdH0PDvRi+xPafDrEFu4modA2wvjvFA7lwZ73CzawbrJhc7AehDh1
	 ZX3kvrO3w9s5oi2zlaQ5xm+23niz8yGUaVIeN7YIhPDdGwgHSKkXat0RT0kMKBgx1Z
	 9nyD5OU/MSVWqoP0LgKpgm4WeYbxpxLA+PdloiKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfHORPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:31 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:37617 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfHORO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:28 -0400
Received: by mail-ed1-f97.google.com with SMTP id f22so2719784edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=2ww6/ywSQxx+FgrrjZeNuFo6FDkJCG7XwL5PeJBApYo=;
        b=hF+Y0+R2BXC0hnGtjRMm4m1MKjJ8YzKqcznn+Lme6nFkc4HN+3sNL+9EmDautmKsIP
         gxsoyWybDaJG85I62KtRXrOV3vBJnp/Hsodjxn9zIDHtL2WvhhLWijlEp8O9Xpw6avkN
         +QW8rSJGYUx3St9FB77FNzmJ6bMb2+g/0ynOS/ZarloUD7KWytb7MKDDV+E0ruig2r5N
         KiiiWEKd1aWhPcRtb+rvDzMW96a0lu+FYTzrTSA9DkiSqihjPF9PlxOMZPJ/JmnNQoTH
         KZTGk1YFO5eyrz0Y1bT2XRdq3bxyi9GyRyuGkZps/ytGRm1VdkH2rvTLbECQaEkbl4wT
         vjqA==
X-Gm-Message-State: APjAAAXc63h9+o6f8FAlODoDnrB77ZDBuNuIYb3c1FOydPM8o8qiHOd/
        dNKU2Ia3l4a9egCMpLwIP2IU0aJbnHY+zOJs2NJywPg81jgSOuu0LplHIMdowFxbDw==
X-Google-Smtp-Source: APXvYqx0U9ZCcYUC9eRM0DPks9F0HSMKXSk3Nh5ZEhg1Rg2rsLGzl8YhUIVKN2eZ5e8UAz7seGjHZbV8WmDJ
X-Received: by 2002:a17:906:b7c9:: with SMTP id fy9mr5281973ejb.237.1565889266689;
        Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id dt26sm13428ejb.51.2019.08.15.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKU-000526-CF; Thu, 15 Aug 2019 17:14:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C800A2742B9E; Thu, 15 Aug 2019 18:14:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.c, tiwai@suse.com
Subject: Applied "ASoC: mediatek: mt8183-da7219-max98357: remove unused variable" to the asoc tree
In-Reply-To: <20190813143952.29232-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171425.C800A2742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: mt8183-da7219-max98357: remove unused variable

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

From 57c3ed42f52cdc51f416c93b19708ef6ceb4a00b Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 13 Aug 2019 22:39:52 +0800
Subject: [PATCH] ASoC: mediatek: mt8183-da7219-max98357: remove unused
 variable

sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:120:1: warning:
 mt8183_da7219_max98357_dapm_widgets defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:124:40: warning:
 mt8183_da7219_max98357_dapm_routes defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190813143952.29232-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 2a6097174614..43f99e59a078 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -116,15 +116,6 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget
-mt8183_da7219_max98357_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("IT6505_8CH"),
-};
-
-static const struct snd_soc_dapm_route mt8183_da7219_max98357_dapm_routes[] = {
-	{"IT6505_8CH", NULL, "TDM"},
-};
-
 /* FE */
 SND_SOC_DAILINK_DEFS(playback1,
 	DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
-- 
2.20.1

