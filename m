Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D643C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FE522C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zrqlB+sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390995AbfGYRAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:00:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42144 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390422AbfGYRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:00:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so1633810wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EnJ0jijRzS2dTBP0GIfyOBSwlVhZ96JqM4OnSaDQRI=;
        b=zrqlB+sQeoLJtKWiAPhzbwX7kylKCafIO1KzA/FJNgh/a46qxeaQ/MasOdo+mg8G0Z
         L8y7jwoXlzZQ6mvBRNM9cESxXm8O6RC7p8R4gPjxMG4/wLY+A8KnPjT/rA2FcguMEzRR
         WK+Yo7evBQftFi7GAnJYWRodM6BP+eUahkLjq6fR8787Fp0lHkJUgJm2TPeBnJhxih9Z
         df0ZEmbGs8Q6TUiZQlsyGkw+9Of9D2Xg9B0k3mlw0YNO/Uve447bcfwPfqbBJpqXWpqJ
         RbXlyWKZGKmR5OsjNUzIX+ME87sdEbat1tdIi9QxTGGGBEbJoqFT2ihMVmdBt1J++UmS
         yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EnJ0jijRzS2dTBP0GIfyOBSwlVhZ96JqM4OnSaDQRI=;
        b=K8+a/iqywvbR6GLX//fgEC6CuNAOV7rw9LOzGYs8cAEfSrvtEOMN0IEcCIrjl9UOx9
         cyxsKQXrbf3qydMB5VHyiI3yEF0UXkc/CvW094IRaenvpOWOT//xxnuGfyl2ffsi59Rv
         Ko7wLpBEQpAvCiMenSWkop0TzOfp9ED0kC2Ts85CfrAWCasWUN6uuBUv/7xKStq9BK3T
         KYTpRE3VD1aHsDfkhmXYy6RFtiSXTuSoxq0Uqem+ZExw4hXRXSbVys3fXenrAIkoA6/J
         tgaFJ4nWweiaRVbBmz41o5Cqje99rzDW5TnEj3X9czxeUI9/8JfyS5hikW1bzIUI1Gnc
         rbeQ==
X-Gm-Message-State: APjAAAXHdeEfLnw9o3efKFqxP/rx32X4jWpIDJVZ5WLumVJd3RhCrevu
        O+iH6O4P+ZoUhla2iwYsD96ryA==
X-Google-Smtp-Source: APXvYqxEblA+PCUWIbY76D7kzv+FxZVbr0kf2a5ecdJme01X+6vy1qWx+hdSCNysEqSdKYujVt5U1Q==
X-Received: by 2002:adf:a299:: with SMTP id s25mr88349171wra.74.1564073997566;
        Thu, 25 Jul 2019 09:59:57 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q10sm53627199wrf.32.2019.07.25.09.59.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 09:59:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 5/6] ASoC: codec2codec: remove ephemeral variables
Date:   Thu, 25 Jul 2019 18:59:48 +0200
Message-Id: <20190725165949.29699-6-jbrunet@baylibre.com>
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

Now that codec to codec links struct snd_soc_pcm_runtime have lasting pcm
and substreams, let's use them. Alsa allocate and keep the
struct snd_pcm_runtime as long as the link is powered.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6dcaf9ff6eb5..3e3b81ae87dd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3773,6 +3773,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_hw_params *params = NULL;
 	const struct snd_soc_pcm_stream *config = NULL;
+	struct snd_pcm_runtime *runtime = NULL;
 	unsigned int fmt;
 	int ret;
 
@@ -3780,6 +3781,14 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	if (!params)
 		return -ENOMEM;
 
+	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
+	if (!runtime) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	substream->runtime = runtime;
+
 	substream->stream = SNDRV_PCM_STREAM_CAPTURE;
 	snd_soc_dapm_widget_for_each_source_path(w, path) {
 		source = path->source->priv;
@@ -3806,6 +3815,8 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 		sink->active++;
 	}
 
