Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF890C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BFB207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQ9L+mzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKMN4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:56:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46244 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbfKMN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573653401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DahN3FKCGNPvbmWogZVF9bc0DBD4WYj2MI4we4l1rhA=;
        b=QQ9L+mzxFibXTRZ5WpnvE3nFp4Q7Gb/xmEBR5tMWa4LzcCzFkLbAmMbvHetEP9MtyKR64y
        dCNItV+se1jXfZu80H+SGp1xsvPvC4w4auzFlTdMLYVZKm+1rXgsk7gWGIv/0A8KQrGLqo
        ugKIR8Z0FTyonYUs9Ck2RRsYyrWzLiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-lsStrGfrPwSwIV-pQUc2SQ-1; Wed, 13 Nov 2019 08:56:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B5710953CE;
        Wed, 13 Nov 2019 13:56:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com [10.36.116.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8F1990A8;
        Wed, 13 Nov 2019 13:56:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7DDA811AAA; Wed, 13 Nov 2019 14:56:30 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     drm@redhat.com
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/ttm: fix mmap refcounting
Date:   Wed, 13 Nov 2019 14:56:12 +0100
Message-Id: <20191113135612.19679-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lsStrGfrPwSwIV-pQUc2SQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mapping ttm objects via drm_gem_ttm_mmap() helper
drm_gem_mmap_obj() will take an object reference.  That gets
never released due to ttm having its own reference counting.

Fix that by dropping the gem object reference once the ttm mmap
completed (and ttm refcount got bumped).

For that to work properly the drm_gem_object_get() call in
drm_gem_ttm_mmap() must be moved so it happens before calling
obj->funcs->mmap(), otherwise the gem refcount would go down
to zero.

Fixes: 231927d939f0 ("drm/ttm: add drm_gem_ttm_mmap()")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_gem.c            | 24 ++++++++++++++----------
 drivers/gpu/drm/drm_gem_ttm_helper.c | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 2f2b889096b0..000fa4a1899f 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1105,21 +1105,33 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, un=
signed long obj_size,
 =09if (obj_size < vma->vm_end - vma->vm_start)
 =09=09return -EINVAL;
=20
+=09/* Take a ref for this mapping of the object, so that the fault
+=09 * handler can dereference the mmap offset's pointer to the object.
+=09 * This reference is cleaned up by the corresponding vm_close
+=09 * (which should happen whether the vma was created by this call, or
+=09 * by a vm_open due to mremap or partial unmap or whatever).
+=09 */
+=09drm_gem_object_get(obj);
+
 =09if (obj->funcs && obj->funcs->mmap) {
 =09=09/* Remove the fake offset */
 =09=09vma->vm_pgoff -=3D drm_vma_node_start(&obj->vma_node);
=20
 =09=09ret =3D obj->funcs->mmap(obj, vma);
-=09=09if (ret)
+=09=09if (ret) {
+=09=09=09drm_gem_object_put_unlocked(obj);
 =09=09=09return ret;
+=09=09}
 =09=09WARN_ON(!(vma->vm_flags & VM_DONTEXPAND));
 =09} else {
 =09=09if (obj->funcs && obj->funcs->vm_ops)
 =09=09=09vma->vm_ops =3D obj->funcs->vm_ops;
 =09=09else if (dev->driver->gem_vm_ops)
 =09=09=09vma->vm_ops =3D dev->driver->gem_vm_ops;
-=09=09else
+=09=09else {
+=09=09=09drm_gem_object_put_unlocked(obj);
 =09=09=09return -EINVAL;
+=09=09}
=20
 =09=09vma->vm_flags |=3D VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 =09=09vma->vm_page_prot =3D pgprot_writecombine(vm_get_page_prot(vma->vm_f=
lags));
@@ -1128,14 +1140,6 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, uns=
igned long obj_size,
=20
 =09vma->vm_private_data =3D obj;
=20
-=09/* Take a ref for this mapping of the object, so that the fault
-=09 * handler can dereference the mmap offset's pointer to the object.
-=09 * This reference is cleaned up by the corresponding vm_close
-=09 * (which should happen whether the vma was created by this call, or
-=09 * by a vm_open due to mremap or partial unmap or whatever).
-=09 */
-=09drm_gem_object_get(obj);
-
 =09return 0;
 }
 EXPORT_SYMBOL(drm_gem_mmap_obj);
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem=
_ttm_helper.c
index 7412bfc5c05a..605a8a3da7f9 100644
--- a/drivers/gpu/drm/drm_gem_ttm_helper.c
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -64,8 +64,19 @@ int drm_gem_ttm_mmap(struct drm_gem_object *gem,
 =09=09     struct vm_area_struct *vma)
 {
 =09struct ttm_buffer_object *bo =3D drm_gem_ttm_of_gem(gem);
+=09int ret;
=20
-=09return ttm_bo_mmap_obj(vma, bo);
+=09ret =3D ttm_bo_mmap_obj(vma, bo);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/*
+=09 * ttm has its own object refcounting, so drop gem reference
+=09 * to avoid double accounting counting.
+=09 */
+=09drm_gem_object_put_unlocked(gem);
+
+=09return 0;
 }
 EXPORT_SYMBOL(drm_gem_ttm_mmap);
=20
--=20
2.18.1

