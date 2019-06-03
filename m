Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F08BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A925D83
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9zxZmts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFCWxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:53:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34049 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:53:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so2651420pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SImWzVCSt0RY7OufuPO1jNvGlcFHu0kGaxSEDGg7OcE=;
        b=u9zxZmtsdOAxlFYnpVTvm0JmTl0e4S4V86dFQ2UjsLi92P4669mjO2pSvX8fp0M/yE
         NLzfTEjFlhV1T40UVu6TG/BVf4Dgj7BZcHNKpboNcN5MNLeRa7yesEiiJut//VM8p6uU
         I6yhjLE3LT3guizrMcvZkmA/3R0hOophx4mXn2Tlu1s/UMI0h5lXgAcb+NAIBhYJEnsQ
         6VhMteKCmfPCED4sqNNVKitrvY9YYki5KK6e/sbEchY8WK7sK3F3dg38qZe1cCwDIbfP
         YX6V4DQEdXPRC5BZky+wVe39CNXCssN7HHkz05GnkUr99VPuQ4MGvkkp2hyOEGn8pv5G
         lSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SImWzVCSt0RY7OufuPO1jNvGlcFHu0kGaxSEDGg7OcE=;
        b=DnICtNJ2q05wA8gG5/8AD70sRtUmhQNpPh7QxPUOoRoLPoJtQA12qecGf9M7ZmSzSS
         ANa25qO2uV1z6bIwrmbKgj4BrGlZ4t07KUANn9mIsJaESIs5XuiIJehVxIFGEKqbG6ki
         gxsr2El/JVEUSAkv2ncWyWgiomU81Np0MgWVIf6SMifKPqPkR4QtsnL1ao1Yv9fAY3b4
         Pdeq76B9ApLJeAKrQ1ha/lypFNda547VqO/cFR2giRgImQdGZJcJnl8sOvvD1WAyzrqd
         m1OBjlhmDr0wyhmGp+/apEvGR18kHOT5iZY8wLHGusA1WMNQ1vsat7eCX5Di2CtZuQZU
         +QFg==
X-Gm-Message-State: APjAAAVbBdEYTWIIuzac61QjjwG+R+Y5s29fMlxKLLyDBoYM4QXtMhcZ
        mpAv8j5MESkzKcQef5wiYJY=
X-Google-Smtp-Source: APXvYqy8vLrFqoVL7F3FzM+8IhTHjoTUjZBmrtxoEIRl8qi1kzL0djeX3jRrJKCsLT4K1CSdITr80g==
X-Received: by 2002:a63:5247:: with SMTP id s7mr21370699pgl.29.1559602382249;
        Mon, 03 Jun 2019 15:53:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j37sm7682759pgj.58.2019.06.03.15.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:53:01 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dma: Apply dma_{alloc,free}_contiguous functions
Date:   Mon,  3 Jun 2019 15:52:59 -0700
Message-Id: <20190603225259.21994-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces dma_{alloc,release}_from_contiguous() with
dma_{alloc,free}_contiguous() to simplify those function calls.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/dma-iommu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cd49c2d3770..cc3d39dbbe1a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -951,8 +951,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 
 	if (pages)
 		__iommu_dma_free_pages(pages, count);
-	if (page && !dma_release_from_contiguous(dev, page, count))
-		__free_pages(page, get_order(alloc_size));
+	if (page)
+		dma_free_contiguous(dev, page, alloc_size);
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
@@ -970,12 +970,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = NULL;
 	void *cpu_addr;
 
-	if (gfpflags_allow_blocking(gfp))
-		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
-						 get_order(alloc_size),
-						 gfp & __GFP_NOWARN);
-	if (!page)
-		page = alloc_pages(gfp, get_order(alloc_size));
+	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (!page)
 		return NULL;
 
@@ -997,8 +992,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	memset(cpu_addr, 0, alloc_size);
 	return cpu_addr;
 out_free_pages:
-	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
-		__free_pages(page, get_order(alloc_size));
+	dma_free_contiguous(dev, page, alloc_size);
 	return NULL;
 }
 
-- 
2.17.1

