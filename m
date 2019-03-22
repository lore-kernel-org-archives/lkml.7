Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B73C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAE5218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253776;
	bh=zmEg1I8HcG+p5HlgBPXh83MTtzguc8QtMeFWP5vbOZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ym9PhSzwr3DkhBt4GP+p3SM8zT9G2E8O1OUYoKRZ+Z4oAHV2Q9npGO///5eQF+KMJ
	 FyVNuUGuDTjml/Ih5lfGRhcKOgtyuM2fg632wAz7187H4TeF+7jWz1tScjpvHUNui0
	 hDCWIQKD88/mLxzuPYrRx4unwZ+TelnulShwn5Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfCVLWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfCVLWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:22:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409DA218A2;
        Fri, 22 Mar 2019 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253768;
        bh=zmEg1I8HcG+p5HlgBPXh83MTtzguc8QtMeFWP5vbOZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dgxes5h79lRa+wYw1FyEiuXkR3fm/KwtqVdgF8MRRQgn8cdRElivS9Uxtk1jFX+6u
         5dTNehlyw8ZIohpNVhHIYPRKXQ95bfMb51NRaHYjiKdiEXOSJoURgBmLpjVHR9X8ZY
         mxFtDyeKw1tVCNoxlqJqk3minsyrFIlXz8VVhKYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 058/134] iommu/amd: Fix IOMMU page flush when detach device from a domain
Date:   Fri, 22 Mar 2019 12:14:31 +0100
Message-Id: <20190322111214.210520651@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9825bd94e3a2baae1f4874767ae3a7d4c049720e ]

When a VM is terminated, the VFIO driver detaches all pass-through
devices from VFIO domain by clearing domain id and page table root
pointer from each device table entry (DTE), and then invalidates
the DTE. Then, the VFIO driver unmap pages and invalidate IOMMU pages.

Currently, the IOMMU driver keeps track of which IOMMU and how many
devices are attached to the domain. When invalidate IOMMU pages,
the driver checks if the IOMMU is still attached to the domain before
issuing the invalidate page command.

However, since VFIO has already detached all devices from the domain,
the subsequent INVALIDATE_IOMMU_PAGES commands are being skipped as
there is no IOMMU attached to the domain. This results in data
corruption and could cause the PCI device to end up in indeterministic
state.

Fix this by invalidate IOMMU pages when detach a device, and
before decrementing the per-domain device reference counts.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Joerg Roedel <joro@8bytes.org>
Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Fixes: 6de8ad9b9ee0 ('x86/amd-iommu: Make iommu_flush_pages aware of multiple IOMMUs')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5cf388ad1555..48a73c48876b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2132,14 +2132,11 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 static void do_detach(struct iommu_dev_data *dev_data)
 {
+	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 
-	/* decrease reference counters */
-	dev_data->domain->dev_iommu[iommu->index] -= 1;
-	dev_data->domain->dev_cnt                 -= 1;
-
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -2147,6 +2144,16 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
+
+	/* Flush IOTLB */
+	domain_flush_tlb_pde(domain);
+
+	/* Wait for the flushes to finish */
+	domain_flush_complete(domain);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	domain->dev_iommu[iommu->index] -= 1;
+	domain->dev_cnt                 -= 1;
 }
 
 /*
-- 
2.19.1



