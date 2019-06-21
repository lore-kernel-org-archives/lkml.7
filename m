Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D795FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D1C21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfFUL65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:58:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfFUL6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FF5AC01F278;
        Fri, 21 Jun 2019 11:58:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2AC360A97;
        Fri, 21 Jun 2019 11:58:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2C2AE9D69; Fri, 21 Jun 2019 13:58:00 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/18] drm/qxl: switch driver from bo->resv to bo->base.resv
Date:   Fri, 21 Jun 2019 13:57:53 +0200
Message-Id: <20190621115755.8481-17-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 21 Jun 2019 11:58:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_debugfs.c | 2 +-
 drivers/gpu/drm/qxl/qxl_release.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
index 013b938986c7..f30460782f05 100644
--- a/drivers/gpu/drm/qxl/qxl_debugfs.c
+++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
@@ -61,7 +61,7 @@ qxl_debugfs_buffers_info(struct seq_file *m, void *data)
 		int rel;
 
 		rcu_read_lock();
-		fobj = rcu_dereference(bo->tbo.resv->fence);
+		fobj = rcu_dereference(bo->tbo.base.resv->fence);
 		rel = fobj ? fobj->shared_count : 0;
 		rcu_read_unlock();
 
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 32126e8836b3..1b7be82c8e68 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -234,7 +234,7 @@ static int qxl_release_validate_bo(struct qxl_bo *bo)
 			return ret;
 	}
 
-	ret = reservation_object_reserve_shared(bo->tbo.resv, 1);
+	ret = reservation_object_reserve_shared(bo->tbo.base.resv, 1);
 	if (ret)
 		return ret;
 
@@ -454,9 +454,9 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
 	list_for_each_entry(entry, &release->bos, head) {
 		bo = entry->bo;
 
-		reservation_object_add_shared_fence(bo->resv, &release->base);
+		reservation_object_add_shared_fence(bo->base.resv, &release->base);
 		ttm_bo_add_to_lru(bo);
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	}
 	spin_unlock(&glob->lru_lock);
 	ww_acquire_fini(&release->ticket);
-- 
2.18.1

