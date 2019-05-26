Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9954C282E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DDD2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csv+uwl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfEZQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 12:06:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 12:06:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so6079765plq.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jwR1lvrNF2AItUaoIXP2wSOWe9t1QX2CvMMmPBX6eWA=;
        b=csv+uwl8wQAeGK7nnISSbnHejM9zbg+YO0ZVBLhi1VoBadodQEAORGD+ptdZJdh3mR
         6DOL1MSUI+4J+Sw5xEkUw3UWdH5AkgU6eQIiquaBRbiIo7nY2PcXodsYFW6JfHee+YGc
         UE/JC+p+sXh9hw4vSgM7FYiY7/0adDs967I2PoZh9GUZS148REiypraHWydI1qgP4IIi
         mpxzBxsJpqWs8yILaEXIbmCh8scx3ZxT3Dquidue3/s6XTg7rx/6Pv35p0nQ4StGE6cY
         X/lowZobfMr0STL42yuyPo/Eq/3eQCQxPxrROkN50kAaJlXpdAnxKwf4smT6CKDuwb31
         4O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jwR1lvrNF2AItUaoIXP2wSOWe9t1QX2CvMMmPBX6eWA=;
        b=qz6b4qXFC/HaRA21iuGNGyjj7WjchhbcICzIsYXvg4hXneQRcI3kEvo11Tz+OCCP6n
         6wqyWYKpBe24LF1eiYtlP2gXnRURhMPF0j7yHvHHFs/hcw2GzdxNBSHjhqs8b+lxhMf0
         o2D3FLXHnMTqZ8IEOsGrXg9e4ZTCIauMKb8hDsa2Prh/TRP9zFKFO9zduhSmSpT/BloF
         KBupgxmLZDPAHzl082PELolZKcweaHCi6wcFU6nDUGwo2wQlEf0xxoUejxNrEYfsW8Ag
         /mAoWNlwLC/XkhEIwaNaDTFByRsBzzHsjEyFwH99+spfwb1N4M4UlJKKlceUDX/HjOgS
         noYA==
X-Gm-Message-State: APjAAAU72XpUMfK7ozZWqkK1VYT+M3Z1yaqD84E+tzPrc0+gqwk0Vvyt
        jDdulsUIgYVxSJsDRJ8yuB0=
X-Google-Smtp-Source: APXvYqy6dpm9qmGQs6V4REc11e8QQz7Hqjq3wNCXmHeuo1x/HgyeFG7yngUroeYo1Dw356070z7GNA==
X-Received: by 2002:a17:902:bc8a:: with SMTP id bb10mr22710797plb.310.1558886772874;
        Sun, 26 May 2019 09:06:12 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.23.119])
        by smtp.gmail.com with ESMTPSA id o2sm12859036pgq.50.2019.05.26.09.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 09:06:12 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        robin@protonic.nl, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
Date:   Sun, 26 May 2019 21:41:10 +0530
Message-Id: <1558887070-4076-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using mmap, the incorrect values of length and vm_pgoff are
ignored and this driver goes ahead with mapping fbdev.buffer
to user vma.

Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
"fix" these drivers to behave according to the normal vm_pgoff
offsetting simply by removing the _zero suffix on the function name
and if that causes regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Robin van der Gracht <robin@protonic.nl>
---
v2: Fixed minor typo. Acked-by tag added.

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

