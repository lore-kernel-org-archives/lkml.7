Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646162075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvDsmFx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfCZWuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:50:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39869 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbfCZWuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:50:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so8754910pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uADFbodtyi76mzTIX2Xhd3f7QgEY+mxRgH7JdFV0yy0=;
        b=EvDsmFx9nuzUTBrHdOWJWjUIPzIu41Xn0U30foyGliVRBJqfitnwfk2hJS3G6tGuxS
         uYtVVjCfNOdxq7QhC5Qpr4yhe+VjhWKvgo+jPL5My6eVGqAI8PkUplK8khP+3cp967do
         2GpK5aU5QFUjL1HJvWkOW7CAm+EU8wDn3hHg5XehJEnmqekDrBzcqVw9yky9syLoz8Rx
         pUkDYjqGlaCH5WNy/KEu9PES1s6fqgT45QnsJc6S3/2KgGnDwK8VKxsHKWBl7qsRlP7g
         bOcrzH72lC6JSE91zxuttQVhRZKQTaas5w1E9i+uaNnIGztd96CEAI58OzRLVYmRTAD2
         vjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uADFbodtyi76mzTIX2Xhd3f7QgEY+mxRgH7JdFV0yy0=;
        b=Bq1YymBnSgNA8XpLD+lb9afLj34Hm6kk7qHli68IxQHJj+pxwE5qG6FEA+erp6m/6u
         L17icjL1tSZOtUZB9Q96o2T08s2hs0cfpwfLLUbTiycAmfIpAw9fsTUM00iQBf0nIbtn
         8Lj8QvylJLubyZ7CM1Pht1d8QcYL0JkcltAhGpoquSKrZNVSeDVfFZVtH6Cx8Kl1vcdc
         WzhsjPekb3wSSe/MH1WjMQWvLtfwfIEppoKIE9cGpY0y9rU7YzoVuVsiCSKKHDUD7dAg
         JwMNHbHwZpbYfRviaAdA8iTmEYdRkV8EhIS/+1H2Yk3FC0V+9Y9bwB4DPYdosdLiKzsT
         jY/Q==
X-Gm-Message-State: APjAAAUEQ4ZODL/G0jz0l0Peiy+vm6fu3bHfAa16B0YvcVthp5/AuWBI
        X8+sJ+akHEfaUGu051CY5hI=
X-Google-Smtp-Source: APXvYqxXIqzjWYVrB3+n7+8C14DJI/QFIHAGZaOed/jWzUdScSQW52wDYo5nXaVGZn24F+emSmeXEw==
X-Received: by 2002:aa7:8a87:: with SMTP id a7mr33152903pfc.252.1553640607850;
        Tue, 26 Mar 2019 15:50:07 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 8sm56937368pfs.50.2019.03.26.15.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:50:07 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal page allocations
Date:   Tue, 26 Mar 2019 15:49:55 -0700
Message-Id: <20190326224959.9656-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326224959.9656-1-nicoleotsuka@gmail.com>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
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

