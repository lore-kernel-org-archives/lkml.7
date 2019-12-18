Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C856C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KiZx8uNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfLRRYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:24:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38977 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfLRRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:24:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so2686299wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ed5DlqEWvxMQUQebFWG7u2PHMS/9BBAGCyGgvqZnXFo=;
        b=KiZx8uNrDxyr1CKrK3b3Awr2DIit9WJR7AcPGhvWh+Ke9RMBBmd6WxOoHo+tvd/q/U
         Vd88yOfuR+PmI8SIyl1Rq1yi0jopIL3Co9YOI4tOZ1xevV68SYk/Hv+F+zMeal3Dud7u
         FQE7uWelTZ2p/qj9Egevpr/DMohozAfSke97hCvCLczo8NzvXK0u2EilAijqxpLG5xOx
         yrKwR331SHgQhKO8GJEXHNt0szTAsSQKs3f+xhkQkJ9vEbdSfnFhF0E2u5uiUq4HXoHj
         a/5wUgK4r4F+MYvViijY3zW4dVF3vo75atXvOjboq7yx41hWoqaC4peqLJC5a41rRCb/
         5XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ed5DlqEWvxMQUQebFWG7u2PHMS/9BBAGCyGgvqZnXFo=;
        b=cSGGyW6y2PuO7TPFI5772OjuFyAx5JC7q2fkqRyPBYKaNVUJAutaeyP7p9WGyo0wm2
         HTTmUOrzUdCvBuR+nq5vd6rYou41B5W0MGG9uLfU5qM6MK4p2uRY01vN8UHz5XA1wP/q
         3uRPJPvduzfgERF7X43K4RBzqHsf0pSPfAlN7zu+7b0xFXzjBr/fSs5CEZmYSIzYTo8b
         O+0jmxYozeiKyPRx3wWOvitfsmGv7o5xKkwoTcwJX26vO2ddwCT3Lks0YbfLBGvbRkGf
         HFCW4PRn5uERhQjWdIUaNQi7Li8lDd2ypwEHjM7Ql/9HvAy6FJEVNWUf9h6eoM/xupgL
         AKBw==
X-Gm-Message-State: APjAAAUZ7NYeRAShYl6jjjftgiZ+jvZDhcVvqwjPx9rpbljhhuEe+iwM
        eRz0VFFQw1XTyS3PWlWDDIjreQ==
X-Google-Smtp-Source: APXvYqz1xXfHwFgFh5QLFX88XE5XgeTWKeWYDflM/DWqS6617x+CfPOPUBBnnPnD6LnKcIJMUh8fWA==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr4437299wme.94.1576689872845;
        Wed, 18 Dec 2019 09:24:32 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 4sm2883231wmg.22.2019.12.18.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:24:32 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4/4] ASoC: meson: axg-fifo: relax period size constraints
Date:   Wed, 18 Dec 2019 18:24:20 +0100
Message-Id: <20191218172420.1199117-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218172420.1199117-1-jbrunet@baylibre.com>
References: <20191218172420.1199117-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the fifo depths and thresholds are properly in the axg-fifo
driver, we can relax the constraints on period. As long as the period is a
multiple of the fifo burst size (8 bytes) things should be OK.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 8 ++++----
 sound/soc/meson/axg-fifo.h | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index c2742a02d866..c12b0d5e8ebf 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -34,7 +34,7 @@ static struct snd_pcm_hardware axg_fifo_hw = {
 	.rate_max = 192000,
 	.channels_min = 1,
 	.channels_max = AXG_FIFO_CH_MAX,
-	.period_bytes_min = AXG_FIFO_MIN_DEPTH,
+	.period_bytes_min = AXG_FIFO_BURST,
 	.period_bytes_max = UINT_MAX,
 	.periods_min = 2,
 	.periods_max = UINT_MAX,
@@ -227,17 +227,17 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 
 	/*
 	 * Make sure the buffer and period size are multiple of the FIFO
-	 * minimum depth size
+	 * burst
 	 */
 	ret = snd_pcm_hw_constraint_step(ss->runtime, 0,
 					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-					 AXG_FIFO_MIN_DEPTH);
+					 AXG_FIFO_BURST);
 	if (ret)
 		return ret;
 
 	ret = snd_pcm_hw_constraint_step(ss->runtime, 0,
 					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
-					 AXG_FIFO_MIN_DEPTH);
+					 AXG_FIFO_BURST);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index 521b54e98fd3..b63acd723c87 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -31,8 +31,6 @@ struct snd_soc_pcm_runtime;
 					 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
 #define AXG_FIFO_BURST			8
-#define AXG_FIFO_MIN_CNT		64
-#define AXG_FIFO_MIN_DEPTH		(AXG_FIFO_BURST * AXG_FIFO_MIN_CNT)
 
 #define FIFO_INT_ADDR_FINISH		BIT(0)
 #define FIFO_INT_ADDR_INT		BIT(1)
-- 
2.23.0

