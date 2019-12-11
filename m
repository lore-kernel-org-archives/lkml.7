Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386A520652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWgqfe6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfLKISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:18:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728250AbfLKISV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576052299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvtkLdUSetwh2LM7748b/AtFetYeaJ3ZQNHZjoVf5YE=;
        b=RWgqfe6aYpQGw+kaQO9KjXjfwVsH4c1+5hlkWagoLvUf+A6NLrx10/ZvoFjo6oS4r+CjHS
        ETBPVuGk3zz310F5Pliuw0zpLVL6QZhivPWJqiHFzYccup1v1GLZWFCODqEyCW+yxf5yOq
        qTewbsi1STlRj9c/fX+FpU/7ZwnVVQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Cbc1t8c6NBaxf1aZQKiJ0A-1; Wed, 11 Dec 2019 03:18:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2631801E72;
        Wed, 11 Dec 2019 08:18:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89C7410013A1;
        Wed, 11 Dec 2019 08:18:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D8E871747D; Wed, 11 Dec 2019 09:18:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/virtio: fix mmap page attributes
Date:   Wed, 11 Dec 2019 09:18:10 +0100
Message-Id: <20191211081810.20079-3-kraxel@redhat.com>
In-Reply-To: <20191211081810.20079-1-kraxel@redhat.com>
References: <20191211081810.20079-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Cbc1t8c6NBaxf1aZQKiJ0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-gpu uses cached mappings, set shmem->caching accordingly.

Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index 017a9e0fc3bb..a0b5e5195816 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -118,6 +118,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *=
vgdev,
 =09shmem_obj =3D drm_gem_shmem_create(vgdev->ddev, params->size);
 =09if (IS_ERR(shmem_obj))
 =09=09return PTR_ERR(shmem_obj);
+=09shmem_obj->caching =3D DRM_GEM_SHMEM_CACHED;
 =09bo =3D gem_to_virtio_gpu_obj(&shmem_obj->base);
=20
 =09ret =3D virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
--=20
2.18.1

