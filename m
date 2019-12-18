Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB074C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2B0206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMyA2qZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLRM47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:56:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbfLRM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576673813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=++1+Rs1nX4ZR8abXy62JFiex+L7zoTZPlGBt0mxUBCw=;
        b=JMyA2qZ9wy3A8KV12wssvScpWAx0uoQJQOFYucowupHhdCSGMcdZ0Xm4Tk4Sqk5Nl3inyU
        66ZunDdKHpz/XIuLnN1NCbFLNCushdqC3Qhq+WDsU6mHZRB/iHJDZ8g5YIMrNEDnSatR9B
        jCZ3FtVRaytcobFqyDLCcrfqia3OpM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-VezIqOXANGaRfJHaDhEgUQ-1; Wed, 18 Dec 2019 07:56:50 -0500
X-MC-Unique: VezIqOXANGaRfJHaDhEgUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE8D477;
        Wed, 18 Dec 2019 12:56:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DBE2620D5;
        Wed, 18 Dec 2019 12:56:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5E86A9B13; Wed, 18 Dec 2019 13:56:45 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/3] drm/shmem: add support for per object caching flags.
Date:   Wed, 18 Dec 2019 13:56:43 +0100
Message-Id: <20191218125645.9211-2-kraxel@redhat.com>
In-Reply-To: <20191218125645.9211-1-kraxel@redhat.com>
References: <20191218125645.9211-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add map_cached bool to drm_gem_shmem_object, to request cached mappings
on a per-object base.  Check the flag before adding writecombine to
pgprot bits.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_shmem_helper.h     |  5 +++++
 drivers/gpu/drm/drm_gem_shmem_helper.c | 12 +++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 6748379a0b44..e69f58d467c6 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -83,6 +83,11 @@ struct drm_gem_shmem_object {
 	 * The address are un-mapped when the count reaches zero.
 	 */
 	unsigned int vmap_use_count;
+
+	/**
+	 * @map_cached: map object cached (instead of using writecombine).
+	 */
+	bool map_cached;
 };
 
 #define to_drm_gem_shmem_obj(obj) \
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index a421a2eed48a..443265a4fc5a 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -256,9 +256,13 @@ static void *drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem)
 
 	if (obj->import_attach)
 		shmem->vaddr = dma_buf_vmap(obj->import_attach->dmabuf);
-	else
+	else {
+		pgprot_t prot = PAGE_KERNEL;
+		if (!shmem->map_cached)
+			prot = pgprot_writecombine(prot);
 		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
-				    VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+				    VM_MAP, prot);
+	}
 
 	if (!shmem->vaddr) {
 		DRM_DEBUG_KMS("Failed to vmap pages\n");
@@ -540,7 +544,9 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	}
 
 	vma->vm_flags |= VM_MIXEDMAP | VM_DONTEXPAND;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+	if (!shmem->map_cached)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 	vma->vm_ops = &drm_gem_shmem_vm_ops;
 
-- 
2.18.1

