Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D0C20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPjpBRL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbfJVIF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:05:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44469 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388047AbfJVIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtZmqzFgxn1pwN65/xIkar281NrAbaBtoHehY0Fvb0U=;
        b=MPjpBRL9wGyDWQl+ejjQRXt0MRy4V0g7pJP1DyR1MNaTus7lYdXR+W0FV2jaNymjqppBZR
        EReESO5JVyx/ISonpwJ3uBjXNeqb0gXaO2KS4tuiZxiN2j2Hp+xFBMUDqkU7gRuPM3LX4t
        3Lq7ycdibw+NjQ+j+4EAHHZkZbTrqOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-quF3-_HKNCqdkw3peQ_QqA-1; Tue, 22 Oct 2019 04:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D687800D56;
        Tue, 22 Oct 2019 08:05:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 711B65C22C;
        Tue, 22 Oct 2019 08:05:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BFBCF9D76; Tue, 22 Oct 2019 10:05:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] drm/virtio: fix byteorder handling in virtio_gpu_cmd_transfer_{from,to}_host_3d functions
Date:   Tue, 22 Oct 2019 10:05:44 +0200
Message-Id: <20191022080546.19769-4-kraxel@redhat.com>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: quF3-_HKNCqdkw3peQ_QqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be consistent with the rest of the code base.
No functional change.

In theory this change is incompatible on bigendian machines,
but in practice 3d acceleration is supported only on little
endian machines, so the affected code paths never run on
bigendian machines.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 74ad3bc3ebe8..0bf60914ece2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -987,7 +987,12 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_=
gpu_device *vgdev,
 =09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D);
 =09cmd_p->hdr.ctx_id =3D cpu_to_le32(ctx_id);
 =09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
-=09cmd_p->box =3D *box;
+=09cmd_p->box.x =3D cpu_to_le32(box->x);
+=09cmd_p->box.y =3D cpu_to_le32(box->y);
+=09cmd_p->box.z =3D cpu_to_le32(box->z);
+=09cmd_p->box.w =3D cpu_to_le32(box->w);
+=09cmd_p->box.h =3D cpu_to_le32(box->h);
+=09cmd_p->box.d =3D cpu_to_le32(box->d);
 =09cmd_p->offset =3D cpu_to_le64(offset);
 =09cmd_p->level =3D cpu_to_le32(level);
=20
@@ -1013,7 +1018,12 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct vir=
tio_gpu_device *vgdev,
 =09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D);
 =09cmd_p->hdr.ctx_id =3D cpu_to_le32(ctx_id);
 =09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
-=09cmd_p->box =3D *box;
+=09cmd_p->box.x =3D cpu_to_le32(box->x);
+=09cmd_p->box.y =3D cpu_to_le32(box->y);
+=09cmd_p->box.z =3D cpu_to_le32(box->z);
+=09cmd_p->box.w =3D cpu_to_le32(box->w);
+=09cmd_p->box.h =3D cpu_to_le32(box->h);
+=09cmd_p->box.d =3D cpu_to_le32(box->d);
 =09cmd_p->offset =3D cpu_to_le64(offset);
 =09cmd_p->level =3D cpu_to_le32(level);
=20
--=20
2.18.1

