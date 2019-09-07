Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E7C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9020221A49
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406272AbfIGRpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:45:16 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:47962 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfIGRpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:45:16 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x87Hj6mw009250;
        Sun, 8 Sep 2019 02:45:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sun, 08 Sep 2019 02:45:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x87Hj3KZ009238
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 8 Sep 2019 02:45:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] SoC: simple-card-utils: set 0Hz to sysclk when shutdown
Date:   Sun,  8 Sep 2019 02:45:01 +0900
Message-Id: <20190907174501.19833-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set 0Hz to sysclk when shutdown the card.

Some codecs set rate constraints that derives from sysclk. This
mechanism works correctly if machine drivers give fixed frequency.

But simple-audio and audio-graph card set variable clock rate if
'mclk-fs' property exists. In this case, rate constraints will go
bad scenario. For example a codec accepts three limited rates
(mclk / 256, mclk / 384, mclk / 512).

Bad scenario as follows (mclk-fs = 256):
   - Initialize sysclk by correct value (Ex. 12.288MHz)
     - Codec set constraints of PCM rate by sysclk
       48kHz (1/256), 32kHz (1/384), 24kHz (1/512)
   - Play 48kHz sound, it's acceptable
   - Sysclk is not changed

   - Play 32kHz sound, it's acceptable
   - Set sysclk to 8.192MHz (= fs * mclk-fs = 32k * 256)
     - Codec set constraints of PCM rate by sysclk
       32kHz (1/256), 21.33kHz (1/384), 16kHz (1/512)

   - Play 48kHz again, but it's NOT acceptable because constraints
     do not allow 48kHz

So codecs treat 0Hz sysclk as signal of applying no constraints to
avoid this problem.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/generic/simple-card-utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 556b1a789629..9b794775df53 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -213,10 +213,17 @@ EXPORT_SYMBOL_GPL(asoc_simple_startup);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
+	if (dai_props->mclk_fs) {
+		snd_soc_dai_set_sysclk(codec_dai, 0, 0, SND_SOC_CLOCK_IN);
+		snd_soc_dai_set_sysclk(cpu_dai, 0, 0, SND_SOC_CLOCK_OUT);
+	}
+
 	asoc_simple_clk_disable(dai_props->cpu_dai);
 
 	asoc_simple_clk_disable(dai_props->codec_dai);
-- 
2.23.0.rc1

