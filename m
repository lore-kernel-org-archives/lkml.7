Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6AAC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F8520644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqJNyAPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfGODUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:20:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46390 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfGODUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:20:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so6982462pgm.13;
        Sun, 14 Jul 2019 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KmjmTx0cDkAe4BsoggF2c5USLaF9+w472czn75Hcufo=;
        b=GqJNyAPxH0Ml0g59SFjtNPvfI/nMwwEmQBiMDuIUmbJNxGEbQuUvp4UuHCxkb4848N
         mc8GAIRsEBzwiVFxp9+2z7sHhc2s6zCZY6p+z8V0oyeg5YjWZml7szMhxsuWYg5Kg8eJ
         7npQPI4AQEPuRJFUOjSIlLO+/pp32+xG+DZcylLjOlwElP60UxNrf8UGavSWXMtW4Maq
         /DBhmtm6BqdCNXAUc0g9J7267V2BPQ7BDPwOFG/EYl6r8K/sszLtpIroCvoh6ld1FuFP
         eFsVynfcUM/U9ebG1AZlUJ+GaLXNlfBCCD0Q0NY3xzeLdZOenyGS9aF/bGerjin5toUG
         fPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KmjmTx0cDkAe4BsoggF2c5USLaF9+w472czn75Hcufo=;
        b=uadVYlPi8lNEx7JDazBmOXLp10bd/VXf3ignAeRhS5JbI6VVAhJ24UprMJwp6OE/lA
         zdBF17dwq89gylTBMDJTtgrAocsuvvv2IX6beUJhHChmLsWaeb4UH4Z5XQHQ/9H+96E+
         Z44sjBCeC7HFYtHrdksuEnCwb/K2lip5nuSgmUQOWUkEVKYMnxWf5XDqB8Bhvwmu8z2j
         BAIG7cqD75Ni+Yz0+ZE+RQjjQgaL5ucYpRQDDgZudfYblzZ2MeCRbjHyJdCPfHWNqUON
         g7Hsn1tSzdMVh9i/DZf10LJA85ZK4QFapNjfciPXNIbpq7QnKGXVebT25RboLuNSP2Ms
         rWTA==
X-Gm-Message-State: APjAAAUq4QPIvMQb+FeYxHyjqTAVOXhLpvqd4Q3I2rf9yM7TQresSZHv
        l3Y9/hM2IG8qNMpPNEGXaUI=
X-Google-Smtp-Source: APXvYqxHjzkaC+srO/ESTpNfjkimIX2OQWbqnxpKFEiSNS/7wssDV6FtTvwkIFT9kcz81LQd/+4Uhw==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr26449164pjb.135.1563160823209;
        Sun, 14 Jul 2019 20:20:23 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id x1sm14037462pjo.4.2019.07.14.20.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:20:22 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 24/24] video: fbdev-MMP: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:20:17 +0800
Message-Id: <20190715032017.7311-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index e5b56f2199df..47bc7c59bbd8 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -612,7 +612,6 @@ static int mmpfb_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto failed_destroy_mutex;
 	}
-	memset(fbi->fb_start, 0, fbi->fb_size);
 	dev_info(fbi->dev, "fb %dk allocated\n", fbi->fb_size/1024);
 
 	/* fb power on */
-- 
2.11.0

