Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC6FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D414220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391207AbfJPLwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbfJPLwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89A983082E0F;
        Wed, 16 Oct 2019 11:52:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11C565D6B2;
        Wed, 16 Oct 2019 11:52:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 00BF831E46; Wed, 16 Oct 2019 13:52:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/11] drm: add mmap() to drm_gem_object_funcs
Date:   Wed, 16 Oct 2019 13:51:53 +0200
Message-Id: <20191016115203.20095-2-kraxel@redhat.com>
In-Reply-To: <20191016115203.20095-1-kraxel@redhat.com>
References: <20191016115203.20095-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 16 Oct 2019 11:52:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_object_funcs->vm_ops alone can't handle everything which needs
to be done for mmap(), tweaking vm_flags for example.  So add a new
mmap() callback to drm_gem_object_funcs where this code can go to.

Note that the vm_ops field is not used in case the mmap callback is
present, it is expected that the callback sets vma->vm_ops instead.

Also setting vm_flags and vm_page_prot is the job of the new callback.
so drivers have more control over these flags.

drm_gem_mmap_obj() will use the new callback for object specific mmap
setup.  With this in place the need for driver-speific fops->mmap
callbacks goes away, drm_gem_mmap can be hooked instead.

drm_gem_prime_mmap() will use the new callback too to just mmap gem
objects directly instead of jumping though loops to make
drm_gem_object_lookup() and fops->mmap work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/drm/drm_gem.h       | 14 ++++++++++++++
 drivers/gpu/drm/drm_gem.c   | 27 ++++++++++++++++++---------
 drivers/gpu/drm/drm_prime.c |  9 +++++++++
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 6aaba14f5972..e71f75a2ab57 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -150,6 +150,20 @@ struct drm_gem_object_funcs {
 	 */
 	void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
 
+	/**
+	 * @mmap:
+	 *
+	 * Handle mmap() of the gem object, setup vma accordingly.
+	 *
+	 * This callback is optional.
+	 *
+	 * The callback is used by by both drm_gem_mmap_obj() and
+	 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
+	 * used, the @mmap callback must set vma->vm_ops instead.
+	 *
+	 */
+	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
+
 	/**
 	 * @vm_ops:
 	 *
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6854f5867d51..56f42e0f2584 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1099,22 +1099,31 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 		     struct vm_area_struct *vma)
 {
 	struct drm_device *dev = obj->dev;
+	int ret;
 
 	/* Check for valid size. */
 	if (obj_size < vma->vm_end - vma->vm_start)
 		return -EINVAL;
 
-	if (obj->funcs && obj->funcs->vm_ops)
-		vma->vm_ops = obj->funcs->vm_ops;
-	else if (dev->driver->gem_vm_ops)
-		vma->vm_ops = dev->driver->gem_vm_ops;
-	else
-		return -EINVAL;
+	if (obj->funcs && obj->funcs->mmap) {
+		ret = obj->funcs->mmap(obj, vma);
+		if (ret)
+			return ret;
+		WARN_ON(!(vma->vm_flags & VM_DONTEXPAND));
+	} else {
+		if (obj->funcs && obj->funcs->vm_ops)
+			vma->vm_ops = obj->funcs->vm_ops;
+		else if (dev->driver->gem_vm_ops)
+			vma->vm_ops = dev->driver->gem_vm_ops;
+		else
+			return -EINVAL;
+
+		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
+		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+	}
 
-	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_private_data = obj;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
-	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* Take a ref for this mapping of the object, so that the fault
 	 * handler can dereference the mmap offset's pointer to the object.
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 0a2316e0e812..0814211b0f3f 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -713,6 +713,15 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	struct file *fil;
 	int ret;
 
+	if (obj->funcs && obj->funcs->mmap) {
+		ret = obj->funcs->mmap(obj, vma);
+		if (ret)
+			return ret;
+		vma->vm_private_data = obj;
+		drm_gem_object_get(obj);
+		return 0;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	fil = kzalloc(sizeof(*fil), GFP_KERNEL);
 	if (!priv || !fil) {
-- 
2.18.1

