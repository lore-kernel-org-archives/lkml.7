Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF39FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BF2206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L3oVRjgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfD2JsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:48:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50652 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfD2JsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:48:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so11350395wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lwkmI0zOv7BLpsbZZC29sb6Qw7tCofqiIoNLObPe54=;
        b=L3oVRjguMhqlA0Z2Bbxuj4vY1G3zFDofgG8TuQyhbayfUvqNiThGHm0Efy3YfZ0PMr
         pO79kWWVi6mW3pYWM/LmvlWPj9OcUqbaUteiHlO4O7ee/5XpL5PsJZ0o2EhRpDZcbqXr
         aVpbS95VmUUu4eJMyM+FQaxlPVcZ+ya60i4bdWLgqfdYLzdK51kFkwv1bg/XzlSEX5lh
         nJv41NX75qyNsvaUVPcMxG0PhOeIhD2iutryaSn/ak9rnsAfcsZMy3UGwiJbiKQb9v1r
         rmKwEtIeTabuJubq1d3hXZNL9hIrJWb9pgdV/PYbdNrl31kp54ZGSGRn7IWP1P2VclTN
         CISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lwkmI0zOv7BLpsbZZC29sb6Qw7tCofqiIoNLObPe54=;
        b=itIpbjKZkShuGinmDnpM/iz9WsMUJ6sAUWF8GB5V9HSF38mltfkqZSdhBC1eqZtO94
         RgHNeWlEh1mPVdSxf2OZB9Ng2/1w8njnEQteYXg7VP1+8o4dYmTY+TSrmwo5htPw0Mx9
         2qSBJY7J6Fhy+NQ8+ZiYrlS6uvlaQzw6XvltALUNMYVKK56d3Sdf1RclBbJV6zXTYHZK
         4HCI/mCMowXBL+fpz3VU+OXs0mZdobin5kgOOPC8KLX/zXP8lN0ugnIuiA23LDPMYY2k
         G4+4FiqnKUNtd4KJ69/MY+0aiCTUL+jCdJBqxfcyKMPyJEVxQ6fxJgMnf8o9u7ZCDkao
         LKWw==
X-Gm-Message-State: APjAAAUfUIAqLR+tpbakh9VKeYCd29TIMg9k96VJ30/Im0bMv45jFBWI
        psY3Xp2P5T7wS74uVQBqwBzGSw==
X-Google-Smtp-Source: APXvYqx9JPfF01cmoW9CW/F015/U9kE0LlcnPM6+cR5nK+o2pv+7MIr/YlDHkptqGMa1Hrl9pkLQdA==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr15087366wma.24.1556531281035;
        Mon, 29 Apr 2019 02:48:01 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 192sm47987465wme.13.2019.04.29.02.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 02:48:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 2/2] ASoC: skip hw_free on codec dai for which the stream is invalid
Date:   Mon, 29 Apr 2019 11:47:50 +0200
Message-Id: <20190429094750.1857-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429094750.1857-1-jbrunet@baylibre.com>
References: <20190429094750.1857-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like for hw_params, hw_free should not be called on codec dai for
which the current stream is invalid.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 263086af707d..04ccdc59295d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1020,6 +1020,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 codec_err:
 	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
@@ -1077,6 +1080,9 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	/* now free hw params for the DAIs  */
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 	}
-- 
2.20.1

