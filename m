Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27E8C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C5120578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfEMHN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46669 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfEMHNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:13:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E417B30821FF;
        Mon, 13 May 2019 07:13:24 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C593844;
        Mon, 13 May 2019 07:13:22 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com
Subject: [PATCH 4/4] iommu/vt-d: Handle PCI bridge RMRR device scopes in intel_iommu_get_resv_regions
Date:   Mon, 13 May 2019 09:13:02 +0200
Message-Id: <20190513071302.30718-5-eric.auger@redhat.com>
In-Reply-To: <20190513071302.30718-1-eric.auger@redhat.com>
References: <20190513071302.30718-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 13 May 2019 07:13:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case the RMRR device scope is a PCI-PCI bridge, let's check
the device belongs to the PCI sub-hierarchy.

Fixes: 0659b8dc45a6 ("iommu/vt-d: Implement reserved region get/put callbacks")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 89d82a1d50b1..9c1a765eca8b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5289,7 +5289,8 @@ static void intel_iommu_get_resv_regions(struct device *device,
 			struct iommu_resv_region *resv;
 			size_t length;
 
-			if (i_dev != device)
+			if (i_dev != device &&
+			    !is_downstream_to_pci_bridge(device, i_dev))
 				continue;
 
 			length = rmrr->end_address - rmrr->base_address + 1;
-- 
2.20.1

