Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C3214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053796;
	bh=Xns1XgUtYzxGuEKYCRNoBKUoznyUt6ybGwnqXsKktyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Npf0rXux+tGic8wX+Y24jBGccuBpmiV73/R2OEo2BOGdmhW6HSOicI540vp4daxSQ
	 zuTBAky4WqIyj6Drbp5ATiRHpyZMf8QQVu+66kix6Mw7q3tmSiUj7MQlxOSz3hn7Xh
	 DrslJ7nECLbIINvbSN0djXHX2KUA9W1kCZGdUksg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfFTSDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfFTSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:03:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F64421479;
        Thu, 20 Jun 2019 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053789;
        bh=Xns1XgUtYzxGuEKYCRNoBKUoznyUt6ybGwnqXsKktyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6RSx9DMpl9ObjB1mM4pKWSWJOmXcj6afVkWNdOF6LcB5a3rbsBuxHGjTR7sGJAkS
         /N/sQ/+QKxKWA1QiC58lmtpxwI8jUTZnryxFt1KBwAmsHX9gdqmkPFaQ/OmION4KXC
         pavqhBv6+0y5v4R3m5xCY74eTaxSvn8vQscp6yII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 028/117] iommu/vt-d: Set intel_iommu_gfx_mapped correctly
Date:   Thu, 20 Jun 2019 19:56:02 +0200
Message-Id: <20190620174353.668773554@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cf1ec4539a50bdfe688caad4615ca47646884316 ]

The intel_iommu_gfx_mapped flag is exported by the Intel
IOMMU driver to indicate whether an IOMMU is used for the
graphic device. In a virtualized IOMMU environment (e.g.
QEMU), an include-all IOMMU is used for graphic device.
This flag is found to be clear even the IOMMU is used.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Reported-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Fixes: c0771df8d5297 ("intel-iommu: Export a flag indicating that the IOMMU is used for iGFX.")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28feb1744710..25cc6ae87039 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4119,9 +4119,7 @@ static void __init init_no_remapping_devices(void)
 
 		/* This IOMMU has *only* gfx devices. Either bypass it or
 		   set the gfx_mapped flag, as appropriate */
-		if (dmar_map_gfx) {
-			intel_iommu_gfx_mapped = 1;
-		} else {
+		if (!dmar_map_gfx) {
 			drhd->ignored = 1;
 			for_each_active_dev_scope(drhd->devices,
 						  drhd->devices_cnt, i, dev)
@@ -4870,6 +4868,9 @@ int __init intel_iommu_init(void)
 		goto out_free_reserved_range;
 	}
 
+	if (dmar_map_gfx)
+		intel_iommu_gfx_mapped = 1;
+
 	init_no_remapping_devices();
 
 	ret = init_dmars();
-- 
2.20.1



