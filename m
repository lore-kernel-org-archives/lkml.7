Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D7C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4C620989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVwFUIhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfEJK0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:26:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38497 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfEJK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:26:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so2819639pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KX7bhkHg3YMiIW9gA14W3R58YbYmx+bP30Xm0xrams=;
        b=XVwFUIhNnY7Vr6G0aenGbpxQIFAnTaqlTy+WW9vXqYfZ7BsFK1craSiGjLjskBZ086
         jbqTXWZM8AX8P9X1zYSTEC4ojR013LY0fP2JjGdngkSA9Erk90Twz5nYPz+6kf6zxhgA
         nB66O3jG2lSN9twe6lwecwgoTtcSgzMStOdJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KX7bhkHg3YMiIW9gA14W3R58YbYmx+bP30Xm0xrams=;
        b=eYWTFzuQpfDvPoxunxkzFmCRRf5JPuD066alU9o6NUtpR155N8sFL1UFKfjjbEkHDk
         /b8Kjr3YeGu0PFpJ58BtEvlUVQ+8px7LRFIPvLHdoBa71Alt8zo4OqoEFldUs3e+8eCo
         rjDE41RsYDy6j3EtjTHFmaOKThgIOi4rTl9bTQ+U6GFlz0QeCQUrSizch7I803/aQIy1
         Uc+Cj2wwQsFvPRE9MIAHpMaHV20zKQ5Mge+j4NKdSNrla6f7Z6X/faorQeUdFewO5TxA
         /inQh/JNqksqMvTGTfxrPdxukKFhSxEae1c+5l8LXJzjLCQz2nhhznD/oFHv0shelxNp
         gnqg==
X-Gm-Message-State: APjAAAWUGU8YCFPCp6OoauifdTEcbgQU6zYeZBKPXk26sfE577IPRTbo
        eHOKQwZ8xSQoe58pZRncbX8+yGvgPuXCgA==
X-Google-Smtp-Source: APXvYqxZydM/ao+0NNXc/nuBz/ZksXOF4YpflsZ26aodWr5g6Jq82oUw3d+UMo0H41Xf5RHg+UTInw==
X-Received: by 2002:a63:2943:: with SMTP id p64mr12654828pgp.151.1557483998262;
        Fri, 10 May 2019 03:26:38 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:6cc8:36d1:3ceb:a986])
        by smtp.gmail.com with ESMTPSA id u75sm15317797pfa.138.2019.05.10.03.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:26:37 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        cychiang@chromium.org
Subject: [PATCH] ASoC: max98090: remove 24-bit format support
Date:   Fri, 10 May 2019 18:25:59 +0800
Message-Id: <20190510102559.76137-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 24-bit format support because it doesn't work now. We can revert
this change after it really supports.
(https://patchwork.kernel.org/patch/10783561/)

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..b25b7efa9118 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2313,7 +2313,7 @@ int max98090_mic_detect(struct snd_soc_component *component,
 EXPORT_SYMBOL_GPL(max98090_mic_detect);
 
 #define MAX98090_RATES SNDRV_PCM_RATE_8000_96000
-#define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define MAX98090_FORMATS SNDRV_PCM_FMTBIT_S16_LE
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
 	.set_sysclk = max98090_dai_set_sysclk,
-- 
2.21.0.1020.gf2820cf01a-goog

