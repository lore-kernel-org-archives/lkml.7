Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A04C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63DE20665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfFUP6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:58:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57410 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:58:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E48D9260D87
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xing Zheng <zhengxing@rock-chips.com>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz sample rates
Date:   Fri, 21 Jun 2019 17:58:08 +0200
Message-Id: <20190621155808.17182-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet the max98357a also supports 32, 44.1 and
88.2 kHz sample rate. This support was also introduced recently by
commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").

Actually the machine driver validates the supported sample rates but
this is not really needed because the component driver can all apply
whatever constraints are needed and do their own validation. So, remove
the checks from the machine driver as are not needed at all. This way,
we also support 32, 44.1 and 88.2 kHz sample rates and we get rid of the
errors like the below.

  rk3399-gru-sound sound: rockchip_sound_max98357a_hw_params() doesn't support this sample rate: 44100
  rk3399-gru-sound sound: ASoC: machine hw_params failed: -22

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- Instead of add supported sample rates, relegate the work to the
  component drivers (Mark)

 sound/soc/rockchip/rk3399_gru_sound.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3d0cc6e90d7b..8cbeeb013a1a 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -55,19 +55,7 @@ static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substrea
 	unsigned int mclk;
 	int ret;
 
-	/* max98357a supports these sample rates */
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-	case 48000:
-	case 96000:
-		mclk = params_rate(params) * SOUND_FS;
-		break;
-	default:
-		dev_err(rtd->card->dev, "%s() doesn't support this sample rate: %d\n",
-				__func__, params_rate(params));
-		return -EINVAL;
-	}
+	mclk = params_rate(params) * SOUND_FS;
 
 	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, 0, mclk, 0);
 	if (ret) {
-- 
2.20.1

