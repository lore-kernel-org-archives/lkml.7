Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A30C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685002083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCSOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:50:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbfCSOu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:50:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D22A8398B73B5E98FBEF;
        Tue, 19 Mar 2019 22:50:52 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 22:50:51 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <alex.williamson@redhat.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vfio/spapr_tce: Make symbol 'tce_iommu_driver_ops' static
Date:   Wed, 20 Mar 2019 02:47:23 -0400
Message-ID: <20190320064723.46604-1-wanghai26@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/vfio/vfio_iommu_spapr_tce.c:1401:36: warning:
 symbol 'tce_iommu_driver_ops' was not declared. Should it be static?

Fixes: 5ffd229c0273 ("powerpc/vfio: Implement IOMMU driver for VFIO")
Signed-off-by: Wang Hai <wanghai26@huawei.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 8dbb270..6b64e45 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1398,7 +1398,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 	mutex_unlock(&container->lock);
 }
 
-const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
+static const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
 	.name		= "iommu-vfio-powerpc",
 	.owner		= THIS_MODULE,
 	.open		= tce_iommu_open,
-- 
1.8.3.1

