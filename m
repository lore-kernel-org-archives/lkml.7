Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47365CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CDB2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbfJWPUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:20:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:42649 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390636AbfJWPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:20:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 08:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="349419680"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2019 08:20:01 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naveen M <naveen.m@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: eve: Enable mclk and ssp sclk early for rt5514
Date:   Wed, 23 Oct 2019 23:16:36 +0800
Message-Id: <1571843796-5021-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first DMIC capture always fail (zero sequence data from PCM port)
after using DSP hotwording function (i.e. Google assistant). The DMIC
is attached to rt5514 which also require eaily mclk/sclk like rt5663.
Therefore we add a dapm route to provide ssp mclk/sclk early to rt5514.
The rt5514 is attached to SSP0 and the rt5663 is attached to SSP1 so
we create another supply widget to provide SSP0 mclk/sclk to rt5514.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 136 ++++++++++++++-------
 1 file changed, 92 insertions(+), 44 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index dc09a85..1755efa 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -53,8 +53,10 @@ struct kbl_codec_private {
 	struct snd_soc_jack kabylake_headset;
 	struct list_head hdmi_pcm_list;
 	struct snd_soc_jack kabylake_hdmi[2];
-	struct clk *mclk;
-	struct clk *sclk;
+	struct clk *ssp0_mclk;
+	struct clk *ssp0_sclk;
+	struct clk *ssp1_mclk;
+	struct clk *ssp1_sclk;
 };
 
 enum {
@@ -77,13 +79,31 @@ static const struct snd_kcontrol_new kabylake_controls[] = {
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *k, int  event)
+			struct snd_kcontrol *k, int event, int ssp_num)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(card);
+	struct clk *mclk, *sclk;
+	unsigned long sclk_rate;
 	int ret = 0;
 
+	switch (ssp_num) {
+	case 0:
+		mclk = priv->ssp0_mclk;
+		sclk = priv->ssp0_sclk;
+		sclk_rate = 6144000;
+		break;
+	case 1:
+		mclk = priv->ssp1_mclk;
+		sclk = priv->ssp1_sclk;
+		sclk_rate = 3072000;
+		break;
+	default:
+		dev_err(card->dev, "Invalid ssp_num %d\n", ssp_num);
+		return -EINVAL;
+	}
+
 	/*
 	 * MCLK/SCLK need to be ON early for a successful synchronization of
 	 * codec internal clock. And the clocks are turned off during
@@ -92,37 +112,39 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Enable MCLK */
-		ret = clk_set_rate(priv->mclk, 24000000);
+		ret = clk_set_rate(mclk, 24000000);
 		if (ret < 0) {
-			dev_err(card->dev, "Can't set rate for mclk, err: %d\n",
-				ret);
+			dev_err(card->dev, "Can't set rate for ssp%d_mclk, err: %d\n",
+				ssp_num, ret);
 			return ret;
 		}
 
-		ret = clk_prepare_enable(priv->mclk);
+		ret = clk_prepare_enable(mclk);
 		if (ret < 0) {
-			dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
+			dev_err(card->dev, "Can't enable ssp%d_mclk, err: %d\n",
+				ssp_num, ret);
 			return ret;
 		}
 
 		/* Enable SCLK */
-		ret = clk_set_rate(priv->sclk, 3072000);
+		ret = clk_set_rate(sclk, sclk_rate);
 		if (ret < 0) {
-			dev_err(card->dev, "Can't set rate for sclk, err: %d\n",
-				ret);
-			clk_disable_unprepare(priv->mclk);
+			dev_err(card->dev, "Can't set rate for ssp%d_sclk, err: %d\n",
+				ssp_num, ret);
+			clk_disable_unprepare(mclk);
 			return ret;
 		}
 
