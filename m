Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1807C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B629206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEP91uss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfLEQG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:06:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44370 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:06:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id bh2so301090plb.11;
        Thu, 05 Dec 2019 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6T5rNKNclcrc8zSiYoO2y70nKx7U2mYLpgDu385uMU=;
        b=EEP91ussc+X9HzK01xBWThOjZtw6K6ZrLXNzwbhx0dgAQ2+XYaUBeVBxWnz48RsOmQ
         wzF0BcUi17TxzODM5z06N5ysOw8YpjclnJfPSqF1G4L58tbBMLo71c4altUl4MJ9mlR1
         6n6+6jKu6+dm10mC0loRoI8MTLMUhIt8wQUjfPvna6FxQZdJyVeHO0ppSNLY+Erl/o+k
         1/R3gfasyxfoUDUOm890FZMyOYUK/rZ5u8gRvpg+IosslbZE7seueHOZVSvoQ8nZ4QXI
         pRAsRYQQzjY904SOKIjYQnrmj0ZzVe06KeuB45tFS5xZiuH5wBoHnwbFMsB1yvsmZjah
         PtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6T5rNKNclcrc8zSiYoO2y70nKx7U2mYLpgDu385uMU=;
        b=TbJWJOZSlDWUKoOy535Ohvoj6uAlGgeZfiYZMXOYKIpewCK6lZqUaajPwoKl275leR
         zzBkaesthFSKOQd7joNcqIlvtxhubofbygoKqS8gjF4yifEzrNxPXXRbvjrfnQvsIlnM
         w4hXn5McV0vDmhwM+iRODfdbYcNxkZm5x8qZo5OsEX/XuYpfW5H3iS0Dute2KlhNxAc/
         rs3CRGyqqsQyvL/OhHJ9BPq4r5n+bkvg1MauERTrN0RqgC2YhtGqhwrqhkG5YqycIvL1
         E7IxoOSeLmNLrBdOaBNZQdmnH24AbV811CdUDOKQkmTu8AAV+DIQNVdVKmQBSKejxPne
         Z/Ug==
X-Gm-Message-State: APjAAAWei5Pa1TdMPnkDIkBG/qXP+qdilkL+t2rlvbL2z+8uE3P8rb4l
        42kV6qPxtUB3114+bQ0Zuuk=
X-Google-Smtp-Source: APXvYqz1TvZSptnZMQa6vC1oLdSukjuo/E1BH74lUOre/7W/SL+wHr7pmaLET0W6OUGj2U7BLAkn4A==
X-Received: by 2002:a17:902:8494:: with SMTP id c20mr9822487plo.123.1575561985483;
        Thu, 05 Dec 2019 08:06:25 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id f8sm171321pjg.28.2019.12.05.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:06:24 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] pxa168fb: fix release function mismatch in probe failure
Date:   Fri,  6 Dec 2019 00:06:13 +0800
Message-Id: <20191205160613.32075-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses kfree() to release the resource allocated by
framebuffer_alloc(), which does not match.
Use framebuffer_release() instead to fix it.

Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/pxa168fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 1410f476e135..b9435133b6f3 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -769,7 +769,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	dma_free_coherent(fbi->dev, info->fix.smem_len,
 			info->screen_base, fbi->fb_start_dma);
 failed_free_info:
-	kfree(info);
+	framebuffer_release(info);
 
 	dev_err(&pdev->dev, "frame buffer device init failed with %d\n", ret);
 	return ret;
-- 
2.24.0

