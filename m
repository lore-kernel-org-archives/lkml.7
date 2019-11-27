Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04649C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BFC204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnJ4KM7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfK0JZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:25:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbfK0JZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574846732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5z9r04AnLOvBsT/Uxl53eyYluiyIniRuU4OD04klCdw=;
        b=RnJ4KM7QY42TfaOcIwUOPHeaASmMcdu0TMXGjoF4f818ExibjerMm1r6atOO2U7ZE1HvQp
        L/t8dGhYflJxHvMPSWsrQADoA42MP431Je5ZMGm8nnG0NMNhFIXt2JNtopgHDaLAp0g+wl
        IF1O/PDitFbu/mSUKGoYVVwoxQp/zHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-uDvwzbvnNgu0saOxSAtQZA-1; Wed, 27 Nov 2019 04:25:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6825B18543AF;
        Wed, 27 Nov 2019 09:25:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5C1C60BE2;
        Wed, 27 Nov 2019 09:25:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 07DBC9DB3; Wed, 27 Nov 2019 10:25:24 +0100 (CET)
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
Subject: [PATCH v3 2/2] drm: share address space for dma bufs
Date:   Wed, 27 Nov 2019 10:25:23 +0100
Message-Id: <20191127092523.5620-3-kraxel@redhat.com>
In-Reply-To: <20191127092523.5620-1-kraxel@redhat.com>
References: <20191127092523.5620-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uDvwzbvnNgu0saOxSAtQZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
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
index a0f929c7117b..86d9b0e45c8c 100644
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

