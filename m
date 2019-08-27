Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF806C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBC72077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfH0MuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:50:05 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54139 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfH0MuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:50:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TacAofi_1566910188;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TacAofi_1566910188)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 20:49:54 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     alex.williamson@redhat.com, cohuck@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] vfio/type1: avoid redundant PageReserved checking
Date:   Tue, 27 Aug 2019 20:49:48 +0800
Message-Id: <3e892a6bdaa069a6e79c50208bd01cab8c9588ac.1566910119.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently, if the page is not a tail of compound page, it will be
checked twice for the same thing.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f..cbe0d88 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 static bool is_invalid_reserved_pfn(unsigned long pfn)
 {
 	if (pfn_valid(pfn)) {
-		bool reserved;
 		struct page *tail = pfn_to_page(pfn);
 		struct page *head = compound_head(tail);
-		reserved = !!(PageReserved(head));
 		if (head != tail) {
+			bool reserved = !!(PageReserved(head));
 			/*
 			 * "head" is not a dangling pointer
 			 * (compound_head takes care of that)
@@ -310,7 +309,7 @@ static bool is_invalid_reserved_pfn(unsigned long pfn)
 			if (PageTail(tail))
 				return reserved;
 		}
-		return PageReserved(tail);
+		return !!(PageReserved(tail));
 	}
 
 	return true;
-- 
1.8.3.1

