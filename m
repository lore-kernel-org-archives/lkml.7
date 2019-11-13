Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB0B21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611974;
	bh=nJkBAQLBBkqX8QZJrgLlumKcXjkCQC5TSG3sVUz0Rm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbgeMDmJPl7tG4Grdsq+TO1FgIp+J2x4QmcIvBAQOnXCYt0/yjYfXG7cDa0XL//Xt
	 k+IeUg2QgDfAJVT4FamagYsL21Fctmwr5+SAVHcj/A+hboNN0kB0VRQXMy0TbnljBI
	 wIf/0Q/zs/dx93YTR3Jw3NVVq4xRnoKAd+DjPHk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfKMC0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfKMBvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F25322466;
        Wed, 13 Nov 2019 01:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609880;
        bh=nJkBAQLBBkqX8QZJrgLlumKcXjkCQC5TSG3sVUz0Rm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HvkMZIz0bFiaQM+UFRgVcjZA/enNk9eUgscCjV/jYoszwQGTtiuZLZSScoa+p9fE
         IRvsWxR7omOXOd8YL/GSCqgxyFjaib5E0F+l2P6hOr1wK9a2s/k4Bs0r6WVGQxqF1y
         P9pQ1R+zAwno2kNA2ZzTm3FCEZ6/bodxV7f8ddm4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 042/209] KVM: PPC: Inform the userspace about TCE update failures
Date:   Tue, 12 Nov 2019 20:47:38 -0500
Message-Id: <20191113015025.9685-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
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
index 07a8004c3c237..65486c3d029b5 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -401,7 +401,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
 	long ret;
 
 	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (dir == DMA_NONE)
 		return H_SUCCESS;
@@ -449,15 +449,15 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
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
index eb8b11515a7ff..d258ed4ef77c3 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -300,10 +300,10 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 
 	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
 			&hpa)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
-		return H_CLOSED;
+		return H_TOO_HARD;
 
 	ret = iommu_tce_xchg_rm(kvm->mm, tbl, entry, &hpa, &dir);
 	if (ret) {
@@ -501,7 +501,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 
 		rmap = (void *) vmalloc_to_phys(rmap);
 		if (WARN_ON_ONCE_RM(!rmap))
-			return H_HARDWARE;
+			return H_TOO_HARD;
 
 		/*
 		 * Synchronize with the MMU notifier callbacks in
-- 
2.20.1

