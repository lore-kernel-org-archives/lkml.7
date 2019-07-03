Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FD9C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4756A218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aosT7HgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfGCNSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:18:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34119 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:18:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so1256720pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=maPFzMJxkxDi9/pzkIAhWooIBm7u3WPHY1fXuOXs5zg=;
        b=aosT7HgRTdAbUppuudBPEzJ5pAmqaRAM0pjZ5iT+PWRrWYST1xeX6Xg/S/8RoHVDUm
         4Xm8U8hXNZEcomAuxcorC3N4GyZ8WxFaFUQ/5HtbxaeEYQCH5WWczrE/QcbClgcko6B3
         9kXHOCMR/9EsFpDnkT2jNADO7Pj8UR/UsKWkZsti/bmm5ZZf2Y3K9ue5eSO1LGT/i5mL
         mIXWsl+tNvt4VwOAS4ueIwoKhVcnXGXRnzs1h9TePUhSTwYP4EgWn6AJumJ9XHsliVvz
         CpEpd205rEkSkJK4oCUyn4k76oP1BcszDg3hnJY7MNXl3bDVJA50IllerePntRebQNK9
         Y5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=maPFzMJxkxDi9/pzkIAhWooIBm7u3WPHY1fXuOXs5zg=;
        b=t9obyyTzb9+CE7mVHYl8BZ8C2zjNDCVSBuqc9Z5BuB4OOTg7oH/DFXWfl/bKFykAxM
         8hJG0kBrSm+AZa+UPQoId0qlooJNFMX9iUbNGPFoDZazmJRMRCJUAKapGPftqtr9EkPs
         O1TPhIaVoq1cxIxYW2fuI+IuV2bcZG5u0cpR+brazJcEDTFRLDbFeZhcutPgm0cftF6c
         dEfj932s7DHydT0zAOWOmJuoKZtLxTh6jTkPVZIGhVjkiNKp0PI3/oU84hAMDzwChN4y
         5TrZzxAzfYfimnKAd5me1iUYgwo3q1MBz0sdtNMJRqAnrHrAXLF6PQiDVnlvwqfsexBf
         pJpQ==
X-Gm-Message-State: APjAAAXaTFLlehFjrUt3N3RCk24qXbE+aK0/UjkszH0fish4LXxs/ycV
        Rl0hGH2oTeQMTCUNZDth5hY=
X-Google-Smtp-Source: APXvYqxo3SWL87xvyOihIZ6tX+GIYgZ0rb8EldB2PBtlU5U2zf9aHiucu/yYrAvdt0jDdkhJJGdVAg==
X-Received: by 2002:a63:b547:: with SMTP id u7mr38243790pgo.322.1562159934678;
        Wed, 03 Jul 2019 06:18:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n140sm2562504pfd.132.2019.07.03.06.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:18:54 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 30/30] sound/soc: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:18:42 +0800
Message-Id: <20190703131842.26082-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/soc/codecs/wm0010.c             | 4 +---
 sound/soc/intel/atom/sst/sst_loader.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

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
diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index ce11c36848c4..cc95af35c060 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_sst_drv *sst,
 {
 	int retval = 0;
 
-	sst->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
+	sst->fw_in_mem = kmemdup(fw->data, fw->size, GFP_KERNEL);
 	if (!sst->fw_in_mem) {
 		retval = -ENOMEM;
 		goto end_release;
 	}
 	dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
 	dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->fw_in_mem));
-	memcpy(sst->fw_in_mem, fw->data, fw->size);
 	retval = sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
 	if (retval) {
 		dev_err(sst->dev, "Failed to parse fw\n");
-- 
2.11.0

