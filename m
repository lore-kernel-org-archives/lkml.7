Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269BC20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="q+D96kC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLCKtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:49:18 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:50888 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:49:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id BE682413DF;
        Tue,  3 Dec 2019 11:49:10 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=q+D96kC0;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O1Phm5sjhJf1; Tue,  3 Dec 2019 11:49:08 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0BB2B413CC;
        Tue,  3 Dec 2019 11:49:05 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 6C4F136159C;
        Tue,  3 Dec 2019 11:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575370145; bh=uTN4ic4eeS1L6Fw/mV08DD+v/r8WpmY+v3FL99RylaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+D96kC0olg7qmojQqZo2RGwOSWcx8AsT4UxE81PKkdLpaLjaBHAcJp4Mx5jV9NF4
         /KFH3xD+dczwrU6flDs7w/BSB7o7ktd64OEbSc+JqQbdLjlHurYE7387HrPED+aT48
         7uGPLTapP4EAWR2jSMqoWo4EjWYhW/Hn18aPu6lU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 2/2] drm/ttm: Fix vm page protection handling
Date:   Tue,  3 Dec 2019 11:48:53 +0100
Message-Id: <20191203104853.4378-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203104853.4378-1-thomas_os@shipmail.org>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

TTM graphics buffer objects may, transparently to user-space,  move
between IO and system memory. When that happens, all PTEs pointing to the
old location are zapped before the move and then faulted in again if
needed. When that happens, the page protection caching mode- and
encryption bits may change and be different from those of
struct vm_area_struct::vm_page_prot.

We were using an ugly hack to set the page protection correctly.
Fix that and instead use vmf_insert_mixed_prot() and / or
vmf_insert_pfn_prot().
Also get the default page protection from
struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
This way we catch modifications done by the vm system for drivers that
want write-notification.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index e6495ca2630b..2098f8d4dfc5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -173,7 +173,6 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgoff_t num_prefault)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vm_area_struct cvma = *vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
 	struct ttm_bo_device *bdev = bo->bdev;
 	unsigned long page_offset;
@@ -244,7 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		goto out_io_unlock;
 	}
 
-	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
+	prot = ttm_io_prot(bo->mem.placement, prot);
 	if (!bo->mem.bus.is_iomem) {
 		struct ttm_operation_ctx ctx = {
 			.interruptible = false,
@@ -260,7 +259,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		}
 	} else {
 		/* Iomem should not be marked encrypted */
-		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
+		prot = pgprot_decrypted(prot);
 	}
 
 	/*
@@ -284,10 +283,11 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		}
 
 		if (vma->vm_flags & VM_MIXEDMAP)
-			ret = vmf_insert_mixed(&cvma, address,
-					__pfn_to_pfn_t(pfn, PFN_DEV));
+			ret = vmf_insert_mixed_prot(vma, address,
+						    __pfn_to_pfn_t(pfn, PFN_DEV),
+						    prot);
 		else
-			ret = vmf_insert_pfn(&cvma, address, pfn);
+			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
@@ -319,7 +319,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	prot = vm_get_page_prot(vma->vm_flags);
+	prot = vma->vm_page_prot;
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
-- 
2.21.0

