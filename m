Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C416D2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsQfvvwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392119AbfETP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:26:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbfETP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:26:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id t187so6935577pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AtdQtJeikUe33L23nGWRCANS3+RKC7kzegDcoMmpvfM=;
        b=AsQfvvwvPdSvQlBqu7MYfLmND64DNmrzYGHUXz18jU9F2uy3D4q3WPQBNmmc5ODkwd
         d0+878rxkRJ57QT1Tb6r3/rCCopQ8peRCcb5a7bqTHQsJTbVoVX0McIAqtnjlFgMoRN9
         6qPLLrMo8JZgFkn9P29Y9m++IF0wboffXyOkwH8GN5c0T86HMKs4EF63c+2g2MbLwKWm
         uTdvRLdVj9T1xaRc2z3ZHaKU1//bvMQR/4Rege5MM+lapZIfg1+tXYbDxuziT1lI5f13
         LhybyH5gJj8XQ2XfrxqirZRz0dW0XXhc/XuCjjOxbdCE7r0v4UmON+crPBTga4TSh7yd
         33+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AtdQtJeikUe33L23nGWRCANS3+RKC7kzegDcoMmpvfM=;
        b=p/rNJ+AnpGisKFso9Jfj8XQwOBB0qwaofKz1T5Tj8VTHzInkXV3OMIS52Pk7C1Z8S7
         EEvX6QquqUrT74GLX99hNnYfxLU87fyfJqVCaus3+CoqNfq8zGScweXXDhqOV049bN+z
         j7ViAlraiOLh4mIng0CyzhSTlxNSyDZVABEGFOMkUuf7NwnNR1l9nhGWCW3131Gvs5Gu
         LJHNR2nnozqAaG4TnPiMx7KPpilqAON4ZaHzkd26Y7cCvNgDUhmZ27fJA9VxvuR5PdUm
         1CZ6OMDeYukb2EnHFZ+f/EWTtVY1vShBX8wEGMqUD3+fV+QzphJjLVyMa/eGnQGAO05B
         PZjw==
X-Gm-Message-State: APjAAAVK5BxevlAEvmvqyMY5ouipRRnZ2y4tcvNFSgf5GR2eCMivsPrb
        DWiJDLIasBe81msswrvVovIP+PS2
X-Google-Smtp-Source: APXvYqwOoiE8PzRaymevnDUYTmM+rMuzOupAGys0f2mg/4kAGWbQy4PZ4gq6FBB938xavkhs7EgVPQ==
X-Received: by 2002:a62:e117:: with SMTP id q23mr81050039pfh.60.1558365960780;
        Mon, 20 May 2019 08:26:00 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.19.216])
        by smtp.gmail.com with ESMTPSA id i7sm14718871pfo.19.2019.05.20.08.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 08:25:59 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com, robin@protonic.nl
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
Date:   Mon, 20 May 2019 21:00:58 +0530
Message-Id: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using mmap, the incorrect value of length and vm_pgoff are
ignored and this driver go ahead with mapping fbdev.buffer
to user vma.

Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
"fix" these drivers to behave according to the normal vm_pgoff
offsetting simply by removing the _zero suffix on the function name
and if that causes regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/auxdisplay/ht16k33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 21393ec..9c0bb77 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -223,9 +223,9 @@ static int ht16k33_bl_check_fb(struct backlight_device *bl, struct fb_info *fi)
 static int ht16k33_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct ht16k33_priv *priv = info->par;
+	struct page *pages = virt_to_page(priv->fbdev.buffer);
 
-	return vm_insert_page(vma, vma->vm_start,
-			      virt_to_page(priv->fbdev.buffer));
+	return vm_map_pages_zero(vma, &pages, 1);
 }
 
 static struct fb_ops ht16k33_fb_ops = {
-- 
1.9.1

