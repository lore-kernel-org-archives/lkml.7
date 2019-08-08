Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C1C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD59B2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfHHNoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:44:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733223AbfHHNoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B01E30EE12B;
        Thu,  8 Aug 2019 13:44:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2720D10016E9;
        Thu,  8 Aug 2019 13:44:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 276F19D20; Thu,  8 Aug 2019 15:44:19 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/17] drm: add mmap() to drm_gem_object_funcs
Date:   Thu,  8 Aug 2019 15:44:05 +0200
Message-Id: <20190808134417.10610-6-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 08 Aug 2019 13:44:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_object_funcs->vm_ops alone can't handle
everything mmap() needs.  Add a new callback for it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem.h     | 9 +++++++++
 drivers/gpu/drm/drm_gem.c | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index ae693c0666cd..ee3c4ad742c6 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -150,6 +150,15 @@ struct drm_gem_object_funcs {
 	 */
 	void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
 
+	/**
+	 * @mmap:
+	 *
+	 * Called by drm_gem_mmap() for additional checks/setup.
+	 *
+	 * This callback is optional.
+	 */
+	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
+
 	/**
 	 * @vm_ops:
 	 *
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index afc38cece3f5..84db8de217e1 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1105,6 +1105,8 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 		vma->vm_ops = obj->funcs->vm_ops;
 	else if (dev->driver->gem_vm_ops)
 		vma->vm_ops = dev->driver->gem_vm_ops;
+	else if (obj->funcs && obj->funcs->mmap)
+		/* obj->funcs->mmap must set vma->vm_ops */;
 	else
 		return -EINVAL;
 
@@ -1192,6 +1194,10 @@ int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	ret = drm_gem_mmap_obj(obj, drm_vma_node_size(node) << PAGE_SHIFT,
 			       vma);
 
+	if (ret == 0)
+		if (obj->funcs->mmap)
+			ret = obj->funcs->mmap(obj, vma);
+
 	drm_gem_object_put_unlocked(obj);
 
 	return ret;
-- 
2.18.1

