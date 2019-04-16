Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D9BC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5310D20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEPNYfVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfDPLrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38514 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfDPLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so10217168pgl.5;
        Tue, 16 Apr 2019 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=ZEPNYfVSL4B5JX2ezXJn9ONMFjeBybnM7dEzWRU+VYIsRyGMGgpqRdABkKcexucE87
         7eS/EqdBIrK6bjtSszOfKTHQL093GWBbTgMhrkG8Fh7H6jPUs7F1cdiZh36WZTAKjZxG
         fXwKyWQnGk2U/GDN1NkdOmI9RlUNXGaha0RSVNQ1DgW9t3VfJBbFyFtFx9E+/utDSTsI
         gGihHxYgoxgGi1Z3uRwOi2dNAXZTpf36/83Ta4UTHVmc82WsQ3ECg5LfIZdF7Rnpd9M/
         M8J4YNEguL/QDMiYCuFlNnKdZR0nVg15NJqCTMb575aSSv31rt9RUSWXNGHBP/5MaHWL
         Sy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=STSblc76pE/amw9edFcK1aG+ENZ8ejUPtwmezCuTN4Ccgr1RLKOiqTcFVE2sxPJdKE
         dymtW3sD8FMajkXZeZ/L5snbVoqdcgkFMUXl3UCvSCNZ/poHYqAlzFTZMxifTUtqd7hx
         veE1MPJvZXNpo6i0tLimWf96rRaSdLD9QJv5BBhOPYbwLeAVrUUu482MyKRnLDvW/h4k
         MQgfaXqtXHxB4onb7KHG2F4upoxH15ydw6wSwOpJqUlXVTjXMtgaCL5StgBBpqmgZ3DR
         TfYgZB/7SlsCLJHPIEgjt0XKtwU8EfD1pGozL+2f8ANz/U26kRrF4eV2iNv7HWZGlDeh
         UCCg==
X-Gm-Message-State: APjAAAWL6qxEyCEMOW5qJihB6PzE4r6boft+DmYtgB6HA0LJlDe0Nl+l
        Aw9ngqTDBM7OfXRujSDaOPE=
X-Google-Smtp-Source: APXvYqyrLQsRSnTjPgcZvGACSx9pqT9Y2eLgTKItzz2brxMgzhzMpJHBo0PeONjvaK7uMxB6G+wAOQ==
X-Received: by 2002:a65:420b:: with SMTP id c11mr76375087pgq.24.1555415234335;
        Tue, 16 Apr 2019 04:47:14 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:47:13 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_map_pages()
Date:   Tue, 16 Apr 2019 17:19:45 +0530
Message-Id:
 <7ba359eb1aceac388d05983c1f29b915bdf291f9.1552921225.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416114945.0kWwoMR6d-nec6ka6HIrXxq2Jc2rJUXqHwerP7MHlSA@z>

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Tested on Rockchip hardware and display is working,
including talking to Lima via prime.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..a2ebb08 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,13 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
+	unsigned int count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff;
-	unsigned long end = user_count + offset;
-	int ret;
 
 	if (user_count == 0)
 		return -ENXIO;
-	if (end > count)
-		return -ENXIO;
 
-	for (i = offset; i < end; i++) {
-		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
-		if (ret)
-			return ret;
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_map_pages(vma, rk_obj->pages, count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

