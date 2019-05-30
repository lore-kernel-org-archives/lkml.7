Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7DEC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8702260B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192439;
	bh=D22WBElfsfKcrJroUrR87y58gP39ciTL7nqz0YFONb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oVtDnv+OzTVEMxqsyO8ovG2yU9+f0Y+DooSsnzYpuTKde+IkeIgUB25/WLl43meEa
	 ZltpIb7iluDn/5/ZFPQxbWPyoovzyp2WxO3n4fTxQ2tjqEwvWw8rFNWFlGK0RNpiYd
	 qX+AFw7DmZhzVQtQtW7pKYo64wX2y83uLkZ4kGQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfE3FAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfE3DJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:30 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3399024485;
        Thu, 30 May 2019 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185770;
        bh=D22WBElfsfKcrJroUrR87y58gP39ciTL7nqz0YFONb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfhsxlQm6qwOvsCoHHyNQzD71SocWn9Cmb40ovdPWDWfBEGCjChj6WckNpMLSeZlM
         xVJx2Irw0pAGtPi4K2PZMYiiUxhb8lwuDfBR5TLcxWLmbgJ3ax1hBlnCaXZINmGCov
         0p1f1E6IjIswsx+Cbd3SbpRqIfA+ePncWbqXKYjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.1 021/405] arm64/iommu: handle non-remapped addresses in ->mmap and ->get_sgtable
Date:   Wed, 29 May 2019 20:00:19 -0700
Message-Id: <20190530030541.674075690@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit a98d9ae937d256ed679a935fc82d9deaa710d98e upstream.

DMA allocations that can't sleep may return non-remapped addresses, but
we do not properly handle them in the mmap and get_sgtable methods.
Resolve non-vmalloc addresses using virt_to_page to handle this corner
case.

Cc: <stable@vger.kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/dma-mapping.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -249,6 +249,11 @@ static int __iommu_mmap_attrs(struct dev
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
+	if (!is_vmalloc_addr(cpu_addr)) {
+		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
+		return __swiotlb_mmap_pfn(vma, pfn, size);
+	}
+
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		/*
 		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
@@ -272,6 +277,11 @@ static int __iommu_get_sgtable(struct de
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
+	if (!is_vmalloc_addr(cpu_addr)) {
+		struct page *page = virt_to_page(cpu_addr);
+		return __swiotlb_get_sgtable_page(sgt, page, size);
+	}
+
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		/*
 		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,


