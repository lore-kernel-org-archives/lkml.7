Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F7C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3975320644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agM+XA9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfFYNzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:55:15 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38328 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfFYNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:55:13 -0400
Received: by mail-wm1-f50.google.com with SMTP id s15so3072787wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cV4KsDQvRxm7DEMIm8JuhK5ZZzz2X/va/1G3dFC0a4I=;
        b=agM+XA9ob1kgKZeEbZHPplhDfx0ko6I8sXPtrzHeaoTppnDDK1a5EFtQXb+B3cQhBS
         hUxbo5qPIQPqIJ7MU5rV1Jny/4VeTn53My8P8XEfwJG3Pt0SpnFLSKIZaIJso0kLwwf6
         PmDTgG/pxA4i6CfYcBgIvs8rhgJWDlBuy+nXVIa8FupsstsnAt5HeAu4hYJhbSkagiNl
         E9Va6yhiBmdPQ2qgCqZTiZGqL/vgAjwv1U0jvIrEiiiwMbuHLdZdN2ujXB1m2mhQKrY/
         S3bDh0a3AFNIk0l+yreckJGqFxIu2hxk2nDDWt0f5xzSR1YbUuHUpxvxRcYzy1TANw6s
         Acbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cV4KsDQvRxm7DEMIm8JuhK5ZZzz2X/va/1G3dFC0a4I=;
        b=e2UX+7TguMXuftOL/t/u5C+zuEJWSt1tGwUfvfPcThAtNUwv0NwgWb+0s69BrB3mTL
         mYmTS35jXehuy+FCwkGLNlZODtFhug1p50tATyHe8jSl8Vripjr/SBO77lqthXNqULii
         xwlmPHWCXfby7QuPaGH8Nm7tAhrdsyNsUQ8JphDg6HAw7dSKZ/9rnOAMB6iSAVS6DUPO
         n51QQY++ceXLqAgZolhEocPNHCTyq9chSp23wrxp0DfrzSbeVc96h5bkYVRk2/jwIPik
         OHRr4PXk/HB+qrQTvnI0HbXEDHOR5MeD5rPcOe/kJl09KBXLjm6k88SebVsqZZNRWmEs
         m1Tg==
X-Gm-Message-State: APjAAAVTmYSgglx/orcofY2779huMbcL+hV1+SWzqKlLqi80Z1DC/XW4
        xqaC+X59tCPskt0F7VG9d8c=
X-Google-Smtp-Source: APXvYqz/CWK6u/g8YjLJKogaCIlE9mQXApmks4Rs2xvNdjnyVs3QK+NuFJfrAi2mP5cXbdHIb/RiTA==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr20644138wme.145.1561470909389;
        Tue, 25 Jun 2019 06:55:09 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:2df2:5da:22f9:1506])
        by smtp.gmail.com with ESMTPSA id y44sm13814441wrd.13.2019.06.25.06.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:55:08 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, peterz@infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/ttm: switch ttm_execbuf_util to new reservation_context
