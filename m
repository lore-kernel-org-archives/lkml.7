Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739892084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGPOKmfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDCDFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:05:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42077 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:05:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so8774419lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ancDZQ4xixL2Du0VM8ghYyMl2kD4SmkUdQ4EQ8sBZI=;
        b=kGPOKmfA3nAi1al0eD0+aEb/wR7UTXtFaTA61s0L/mWZ43rJVaTkBqCEwRVXpLTVYM
         VHkD52qGVRdZXZ/F0kXq0f+zWqsmuoExmqM+v7Ezh1HQbxMuf31j+ApIyga1h9WZMrOt
         hYSStVsAzehx7kWXjnYhultVVFAfV3M/ko14kPJ8hMTRG3uWLI42DgT3C2EQcDK1UNwk
         bmF1HF7RWRpGWsjiGb1anLPZkerKCuwb3amM/76jCDYiu6AWryhWi+De0naIhthXOHFD
         3rxBCGsH3a5g43a1JoQbiDRcyHkTsU1HOyWSguf/W+bGPvsWhsWwGU06rwwBNxqbzBEZ
         Xy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ancDZQ4xixL2Du0VM8ghYyMl2kD4SmkUdQ4EQ8sBZI=;
        b=K2WHROb1srOo+0O1E97OWcvQiCyKGe9OK1Rq9r1WvZv0fJfVjYhk43xhbHQ/aG4eR+
         BVv8VfU+IoN5NSx/d5aleSMHa5GrRBuRV3YjmCHvXLc4hPe1quGlSR0ginNSRlEV6yzN
         79SNLF0y0/G3KJX+VC9PLAQunOxa8DGH4xE6SwzhO+o3W7kSpJkhROxbcNHou6MVLMng
         2Sy4pLklRicebJe05PFG/K/8R+CIarWqyWrgsfGKkP2zxg0ezXZcnhZkHdfsri5deWCQ
         hYAtQMYW2VqSDgHcEuBYKKYJHiIYWRwwYl0XTCyOczXg+ROjCqmhhnbLwjfaXpdKdGE0
         Sj2A==
X-Gm-Message-State: APjAAAVtq9aaCSOiriUMasRx2yi9P3QcbHNwZTjCx91tfWtHID2fmJ2z
        nNTUciSHn+lKzIK4EgY94QOONg==
X-Google-Smtp-Source: APXvYqx70dd7TTJX6o1znFNPQdCD5tqI7b3YVMr+Mo0A/SzongecYOnCGBBs1FilschRPquiWiqJWQ==
X-Received: by 2002:a2e:8ece:: with SMTP id e14mr26492025ljl.66.1554260712515;
        Tue, 02 Apr 2019 20:05:12 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id d1sm2701968lfa.15.2019.04.02.20.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 20:05:11 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ASoC: Mediatek: MT8183: TS3A227: fix build error
Date:   Wed,  3 Apr 2019 05:05:01 +0200
Message-Id: <20190403030501.25140-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m the
following error pops up:

../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c: In function ‘mt8183_mt6358_ts3a227_max98357_dev_probe’:
../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:325:13: error: ‘struct snd_soc_dai_link’ has no member named ‘platform’; did you mean ‘platforms’?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

Rework to use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: 11c0269017b2 ("ASoC: Mediatek: MT8183: Add machine driver with TS3A227")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 2da56232a9e1..a50c6af5c945 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -322,7 +322,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		 * the "platform" will not null when probe is trying
 		 * again. It's not expected normally.
 		 */
-		dai_link->platform = NULL;
+		dai_link->platforms = NULL;
 
 		if (dai_link->platform_name)
 			continue;
-- 
2.20.1

