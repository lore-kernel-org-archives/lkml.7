Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F91CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487382064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YlDpVbEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407090AbfJWQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:12:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404582AbfJWQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:12:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so6666743wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jku1smTEPHhN+cvKCtL6fmKpwQiYDnStnysLN3jZh3k=;
        b=YlDpVbEY99OVN3O7AhHeZrOjLm2qsRLfbFJi27v0f4JnEnOTvZAQulErlq8Nlj1kNe
         cDoLIFstWwUieFXb4Lu+DTBmbpQCN+6fXRk3jXwLqKCaSvPHaRxPoydTedDsseb7lYEJ
         Kjd3h8A5C/2L3DqQe6S1b9jFVFMX9w+VyobSD9zi0sa03QZGpFbKpLceATsPeo26SSS/
         W5lAFCgVvP2GFX+J1mWRu7MskCqrFS9n8ppb7q8VBsMkijs9GJKKecGtyJWApYNLPFK9
         xennvVzeF3L5sWOFNgqMdtc8L0RiLeq9ictajHb+4QiKFt9SftOsfUi1isgT+6j8ye49
         S2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jku1smTEPHhN+cvKCtL6fmKpwQiYDnStnysLN3jZh3k=;
        b=UOMM6hbV/vDWTAIMfaE2MPlbKr0yuh92m2U/YgLLyH0Hu5+atz6tX3t3NPFWlI7FFC
         6sE58DxuqDiy30fH5ASR326MiWrkpSy8WFzxdTgxSjG/WbWuON2tSbGd+X+AkRItxznc
         d0FpTAC5ya5eshHuzDfdcNCUiMpWloRcTBGuZ7lWYBF9+QqL4HJVoK0V0QFxklXxb+pg
         ZXlqyaYSAFqCoqqZgSINH7KokzMARfbXUucfYcNd2aFWfj/5s6V2tAnONmgoIFBKPbI+
         w+Z4ja7RYWIJ+ARFAGaDs30eNiDuCkda4K4kU+mfD0khLUi3Bl723LWPriPbADsXwaYW
         2NOw==
X-Gm-Message-State: APjAAAVafIL8/Be9KzF3HGEAGDiyJNTCdGT7iPooLHj9lN3UdJ0Z3GPK
        kUwUouILKl2MuMHTMEH2SOMyAItpUtI=
X-Google-Smtp-Source: APXvYqwJZmJTgYaqzR7EpYV47FoagkgViQqCyt9VJfAZEwIu5Pi0cWnYVEpA+myXiZVbuNZ9XnrLPw==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr9372180wru.184.1571847133523;
        Wed, 23 Oct 2019 09:12:13 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x7sm30240578wrg.63.2019.10.23.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:12:12 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/2] ASoC: hdmi-codec: re-introduce mutex locking again
Date:   Wed, 23 Oct 2019 18:12:03 +0200
Message-Id: <20191023161203.28955-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023161203.28955-1-jbrunet@baylibre.com>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
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

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f8b5b960e597..56f6373d7927 100644
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
@@ -390,12 +391,15 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
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
 
+	hcp->busy = true;
+
 	if (hcp->hcd.ops->audio_startup) {
 		ret = hcp->hcd.ops->audio_startup(dai->dev->parent, hcp->hcd.data);
 		if (ret)
@@ -415,11 +419,12 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
 	}
-	return 0;
 
 err:
-	/* Release the exclusive lock on error */
-	clear_bit(0, &hcp->busy);
+	if (ret)
+		hcp->busy = false;
+
+	mutex_unlock(&hcp->lock);
 	return ret;
 }
 
@@ -431,7 +436,9 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	clear_bit(0, &hcp->busy);
+	mutex_lock(&hcp->lock);
+	hcp->busy = false;
+	mutex_unlock(&hcp->lock);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -811,6 +818,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
+	mutex_init(&hcp->lock);
+
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.21.0

