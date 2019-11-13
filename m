Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1455C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72152053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610219;
	bh=ViMif753YVWxmN/urXVlLwxTqpT/hqAuASnE0CsjgGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMfpx0Fkbb00SbZsc5IR1Y41CDNMweEgcrwhar+0+tKAmc2fPxfMjYr6CPmaQKx9o
	 c2xr9AF0PmyC+CNKvh7m9dbMNwhgnf3fg1MpqOK33J0NTTOWJTJvp+ae+BmOA01dxM
	 0DvUMxG18DxI7hFp1W1wbGGIFw3oitcdHq5PO0fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfKMB46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfKMB4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360AF2053B;
        Wed, 13 Nov 2019 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610213;
        bh=ViMif753YVWxmN/urXVlLwxTqpT/hqAuASnE0CsjgGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5IXX6FntwALNO50SRloi2Rb2EJwMAk0220eORqAf9FdkclFIFddohQ3WgfXh2rHn
         Y1vk1LJPaXVYv57KSxWxc9Td3gSjwpuFpqCywazrmKHeHQQtxP40KWULQpGOXNdcgK
         zd0NMGOHy4rOoE6cgFE/cPkB5CijqV19z1USW5FI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 022/115] KVM: PPC: Inform the userspace about TCE update failures
Date:   Tue, 12 Nov 2019 20:54:49 -0500
Message-Id: <20191113015622.11592-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit f7960e299f13f069d6f3d4e157d91bfca2669677 ]

We return H_TOO_HARD from TCE update handlers when we think that
the next handler (realmode -> virtual mode -> user mode) has a chance to
handle the request; H_HARDWARE/H_CLOSED otherwise.

This changes the handlers to return H_TOO_HARD on every error giving
the userspace an opportunity to handle any request or at least log
them all.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++----
 arch/powerpc/kvm/book3s_64_vio_hv.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 2c6cce8e7cfd0..5e44462960213 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -404,7 +404,7 @@ static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
 	long ret;
 
 	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (dir == DMA_NONE)
 		return H_SUCCESS;
@@ -434,15 +434,15 @@ long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
 		return H_TOO_HARD;
 
 	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (mm_iommu_mapped_inc(mem))
-		return H_CLOSED;
+		return H_TOO_HARD;
 
 	ret = iommu_tce_xchg(tbl, entry, &hpa, &dir);
 	if (WARN_ON_ONCE(ret)) {
 		mm_iommu_mapped_dec(mem);
-		return H_HARDWARE;
+		return H_TOO_HARD;
 	}
 
 	if (dir != DMA_NONE)
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 23d6d1592f117..c75e5664fe3d8 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -264,14 +264,14 @@ static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
 
 	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
 			&hpa)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	pua = (void *) vmalloc_to_phys(pua);
 	if (WARN_ON_ONCE_RM(!pua))
 		return H_HARDWARE;
 
 	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
-		return H_CLOSED;
+		return H_TOO_HARD;
 
 	ret = iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
 	if (ret) {
@@ -448,7 +448,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 
 		rmap = (void *) vmalloc_to_phys(rmap);
 		if (WARN_ON_ONCE_RM(!rmap))
-			return H_HARDWARE;
+			return H_TOO_HARD;
 
 		/*
 		 * Synchronize with the MMU notifier callbacks in
-- 
2.20.1

