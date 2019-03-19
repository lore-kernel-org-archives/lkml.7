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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E72C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91F22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7fWh3XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCSCXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:23:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34167 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:23:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so12778880pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=h7fWh3XQpVCLdL4ftW6K8821+fJbEx9xiv4LfYg8iyWm8RxxMuoyzBhxnRKFxjxUcq
         T00TBWmApNpUpw4//HK7pQV+dp2QRHXRCZqdh0C4p/XOt0vMVPqv8y9pxYhS5XaLRXY0
         xbmZqlxg6214GIOQaYXE7n82moU19epkFZRVWW6xQE6lGim/TRg5EoDRPgyHXH2mKts7
         x2gkkiNvERV3obQbyAvupx4A+T4a5Nf2iXPzS6etde+Tm1wXD7oEWNRmbHfKYuitdgwx
         RomL7+lV4OdxCefjaQnh0zE7naaN78p9NgU11I1wQeM3wEg2qFNj9J40w0uky0Bn7ogr
         AmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=r04s6ZQxrM5deRDigKHaOLXHRsOhNT/qXqRNhs2Aqu6tzWc+hdcZgEUaC0ZXzh84vQ
         J1Efc71CjjoBWgprj7lwfj3i+FZbndr4wXyJHsSYmLanUPTvuOwuvCTt2VqWnWR28Sjc
         Q1GXXkgzGJnk1NG0AvZIIAM8sDyBT/s/OfIk6/Q8stwl3ewA8owVk8mTrjQJZUG2x4o6
         +C+d0tVT6/HSMOSLo4pWzM07JfwFhKP7awGy+IC+O63RNQBo0KOTSj2nSME0u6euYxP2
         Gr2Na+kuoUva7OsG6qCgQKbFIQTjTh2jNWjRzksfyJ4evpGkdmi1FKviUHw3MlRCM3I6
         +Vqg==
X-Gm-Message-State: APjAAAWe0qSXJSQNOofuQSL2eWi2imx20tgtlG+IRE7ptBps0wgbOlUi
        7QV2wUgP7GEilKeYyCjxzXk=
X-Google-Smtp-Source: APXvYqwa8wXt+mz7i6FijqBLeIp49F1z3IgvodvcaTTDVoxNESr8D3k+zbgwuMkbbyfNEcSvmrRV0A==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr2373901pff.131.1552962224852;
        Mon, 18 Mar 2019 19:23:44 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id p6sm18728397pgd.69.2019.03.18.19.23.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:23:44 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:58:19 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RESEND PATCH v4 6/9] iommu/dma-iommu.c: Convert to use
 vm_map_pages()
Message-ID: <80c3d220fc6ada73a88ce43ca049afb55a889258.1552921225.git.jrdr.linux@gmail.com>
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
---
 drivers/iommu/dma-iommu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..bacebff 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -620,17 +620,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int ret = -ENXIO;
-
-	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
-		if (ret)
-			break;
-		uaddr += PAGE_SIZE;
-	}
-	return ret;
+	return vm_map_pages(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

