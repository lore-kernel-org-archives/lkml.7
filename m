Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E63C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E302F216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyO2ylq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIBMnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:43:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfIBMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:43:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so7430699pgi.6;
        Mon, 02 Sep 2019 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ooe5z12tf4eCBGCVXGJZdyU61lnZf8UxozrPAtJtqFg=;
        b=LyO2ylq1hMvJP8HhT7mG3uunF78cZErvlO24NmDxqyhxNiCdYGt6pNgVCw1Jxd9HtE
         2gLGK6oFjGGUNacqqhFzoTnVtYoVhI1eP8mHDf2fEY9kSmDDGKqG9tCN00JhEw/uoxWw
         NKw+ZSlhqJnxG5HRQDmIhgAeiBcHi8Qt5xYB+EqzGfeIFHSwzpiIztN/Y33b8qq3zHH1
         dc11/UPJEVWoCK1awbsKTd/NBn0v/c6kBXk4CbcDli9aeug4q0uJc9wLIYhG1Zo4nQ3z
         Ll9kbCP93B+XX6aytGvWmNweWxpbawacxilTi4M4GSiIL6ddW8l+0OE0Xv2FcwOH/BHt
         Ogag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ooe5z12tf4eCBGCVXGJZdyU61lnZf8UxozrPAtJtqFg=;
        b=O4rpQgJqk57mzAoSKz5554iYsXSBg0ff8vKbNIfugvIWyna+4u1VbxA2aQRWHIXIQb
         OWhkdh7U7XL/SGxYnSNWFucFXNhpA81CU0PGQ5c4HbwBOre8c6Vj7CQwoK+IQSrNlS0D
         KeWZ2+uUCAZ5dJtyH0tR/axJIQbsm5zCJjxmz1JBVRnafFLN7S2o6PYS6kOGpJe2eunF
         50fyT6NjdRxqu+FdD2orUJuBUuF0+0CDCphId5feaJBy2MKWkO7bUHaXFLd+SdkeFvLv
         +BR0CXOFkNqaoAfL2vPj6u2UhQWRmxw0c6YoZ7EDPQ1JPa/3Ov6yppzu6Qb7CYD74TIK
         ZC8Q==
X-Gm-Message-State: APjAAAUDnn51rMH5Y+FChwhXj84LmulQ9hQPqkrgZYd+k1QNo9RXKDud
        J6mRglmJKCoqKBByvMR17sE=
X-Google-Smtp-Source: APXvYqyLyzHI4G7B5pK37XIuveSiZGZ9agj2nr+S8QgtKm0qzaCDTZJG50/mG2xYaudRpo8bEPEpEw==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr13849175pfh.42.1567428193475;
        Mon, 02 Sep 2019 05:43:13 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.39])
        by smtp.gmail.com with ESMTPSA id m102sm2126286pje.5.2019.09.02.05.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 05:43:12 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video/fbdev/68328fb: Remove dead code
Date:   Mon,  2 Sep 2019 18:19:04 +0530
Message-Id: <1567428544-8620-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is dead code since 3.15. If their is no plan to
use it further, these can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/68328fb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/video/fbdev/68328fb.c b/drivers/video/fbdev/68328fb.c
index d48e960..02d22b7 100644
--- a/drivers/video/fbdev/68328fb.c
+++ b/drivers/video/fbdev/68328fb.c
@@ -405,20 +405,8 @@ static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 int __init mc68x328fb_setup(char *options)
 {
-#if 0
-	char *this_opt;
-#endif
-
 	if (!options || !*options)
 		return 1;
-#if 0
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
-		if (!strncmp(this_opt, "disable", 7))
-			mc68x328fb_enable = 0;
-	}
-#endif
 	return 1;
 }
 
-- 
1.9.1

