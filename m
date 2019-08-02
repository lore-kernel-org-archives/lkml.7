Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E252220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfHBFXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732930AbfHBFW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:22:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 722F331CD7F;
        Fri,  2 Aug 2019 05:22:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57F9D5D713;
        Fri,  2 Aug 2019 05:22:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 015E29D14; Fri,  2 Aug 2019 07:22:51 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 12/17] drm/vmwgfx: switch driver from bo->resv to bo->base.resv
Date:   Fri,  2 Aug 2019 07:22:42 +0200
Message-Id: <20190802052247.18427-13-kraxel@redhat.com>
In-Reply-To: <20190802052247.18427-1-kraxel@redhat.com>
References: <20190802052247.18427-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 02 Aug 2019 05:22:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c     | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       | 8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index fc6673cde289..917eeb793585 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -459,9 +459,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 
 	/* Buffer objects need to be either pinned or reserved: */
 	if (!(dst->mem.placement & TTM_PL_FLAG_NO_EVICT))
-		lockdep_assert_held(&dst->resv->lock.base);
+		lockdep_assert_held(&dst->base.resv->lock.base);
 	if (!(src->mem.placement & TTM_PL_FLAG_NO_EVICT))
-		lockdep_assert_held(&src->resv->lock.base);
+		lockdep_assert_held(&src->base.resv->lock.base);
 
 	if (dst->ttm->state == tt_unpopulated) {
 		ret = dst->ttm->bdev->driver->ttm_tt_populate(dst->ttm, &ctx);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 0d9478d2e700..4a38ab0733c4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -342,7 +342,7 @@ void vmw_bo_pin_reserved(struct vmw_buffer_object *vbo, bool pin)
 	uint32_t old_mem_type = bo->mem.mem_type;
 	int ret;
 
-	lockdep_assert_held(&bo->resv->lock.base);
+	lockdep_assert_held(&bo->base.resv->lock.base);
 
 	if (pin) {
 		if (vbo->pin_count++ > 0)
@@ -690,7 +690,7 @@ static int vmw_user_bo_synccpu_grab(struct vmw_user_buffer_object *user_bo,
 		long lret;
 
 		lret = reservation_object_wait_timeout_rcu
-			(bo->resv, true, true,
+			(bo->base.resv, true, true,
 			 nonblock ? 0 : MAX_SCHEDULE_TIMEOUT);
 		if (!lret)
 			return -EBUSY;
@@ -1007,10 +1007,10 @@ void vmw_bo_fence_single(struct ttm_buffer_object *bo,
 
 	if (fence == NULL) {
 		vmw_execbuf_fence_commands(NULL, dev_priv, &fence, NULL);
-		reservation_object_add_excl_fence(bo->resv, &fence->base);
+		reservation_object_add_excl_fence(bo->base.resv, &fence->base);
 		dma_fence_put(&fence->base);
 	} else
-		reservation_object_add_excl_fence(bo->resv, &fence->base);
+		reservation_object_add_excl_fence(bo->base.resv, &fence->base);
 }
 
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index b4f6e1217c9d..e142714f132c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -169,7 +169,7 @@ static int vmw_cotable_unscrub(struct vmw_resource *res)
 	} *cmd;
 
 	WARN_ON_ONCE(bo->mem.mem_type != VMW_PL_MOB);
-	lockdep_assert_held(&bo->resv->lock.base);
+	lockdep_assert_held(&bo->base.resv->lock.base);
 
 	cmd = VMW_FIFO_RESERVE(dev_priv, sizeof(*cmd));
 	if (!cmd)
@@ -311,7 +311,7 @@ static int vmw_cotable_unbind(struct vmw_resource *res,
 		return 0;
 
 	WARN_ON_ONCE(bo->mem.mem_type != VMW_PL_MOB);
-	lockdep_assert_held(&bo->resv->lock.base);
+	lockdep_assert_held(&bo->base.resv->lock.base);
 
 	mutex_lock(&dev_priv->binding_mutex);
 	if (!vcotbl->scrubbed)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 1d38a8b2f2ec..ccd7f758bf8c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -402,14 +402,14 @@ void vmw_resource_unreserve(struct vmw_resource *res,
 
 	if (switch_backup && new_backup != res->backup) {
 		if (res->backup) {
-			lockdep_assert_held(&res->backup->base.resv->lock.base);
+			lockdep_assert_held(&res->backup->base.base.resv->lock.base);
 			list_del_init(&res->mob_head);
 			vmw_bo_unreference(&res->backup);
 		}
 
 		if (new_backup) {
 			res->backup = vmw_bo_reference(new_backup);
-			lockdep_assert_held(&new_backup->base.resv->lock.base);
+			lockdep_assert_held(&new_backup->base.base.resv->lock.base);
 			list_add_tail(&res->mob_head, &new_backup->res_list);
 		} else {
 			res->backup = NULL;
@@ -691,7 +691,7 @@ void vmw_resource_unbind_list(struct vmw_buffer_object *vbo)
 		.num_shared = 0
 	};
 
-	lockdep_assert_held(&vbo->base.resv->lock.base);
+	lockdep_assert_held(&vbo->base.base.resv->lock.base);
 	list_for_each_entry_safe(res, next, &vbo->res_list, mob_head) {
 		if (!res->func->unbind)
 			continue;
-- 
2.18.1

