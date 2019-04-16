Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAFCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F4F2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfDPOuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:50:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728759AbfDPOuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:50:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C5372D550CFA91E781BA;
        Tue, 16 Apr 2019 22:50:02 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:49:55 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <konrad.wilk@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>, <sstabellini@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <xen-devel@lists.xenproject.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] xen-swiotlb: Make two functions static
Date:   Tue, 16 Apr 2019 22:49:50 +0800
Message-ID: <20190416144950.37952-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

drivers/xen/swiotlb-xen.c:489:1: warning:
 symbol 'xen_swiotlb_sync_single_for_cpu' was not declared. Should it be static?
drivers/xen/swiotlb-xen.c:496:1: warning:
 symbol 'xen_swiotlb_sync_single_for_device' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2..e741df4 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -485,14 +485,14 @@ xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
 }
 
-void
+static void
 xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 				size_t size, enum dma_data_direction dir)
 {
 	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
 
-void
+static void
 xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir)
 {
-- 
2.7.4


