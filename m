Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB9EC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B1424671
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oZC+Mg3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFKfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:35:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFKfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:35:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so7149482wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2P76kSoNDGNNbqOJn2kSGms/jkHQIG00/8B7zZ9IAWc=;
        b=oZC+Mg3xodxXWHIkXMzl5MjCHXgHGP4BTZlEj8wbkkQKrb/xTAZz2TcgxnPz/8M8Ap
         SEVGG0mDu5DnWf8GLyFVlv6oV5oWGyAdn89M1wQTHdjQ0aBd0UHL8VE6vlwJu9lIrQsI
         IHEs5lBcbWtd66Zi1dpKu6KPBp8rTTQyW/0LSAUEUts5pg5tJQ3SJryqgWnpN0xxKaNY
         8awbJssV2Vk6/v9/6qOjuAPxok8m1mCzS66eaw5hBVwaHJNYSnntdObS/5Op3AiyHbSu
         4DPDUt5Bw+Dcqzr7sya9ODOXyLswtKpQIvCxPTS8lkAZfIPF5WWNJp9urxJbiuJRQGhS
         q8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2P76kSoNDGNNbqOJn2kSGms/jkHQIG00/8B7zZ9IAWc=;
        b=DIkD6oJUqJJHBpLcSwsgdyzdIw0qLhmWMd9qKVVRGe04tPZ0DterK74j2OJeU7LC9n
         xox+2+MTX4A7fHsrlGV5OZV5i2tuyDMIcK0G1m51t3d2NcoJSbkOAQs1zIeuuVynbhHY
         g6av3N8z6nB8LVKv4EPlZNtcfbhSksAsTize2Eo+3W5RNrqSvfis8qpYeFvrP0bvqJGI
         rcMQYU35/zksx/ptt9vy9S8Rhn/ibjbuwecYTItokiu309X8B+DjvbY26CVenbfkgdj+
         P3HnpfhYeTg16cWX9HGxOkEEYICKZv8Fwsd+aR8IyfffWQLsTQnq4VD7ItpS2urPaWfo
         cTAg==
X-Gm-Message-State: APjAAAWm8SeY5tqKBLLIMEJHPsdEp0Blo/6KoioQ5rgiUxphkWnDbwH2
        XoAQHQhw4FDd4NKa5FcZjT8eRw==
X-Google-Smtp-Source: APXvYqzpCEq7FRqzkGxefVAfwg3KvzY5JopYcmnzxXZT1FNThv71oz7fGU1opXocQjbae72vvyU62Q==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr15822520wrp.171.1575628551056;
        Fri, 06 Dec 2019 02:35:51 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n14sm2164013wmk.0.2019.12.06.02.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:35:50 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: hdmi-codec: re-introduce mutex locking again
Date:   Fri,  6 Dec 2019 11:35:42 +0100
Message-Id: <20191206103542.485224-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dai codec needs to ensure that on one dai is used at any time.
This is currently protected by bit atomic operation. With this change,
it done with a mutex instead.

This change is not about functionality or efficiency. It is done with
the hope that it help maintainability in the future.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f8b5b960e597..543363102d03 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -274,7 +274,8 @@ struct hdmi_codec_priv {
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
-	unsigned long busy;
+	struct mutex lock;
+	bool busy;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
 };
@@ -390,9 +391,10 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = test_and_set_bit(0, &hcp->busy);
-	if (ret) {
+	mutex_lock(&hcp->lock);
+	if (hcp->busy) {
 		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
+		mutex_unlock(&hcp->lock);
 		return -EINVAL;
 	}
 
@@ -405,21 +407,21 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	if (hcp->hcd.ops->get_eld) {
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
+		if (ret)
+			goto err;
+
+		ret = snd_pcm_hw_constraint_eld(substream->runtime, hcp->eld);
+		if (ret)
+			goto err;
 
-		if (!ret) {
-			ret = snd_pcm_hw_constraint_eld(substream->runtime,
-							hcp->eld);
-			if (ret)
-				goto err;
-		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
 	}
-	return 0;
+
+	hcp->busy = true;
 
 err:
-	/* Release the exclusive lock on error */
-	clear_bit(0, &hcp->busy);
+	mutex_unlock(&hcp->lock);
 	return ret;
 }
 
@@ -431,7 +433,9 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	clear_bit(0, &hcp->busy);
+	mutex_lock(&hcp->lock);
+	hcp->busy = false;
+	mutex_unlock(&hcp->lock);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -811,6 +815,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
+	mutex_init(&hcp->lock);
+
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.23.0

