Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CDCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB76B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369064;
	bh=avms9JqdlW9ocvZa7YWk61e85LYjypUBOaI53k2Pf6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xArBqCHDtbgx6Jh77DszJL39AluTowe6jpepsSFIZOJ9GqQFhD9ZnjtANcTPfBpxY
	 cZ8OEU/n7/uYaWPtwNXyD3bzIEXtFhQaJmTBdPWDiDJUhi8Qdogd9Hue8nE/2W+SPq
	 9bGLwK9gdfv3BfnB9nXSgWUyFklWDu1cmZ4t9HZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfDDJLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733092AbfDDJK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B86A20855;
        Thu,  4 Apr 2019 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369057;
        bh=avms9JqdlW9ocvZa7YWk61e85LYjypUBOaI53k2Pf6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXmGIX5JCVTmfU4MP219K39XsiqJwb9sefclntTRKJk0pYPJ0DIcRV75gHAgp+rdE
         w0yKeyjrjeRO71AgOrt0vZHzhaO/bv9IlhIlKswLWCuduB6xn3/UZBn6qrmYadWUbZ
         hgDzSqg3+rEuY3ecnO6AnRoNhduBq7EQbOtPESVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 067/246] powerpc/powernv/ioda: Fix locked_vm counting for memory used by IOMMU tables
Date:   Thu,  4 Apr 2019 10:46:07 +0200
Message-Id: <20190404084621.495485780@linuxfoundation.org>
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
index 697449afb3f7..e28f03e1eb5e 100644
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
index 145373f0e5dc..2d62c58f9a4c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2594,8 +2594,13 @@ static long pnv_pci_ioda2_create_table_userspace(
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



