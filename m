Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5EDC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCB8233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNnlO3AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfHVJ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:57:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40628 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbfHVJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:57:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id c5so4903225wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lEwavhf3fUGzkEL5MEZgCjXL2zMuro3WN6EEJNDNjU=;
        b=KNnlO3ASgv4ah2d8gdkaMFHttHgLNVvTnm4UPZ74Eqwfy7YLV+R7o/vIGBjnfyEh9E
         Xv1tzEw7a0qZuTR4qmbCKAeMqQFEJyk4L2SOdZhCRPcm2dCoG58ReEhEDi5blIeHiiFd
         VzKuaX13KfllCzPzSn3OiuysWFMb1eZQ9VePTg63dOcHiSVD6LX0OHU6EyaTuK1MaPx3
         Fq1QgUzvgl/WKVRERRfykRgAnriXiGyZZPViuba/+Tlcbhv76oHh3cPV1qcdbAYWX27j
         lcydCzTlT7ABHQBsbCx7if52dsaxPcdMPGkyCSfG9L4xAE8gEzVYW0iXOkFs0llHuKFV
         XmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lEwavhf3fUGzkEL5MEZgCjXL2zMuro3WN6EEJNDNjU=;
        b=AnTBsR4eIiGuPY/G1on96jFKwPgb4qgJHZ9sOelyFPYy32u287rNXPQZUA6lkLWlDJ
         3ZoWbUfiQn8cKqueMRtOrq+z+iPh5vuKYQWjUgJjaXkNz1VI7T+U2xgbBo6c+SeUU1ho
         6OJ25GeJKnUOcEj8UcPn1384D8WyuT+FOqSgdCA+1aScmLUosxZs3tGD1PS+VUv5bWRn
         XaluyluE5KVq0eDVzOr0MF6xQqlg3rXHGF7jbm4dJhT5boW/ppfIJ0SObRi/oFff0ZB7
         5fdKqann/irzYeQC51ZIRHe11Ql9eftmiTpewOIFnhHqxN6JYHZL9PNYThHgWP0pgJI1
         3MLw==
X-Gm-Message-State: APjAAAVz91OSRde/PmcKwfbl7OJd2G1zrq5PW8Ej3uWRA/s/ftdBvS+x
        B5dR3afjdOMpY9bmTao/HkwWCrGFlHM=
X-Google-Smtp-Source: APXvYqwUnYGJLfqkiROJD+X4tEsIDFB40pxu7PvSCUNNiAEanKhCCKYvuvg1SrblgBqPqyIcx/v9bg==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr5154610wmf.47.1566467849478;
        Thu, 22 Aug 2019 02:57:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t24sm3298909wmj.14.2019.08.22.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 02:57:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Vidyakumar Athota <vathota@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] ALSA: pcm: add support for 352.8KHz and 384KHz sample rate
Date:   Thu, 22 Aug 2019 10:56:50 +0100
Message-Id: <20190822095653.7200-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vidyakumar Athota <vathota@codeaurora.org>

Most of the modern codecs supports 352.8KHz and 384KHz sample rates.
Currenlty HW params fails to set 352.8Kz and 384KHz sample rate
as these are not in known rates list.
Add these new rates to known list to allow them.

This patch also adds defines in pcm.h so that drivers can use it.

Signed-off-by: Vidyakumar Athota <vathota@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
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

