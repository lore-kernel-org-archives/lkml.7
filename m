Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72705C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7C020855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369026;
	bh=d5RwVlPz9BmFcnVJtSY8fE+nDJ8BYaCSDn8bRU/Ws5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hU/UlIoKC1D1vZZDECPOgPZ/XBQjLHAnG0LORHzwACyhmLHjcGS06aTCiUT8Pmf78
	 aCRKKyTjOSuuJqcUqf7+X/d4kWORI11rzlySAgCImZ+BOP/DZJ5ehwMzQ7mqX2e9pf
	 tS3RtI9QQQwP1nAns6X4shkzTTvEwRYVH04td1gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfDDJKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbfDDJKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52EAD20652;
        Thu,  4 Apr 2019 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369022;
        bh=d5RwVlPz9BmFcnVJtSY8fE+nDJ8BYaCSDn8bRU/Ws5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXg5U/VACwp782cfcyD4TyuyWd0eVA/GJGtbk3NnI9cK5RYKx5BVUgQwR0r5AQk9U
         XAYz3mgYg+yhyUz6w88+EVnpelIG3e+HfgclitPaONXXufTmCOBv/um8HjvEd+P0lf
         YrNYEjvOPokh47SBV5hFlixJPWboq7zTrUK5OXzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 052/246] iommu/vt-d: Disable ATS support on untrusted devices
Date:   Thu,  4 Apr 2019 10:45:52 +0200
Message-Id: <20190404084620.839695349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d8b8591054575f33237556c32762d54e30774d28 ]

Commit fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted
devices") disables ATS support on the devices which have been marked
as untrusted. Unfortunately this is not enough to fix the DMA attack
vulnerabiltiies because IOMMU driver allows translated requests as
long as a device advertises the ATS capability. Hence a malicious
peripheral device could use this to bypass IOMMU.

This disables the ATS support on untrusted devices by clearing the
internal per-device ATS mark. As the result, IOMMU driver will block
any translated requests from any device marked as untrusted.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..dbd6824dfffa 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2485,7 +2485,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pci_ats_disabled() &&
+		if (!pdev->untrusted &&
+		    !pci_ats_disabled() &&
 		    ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
 		    dmar_find_matched_atsr_unit(pdev))
-- 
2.19.1



