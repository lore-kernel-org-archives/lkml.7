Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8B206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330151;
	bh=GROyF/lq+5IDeNEOW6pAINFQZfxolgvGfSZ0E8R0nlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IgW56AW1PukbB4FdTdbyqx7pEbpjM4fpjUTJHlHzu4WopiLWjF0fSZlVf7Xot4OOW
	 4FOeZqoFyeq6NoYSyRiZ3+lO6V2EmVevk2TNWxa7iAqnoRu2gMTXL1THVzwJhFwwz3
	 l6xP7oxDoWukWaRlCPI7Ox5dEbu7OWEYimBU2NVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfD0BjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfD0BjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E907720B7C;
        Sat, 27 Apr 2019 01:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329141;
        bh=GROyF/lq+5IDeNEOW6pAINFQZfxolgvGfSZ0E8R0nlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEYOtZmrn5po1WrnfUWzND7XE71LUVu8faagzKcpV8E3KoHe+zauAlW4EYsprYY4D
         V3JxX1J8h85ewRzBHEmIZ39BdPSvMZlEbAElJoWft9Q7nTRYYhiqb+OKoX+aNV3AbO
         nqvzCt7Wv+Z7uPoTnADQF1xt+dBAxFVz05clYbEs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 19/79] ASoC: stm32: dfsdm: manage multiple prepare
Date:   Fri, 26 Apr 2019 21:37:38 -0400
Message-Id: <20190427013838.6596-19-sashal@kernel.org>
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

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit 19441e35a43b616ea6afad91ed0d9e77268d8f6a ]

The DFSDM must be stopped when a new setting is applied.
restart systematically DFSDM on multiple prepare calls,
to apply changes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 706ff005234f..71d341b732a4 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -37,6 +38,8 @@ struct stm32_adfsdm_priv {
 	/* PCM buffer */
 	unsigned char *pcm_buff;
 	unsigned int pos;
+
+	struct mutex lock; /* protect against race condition on iio state */
 };
 
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
@@ -62,10 +65,12 @@ static void stm32_adfsdm_shutdown(struct snd_pcm_substream *substream,
 {
 	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
 
+	mutex_lock(&priv->lock);
 	if (priv->iio_active) {
 		iio_channel_stop_all_cb(priv->iio_cb);
 		priv->iio_active = false;
 	}
+	mutex_unlock(&priv->lock);
 }
 
 static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
@@ -74,13 +79,19 @@ static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
 	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	mutex_lock(&priv->lock);
+	if (priv->iio_active) {
+		iio_channel_stop_all_cb(priv->iio_cb);
+		priv->iio_active = false;
+	}
+
 	ret = iio_write_channel_attribute(priv->iio_ch,
 					  substream->runtime->rate, 0,
 					  IIO_CHAN_INFO_SAMP_FREQ);
 	if (ret < 0) {
 		dev_err(dai->dev, "%s: Failed to set %d sampling rate\n",
 			__func__, substream->runtime->rate);
-		return ret;
+		goto out;
 	}
 
 	if (!priv->iio_active) {
@@ -92,6 +103,9 @@ static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
 				__func__, ret);
 	}
 
+out:
+	mutex_unlock(&priv->lock);
+
 	return ret;
 }
 
@@ -298,6 +312,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->dai_drv = stm32_adfsdm_dai;
+	mutex_init(&priv->lock);
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.19.1

