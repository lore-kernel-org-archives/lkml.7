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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E672087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFqJQuV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfCZWuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:50:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45734 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbfCZWuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:50:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so8930018pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVhTNoDORVJm41U/dvmFkCkktZV91K1+FNoU6GFbQHw=;
        b=cFqJQuV6FmmN/f2qOE6O3FagCTd8eyCZsCSf/bXbOIxVMBIxsfByjEuqUdT0yPlczZ
         qKE5Y0QUWVtnc+sLX5v+2NF3AjjUkXAJ7fF+50t1hDwLW5GE1bxFca/kNEkumdyC13HN
         zAEzlZroDh7TUyO06rLhbvFTBw10lv4dhsdlQ2lnsM7CNQw3UxDymby1giPnWC7h/b5S
         Lr3G4bPqrl5KMS+wh4aU4rZihb4Yg+O0x2z3frjLpHF3tT+5wXQXccuHdyiPg+Ge1WB2
         AsGfHAAbInBda09PKb4duUmNhFQ2rVzzv/vbCtEsCOrZQylqHqvLcpnqjCKB9mWLFOb4
         DsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mVhTNoDORVJm41U/dvmFkCkktZV91K1+FNoU6GFbQHw=;
        b=M5sweGS7/Kb952zvSYkSS5U6nIgFNIgroOEpG+p2fdwYbK6TIwktoU424L8qzwn06t
         5EU/TL42wk8/0W40HGBUmXrtkZnkdSJS1rnELD93gi5oEwEf14Jrwis2fzJPaY5D2olQ
         jgmztFIyOwzFFJOSaACggZkPw/KCDXleetvmabaIS8emFUBhfk9WydbFd3Su/G32fOZj
         kLOPZ3WDlxiThWQGCfi0yo7KJdE4duQAUaHsHWf0+ImAAqv1XFFtkV+6CLofbZdVbOol
         1LQUHaJ9pGKpJTGtfOWGFg3+UxEqQVbAxWZx9UE/UH5umHzsOsACF8amomNTrFAPhXYm
         o24A==
X-Gm-Message-State: APjAAAXhB9LdQV+v3ZRvx4X6SB1oZkkfCpebejDzjOazvpYlA4uhazWo
        sp0ZrJKY8UqvrNPdMbOf4pE=
X-Google-Smtp-Source: APXvYqwThCSYyhpxpNvxFwMCUg5Eb+Cf0vqe6uTZOwvb8aCx2itCgLKEQC5TFVuZ4K/fEtk6lUt/HA==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr18841321pgc.8.1553640612009;
        Tue, 26 Mar 2019 15:50:12 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 8sm56937368pfs.50.2019.03.26.15.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:50:10 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH RFC/RFT 4/5] arm64: dma-mapping: Add fallback normal page allocations
Date:   Tue, 26 Mar 2019 15:49:58 -0700
Message-Id: <20190326224959.9656-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326224959.9656-1-nicoleotsuka@gmail.com>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
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

