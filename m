Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66217C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9DF20730
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfKTPYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:24:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47090 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbfKTPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:24:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6D9162910F0
Received: by earth.universe (Postfix, from userid 1000)
        id 35C833C0C7C; Wed, 20 Nov 2019 16:24:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 6/6] ASoC: da7213: Add default clock handling
Date:   Wed, 20 Nov 2019 16:24:06 +0100
Message-Id: <20191120152406.2744-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120152406.2744-1-sebastian.reichel@collabora.com>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds default clock/PLL configuration to the driver
for usage with generic drivers like simple-card for usage
with a fixed rate clock.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 sound/soc/codecs/da7213.c | 75 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7213.h |  2 ++
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3e6ad996741b..ff1a936240be 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1156,6 +1156,7 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 	u8 dai_ctrl = 0;
 	u8 fs;
 
@@ -1181,33 +1182,43 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 		fs = DA7213_SR_8000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 11025:
 		fs = DA7213_SR_11025;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 12000:
 		fs = DA7213_SR_12000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 16000:
 		fs = DA7213_SR_16000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 22050:
 		fs = DA7213_SR_22050;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 32000:
 		fs = DA7213_SR_32000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 44100:
 		fs = DA7213_SR_44100;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 48000:
 		fs = DA7213_SR_48000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 88200:
 		fs = DA7213_SR_88200;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 96000:
 		fs = DA7213_SR_96000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	default:
 		return -EINVAL;
@@ -1392,9 +1403,9 @@ static int da7213_set_component_sysclk(struct snd_soc_component *component,
 }
 
 /* Supported PLL input frequencies are 32KHz, 5MHz - 54MHz. */
-static int da7213_set_component_pll(struct snd_soc_component *component,
-				    int pll_id, int source,
-				    unsigned int fref, unsigned int fout)
+static int _da7213_set_component_pll(struct snd_soc_component *component,
+				     int pll_id, int source,
+				     unsigned int fref, unsigned int fout)
 {
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 
@@ -1503,6 +1514,16 @@ static int da7213_set_component_pll(struct snd_soc_component *component,
 	return 0;
 }
 
+static int da7213_set_component_pll(struct snd_soc_component *component,
+				    int pll_id, int source,
+				    unsigned int fref, unsigned int fout)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	da7213->fixed_clk_auto_pll = false;
+
+	return _da7213_set_component_pll(component, pll_id, source, fref, fout);
+}
+
 /* DAI operations */
 static const struct snd_soc_dai_ops da7213_dai_ops = {
 	.hw_params	= da7213_hw_params,
@@ -1532,6 +1553,43 @@ static struct snd_soc_dai_driver da7213_dai = {
 	.symmetric_rates = 1,
 };
 
+static int da7213_set_auto_pll(struct snd_soc_component *component, bool enable)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int mode;
+
+	if (!da7213->fixed_clk_auto_pll)
+		return 0;
+
+	da7213->mclk_rate = clk_get_rate(da7213->mclk);
+
+	if (enable)
+		mode = DA7213_SYSCLK_PLL;
+	else
+		mode = DA7213_SYSCLK_MCLK;
+
+	switch (da7213->out_rate) {
+	case DA7213_PLL_FREQ_OUT_90316800:
+		if (da7213->mclk_rate == 11289600 ||
+		    da7213->mclk_rate == 22579200 ||
+		    da7213->mclk_rate == 45158400)
+			mode = DA7213_SYSCLK_MCLK;
+		break;
+	case DA7213_PLL_FREQ_OUT_98304000:
+		if (da7213->mclk_rate == 12288000 ||
+		    da7213->mclk_rate == 24576000 ||
+		    da7213->mclk_rate == 49152000)
+			mode = DA7213_SYSCLK_MCLK;
+
+		break;
+	default:
+		return -1;
+	}
+
+	return _da7213_set_component_pll(component, 0, mode,
+					 da7213->mclk_rate, da7213->out_rate);
+}
+
 static int da7213_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
@@ -1551,6 +1609,8 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 						"Failed to enable mclk\n");
 					return ret;
 				}
+
+				da7213_set_auto_pll(component, true);
 			}
 		}
 		break;
@@ -1562,8 +1622,10 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 					    DA7213_VMID_EN | DA7213_BIAS_EN);
 		} else {
 			/* Remove MCLK */
-			if (da7213->mclk)
+			if (da7213->mclk) {
+				da7213_set_auto_pll(component, false);
 				clk_disable_unprepare(da7213->mclk);
+			}
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -1829,6 +1891,11 @@ static int da7213_probe(struct snd_soc_component *component)
 			return PTR_ERR(da7213->mclk);
 		else
 			da7213->mclk = NULL;
+	} else {
+		/* Do automatic PLL handling assuming fixed clock until
+		 * set_pll() has been called. This makes the codec usable
+		 * with the simple-audio-card driver. */
+		da7213->fixed_clk_auto_pll = true;
 	}
 
 	return 0;
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 3890829dfb6e..97ccf0ddd2be 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -535,10 +535,12 @@ struct da7213_priv {
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
 	unsigned int mclk_rate;
+	unsigned int out_rate;
 	int clk_src;
 	bool master;
 	bool alc_calib_auto;
 	bool alc_en;
+	bool fixed_clk_auto_pll;
 	struct da7213_platform_data *pdata;
 };
 
-- 
2.24.0

