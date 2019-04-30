Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEECC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A0B21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfD3HaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3HaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08FF23082E70;
        Tue, 30 Apr 2019 07:30:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91784183E2;
        Tue, 30 Apr 2019 07:30:10 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     dwmw2@infradead.org
Subject: [PATCH] iommu/vt-d: Fix leak in intel_pasid_alloc_table on error path
Date:   Tue, 30 Apr 2019 09:30:04 +0200
Message-Id: <20190430073004.10528-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 30 Apr 2019 07:30:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If alloc_pages_node() fails, pasid_table is leaked. Free it.

Fixes: cc580e41260db ("iommu/vt-d: Per PCI device pasid table interfaces")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-pasid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 03b12d2ee213..2fefeafda437 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -154,8 +154,10 @@ int intel_pasid_alloc_table(struct device *dev)
 	order = size ? get_order(size) : 0;
 	pages = alloc_pages_node(info->iommu->node,
 				 GFP_KERNEL | __GFP_ZERO, order);
-	if (!pages)
+	if (!pages) {
+		kfree(pasid_table);
 		return -ENOMEM;
+	}
 
 	pasid_table->table = page_address(pages);
 	pasid_table->order = order;
-- 
2.20.1

