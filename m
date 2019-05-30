Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E32C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20943218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190781;
	bh=D22WBElfsfKcrJroUrR87y58gP39ciTL7nqz0YFONb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXrRQamGStWapIgtvCMgfDSDHfHC6H7V0taZXA7CzbiDo1ZIkdKaXt/jBxe16kc6z
	 Ii4bn590vNoQBK/8hEB58Z1qm5B1FsM3UOutsM6r0fyksRt5SZVlg30JfkSUGefwwX
	 ScUbvxD01bU22G/b3F8HjznPjj3ZKA9qDG6ug340=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfE3Ec7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfE3DNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:33 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E330923D83;
        Thu, 30 May 2019 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186010;
        bh=D22WBElfsfKcrJroUrR87y58gP39ciTL7nqz0YFONb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpyFy4N7Hv7SICNXiMx2n6o2UbrdH7L5f0S6rhs6vDZ/QFK29xoxfaU7e7obIHOvi
         wXXjfIjf09DSG17N+uvBuzGjpo4TcOtaeuDFYiCxNOEqf5wIq7PX0fzw8wuv98f+rQ
         7JQZq3R4qpQTIjSDDeMdq5TInC4yM3n0Nq3OwpS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.0 015/346] arm64/iommu: handle non-remapped addresses in ->mmap and ->get_sgtable
Date:   Wed, 29 May 2019 20:01:28 -0700
Message-Id: <20190530030541.387385596@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
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


