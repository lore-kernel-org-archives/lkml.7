Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689D22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M87On/OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfD3CCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:02:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42827 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3CCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:02:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so6249746pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8UYDA0A35ZvIDjqUXHlnj64LOZDrFMTPlT84kyIZ/A=;
        b=M87On/OVQyBg+MT1fVPE7dKNwirCzXjLqib8e9Rziw1Ivr/4fR4X+fNYh7Z6Q7F582
         9l6GJBGPMqJqDugoryFUtON6Rziuv8o26pwNLS1Gkeqe4XaanoSK/EuQcmYltcUFjj1j
         rApDbk9/KkrxFqAqefRKrCatfUmoW/xFrSBF5Zl6ZaCffNYX4fuHXBSllNEcbp1fyXSy
         XY//ob5MYUHZZ6zVoCf+wezYjw9eeQNrLgq0Y+YMCYYbPnrh9scxIyGMB0cp+3R1f6nV
         r+mw+cUCZj0+/w5ylx8X+5oXwyKyvtA87jgmz5NmzWWzw7bGJL94m5dvcxkkFAjNucsm
         gHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8UYDA0A35ZvIDjqUXHlnj64LOZDrFMTPlT84kyIZ/A=;
        b=VpQzMv/JyaL9Lb63Y25Us7WMKtA5VecOwTIf4NlzC4ixocGXTShRcTBw6378o0tcgL
         BRyvJBzPrnEVfQcNa+J5BFmgN53164KRWwxRf65vn1Ylp6i0MDcSS+ko/hUt007mlv9W
         qIbtTNdT9FXPUHJDvp3x0BUIpIUojGE9lZVlLlHNWaUW+PkwQBTf0NqBVndVJmATEmUu
         63g/mqhLHJMdnX6gFfYpvgneKL1pT9e5LjdRka6p5gUW99YA+FFvSWHyEyJh7E69uhxi
         Csqjbvx+z8xyLb+234d55ML0SJEa9LlMJO9YfMQJSvLwhrTNS52ct4Qo/Yv8ICbOpxbt
         fdFQ==
X-Gm-Message-State: APjAAAXq7Gz2Eac2cuz3uoOq6zsx+V5k7gp149j/tMcntrT5kNVtSnns
        V+A4lx30Iv6CgzcLzBH2ndU=
X-Google-Smtp-Source: APXvYqzD4hPvjqmWE2q801NZMH8qACSDt5uAhDTlNqVfP4C95RfP3OVEnzocGAEnXIXXblyEUKqGYg==
X-Received: by 2002:a63:8741:: with SMTP id i62mr12431618pge.313.1556589423757;
        Mon, 29 Apr 2019 18:57:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a12sm36918995pgq.21.2019.04.29.18.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:57:03 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: [RFC/RFT PATCH 2/2] dma-contiguous: Use fallback alloc_pages for single pages
Date:   Mon, 29 Apr 2019 18:55:21 -0700
Message-Id: <20190430015521.27734-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430015521.27734-1-nicoleotsuka@gmail.com>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to use the fallback alloc_pages path, instead of
one-page size allocations from the global CMA area in case that a
device does not have its own CMA area. This'd save resources from
the CMA global area for more CMA allocations, and also reduce CMA
fragmentations resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index afe5a673668e..71aba1551275 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,14 +186,23 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  * This function allocates contiguous memory buffer for specified device. It
  * first tries to use device specific contiguous memory area if available or
  * the default global one, then tries a fallback allocation of normal pages.
+ *
+ * Note that it byapss one-page size of allocations from the global area as
+ * the addresses within one page are always contiguous, so there is no need
+ * to waste CMA pages for that kind; it also helps reduce fragmentations.
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t align = get_order(PAGE_ALIGN(size));
-	struct cma *cma = dev_get_cma_area(dev);
 	struct page *page = NULL;
+	struct cma *cma = NULL;
+
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
-- 
2.17.1

