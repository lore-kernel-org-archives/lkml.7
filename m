Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28973C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4A22068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiGVLPEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKVGiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:38:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35953 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbfKVGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574404679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kO/f20OK8ehETRWvdOhwDSCz6FJfjfQn0GgthZnU0Rc=;
        b=OiGVLPEhhszZ08NhUsVnCAzZLQTHi5Pr/l/afZGSx9aXBpGP2HPK3BYM1TR7TYGx/xsdpP
        dxL/EP1ej7bSd0xiadpvzXSRwzSPw+YfeLE/Ir+t+vIRODyKIy/n+JiTBZCamz87rjomqD
        LgjFLGfISWVNlgaHmax7M2PUDOOYyuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-TBtFseKXMp6LDL4WsY81WA-1; Fri, 22 Nov 2019 01:37:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22958593CE;
        Fri, 22 Nov 2019 06:37:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05F975DF2C;
        Fri, 22 Nov 2019 06:37:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2B368A1E0; Fri, 22 Nov 2019 07:37:50 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     robh@kernel.org, intel-gfx@lists.freedesktop.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm: share address space for dma bufs
Date:   Fri, 22 Nov 2019 07:37:49 +0100
Message-Id: <20191122063749.27113-3-kraxel@redhat.com>
In-Reply-To: <20191122063749.27113-1-kraxel@redhat.com>
References: <20191122063749.27113-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TBtFseKXMp6LDL4WsY81WA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the shared address space of the drm device (see drm_open() in
drm_file.c) for dma-bufs too.  That removes a difference betweem drm
device mmap vmas and dma-buf mmap vmas and fixes corner cases like
dropping ptes (using madvise(DONTNEED) for example) not working
properly.

Also remove amdgpu driver's private dmabuf update.  It is not needed
any more now that we are doing this for everybody.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +---
 drivers/gpu/drm/drm_prime.c                 | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index d5bcdfefbad6..586db4fb46bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -361,10 +361,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem=
_object *gobj,
 =09=09return ERR_PTR(-EPERM);
=20
 =09buf =3D drm_gem_prime_export(gobj, flags);
-=09if (!IS_ERR(buf)) {
-=09=09buf->file->f_mapping =3D gobj->dev->anon_inode->i_mapping;
+=09if (!IS_ERR(buf))
 =09=09buf->ops =3D &amdgpu_dmabuf_ops;
-=09}
=20
 =09return buf;
 }
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index a9633bd241bb..c3fc341453c0 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_fi=
le_private *prime_fpriv)
 struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
 =09=09=09=09      struct dma_buf_export_info *exp_info)
 {
+=09struct drm_gem_object *obj =3D exp_info->priv;
 =09struct dma_buf *dma_buf;
=20
 =09dma_buf =3D dma_buf_export(exp_info);
@@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device=
 *dev,
 =09=09return dma_buf;
=20
 =09drm_dev_get(dev);
-=09drm_gem_object_get(exp_info->priv);
+=09drm_gem_object_get(obj);
+=09dma_buf->file->f_mapping =3D obj->dev->anon_inode->i_mapping;
=20
 =09return dma_buf;
 }
--=20
2.18.1

