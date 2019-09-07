Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6BDC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FB421871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394984AbfIGQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:37:20 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:16949 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392062AbfIGQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:37:20 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x87GawhE091901;
        Sun, 8 Sep 2019 01:36:58 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sun, 08 Sep 2019 01:36:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x87GatL3091872
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 8 Sep 2019 01:36:58 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH 2/2] ASoC: es8316: support fixed and variable both clock rates
Date:   Sun,  8 Sep 2019 01:36:53 +0900
Message-Id: <20190907163653.9382-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190907163653.9382-1-katsuhiro@katsuster.net>
References: <20190907163653.9382-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports some type of machine drivers that set 0 to mclk
when sound device goes to idle state. After applied this patch,
sysclk == 0 means there is no constraint of sound rate and other
values will set constraints which is derived by sysclk setting.

Original code refuses sysclk == 0 setting. But some boards and SoC
(such as RockPro64 and RockChip I2S) has connected SoC MCLK out to
ES8316 MCLK in. In this case, SoC side I2S will choose suitable
frequency of MCLK such as fs * mclk-fs when user starts playing or
capturing.

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

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/codecs/es8316.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 1424ecd6952c..36eef1fb3d18 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -370,8 +370,12 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 	es8316->sysclk = freq;
 
-	if (freq == 0)
+	if (freq == 0) {
+		es8316->sysclk_constraints.list = NULL;
+		es8316->sysclk_constraints.count = 0;
+
 		return 0;
+	}
 
 	ret = clk_set_rate(es8316->mclk, freq);
 	if (ret)
@@ -450,17 +454,10 @@ static int es8316_pcm_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
-	if (es8316->sysclk == 0) {
-		dev_err(component->dev, "No sysclk provided\n");
-		return -EINVAL;
-	}
-
-	/* The set of sample rates that can be supported depends on the
-	 * MCLK supplied to the CODEC.
-	 */
-	snd_pcm_hw_constraint_list(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_RATE,
-				   &es8316->sysclk_constraints);
+	if (es8316->sysclk_constraints.list)
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   &es8316->sysclk_constraints);
 
 	return 0;
 }
@@ -472,11 +469,19 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 	u8 wordlen = 0;
+	int i;
 
-	if (!es8316->sysclk) {
-		dev_err(component->dev, "No MCLK configured\n");
-		return -EINVAL;
+	/* Validate supported sample rates that are autodetected from MCLK */
+	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+		const unsigned int ratio = supported_mclk_lrck_ratios[i];
+
+		if (es8316->sysclk % ratio != 0)
+			continue;
+		if (es8316->sysclk / ratio == params_rate(params))
+			break;
 	}
+	if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS)
+		return -EINVAL;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-- 
2.23.0.rc1

