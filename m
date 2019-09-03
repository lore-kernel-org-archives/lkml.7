Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3193FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B122CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfICQxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:53:55 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:18185 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbfICQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:53:48 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x83GrQRs037055;
        Wed, 4 Sep 2019 01:53:26 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Wed, 04 Sep 2019 01:53:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x83GrNwm037038
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 4 Sep 2019 01:53:26 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v3 3/4] ASoC: es8316: support fixed clock rate
Date:   Wed,  4 Sep 2019 01:53:21 +0900
Message-Id: <20190903165322.20791-3-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903165322.20791-1-katsuhiro@katsuster.net>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports some type of machine drivers that use fixed clock
rate. After applied this patch, sysclk == 0 means there is no
constraint of sound rate and other values will set constraints which
is derived by sysclk setting.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes from v2:
  - Newly added
---
 sound/soc/codecs/es8316.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index ab41f2c056bd..bf390bc64177 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -432,20 +432,6 @@ static int es8316_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int es8316_pcm_startup(struct snd_pcm_substream *substream,
-			      struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
-
-	if (es8316->sysclk == 0) {
-		dev_err(component->dev, "No sysclk provided\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -455,17 +441,16 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	u8 wordlen = 0;
 	int i;
 
-	if (!es8316->sysclk) {
-		dev_err(component->dev, "No MCLK configured\n");
-		return -EINVAL;
-	}
-
 	/* Limit supported sample rates to ones that can be autodetected
 	 * by the codec running in slave mode.
 	 */
 	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
 		const unsigned int ratio = supported_mclk_lrck_ratios[i];
 
+		/* Accept any rates if sysclk is 0. */
+		if (es8316->sysclk == 0)
+			break;
+
 		if (es8316->sysclk % ratio != 0)
 			continue;
 		if (es8316->sysclk / ratio == params_rate(params))
@@ -509,7 +494,6 @@ static int es8316_mute(struct snd_soc_dai *dai, int mute)
 			SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops es8316_ops = {
-	.startup = es8316_pcm_startup,
 	.hw_params = es8316_pcm_hw_params,
 	.set_fmt = es8316_set_dai_fmt,
 	.set_sysclk = es8316_set_dai_sysclk,
-- 
2.23.0.rc1

