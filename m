Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFEF22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dzjJNvq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbfGYRAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:00:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390363AbfGYQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:59:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so51593440wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSaABRSxmdPUIlgGnW2e+CGetJdVeG6KV5A9m/NM03Q=;
        b=dzjJNvq7xJTWyXkFVbIaJLjqZBZoU8ZqdT/QCMdQPbuJsEia8N4AjHH78SYDIQU/MF
         SE3D5rq72pKncku4roeMltpWj1HtoMrqQExGA9l/OLQrjzQSCOZtLQfjLYLzl51m+0xS
         3sw1Fy+4OfjzyaOVMeQG4tcxFmsfPZNwitZYidiZtbQXEeSBxYGe4eRDxWDYqyeREeO9
         2wZKTH81vMLCcOTF+aDJwx9/t02mvMe+3tm4AXN1U3z/r2/CscTu6HotbuaVp6x5x+0l
         vYuvLlI/PjAaD+IrADHxVH5rHmxz/Qiq8cBtSkr4OhXxDHLlByhqVuU5Llzhx0X4VtrO
         GoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSaABRSxmdPUIlgGnW2e+CGetJdVeG6KV5A9m/NM03Q=;
        b=m+05SqPJGUN+UH+hQSHSsi0/wxfwruA7AvYl3nT9FgrNY+Toi7asJ64hHO+JGhCade
         BWmvJD9ZfE3dU6twPVnxHMZtwTLAnWsT7uTEuxM/MCHE3TWFzNHzjNw422WQ8W31LGBq
         0R4AhIQwogsWgkYDkjSX8fmLPGTInXmI+T63JTCr6DTrdTC3VW0US4R81F2N6XRttrf5
         3fWFbFXXYLsAfSJD/8W4b1CIQaVRzlCil2SgHlGafyAyY1yXPL+DtkKBdhQIIhpGuBsL
         AZm2smGVwBKPNaeXRWMZOQtfPlFiDNyH3TitaBHcZINHA0OO6D6DaIZG7hALG9xW2cZm
         2w3Q==
X-Gm-Message-State: APjAAAUb8oDsG95vwt1MaHkzLz9nnw7X5uc0yxkmO05DxrCwEHTZcmNQ
        fZr8XcnwnB0crfcFKgDfsVjwSw==
X-Google-Smtp-Source: APXvYqzRG6Az+MgGqxxEBAb5E5EGfhL+MFHK/+8S7Iq7P68KOK5tPCMXEIL5dt32F7Ydq6A6BwLZGA==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr95779961wrq.143.1564073996455;
        Thu, 25 Jul 2019 09:59:56 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q10sm53627199wrf.32.2019.07.25.09.59.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 09:59:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 4/6] ASoC: create pcm for codec2codec links as well
Date:   Thu, 25 Jul 2019 18:59:47 +0200
Message-Id: <20190725165949.29699-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725165949.29699-1-jbrunet@baylibre.com>
References: <20190725165949.29699-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, codec to codec links uses an ephemeral variable for
the struct snd_pcm_substream. Also the struct snd_soc_pcm_runtime
does not have real struct snd_pcm.

This might a problem if the functions used by a codec on codec to
codec link expect these structures to exist, and keep on existing
during the life of the codec.

For example, it is the case of the hdmi-codec, which uses
snd_pcm_add_chmap_ctls(). For the controls to works, the pcm and
substream must to exist.

This change is first step, it create pcm (and substreams) for codec
to codec links, in the same way as dpcm backend links.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 42 ++++++++++++------------------------------
 sound/soc/soc-pcm.c  | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7ecfe641ca46..9e8eb93c8a3f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -447,16 +447,6 @@ static void snd_soc_flush_all_delayed_work(struct snd_soc_card *card)
 		flush_delayed_work(&rtd->delayed_work);
 }
 
-static void codec2codec_close_delayed_work(struct work_struct *work)
-{
-	/*
-	 * Currently nothing to do for c2c links
-	 * Since c2c links are internal nodes in the DAPM graph and
-	 * don't interface with the outside world or application layer
-	 * we don't have to do any special handling on close.
-	 */
-}
-
 #ifdef CONFIG_PM_SLEEP
 /* powers down audio subsystem for suspend */
 int snd_soc_suspend(struct device *dev)
