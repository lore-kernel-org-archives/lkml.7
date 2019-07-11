Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACF5C74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfGKOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:18:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbfGKOS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:18:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50C1B3222C970C39F9BC;
        Thu, 11 Jul 2019 22:18:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 22:18:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <aik@ozlabs.ru>,
        <david@gibson.dropbear.id.au>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/powernv/ioda: using kfree_rcu() to simplify the code
Date:   Thu, 11 Jul 2019 22:18:18 +0800
Message-ID: <20190711141818.18044-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback function of call_rcu() just calls a kfree(), so we
can use kfree_rcu() instead of call_rcu() + callback function.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index e28f03e..05f80b1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -332,14 +332,6 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	return -ENOMEM;
 }
 
-static void pnv_iommu_table_group_link_free(struct rcu_head *head)
-{
-	struct iommu_table_group_link *tgl = container_of(head,
-			struct iommu_table_group_link, rcu);
-
-	kfree(tgl);
-}
-
 void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
 		struct iommu_table_group *table_group)
 {
@@ -355,7 +347,7 @@ void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
 	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
 		if (tgl->table_group == table_group) {
 			list_del_rcu(&tgl->next);
-			call_rcu(&tgl->rcu, pnv_iommu_table_group_link_free);
+			kfree_rcu(tgl, rcu);
 			found = true;
 			break;
 		}
-- 
2.7.4


