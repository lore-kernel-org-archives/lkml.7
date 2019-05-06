Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED17C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B6208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AndrexMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEFJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:58:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33986 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:58:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so6113571wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfLtGNFClAo6TII3XvesnrIEXOA3C3N3iJ8W2ZBUhMY=;
        b=AndrexMZaltXMXLQICjUp7CV9V4Mp7tlXc1teK2aYdDDsqAYZ2XPSpQntKBfOyEKDY
         +gvcG8eud5mk0ltvrTQi9Q/S1CblmXA0+1qoJxiuzXDIfTxhpdWdSoYwY+oCW0E6S6sR
         DLBQB2PM9EG/5ruV9Hlmw0ATywSf+JpzT0VQYMw717AUIlQ/s+ZrqRiev7kjs5NyYE7t
         mJ0M9fkJJowP5MXW+Ut5eQCKV2QW5pMvaMs3T9VfPxqlh3+9zMdbbRLXgwtlTJjovFVV
         jgdWJGg+fw0/RN1PZyCfU18SKPvjeIo+e/Z9uIDEfGePi/orcdkcQWZJbPfUbypibZsx
         f9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfLtGNFClAo6TII3XvesnrIEXOA3C3N3iJ8W2ZBUhMY=;
        b=UjAQM77UMRP+tmO2Tt4CskQMoJ4bvrpY4IUdMHdM8uBYk4RVG8I5XMFKN5/N9lCpvF
         NHMJxebTwUN2DzYJ6NLmDLjAGaxzQNroy8PctV5oS4P9OhdxXMHe4DqDB19NzpOoC/g3
         3NlyD388diFPbH4504Wily/hYfKZvkmD+ihQa3I4d3Ms+PQKFg4QTprBIDyNmzVK+msO
         0NOC1wUD3O0UdE/kSI+N9t+Rp+gsB/Tg+njjI1OrSgUPyMpkVqcKoSV8hehD6vfGCJn0
         SwFZC9UCsJIb7WF30qBvRH0XxzORa6f0J+TdnFeJmZj3aoYSYOolPsgzWXia1ouYION+
         FaSA==
X-Gm-Message-State: APjAAAWHFCLSlBN+U7WkugAjJsLhHIJaZQSZDJ+zZyXED7uuwx3KiIT+
        aaWrOr+IVZs2xizYq0a7jCzYZA==
X-Google-Smtp-Source: APXvYqyU5tzeDEIIy4cT2QjaaJ2oiPWaQMuDSG+/sop7ymmJTLBYxOZBAITjLAETmZyF60k8YnF6xA==
X-Received: by 2002:a5d:6249:: with SMTP id m9mr611030wrv.255.1557136703654;
        Mon, 06 May 2019 02:58:23 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c10sm23409791wrd.69.2019.05.06.02.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:58:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 1/4] ASoC: hdmi-codec: remove function name debug traces
Date:   Mon,  6 May 2019 11:58:12 +0200
Message-Id: <20190506095815.24578-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506095815.24578-1-jbrunet@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the debug traces only showing the function name on entry.
The same can be obtained using ftrace.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 39caf19abb0b..eb31d7eddcbf 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -416,8 +416,6 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret = hdmi_codec_new_stream(substream, dai);
 	if (ret)
 		return ret;
@@ -457,8 +455,6 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	WARN_ON(hcp->current_stream != substream);
 
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
@@ -527,8 +523,6 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	struct hdmi_codec_daifmt cf = { 0 };
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (dai->id == DAI_ID_SPDIF)
 		return 0;
 
@@ -597,8 +591,6 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (hcp->hcd.ops->digital_mute)
 		return hcp->hcd.ops->digital_mute(dai->dev->parent,
 						  hcp->hcd.data, mute);
@@ -656,8 +648,6 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	};
 	int ret;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				      NULL, drv->playback.channels_max, 0,
 				      &hcp->chmap_info);
@@ -754,8 +744,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	int dai_count, i = 0;
 	int ret;
 
-	dev_dbg(dev, "%s()\n", __func__);
-
 	if (!hcd) {
 		dev_err(dev, "%s: No platform data\n", __func__);
 		return -EINVAL;
-- 
2.20.1

