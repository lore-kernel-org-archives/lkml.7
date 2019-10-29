Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EEDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DA320862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBhh53sJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfJ2K7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:59:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55317 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727222AbfJ2K7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572346770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bznT7rhcp8ud8WeGAKqJrKndjLj9XWfScadDTu5pjM8=;
        b=fBhh53sJe5F86fMh8B+jgp3sYv/4h4LvtWrmDq6LXCj3cDyd+BgyUdzMKrVLPmTDRxv0pP
        DRYDR789aJQyoY6PHXJ/1/ca+NUAqzRXJOpejnnK/8wy8p2TK4RwEssLBsuU9IE3e7sQxz
        LuEyH+cMmCVGD99CFzTqlQbm/HppHfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-NVxtE9rrM6qQTzdZYfcDdw-1; Tue, 29 Oct 2019 06:59:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E026476;
        Tue, 29 Oct 2019 10:59:26 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31FA95C1D8;
        Tue, 29 Oct 2019 10:59:10 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com, lulu@redhat.com
Subject: [RFC PATCH 1/2] virtio: accept parent as a parameter when allocating virtqueue
Date:   Tue, 29 Oct 2019 18:58:42 +0800
Message-Id: <20191029105843.12061-2-jasowang@redhat.com>
In-Reply-To: <20191029105843.12061-1-jasowang@redhat.com>
References: <20191029105843.12061-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: NVxtE9rrM6qQTzdZYfcDdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bdc08244a648..51d83f4d7c32 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -269,12 +269,12 @@ size_t virtio_max_dma_size(struct virtio_device *vdev=
)
 }
 EXPORT_SYMBOL_GPL(virtio_max_dma_size);
=20
-static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-=09=09=09      dma_addr_t *dma_handle, gfp_t flag)
+static void *vring_alloc_queue(struct virtio_device *vdev,
+=09=09=09       struct device *parent, size_t size,
+=09=09=09       dma_addr_t *dma_handle, gfp_t flag)
 {
 =09if (vring_use_dma_api(vdev)) {
-=09=09return dma_alloc_coherent(vdev->dev.parent, size,
-=09=09=09=09=09  dma_handle, flag);
+=09=09return dma_alloc_coherent(parent, size, dma_handle, flag);
 =09} else {
 =09=09void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), flag);
=20
@@ -859,6 +859,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 =09dma_addr_t dma_addr;
 =09size_t queue_size_in_bytes;
 =09struct vring vring;
+=09struct device *parent =3D vdev->dev.parent;
=20
 =09/* We assume num is a power of 2. */
 =09if (num & (num - 1)) {
@@ -868,7 +869,8 @@ static struct virtqueue *vring_create_virtqueue_split(
=20
 =09/* TODO: allocate each queue chunk individually */
 =09for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /=3D 2) {
-=09=09queue =3D vring_alloc_queue(vdev, vring_size(num, vring_align),
+=09=09queue =3D vring_alloc_queue(vdev, parent,
+=09=09=09=09=09  vring_size(num, vring_align),
 =09=09=09=09=09  &dma_addr,
 =09=09=09=09=09  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 =09=09if (queue)
@@ -882,7 +884,8 @@ static struct virtqueue *vring_create_virtqueue_split(
=20
 =09if (!queue) {
 =09=09/* Try to get a single page. You are my only hope! */
-=09=09queue =3D vring_alloc_queue(vdev, vring_size(num, vring_align),
+=09=09queue =3D vring_alloc_queue(vdev, parent,
+=09=09=09=09=09  vring_size(num, vring_align),
 =09=09=09=09=09  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 =09}
 =09if (!queue)
@@ -1569,10 +1572,11 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
 =09dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 =09size_t ring_size_in_bytes, event_size_in_bytes;
 =09unsigned int i;
+=09struct device *parent =3D vdev->dev.parent;
=20
 =09ring_size_in_bytes =3D num * sizeof(struct vring_packed_desc);
=20
-=09ring =3D vring_alloc_queue(vdev, ring_size_in_bytes,
+=09ring =3D vring_alloc_queue(vdev, parent, ring_size_in_bytes,
 =09=09=09=09 &ring_dma_addr,
 =09=09=09=09 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 =09if (!ring)
@@ -1580,13 +1584,13 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
=20
 =09event_size_in_bytes =3D sizeof(struct vring_packed_desc_event);
=20
-=09driver =3D vring_alloc_queue(vdev, event_size_in_bytes,
+=09driver =3D vring_alloc_queue(vdev, parent, event_size_in_bytes,
 =09=09=09=09   &driver_event_dma_addr,
 =09=09=09=09   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 =09if (!driver)
 =09=09goto err_driver;
=20
-=09device =3D vring_alloc_queue(vdev, event_size_in_bytes,
+=09device =3D vring_alloc_queue(vdev, parent, event_size_in_bytes,
 =09=09=09=09   &device_event_dma_addr,
 =09=09=09=09   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 =09if (!device)
--=20
2.19.1

