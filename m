Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422572084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889316;
	bh=EiVcocz0Gwntc4j3w+DKCxpn9+p6sHgLTY/F3JiXdWA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pjuWl63EBqNoge4f8hpW1KLnFL1YhfvDhRkfW+HvwB6Kqh3KR9rsA5HMB09OXBa/w
	 Kmp8JoeCGeYEiLX17mYVVjpddQ/m1MYCZxYk5QQWqFMhcyDRBYMBJinC71ScWim1O5
	 4+lnOpGnkWW2v7kbyjg1d4oBlKDoIv9Vki/aEHuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbfHORPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:12 -0400
Received: from mail-wm1-f98.google.com ([209.85.128.98]:35485 "EHLO
        mail-wm1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731637AbfHOROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:30 -0400
Received: by mail-wm1-f98.google.com with SMTP id l2so1867527wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=qK+K3lvg5j7KBSfj3mqp/CfZUMLY6IjIIgyqWda7qdY=;
        b=jrptLSSGaEhsZnemGxbQsiutDVJEabMLnUvAlPyQGJ1J2DRRSxl3aed33cLWjtrSnU
         BNpPXVllF4JO1NUGW6ibpxzSeRJfWFQKzo4l9YL8KpWt/MPylUaJyS6+7u8SpZcxT/sa
         VTZoiWPQY9oBAVWJnfR2AH4Pe+JcUl1KAUhIQwr7SK2nKlZPAPUQALzGiGjK7l5r0+iA
         e49bHtgp8/5tqjPnky06s/v0+XljlPblYh8OPAro9kc0d3NqCkUkcCvqhuntQW80ltvl
         wNPKg5Cu5634CuuJx6TwPIs6+eUGSaHYCiSQdArtqxuSTnk9+feRvgQ3kIC+p9xPj81f
         G02A==
X-Gm-Message-State: APjAAAUdRFnxw7eOG/wl35qnIPWhpaydoLNdVKnLGiAD/NesoHukKwnI
        LWbvEcG5BdswM/9upUyHDgB1lz+gfs/Coj3ZJ5DjNnC3z0gqqZfQYgh60YsqptmbRA==
X-Google-Smtp-Source: APXvYqzwc/xYr8huKOghn9vmtQMt/8YLWEaKPN+5vpK0OgbJx4iilw7n+VrgNxOG+/p65MKqhugGqHofkiLa
X-Received: by 2002:a7b:c198:: with SMTP id y24mr3681836wmi.131.1565889268536;
        Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id r12sm59823wrw.27.2019.08.15.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKW-00052a-AD; Thu, 15 Aug 2019 17:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D1B542742BD6; Thu, 15 Aug 2019 18:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, peter.ujfalusi@ti.com,
        tiwai@suse.com
Subject: Applied "ASoC: ti: Fix typos in ti/Kconfig" to the asoc tree
In-Reply-To: <20190813034235.30673-1-standby24x7@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171427.D1B542742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: Fix typos in ti/Kconfig

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

From ae3a5901dde2ab136ec0cebda2fccc48e810d2ec Mon Sep 17 00:00:00 2001
From: Masanari Iida <standby24x7@gmail.com>
Date: Tue, 13 Aug 2019 12:42:35 +0900
Subject: [PATCH] ASoC: ti: Fix typos in ti/Kconfig

This patch fixes some spelling typo in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190813034235.30673-1-standby24x7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 2197f3e1eaed..87a9b9dd4e98 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -12,7 +12,7 @@ config SND_SOC_TI_SDMA_PCM
 
 comment "Texas Instruments DAI support for:"
 config SND_SOC_DAVINCI_ASP
-	tristate "daVinci Audio Serial Port (ASP) or McBSP suport"
+	tristate "daVinci Audio Serial Port (ASP) or McBSP support"
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	select SND_SOC_TI_EDMA_PCM
 	help
@@ -33,7 +33,7 @@ config SND_SOC_DAVINCI_MCASP
 	  - Keystone devices
 
 config SND_SOC_DAVINCI_VCIF
-	tristate "daVinci Voice Interface (VCIF) suport"
+	tristate "daVinci Voice Interface (VCIF) support"
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	select SND_SOC_TI_EDMA_PCM
 	help
-- 
2.20.1

