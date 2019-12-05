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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EB8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F23206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spso+1VB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfLEQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:07:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39173 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:07:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so1820181pfx.6;
        Thu, 05 Dec 2019 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nk1cXD8ocqFBtC4Ixaba4spST22wd8UaYJyDzazVJTU=;
        b=Spso+1VBGEYjX599HKgBZ7LMPvTnErQh8OrWYDokzKb3zBSSaEgZ4u+I7C5EwKrVeR
         lUG3UW/5r65Fp75N8CBIUjv0os9y+d8jDXNVYICft9E6k/2uxzV9eTJm5v5FvsNpZo9o
         vf8MzxGjzeWRfcVXaeWb2sQNaDqMSv+/hIJ+IRH3BPxs3B1ykEPlsdshzdpXT6Xuwzcj
         EgGzERz2cVpnYAaW3kqMFAtCJQswy/cTqOwhu4EHNjgqlzgRKhF2SSB4NFAcFCCyDxfn
         UbFZIr3T0i9xpQA3xoaqCda2BYeVA5gwQcFMZGSDjcbHaEj8cfWg1pu9yAIv4xdZTwIg
         k00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nk1cXD8ocqFBtC4Ixaba4spST22wd8UaYJyDzazVJTU=;
        b=l8cWx2IplVPxHPDd91ucWHxdeqOTRmdRRmxSgsk64tGXHRy5fDnSXwy1xUFJAmQghB
         Mmqeh3LBy4yhXpRf9YqKcouhmvvJBTl0UL/sAVWoN3ydXpf3mqKtxP/3NBugfNNCZRus
         jYykpdUHURazb3bzw/K98qX7iyYF6yuvClvt/P7158WDeqguChvGrZqdHbjlPGArI9Kw
         UTl236B7QsawiIGg8GFxLdvLnRXR9MQ2GTf9e98ApIusXmlX0mo/BoNDdn5geJa9+tl8
         BDDYrMYDnXN1V5JtgN7uJUK9ueJYTdxP9kkudCbyQEs8GR8RjRKVWgyhpVbnlmYT0BD5
         UANg==
X-Gm-Message-State: APjAAAUukiG4hJqOZiRM05pU+vkQQrYEIA+Z1aNGNekin0GWI/lEFzqW
        Wk5gafjSRAZRkGfyLziPvIk=
X-Google-Smtp-Source: APXvYqy9oKB9Ozl8hrB3SUfpSveBM41X9hsvRCH6URNhs4FJAED+cuPGdd9arO5yZ4Zj26NEgNPDFQ==
X-Received: by 2002:a63:3104:: with SMTP id x4mr9948531pgx.369.1575562040738;
        Thu, 05 Dec 2019 08:07:20 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id m15sm11956980pgi.91.2019.12.05.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:07:20 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] video: fbdev: vesafb: add missed release_region
Date:   Fri,  6 Dec 2019 00:07:12 +0800
Message-Id: <20191205160712.32245-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to free the requested irq in remove and probe
failure.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Modify commit message.

 drivers/video/fbdev/vesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index d9c08f6c2155..fbb196a8bbf6 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -468,6 +468,7 @@ static int vesafb_probe(struct platform_device *dev)
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 err:
+	release_region(0x3c0, 32);
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
@@ -480,6 +481,7 @@ static int vesafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	release_region(0x3c0, 32);
 	unregister_framebuffer(info);
 	framebuffer_release(info);
 
-- 
2.24.0

