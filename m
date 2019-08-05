Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3272173C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfHEOCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34945 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbfHEOB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:01:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 857A5765CE;
        Mon,  5 Aug 2019 14:01:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5EA426396;
        Mon,  5 Aug 2019 14:01:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DA1789D00; Mon,  5 Aug 2019 16:01:22 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        thomas@shipmail.org, bskeggs@redhat.com, tzimmermann@suse.de,
        ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 12/17] drm/vmwgfx: switch driver from bo->resv to bo->base.resv
Date:   Mon,  5 Aug 2019 16:01:14 +0200
Message-Id: <20190805140119.7337-13-kraxel@redhat.com>
In-Reply-To: <20190805140119.7337-1-kraxel@redhat.com>
References: <20190805140119.7337-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 05 Aug 2019 14:01:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c     | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       | 8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 703786e3d579..6c01ad2785dd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -459,9 +459,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 
 	/* Buffer objects need to be either pinned or reserved: */
 	if (!(dst->mem.placement & TTM_PL_FLAG_NO_EVICT))
-		reservation_object_assert_held(dst->resv);
+		reservation_object_assert_held(dst->base.resv);
 	if (!(src->mem.placement & TTM_PL_FLAG_NO_EVICT))
-		reservation_object_assert_held(src->resv);
+		reservation_object_assert_held(src->base.resv);
 
 	if (dst->ttm->state == tt_unpopulated) {
 		ret = dst->ttm->bdev->driver->ttm_tt_populate(dst->ttm, &ctx);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 5739c6c49c99..369034c0de31 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -342,7 +342,7 @@ void vmw_bo_pin_reserved(struct vmw_buffer_object *vbo, bool pin)
 	uint32_t old_mem_type = bo->mem.mem_type;
 	int ret;
 
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
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
index 71e901bbed68..7984f172ec4a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -169,7 +169,7 @@ static int vmw_cotable_unscrub(struct vmw_resource *res)
 	} *cmd;
 
 	WARN_ON_ONCE(bo->mem.mem_type != VMW_PL_MOB);
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	cmd = VMW_FIFO_RESERVE(dev_priv, sizeof(*cmd));
 	if (!cmd)
@@ -311,7 +311,7 @@ static int vmw_cotable_unbind(struct vmw_resource *res,
 		return 0;
 
 	WARN_ON_ONCE(bo->mem.mem_type != VMW_PL_MOB);
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	mutex_lock(&dev_priv->binding_mutex);
 	if (!vcotbl->scrubbed)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 303d2c7d9ab3..701643b7b0c4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -402,14 +402,14 @@ void vmw_resource_unreserve(struct vmw_resource *res,
 
 	if (switch_backup && new_backup != res->backup) {
 		if (res->backup) {
-			reservation_object_assert_held(res->backup->base.resv);
+			reservation_object_assert_held(res->backup->base.base.resv);
 			list_del_init(&res->mob_head);
 			vmw_bo_unreference(&res->backup);
 		}
 
 		if (new_backup) {
 			res->backup = vmw_bo_reference(new_backup);
-			reservation_object_assert_held(new_backup->base.resv);
+			reservation_object_assert_held(new_backup->base.base.resv);
 			list_add_tail(&res->mob_head, &new_backup->res_list);
 		} else {
 			res->backup = NULL;
@@ -691,7 +691,7 @@ void vmw_resource_unbind_list(struct vmw_buffer_object *vbo)
 		.num_shared = 0
 	};
 
-	reservation_object_assert_held(vbo->base.resv);
+	reservation_object_assert_held(vbo->base.base.resv);
 	list_for_each_entry_safe(res, next, &vbo->res_list, mob_head) {
 		if (!res->func->unbind)
 			continue;
-- 
2.18.1

