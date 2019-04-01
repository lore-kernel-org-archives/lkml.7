Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F1C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4F220828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WrShahGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfDANEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:04:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44355 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDANEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:04:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so11905266wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tBZICv5M63o9cwb5YALAd81rCrwUN1fQDpKJ6yysLZ8=;
        b=WrShahGvKsuQuqcrFhbR3ajSfIbTFlbGqKfAN4/Gj2yROtrMmMFGZbMhjmXOCZyRVq
         1G67/nCJPN0r0WchiaJnvX989+24r7Fx9rvZhLuvK7vxqEKcFT8glNwRe0PDg+dHhqoV
         J878XZI/2ATT0KBFLz0S3XdQeCUlnDZRzykBpI98wTRcnZ8uhDGbvuXE1//ademK3jU+
         mgEMPXm0Xg5Y+km9AhGkwM45bD9JO76V2qpEDr4gv1nSOX60zCQiXVp1+WtOUD82R2rP
         nXmaqJok4XX9IxHHUyLEz2wjW8HcZBanfkWKleCT4M/0evsT+5cvbEmIvAfeRgTpvF4y
         LQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tBZICv5M63o9cwb5YALAd81rCrwUN1fQDpKJ6yysLZ8=;
        b=HgUiJWPIH8uyZKfRuOkgzJbENd+JRdUIM1iWigUTZwWNLsVphZHbml0AVz5ge0OVug
         dyMpTf0bSbs0YyOcoYYqgAQZuWH/M0sWqUN0vaxqKwH5lXt3/XLKHK1q5LrmLEZrwxRT
         ZkdVmyxIe7EaE4XwH0mlWXnqfvZxSfxeUAt59vnFgxgENIrWoJhMbaar9S435P0ubMSt
         FU8mQBe/kEKbZMp3tRw2IWORVyiSp1Pxr2+OU8m00RQmlspsikBpl0894bPCbtKSRDI3
         ByGNf9Eb+9sMr+lGq7Lhj8CilfmeoaL2z+UyH6EoyVpcMLaPMB4uMGnZfVVpWUi/6Nd7
         /IZw==
X-Gm-Message-State: APjAAAVLazdCVHIbXGjaruE1t2Tc8lmcBD3z7JN7STGmCWGzX7qCkuv8
        Ug4mSs8K+gCw9voHOdBqb8o2cg==
X-Google-Smtp-Source: APXvYqzd/icuIQH9RTzK+1bTurbUuheFVXWEpXTXdfEk1+m2/WAqcGvpmuuVgaM+NPez3NzjM8ahrA==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr41220314wrs.206.1554123846979;
        Mon, 01 Apr 2019 06:04:06 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id o15sm9612638wrj.59.2019.04.01.06.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 06:04:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: dpcm: skip missing substream while applying symmetry
Date:   Mon,  1 Apr 2019 15:03:54 +0200
Message-Id: <20190401130354.24202-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If for any reason, the backend does not have the requested substream
(like capture on a playback only backend), the BE will be skipped in
dpcm_be_dai_startup().

However, dpcm_apply_symmetry() does not skip those BE and will
dereference the be_substream (NULL) pointer anyway.

Like in dpcm_be_dai_startup(), just skip those BE.

Fixes: 906c7d690c3b ("ASoC: dpcm: Apply symmetry for DPCM")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0d5ec68a1e50..99bbd724d2a6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1899,10 +1899,15 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
-		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
+		struct snd_soc_pcm_runtime *rtd;
 		struct snd_soc_dai *codec_dai;
 		int i;
 
+		/* A backend may not have the requested substream */
+		if (!be_substream)
+			continue;
+
+		rtd = be_substream->private_data;
 		if (rtd->dai_link->be_hw_params_fixup)
 			continue;
 
-- 
2.20.1