@@ -1552,27 +1542,19 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		return ret;
 	}
 
-	if (!dai_link->params) {
-		/* create the pcm */
-		ret = soc_new_pcm(rtd, num);
-		if (ret < 0) {
-			dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
-				dai_link->stream_name, ret);
-			return ret;
-		}
-		ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
-		if (ret < 0)
-			return ret;
-		ret = soc_link_dai_pcm_new(rtd->codec_dais,
-					   rtd->num_codecs, rtd);
-		if (ret < 0)
-			return ret;
-	} else {
-		INIT_DELAYED_WORK(&rtd->delayed_work,
-				  codec2codec_close_delayed_work);
+	/* create the pcm */
+	ret = soc_new_pcm(rtd, num);
+	if (ret < 0) {
+		dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
+			dai_link->stream_name, ret);
+		return ret;
 	}
-
-	return 0;
+	ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+	if (ret < 0)
+		return ret;
+	ret = soc_link_dai_pcm_new(rtd->codec_dais,
+				   rtd->num_codecs, rtd);
+	return ret;
 }
 
 static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fabeac164a6c..30264bc592f6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -678,6 +678,16 @@ static void close_delayed_work(struct work_struct *work)
 	mutex_unlock(&rtd->pcm_mutex);
 }
 
+static void codec2codec_close_delayed_work(struct work_struct *work)
+{
+	/*
+	 * Currently nothing to do for c2c links
+	 * Since c2c links are internal nodes in the DAPM graph and
+	 * don't interface with the outside world or application layer
+	 * we don't have to do any special handling on close.
+	 */
+}
+
 /*
  * Called by ALSA when a PCM substream is closed. Private data can be
  * freed here. The cpu DAI, codec DAI, machine and components are also
@@ -3011,6 +3021,12 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		playback = rtd->dai_link->dpcm_playback;
 		capture = rtd->dai_link->dpcm_capture;
 	} else {
+		/* Adapt stream for codec2codec links */
+		struct snd_soc_pcm_stream *cpu_capture = rtd->dai_link->params ?
+			&cpu_dai->driver->playback : &cpu_dai->driver->capture;
+		struct snd_soc_pcm_stream *cpu_playback = rtd->dai_link->params ?
+			&cpu_dai->driver->capture : &cpu_dai->driver->playback;
+
 		for_each_rtd_codec_dai(rtd, i, codec_dai) {
 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
 			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
@@ -3019,6 +3035,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
 				capture = 1;
 		}
+
+		capture = capture && cpu_capture->channels_min;
+		playback = playback && cpu_playback->channels_min;
 	}
 
 	if (rtd->dai_link->playback_only) {
@@ -3032,7 +3051,13 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 
 	/* create the PCM */
-	if (rtd->dai_link->no_pcm) {
+	if (rtd->dai_link->params) {
+		snprintf(new_name, sizeof(new_name), "codec2codec(%s)",
+			 rtd->dai_link->stream_name);
+
+		ret = snd_pcm_new_internal(rtd->card->snd_card, new_name, num,
+					   playback, capture, &pcm);
+	} else if (rtd->dai_link->no_pcm) {
 		snprintf(new_name, sizeof(new_name), "(%s)",
 			rtd->dai_link->stream_name);
 
@@ -3059,13 +3084,17 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	dev_dbg(rtd->card->dev, "ASoC: registered pcm #%d %s\n",num, new_name);
 
 	/* DAPM dai link stream work */
-	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
+	if (rtd->dai_link->params)
+		INIT_DELAYED_WORK(&rtd->delayed_work,
+				  codec2codec_close_delayed_work);
+	else
+		INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
 	pcm->nonatomic = rtd->dai_link->nonatomic;
 	rtd->pcm = pcm;
 	pcm->private_data = rtd;
 
-	if (rtd->dai_link->no_pcm) {
+	if (rtd->dai_link->no_pcm || rtd->dai_link->params) {
 		if (playback)
 			pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data = rtd;
 		if (capture)
-- 
2.21.0