+	substream->hw_opened = 1;
+
 	/*
 	 * Note: getting the config after .startup() gives a chance to
 	 * either party on the link to alter the configuration if
@@ -3862,6 +3873,9 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	}
 
 out:
+	if (ret < 0)
+		kfree(runtime);
+
 	kfree(params);
 	return 0;
 }
@@ -3871,29 +3885,16 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dai *source, *sink;
-	struct snd_soc_pcm_runtime *rtd = w->priv;
-	struct snd_pcm_substream substream;
-	struct snd_pcm_runtime *runtime = NULL;
-	int ret = 0;
+	struct snd_pcm_substream *substream = w->priv;
+	int ret = 0, saved_stream = substream->stream;
 
 	if (WARN_ON(list_empty(&w->edges[SND_SOC_DAPM_DIR_OUT]) ||
 		    list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])))
 		return -EINVAL;
 
-	memset(&substream, 0, sizeof(substream));
-
-	/* Allocate a dummy snd_pcm_runtime for startup() and other ops() */
-	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
-	if (!runtime) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	substream.runtime = runtime;
-	substream.private_data = rtd;
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		ret = snd_soc_dai_link_event_pre_pmu(w, &substream);
+		ret = snd_soc_dai_link_event_pre_pmu(w, substream);
 		if (ret < 0)
 			goto out;
 
@@ -3924,40 +3925,45 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			ret = 0;
 		}
 
-		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		substream->stream = SNDRV_PCM_STREAM_CAPTURE;
 		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			source = path->source->priv;
-			snd_soc_dai_hw_free(source, &substream);
+			snd_soc_dai_hw_free(source, substream);
 		}
 
-		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		substream->stream = SNDRV_PCM_STREAM_PLAYBACK;
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
-			snd_soc_dai_hw_free(sink, &substream);
+			snd_soc_dai_hw_free(sink, substream);
 		}
 
-		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		substream->stream = SNDRV_PCM_STREAM_CAPTURE;
 		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			source = path->source->priv;
 			source->active--;
-			snd_soc_dai_shutdown(source, &substream);
+			snd_soc_dai_shutdown(source, substream);
 		}
 
-		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		substream->stream = SNDRV_PCM_STREAM_PLAYBACK;
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
 			sink->active--;
-			snd_soc_dai_shutdown(sink, &substream);
+			snd_soc_dai_shutdown(sink, substream);
 		}
 		break;
 
+	case SND_SOC_DAPM_POST_PMD:
+		kfree(substream->runtime);
+		break;
+
 	default:
 		WARN(1, "Unknown event %d\n", event);
 		ret = -EINVAL;
 	}
 
 out:
-	kfree(runtime);
+	/* Restore the substream direction */
+	substream->stream = saved_stream;
 	return ret;
 }
 
@@ -4080,9 +4086,11 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
 }
 
 static struct snd_soc_dapm_widget *
-snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
+snd_soc_dapm_new_dai(struct snd_soc_card *card,
+		     struct snd_pcm_substream *substream,
 		     char *id)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
 	const char **w_param_text;
@@ -4101,7 +4109,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	template.name = link_name;
 	template.event = snd_soc_dai_link_event;
 	template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		SND_SOC_DAPM_PRE_PMD;
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD;
 	template.kcontrol_news = NULL;
 
 	/* allocate memory for control, only in case of multiple configs */
@@ -4136,7 +4144,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 		goto outfree_kcontrol_news;
 	}
 
-	w->priv = rtd;
+	w->priv = substream;
 
 	return w;
 
@@ -4258,6 +4266,8 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dapm_widget *playback = NULL, *capture = NULL;
 	struct snd_soc_dapm_widget *codec, *playback_cpu, *capture_cpu;
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_str *streams = rtd->pcm->streams;
 	int i;
 
 	if (rtd->dai_link->params) {
@@ -4276,7 +4286,8 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 
 		if (playback_cpu && codec) {
 			if (!playback) {
-				playback = snd_soc_dapm_new_dai(card, rtd,
+				substream = streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+				playback = snd_soc_dapm_new_dai(card, substream,
 								"playback");
 				if (IS_ERR(playback)) {
 					dev_err(rtd->dev,
@@ -4305,7 +4316,8 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 
 		if (codec && capture_cpu) {
 			if (!capture) {
-				capture = snd_soc_dapm_new_dai(card, rtd,
+				substream = streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+				capture = snd_soc_dapm_new_dai(card, substream,
 							       "capture");
 				if (IS_ERR(capture)) {
 					dev_err(rtd->dev,
-- 
2.21.0

