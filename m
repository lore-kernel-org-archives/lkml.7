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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38F6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7524E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRbSr4JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfDPLr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43233 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfDPLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so10207571plp.10;
        Tue, 16 Apr 2019 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=DRbSr4JYhMaKQ5p3pSrZNdJX2v94ShwHCZj4JAJ277tZ1wQsiIQl2m3vs4+ZyECEeS
         ypZFAEQ/iRhrJ4cy8tjSf8TINaI7KNT+bZBUhPA2nIMoy+GPcnOzX727oWD/PJNtlrh+
         HyaY9/HNlgDRuGW7rwokX24bptqOXuI9I8zNMxdpFUbLTeIv3TSNs3SkFfabWtME2qqp
         T/IiDWs5sO90ha1GY7nB5d4PNLg62FUtdtcVR8CmHWcINbDhMOvDh/r39YDnRTWFwcPF
         G5IZMu2jRg+rHhl3BtSMwVjwJinoSfvFQCvL2mrSSRqW5pkek6voVHHXMb94dmQpbOpR
         vYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
        b=peoKsKhaAxRRyOm99znL/lJcV7AkIhtayk4T4S2HxaCRDVVmoHmMZysvwRFzjPMXnB
         WfEfSUrOg9QQrQ7avXviSUrgdEaNRd7zFGO5pQn8ouB8pkK45ywxnwaPkw2L24L0vt7E
         NZO6Ks2649RFkZdYNGDGbZusooY2zbtxkA7gXgdeu2aFCIRaBH4gSYi6SY4DDVKTiuoL
         6QF7sardByOcckSeF7Xw7EK7dTp6ITowGBkTQcGM9nmm/w3WSkNuYAwFyCHYS07T6WY5
         57Z+e4tiJxUdr/+bHDRb9SdGJb1r75zR5bZdHMhHAp4Vz8UtqUJmS5C0KqWUjOFhV371
         w/OQ==
X-Gm-Message-State: APjAAAWdnDk0KEyd5XmvXnwPaHjBWAlKx1HNYvSZA68J8IebH/YfArsv
        byqEsesuyVdswF6UdX0UcDo=
X-Google-Smtp-Source: APXvYqwD0xz7vCOqB5SDlSiBwryde6J7jA8KbAOcQ8+b3Q+tiiDDskcFLBFNGuxSXVMUW6Tz86k9Zg==
X-Received: by 2002:a17:902:e382:: with SMTP id ch2mr79568490plb.94.1555415244031;
        Tue, 16 Apr 2019 04:47:24 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:47:23 -0700 (PDT)
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
Subject: [REBASE PATCH v5 5/9] drm/xen/xen_drm_front_gem.c: Convert to use vm_map_pages()
Date:   Tue, 16 Apr 2019 17:19:46 +0530
Message-Id:
 <ff8e10ba778d79419c66ee8215bccf01560540fd.1552921225.git.jrdr.linux@gmail.com>
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
Message-ID: <20190416114946.7dbTtw1D7BwpESBCWvf9FjC_ZVXXhWOL-I4R0JubtY4@z>

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

