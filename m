Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC10EC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989A32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsR0qgSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfCZXBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:01:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47000 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbfCZXBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:01:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so2336127pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVhTNoDORVJm41U/dvmFkCkktZV91K1+FNoU6GFbQHw=;
        b=HsR0qgSYordfKl2jHrx5zqJbtouhHI4pyU3627J8Xuo70x35da5R5nIyaLmo3shlAL
         mlGdpHjesbvXjNJakIwR8NxAiE+SB5HdR8pPKoSJPqq7zbhNnAX7YxgYxsjqOZRH8ejL
         /8hzsQopu3FXi7tiGZLpeusdTKfY1xj0R3qYnY8dToqDZ/o4lv1CSpJhThbJb21hRvC0
         BibsSmWSMgOn3qJHysfkKIkvlkf3Tcgv056cAPgLmDXSkVBaVAhuyocpTXbmFKRY/v/Z
         bUTDvBKzyZUUIayeIQN4ndiJltczqB7bUA9KoIKAJhxuyqaWSdCaCCTliu32NT+/9X29
         jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mVhTNoDORVJm41U/dvmFkCkktZV91K1+FNoU6GFbQHw=;
        b=LiR3f8Mss4oTgSsm8UJj01VMbNwsNHcxt8HpAgqo8PTKTPMB+0Xf4AzvpnykrjDWXt
         +XjdBFuaFdKDBy9MSlARTqiqT3og2ziia+NGgGVPWgoLB0Rv/Ya/MnJiebgMdRVSeZyp
         kb4O1UjZChMs6Z5Scp19pKNIJp1kwhqvvr2TFxudivk46kz13F1jqacDzMeTnG6vjxgD
         hgBQe/L4EFxd7+5xLU+TOJ9uL07Zx0pUHDzRT+rlL97xozSiR8j8YGSONu18Z2MciIz/
         VJnX8FqS1gUQdBnbOKlZ1T/VGUmK07f2rv9Roh1c7+iYLJAeYzZhIqPomNHibc85i7+h
         IWrg==
X-Gm-Message-State: APjAAAV+bPNFMlvOEs662RWsCQR/MXBgebJrbLmmOequPtJnacjkSbP5
        r5qK7cwuvHPuFy6WHm/fOeJg3xvC
X-Google-Smtp-Source: APXvYqxUYbOG0HP6pL1n1gl+MBlw4kIQsbSZwC9tPcLPEhkpNkYXVFIayVuF4UUGx/Zz7cgQGLcjNg==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr25950343plm.202.1553641303304;
        Tue, 26 Mar 2019 16:01:43 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n24sm43832587pfi.123.2019.03.26.16.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:01:42 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH v2 RFC/RFT 4/5] arm64: dma-mapping: Add fallback normal page allocations
Date:   Tue, 26 Mar 2019 16:01:30 -0700
Message-Id: <20190326230131.16275-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cma allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/arm64/mm/dma-mapping.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..be2302533334 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -156,17 +156,20 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		}
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+		unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 		struct page *page;
 
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, get_order(size),
+						 gfp & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(gfp, get_order(size));
 		if (!page)
 			return NULL;
 
 		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
+			if (!dma_release_from_contiguous(dev, page, count))
+				__free_pages(page, get_order(size));
 			return NULL;
 		}
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
@@ -178,8 +181,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 			memset(addr, 0, size);
 		} else {
 			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
+			if (!dma_release_from_contiguous(dev, page, count))
+				__free_pages(page, get_order(size));
 		}
 	} else {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
@@ -201,6 +204,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 			       dma_addr_t handle, unsigned long attrs)
 {
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t iosize = size;
 
 	size = PAGE_ALIGN(size);
@@ -222,7 +226,8 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		struct page *page = vmalloc_to_page(cpu_addr);
 
 		iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+		if (!dma_release_from_contiguous(dev, page, count))
+			__free_pages(page, get_order(size));
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
-- 
2.17.1

