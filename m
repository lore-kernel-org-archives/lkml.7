Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F9C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56942087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tkNli+26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEFJ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:58:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33990 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:58:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so6113701wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7AcpWA9A83L4FypCc369GCLs1Ntp7uwJwm/XxipXaE=;
        b=tkNli+26My6vrczGDwdluDE7HLnExdDaIwWUJCnpa4VluVUwGnbyIpFbDmCLJjxBM4
         giBX2hEpBS3HS9XssUh6r+omnD+ojlJH+sW9cDeFDBr9R1lMWmT+Ek7g7bXGF/c6+LUh
         PooGogBA4eNNtnk+NuvoYHCGynN1FSgU9zN6/De8aBhVaelHmlKea5y0z2sz4sEJNdKr
         OjO+1w8F9h2cYU8G9NIXEWjb6vmh/b4yNfxCY46j9zJvBKs3QVi74I258ifIBY6rRWaG
         tLaHbEzyk8GBA9xwbWFLMjigRnrLEzB+y19uCtIHiGvz8VqaqYmTg9KQtCqRyrmbc+7X
         S0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7AcpWA9A83L4FypCc369GCLs1Ntp7uwJwm/XxipXaE=;
        b=tMUVxnV6tBzWS9yu0W5cXwnYaNaehwcZZS1gduJ4MXptNudFCTaPcQ9xPV+/Rd1jnz
         Sj6z7D0PFPqjI4BAAI/OuPmNqEc/VxKtWURtewaAtxY4Q+lAdFfm43BKPfz9XHYFPknY
         kf0WQPDy/2GKzZJD02u/Zxje7AkeIvR3ebOmEigssZK9h7yeeN5Sp/5brflG/kxDTpoo
         oticZXU59UIKrJCfQAAxyDGuTby5R3MSkcsAEwMwd52F2yiVJ5vl94zwKxvcIU4jaqdN
         41TWibGFX/03q8qjaQNNKgzRzdL6N2xxziOXV8gb6lCkT343IlKOvev5E+cw6d/7vk7N
         UobQ==
X-Gm-Message-State: APjAAAWgnwMloLmDfbP0D2xg9lYCZnitHqzOyo+jjhlCfRz+1KobJD07
        P2Mcjtu84DH9fSkv25qJjx+wcA==
X-Google-Smtp-Source: APXvYqwtQmbhEPHAd44Q+EvhhRiBF2PG/mrHhY+2X/gPbS7Vo3zjYdFH/nJTb9sZOSOAoVH9EFtF3A==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr6800608wro.291.1557136705814;
        Mon, 06 May 2019 02:58:25 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c10sm23409791wrd.69.2019.05.06.02.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:58:25 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 3/4] ASoC: hdmi-codec: remove reference to the dai drivers in the private data
Date:   Mon,  6 May 2019 11:58:14 +0200
Message-Id: <20190506095815.24578-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506095815.24578-1-jbrunet@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the a pointer to the dai drivers is not necessary. It is not used
by the hdmi_codec after the probe.

Even if it was used, the 'struct snd_soc_dai_driver' can accessed through
the 'struct snd_soc_dai' so keeping the pointer in the private data
structure is not useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 4d32f93f6be6..9408e6bc4d3e 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -278,7 +278,6 @@ static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
-	struct snd_soc_dai_driver *daidrv;
 	struct hdmi_codec_daifmt daifmt[2];
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
@@ -715,6 +714,7 @@ static const struct snd_soc_component_driver hdmi_driver = {
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *daidrv;
 	struct device *dev = &pdev->dev;
 	struct hdmi_codec_priv *hcp;
 	int dai_count, i = 0;
@@ -737,27 +737,25 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
-				   GFP_KERNEL);
-	if (!hcp->daidrv)
+	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
+	if (!daidrv)
 		return -ENOMEM;
 
 	if (hcd->i2s) {
-		hcp->daidrv[i] = hdmi_i2s_dai;
-		hcp->daidrv[i].playback.channels_max =
-			hcd->max_i2s_channels;
+		daidrv[i] = hdmi_i2s_dai;
+		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
 		i++;
 	}
 
 	if (hcd->spdif) {
-		hcp->daidrv[i] = hdmi_spdif_dai;
+		daidrv[i] = hdmi_spdif_dai;
 		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
 	}
 
 	dev_set_drvdata(dev, hcp);
 
-	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
-				     dai_count);
+	ret = devm_snd_soc_register_component(dev, &hdmi_driver, daidrv,
+					      dai_count);
 	if (ret) {
 		dev_err(dev, "%s: snd_soc_register_component() failed (%d)\n",
 			__func__, ret);
-- 
2.20.1

