Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEFC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB86421926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8bju59P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfGXNTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:19:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39188 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGXNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:19:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so21230409pgi.6;
        Wed, 24 Jul 2019 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=187+tifTVmT8+OOjO9Brc7YUyKXShVPSiDjBCP8NPi4=;
        b=N8bju59PXmAonbSc85iXGzLL6y3xg2uZwJKtZPnFLv2O7xjuyo9lHS8oDnWzmq4ncq
         0o8YIkXVsfExVs9ti4kRZJ3/TCeFj37VJoH6+hI0pGlIgW3mkjTuiZNpKxltae0N6KiL
         RXKBrP2eZX5p1zCL/os4C9yuaav6QIabBWUAOfjrmiZplNtGdFLaCFalUkp6TumrfJrP
         81AMW8WP9t9LQ487Y2BP/a4Ip3pQqkZkLJ317FXDwta6EUMVlnFTuW1e6hQpF2lW501Z
         4oN2b2VSNda87QCtFOHyKWHS/jmg7bCH/GIUI/zgfN6A1xNFvWEkMssC6kwI+u3fWG8g
         QQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=187+tifTVmT8+OOjO9Brc7YUyKXShVPSiDjBCP8NPi4=;
        b=e05SLjwj0eVf+IjVyOkXy6WBeVtY/yxB/Eu4vYzKWJNaFC/Uj5oMwxeV/mS7j+eHaR
         hh4iJEyXuMCiicCCR5bS+TONXBppUWs7+/KpgPWL3i4pkFfNesYtttcEzXfpjvXEcBtl
         ZJDUxUGdDZumpCwiGBZDS0buxWIbW4rsBqcWjJVF7NUuP+ce7c2cmx9mfojRCQIYmEhk
         kWyJrLHfDbuIuP/EoGM5or308lCQ+tiF/+x3UtC0jUtGFMw4NfQuyLxVyRvQsivwHJMl
         la9ALEUw2iF1yozU7kavo8r/FkasKu32/RvY6ZYHgJSQbdh+fZ7ok+OhURwdNKQ0QdvT
         A2Og==
X-Gm-Message-State: APjAAAWUtOqVmarkGVNnEWg5E5W/k6VyS/GEOc9wxl1jyvDUckDetN9k
        jh0tjIEWaWY8V3v+vZVPwA0=
X-Google-Smtp-Source: APXvYqx0xnEr8N9RRGfndLrAHVr4nivY1lnSIq0jSryfTg4ogib6Ugw9VmUngELr/aWPiMAGKtw5SQ==
X-Received: by 2002:a17:90a:3344:: with SMTP id m62mr87950008pjb.135.1563974345617;
        Wed, 24 Jul 2019 06:19:05 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a5sm39888253pjv.21.2019.07.24.06.19.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:19:05 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] video: fbdev: aty: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 21:19:00 +0800
Message-Id: <20190724131900.2039-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 6f891d82eebe..5d042653e9bd 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2217,8 +2217,7 @@ static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
 				 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-        struct fb_info *info = pci_get_drvdata(pdev);
+		struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
 	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
@@ -2230,8 +2229,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
 				 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-        struct fb_info *info = pci_get_drvdata(pdev);
+		struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
 	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
-- 
2.20.1

