Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D0FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="qjbONmoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfLCNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:23:26 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:60085 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLCNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:23:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CF11F3F67A;
        Tue,  3 Dec 2019 14:22:58 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=qjbONmoK;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fTgvZ59bShiW; Tue,  3 Dec 2019 14:22:52 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 12D063F65E;
        Tue,  3 Dec 2019 14:22:52 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B722C362532;
        Tue,  3 Dec 2019 14:22:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575379369; bh=a8XevGou6NRGoHcArPvCBWEfkQY2lbEu75A0FKNzs1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjbONmoK7SErMiU3088Lj+fguno3k9SMcK1/DNzHgsA/n24OKpSl23zUYXCq33zQA
         7+ym5Y/Y81/YCDsJix4tQZPBymeZXwdBKnAJBH6y8CTzsyRwDGfomO0tjRGrL7+KBF
         V/uWBm9FQ2HYqlnKpU1/YiyB1WKxyBsn1f2E9P50=
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
Subject: [PATCH 5/8] drm/vmwgfx: Support huge page faults
Date:   Tue,  3 Dec 2019 14:22:36 +0100
Message-Id: <20191203132239.5910-6-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203132239.5910-1-thomas_os@shipmail.org>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With vmwgfx dirty-tracking we need a specialized huge_fault
callback. Implement and hook it up.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        |  2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 66 +++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c   |  1 +
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index a31e726d6d71..8656a97448c3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1428,6 +1428,8 @@ void vmw_bo_dirty_unmap(struct vmw_buffer_object *vbo,
 			pgoff_t start, pgoff_t end);
 vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf);
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf);
+vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
+				enum page_entry_size pe_size);
 
 /**
  * VMW_DEBUG_KMS - Debug output for kernel mode-setting
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 17a5dca7b921..6f76a97ad969 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -473,7 +473,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 	 * a lot of unnecessary write faults.
 	 */
 	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE)
-		prot = vma->vm_page_prot;
+		prot = vm_get_page_prot(vma->vm_flags & ~VM_SHARED);
 	else
 		prot = vm_get_page_prot(vma->vm_flags);
 
@@ -486,3 +486,67 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 
 	return ret;
 }
+
+vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
+				enum page_entry_size pe_size)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
+	    vma->vm_private_data;
+	struct vmw_buffer_object *vbo =
+		container_of(bo, struct vmw_buffer_object, base);
+	pgprot_t prot;
+	vm_fault_t ret;
+	pgoff_t fault_page_size;
+
+	switch (pe_size) {
+	case PE_SIZE_PMD:
+		fault_page_size = HPAGE_PMD_SIZE >> PAGE_SHIFT;
+		break;
+	case PE_SIZE_PUD:
+		fault_page_size = HPAGE_PUD_SIZE >> PAGE_SHIFT;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return VM_FAULT_FALLBACK;
+	}
+
+	/* Always do write dirty-tracking on PTE level. */
+	if (READ_ONCE(vbo->dirty) && (vmf->flags & FAULT_FLAG_WRITE))
+		return VM_FAULT_FALLBACK;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	if (vbo->dirty) {
+		pgoff_t allowed_prefault;
+		unsigned long page_offset;
+
+		page_offset = vmf->pgoff -
+			drm_vma_node_start(&bo->base.vma_node);
+		if (page_offset >= bo->num_pages ||
+		    vmw_resources_clean(vbo, page_offset,
+					page_offset + PAGE_SIZE,
+					&allowed_prefault)) {
+			ret = VM_FAULT_SIGBUS;
+			goto out_unlock;
+		}
+
+		/*
+		 * Write protect, so we get a new fault on write, and can
+		 * split.
+		 */
+		prot = vm_get_page_prot(vma->vm_flags & ~VM_SHARED);
+	} else {
+		prot = vm_get_page_prot(vma->vm_flags);
+	}
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, 1, fault_page_size);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
+out_unlock:
+	dma_resv_unlock(bo->base.resv);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
index ce288756531b..de838ba88a97 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
@@ -33,6 +33,7 @@ int vmw_mmap(struct file *filp, struct vm_area_struct *vma)
 		.pfn_mkwrite = vmw_bo_vm_mkwrite,
 		.page_mkwrite = vmw_bo_vm_mkwrite,
 		.fault = vmw_bo_vm_fault,
+		.huge_fault = vmw_bo_vm_huge_fault,
 		.open = ttm_bo_vm_open,
 		.close = ttm_bo_vm_close
 	};
-- 
2.21.0

