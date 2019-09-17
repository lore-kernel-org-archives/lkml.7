Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48187C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E6721881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfIQJYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:24:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfIQJYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:24:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D60D8980E1;
        Tue, 17 Sep 2019 09:24:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3597C10013A1;
        Tue, 17 Sep 2019 09:24:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 15F1F9CA9; Tue, 17 Sep 2019 11:24:06 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/11] drm/ttm: add drm_gem_ttm_mmap()
Date:   Tue, 17 Sep 2019 11:24:01 +0200
Message-Id: <20190917092404.9982-9-kraxel@redhat.com>
In-Reply-To: <20190917092404.9982-1-kraxel@redhat.com>
References: <20190917092404.9982-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 17 Sep 2019 09:24:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function to mmap ttm bo's using &drm_gem_object_funcs.mmap().

Note that with this code path access verification is done by
drm_gem_mmap() (which calls drm_vma_node_is_allowed(()).
The &ttm_bo_driver.verify_access() callback is is not used.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_ttm_helper.h     |  2 ++
 drivers/gpu/drm/drm_gem_ttm_helper.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
index 6268f89c5a48..118cef76f84f 100644
--- a/include/drm/drm_gem_ttm_helper.h
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -15,5 +15,7 @@
 
 void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
 			    const struct drm_gem_object *gem);
+int drm_gem_ttm_mmap(struct drm_gem_object *gem,
+		     struct vm_area_struct *vma);
 
 #endif
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
index 9a4bafcf20df..34ce6cf78b35 100644
--- a/drivers/gpu/drm/drm_gem_ttm_helper.c
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -52,5 +52,24 @@ void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
 }
 EXPORT_SYMBOL(drm_gem_ttm_print_info);
 
+/**
+ * drm_gem_ttm_mmap() - mmap &ttm_buffer_object
+ * @gem: GEM object.
+ * @vma: vm area.
+ *
+ * This function can be used as &drm_gem_object_funcs.mmap
+ * callback.
+ */
+int drm_gem_ttm_mmap(struct drm_gem_object *gem,
+		     struct vm_area_struct *vma)
+{
+	struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
+
+	ttm_bo_get(bo);
+	ttm_bo_mmap_vma_setup(bo, vma);
+	return 0;
+}
+EXPORT_SYMBOL(drm_gem_ttm_mmap);
+
 MODULE_DESCRIPTION("DRM gem ttm helpers");
 MODULE_LICENSE("GPL");
-- 
2.18.1

