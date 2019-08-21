Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C467C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4282339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEvzziXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHUK1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:27:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50596 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHUK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:27:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so1554937wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfcFoGCu+Bqv0m26SvG5wMf49FCbhYgNKFtc/Mu7ArM=;
        b=dEvzziXbyDYjihHBHAQ4og/g6Ul+JzM+1X3WiZ89KPRoO5AfTMcUKgbTjavvmz7+CO
         Mdl5Hq0ZNiWwCuznT9fT4WPGFNLthr/+bIK8/Tns7fW8NXKl0htemLGe87xYMmtp370V
         08UAUrkyuCQ8MuatWKWGV89mJ+b7XPLIQUF2gLDsNlHRayxNHffm6CtrEeynf6a2/E0C
         4ooE1iftKfXqUkdYU+RMGlm8/NZLU4DRnAjbhpUWrqF4NfXaGyOyYAZ13pD/xyDjKWPj
         EBO56Bx2nVKiVj7Vfb3d68rHOjPG/lK3IDWZS4FQeT5yiIjAJrUKBWafViFlOTIi5H8k
         SPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfcFoGCu+Bqv0m26SvG5wMf49FCbhYgNKFtc/Mu7ArM=;
        b=QNNoeMPL6Q3h7sdXGXeCxiaL1wVr2fWHvCFHP7lNLCuaRPqO1jqOiLu5HQEsTI74fD
         HcoCP2AtiYPEPKqAFwd87V6RSqXwkjohPGzWN17JGMWldcmaWhHS9pGKiw48EP6bkHd9
         T5JOKESSE0ObnVintaDweYnGaEguEplxqzDgqSHuTaYA+53Fcf2BinEcw9r/XV0dd3fS
         WWCKx6kXtRDMOSF5WEkZXu0Mepu38LV/XO5FXcxu/GmWnlzVVG4WDL9Dl418ClHlA+4Q
         kr2AP+0yU+CuneWrMPEPVa9Vag26OOwAcUM45seWFQ4TP08jXz/Jll4kjQz/GNhDOlGV
         /WqQ==
X-Gm-Message-State: APjAAAX4frGzuryrPswp4J4ci8lCEcj6MpdAMuVGKC+9Bl/f5XizFTu4
        J7vaJ9eosImWbC4rByA/aBWBFQ==
X-Google-Smtp-Source: APXvYqy4ImYkCTgqYv5UHwmc2VUZxv6qDWNrqq312b932pdxf7IsrXoWsMHBZbM4Y0whtwt6pa1bkg==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr4928650wmd.122.1566383257348;
        Wed, 21 Aug 2019 03:27:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p186sm3475079wme.9.2019.08.21.03.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 03:27:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, Vidyakumar Athota <vathota@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ALSA: pcm: add support for 352.8KHz and 384KHz sample rate
Date:   Wed, 21 Aug 2019 11:27:05 +0100
Message-Id: <20190821102705.18382-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vidyakumar Athota <vathota@codeaurora.org>

Most of the modern codecs supports 352.8KHz and 384KHz sample rates.
Currently HW params fails to set 352.8Kz and 384KHz sample rate
as these are not in known rates list.
Add these new rates to known list to allow them.

This patch also adds defines in pcm.h so that drivers can use it.

Signed-off-by: Vidyakumar Athota <vathota@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/pcm.h     | 5 +++++
 sound/core/pcm_native.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e9bb1c91770..bbe6eb1ff5d2 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -117,6 +117,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
 #define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
 #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
+#define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
+#define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -129,6 +131,9 @@ struct snd_pcm_ops {
 					 SNDRV_PCM_RATE_88200|SNDRV_PCM_RATE_96000)
 #define SNDRV_PCM_RATE_8000_192000	(SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
 					 SNDRV_PCM_RATE_192000)
+#define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000|\
+					 SNDRV_PCM_RATE_352800|\
+					 SNDRV_PCM_RATE_384000)
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 703857aab00f..11e653c8aa0e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2170,7 +2170,7 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 
 static const unsigned int rates[] = {
 	5512, 8000, 11025, 16000, 22050, 32000, 44100,
-	48000, 64000, 88200, 96000, 176400, 192000
+	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000
 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
-- 
2.21.0

