Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1269C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09C02080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfD3H3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3H3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08E7C821E5;
        Tue, 30 Apr 2019 07:29:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F72B61525;
        Tue, 30 Apr 2019 07:29:46 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     dwmw2@infradead.org
Subject: [PATCH] iommu/vt-d: Fix intel_pasid_max_id
Date:   Tue, 30 Apr 2019 09:29:40 +0200
Message-Id: <20190430072940.10467-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 30 Apr 2019 07:29:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended Capability Register PSS field (PASID Size Supported)
corresponds to the PASID bit size -1.

"A value of N in this field indicates hardware supports PASID
field of N+1 bits (For example, value of 7 in this field,
indicates 8-bit PASIDs are supported)".

Fix the computation of intel_pasid_max_id accordingly.

Fixes: 562831747f62 ("iommu/vt-d: Global PASID name space")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713d728c..c3f1bfc81d2e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3331,7 +3331,7 @@ static int __init init_dmars(void)
 		 * than the smallest supported.
 		 */
 		if (pasid_supported(iommu)) {
-			u32 temp = 2 << ecap_pss(iommu->ecap);
+			u32 temp = 2 << (ecap_pss(iommu->ecap) + 1);
 
 			intel_pasid_max_id = min_t(u32, temp,
 						   intel_pasid_max_id);
-- 
2.20.1

