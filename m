Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFEFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D102077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDIRxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDIRxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AC7B88AB7;
        Tue,  9 Apr 2019 17:53:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68FE717AB5;
        Tue,  9 Apr 2019 17:53:45 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm/hmm: fix hmm_range_dma_map()/hmm_range_dma_unmap()
Date:   Tue,  9 Apr 2019 13:53:40 -0400
Message-Id: <20190409175340.26614-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 09 Apr 2019 17:53:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Was using wrong field and wrong enum for read only versus read and
write mapping.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/hmm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 90369fd2307b..ecd16718285e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1203,7 +1203,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 
 	npages = (range->end - range->start) >> PAGE_SHIFT;
 	for (i = 0, mapped = 0; i < npages; ++i) {
-		enum dma_data_direction dir = DMA_FROM_DEVICE;
+		enum dma_data_direction dir = DMA_TO_DEVICE;
 		struct page *page;
 
 		/*
@@ -1227,7 +1227,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 		}
 
 		/* If it is read and write than map bi-directional. */
-		if (range->pfns[i] & range->values[HMM_PFN_WRITE])
+		if (range->pfns[i] & range->flags[HMM_PFN_WRITE])
 			dir = DMA_BIDIRECTIONAL;
 
 		daddrs[i] = dma_map_page(device, page, 0, PAGE_SIZE, dir);
@@ -1243,7 +1243,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 
 unmap:
 	for (npages = i, i = 0; (i < npages) && mapped; ++i) {
-		enum dma_data_direction dir = DMA_FROM_DEVICE;
+		enum dma_data_direction dir = DMA_TO_DEVICE;
 		struct page *page;
 
 		page = hmm_device_entry_to_page(range, range->pfns[i]);
@@ -1254,7 +1254,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 			continue;
 
 		/* If it is read and write than map bi-directional. */
-		if (range->pfns[i] & range->values[HMM_PFN_WRITE])
+		if (range->pfns[i] & range->flags[HMM_PFN_WRITE])
 			dir = DMA_BIDIRECTIONAL;
 
 		dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
@@ -1298,7 +1298,7 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 
 	npages = (range->end - range->start) >> PAGE_SHIFT;
 	for (i = 0; i < npages; ++i) {
-		enum dma_data_direction dir = DMA_FROM_DEVICE;
+		enum dma_data_direction dir = DMA_TO_DEVICE;
 		struct page *page;
 
 		page = hmm_device_entry_to_page(range, range->pfns[i]);
@@ -1306,7 +1306,7 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 			continue;
 
 		/* If it is read and write than map bi-directional. */
-		if (range->pfns[i] & range->values[HMM_PFN_WRITE]) {
+		if (range->pfns[i] & range->flags[HMM_PFN_WRITE]) {
 			dir = DMA_BIDIRECTIONAL;
 
 			/*
-- 
2.20.1

