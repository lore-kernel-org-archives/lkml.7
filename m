Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C02C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87112075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVveUJyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfCZWu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:50:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46347 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbfCZWuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:50:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so2323954pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nSqLKLQoUDGkS6WO6/0mqXSeMgP/CMmbaNUycpN9yEE=;
        b=ZVveUJyfJtWMiRM4wzAvSqvIrGb5Uc4l2fO8VFBJijcJW7PWGpQb8oVHdGr0AoCgDE
         3A6CC9+a+wrgLm2xlITj6BH4POxgy856dcYoulSSjYKNcRXv/P/8Pdps5oSzikhA3+KD
         Nr6ybuvCcvEAfUO4Aj/nP6wiVfwmPGk5vp1NMOYeKrE1mfER2xMRG891B1EcnUjv+0QL
         1PV0iOoeyf52M2f3f3oe//dlwFLXILaoVIDLaEM5YS83vmVbGZXfpHZhknITyT400jI9
         Bo+MqtKKdeKLLchEHs8DWIbTTI4kTFMoX5odJYfHaP53mgCJyyhjufaKI+yUrmlmcpm6
         naiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nSqLKLQoUDGkS6WO6/0mqXSeMgP/CMmbaNUycpN9yEE=;
        b=eawzAInfLi49daNTTOfxkJmPZNUg+n4lVX+r4I3+ELPSKx+62V9Z1W+rC9QhMnk9b2
         xHxUIUxcBE75oE87jAykGUMLZlm2HpO5ZfpePzV+RWhFWBikc4zZ5ZNjKysmj9YDhEqL
         gtvDOGlc2YCu8J4mkxeIaoV5n4YhFjkKvnzG5VjJH/r5YqvfCayB3ETgAmHwDvWq5lEe
         PSBa6rdiRcQ6l3n14LjNPnPzM++B0EaQ/oh1LEegxhtfY6UfLNSk4yZ8j7SSmWsVo05d
         igCZUGyANCdd0yZ+R+P1+R26pPsg7djX9J86kxiNvPFD09Qt/dKuCBL9QzD5mCLcpKDX
         z8Ew==
X-Gm-Message-State: APjAAAWyVcM/oddS9wKadE4jwJjOnng/r6IPB8TprSh+Ppt5l4kOkUMu
        INuBUBb+Cw3AUsOJ4FXUQRI=
X-Google-Smtp-Source: APXvYqwmClTzI7FvtAmxZGjK3gY6Chb0F1x05w8JRFZiw+0qSexX6YaMke6VFqQXamPljAAhWjWM2A==
X-Received: by 2002:a17:902:846:: with SMTP id 64mr33494874plk.266.1553640609222;
        Tue, 26 Mar 2019 15:50:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 8sm56937368pfs.50.2019.03.26.15.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:50:08 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH RFC/RFT 2/5] dma-remap: Run alloc_pages() on failure
Date:   Tue, 26 Mar 2019 15:49:56 -0700
Message-Id: <20190326224959.9656-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326224959.9656-1-nicoleotsuka@gmail.com>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area.

So this patch moves the alloc_pages() call to the fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/remap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 2b750f13bc8f..daab2f3186a2 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -116,7 +116,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 	if (dev_get_cma_area(NULL))
 		page = dma_alloc_from_contiguous(NULL, nr_pages,
 						 pool_size_order, false);
-	else
+	if (!page)
 		page = alloc_pages(gfp, pool_size_order);
 	if (!page)
 		goto out;
-- 
2.17.1

