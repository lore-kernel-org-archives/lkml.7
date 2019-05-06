Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06763C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F93208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tcCdgTG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEFJ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:58:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42567 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfEFJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:58:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so16454394wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spyvVZOA092Rq/pDhbTlA8tcvHt4DyPzwJ7M6MsQeGA=;
        b=tcCdgTG8H8MAKQGHBtyfaqhZgC9xPbMemqlo38nW50o2fdg9QUHXNAT05F4uz1pgJc
         g27KbxkrZLb3kgtKhQgpVmDkVX6BEU/+azucdZWPCLyIqEu8rt7mTwuKWkekCiUD0ED/
         P/RJu8RgYwvRkf2APWHfhpQOGR7yjvjvY3DTseJwtmVY96NxWYu22fLGqSWGTQcY3MeW
         Gd+KQkz69EtpMjAk9S69OuaY5tVbutsWwasUcqwjWM04T12h4yasr9m/1FVxUZZqJn+1
         MKzAqrgvTZpvR0csyALcM4iwqJ1spJwi1ENeVtpWdrFy6QLquyNyi1EsnxIFXyRB1ImH
         sdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spyvVZOA092Rq/pDhbTlA8tcvHt4DyPzwJ7M6MsQeGA=;
        b=b9q4VGi2wYEGU09E7auIazMPaY9EwcIM51v9YPN8Je3mHaPeTJnmQ0xVe6x+qr0VIf
         VkkZJECQfO6LNNMTK4cr/GDWeCUrQNLIdiVDCnPNJxFG3cPAFaincNTwclmUeBbyrYoy
         YCMeJ6LwnA71nmJWZi06ho0b7bTj3mb0DDlL7EhfDdjFQjOk7qrRqTz0IthtpBzilmvF
         Q4vnynxUhD7Q3C7U0/YR4NPIqamiLBo/j9+HahXyh4wSw8vYvoJRgdzKem3hFdbsNbKq
         Y6m1E2ayJpqxXrawIA0Wdvvm8Zlw1TH4h+FfKyUC7D2H47Wy3LN10kP+HnT35P4vmEXe
         FTPg==
X-Gm-Message-State: APjAAAWZfw8tz2mstMnITcLM3zjn3sc6qkZ0Vvto73Yirc3aOJv+/I9k
        AX5N930IbJc/Z1kYelruqTX3UQ==
X-Google-Smtp-Source: APXvYqx0DOK7WHFX9ytkejwPIliORawCMPCyR4HJ+H09HoIufnGhw37LS35rMEm75u7m8KRZrZHuMA==
X-Received: by 2002:a5d:5108:: with SMTP id s8mr115083wrt.99.1557136706779;
        Mon, 06 May 2019 02:58:26 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c10sm23409791wrd.69.2019.05.06.02.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:58:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 4/4] ASoC: hdmi-codec: remove ops dependency on the dai id
Date:   Mon,  6 May 2019 11:58:15 +0200
Message-Id: <20190506095815.24578-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506095815.24578-1-jbrunet@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency on the dai_id can be removed by setting different ops
for the i2s and spdif dai and storing the dai format information in
each dai structure. It simplies the code a bit.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 100 +++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 9408e6bc4d3e..90a892766625 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -278,7 +278,6 @@ static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
-	struct hdmi_codec_daifmt daifmt[2];
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
@@ -445,6 +444,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
 	struct hdmi_codec_params hp = {
 		.iec = {
 			.status = { 0 },
@@ -489,28 +489,27 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 	hp.channels = params_channels(params);
 
 	return hcp->hcd.ops->hw_params(dai->dev->parent, hcp->hcd.data,
-				       &hcp->daifmt[dai->id], &hp);
+				       cf, &hp);
 }
 
-static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
-			      unsigned int fmt)
+static int hdmi_codec_i2s_set_fmt(struct snd_soc_dai *dai,
+				  unsigned int fmt)
 {
-	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	struct hdmi_codec_daifmt cf = { 0 };
+	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
 
-	if (dai->id == DAI_ID_SPDIF)
-		return 0;
+	/* Reset daifmt */
+	memset(cf, 0, sizeof(*cf));
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		cf.bit_clk_master = 1;
-		cf.frame_clk_master = 1;
+		cf->bit_clk_master = 1;
+		cf->frame_clk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		cf.frame_clk_master = 1;
+		cf->frame_clk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		cf.bit_clk_master = 1;
+		cf->bit_clk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
@@ -522,43 +521,41 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		cf.frame_clk_inv = 1;
+		cf->frame_clk_inv = 1;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		cf.bit_clk_inv = 1;
+		cf->bit_clk_inv = 1;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
-		cf.frame_clk_inv = 1;
-		cf.bit_clk_inv = 1;
+		cf->frame_clk_inv = 1;
+		cf->bit_clk_inv = 1;
 		break;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		cf.fmt = HDMI_I2S;
+		cf->fmt = HDMI_I2S;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		cf.fmt = HDMI_DSP_A;
+		cf->fmt = HDMI_DSP_A;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		cf.fmt = HDMI_DSP_B;
+		cf->fmt = HDMI_DSP_B;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		cf.fmt = HDMI_RIGHT_J;
+		cf->fmt = HDMI_RIGHT_J;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		cf.fmt = HDMI_LEFT_J;
+		cf->fmt = HDMI_LEFT_J;
 		break;
 	case SND_SOC_DAIFMT_AC97:
-		cf.fmt = HDMI_AC97;
+		cf->fmt = HDMI_AC97;
 		break;
 	default:
 		dev_err(dai->dev, "Invalid DAI interface format\n");
 		return -EINVAL;
 	}
 
