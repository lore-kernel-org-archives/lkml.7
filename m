Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E62C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379921781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574947122;
	bh=O5ijdDTIjSZkMQRZ0BJfjhp/xdsHSFKf0Bqn+YUvPoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=XLS4kjzdqFlAq+lygqm5Li9oQFBkWKccnoYAMO+UbNPosAW1fgYVg1aU86aMMnSAW
	 F1goQiCSCtUI4folVmfWOaKL1TUuQ3mQ9d11BEbad3lhCqMqJESNHeDwwY3aV8WW3Z
	 NIZsV/++uL+Vacppl33+SBpbDAfaGPrLfvC3CZXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfK1NSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:18:41 -0500
Received: from foss.arm.com ([217.140.110.172]:35246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1NSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:18:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1531045;
        Thu, 28 Nov 2019 05:18:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDCEC3F52E;
        Thu, 28 Nov 2019 05:18:39 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:18:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Agrawal Akshu <Akshu.Agrawal@amd.com>,
        Akshu Agrawal <akshu.agarawal@amd.com>,
        alsa-devel@alsa-project.org, Andi Kleen <ak@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Applied "ASoC: AMD: Enable clk in startup intead of hw_params" to the asoc tree
In-Reply-To: <20191126075424.80668-1-yuhsuan@chromium.org>
Message-Id: <applied-20191126075424.80668-1-yuhsuan@chromium.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Enable clk in startup intead of hw_params

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 756ae8f237e19a014a1c20ad5a51b0686463d1f7 Mon Sep 17 00:00:00 2001
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date: Tue, 26 Nov 2019 15:54:24 +0800
Subject: [PATCH] ASoC: AMD: Enable clk in startup intead of hw_params

Some usages only call startup and shutdown without setting hw_params
(e.g. arecord --dump-hw-params). If we don't enable clk in startup, it
will cause ref count error because the clk will be disabled in shutdown.
For this reason, we should move enabling clk from hw_params to startup.

In addition, the hw_params is fixed in this driver(48000 rate, 2
channels, S16_LE format) so we don't need to change the clk rate after
the hw_params is set.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Acked-by: Akshu Agrawal <akshu.agarawal@amd.com>
Link: https://lore.kernel.org/r/20191126075424.80668-1-yuhsuan@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 46 +++++++++-------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index f4ee6798154a..7a5621e5e233 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -96,14 +96,19 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int da7219_clk_enable(struct snd_pcm_substream *substream,
-			     int wclk_rate, int bclk_rate)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
-	clk_set_rate(da7219_dai_wclk, wclk_rate);
-	clk_set_rate(da7219_dai_bclk, bclk_rate);
+	/*
+	 * Set wclk to 48000 because the rate constraint of this driver is
+	 * 48000. ADAU7002 spec: "The ADAU7002 requires a BCLK rate that is
+	 * minimum of 64x the LRCLK sample rate." DA7219 is the only clk
+	 * source so for all codecs we have to limit bclk to 64X lrclk.
+	 */
+	clk_set_rate(da7219_dai_wclk, 48000);
+	clk_set_rate(da7219_dai_bclk, 48000 * 64);
 	ret = clk_prepare_enable(da7219_dai_bclk);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
@@ -156,7 +161,7 @@ static int cz_da7219_play_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->play_i2s_instance = I2S_SP_INSTANCE;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
@@ -178,7 +183,7 @@ static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL1;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
@@ -199,7 +204,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->play_i2s_instance = I2S_BT_INSTANCE;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_dmic0_startup(struct snd_pcm_substream *substream)
@@ -220,7 +225,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->cap_i2s_instance = I2S_BT_INSTANCE;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -242,25 +247,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
-	return 0;
-}
-
-static int cz_da7219_params(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params *params)
-{
-	int wclk, bclk;
-
-	wclk = params_rate(params);
-	bclk = wclk * params_channels(params) *
-		snd_pcm_format_width(params_format(params));
-	/* ADAU7002 spec: "The ADAU7002 requires a BCLK rate
-	 * that is minimum of 64x the LRCLK sample rate."
-	 * DA7219 is the only clk source so for all codecs
-	 * we have to limit bclk to 64X lrclk.
-	 */
-	if (bclk < (wclk * 64))
-		bclk = wclk * 64;
-	return da7219_clk_enable(substream, wclk, bclk);
+	return da7219_clk_enable(substream);
 }
 
 static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
@@ -271,31 +258,26 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 static const struct snd_soc_ops cz_da7219_play_ops = {
 	.startup = cz_da7219_play_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_cap_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_dmic0_cap_ops = {
 	.startup = cz_dmic0_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_dmic1_cap_ops = {
 	.startup = cz_dmic1_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-- 
2.20.1

