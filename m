Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF60C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2320A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTn+t77v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfGJR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:58:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41006 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfGJR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:58:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so1442092pff.8;
        Wed, 10 Jul 2019 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Yptoe5D085BWh+Bibq1x1Qze0BUntRJjyskqFEUkv4=;
        b=tTn+t77vdNkoiG8Ypss8Jb1MN9bCLyC0qtR8XfCrzNdJsuOVuvNQ1DdLEOL4u005Ba
         cvHdj6+6PfRyKhHzkljerHrTWMEJfGtZikAG5SfDWxACqVQE8+Y+eXa9vgTs0j1YF6Aq
         /bMlRektpHJiHrSm510ZZ5mlnrI8SHO+tmimjswCuuqgyDF7E7IYHATkGjN8SvLAazha
         QviZGyYzNYCC9M/jzuS2U2gyY7aQqLhwpwNlhWlxSG4yGM+z+3lDk1cl3bVfELADuaPX
         63SX5w2hhXtLZlgH6EYie38nh4MEot/F8DynKZH6pqqn4fSJa3aW4lYui6YIg4Uclt5K
         nrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Yptoe5D085BWh+Bibq1x1Qze0BUntRJjyskqFEUkv4=;
        b=bdAsHaX0UrtUsbK74YJLb3pl0Dd9p7K76kIrus9+qfQxQR3hVxcluqgsgJZ0EvgLx/
         OzYlXumNM3X8RQ0wctUnOA3i4fisJkn+nQcNPdanum/6y8zzpQVGkg7Ss3xhMrKe8xsa
         CH/eMH4zEVNt//JJbYEl2eS0k/T4TZE61ud03BzA3gZER8ugRCtHJUEcmnnvVdtaCqEy
         6+6QzO1Hpvi+uP9APZHB8CUjv9aisW39ZjyXk/q0VwZ07L8m0qf8iY7aPjeotWKLx5eH
         8G9X3TdPHW/lMHYvBEfVHl0BOBTf4w1D4KJrsqLXkcGGz7M2qTpFIDzeGfl5i16isrPC
         GgRg==
X-Gm-Message-State: APjAAAWGnkiYLN3dMRHm552PaqLtXyPJpOc9K6dAcWZOY7INskZpnfAC
        +15J9GAdTD9W7xtoRbQ3nMU=
X-Google-Smtp-Source: APXvYqzRIoVFWzhS+1VgbH8QHWcdl6FPoGRrTAD67T9udDa+FcsMUPzpD2OL7tIqAgpvpAzvnDPj7A==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr8433814pjb.19.1562781515699;
        Wed, 10 Jul 2019 10:58:35 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.16.82])
        by smtp.gmail.com with ESMTPSA id a6sm2460536pjs.31.2019.07.10.10.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jul 2019 10:58:34 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     adaplas@gmail.com, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video: fbdev: nvidia: Remove extra return
Date:   Wed, 10 Jul 2019 23:33:15 +0530
Message-Id: <1562781795-3494-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup to remove extra return statement.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/nvidia/nv_backlight.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_backlight.c b/drivers/video/fbdev/nvidia/nv_backlight.c
index e705a78..2ce5352 100644
--- a/drivers/video/fbdev/nvidia/nv_backlight.c
+++ b/drivers/video/fbdev/nvidia/nv_backlight.c
@@ -123,8 +123,6 @@ void nvidia_bl_init(struct nvidia_par *par)
 
 	printk("nvidia: Backlight initialized (%s)\n", name);
 
-	return;
-
 error:
 	return;
 }
-- 
1.9.1

