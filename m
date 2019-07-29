Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358F920693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MTNriKxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfG2ICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:02:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43615 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfG2ICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:02:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so60674243wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9RA94ICutOEe48WXCPH8Kz/PFpg7/2L2e8y1Aso6Yrg=;
        b=MTNriKxVQBKmei1wel/XbIBlCJK8WQMMHKPY/R+8DD7Vq1DWOv1c1p03soQwYEWuC6
         wDN0boNiENDCEG/tur73v8PTxB5MHU/KgHEJeinhTsC9L48LMY3ptVFTd8HZGN1snVJ0
         RAC1JXik9zm4Vh32++d84mg93S4QM8lS6WWa3PwPZdotjTD+WkIVvv/hXI8UgpOQBAP4
         +HTO9KpM5XX5MF45h1ijxg8+W88UBododOIvtUYi2TpzHPigukzxN5NrrRY7mpf407YK
         0mNb1iNHOcsqp3NkSYIqlcgGRF+fexOs76a19uHu8BfxJWnq+iKWfAlCNmwO0+mmlmnt
         4FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9RA94ICutOEe48WXCPH8Kz/PFpg7/2L2e8y1Aso6Yrg=;
        b=Yt54KRuSklBOxzXqCTL5frXFzXEpFii9UZ/tk7IY5HRuu7fiVFKh9X/JY5Ojt6CLLW
         hXZ98otnuySkepK3V6DmFL+7gsE8du8ouCC3ophpRqhCgKD4zHhDO2KSf/1PjziRbx8A
         VeiLjFBUz44eclRAKTlg+GjWBZjtAxV9rbfLCspTikCSeWxIfj+l7Iw2CQgxdMQHnT/D
         qkKDXaW/eDmRw6QYSP095KfXaxSnCU94TjGByfhbljDzzCjWrKhHxiVr8VDBi6OJnVkK
         g/oXePEw6rBdV0fFYOVzjmJ5eYwXcN75B/Sx8H/MH9LmwYi6SnmG6cFIcajDQh9imWZz
         qjLA==
X-Gm-Message-State: APjAAAVBNC3z4Z+ej+iHjcH4W8u8cyEZHMJIuLbNb/4qT14lIUm/4bCG
        5PkqvKID9w5Yu6DqpGHfKU+XbA==
X-Google-Smtp-Source: APXvYqwADxrFEOUZ64tv0Wk/f+cSLqtMt/lXaNmVznyzUgfsI7zu68MZijDvv18qher7+QJCrrQplQ==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr16431382wrp.287.1564387334288;
        Mon, 29 Jul 2019 01:02:14 -0700 (PDT)
Received: from starbuck.baylibre.local ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.googlemail.com with ESMTPSA id a2sm62043546wmj.9.2019.07.29.01.02.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:02:13 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: g12a-tohdmitx: override codec2codec params
Date:   Mon, 29 Jul 2019 10:01:39 +0200
Message-Id: <20190729080139.32068-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, forwarding the hw_params of the input to output relied on the
.hw_params() callback of the cpu side of the codec2codec link to be called
first. This is a bit weak.

Instead, override the stream params of the codec2codec to link to set it up
correctly.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/g12a-tohdmitx.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index 707ccb192e4c..9943c807ec5d 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -28,7 +28,7 @@
 #define  CTRL0_SPDIF_CLK_SEL		BIT(0)
 
 struct g12a_tohdmitx_input {
-	struct snd_pcm_hw_params params;
+	struct snd_soc_pcm_stream params;
 	unsigned int fmt;
 };
 
@@ -225,26 +225,17 @@ static int g12a_tohdmitx_input_hw_params(struct snd_pcm_substream *substream,
 {
 	struct g12a_tohdmitx_input *data = dai->playback_dma_data;
 
-	/* Save the stream params for the downstream link */
-	memcpy(&data->params, params, sizeof(*params));
+	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
+	data->params.rate_min = params_rate(params);
+	data->params.rate_max = params_rate(params);
+	data->params.formats = 1 << params_format(params);
+	data->params.channels_min = params_channels(params);
+	data->params.channels_max = params_channels(params);
+	data->params.sig_bits = dai->driver->playback.sig_bits;
 
 	return 0;
 }
 
-static int g12a_tohdmitx_output_hw_params(struct snd_pcm_substream *substream,
-					  struct snd_pcm_hw_params *params,
-					  struct snd_soc_dai *dai)
-{
-	struct g12a_tohdmitx_input *in_data =
-		g12a_tohdmitx_get_input_data(dai->capture_widget);
-
-	if (!in_data)
-		return -ENODEV;
-
-	memcpy(params, &in_data->params, sizeof(*params));
-
-	return 0;
-}
 
 static int g12a_tohdmitx_input_set_fmt(struct snd_soc_dai *dai,
 				       unsigned int fmt)
@@ -266,6 +257,14 @@ static int g12a_tohdmitx_output_startup(struct snd_pcm_substream *substream,
 	if (!in_data)
 		return -ENODEV;
 
+	if (WARN_ON(!rtd->dai_link->params)) {
+		dev_warn(dai->dev, "codec2codec link expected\n");
+		return -EINVAL;
+	}
+
+	/* Replace link params with the input params */
+	rtd->dai_link->params = &in_data->params;
+
 	if (!in_data->fmt)
 		return 0;
 
@@ -278,7 +277,6 @@ static const struct snd_soc_dai_ops g12a_tohdmitx_input_ops = {
 };
 
 static const struct snd_soc_dai_ops g12a_tohdmitx_output_ops = {
-	.hw_params	= g12a_tohdmitx_output_hw_params,
 	.startup	= g12a_tohdmitx_output_startup,
 };
 
-- 
2.21.0

