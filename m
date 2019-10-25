Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675C121929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408763AbfJYJOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:14:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:39273 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408744AbfJYJOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:14:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="400050841"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 02:14:50 -0700
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
Subject: [PATCH] ASoC: eve: implement set_bias_level function for rt5514
Date:   Fri, 25 Oct 2019 17:11:31 +0800
Message-Id: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first DMIC capture always fail (zero sequence data from PCM port)
after using DSP hotwording function (i.e. Google assistant).

This rt5514 codec requires to control mclk directly in the set_bias_level
function. Implement this function in machine driver to control the
ssp1_mclk clock explicitly could fix this issue.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index dc09a85..b546de8 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -653,6 +653,55 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 	},
 };
 
+static int kabylake_set_bias_level(struct snd_soc_card *card,
+	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	if (!component || strcmp(component->name, RT5514_DEV_NAME))
+		return 0;
+
+	if (IS_ERR(priv->mclk))
+		return 0;
+
+	/*
+	 * It's required to control mclk directly in the set_bias_level
+	 * function for rt5514 codec or the recording function could
+	 * break.
+	 */
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (dapm->bias_level == SND_SOC_BIAS_ON) {
+			dev_dbg(card->dev, "Disable mclk");
+			clk_disable_unprepare(priv->mclk);
+		} else {
+			dev_dbg(card->dev, "Enable mclk");
+			ret = clk_set_rate(priv->mclk, 24000000);
+			if (ret) {
+				dev_err(card->dev, "Can't set rate for mclk, err: %d\n",
+					ret);
+				return ret;
+			}
+
+			ret = clk_prepare_enable(priv->mclk);
+			if (ret) {
+				dev_err(card->dev, "Can't enable mclk, err: %d\n",
+					ret);
+
+				/* mclk is already enabled in FW */
+				ret = 0;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static int kabylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
@@ -692,6 +741,7 @@ static struct snd_soc_card kabylake_audio_card = {
 	.owner = THIS_MODULE,
 	.dai_link = kabylake_dais,
 	.num_links = ARRAY_SIZE(kabylake_dais),
+	.set_bias_level = kabylake_set_bias_level,
 	.controls = kabylake_controls,
 	.num_controls = ARRAY_SIZE(kabylake_controls),
 	.dapm_widgets = kabylake_widgets,
-- 
2.7.4

