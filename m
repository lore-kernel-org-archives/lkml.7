Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC35FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43B3206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfDCIgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:36:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfDCIgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:36:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [10.3.19.203])
        by Forcepoint Email with ESMTP id 111F3A9948F6DAC30530;
        Wed,  3 Apr 2019 16:36:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 16:36:25 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Jinyu Qi <jinyuqi@huawei.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/iova: Separate atomic variables to improve performance
Date:   Wed, 3 Apr 2019 16:35:21 +0800
Message-ID: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinyu Qi <jinyuqi@huawei.com> 

In struct iova_domain, there are three atomic variables, the former two
are about TLB flush counters which use atomic_add operation, anoter is
used to flush timer that use cmpxhg operation.
These variables are in the same cache line, so it will cause some
performance loss under the condition that many cores call queue_iova
function, Let's isolate the two type atomic variables to different
cache line to reduce cache line conflict.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jinyu Qi <jinyuqi@huawei.com>
---
 include/linux/iova.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 0b93bf96693e..28a5128405f8 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -76,6 +76,14 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	struct iova_fq __percpu *fq;	/* Flush Queue */
+
+	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
+						   have been started */
+
+	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
+						   have been finished */
+
 	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
@@ -85,14 +93,6 @@ struct iova_domain {
 	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor for
 					   iova entry */
 
-	struct iova_fq __percpu *fq;	/* Flush Queue */
-
-	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
-						   have been started */
-
-	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
-						   have been finished */
-
 	struct timer_list fq_timer;		/* Timer to regularily empty the
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
-- 
2.7.4

