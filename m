Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99647ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB3920872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbfJOPQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:16:56 -0400
Received: from 8bytes.org ([81.169.241.247]:47630 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfJOPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:16:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6EC60398; Tue, 15 Oct 2019 17:16:54 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] vfio/type1: Initialize resv_msi_base
Date:   Tue, 15 Oct 2019 17:16:50 +0200
Message-Id: <20191015151650.30788-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

After enabling CONFIG_IOMMU_DMA on X86 a new warning appears when
compiling vfio:

drivers/vfio/vfio_iommu_type1.c: In function ‘vfio_iommu_type1_attach_group’:
drivers/vfio/vfio_iommu_type1.c:1827:7: warning: ‘resv_msi_base’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   ret = iommu_get_msi_cookie(domain->domain, resv_msi_base);
   ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The warning is a false positive, because the call to iommu_get_msi_cookie()
only happens when vfio_iommu_has_sw_msi() returned true. And that only
happens when it also set resv_msi_base.

But initialize the variable anyway to get rid of the warning.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 96fddc1dafc3..d864277ea16f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1658,7 +1658,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	struct bus_type *bus = NULL;
 	int ret;
 	bool resv_msi, msi_remap;
-	phys_addr_t resv_msi_base;
+	phys_addr_t resv_msi_base = 0;
 	struct iommu_domain_geometry geo;
 	LIST_HEAD(iova_copy);
 	LIST_HEAD(group_resv_regions);
-- 
2.16.4

