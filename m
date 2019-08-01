Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7045FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C59720665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfHAMWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:22:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728217AbfHAMWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:22:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00C158748E0FA7FF6A83;
        Thu,  1 Aug 2019 20:22:27 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 20:22:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] iommu/iova: introduce iova_magazine_compact_pfns()
Date:   Thu, 1 Aug 2019 20:21:53 +0800
Message-ID: <20190801122154.18820-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iova_magazine_free_pfns() can only free the whole magazine buffer, add
iova_magazine_compact_pfns() to support free part of it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 3e1a8a6755723a9..4b7a9efa0ef40af 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -795,18 +795,19 @@ static void iova_magazine_free(struct iova_magazine *mag)
 	kfree(mag);
 }
 
-static void
-iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
+static void iova_magazine_compact_pfns(struct iova_magazine *mag,
+				       struct iova_domain *iovad,
+				       unsigned long newsize)
 {
 	unsigned long flags;
 	int i;
 
-	if (!mag)
+	if (!mag || mag->size <= newsize)
 		return;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 
-	for (i = 0 ; i < mag->size; ++i) {
+	for (i = newsize; i < mag->size; ++i) {
 		struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
 
 		BUG_ON(!iova);
@@ -815,7 +816,13 @@ static void iova_magazine_free(struct iova_magazine *mag)
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
-	mag->size = 0;
+	mag->size = newsize;
+}
+
+static void
+iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
+{
+	iova_magazine_compact_pfns(mag, iovad, 0);
 }
 
 static bool iova_magazine_full(struct iova_magazine *mag)
-- 
1.8.3