-	hcp->daifmt[dai->id] = cf;
-
 	return 0;
 }
 
@@ -573,14 +570,20 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-static const struct snd_soc_dai_ops hdmi_dai_ops = {
+static const struct snd_soc_dai_ops hdmi_codec_i2s_dai_ops = {
 	.startup	= hdmi_codec_startup,
 	.shutdown	= hdmi_codec_shutdown,
 	.hw_params	= hdmi_codec_hw_params,
-	.set_fmt	= hdmi_codec_set_fmt,
+	.set_fmt	= hdmi_codec_i2s_set_fmt,
 	.digital_mute	= hdmi_codec_digital_mute,
 };
 
+static const struct snd_soc_dai_ops hdmi_codec_spdif_dai_ops = {
+	.startup	= hdmi_codec_startup,
+	.shutdown	= hdmi_codec_shutdown,
+	.hw_params	= hdmi_codec_hw_params,
+	.digital_mute	= hdmi_codec_digital_mute,
+};
 
 #define HDMI_RATES	(SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
 			 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
@@ -648,20 +651,52 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 static int hdmi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct snd_soc_dapm_context *dapm;
+	struct hdmi_codec_daifmt *daifmt;
 	struct snd_soc_dapm_route route = {
 		.sink = "TX",
 		.source = dai->driver->playback.stream_name,
 	};
+	int ret;
 
 	dapm = snd_soc_component_get_dapm(dai->component);
+	ret = snd_soc_dapm_add_routes(dapm, &route, 1);
+	if (ret)
+		return ret;
+
+	daifmt = kzalloc(sizeof(*daifmt), GFP_KERNEL);
+	if (!daifmt)
+		return -ENOMEM;
 
-	return snd_soc_dapm_add_routes(dapm, &route, 1);
+	dai->playback_dma_data = daifmt;
+	return 0;
+}
+
+static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
+{
+	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
+	int ret;
+
+	ret = hdmi_dai_probe(dai);
+	if (ret)
+		return ret;
+
+	cf = dai->playback_dma_data;
+	cf->fmt = HDMI_SPDIF;
+
+	return 0;
+}
+
+static int hdmi_codec_dai_remove(struct snd_soc_dai *dai)
+{
+	kfree(dai->playback_dma_data);
+	return 0;
 }
 
 static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
 	.probe = hdmi_dai_probe,
+	.remove = hdmi_codec_dai_remove,
 	.playback = {
 		.stream_name = "I2S Playback",
 		.channels_min = 2,
@@ -670,14 +705,15 @@ static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 		.formats = I2S_FORMATS,
 		.sig_bits = 24,
 	},
-	.ops = &hdmi_dai_ops,
+	.ops = &hdmi_codec_i2s_dai_ops,
 	.pcm_new = hdmi_codec_pcm_new,
 };
 
 static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 	.name = "spdif-hifi",
 	.id = DAI_ID_SPDIF,
-	.probe = hdmi_dai_probe,
+	.probe = hdmi_dai_spdif_probe,
+	.remove = hdmi_codec_dai_remove,
 	.playback = {
 		.stream_name = "SPDIF Playback",
 		.channels_min = 2,
@@ -685,7 +721,7 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 		.rates = HDMI_RATES,
 		.formats = SPDIF_FORMATS,
 	},
-	.ops = &hdmi_dai_ops,
+	.ops = &hdmi_codec_spdif_dai_ops,
 	.pcm_new = hdmi_codec_pcm_new,
 };
 
@@ -747,10 +783,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		i++;
 	}
 
-	if (hcd->spdif) {
+	if (hcd->spdif)
 		daidrv[i] = hdmi_spdif_dai;
-		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
-	}
 
 	dev_set_drvdata(dev, hcp);
 
-- 
2.20.1

