Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E3C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206420723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2Fixbx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfKPPNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:13:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41220 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfKPPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:13:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id 207so917pge.8;
        Sat, 16 Nov 2019 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NR0lZBfSAsF9PTcWhdjtOR0vndWuNhvYIvZ0O6q/gY=;
        b=t2Fixbx8FrbucKGgmC0xyNorjg8XHYcKKOvOb8d4MqBkw4RSLbRua9PFBL0WqPxO0S
         vzDvoPgs9fsNawm1/nDoQKxbYxRICBGkFkcfS7fuYJaPFxrncKHsrBhSmQ0NoZs00GtC
         XPESdybY3jw3R/zj4Y2fTrDBHkIufqP6WxPogUcFDZKmSox1lRiVh9GXFryLXUCs1Fba
         +isMDFrscgXvX88Oib81T5jkgiraCTz5X8H9n3iKvL4VsT+dCUtFHaL1v0CAqwMfnEmH
         RpTXmNjRo4JByPO7ElefkJDkchq5mfKDrHCresVem8NOzbla+YCV+OIMM7J8v8VK/fJY
         umnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NR0lZBfSAsF9PTcWhdjtOR0vndWuNhvYIvZ0O6q/gY=;
        b=BDyqXegdY0MEHePyupPTKv+YCDpOtVdiTdZkeknnV4gAk1snbuDfV9tCJZUwDAvtfZ
         Rn1iLDEG/hdVYBAprawY80EEJKAu7bh3Qt5DSE6/253UgIj1HJCbpSpX87lNs1OKh13u
         7zfAu1HBo+e+qzHvYC7IArpEglKMvpkGuPeWEkiSEGKw2KEAjSziOC/cp2QCPFOvv/X4
         AHG6YCmOvu4A8FcmMt6NnbPDEWyjpkOHqYAqkuNYdmDFg/oQgy4kp58eNSzaCVXLfNOF
         0EN1Ecf3nmZgy2xKShLpEMo9S7jPq0FmF6SRWCZZZ5i8LJbU3mAxplIndJhF391OWU9J
         A9RA==
X-Gm-Message-State: APjAAAVtpvoE7S3rvsHypjpblb3j303ly9dZaBSJSOXepabgVxFkFPJf
        CddjkcdS1jJfjoiVZImxUCE=
X-Google-Smtp-Source: APXvYqwLV+Q22WHhBCIyjc4XfkdYQHcDZZlOf6JUEe1X4D7cOUaa++BL8PFFUkrqKStocMzbnbRfew==
X-Received: by 2002:a63:ea17:: with SMTP id c23mr22941078pgi.85.1573917207501;
        Sat, 16 Nov 2019 07:13:27 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id m6sm7250201pgl.42.2019.11.16.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 07:13:26 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] video: fbdev: vesafb: add missed release_region
Date:   Sat, 16 Nov 2019 23:13:18 +0800
Message-Id: <20191116151318.17874-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver calls request_region in probe but forgets to call
release_region in probe failure and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
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

