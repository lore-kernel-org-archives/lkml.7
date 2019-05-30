Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251B9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E584D24996
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186455;
	bh=w0FNEcwamqYLDkj3GaVPl4jMvnrBDG1Rp3VxgMOjzwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNhqtUbGdX31JvxaedKRGmKD82eXlsevPHMmLabtcQo0QbHx7N5O9+ly8NgESjSB8
	 dzd8SVxJbjLjBTtn8IyAYWmHHBnscZSmalxV92Ycpq/xWvd2j4HL/MI/7wKBGCaWGY
	 RxZNgGF0NjEc0iekXMPI8e13IgQ9QmscXqPCC5sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfE3DUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbfE3DQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:05 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA952455E;
        Thu, 30 May 2019 03:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186164;
        bh=w0FNEcwamqYLDkj3GaVPl4jMvnrBDG1Rp3VxgMOjzwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgGItlKffiEnG6L/MXKFJ1fxmRg4z9BaYF2Lsjfn9ALsjjAngO7+mXSDJc9v4EuCj
         Jqxm26eGaoZGL7gD8rQ7DHKChq518PuJMwn8D/DPaD8tofCP5rS+Fs1+erSIgi4QmI
         cdxC935e1kWurXV0KAhTGgqbWspEPFyp3mo+A7fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 015/276] arm64/iommu: handle non-remapped addresses in ->mmap and ->get_sgtable
Date:   Wed, 29 May 2019 20:02:53 -0700
Message-Id: <20190530030524.868919123@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
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
@@ -664,6 +664,11 @@ static int __iommu_mmap_attrs(struct dev
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
@@ -687,6 +692,11 @@ static int __iommu_get_sgtable(struct de
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


