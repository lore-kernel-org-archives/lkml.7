Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD689C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFF52084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J2dTv1NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfD2N34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:29:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46930 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbfD2N3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:29:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so16009283wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whsOXQ8xRakI5AVYAzepVuB15C/D0yrTQsABLkaS6Vw=;
        b=J2dTv1NPn4J99TrrljZ2hOdA1bv1ifuVO+cH2SVjLUxRsCwvDn6BHWRe13ydolX9HU
         f0TgeitA6xsof7AZ1BTeJMhJx9kNVCtreRIIz9tilr7F8ppdQBBxnamrpVfxs+7s0EuC
         /JVT4wZ1PMsPZY5/LjXMc70KWL4sthpL7sEtgbb7ZuUzPpYMMhz4nifFsD75k0rW8ryA
         spcy4SlO6AluDcIowl1fcf1VPnzD2N57NI7qTRcgkQAlS9idnCiCIUExwUaYbgeV7gih
         tm7D8w2q0cvdL0hYkGcQiVK21c5VDYXHMhWi8jpwQFBdbCzSs5At+eD45xDtXv+WytzX
         tf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whsOXQ8xRakI5AVYAzepVuB15C/D0yrTQsABLkaS6Vw=;
        b=jSjqbXfxdamEX83PCunFV/AEM0aNjTJiZFw9tNFlxZoYANPdVM5AUXplXseiWX2PfG
         Khb/CI2E3N0tvCOpKiY5/aF19ML4KGl7MzdCBg4HQIMpL1H3gV8wMyVNcG3ExiKNeq37
         iEw2gLl9LOj0rPC+/ZFj2bZVhz/rkrTBGOgP0rMpqOJsb3pMWbdBVIMTqyepqg+2UlYd
         naEaekFcjy2BA3UUUOne3cl9ELRUebqya5Cx1owzBWKk82HLhZ4m6MlEdaJVTDHpyqEE
         sVvuYJgwsaJVsUmJOp4N0kkksiMEHtSdwYk8Rf+cXDV8R+qQJFe/ZXQJbHOs6O6lxmvj
         tDLw==
X-Gm-Message-State: APjAAAUhPMvHZLSN6ktGJHGmgJm4cSU4WeR6Pu7+rX+mmqF0NQcpS8PG
        5JGif+nzW+COs/cTgXdxUD91ZiYMue4=
X-Google-Smtp-Source: APXvYqxOsG9oiU7eEepi7586wap76Pj0lBUVZ/mY6bdH1Ba/VKYnS+x1TJFaXAE4iJXvcVWCek6nRA==
X-Received: by 2002:adf:f845:: with SMTP id d5mr2185657wrq.107.1556544591717;
        Mon, 29 Apr 2019 06:29:51 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s17sm2857593wra.94.2019.04.29.06.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 06:29:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 3/6] ASoC: hdmi-codec: stream is already locked in hw_params
Date:   Mon, 29 Apr 2019 15:29:40 +0200
Message-Id: <20190429132943.16269-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

startup() should have run before hw_params() is called, so the
current_substream pointer should already be properly set. There
is no reason to call hdmi_codec_new_stream() again in the
hw_params() callback

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 4bd598253c62..780f2008b271 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -495,10 +495,6 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = hdmi_codec_new_stream(substream, dai);
-	if (ret)
-		return ret;
-
 	hdmi_audio_infoframe_init(&hp.cea);
 	hp.cea.channels = params_channels(params);
 	hp.cea.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
-- 
2.20.1