Date:   Tue, 25 Jun 2019 15:55:07 +0200
Message-Id: <20190625135507.80548-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625135507.80548-1-christian.koenig@amd.com>
References: <20190625135507.80548-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change ttm_execbuf_util to use the new reservation context
object for deadlock handling.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/qxl/qxl_drv.h                 |   2 +-
 drivers/gpu/drm/qxl/qxl_release.c             |   2 +-
 drivers/gpu/drm/radeon/radeon.h               |   3 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |   2 +-
 drivers/gpu/drm/radeon/radeon_object.c        |   2 +-
 drivers/gpu/drm/radeon/radeon_object.h        |   2 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c        | 117 ++++++++----------
 drivers/gpu/drm/virtio/virtgpu_drv.h          |   2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |   4 +-
 drivers/gpu/drm/virtio/virtgpu_object.c       |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h    |   2 +-
 include/drm/ttm/ttm_execbuf_util.h            |  12 +-
 19 files changed, 83 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 19a00282e34c..f7f061f71b26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -457,7 +457,7 @@ struct amdgpu_cs_parser {
 	struct drm_sched_entity	*entity;
 
 	/* buffer objects */
-	struct ww_acquire_ctx		ticket;
+	struct reservation_context	ticket;
 	struct amdgpu_bo_list		*bo_list;
 	struct amdgpu_mn		*mn;
 	struct amdgpu_bo_list_entry	vm_pd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 81e0e758cc54..a9be6d1d4f76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -539,7 +539,7 @@ struct bo_vm_reservation_context {
 	struct amdgpu_bo_list_entry kfd_bo; /* BO list entry for the KFD BO */
 	unsigned int n_vms;		    /* Number of VMs reserved	    */
 	struct amdgpu_bo_list_entry *vm_pd; /* Array of VM BO list entries  */
-	struct ww_acquire_ctx ticket;	    /* Reservation ticket	    */
+	struct reservation_context ticket;  /* Reservation ticket	    */
 	struct list_head list, duplicates;  /* BO lists			    */
 	struct amdgpu_sync *sync;	    /* Pointer to sync object	    */
 	bool reserved;			    /* Whether BOs are reserved	    */
@@ -1772,7 +1772,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 {
 	struct amdgpu_bo_list_entry *pd_bo_list_entries;
 	struct list_head resv_list, duplicates;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct amdgpu_sync sync;
 
 	struct amdgpu_vm *peer_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 3e2da24cd17a..0fc4c0c10ef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1322,7 +1322,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_job_free_resources(job);
 
 	trace_amdgpu_cs_ioctl(job);
-	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
+	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket.ctx);
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
 
@@ -1726,7 +1726,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	*map = mapping;
 
 	/* Double check that the BO is reserved by this CS */
-	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
+	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket.ctx)
 		return -EINVAL;
 
 	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index f660628e6af9..3e13850b2435 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -65,7 +65,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t csa_addr, uint32_t size)
 {
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct list_head list;
 	struct amdgpu_bo_list_entry pd;
 	struct ttm_validate_buffer csa_tv;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ed25a4e14404..6e819d6a80e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -158,7 +158,7 @@ void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	struct amdgpu_bo_list_entry vm_pd;
 	struct list_head list, duplicates;
 	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct amdgpu_bo_va *bo_va;
 	int r;
 
@@ -546,7 +546,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo_list_entry vm_pd;
 	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct list_head list, duplicates;
 	uint64_t va_flags;
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 36ee8fe52f38..241bb4562240 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4193,7 +4193,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
 	struct list_head list;
 	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	uint64_t tiling_flags;
 	uint32_t domain;
 	int r;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 2896bb6fdbf4..3066fd9776bd 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -154,7 +154,7 @@ struct qxl_release {
 	struct qxl_bo *release_bo;
 	uint32_t release_offset;
 	uint32_t surface_release_id;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct list_head bos;
 };
 
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 49f9a9385393..e392bdd82609 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -459,6 +459,6 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
 		reservation_object_unlock(bo->resv);
 	}
 	spin_unlock(&glob->lru_lock);
