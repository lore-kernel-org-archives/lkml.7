Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F7C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9157D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mLbAumr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfILC2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:28:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44822 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfILC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:28:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so14911841pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=717l4cD4Wzf0xH5nDJTl15ClpUuQOFo2fyYpt1Q/w+k=;
        b=mLbAumr3DrZozScwMs30++F+mc9LHyzJ1lI4nMTznNNyIfv8T3I92qVVOQ8PuMD+O1
         yKJGaeibE3xja5CAapYuI2Pa851bdGq+UEXTP+xyeeW9V7gieFN0dsE5RWKeTUi9Azgt
         RiBIxCQWng9eeHY5ruYHNqm+jPmq4OvTg8+ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=717l4cD4Wzf0xH5nDJTl15ClpUuQOFo2fyYpt1Q/w+k=;
        b=OvK+WynKIjrWW32Qm8nhzrCf+DtNzpaaWPuXVvbC1QmqQ5be8N4QM/ai8I/JMPLWiU
         212mPY8jrLSHw0OnnnzZgxZV0pIxr/nxpdSGgG9XuMGWow5weLvRZA+4J6GtPtKX/3zX
         dKszuCetq9AJaBv1zzksopvYjoGQXEn6BNdpbcY2cPqHWBj44CcqzrD6ib6zfAnSf1tv
         l1PhOyFKVoMCl9z5GsKJ6RBNFeYxfdeUFUMrHgV0T0zoqVGCsEps9HyhTXMiwybIxsvb
         EVzNzESbgflJGzu9hDwOaufkCGNxja1VueZCZRlIAHo6Pp35AnMPEblSpfCxWdaW97LY
         teyw==
X-Gm-Message-State: APjAAAV3yGC5U0x4gyeo4FmKYKfsLhuidNMNVnPpoIJUjgeBRNcV+zDz
        NOot2tLEnHovsl9x6MNlc0mcUbXV5Mw=
X-Google-Smtp-Source: APXvYqxnYzuJHmTquTSzntnrHY/YlhYcc4fT7VV9owd91fu47KgRLpUA0jzIxdr/7Kj9nG/lAQhP6Q==
X-Received: by 2002:a63:ad49:: with SMTP id y9mr343398pgo.30.1568255291271;
        Wed, 11 Sep 2019 19:28:11 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id e21sm7539616pgr.43.2019.09.11.19.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 19:28:10 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add dmic format constraint
Date:   Thu, 12 Sep 2019 10:27:40 +0800
Message-Id: <20190912022740.161798-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24 bits recording from DMIC is not supported for KBL platform because
the TDM slot between PCH and codec is 16 bits only. We should add a
constraint to remove that unsupported format.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 74dda8784f1a01..67b276a65a8d2d 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 			dmic_constraints);
 
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
+
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
 }
-- 
2.23.0.162.g0b9fbb3734-goog

