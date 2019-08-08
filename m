Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BACC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD242171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbfHHNou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733264AbfHHNoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FD713007F2A;
        Thu,  8 Aug 2019 13:44:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9386608AB;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9AAA19CAA; Thu,  8 Aug 2019 15:44:20 +0200 (CEST)
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
Subject: [PATCH v4 13/17] drm/qxl: use drm_gem_object_funcs
Date:   Thu,  8 Aug 2019 15:44:13 +0200
Message-Id: <20190808134417.10610-14-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 08 Aug 2019 13:44:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c    |  8 --------
 drivers/gpu/drm/qxl/qxl_object.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 12cf85a06bed..38467478c7b2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -257,16 +257,8 @@ static struct drm_driver qxl_driver = {
 #endif
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_pin = qxl_gem_prime_pin,
-	.gem_prime_unpin = qxl_gem_prime_unpin,
-	.gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
-	.gem_prime_vmap = qxl_gem_prime_vmap,
-	.gem_prime_vunmap = qxl_gem_prime_vunmap,
 	.gem_prime_mmap = qxl_gem_prime_mmap,
-	.gem_free_object_unlocked = qxl_gem_object_free,
-	.gem_open_object = qxl_gem_object_open,
-	.gem_close_object = qxl_gem_object_close,
 	.fops = &qxl_fops,
 	.ioctls = qxl_ioctls,
 	.irq_handler = qxl_irq_handler,
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 548dfe6f3b26..29aab7b14513 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -77,6 +77,17 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 	}
 }
 
+static const struct drm_gem_object_funcs qxl_object_funcs = {
+	.free = qxl_gem_object_free,
+	.open = qxl_gem_object_open,
+	.close = qxl_gem_object_close,
+	.pin = qxl_gem_prime_pin,
+	.unpin = qxl_gem_prime_unpin,
+	.get_sg_table = qxl_gem_prime_get_sg_table,
+	.vmap = qxl_gem_prime_vmap,
+	.vunmap = qxl_gem_prime_vunmap,
+};
+
 int qxl_bo_create(struct qxl_device *qdev,
 		  unsigned long size, bool kernel, bool pinned, u32 domain,
 		  struct qxl_surface *surf,
@@ -100,6 +111,7 @@ int qxl_bo_create(struct qxl_device *qdev,
 		kfree(bo);
 		return r;
 	}
+	bo->tbo.base.funcs = &qxl_object_funcs;
 	bo->type = domain;
 	bo->pin_count = pinned ? 1 : 0;
 	bo->surface_id = 0;
-- 
2.18.1

