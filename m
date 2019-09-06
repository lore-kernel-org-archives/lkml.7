Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B122C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759E52082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391814AbfIFMNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfIFMNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C44A11DB3;
        Fri,  6 Sep 2019 12:13:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-59.ams2.redhat.com [10.36.117.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3756910016EB;
        Fri,  6 Sep 2019 12:13:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4417D31EBF; Fri,  6 Sep 2019 14:13:18 +0200 (CEST)
Date:   Fri, 6 Sep 2019 14:13:18 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/17] drm: add mmap() to drm_gem_object_funcs
Message-ID: <20190906121318.r4nvoacazvwukuun@sirius.home.kraxel.org>
References: <20190808134417.10610-1-kraxel@redhat.com>
 <20190808134417.10610-6-kraxel@redhat.com>
 <20190903094859.GQ2112@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903094859.GQ2112@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 06 Sep 2019 12:13:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I think if we do an mmap callback, it should replace all the mmap handling
> (except the drm_gem_object_get) that drm_gem_mmap_obj does. So maybe
> something like the below:

[ snip ]

> Since I remember quite a few discussions where the default vma flag
> wrangling we're doing is seriously getting in the way of things too.

Yep, makes sense.

> I think even better would be if this new ->mmap hook could also be used
> directly by the dma-buf mmap code, without having to jump through hoops
> creating a fake file and fake vma offset and everything. I think with that
> we'd have a really solid case to add this ->mmap hook.

Looks easy on a quick glance.  So something like the patch below (quick
sketch, not tested yet other than compiling it)?

cheers,
  Gerd

From c13b30d776fb593a03473fa3bc93baf470cba728 Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Jun 2019 14:26:51 +0200
Subject: [PATCH] drm: add mmap() to drm_gem_object_funcs

drm_gem_object_funcs->vm_ops alone can't handle everything which needs
to be done for mmap(), tweaking vm_flags for example.  So add a new
mmap() callback to drm_gem_object_funcs where this code can go to.

Note that the vm_ops field is not used in case the mmap callback is
presnt, it is expected that the callback sets vma->vm_ops instead.

drm_gem_mmap_obj() will use the new callback for object specific mmap
setup.  With this in place the need for driver-speific fops->mmap
callbacks goes away, drm_gem_mmap can be hooked instead.

drm_gem_prime_mmap() will use the new callback too to just mmap gem
objects directly instead of jumping though loops to make
drm_gem_object_lookup() and fops->mmap work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem.h       | 14 ++++++++++++++
 drivers/gpu/drm/drm_gem.c   | 26 +++++++++++++++++---------
 drivers/gpu/drm/drm_prime.c |  9 +++++++++
 3 files changed, 40 insertions(+), 9 deletions(-)

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
index 6854f5867d51..aabde003ac4a 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1099,22 +1099,30 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
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

