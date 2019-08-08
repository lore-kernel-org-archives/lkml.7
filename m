Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E78FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC192186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbfHHJh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732451AbfHHJhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B145E316D798;
        Thu,  8 Aug 2019 09:37:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 647B560BE1;
        Thu,  8 Aug 2019 09:37:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AE46F9D21; Thu,  8 Aug 2019 11:37:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/8] drm/ttm: add drm_gem_ttm_bo_driver_verify_access()
Date:   Thu,  8 Aug 2019 11:37:00 +0200
Message-Id: <20190808093702.29512-7-kraxel@redhat.com>
In-Reply-To: <20190808093702.29512-1-kraxel@redhat.com>
References: <20190808093702.29512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 08 Aug 2019 09:37:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_ttm_helper.h     |  2 ++
 drivers/gpu/drm/drm_gem_ttm_helper.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
index 43c9db3583cc..78e4d8930fec 100644
--- a/include/drm/drm_gem_ttm_helper.h
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -26,5 +26,7 @@ int drm_gem_ttm_bo_device_init(struct drm_device *dev,
 			       struct ttm_bo_device *bdev,
 			       struct ttm_bo_driver *driver,
 			       bool need_dma32);
+int drm_gem_ttm_bo_driver_verify_access(struct ttm_buffer_object *bo,
+					struct file *filp);
 
 #endif
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
index 0c57e9fd50b9..159768c7ec63 100644
--- a/drivers/gpu/drm/drm_gem_ttm_helper.c
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -34,3 +34,25 @@ int drm_gem_ttm_bo_device_init(struct drm_device *dev,
 						   need_dma32);
 }
 EXPORT_SYMBOL(drm_gem_ttm_bo_device_init);
+
+/**
+ * drm_gem_ttm_bo_driver_verify_access() - \
+	Implements &struct ttm_bo_driver.verify_access
+ * @bo:		TTM buffer object.
+ * @filp:	File pointer.
+ *
+ * This function assumes filp->private_data refers to the
+ * corresponding &struct drm_file.
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative errno code otherwise.
+ */
+int drm_gem_ttm_bo_driver_verify_access(struct ttm_buffer_object *bo,
+					struct file *filp)
+{
+	struct drm_file *ptr = filp->private_data;
+
+	return drm_vma_node_verify_access(&bo->base.vma_node, ptr);
+}
+EXPORT_SYMBOL(drm_gem_ttm_bo_driver_verify_access);
-- 
2.18.1

