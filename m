Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1424C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A1920880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfHHJhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732427AbfHHJhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29E0E3064FD3;
        Thu,  8 Aug 2019 09:37:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D660B5C231;
        Thu,  8 Aug 2019 09:37:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E6F6F9D2B; Thu,  8 Aug 2019 11:37:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 8/8] gem/qxl: use drm_gem_ttm_bo_driver_verify_access()
Date:   Thu,  8 Aug 2019 11:37:02 +0200
Message-Id: <20190808093702.29512-9-kraxel@redhat.com>
In-Reply-To: <20190808093702.29512-1-kraxel@redhat.com>
References: <20190808093702.29512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 08 Aug 2019 09:37:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 3a24145dd516..bcf48b062a85 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -151,14 +151,6 @@ static void qxl_evict_flags(struct ttm_buffer_object *bo,
 	*placement = qbo->placement;
 }
 
-static int qxl_verify_access(struct ttm_buffer_object *bo, struct file *filp)
-{
-	struct qxl_bo *qbo = to_qxl_bo(bo);
-
-	return drm_vma_node_verify_access(&qbo->tbo.base.vma_node,
-					  filp->private_data);
-}
-
 static int qxl_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
 				  struct ttm_mem_reg *mem)
 {
@@ -310,7 +302,7 @@ static struct ttm_bo_driver qxl_bo_driver = {
 	.eviction_valuable = ttm_bo_eviction_valuable,
 	.evict_flags = &qxl_evict_flags,
 	.move = &qxl_bo_move,
-	.verify_access = &qxl_verify_access,
+	.verify_access = drm_gem_ttm_bo_driver_verify_access,
 	.io_mem_reserve = &qxl_ttm_io_mem_reserve,
 	.io_mem_free = &qxl_ttm_io_mem_free,
 	.move_notify = &qxl_bo_move_notify,
-- 
2.18.1

