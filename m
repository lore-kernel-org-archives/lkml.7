Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0594C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3F520700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiBtkKML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfCSCZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:25:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46680 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSCZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:25:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so12582870pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n/NDS47nz9uuNytg4LeJJ+li959uQqsTwzm1mhrxiWA=;
        b=jiBtkKMLnhknyJBqO0pykSJ1rbddZqUTZxiCQSo/SQdWsCg6rLr0Cy1/XcNb01JLUe
         arpg6kvnCyN5mQVoBrYIXH3jjsPbg038amLqb/8cOmOdXYXMUoJGico4viaD0NRc4vzS
         tqNZi/bzEiId0TsLouzvEpgHrIloi0yxX3b5HKTc68Ot8AOc22832Bwi6kZpXbWljicc
         Z6NmfIIGCh7KJixA06QsQBncUA/fr0iFgC3sIQ2960zrQ/E63Zzk79r1DAeIZ/RVs56o
         Z92k7Ksf6tDBHwMo12HW/o2rx8yQUNX35Sfm4tjZIIcRXJ2dzt3xtZBPd9C4QamrFLr+
         ZhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/NDS47nz9uuNytg4LeJJ+li959uQqsTwzm1mhrxiWA=;
        b=UlTDhVEMuOX8O/Qb5u2+/61ItnumDTQBLIkWxcGNzgQ95RBLuNO3QVs6O/PAhLGknr
         QXlUHZkeutdtDa0byuJ3uzkjgJ6d9Zkw0EUXyybmYVp++7vFO59ALkC9TuLZwAHnaanm
         +4WiZnKjgCA6VV5f6CYHAAL2Yls1Wz1N9FlmT3SQXcbM49zOoTzTxCIKL3Y5k/1SaeYa
         ofF2amWisLxOIWmx6SmyvtC0QPLvwGI99x42bSQH2IJXm1SORRPwR0CmDGDCNAnL/6qp
         ErP2drPB8wVCYFXPeilFrINVXpdQhOCJZFZP98MglYpN6HNSiTfqgyYBTdkW+wTC0mYU
         qmsg==
X-Gm-Message-State: APjAAAXmhEnA96tfxMh33t601aRsQq2yfDI1zRWLC3L+UIhzS7+UiiRG
        zt0feq6fg86ycpxcblRZzp0=
X-Google-Smtp-Source: APXvYqw25r5MaAPOEBNu+onH2jr/m6hG8lprEL1PtpTxaPWtjQk1ZzP3VFv20URyYkFjUUqJo+9YQg==
X-Received: by 2002:a63:ff0f:: with SMTP id k15mr7714pgi.301.1552962332881;
        Mon, 18 Mar 2019 19:25:32 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id b17sm3327180pgj.79.2019.03.18.19.25.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:25:32 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:00:07 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RESEND PATCH v4 8/9] xen/gntdev.c: Convert to use vm_map_pages()
Message-ID: <88e56e82d2db98705c2d842e9c9806c00b366d67.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

map->count is passed to vm_map_pages() and internal API
verify map->count against count ( count = vma_pages(vma))
for page array boundary overrun condition.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5ee..5d64262 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	int index = vma->vm_pgoff;
 	int count = vma_pages(vma);
 	struct gntdev_grant_map *map;
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
@@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto out_put_map;
 
 	if (!use_ptemod) {
-		for (i = 0; i < count; i++) {
-			err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
-				map->pages[i]);
-			if (err)
-				goto out_put_map;
-		}
+		err = vm_map_pages(vma, map->pages, map->count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

