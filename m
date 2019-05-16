Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7BAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070BE2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEPKI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1C1B3EDBF;
        Thu, 16 May 2019 10:08:54 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E062D6266C;
        Thu, 16 May 2019 10:08:51 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v3 7/7] iommu/vt-d: Differentiate relaxable and non relaxable RMRRs
Date:   Thu, 16 May 2019 12:08:17 +0200
Message-Id: <20190516100817.12076-8-eric.auger@redhat.com>
In-Reply-To: <20190516100817.12076-1-eric.auger@redhat.com>
References: <20190516100817.12076-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 16 May 2019 10:08:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
region type, let's report USB and GFX RMRRs as relaxable ones.

This allows to have a finer reporting at IOMMU API level of
reserved memory regions. This will be exploitable by VFIO to
define the usable IOVA range and detect potential conflicts
between the guest physical address space and host reserved
regions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a36604f4900f..af1d65fdedfc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5493,7 +5493,9 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	for_each_rmrr_units(rmrr) {
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, i_dev) {
+			struct pci_dev *pdev = to_pci_dev(device);
 			struct iommu_resv_region *resv;
+			enum iommu_resv_type type;
 			size_t length;
 
 			if (i_dev != device &&
@@ -5501,9 +5503,13 @@ static void intel_iommu_get_resv_regions(struct device *device,
 				continue;
 
 			length = rmrr->end_address - rmrr->base_address + 1;
+
+			type = (pdev &&
+				(IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))) ?
+				IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
+
 			resv = iommu_alloc_resv_region(rmrr->base_address,
-						       length, prot,
-						       IOMMU_RESV_DIRECT,
+						       length, prot, type,
 						       GFP_ATOMIC);
 			if (!resv)
 				break;
-- 
2.20.1

