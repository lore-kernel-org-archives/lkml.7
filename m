Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C99C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316372075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OM63BoL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfEBEHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 00:07:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42652 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfEBEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 00:07:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so401198pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOwKWUPB3XYL5vqCBpfMhq2ycc4DNiuOgeK/TTjRmug=;
        b=OM63BoL46xvlrzeumkV1LZA93RUL3Tn8qyNAtNyvef+IRAl9lg08hzIZVDBLnB43l9
         faSzDUTKXqhKzADVxeVXcKYh3EscgVnyI2P3JuY0rzwfvhkjCIZK/sLhRkz6YTnjy8U3
         ac8Rq85iP1+dm+tMt6U5hhlK0hwcuOiV2/DAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOwKWUPB3XYL5vqCBpfMhq2ycc4DNiuOgeK/TTjRmug=;
        b=OX7O13ttTHgWqEMvmVxREB3Ry82o6aQZ0WLOKwxK+pTgZFOlmySHAdsxixQYxikXs/
         lM7taYTAQNNCWZGQlws3tG0m7zZhykSP5TXYDjd69JLFy9jiYuObUHLWghubdLeyQqaE
         kTFxe6GIKTIDW3W2LhqqJaLseRTvRtfKnS+4R/0xfpe048g18knCQMzU5GbpEsbEOQOA
         NY53EIa9uNUse0fggkcJWQmvInR6X5M/Xz+eWIjcdEb5pmtWYj43MPCfinZtS0qnfG/E
         WMRk5Hy2gZZe3yVpFidtzoqix1uLDR6nKESU2l+BCY97fYvtUjDYUgL0l9G4E6R7zYNP
         iArQ==
X-Gm-Message-State: APjAAAUVPf8CZzzfCw/LH9umNE+GGhKpI+7eHsQPtFTuNbbiuYdSBvTK
        iOWyeJIkO3riSTPO1JEpn5onWErRnawp8Q==
X-Google-Smtp-Source: APXvYqzB3uwZbHEMviHNeD8m1xkKNL2FXm123P94Bp57SbqrASolvKxjmDOyHF1jlW5+fb0pShkuzA==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr1343912plt.104.1556770072646;
        Wed, 01 May 2019 21:07:52 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:6cc8:36d1:3ceb:a986])
        by smtp.gmail.com with ESMTPSA id d5sm31527869pgb.33.2019.05.01.21.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 21:07:51 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH] ASoC: da7219: Update the support rate list
Date:   Thu,  2 May 2019 12:07:43 +0800
Message-Id: <20190502040743.184310-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to set rate to 64000 on da7219, it fails and returns
"snd_pcm_hw_params: Invalid argument".
We should remove 64000 from support rate list because it is not
available.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/da7219.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5f5fa3416af3..7497457cf3d4 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1658,20 +1658,26 @@ static const struct snd_soc_dai_ops da7219_dai_ops = {
 #define DA7219_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
+#define DA7219_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+		      SNDRV_PCM_RATE_96000)
+
 static struct snd_soc_dai_driver da7219_dai = {
 	.name = "da7219-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = DA7219_DAI_CH_NUM_MAX,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = DA7219_RATES,
 		.formats = DA7219_FORMATS,
 	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = DA7219_DAI_CH_NUM_MAX,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = DA7219_RATES,
 		.formats = DA7219_FORMATS,
 	},
 	.ops = &da7219_dai_ops,
-- 
2.21.0.593.g511ec345e18-goog

