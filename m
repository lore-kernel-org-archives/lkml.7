Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E290CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56C72147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0tcryB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfCSCXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:23:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38319 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCSCXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:23:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id n125so12595955pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=r0tcryB8FIFERLIj7h0R33SOmYQKY3BszrJoO9gjENz3TFDIJjslV5YKjuYSuiYBUV
         i4+oGUagTKlmINiPDRLeTjbaA0eWp0BIpZZgCb2Qe0Tao76itUzijedlOG2GIRjFE/Hz
         BaWedKn2ryfGsOn5FBK7iz78EkzaoCRUznER5dHb86rqpZNrvE6rCWhhXrrRvSBpf9C1
         7ILDZf7aFsdefLmMnDiUZnSWFexWdlbI3y3kvYZ9e/pzLyTe0dvAvQ2aONlmJJdR4Pcn
         X3qaxjDMZwQfqR4Aaa6V6UxgRjnM6WB3QSwTbx0ZuSHyFlLa2E63NVEBREXlVUGi2Z6J
         6X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=p1XGX/Fcfy+g5ZM1jtwGCEcNFX5ZozcD+4MEsTqA6YJqqif4KV1DUe1aJmwh03N5K0
         //EEkrPuyRbc7M1jQuvhvMoMa/8lYRVUY8t7IHFx6MmXe83IuWu03tXmMF6Uqd/WqP51
         K+lyO0V2kjBT92+e0J+zHbAxFX778OxQR9bhjMbPXFHDJWw2n85vcH79V+9LF7KLmlHU
         AfhDslvtG6JBosDE5wHhyC1PxlzWcW8PIfzBf05dQ47Lm0ez0w3xDfXPMcnBQ6Uvtwyf
         KFS3Zd+B78YoVD0fwNcpgQlApRfRtt+R4pq64mPPwMHMoyToiC7IU0aWgiBABbFxsoif
         wE1A==
X-Gm-Message-State: APjAAAVqaoNAXPzXX2SjB5/AyvC6RKqaB033JUhXItLOmsSCYxgs3X1n
        zy0xt3KdWfXZIzTPX5TewG4=
X-Google-Smtp-Source: APXvYqxDQ8p8D25l6mu8hirVXzXqpLPPAgWgqdF/gLd3vbvYIwZUmDpQg4eiKwmgL/qbB8DgDPB4wA==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr13784pla.226.1552962181959;
        Mon, 18 Mar 2019 19:23:01 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id 3sm15567578pfp.115.2019.03.18.19.23.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:23:01 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:57:36 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [RESEND PATCH v4 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_map_pages()
Message-ID: <ff8e10ba778d79419c66ee8215bccf01560540fd.1552921225.git.jrdr.linux@gmail.com>
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

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 28bc501..dd0602d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -224,8 +224,7 @@ struct drm_gem_object *
 static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 			struct vm_area_struct *vma)
 {
-	unsigned long addr = vma->vm_start;
-	int i;
+	int ret;
 
 	/*
 	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
@@ -246,18 +245,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 	 * FIXME: as we insert all the pages now then no .fault handler must
 	 * be called, so don't provide one
 	 */
-	for (i = 0; i < xen_obj->num_pages; i++) {
-		int ret;
-
-		ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
-		if (ret < 0) {
-			DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
-			return ret;
-		}
+	ret = vm_map_pages(vma, xen_obj->pages, xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to map pages into vma: %d\n", ret);
 
-		addr += PAGE_SIZE;
-	}
-	return 0;
+	return ret;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

