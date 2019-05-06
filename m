Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCABBC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE0B21655
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WouC9aTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfEFJ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:58:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56050 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfEFJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:58:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id y2so14658078wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFAZLM2HXuFCxb/qpIKx/Zvd6z+9jBXknwydcf65Gow=;
        b=WouC9aTpP+JbWnMYvxrFG/C6chBDo+e5JZjiNsYqbm1PNvq2E6DI/tdFgRaefTjk7i
         dNjc79J6JQivuiOzumg4tKN6nqc9pthH/ZXoBubgM1z73EO/P6ZuoANyqjt8AFGtzrox
         Vql+EhiR33zOisnT0IV4X/4e/92L5bH6IDmnx+zE3q6H5MoMovyn0VzUkQNR0OE90imA
         eT4RaWKVBYJJ80/h7P2uUdpWyPEvjwJ/iuM/hwMegTQpfDHfRPtK0uzeM1OoO9aVsaLZ
         trtYy11H5oiseOjLJjgK+D80szm9pmKtydFxdC4+PqhUTs3pbDpBur1EV1ejfQ49DpP6
         S0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFAZLM2HXuFCxb/qpIKx/Zvd6z+9jBXknwydcf65Gow=;
        b=YTv8YQ40b3p0JEJct6fCniCyiMaUxsRBTZHnGCfGHxFQddfSg1dVrQkb7+uButhiTu
         bVkaqjggR/dckIQRW32+JG/2MdFtKPsCySIBpPJV16vmRbPWR0a6t3nq78iVcol1wKnd
         HhxM5ee2/FJvf+/qndfPp/Zvrqh8VnuyMXcbYOtCqTheRkIM0m+NcFdj9RtLODmjYB5n
         Kf3iyKdLe8lvjTMTaEO2sv8Ynlfs91Xy5TbATJXzk27z5cQFhN4QwrVcC1+3br7F56eO
         69dCfA7f51S46TWS7GIMNLnT5OeyJDiu8rrH8JTG5/iEl/IWfXThGn2oC7w00pLHqEQ/
         1qog==
X-Gm-Message-State: APjAAAUzpGihjG/ad/VV5YNik82wYAwele9RRO2CxAmBs/C37R335Evb
        4LIe3gtCBjnWZ/wn+UKQS0z+rIKikh0=
X-Google-Smtp-Source: APXvYqwMyYmowFoyRxcASiMYF+mzRuRWL8uRd4dpCJhtQaVbJecrErQbWHTZ6vSNWIk7d0OmBHTuZQ==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr15691569wmc.12.1557136704663;
        Mon, 06 May 2019 02:58:24 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c10sm23409791wrd.69.2019.05.06.02.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:58:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current substream
Date:   Mon,  6 May 2019 11:58:13 +0200
Message-Id: <20190506095815.24578-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506095815.24578-1-jbrunet@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hdmi-codec is on a codec-to-codec link, the substream pointer
it receives is completely made up by snd_soc_dai_link_event().
The pointer will be different between startup() and shutdown().

The hdmi-codec complains when this happens even if it is not really a
problem. The current_substream pointer is not used for anything useful
apart from getting the exclusive ownership of the device.

Remove current_substream pointer and replace the exclusive locking
mechanism with a simple variable and some atomic operations.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 58 ++++++++++-------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index eb31d7eddcbf..4d32f93f6be6 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -280,11 +280,10 @@ struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
 	struct snd_soc_dai_driver *daidrv;
 	struct hdmi_codec_daifmt daifmt[2];
-	struct mutex current_stream_lock;
-	struct snd_pcm_substream *current_stream;
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
+	unsigned long busy;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -392,42 +391,22 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	int ret = 0;
-
-	mutex_lock(&hcp->current_stream_lock);
-	if (!hcp->current_stream) {
-		hcp->current_stream = substream;
-	} else if (hcp->current_stream != substream) {
-		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
-		ret = -EINVAL;
-	}
-	mutex_unlock(&hcp->current_stream_lock);
-
-	return ret;
-}
-
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = hdmi_codec_new_stream(substream, dai);
-	if (ret)
-		return ret;
+	ret = test_and_set_bit(0, &hcp->busy);
+	if (ret) {
+		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
+		return -EINVAL;
+	}
 
 	if (hcp->hcd.ops->audio_startup) {
 		ret = hcp->hcd.ops->audio_startup(dai->dev->parent, hcp->hcd.data);
-		if (ret) {
-			mutex_lock(&hcp->current_stream_lock);
-			hcp->current_stream = NULL;
-			mutex_unlock(&hcp->current_stream_lock);
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
 	if (hcp->hcd.ops->get_eld) {
@@ -437,17 +416,18 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		if (!ret) {
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret) {
-				mutex_lock(&hcp->current_stream_lock);
-				hcp->current_stream = NULL;
-				mutex_unlock(&hcp->current_stream_lock);
-				return ret;
-			}
+			if (ret)
+				goto err;
 		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
 	}
 	return 0;
+
+err:
+	/* Release the exclusive lock on error */
+	clear_bit(0, &hcp->busy);
+	return ret;
 }
 
 static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
@@ -455,14 +435,10 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	WARN_ON(hcp->current_stream != substream);
-
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	mutex_lock(&hcp->current_stream_lock);
-	hcp->current_stream = NULL;
-	mutex_unlock(&hcp->current_stream_lock);
+	clear_bit(0, &hcp->busy);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -761,8 +737,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	mutex_init(&hcp->current_stream_lock);
-
 	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
 				   GFP_KERNEL);
 	if (!hcp->daidrv)
-- 
2.20.1

