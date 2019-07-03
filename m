Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D473C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A7F218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3/1i6PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfGCQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:32:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38062 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfGCQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:32:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so1513916pgz.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l0364bIasEWF4u6q6PoJgdA0dWNvfPQBCr9kLEyFzmc=;
        b=A3/1i6PFKv8gEafTpu+DrcOtTvtUVbk5N0FhU3sAIRCeitnnDZl/16Vgwj94zhFZRw
         sloUEURPQeMMX4uVZq7nUxbncgxJJDxnsQEx5LGUxopH1IJ5oNMFuliVpw+YwjuTn0Hl
         hY7MHjdi8wl8/WsuuDcyV4wjpSseMOFafa32ggD5Q3LgDQHRgISniM1+DKZSTnFemvXw
         3wJWkS0e/SqzyUZST9Fj96yx55xRxQMtTonyNNuCWyeObU4YNYhx0jMt3uqIpSf3Defm
         btWbdptUzbuYrZ4cf/Q56RzBPSzsOSNjVzPMtbcFCHyFfcYSaXorV0t0OoOPb+dQEm7g
         CXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l0364bIasEWF4u6q6PoJgdA0dWNvfPQBCr9kLEyFzmc=;
        b=GHc8oFIFyCbci5nwXEGapzVx5MZz4342lwdkF6yKbzesihZAto9znyefFkBgoEGt40
         pi65lnlym/d5dC2RgUVkkw1va6p/LvtqzsdiRQkqRHBY0NgFN/YUaRK7CF5oL+LsO3qF
         cPY5/hFXGa7+4hlcMKPnRCHBs6wVWbRTPwM2AXVEHJKpFAkhlrI9djjv+zomHHEbwH24
         uLeFFqgnzKmEo4JkNWVKz6Nz6piifHgvT7szSIXy6v2fj++LRorKxwYGxxuRuAvupuMt
         39V2pfSPZ6AoDP4wRb+GsWSYQ2jxwS2DP/D7frI8AoaNmgivl7z6A1UCcCSRlBvg+ts3
         qNIw==
X-Gm-Message-State: APjAAAWkuVNslXlwzrtgekm6NuQLGROm4X0JBUdqUBtGgnbClf1FiFq9
        mcgG0+hhcMr6GIpDjevVUyo=
X-Google-Smtp-Source: APXvYqz95ExAz0RnIJX8vrhkHQw4WbHC6UJPq4iqb2Ol9St8WIphQDUOOlVKDM6wl0N9nBJSWgYktQ==
X-Received: by 2002:a17:90a:b883:: with SMTP id o3mr13734677pjr.50.1562171554721;
        Wed, 03 Jul 2019 09:32:34 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a3sm3042487pff.122.2019.07.03.09.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:32:34 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 34/35] sound/soc/codecs: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:32:24 +0800
Message-Id: <20190703163224.1029-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)
  - Split into two patches

 sound/soc/codecs/wm0010.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 727d6703c905..807826f30f58 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -515,7 +515,7 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
 	dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
 
 	/* Copy to local buffer first as vmalloc causes problems for dma */
-	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
+	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
 	if (!img) {
 		ret = -ENOMEM;
 		goto abort2;
@@ -527,8 +527,6 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
 		goto abort1;
 	}
 
-	memcpy(img, &fw->data[0], fw->size);
-
 	spi_message_init(&m);
 	memset(&t, 0, sizeof(t));
 	t.rx_buf = out;
-- 
2.11.0

