Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79BDC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E60E2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiHNyRJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfHVJ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:57:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34662 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbfHVJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:57:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so6723450wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKAFqYDadH8IMiNywSvrdjTGvpCeW6m4y4ghvkPFmxg=;
        b=XiHNyRJPSiORbIyKJHuEbQbN/oWy9Kz9DnlaRQmvE0QFRPUSfJ/wQRArr2AAZFNcjP
         +4tKvhaM1NHaTb8jYFDWQHxJoGPUw4GiB9+C7EebLxAnrt1td8dIXJUcrSNMvCJFUeEH
         993vnt+UyK/vhA3vQTs8izx9oAfKsPy6fz4DCkP5KI/ORB33uOk6QX3qb18R5ayS58K1
         hmEB0n42KVIS4w8rWTLDo1IuJyxa8hngyXZRViT273e8ueH6mtvxrRx4MGThykMogNSk
         vOxOfBk4dgwUhlBMiB3NrziEqYZ18ssarwHumTVKBZT/7OxRlvsrJa2fDU0GywpL/zuj
         B+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKAFqYDadH8IMiNywSvrdjTGvpCeW6m4y4ghvkPFmxg=;
        b=PkivTRBy69GfvtE1efm+h00Hc5AWnDJHw3c+To0f9/Jk1cmBXPb80wfkzE0vFYT/Fx
         JYnNT+PYvfI44EDsr6S/CFUqxqSWdAK7ySSRMTS2AIrG6AWr9ei8FzGmKF2mWzHhnBgR
         hnWFalqm8PKol76DlOBzyjKLciSrqKYxpO/g7NHd95U7LaouO3T8mt7cIhhwMTJ/Pgw+
         89cWxXrBCDNeh4cgFN2P1CNN4Nbjy3s1W65vVHWEWa+qGMyEBwgH/7DWoFS4I0w9Clw0
         5NKDIrjt+rYNPfTpya/ZZpg2j1J4dUJrCSy+9G2H3kmyZ6GzYanJZGLTmYA7/hGZ7wDH
         hDJg==
X-Gm-Message-State: APjAAAWGRaSFAr++YI5DpC5lXGV2JD2yjQdhJyYj/tqn5C8Se6JeqQ5J
        NfL2nDwAHKtTq8I4shAHnoIUWA==
X-Google-Smtp-Source: APXvYqzK7Mj2V/hj/IO89jrFTKEWQfOQmDRvNqMHhkqgbg8bHdZAFC8WJc9kyzAdsIMmVhwhXq5RXQ==
X-Received: by 2002:a1c:a957:: with SMTP id s84mr5319660wme.65.1566467851084;
        Thu, 22 Aug 2019 02:57:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t24sm3298909wmj.14.2019.08.22.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 02:57:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/4] ASoC: wcd9335: Fix primary interpolator max rate
Date:   Thu, 22 Aug 2019 10:56:51 +0100
Message-Id: <20190822095653.7200-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this codec SLIMBus RX path supports 384000 rate on primary interpolator.
Add this missing rate as supported rate.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 956602788d0e..03f8a94bba2f 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2071,9 +2071,10 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF1_PB,
 		.playback = {
 			.stream_name = "AIF1 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.rate_min = 8000,
 			.channels_min = 1,
 			.channels_max = 2,
@@ -2099,10 +2100,11 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF2_PB,
 		.playback = {
 			.stream_name = "AIF2 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.channels_min = 1,
 			.channels_max = 2,
 		},
@@ -2127,10 +2129,11 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF3_PB,
 		.playback = {
 			.stream_name = "AIF3 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.channels_min = 1,
 			.channels_max = 2,
 		},
@@ -2155,10 +2158,11 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF4_PB,
 		.playback = {
 			.stream_name = "AIF4 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.channels_min = 1,
 			.channels_max = 2,
 		},
-- 
2.21.0

