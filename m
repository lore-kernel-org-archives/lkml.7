Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF9C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C782339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfICQxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:53:48 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:18184 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfICQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:53:48 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x83GrQTW037049;
        Wed, 4 Sep 2019 01:53:26 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Wed, 04 Sep 2019 01:53:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x83GrNwk037038
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 4 Sep 2019 01:53:25 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v3 1/4] ASoC: es8316: judge PCM rate at later timing
Date:   Wed,  4 Sep 2019 01:53:19 +0900
Message-Id: <20190903165322.20791-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch change the judge timing about playing/capturing PCM rate.

Original code set constraints list of PCM rate limits at set_sysclk.
This strategy works well if system is using fixed rate clock.

But some boards and SoC (such as RockPro64 and RockChip I2S) has
connected SoC MCLK out to ES8316 MCLK in. In this case, SoC side I2S
will choose suitable frequency of MCLK such as fs * mclk-fs when
user starts playing or capturing.

Bad scenario as follows (mclk-fs = 256):
  - Initialize sysclk by correct value (Ex. 12.288MHz)
    - ES8316 set constraints of PCM rate by sysclk
      48kHz (1/256), 32kHz (1/384), 30.720kHz (1/400),
      24kHz (1/512), 16kHz (1/768), 12kHz (1/1024)
  - Play 48kHz sound, it's acceptable
  - Sysclk is not changed

  - Play 32kHz sound, it's acceptable
  - Set sysclk by 8.192MHz (= fs * mclk-fs = 32k * 256)
    - ES8316 set constraints of PCM rate by sysclk
      32kHz (1/256), 21.33kHz (1/384), 20.48kHz (1/400),
      16kHz (1/512), 10.66kHz (1/768), 8kHz (1/1024)

  - Play 48kHz again, but it's NOT acceptable because constraints
    list does not allow 48kHz

Root cause of this strange behavior is changing constraints list at
set_sysclk timing. It seems that is too early to determine. So this
patch does not use constraints list and check PCM rate limit more
later timing at hw_params.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/codecs/es8316.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index ed2959dbe1fb..229808fa627c 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -363,27 +363,12 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
-	int i;
-	int count = 0;
 
 	es8316->sysclk = freq;
 
 	if (freq == 0)
 		return 0;
 
-	/* Limit supported sample rates to ones that can be autodetected
-	 * by the codec running in slave mode.
-	 */
-	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
-		const unsigned int ratio = supported_mclk_lrck_ratios[i];
-
-		if (freq % ratio == 0)
-			es8316->allowed_rates[count++] = freq / ratio;
-	}
-
-	es8316->sysclk_constraints.list = es8316->allowed_rates;
-	es8316->sysclk_constraints.count = count;
-
 	return 0;
 }
 
@@ -449,13 +434,6 @@ static int es8316_pcm_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* The set of sample rates that can be supported depends on the
-	 * MCLK supplied to the CODEC.
-	 */
-	snd_pcm_hw_constraint_list(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_RATE,
-				   &es8316->sysclk_constraints);
-
 	return 0;
 }
 
@@ -466,12 +444,27 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 	u8 wordlen = 0;
+	int i;
 
 	if (!es8316->sysclk) {
 		dev_err(component->dev, "No MCLK configured\n");
 		return -EINVAL;
 	}
 
+	/* Limit supported sample rates to ones that can be autodetected
+	 * by the codec running in slave mode.
+	 */
+	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+		const unsigned int ratio = supported_mclk_lrck_ratios[i];
+
+		if (es8316->sysclk % ratio != 0)
+			continue;
+		if (es8316->sysclk / ratio == params_rate(params))
+			break;
+	}
+	if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS)
+		return -EINVAL;
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		wordlen = ES8316_SERDATA2_LEN_16;
-- 
2.23.0.rc1

