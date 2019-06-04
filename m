Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75543C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A823235EE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lhbk6CaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFDKpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:45:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41761 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfFDKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:45:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so8046601plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tnxaz1jFi+0c70adFdZwh4smT92+AgzJSxKEKHIEhF4=;
        b=Lhbk6CaRYULPnEKNSyq8RYLlZKVu0r/YOy5oOmx4UPBjmsxzCga0HaKw+Z60/X04OK
         GJ6slNfxshzwmy+Sk4gmQlinmXFXyRbTnIRFZ2ctwS8EZW85i4fmCX7gqfNNeKWpJcZd
         eaLMNpFWIOg95t5sHxnxp2cdnsuFv5BLyGijo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tnxaz1jFi+0c70adFdZwh4smT92+AgzJSxKEKHIEhF4=;
        b=qXP1D35Is8MB0iT3tR4SeHby539cR8VEq5dv7/rxLR5snFzFAUAJk55F/dO0UIQ04s
         tIhFgoFyQCzcnDbsLv6Cqtn0sz9yhNP68bEjkhvJIJnC0eBYiK3q3GUDjbWxOXEP+ANc
         WmpZdwBNLh5u9GHkNVYXeVNHqVRBlFOWjus656C85LGJGJ3vAN9fwb+T00GyP6XI3PnF
         m09iA3tnpd9CokVnItE4ie14WZlwAJAlWcClDcQf/QuScbYF64rKJyg49QcVs+279ooz
         kakH1zxrDn4/wpr0O5nVmqsZci7bTY3QUppIPKmnvlaUVBlmn5nrB1jT/5n7arBJcWj5
         bNag==
X-Gm-Message-State: APjAAAWdyC9uXUjhlu3rvxxGCQLBfL4kyODwlaozlkxkKXS847BCuzOW
        +Cji6y85xV+Sj3/0uJAh3gG6wDYxXC0=
X-Google-Smtp-Source: APXvYqwh/4ffwfhgvj6Uv62eFrI0oVq5vlDa+xCXZjEBrFlgI5XBmHVEkkd3NqjNx2+6PfY2MIM85Q==
X-Received: by 2002:a17:902:1cb:: with SMTP id b69mr36438915plb.1.1559645139983;
        Tue, 04 Jun 2019 03:45:39 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id j20sm14171954pff.183.2019.06.04.03.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 03:45:39 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        cychiang@chromium.org
Subject: [PATCH v3] ASoC: max98090: remove 24-bit format support if RJ is 0
Date:   Tue,  4 Jun 2019 18:45:32 +0800
Message-Id: <20190604104532.110492-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported formats are S16_LE and S24_LE now. However, by datasheet
of max98090, S24_LE is only supported when it is in the right justified
mode. We should remove 24-bit format if it is not in that mode to avoid
triggering error.

Change-Id: I304882e0b67974f8fe4c2a47c61a41a04635b2df
Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
Fix compile error.
codec->dai => dai
runtime => substream->runtime

 sound/soc/codecs/max98090.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..ada8c25e643d 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1909,6 +1909,21 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
 	return 0;
 }
 
+static int max98090_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
+	unsigned int fmt = max98090->dai_fmt;
+
+	/* Remove 24-bit format support if it is not in right justified mode. */
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
+		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
+	}
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -2316,6 +2331,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
+	.startup = max98090_dai_startup,
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
-- 
2.22.0.rc1.311.g5d7573a151-goog

