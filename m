Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B154C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C340214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuWLwj81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfLKMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:20:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727365AbfLKMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576066803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CO314128W7CDNlXEcy+PWsJG51Toka8m6TWFPQjhhH4=;
        b=JuWLwj81zqtQF8e+LsBv8NGYKCsZNglL4nfnKcdi4tf/FKyvx6dOXCEVfMn/EIbsb6EsCS
        LPjPz7SkeoQzoznOSnZ8fWtsX+r5WlarJGMx3Et/xAtORd7cTemSe+Ui4AfhZc+MVHWdCT
        KuPRKohOLyiJbdM5GsqS6jChUcHys24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ptuNYTXuPj6rCyVckKaV4A-1; Wed, 11 Dec 2019 07:20:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C40E31804488;
        Wed, 11 Dec 2019 12:20:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 464BC6364F;
        Wed, 11 Dec 2019 12:19:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 91A7A17538; Wed, 11 Dec 2019 13:19:57 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] drm/udl: simplify gem object mapping.
Date:   Wed, 11 Dec 2019 13:19:56 +0100
Message-Id: <20191211121957.18637-5-kraxel@redhat.com>
In-Reply-To: <20191211121957.18637-1-kraxel@redhat.com>
References: <20191211121957.18637-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ptuNYTXuPj6rCyVckKaV4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With shmem helpers allowing to update pgprot caching flags via
drm_gem_object_funcs.pgprot we can just use that and ditch our own
implementations of mmap() and vmap().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/udl/udl_gem.c | 62 ++++-------------------------------
 1 file changed, 7 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
index b6e26f98aa0a..b82a4a921f1b 100644
--- a/drivers/gpu/drm/udl/udl_gem.c
+++ b/drivers/gpu/drm/udl/udl_gem.c
@@ -17,61 +17,12 @@
  * GEM object funcs
  */
=20
-static int udl_gem_object_mmap(struct drm_gem_object *obj,
-=09=09=09       struct vm_area_struct *vma)
+static pgprot_t udl_gem_object_pgprot(struct drm_gem_object *obj,
+=09=09=09=09      pgprot_t pgprot)
 {
-=09int ret;
-
-=09ret =3D drm_gem_shmem_mmap(obj, vma);
-=09if (ret)
-=09=09return ret;
-
-=09vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
 =09if (obj->import_attach)
-=09=09vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
-=09vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
-
-=09return 0;
-}
-
-static void *udl_gem_object_vmap(struct drm_gem_object *obj)
-{
-=09struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
-=09int ret;
-
-=09ret =3D mutex_lock_interruptible(&shmem->vmap_lock);
-=09if (ret)
-=09=09return ERR_PTR(ret);
-
-=09if (shmem->vmap_use_count++ > 0)
-=09=09goto out;
-
-=09ret =3D drm_gem_shmem_get_pages(shmem);
-=09if (ret)
-=09=09goto err_zero_use;
-
-=09if (obj->import_attach)
-=09=09shmem->vaddr =3D dma_buf_vmap(obj->import_attach->dmabuf);
-=09else
-=09=09shmem->vaddr =3D vmap(shmem->pages, obj->size >> PAGE_SHIFT,
-=09=09=09=09    VM_MAP, PAGE_KERNEL);
-
-=09if (!shmem->vaddr) {
-=09=09DRM_DEBUG_KMS("Failed to vmap pages\n");
-=09=09ret =3D -ENOMEM;
-=09=09goto err_put_pages;
-=09}
-
-out:
-=09mutex_unlock(&shmem->vmap_lock);
-=09return shmem->vaddr;
-
-err_put_pages:
-=09drm_gem_shmem_put_pages(shmem);
-err_zero_use:
-=09shmem->vmap_use_count =3D 0;
-=09mutex_unlock(&shmem->vmap_lock);
-=09return ERR_PTR(ret);
+=09=09pgprot =3D pgprot_writecombine(pgprot);
+=09return pgprot;
 }
=20
 static const struct drm_gem_object_funcs udl_gem_object_funcs =3D {
@@ -80,9 +31,10 @@ static const struct drm_gem_object_funcs udl_gem_object_=
funcs =3D {
 =09.pin =3D drm_gem_shmem_pin,
 =09.unpin =3D drm_gem_shmem_unpin,
 =09.get_sg_table =3D drm_gem_shmem_get_sg_table,
-=09.vmap =3D udl_gem_object_vmap,
+=09.vmap =3D drm_gem_shmem_vmap,
 =09.vunmap =3D drm_gem_shmem_vunmap,
-=09.mmap =3D udl_gem_object_mmap,
+=09.mmap =3D drm_gem_shmem_mmap,
+=09.pgprot =3D udl_gem_object_pgprot,
 };
=20
 /*
--=20
2.18.1

