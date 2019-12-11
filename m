Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E842173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RX5+qDSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfLKMUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:20:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729117AbfLKMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576066806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aya/nycTrUQ34itusmCkgEMEDKSIN7dICC56yrlcxiA=;
        b=RX5+qDSux4bEGHeDt/pP8WfypqDIXYIad1G6OwYm2MDaSaCnkUuUD3pwNOPQWzLulICW85
        PIPxk6+Jcin/P5m1C7AzAeF2RyOe+iycFbrLGiUDGf7WV6SlZyOhxSrFT5FrtsgJBYuyaT
        8kGYqrdwnZ6CwMw+0RI/NjnYtcKYp5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-VbEHjdUdNpma6zsmh9Vx_A-1; Wed, 11 Dec 2019 07:20:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64BE5800D4C;
        Wed, 11 Dec 2019 12:20:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B25719756;
        Wed, 11 Dec 2019 12:19:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3DB3616E2D; Wed, 11 Dec 2019 13:19:57 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] drm: add pgprot callback to drm_gem_object_funcs
Date:   Wed, 11 Dec 2019 13:19:53 +0100
Message-Id: <20191211121957.18637-2-kraxel@redhat.com>
In-Reply-To: <20191211121957.18637-1-kraxel@redhat.com>
References: <20191211121957.18637-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VbEHjdUdNpma6zsmh9Vx_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback allows drivers and helpers to tweak pgprot for mappings.
This is especially helpful when using shmem helpers.  It allows drivers
to switch mappings from writecombine (default) to something else (cached
for example) on a per-object base without having to supply their own
mmap() and vmap() functions.

The patch also adds two implementations for the callback, for cached and
writecombine mappings, and the drm_gem_pgprot() function to update
pgprot for a given object, using the new &drm_gem_object_funcs.pgprot
callback if available.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem.h     | 15 +++++++++++++
 drivers/gpu/drm/drm_gem.c | 46 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 0b375069cd48..5beef7226e69 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -163,6 +163,17 @@ struct drm_gem_object_funcs {
 =09 */
 =09int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
=20
+=09/**
+=09 * @pgprot:
+=09 *
+=09 * Tweak pgprot as needed, typically used to set cache bits.
+=09 *
+=09 * This callback is optional.
+=09 *
+=09 * If unset drm_gem_pgprot_wc() will be used.
+=09 */
+=09pgprot_t (*pgprot)(struct drm_gem_object *obj, pgprot_t prot);
+
 =09/**
 =09 * @vm_ops:
 =09 *
@@ -350,6 +361,10 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsig=
ned long obj_size,
 =09=09     struct vm_area_struct *vma);
 int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
=20
+pgprot_t drm_gem_pgprot_cached(struct drm_gem_object *obj, pgprot_t prot);
+pgprot_t drm_gem_pgprot_wc(struct drm_gem_object *obj, pgprot_t prot);
+pgprot_t drm_gem_pgprot(struct drm_gem_object *obj, pgprot_t prot);
+
 /**
  * drm_gem_object_get - acquire a GEM buffer object reference
  * @obj: GEM buffer object
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 56f42e0f2584..1c468fe8e342 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1119,7 +1119,8 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsi=
gned long obj_size,
 =09=09=09return -EINVAL;
=20
 =09=09vma->vm_flags |=3D VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
-=09=09vma->vm_page_prot =3D pgprot_writecombine(vm_get_page_prot(vma->vm_f=
lags));
+=09=09vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
+=09=09vma->vm_page_prot =3D drm_gem_pgprot(obj, vma->vm_page_prot);
 =09=09vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
 =09}
=20
@@ -1210,6 +1211,49 @@ int drm_gem_mmap(struct file *filp, struct vm_area_s=
truct *vma)
 }
 EXPORT_SYMBOL(drm_gem_mmap);
=20
+/**
+ * drm_gem_mmap - update pgprot for objects needing a cachable mapping.
+ * @obj: the GEM object.
+ * @prot: page attributes.
+ *
+ * This function can be used as &drm_gem_object_funcs.pgprot callback.
+ */
+pgprot_t drm_gem_pgprot_cached(struct drm_gem_object *obj, pgprot_t prot)
+{
+=09return prot;
+}
+EXPORT_SYMBOL(drm_gem_pgprot_cached);
+
+/**
+ * drm_gem_mmap - update pgprot for objects needing a wc mapping.
+ * @obj: the GEM object.
+ * @prot: page attributes.
+ *
+ * This function can be used as &drm_gem_object_funcs.pgprot callback.
+ */
+pgprot_t drm_gem_pgprot_wc(struct drm_gem_object *obj, pgprot_t prot)
+{
+=09return pgprot_writecombine(prot);
+}
+EXPORT_SYMBOL(drm_gem_pgprot_wc);
+
+/**
+ * drm_gem_mmap - update pgprot for a given gem object.
+ * @obj: the GEM object.
+ * @prot: page attributes.
+ *
+ * This function updates pgprot according to the needs of the given
+ * object.  If present &drm_gem_object_funcs.pgprot callback will be
+ * used, otherwise drm_gem_pgprot_wc() is called.
+ */
+pgprot_t drm_gem_pgprot(struct drm_gem_object *obj, pgprot_t prot)
+{
+=09if (obj->funcs->pgprot)
+=09=09return obj->funcs->pgprot(obj, prot);
+=09return drm_gem_pgprot_wc(obj, prot);
+}
+EXPORT_SYMBOL(drm_gem_pgprot);
+
 void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
 =09=09=09const struct drm_gem_object *obj)
 {
--=20
2.18.1

