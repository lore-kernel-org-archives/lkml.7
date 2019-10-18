Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28A420869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422062;
	bh=9c6VdGtaB1yKtKhcvfzPm9WWJK2yJtZD8fOc7L5QBU0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VV5qi6jkqz6dcUyVy9B5nwHVAjdp9nEH8rXaIiKDiDdgGuGrXjQ0wFcf5DimJ3oR+
	 ndy7540zOz4pwZ92k4u+I1OoihR+Dw60LFTDu+6xB16eHT2cfockvarP9/oNJna+qD
	 JKpmBqvAk59j73nZ51lKOF3NFASfju58hrMjuF7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634541AbfJRSHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:07:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634478AbfJRSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dHAwUaRTj6WzF3k5/983amBt+WSwLh0j0L7nOIxWmDw=; b=dyuu+/tMviLx
        TOcnOCm5pCzaLOxSuAVGQpml4EQrF+FxOrYBy56ouq5fq2JdCDiLh/vtMyQeMAVw997JNd6e6+Kws
        XKigfZ4ajuB+jjwbCoUiZcfzLhmOyxzCnWrt1Ssjwh+Em14kpVGlJVAdUJ07dpsd96lo/kQ+2KcVp
        hSfyw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeT-0004Fm-3M; Fri, 18 Oct 2019 18:07:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 819E72743276; Fri, 18 Oct 2019 19:07:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Junya Monden <jmonden@jp.adit-jv.com>
Cc:     alsa-devel@alsa-project.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiada Wang <jiada_wang@mentor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: Applied "ASoC: rsnd: Reinitialize bit clock inversion flag for every format setting" to the asoc tree
In-Reply-To: <20191016124255.7442-1-erosca@de.adit-jv.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180700.819E72743276@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: Reinitialize bit clock inversion flag for every format setting

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

From 22e58665a01006d05f0239621f7d41cacca96cc4 Mon Sep 17 00:00:00 2001
From: Junya Monden <jmonden@jp.adit-jv.com>
Date: Wed, 16 Oct 2019 14:42:55 +0200
Subject: [PATCH] ASoC: rsnd: Reinitialize bit clock inversion flag for every
 format setting

Unlike other format-related DAI parameters, rdai->bit_clk_inv flag
is not properly re-initialized when setting format for new stream
processing. The inversion, if requested, is then applied not to default,
but to a previous value, which leads to SCKP bit in SSICR register being
set incorrectly.
Fix this by re-setting the flag to its initial value, determined by format.

Fixes: 1a7889ca8aba3 ("ASoC: rsnd: fixup SND_SOC_DAIFMT_xB_xF behavior")
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>
Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Junya Monden <jmonden@jp.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20191016124255.7442-1-erosca@de.adit-jv.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index bda5b958d0dc..e9596c2096cd 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -761,6 +761,7 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set format */
+	rdai->bit_clk_inv = 0;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		rdai->sys_delay = 0;
-- 
2.20.1

