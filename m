Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BD4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BAF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXEW98J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbfCZXBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:01:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46259 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbfCZXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:01:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so8739906pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uADFbodtyi76mzTIX2Xhd3f7QgEY+mxRgH7JdFV0yy0=;
        b=YXEW98J6zg2ngpdsbfxr6LvjKJrW33mB3hLFn3NjZUDubpqWmop2dMdcSWSvyphals
         7TiS+I8S0EO+f/8xgAKAa8RjMCdMxQMzFhh61XaYuVBMgclCGd0KIg+qAs6zK7YSCqtg
         uRPGdvIAycukBJ7HDxvb5wMH0fGXj5XEVIcBC+RewLu9Jnf6dCW1uhxu4WPJBADSR5Yc
         KGoiXFYQSdq11wARhbBhf22DLSqyjOSwrlOckPYB557DntfUEWvq2x4TybL6EYePmDyl
         PUacipS6FZTxJLVOprM6mCFCSxE2kXPH7GxaJBbz7p8lmHGMPjYoCfGy1JNVPGQm78WK
         oKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uADFbodtyi76mzTIX2Xhd3f7QgEY+mxRgH7JdFV0yy0=;
        b=ueOBWRehi5+TX+EWIlbtPqdDIoOtxplo2TmlDeexAmzcHa1boN82h3sjfsAni9CeyA
         bIXEDHCDaysuLkcX1c+pobelsghaEkJxDkvn1wfLToOgJNNHmN7IslRkAclSsLJPyEEH
         6MWKV39BXt0PrtZSBK6vvpNyGOkmhETb3OXMII7XcbER32UGOOfp9BmakoyOubn8ndcC
         NR7cj71xKXhi6o0NG2ViMDkgn53gBDOFL+6zjkEcQDodVz1d+9ttvy77xdGTCMoGIpYS
         K+dekIyALFoRMmMsxqdAuWxy/G68/QnPqu66Gei2VdJMDCfvjcxapf4odNIR1i+rDBuC
         wQaw==
X-Gm-Message-State: APjAAAV1umhb/Qs5HzRje01YWBBUKIo1HdZxL43MvDdKr4VLjiZ1qohR
        keBL1GsYOqxXjb1DrTsZzZ8=
X-Google-Smtp-Source: APXvYqzklxAL3HA3sAuQe2qJFq1XDkOl77Jl/JduYVAUyv9Beg8otfrvCX8qukeM8dQKVBZmt8Bt8A==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr28362977pfb.150.1553641299192;
        Tue, 26 Mar 2019 16:01:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n24sm43832587pfi.123.2019.03.26.16.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:01:38 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal page allocations
Date:   Tue, 26 Mar 2019 16:01:27 -0700
Message-Id: <20190326230131.16275-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a90f298af96..febaf637a25b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -589,6 +589,8 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	void *ptr = NULL;
 
 	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
+	if (!page)
+		page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
@@ -600,7 +602,8 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	if (PageHighMem(page)) {
 		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
 		if (!ptr) {
-			dma_release_from_contiguous(dev, page, count);
+			if (!dma_release_from_contiguous(dev, page, count))
+				__free_pages(page, get_order(size));
 			return NULL;
 		}
 	} else {
@@ -622,7 +625,8 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 		else
 			__dma_remap(page, size, PAGE_KERNEL);
 	}
-	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, get_order(size));
 }
 
 static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
@@ -1295,6 +1299,8 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 gfp & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(gfp, order);
 		if (!page)
 			goto error;
 
@@ -1369,7 +1375,8 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
 	int i;
 
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		dma_release_from_contiguous(dev, pages[0], count);
+		if (!dma_release_from_contiguous(dev, pages[0], count))
+			__free_pages(page[0], get_order(size));
 	} else {
 		for (i = 0; i < count; i++)
 			if (pages[i])
-- 
2.17.1

