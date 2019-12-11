Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB045C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904D9214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilGDDQPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfLKMUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:20:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729146AbfLKMUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576066808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkdD4/AJY6bHnmvm2xfOY1Z5pyo8lh7Kbp9qetU0nC8=;
        b=ilGDDQPjEeDoEEqDiXjP8MahyzLruMwc7pFrwtvHzjRL06n2X9KdD2EeVxU420aEE23qrE
        3rdndF0JMx4CtSBYcYKXo5GKS8Y6KaaNv3BK+d7AJ3z/F97ovJI6E4igubuqK9cEW8OVjN
        44Pz6eSWaAV5KvVudn1rdlomJKqR0DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-UBI4tOyRMcmcvF9FM1qicw-1; Wed, 11 Dec 2019 07:20:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718631804488;
        Wed, 11 Dec 2019 12:20:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1533260BE0;
        Wed, 11 Dec 2019 12:19:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5B1421747D; Wed, 11 Dec 2019 13:19:57 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/4] drm/shmem: add support for per object caching flags.
Date:   Wed, 11 Dec 2019 13:19:54 +0100
Message-Id: <20191211121957.18637-3-kraxel@redhat.com>
In-Reply-To: <20191211121957.18637-1-kraxel@redhat.com>
References: <20191211121957.18637-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UBI4tOyRMcmcvF9FM1qicw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_gem_pgprot_wc() as pgprot callback in drm_gem_shmem_funcs.
Use drm_gem_pgprot() to update pgprot caching flags.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_g=
em_shmem_helper.c
index a421a2eed48a..2a662ed77115 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -33,6 +33,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_fu=
ncs =3D {
 =09.vmap =3D drm_gem_shmem_vmap,
 =09.vunmap =3D drm_gem_shmem_vunmap,
 =09.mmap =3D drm_gem_shmem_mmap,
+=09.pgprot =3D drm_gem_pgprot_wc,
 };
=20
 /**
@@ -258,7 +259,7 @@ static void *drm_gem_shmem_vmap_locked(struct drm_gem_s=
hmem_object *shmem)
 =09=09shmem->vaddr =3D dma_buf_vmap(obj->import_attach->dmabuf);
 =09else
 =09=09shmem->vaddr =3D vmap(shmem->pages, obj->size >> PAGE_SHIFT,
-=09=09=09=09    VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+=09=09=09=09    VM_MAP, drm_gem_pgprot(obj, PAGE_KERNEL));
=20
 =09if (!shmem->vaddr) {
 =09=09DRM_DEBUG_KMS("Failed to vmap pages\n");
@@ -540,7 +541,8 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, stru=
ct vm_area_struct *vma)
 =09}
=20
 =09vma->vm_flags |=3D VM_MIXEDMAP | VM_DONTEXPAND;
-=09vma->vm_page_prot =3D pgprot_writecombine(vm_get_page_prot(vma->vm_flag=
s));
+=09vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
+=09vma->vm_page_prot =3D drm_gem_pgprot(obj, vma->vm_page_prot);
 =09vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
 =09vma->vm_ops =3D &drm_gem_shmem_vm_ops;
=20
--=20
2.18.1

