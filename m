Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EAEC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062B121479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="19wbZ9g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfEMITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:19:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:19:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so14103389wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUi0ZGwdStuY0eVRYd5ldGSSn5HdKxs5p/Z/yyYivTw=;
        b=19wbZ9g46sLKbeiPuUn11Sf+oj1WEgyw3x02jpEOfdMoHk27ztwm0HIkmsn3bInU5J
         eprXbmiXOBvogz+3QhC3HHNgt61Uk4vo3vJDQrCasZG9z0KT2tyiawjCAYI9zMdrY0Ew
         Lqws+TlEHrQ9dTEGblkJpOApAWL2qwkfhYOQmBUF1rjywGqbYBcMbkmo4tcK69bLgpM+
         YkazkWzpRsxLieBr+vB5cLlNDAJr82+OCzsNY1kOuSFPNE+oieA4tKRY0CCzBYbcYNvA
         CadWec3B2ct4eGoe/SnHPYEc120RviRN4dxFzYGRnwehbQjnlIjqibS50pGKe8iupjd2
         oIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUi0ZGwdStuY0eVRYd5ldGSSn5HdKxs5p/Z/yyYivTw=;
        b=gNvj7mbr/h9SjCFujuE/fEsH/vJgH/RNTcaHB8HPtG80iHtUHzWXRTNslfVTCCpVeu
         MOE/Z0zGKkiAKj5GdKNK6KQQH7J+yZwHCia8mF1HZFl8AxX836OiPLrXv2oaLcfESdF7
         zgZD/3kMiRL4yr/7nxgB7jJ2ZnbDUaj4L2f4M1IHmQ+HCQj7ka9n5FRw0tOZWCZ+jeT8
         sItrUFLRm4Caa5ccOO68Xhj8sHc1zCpH8mk9+4I1GOGAEf3jXe51DqZRlJHSxUZsaI6p
         lMXIO8qCnSdfIP3avpx7H2BDo8FToLuRGj2t49tD9axqd9L01vpzl3nv8v2F04YNPSHT
         9DHg==
X-Gm-Message-State: APjAAAXaEKQo8f/L/hIzvd+3VEGF6s39iNF2nH+sLjUiauJmjxXc8mof
        crsUO7Px3lMjtguecSLo/QlgQQ==
X-Google-Smtp-Source: APXvYqwLdalQYeISU9E+Q5WyRnBHVc3VJxFENzGQ3xLaSxs7jEwkM78H29YxFKjqcUY+auodvZ1x2Q==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr7825518wrn.222.1557735543746;
        Mon, 13 May 2019 01:19:03 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x4sm1594859wrn.41.2019.05.13.01.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 01:19:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH] ASoC: hdmi-codec: re-introduce mutex locking
Date:   Mon, 13 May 2019 10:18:47 +0200
Message-Id: <20190513081847.31140-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the bit atomic operations by a mutex to ensure only one dai
at a time is active on the hdmi codec.

This is a follow up on change:
3fcf94ef4d41 ("ASoC: hdmi-codec: remove reference to the current substream")

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 90a892766625..6a0cc8d7e141 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -281,7 +281,7 @@ struct hdmi_codec_priv {
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
-	unsigned long busy;
+	struct mutex lock;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -395,8 +395,8 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = test_and_set_bit(0, &hcp->busy);
-	if (ret) {
+	ret = mutex_trylock(&hcp->lock);
+	if (!ret) {
 		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
 		return -EINVAL;
 	}
@@ -424,7 +424,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 
 err:
 	/* Release the exclusive lock on error */
-	clear_bit(0, &hcp->busy);
+	mutex_unlock(&hcp->lock);
 	return ret;
 }
 
@@ -436,7 +436,7 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	clear_bit(0, &hcp->busy);
+	mutex_unlock(&hcp->lock);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -773,6 +773,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
+	mutex_init(&hcp->lock);
+
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.20.1

