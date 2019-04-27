Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43947C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1016B20679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330226;
	bh=zd1ZPJ/RXgFYx3L+3lKym6J4tZk/67k8Hi3H5KmoOPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mce3Vo7eCZY9VIYNoREwnXl7pkk+uxnb4Gg0ZkLrE45lBnJ3VEk6FRSvPlQJj9sbk
	 gdi6GKY1mBynLIOHn933sl7Yhtuj9/L+Dulzk+OQQ7OxC31D/JnU9vRqWsApA2m4kS
	 EUXJZS8gLiDPRLZ+TevmDM8CsrkepQxfALiT36O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfD0Biu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfD0Bis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BE52084F;
        Sat, 27 Apr 2019 01:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329127;
        bh=zd1ZPJ/RXgFYx3L+3lKym6J4tZk/67k8Hi3H5KmoOPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyB+MVv3/2WuIL3Ht5MsAKc+qx3iEb8tnL0CfCE0htQ5s5ZNoaw4C42r5UQB3PWoG
         0xJVJ3NEuGxc1Ifuw2M6rNh+MNO2D20LE2k915UZPP6YdstFwHaPHKvXJODAzvp0Is
         LP5SA8jxQ7NeUWdFXsO5nWhBBbGCzhGgpQsP+MLk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 08/79] ASoC:hdac_hda:use correct format to setup hda codec
Date:   Fri, 26 Apr 2019 21:37:27 -0400
Message-Id: <20190427013838.6596-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

[ Upstream commit 03d0aa4d4fddce4a5d865d819a4d98bfc3d451e6 ]

The current implementation of the hdac_hda codec results in zero-valued
samples on capture and noise with headset playback when SOF is used on
platforms with an on-board HDaudio codec. This is root-caused to SOF
using be_hw_params_fixup, and the prepare() call using invalid runtime
fields to determine the format.

This patch moves the format handling to the hw_params() callback, as
done already for hdac_hdmi, to make sure the fixed-up information is
taken into account but keeps the codec initialization in prepare() as
the stream_tag is only available at that time. Moving everything in the
prepare() callback is possible but the code is less elegant so this
two-step solution was chosen.

The solution was tested with the SST driver with no regressions, and all
the issues with SOF playback and capture are solved.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 53 +++++++++++++++++++++++++++----------
 sound/soc/codecs/hdac_hda.h |  1 +
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index ffecdaaa8cf2..f889d94c8e3c 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -38,6 +38,9 @@ static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai);
 static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai);
+static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai);
 static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai);
 static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
@@ -50,6 +53,7 @@ static const struct snd_soc_dai_ops hdac_hda_dai_ops = {
 	.startup = hdac_hda_dai_open,
 	.shutdown = hdac_hda_dai_close,
 	.prepare = hdac_hda_dai_prepare,
+	.hw_params = hdac_hda_dai_hw_params,
 	.hw_free = hdac_hda_dai_hw_free,
 	.set_tdm_slot = hdac_hda_dai_set_tdm_slot,
 };
@@ -139,6 +143,39 @@ static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	unsigned int format_val;
+	unsigned int maxbps;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		maxbps = dai->driver->playback.sig_bits;
+	else
+		maxbps = dai->driver->capture.sig_bits;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	format_val = snd_hdac_calc_stream_format(params_rate(params),
+						 params_channels(params),
+						 params_format(params),
+						 maxbps,
+						 0);
+	if (!format_val) {
+		dev_err(dai->dev,
+			"invalid format_val, rate=%d, ch=%d, format=%d, maxbps=%d\n",
+			params_rate(params), params_channels(params),
+			params_format(params), maxbps);
+
+		return -EINVAL;
+	}
+
+	hda_pvt->pcm[dai->id].format_val[substream->stream] = format_val;
+	return 0;
+}
+
 static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -162,10 +199,9 @@ static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct hda_pcm_stream *hda_stream;
 	struct hdac_hda_priv *hda_pvt;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct hdac_device *hdev;
-	struct hda_pcm_stream *hda_stream;
 	unsigned int format_val;
 	struct hda_pcm *pcm;
 	unsigned int stream;
@@ -179,19 +215,8 @@ static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 
 	hda_stream = &pcm->stream[substream->stream];
 
-	format_val = snd_hdac_calc_stream_format(runtime->rate,
-						 runtime->channels,
-						 runtime->format,
-						 hda_stream->maxbps,
-						 0);
-	if (!format_val) {
-		dev_err(&hdev->dev,
-			"invalid format_val, rate=%d, ch=%d, format=%d\n",
-			runtime->rate, runtime->channels, runtime->format);
-		return -EINVAL;
-	}
-
 	stream = hda_pvt->pcm[dai->id].stream_tag[substream->stream];
+	format_val = hda_pvt->pcm[dai->id].format_val[substream->stream];
 
 	ret = snd_hda_codec_prepare(&hda_pvt->codec, hda_stream,
 				    stream, format_val, substream);
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index e444ef593360..6b1bd4f428e7 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -8,6 +8,7 @@
 
 struct hdac_hda_pcm {
 	int stream_tag[2];
+	unsigned int format_val[2];
 };
 
 struct hdac_hda_priv {
-- 
2.19.1