-	ww_acquire_fini(&release->ticket);
+	reservation_context_fini(&release->ticket);
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 32808e50be12..04f94792be55 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1084,7 +1084,8 @@ struct radeon_cs_parser {
 	u32			cs_flags;
 	u32			ring;
 	s32			priority;
-	struct ww_acquire_ctx	ticket;
+
+	struct reservation_context	ticket;
 };
 
 static inline u32 radeon_get_ib_value(struct radeon_cs_parser *p, int idx)
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 7411e69e2712..823ccb8dae20 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -544,7 +544,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 {
 	struct ttm_validate_buffer tv, *entry;
 	struct radeon_bo_list *vm_bos;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct list_head list;
 	unsigned domain;
 	int r;
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 36683de0300b..56b90903482a 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -528,7 +528,7 @@ static u64 radeon_bo_get_threshold_for_moves(struct radeon_device *rdev)
 }
 
 int radeon_bo_list_validate(struct radeon_device *rdev,
-			    struct ww_acquire_ctx *ticket,
+			    struct reservation_context *ticket,
 			    struct list_head *head, int ring)
 {
 	struct ttm_operation_ctx ctx = { true, false };
diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/radeon/radeon_object.h
index 9ffd8215d38a..9dd3b2fa3f9a 100644
--- a/drivers/gpu/drm/radeon/radeon_object.h
+++ b/drivers/gpu/drm/radeon/radeon_object.h
@@ -141,7 +141,7 @@ extern void radeon_bo_force_delete(struct radeon_device *rdev);
 extern int radeon_bo_init(struct radeon_device *rdev);
 extern void radeon_bo_fini(struct radeon_device *rdev);
 extern int radeon_bo_list_validate(struct radeon_device *rdev,
-				   struct ww_acquire_ctx *ticket,
+				   struct reservation_context *ticket,
 				   struct list_head *head, int ring);
 extern int radeon_bo_set_tiling_flags(struct radeon_bo *bo,
 				u32 tiling_flags, u32 pitch);
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 957ec375a4ba..6df2879b2480 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -33,16 +33,6 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 
-static void ttm_eu_backoff_reservation_reverse(struct list_head *list,
-					      struct ttm_validate_buffer *entry)
-{
-	list_for_each_entry_continue_reverse(entry, list, head) {
-		struct ttm_buffer_object *bo = entry->bo;
-
-		reservation_object_unlock(bo->resv);
-	}
-}
-
 static void ttm_eu_del_from_lru_locked(struct list_head *list)
 {
 	struct ttm_validate_buffer *entry;
@@ -53,7 +43,7 @@ static void ttm_eu_del_from_lru_locked(struct list_head *list)
 	}
 }
 
-void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
+void ttm_eu_backoff_reservation(struct reservation_context *ticket,
 				struct list_head *list)
 {
 	struct ttm_validate_buffer *entry;
@@ -71,12 +61,15 @@ void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
 
 		if (list_empty(&bo->lru))
 			ttm_bo_add_to_lru(bo);
-		reservation_object_unlock(bo->resv);
+		if (!ticket)
+			reservation_object_unlock(bo->resv);
 	}
 	spin_unlock(&glob->lru_lock);
 
-	if (ticket)
-		ww_acquire_fini(ticket);
+	if (ticket) {
+		reservation_context_unlock_all(ticket);
+		reservation_context_fini(ticket);
+	}
 }
 EXPORT_SYMBOL(ttm_eu_backoff_reservation);
 
@@ -92,12 +85,12 @@ EXPORT_SYMBOL(ttm_eu_backoff_reservation);
  * buffers in different orders.
  */
 
