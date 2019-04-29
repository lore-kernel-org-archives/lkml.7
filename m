Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB168C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A452087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DHEEBsU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfD2JsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:48:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41166 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfD2JsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:48:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id c12so15018220wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vJi7jzhGksKSzSUALjvd5a/wT/QdGOfMu/ANjtuZHE=;
        b=DHEEBsU1qBAt9TXEXJ1V85pxD8WpW3If6DHzzZi4Hkhn5f5Pbe85cOLPEAMi29AOb2
         uofvyNQN+W1wNmV2zYC2Y5KawyC620cqLMa67v5FM0PGsR51yW3pvqZO5zPlcYGSDuvN
         mAOZrLCxN+uffrRq2Flq2BjKnPdoZACbiAQjwUuMelA6FB6p1S69w59uezspzBhpChBZ
         ovEmRyiAhMtLAiAo/6EiQJpcqQgVXI8xJbUqxZQiDoVdcDGu9QHwyt2p8SMEnCjAM4XF
         bEfnbq9JeCrrNxSZWHtyn0EQYI93hlqZxZV0UIq86aEvKP1l38cJoAnucKOIFvUpGZqX
         95lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vJi7jzhGksKSzSUALjvd5a/wT/QdGOfMu/ANjtuZHE=;
        b=SH/tt1hxaQZtE0faJJqMGRiwQgTGegelPQbz8K6CeQUrZM49id/2fmIUwEsjpedAXF
         wYTThuJABTbrSoKaTWTFfn7cgidkJwa4kL6JPl/rme/ESOaCerfBsTqKLCr/NB3ZOoej
         Z5Jq1PldjHjNCHowRSq2gPUsVpO6fDtZTf+tw+AM7uFNGv36tdYHefvQreG4bmLfzJ30
         T1bCBLZf5QVP68laMlVjk+2x4tBNPLGi6bjllfxDyWfarj0jm7czfrdYaMPrPVoof5h6
         BjXn1A5yJe0hVWn8EzrGqfmiGLzx1p+hzmbx31rRP8BqDHMH5vDUa0+zF7cZ2gJD5yS5
         qI3Q==
X-Gm-Message-State: APjAAAU9OqeYh5Y1kW7wGqr9Zl2a1p9amqgM/iQ5yGZP48nFZiJrFbz9
        6lGDRoIY/nXj7JsuIQFJMSJitA==
X-Google-Smtp-Source: APXvYqy37aX173M+03P7QBLkDx71CokTO8IGK+3sJKOpk4e5ax6NJ8Np4npqIkJGdOhMkgcVWidOkA==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr11840603wrx.261.1556531279788;
        Mon, 29 Apr 2019 02:47:59 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 192sm47987465wme.13.2019.04.29.02.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 02:47:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 1/2] ASoC: fix valid stream condition
Date:   Mon, 29 Apr 2019 11:47:49 +0200
Message-Id: <20190429094750.1857-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429094750.1857-1-jbrunet@baylibre.com>
References: <20190429094750.1857-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A stream may specify a rate range using 'rate_min' and 'rate_max', so a
stream may be valid and not specify any rates. However, as stream cannot
be valid and not have any channel. Let's use this condition instead to
determine if a stream is valid or not.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 99bbd724d2a6..263086af707d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -42,8 +42,8 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
 	else
 		codec_stream = &dai->driver->capture;
 
-	/* If the codec specifies any rate at all, it supports the stream. */
-	return codec_stream->rates;
+	/* If the codec specifies any channels at all, it supports the stream */
+	return codec_stream->channels_min;
 }
 
 /**
-- 
2.20.1

