Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281542171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCLJRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:17:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfCLJRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:17:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF2959199FD84517F0F2;
        Tue, 12 Mar 2019 17:17:15 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 17:17:06 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <linux@armlinux.org.uk>, <akpm@linux-foundation.org>,
        <robin.murphy@arm.com>, <iamjoonsoo.kim@lge.com>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ARM: dma-mapping: always clear allocated buffers in __alloc_from_pool
Date:   Tue, 12 Mar 2019 17:16:37 +0800
Message-ID: <20190312091637.16412-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Like commit 518a2f1925c3 ("dma-mapping: zero memory returned
from dma_alloc_*"), if we want to map memory from the DMA
allocator to userspace it must be zeroed at allocation time 
to prevent stale data leaks. On arm platform, if the allocator
is pool_allocator in __dma_alloc, then the mem is alloced by
__alloc_from_pool, which also need be zeroed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a90f29..28ad6d5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -558,6 +558,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 
 		*ret_page = phys_to_page(phys);
 		ptr = (void *)val;
+		memset(ptr, 0, size);
 	}
 
 	return ptr;
-- 
2.7.0


