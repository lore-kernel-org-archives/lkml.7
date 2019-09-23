Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03420820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XlvLPuZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfIWQ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:29:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34053 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfIWQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:29:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so6739564plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIQLE/TpeP0HNhlfy3lZ1lxjb/GhF1u9ggZXik+vAmU=;
        b=XlvLPuZJavyiPOcfVx827wot/20NwTXrHE4BD4Nakg2I6XGoYlP9HvLTQBW8nNpV6y
         B/yPd6PqLET2yp8IKUKnWjCeC3rdEaxGjLhmit3yM+4I2rtZOKKgG4fiqf5Uy/AAi5ov
         NbecdsQQ9xyUbFDDzBjphvglyA6bH74dFlR0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIQLE/TpeP0HNhlfy3lZ1lxjb/GhF1u9ggZXik+vAmU=;
        b=G8bhm0QkTsbGNbgGxJ3HZbLp4q0gE0Chr0qNpMGHSrjy0PNxn0x0M3nXJv2WfZcpGw
         BPe0702SDf16wmW+zY6UDFSL7S+a4e3YOTVLfaT4qkRRhzFvFC/R58JHvEy2Eh9v1IoD
         K92qr9YLpWM/0K9u3D1ubnD3mq49yr/TeQAp4IhZsMZlP7ylQdJBqgiQoxVGDO5BZdl/
         UHHtjUBtCarjZHWH2pLi8end5mb6oo+cvaHwHB5ycL6SZ5t0rLCbwJ4xlLxfYPDS4PKy
         WFRQTpc5YIkZhfbQtGZ2RnGSY3JuOdlDcS13iA3yRlQob7sP61nv57Gb0LnzbrthMpcI
         HFSg==
X-Gm-Message-State: APjAAAWjuETPiJAMPyF8TSIrBSCXN091mn6TGw2cKNpk8CuSpZAcgv0y
        D/87F3dT4OegA1e4BAdpN0RD5i4GClw=
X-Google-Smtp-Source: APXvYqwRngXV+UwA72WqOEFbZ2k5d969GaGRonb02UkUYlpokXoz7LNon/OVIE/CS/DX3WXOO3K9ow==
X-Received: by 2002:a17:902:fe81:: with SMTP id x1mr635679plm.66.1569256190787;
        Mon, 23 Sep 2019 09:29:50 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id c11sm13677254pfj.114.2019.09.23.09.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:29:49 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add dmic format constraint
Date:   Tue, 24 Sep 2019 00:29:40 +0800
Message-Id: <20190923162940.199580-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On KBL platform, the microphone is attached to external codec(rt5514)
instead of PCH. However, TDM slot between PCH and codec is 16 bits only.
In order to avoid setting wrong format, we should add a constraint to
force to use 16 bits format forever.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
I have updated the commit message. Please see whether it is clear
enough. Thanks.
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
2.23.0.351.gc4317032e6-goog