-int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
+int ttm_eu_reserve_buffers(struct reservation_context *ticket,
 			   struct list_head *list, bool intr,
 			   struct list_head *dups, bool del_lru)
 {
-	struct ttm_bo_global *glob;
 	struct ttm_validate_buffer *entry;
+	struct ttm_bo_global *glob;
 	int ret;
 
 	if (list_empty(list))
@@ -107,70 +100,45 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 	glob = entry->bo->bdev->glob;
 
 	if (ticket)
-		ww_acquire_init(ticket, &reservation_ww_class);
+		reservation_context_init(ticket);
 
+retry:
 	list_for_each_entry(entry, list, head) {
 		struct ttm_buffer_object *bo = entry->bo;
 
-		ret = __ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
+		if (likely(ticket)) {
+			ret = reservation_context_lock(ticket, bo->resv, intr);
+			if (ret == -EDEADLK)
+				goto retry;
+		} else {
+			ret = reservation_object_trylock(bo->resv) ? 0 : -EBUSY;
+		}
+
 		if (!ret && unlikely(atomic_read(&bo->cpu_writers) > 0)) {
 			reservation_object_unlock(bo->resv);
-
 			ret = -EBUSY;
 
 		} else if (ret == -EALREADY && dups) {
 			struct ttm_validate_buffer *safe = entry;
+
 			entry = list_prev_entry(entry, head);
 			list_del(&safe->head);
 			list_add(&safe->head, dups);
 			continue;
 		}
 
-		if (!ret) {
-			if (!entry->num_shared)
-				continue;
+		if (unlikely(ret))
+			goto error;
 
-			ret = reservation_object_reserve_shared(bo->resv,
-								entry->num_shared);
-			if (!ret)
-				continue;
-		}
-
-		/* uh oh, we lost out, drop every reservation and try
-		 * to only reserve this buffer, then start over if
-		 * this succeeds.
-		 */
-		ttm_eu_backoff_reservation_reverse(list, entry);
-
-		if (ret == -EDEADLK) {
-			if (intr) {
-				ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
-								       ticket);
-			} else {
-				ww_mutex_lock_slow(&bo->resv->lock, ticket);
-				ret = 0;
-			}
-		}
+		if (!entry->num_shared)
+			continue;
 
-		if (!ret && entry->num_shared)
-			ret = reservation_object_reserve_shared(bo->resv,
-								entry->num_shared);
-
-		if (unlikely(ret != 0)) {
-			if (ret == -EINTR)
-				ret = -ERESTARTSYS;
-			if (ticket) {
-				ww_acquire_done(ticket);
-				ww_acquire_fini(ticket);
-			}
-			return ret;
+		ret = reservation_object_reserve_shared(bo->resv,
+							entry->num_shared);
+		if (unlikely(ret)) {
+			reservation_object_unlock(bo->resv);
+			goto error;
 		}
-
-		/* move this item to the front of the list,
-		 * forces correct iteration of the loop without keeping track
-		 */
-		list_del(&entry->head);
-		list_add(&entry->head, list);
 	}
 
 	if (del_lru) {
@@ -179,10 +147,26 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 		spin_unlock(&glob->lru_lock);
 	}
 	return 0;
+
+error:
+	if (ret == -EINTR)
+		ret = -ERESTARTSYS;
+	if (ticket) {
+		reservation_context_unlock_all(ticket);
+		reservation_context_done(ticket);
+		reservation_context_fini(ticket);
+	} else {
+		list_for_each_entry_continue_reverse(entry, list, head) {
+			struct ttm_buffer_object *bo = entry->bo;
+
+			reservation_object_unlock(bo->resv);
+		}
+	}
+	return ret;
 }
 EXPORT_SYMBOL(ttm_eu_reserve_buffers);
 
-void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
+void ttm_eu_fence_buffer_objects(struct reservation_context *ticket,
 				 struct list_head *list,
 				 struct dma_fence *fence)
 {
@@ -208,10 +192,13 @@ void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
 			ttm_bo_add_to_lru(bo);
 		else
 			ttm_bo_move_to_lru_tail(bo, NULL);
-		reservation_object_unlock(bo->resv);
+		if (!ticket)
+			reservation_object_unlock(bo->resv);
 	}
 	spin_unlock(&glob->lru_lock);
-	if (ticket)
-		ww_acquire_fini(ticket);
+	if (ticket) {
+		reservation_context_unlock_all(ticket);
+		reservation_context_fini(ticket);
+	}
 }
 EXPORT_SYMBOL(ttm_eu_fence_buffer_objects);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index b69ae10ca238..b69ac78079fd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -221,7 +221,7 @@ struct virtio_gpu_fpriv {
 /* virtio_ioctl.c */
 #define DRM_VIRTIO_NUM_IOCTLS 10
 extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
-int virtio_gpu_object_list_validate(struct ww_acquire_ctx *ticket,
+int virtio_gpu_object_list_validate(struct reservation_context *ticket,
 				    struct list_head *head);
 void virtio_gpu_unref_list(struct list_head *head);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 24ebe049baa8..7b7fafe4b1f7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -54,7 +54,7 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 					 &virtio_gpu_map->offset);
 }
 
