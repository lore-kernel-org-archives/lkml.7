Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D1DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFCD205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889314;
	bh=nvsLVUFtAMRzEu1y2Z1m0T+QQ5UYAC9iqJQox9tALAY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FHaPZxWejNqk+6pg5sk7pRqS/UykRa9dYHK97aGLNk1JgDAl/r/9BLXfROqOscsi7
	 zp9zGV95rM9B3QOiQzU+u08vWH6peUpxNxiYIKcNVjWvvtGz2442u7bxClu6Gi3+4/
	 X5dqDTjf8bWeUIGArLNmx/vxYVHyonydkoedAK0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfHORPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:13 -0400
Received: from mail-wm1-f100.google.com ([209.85.128.100]:38404 "EHLO
        mail-wm1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbfHOROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:30 -0400
Received: by mail-wm1-f100.google.com with SMTP id m125so1859719wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=CnBCQCl8HgGtRAslD3BhGDm2lZeAd4b8wc+xobzHTtE=;
        b=fAtSj4gtUsw/zzHOeGeURkspKwTZdaAbjfN+qSryoOWqsXpe4Nw4PO/2LVpnPljL38
         UPc2EsMnAMl0PC1UVZHzaVTC+ch8AQl/obUVUhNJ76HL12R9nwzWNqN12CMqiZeDE7TO
         ugsRd7mV8EBvR1Xf46LPRpaLKLLe4/OCCoppCCkZKeEK8OBdwVToPTdIdoiLaZCqdaKp
         qhdfLoHO0xWzfOWHHIlb2bH/ae4f34m+DwZwyvrk71elnMkhv5pcNWKrJz1kIM/Yu6wI
         l9aS7TuSAXQ3wnwxnxgkabVEy3Ac+RwLlYFJ5Y3e17m3Gmxua+rDhUR4mNkSsCGQ3cZy
         DNdw==
X-Gm-Message-State: APjAAAWpan29/51Xv8iJtOduwfBu6OESdLMgxgTtbGt+dCTo+yrShmNy
        CaDaoewD0UhW+4+u2adwfFd2EwnumkWEcyxEMvW8lzevWUUbPNUNKi+49/piJ3bZfg==
X-Google-Smtp-Source: APXvYqzF9p1m8pQLSYHcZd54ZXHssvs7mOElBrJ3n7sLNitdfagAUctF4SZiOcG91ZIiZMiKr3Spp9T/hSsU
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr3836224wme.81.1565889268788;
        Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id v11sm7554wmh.27.2019.08.15.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKW-00052e-HJ; Thu, 15 Aug 2019 17:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 16A862742B9E; Thu, 15 Aug 2019 18:14:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     alsa-devel@alsa-project.org, cain.cai@rock-chips.com,
        dgreid@chromium.org, dianders@chromium.org,
        eddie.cai@rock-chips.com, enric.balletbo@collabora.com,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>, jeffy.chen@rock-chips.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        tzungbi@chromium.org, zhengxing@rock-chips.com
Subject: Applied "ASoC: rockchip: rockchip_max98090: Set period size to 240" to the asoc tree
In-Reply-To: <20190813074430.191791-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190815171428.16A862742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: rockchip_max98090: Set period size to 240

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 7188f656cdf762d4ea8ce16b6aaf4c6b06e119ec Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Tue, 13 Aug 2019 15:44:30 +0800
Subject: [PATCH] ASoC: rockchip: rockchip_max98090: Set period size to 240

From stress testing of arecord, we found that period size
greater than ~900 will bring pl330 to DYING state and
can not recover within 100 iterations.
The result is that arecord will stuck and get I/O error,
and issue can not be recovered until reboot.

This issue does not happen when period size is small.
Set constraint of period size to 240 to prevent such issue.
With the constraint, there will be no issue after 2000 iterations.

We can revert this patch once the root cause is found
in rockchip's pl330 implementation.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Link: https://lore.kernel.org/r/20190813074430.191791-1-cychiang@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 782e534d4c0d..d54f672d38d8 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -138,8 +138,19 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int rk_aif1_startup(struct snd_pcm_substream *substream)
+{
+	/*
+	 * Set period size to 240 because pl330 has issue
+	 * dealing with larger period in stress testing.
+	 */
+	return snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+}
+
 static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
+	.startup = rk_aif1_startup,
 };
 
 SND_SOC_DAILINK_DEFS(hifi,
-- 
2.20.1

