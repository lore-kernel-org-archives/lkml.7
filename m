Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B703C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207B120818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VqvOXxoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbfHFQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbfHFQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rJswjijmkpcl3+zNTfEscrNrHCmk4eoJ1fNyJa4rycs=; b=VqvOXxozSwzI7eFEf4UYNUkBtj
        zcyVitAb2IBMSN93hEBkvpOtxEY7UNDy7CxQ9GwlywMhcQG+yvk1GnvJ95BMTub6P4sOUn/zZ7DL2
        6OGLjDqkUdd0yERlijxCp48M1Sb2SETesO8sl08Tqp3CLKkJt0om/9x2rBHbcNm/RwLcHbbrEg0HO
        OSKL0hAunEvUeoKw2CxinuU3cCbdfwZyg//2UUmstD8wxTIzDYuvmfwcVdjkH+omes3LrNSHjicgO
        WDD51ILtI0PHtJZF9sKmSRarRmER/JhlTblhSLHMs+d7uLKufLh1X/vU4bfr/hI4BkMtdZN+ok155
        BwkIXDrg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yt-0000fO-41; Tue, 06 Aug 2019 16:06:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
Date:   Tue,  6 Aug 2019 19:05:53 +0300
Message-Id: <20190806160554.14046-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option is just used to select HMM mirror support and has a very
confusing help text.  Just pull in the HMM mirror code by default
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/Kconfig                 |  2 ++
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 12 ------------
 4 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1d80222587ad..319c1da2e74e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -226,9 +226,11 @@ config DRM_AMDGPU
 	select DRM_SCHED
         select DRM_TTM
 	select POWER_SUPPLY
+	select HMM_MIRROR
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
 	select INTERVAL_TREE
+	select MMU_NOTIFIER
 	select CHASH
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 2e98c016cb47..c5c963164f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -24,16 +24,6 @@ config DRM_AMDGPU_CIK
 
 	  radeon.cik_support=0 amdgpu.cik_support=1
 
-config DRM_AMDGPU_USERPTR
-	bool "Always enable userptr write support"
-	depends on DRM_AMDGPU
-	depends on MMU
-	select HMM_MIRROR
-	select MMU_NOTIFIER
-	help
-	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
-	  isn't already selected to enabled full userptr support.
-
 config DRM_AMDGPU_GART_DEBUGFS
 	bool "Allow GART access through debugfs"
 	depends on DRM_AMDGPU
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8bf79288c4e2..00b74adbd790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -751,9 +751,7 @@ struct amdgpu_ttm_tt {
 	uint64_t		userptr;
 	struct task_struct	*usertask;
 	uint32_t		userflags;
-#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 	struct hmm_range	*range;
-#endif
 };
 
 /**
@@ -763,7 +761,6 @@ struct amdgpu_ttm_tt {
  * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
  * once afterwards to stop HMM tracking
  */
-#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 
 #define MAX_RETRY_HMM_RANGE_FAULT	16
 
@@ -892,7 +889,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 
 	return r;
 }
-#endif
 
 /**
  * amdgpu_ttm_tt_set_user_pages - Copy pages in, putting old pages as necessary.
@@ -970,12 +966,10 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 
 	sg_free_table(ttm->sg);
 
-#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 	if (gtt->range &&
 	    ttm->pages[0] == hmm_device_entry_to_page(gtt->range,
 						      gtt->range->pfns[0]))
 		WARN_ONCE(1, "Missing get_user_page_done\n");
-#endif
 }
 
 int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index caa76c693700..406b1c5e6dd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,20 +101,8 @@ int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 
-#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
 bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);
-#else
-static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
-					       struct page **pages)
-{
-	return -EPERM;
-}
-static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
-{
-	return false;
-}
-#endif
 
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
 int amdgpu_ttm_tt_set_userptr(struct ttm_tt *ttm, uint64_t addr,
-- 
2.20.1

