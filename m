Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B26CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5029E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUldyGdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbfJVIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:05:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49215 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388019AbfJVIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJBqHCwpIBtwLyrKpDMAXOjT9q0eBo6gpCpHT0A5CYs=;
        b=bUldyGddilpkePhC+ulhauT+5S354eBhMnziXjg+LK+6M9qmB+l4ZLJWL+phWL9UbMDi/p
        aQtN2ZEKQ7kmKvIksWJiuqeC6siDpTfjhF/c/tw+K3dwLeI9qaUK6MPpd5QYWroaXMCLgq
        k/ZLok0pWUBJr6tj6S2YEqlqesVbDxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-yq8PqrZiMIu0kX-iL-wLUw-1; Tue, 22 Oct 2019 04:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2063F800D4E;
        Tue, 22 Oct 2019 08:05:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E4865C219;
        Tue, 22 Oct 2019 08:05:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7BE489D69; Tue, 22 Oct 2019 10:05:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/virtio: print a single line with device features
Date:   Tue, 22 Oct 2019 10:05:42 +0200
Message-Id: <20191022080546.19769-2-kraxel@redhat.com>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yq8PqrZiMIu0kX-iL-wLUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 0b3cdb0d83b0..2f5773e43557 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
 #ifdef __LITTLE_ENDIAN
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 =09=09vgdev->has_virgl_3d =3D true;
-=09DRM_INFO("virgl 3d acceleration %s\n",
-=09=09 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
-#else
-=09DRM_INFO("virgl 3d acceleration not supported by guest\n");
 #endif
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 =09=09vgdev->has_edid =3D true;
-=09=09DRM_INFO("EDID support available.\n");
 =09}
=20
+=09DRM_INFO("features: %cvirgl %cedid\n",
+=09=09 vgdev->has_virgl_3d ? '+' : '-',
+=09=09 vgdev->has_edid     ? '+' : '-');
+
 =09ret =3D virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 =09if (ret) {
 =09=09DRM_ERROR("failed to find virt queues\n");
--=20
2.18.1