-		ret = clk_prepare_enable(priv->sclk);
+		ret = clk_prepare_enable(sclk);
 		if (ret < 0) {
-			dev_err(card->dev, "Can't enable sclk, err: %d\n", ret);
-			clk_disable_unprepare(priv->mclk);
+			dev_err(card->dev, "Can't enable ssp%d_sclk, err: %d\n",
+				ssp_num, ret);
+			clk_disable_unprepare(mclk);
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		clk_disable_unprepare(priv->mclk);
-		clk_disable_unprepare(priv->sclk);
+		clk_disable_unprepare(mclk);
+		clk_disable_unprepare(sclk);
 		break;
 	default:
 		return 0;
@@ -131,6 +153,18 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int platform_clock_control_ssp0(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	return platform_clock_control(w, k, event, 0);
+}
+
+static int platform_clock_control_ssp1(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	return platform_clock_control(w, k, event, 1);
+}
+
 static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -139,15 +173,17 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
-	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
-			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+	SND_SOC_DAPM_SUPPLY("Platform Clock SSP0", SND_SOC_NOPM, 0, 0,
+			platform_clock_control_ssp0, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("Platform Clock SSP1", SND_SOC_NOPM, 0, 0,
+			platform_clock_control_ssp1, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
-
 };
 
 static const struct snd_soc_dapm_route kabylake_map[] = {
 	/* Headphones */
-	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headphone Jack", NULL, "Platform Clock SSP1" },
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 
@@ -156,7 +192,7 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "Right Spk", NULL, "Right BE_OUT" },
 
 	/* other jacks */
-	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock SSP1" },
 	{ "IN1P", NULL, "Headset Mic" },
 	{ "IN1N", NULL, "Headset Mic" },
 
@@ -180,6 +216,7 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
 
 	/* DMIC */
+	{ "DMIC", NULL, "Platform Clock SSP0" },
 	{ "DMIC1L", NULL, "DMIC" },
 	{ "DMIC1R", NULL, "DMIC" },
 	{ "DMIC2L", NULL, "DMIC" },
@@ -704,6 +741,29 @@ static struct snd_soc_card kabylake_audio_card = {
 	.late_probe = kabylake_card_late_probe,
 };
 
+static int kabylake_audio_clk_get(struct device *dev, const char *id,
+	struct clk **clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		return -EINVAL;
+
+	*clk = devm_clk_get(dev, id);
+	if (IS_ERR(*clk)) {
+		ret = PTR_ERR(*clk);
+		if (ret == -ENOENT) {
+			dev_info(dev, "Failed to get %s, defer probe\n", id);
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(dev, "Failed to get %s with err:%d\n", id, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_codec_private *ctx;
@@ -724,33 +784,21 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
-	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
-	if (IS_ERR(ctx->mclk)) {
-		ret = PTR_ERR(ctx->mclk);
-		if (ret == -ENOENT) {
-			dev_info(&pdev->dev,
-				"Failed to get ssp1_mclk, defer probe\n");
-			return -EPROBE_DEFER;
-		}
+	ret = kabylake_audio_clk_get(&pdev->dev, "ssp0_mclk", &ctx->ssp0_mclk);
+	if (ret != 0)
+		return ret;
 
-		dev_err(&pdev->dev, "Failed to get ssp1_mclk with err:%d\n",
-								ret);
+	ret = kabylake_audio_clk_get(&pdev->dev, "ssp0_sclk", &ctx->ssp0_sclk);
+	if (ret != 0)
 		return ret;
-	}
 
-	ctx->sclk = devm_clk_get(&pdev->dev, "ssp1_sclk");
-	if (IS_ERR(ctx->sclk)) {
-		ret = PTR_ERR(ctx->sclk);
-		if (ret == -ENOENT) {
-			dev_info(&pdev->dev,
-				"Failed to get ssp1_sclk, defer probe\n");
-			return -EPROBE_DEFER;
-		}
+	ret = kabylake_audio_clk_get(&pdev->dev, "ssp1_mclk", &ctx->ssp1_mclk);
+	if (ret != 0)
+		return ret;
 
-		dev_err(&pdev->dev, "Failed to get ssp1_sclk with err:%d\n",
-								ret);
+	ret = kabylake_audio_clk_get(&pdev->dev, "ssp1_sclk", &ctx->ssp1_sclk);
+	if (ret != 0)
 		return ret;
-	}
 
 	return devm_snd_soc_register_card(&pdev->dev, &kabylake_audio_card);
 }
-- 
2.7.4

