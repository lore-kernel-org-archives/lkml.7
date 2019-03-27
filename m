Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656FF204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713677;
	bh=Ov1QuUJhEHTF/HRkiW26STtZhdPCawV1qgMKrz3c1AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UAqrycvIy7hayC0JkYTbPBdszDY2l6feqBvJ/KMFSfdEURWYAAqNRqLjNsLDCuD/j
	 kPMLqdNGPCmtVdR9DvoVs5/4woVvW80Ku3R3OD8QlcPHNSrfqIawzhFJXcAXmR7nFd
	 0STwkleHhZH1rV+1EaEJq6btn/2hsh8QPLbqRv1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbfC0TH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389122AbfC0SMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5F4E2147C;
        Wed, 27 Mar 2019 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710319;
        bh=Ov1QuUJhEHTF/HRkiW26STtZhdPCawV1qgMKrz3c1AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayofimgkUZ2W/afzvQs3mExkYDP3dYaYEFL4HuU8ZBkEJN7SfScz+O4jdUTww7RUZ
         bkha8bvbdUCitPspvhviEHLvZuSbgyJsILEibR3NBVDK79Yhym2TVoCqbs4Qfi9J5b
         Z6aa2WJCGpISE4HsagR3QzVgT2b4PkcfxO0tlN20=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 052/192] powerpc/powernv/ioda: Fix locked_vm counting for memory used by IOMMU tables
Date:   Wed, 27 Mar 2019 14:08:04 -0400
Message-Id: <20190327181025.13507-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 11f5acce2fa43b015a8120fa7620fa4efd0a2952 ]

We store 2 multilevel tables in iommu_table - one for the hardware and
one with the corresponding userspace addresses. Before allocating
the tables, the iommu_table_group_ops::get_table_size() hook returns
the combined size of the two and VFIO SPAPR TCE IOMMU driver adjusts
the locked_vm counter correctly. When the table is actually allocated,
the amount of allocated memory is stored in iommu_table::it_allocated_size
and used to decrement the locked_vm counter when we release the memory
used by the table; .get_table_size() and .create_table() calculate it
independently but the result is expected to be the same.

However the allocator does not add the userspace table size to
.it_allocated_size so when we destroy the table because of VFIO PCI
unplug (i.e. VFIO container is gone but the userspace keeps running),
we decrement locked_vm by just a half of size of memory we are
releasing.

To make things worse, since we enabled on-demand allocation of
indirect levels, it_allocated_size contains only the amount of memory
actually allocated at the table creation time which can just be a
fraction. It is not a problem with incrementing locked_vm (as
get_table_size() value is used) but it is with decrementing.

As the result, we leak locked_vm and may not be able to allocate more
IOMMU tables after few iterations of hotplug/unplug.

This sets it_allocated_size in the pnv_pci_ioda2_ops::create_table()
hook to what pnv_pci_ioda2_get_table_size() returns so from now on we
have a single place which calculates the maximum memory a table can
occupy. The original meaning of it_allocated_size is somewhat lost now
though.

We do not ditch it_allocated_size whatsoever here and we do not call
get_table_size() from vfio_iommu_spapr_tce.c when decrementing
locked_vm as we may have multiple IOMMU groups per container and even
though they all are supposed to have the same get_table_size()
implementation, there is a small chance for failure or confusion.

Fixes: 090bad39b237 ("powerpc/powernv: Add indirect levels to it_userspace")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 1 -
 arch/powerpc/platforms/powernv/pci-ioda.c     | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index 7639b2168755..f5adb6b756f7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -313,7 +313,6 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 			page_shift);
 	tbl->it_level_size = 1ULL << (level_shift - 3);
 	tbl->it_indirect_levels = levels - 1;
-	tbl->it_allocated_size = total_allocated;
 	tbl->it_userspace = uas;
 	tbl->it_nid = nid;
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cde710297a4e..326ca6288bb1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2603,8 +2603,13 @@ static long pnv_pci_ioda2_create_table_userspace(
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table **ptbl)
 {
-	return pnv_pci_ioda2_create_table(table_group,
+	long ret = pnv_pci_ioda2_create_table(table_group,
 			num, page_shift, window_size, levels, true, ptbl);
+
+	if (!ret)
+		(*ptbl)->it_allocated_size = pnv_pci_ioda2_get_table_size(
+				page_shift, window_size, levels);
+	return ret;
 }
 
 static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
-- 
2.19.1