-int virtio_gpu_object_list_validate(struct ww_acquire_ctx *ticket,
+int virtio_gpu_object_list_validate(struct reservation_context *ticket,
 				    struct list_head *head)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -114,7 +114,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct list_head validate_list;
 	struct ttm_validate_buffer *buflist = NULL;
 	int i;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct sync_file *sync_file;
 	int in_fence_fd = exbuf->fence_fd;
 	int out_fence_fd = -1;
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index b2da31310d24..0d18e5c39357 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -142,7 +142,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 		struct list_head validate_list;
 		struct ttm_validate_buffer mainbuf;
-		struct ww_acquire_ctx ticket;
+		struct reservation_context ticket;
 		unsigned long irq_flags;
 		bool signaled;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 1d38a8b2f2ec..94bd8033df4d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -443,7 +443,7 @@ void vmw_resource_unreserve(struct vmw_resource *res,
  *                  reserved and validated backup buffer.
  */
 static int
-vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
+vmw_resource_check_buffer(struct reservation_context *ticket,
 			  struct vmw_resource *res,
 			  bool interruptible,
 			  struct ttm_validate_buffer *val_buf)
@@ -535,7 +535,7 @@ int vmw_resource_reserve(struct vmw_resource *res, bool interruptible,
  * @val_buf:        Backup buffer information.
  */
 static void
-vmw_resource_backoff_reservation(struct ww_acquire_ctx *ticket,
+vmw_resource_backoff_reservation(struct reservation_context *ticket,
 				 struct ttm_validate_buffer *val_buf)
 {
 	struct list_head val_list;
@@ -558,7 +558,7 @@ vmw_resource_backoff_reservation(struct ww_acquire_ctx *ticket,
  * @res:            The resource to evict.
  * @interruptible:  Whether to wait interruptible.
  */
-static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
+static int vmw_resource_do_evict(struct reservation_context *ticket,
 				 struct vmw_resource *res, bool interruptible)
 {
 	struct ttm_validate_buffer val_buf;
@@ -822,7 +822,7 @@ static void vmw_resource_evict_type(struct vmw_private *dev_priv,
 	struct vmw_resource *evict_res;
 	unsigned err_count = 0;
 	int ret;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 
 	do {
 		spin_lock(&dev_priv->resource_lock);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 1d2322ad6fd5..ded66b3e0c4c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -77,7 +77,7 @@ struct vmw_validation_context {
 	struct list_head resource_ctx_list;
 	struct list_head bo_list;
 	struct list_head page_list;
-	struct ww_acquire_ctx ticket;
+	struct reservation_context ticket;
 	struct mutex *res_mutex;
 	unsigned int merge_dups;
 	unsigned int mem_size_left;
diff --git a/include/drm/ttm/ttm_execbuf_util.h b/include/drm/ttm/ttm_execbuf_util.h
index 7e46cc678e7e..82c7a25a70be 100644
--- a/include/drm/ttm/ttm_execbuf_util.h
+++ b/include/drm/ttm/ttm_execbuf_util.h
@@ -52,20 +52,20 @@ struct ttm_validate_buffer {
 /**
  * function ttm_eu_backoff_reservation
  *
- * @ticket:   ww_acquire_ctx from reserve call
+ * @ticket:   reservation_context from reserve call
  * @list:     thread private list of ttm_validate_buffer structs.
  *
  * Undoes all buffer validation reservations for bos pointed to by
  * the list entries.
  */
 
-extern void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
+extern void ttm_eu_backoff_reservation(struct reservation_context *ticket,
 				       struct list_head *list);
 
 /**
  * function ttm_eu_reserve_buffers
  *
- * @ticket:  [out] ww_acquire_ctx filled in by call, or NULL if only
+ * @ticket:  [out] reservation_context filled in by caller, or NULL if only
  *           non-blocking reserves should be tried.
  * @list:    thread private list of ttm_validate_buffer structs.
  * @intr:    should the wait be interruptible
@@ -97,14 +97,14 @@ extern void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
  * has failed.
  */
 
-extern int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
+extern int ttm_eu_reserve_buffers(struct reservation_context *ticket,
 				  struct list_head *list, bool intr,
 				  struct list_head *dups, bool del_lru);
 
 /**
  * function ttm_eu_fence_buffer_objects.
  *
- * @ticket:      ww_acquire_ctx from reserve call
+ * @ticket:      reservation_context from reserve call
  * @list:        thread private list of ttm_validate_buffer structs.
  * @fence:       The new exclusive fence for the buffers.
  *
@@ -114,7 +114,7 @@ extern int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
  *
  */
 
-extern void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
+extern void ttm_eu_fence_buffer_objects(struct reservation_context *ticket,
 					struct list_head *list,
 					struct dma_fence *fence);
 
-- 
2.17.1

