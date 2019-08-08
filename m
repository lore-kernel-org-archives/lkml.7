Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E5DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4632171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfHHNo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733276AbfHHNo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FCCE2F3663;
        Thu,  8 Aug 2019 13:44:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B01AF194BB;
        Thu,  8 Aug 2019 13:44:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CB9489D31; Thu,  8 Aug 2019 15:44:19 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/17] drm/ttm: add drm_gem_ttm_mmap()
Date:   Thu,  8 Aug 2019 15:44:09 +0200
Message-Id: <20190808134417.10610-10-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 08 Aug 2019 13:44:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function to mmap ttm bo's via drm_gem_object_funcs->mmap().

Note that with this code path access verification is done by
drm_gem_mmap() and ttm_bo_driver.verify_access() is not used.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_ttm_helper.h     |  2 ++
 drivers/gpu/drm/drm_gem_ttm_helper.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
index 43c9db3583cc..0de3f41a37f4 100644
--- a/include/drm/drm_gem_ttm_helper.h
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -26,5 +26,7 @@ int drm_gem_ttm_bo_device_init(struct drm_device *dev,
 			       struct ttm_bo_device *bdev,
 			       struct ttm_bo_driver *driver,
 			       bool need_dma32);
+int drm_gem_ttm_mmap(struct drm_gem_object *gem,
+		     struct vm_area_struct *vma);
 
 #endif
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
index 0c57e9fd50b9..fabeced8ccf2 100644
--- a/drivers/gpu/drm/drm_gem_ttm_helper.c
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -34,3 +34,14 @@ int drm_gem_ttm_bo_device_init(struct drm_device *dev,
 						   need_dma32);
 }
 EXPORT_SYMBOL(drm_gem_ttm_bo_device_init);
+
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
-- 
2.18.1

