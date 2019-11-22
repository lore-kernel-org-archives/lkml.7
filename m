Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73ECC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80C32068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRL8pris"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKVGiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:38:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726690AbfKVGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574404679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGdiHJQ3wd2tnmCCk4UsV27B6S6gW6jgkzpLlT5/3dc=;
        b=RRL8pris7IdJ+6m5viDBJTxRSX0RPLmu7Yw3eRnqimOPbOakAxF74cJ6kcOt8PPXjdfU80
        UildU/4G2hDvPg8mcNYrWcawoetNuon9p861tnmvKEzoXE8yfcZMdi3jokEPCa+1ioWbJe
        lD/uyRCCfHyP0pHEE+sUj6Lm36RhG7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-YVlJdhMFMU2QLu8_ieEFqQ-1; Fri, 22 Nov 2019 01:37:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89F2E100551C;
        Fri, 22 Nov 2019 06:37:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05EDB6E70E;
        Fri, 22 Nov 2019 06:37:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0AA0217536; Fri, 22 Nov 2019 07:37:50 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     robh@kernel.org, intel-gfx@lists.freedesktop.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm: call drm_gem_object_funcs.mmap with fake offset
Date:   Fri, 22 Nov 2019 07:37:48 +0100
Message-Id: <20191122063749.27113-2-kraxel@redhat.com>
In-Reply-To: <20191122063749.27113-1-kraxel@redhat.com>
References: <20191122063749.27113-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YVlJdhMFMU2QLu8_ieEFqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fake offset is going to stay, so change the calling convention for
drm_gem_object_funcs.mmap to include the fake offset.  Update all users
accordingly.

Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
handling for drm_gem_object_funcs.mmap") and on top then adds the fake
offset to  drm_gem_prime_mmap to make sure all paths leading to
obj->funcs->mmap are consistent.

Fixes: 83b8a6f242ea ("drm/gem: Fix mmap fake offset handling for drm_gem_ob=
ject_funcs.mmap")
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/drm/drm_gem.h                  | 4 +---
 drivers/gpu/drm/drm_gem.c              | 3 ---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
 drivers/gpu/drm/drm_prime.c            | 3 +++
 drivers/gpu/drm/ttm/ttm_bo_vm.c        | 7 -------
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 97a48165642c..0b375069cd48 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -159,9 +159,7 @@ struct drm_gem_object_funcs {
 =09 *
 =09 * The callback is used by by both drm_gem_mmap_obj() and
 =09 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
-=09 * used, the @mmap callback must set vma->vm_ops instead. The @mmap
-=09 * callback is always called with a 0 offset. The caller will remove
-=09 * the fake offset as necessary.
+=09 * used, the @mmap callback must set vma->vm_ops instead.
 =09 */
 =09int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
=20
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 2f2b889096b0..56f42e0f2584 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1106,9 +1106,6 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsi=
gned long obj_size,
 =09=09return -EINVAL;
=20
 =09if (obj->funcs && obj->funcs->mmap) {
-=09=09/* Remove the fake offset */
-=09=09vma->vm_pgoff -=3D drm_vma_node_start(&obj->vma_node);
-
 =09=09ret =3D obj->funcs->mmap(obj, vma);
 =09=09if (ret)
 =09=09=09return ret;
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_g=
em_shmem_helper.c
index 0810d3ef6961..a421a2eed48a 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -528,6 +528,9 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, stru=
ct vm_area_struct *vma)
 =09struct drm_gem_shmem_object *shmem;
 =09int ret;
=20
+=09/* Remove the fake offset */
+=09vma->vm_pgoff -=3D drm_vma_node_start(&obj->vma_node);
+
 =09shmem =3D to_drm_gem_shmem_obj(obj);
=20
 =09ret =3D drm_gem_shmem_get_pages(shmem);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 0814211b0f3f..a9633bd241bb 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -714,6 +714,9 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, stru=
ct vm_area_struct *vma)
 =09int ret;
=20
 =09if (obj->funcs && obj->funcs->mmap) {
+=09=09/* Add the fake offset */
+=09=09vma->vm_pgoff +=3D drm_vma_node_start(&obj->vma_node);
+
 =09=09ret =3D obj->funcs->mmap(obj, vma);
 =09=09if (ret)
 =09=09=09return ret;
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_v=
m.c
index e6495ca2630b..3e8c3de91ae4 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -514,13 +514,6 @@ EXPORT_SYMBOL(ttm_bo_mmap);
 int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *=
bo)
 {
 =09ttm_bo_get(bo);
-
-=09/*
-=09 * FIXME: &drm_gem_object_funcs.mmap is called with the fake offset
-=09 * removed. Add it back here until the rest of TTM works without it.
-=09 */
-=09vma->vm_pgoff +=3D drm_vma_node_start(&bo->base.vma_node);
-
 =09ttm_bo_mmap_vma_setup(bo, vma);
 =09return 0;
 }
--=20
2.18.1

