Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21612C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E919B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC4m+eGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLJI6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:58:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44470 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbfLJI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575968286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B3uP/SCLcrRR2RNPhR22qrcwSwHoRfQCsZKJS7KksnQ=;
        b=VC4m+eGQ6oH95ORhmLzG8U1x8ML66UTQmCiuTYY/aFW1LCpdj0GithjWaQI5u2ppREvBbN
        FKovdk90BEwBPeBxROqvWax6TGgXPsbkE7rst4lyoG6kaAHh99UKjjZ/nLZgH2exPL+dxm
        vR2SJ5xQlW8K7fpSfjJFJm7fuOLzIe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-5yTMreCZOyGtterTydZw-g-1; Tue, 10 Dec 2019 03:58:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA41318557E6;
        Tue, 10 Dec 2019 08:58:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E04E6F12C;
        Tue, 10 Dec 2019 08:58:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 95C5E16E18; Tue, 10 Dec 2019 09:57:59 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: fix mmap page attributes
Date:   Tue, 10 Dec 2019 09:57:59 +0100
Message-Id: <20191210085759.14763-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5yTMreCZOyGtterTydZw-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-gpu uses cached mappings.  shmem helpers use writecombine though.
So roll our own mmap function, wrapping drm_gem_shmem_mmap(), to tweak
vm_page_prot accordingly.

Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index 017a9e0fc3bb..158610902054 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -75,6 +75,22 @@ static void virtio_gpu_free_object(struct drm_gem_object=
 *obj)
 =09drm_gem_shmem_free_object(obj);
 }
=20
+static int virtio_gpu_gem_mmap(struct drm_gem_object *obj, struct vm_area_=
struct *vma)
+{
+=09pgprot_t prot;
+=09int ret;
+
+=09ret =3D drm_gem_shmem_mmap(obj, vma);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/* virtio-gpu needs normal caching, so clear writecombine */
+=09prot =3D vm_get_page_prot(vma->vm_flags);
+=09prot =3D pgprot_decrypted(prot);
+=09vma->vm_page_prot =3D prot;
+=09return 0;
+}
+
 static const struct drm_gem_object_funcs virtio_gpu_gem_funcs =3D {
 =09.free =3D virtio_gpu_free_object,
 =09.open =3D virtio_gpu_gem_object_open,
@@ -86,7 +102,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_=
funcs =3D {
 =09.get_sg_table =3D drm_gem_shmem_get_sg_table,
 =09.vmap =3D drm_gem_shmem_vmap,
 =09.vunmap =3D drm_gem_shmem_vunmap,
-=09.mmap =3D &drm_gem_shmem_mmap,
+=09.mmap =3D &virtio_gpu_gem_mmap,
 };
=20
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
--=20
2.18.1

