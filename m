Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A3721556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO9oaEGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfLKISV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:18:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51259 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727298AbfLKISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576052297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSCatYr1K7gbKR20Rl2b+FcJa0Soyo5HWbQNxR4Y05o=;
        b=cO9oaEGlC1JwBZKSko4MG4YY7k2wy2j3HDMHcqvsNj8tBWr4dFvcC0q5eD9nXqzZidbhp0
        Ox1azZzaYUIyeAx9/B2DYGYdceuH9mWRg1X/W8unYP0mDfUqFBxFxedO4Qni3ZyttMot6q
        VXrm03hgVKDNJzt9ecLQ57AKyY5VBIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-8paW8KCSOO-xypeXDDW1kw-1; Wed, 11 Dec 2019 03:18:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEF7800D41;
        Wed, 11 Dec 2019 08:18:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73B1F5C1B0;
        Wed, 11 Dec 2019 08:18:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C084D16E2D; Wed, 11 Dec 2019 09:18:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/shmem: add support for per object caching attributes
Date:   Wed, 11 Dec 2019 09:18:09 +0100
Message-Id: <20191211081810.20079-2-kraxel@redhat.com>
In-Reply-To: <20191211081810.20079-1-kraxel@redhat.com>
References: <20191211081810.20079-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8paW8KCSOO-xypeXDDW1kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add caching field to drm_gem_shmem_object to specify the cachine
attributes for mappings.  Add helper function to tweak pgprot
accordingly.  Switch vmap and mmap functions to the new helper.

Set caching to write-combine when creating the object so behavior
doesn't change by default.  Drivers can override that later if
needed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_shmem_helper.h     | 12 ++++++++++++
 drivers/gpu/drm/drm_gem_shmem_helper.c | 24 +++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem=
_helper.h
index 6748379a0b44..9d6e02c6205f 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -17,6 +17,11 @@ struct drm_mode_create_dumb;
 struct drm_printer;
 struct sg_table;
=20
+enum drm_gem_shmem_caching {
+=09DRM_GEM_SHMEM_CACHED =3D 1,
+=09DRM_GEM_SHMEM_WC,
+};
+
 /**
  * struct drm_gem_shmem_object - GEM object backed by shmem
  */
@@ -83,6 +88,11 @@ struct drm_gem_shmem_object {
 =09 * The address are un-mapped when the count reaches zero.
 =09 */
 =09unsigned int vmap_use_count;
+
+=09/**
+=09 * @caching: caching attributes for mappings.
+=09 */
+=09enum drm_gem_shmem_caching caching;
 };
=20
 #define to_drm_gem_shmem_obj(obj) \
@@ -130,6 +140,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *=
dev,
=20
 struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_object *obj);
=20
+pgprot_t drm_gem_shmem_caching(struct drm_gem_shmem_object *shmem, pgprot_=
t prot);
+
 /**
  * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
  *
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_g=
em_shmem_helper.c
index a421a2eed48a..5bb94e130a50 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -76,6 +76,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct =
drm_device *dev, size_t
 =09mutex_init(&shmem->pages_lock);
 =09mutex_init(&shmem->vmap_lock);
 =09INIT_LIST_HEAD(&shmem->madv_list);
+=09shmem->caching =3D DRM_GEM_SHMEM_WC;
=20
 =09/*
 =09 * Our buffers are kept pinned, so allocating them
@@ -256,9 +257,11 @@ static void *drm_gem_shmem_vmap_locked(struct drm_gem_=
shmem_object *shmem)
=20
 =09if (obj->import_attach)
 =09=09shmem->vaddr =3D dma_buf_vmap(obj->import_attach->dmabuf);
-=09else
+=09else {
+=09=09pgprot_t prot =3D drm_gem_shmem_caching(shmem, PAGE_KERNEL);
 =09=09shmem->vaddr =3D vmap(shmem->pages, obj->size >> PAGE_SHIFT,
-=09=09=09=09    VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+=09=09=09=09    VM_MAP, prot);
+=09}
=20
 =09if (!shmem->vaddr) {
 =09=09DRM_DEBUG_KMS("Failed to vmap pages\n");
@@ -540,7 +543,8 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, stru=
ct vm_area_struct *vma)
 =09}
=20
 =09vma->vm_flags |=3D VM_MIXEDMAP | VM_DONTEXPAND;
-=09vma->vm_page_prot =3D pgprot_writecombine(vm_get_page_prot(vma->vm_flag=
s));
+=09vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
+=09vma->vm_page_prot =3D drm_gem_shmem_caching(shmem, vma->vm_page_prot);
 =09vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
 =09vma->vm_ops =3D &drm_gem_shmem_vm_ops;
=20
@@ -683,3 +687,17 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device =
*dev,
 =09return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
+
+pgprot_t drm_gem_shmem_caching(struct drm_gem_shmem_object *shmem, pgprot_=
t prot)
+{
+=09switch (shmem->caching) {
+=09case DRM_GEM_SHMEM_CACHED:
+=09=09return prot;
+=09case DRM_GEM_SHMEM_WC:
+=09=09return pgprot_writecombine(prot);
+=09default:
+=09=09WARN_ON_ONCE(1);
+=09=09return prot;
+=09}
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_caching);
--=20
2.18.1

