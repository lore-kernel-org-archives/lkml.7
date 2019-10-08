Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB9AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4A5217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfJHOeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:34:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33290 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJHOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:34:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so25676615qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rEMMm6x48wipfHs8VZIqNwD7DIJGYzqO2JqQPWe5Vn4=;
        b=a1vueA6z5flhMIxxmIo3cauDbfAteqX0uHPypxye2h/yMYtKig22TyU6mrsXDuZLRK
         iCgVOoP2USA9bbeZzJ3ilj7r6WfZXqA9UGLBDU3qVaAzN5ApCG9HDCoEOFdB8lxfmMIc
         NYs4UED9+OPv2j19N5Hd25N6W/vTXzTxXQ8I6QsbCX2+lC2Yg2XxliyA8mJprzzBohJ6
         7eEFr3gfBw6wy3JPJvDV7tqE6x5TF6u5f5wfPYe7NB7+J3xnlM3EEiQk4a4985MwBBUq
         0SHFW+kWM4sM4B7t5UW/i27f3EXBTgUB49f2fi3SV1k3W/Vk+RO6u7SurUQQmEFsJOw7
         9a+Q==
X-Gm-Message-State: APjAAAW5MtdZyjP7yMDKOt3ZoEh+MFpbvbhGMvqEuS/aPtgx/dxa8zIL
        HYVBcGt8bY2SQ+WQ6disZja7H8E70/YmLg==
X-Google-Smtp-Source: APXvYqxXO5A9nvUR7/kxRQrlXjVff95blLbe3XPZSG5FKOiBQOLG+l+GrPxoFDEMZGR+0l0SfGGoLQ==
X-Received: by 2002:ac8:75cd:: with SMTP id z13mr34932892qtq.87.1570545239704;
        Tue, 08 Oct 2019 07:33:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q49sm13001806qta.60.2019.10.08.07.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 07:33:59 -0700 (PDT)
Date:   Tue, 8 Oct 2019 10:33:57 -0400
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191008143357.GA599223@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008072949.GA9452@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must return a mask covering the full physical RAM when bypassing the
IOMMU mapping. Also, in iommu_need_mapping, we need to check using
dma_direct_get_required_mask to ensure that the device's dma_mask can
cover physical RAM before deciding to bypass IOMMU mapping.

Fixes: 249baa547901 ("dma-mapping: provide a better default ->get_required_mask")
Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
Originally-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/iommu/intel-iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3f974919d3bd..79e35b3180ac 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3471,7 +3471,7 @@ static bool iommu_need_mapping(struct device *dev)
 		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
 			dma_mask = dev->coherent_dma_mask;
 
-		if (dma_mask >= dma_get_required_mask(dev))
+		if (dma_mask >= dma_direct_get_required_mask(dev))
 			return false;
 
 		/*
@@ -3775,6 +3775,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
+static u64 intel_get_required_mask(struct device *dev)
+{
+	if (!iommu_need_mapping(dev))
+		return dma_direct_get_required_mask(dev);
+	return DMA_BIT_MASK(32);
+}
+
 static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
@@ -3787,6 +3794,7 @@ static const struct dma_map_ops intel_dma_ops = {
 	.dma_supported = dma_direct_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
+	.get_required_mask = intel_get_required_mask,
 };
 
 static void
-- 
2.21.0
