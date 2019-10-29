Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E9ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1205620862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj7CljVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfJ2K7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:59:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbfJ2K7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572346786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoC9DQBfngAYpMprddyEKsQ4rDBmYaE/2uMIoiuS8Sc=;
        b=Aj7CljVnbfSdafkHPBBVcsLyIeNg0+ZzhkAaLIUZ1JMXhNOU42nPmG63AbbffLpeVBLgnV
        7YXoyZoHbR/E9iJH0+gA+VAKJLlIJGS2EDucmskX5XN/UOW+tl8I+hJx6TnX9pm0x99G6f
        mourFSBqHdynStgcY0oJPLN903UHEkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-kDmpJ3UPMQ-9Gx_yNcan0g-1; Tue, 29 Oct 2019 06:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE4C8017DD;
        Tue, 29 Oct 2019 10:59:43 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6731A5C1B2;
        Tue, 29 Oct 2019 10:59:26 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com, lulu@redhat.com
Subject: [RFC PATCH 2/2] virtio: allow query vq parent device
Date:   Tue, 29 Oct 2019 18:58:43 +0800
Message-Id: <20191029105843.12061-3-jasowang@redhat.com>
In-Reply-To: <20191029105843.12061-1-jasowang@redhat.com>
References: <20191029105843.12061-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kDmpJ3UPMQ-9Gx_yNcan0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c  | 16 ++++++++++++++--
 include/linux/virtio_config.h |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d83f4d7c32..ddeef7421d4d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -183,6 +183,9 @@ struct vring_virtqueue {
 =09/* DMA, allocation, and size information */
 =09bool we_own_ring;
=20
+=09/* Parent device for doing DMA */
+=09struct device *parent;
+
 #ifdef DEBUG
 =09/* They're supposed to lock for us. */
 =09unsigned int in_use;
@@ -318,7 +321,7 @@ static void vring_free_queue(struct virtio_device *vdev=
, size_t size,
  */
 static inline struct device *vring_dma_dev(const struct vring_virtqueue *v=
q)
 {
-=09return vq->vq.vdev->dev.parent;
+=09return vq->parent;
 }
=20
 /* Map one sg entry. */
@@ -1554,6 +1557,14 @@ static void *virtqueue_detach_unused_buf_packed(stru=
ct virtqueue *_vq)
 =09return NULL;
 }
=20
+static struct device *vring_get_parent(struct virtio_device *vdev, int ind=
ex)
+{
+=09if (vdev->config->get_vq_parent)
+=09=09return vdev->config->get_vq_parent(vdev, index);
+=09else
+=09=09return vdev->dev.parent;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 =09unsigned int index,
 =09unsigned int num,
@@ -1572,7 +1583,7 @@ static struct virtqueue *vring_create_virtqueue_packe=
d(
 =09dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 =09size_t ring_size_in_bytes, event_size_in_bytes;
 =09unsigned int i;
-=09struct device *parent =3D vdev->dev.parent;
+=09struct device *parent =3D vring_get_parent(vdev, index);
=20
 =09ring_size_in_bytes =3D num * sizeof(struct vring_packed_desc);
=20
@@ -1613,6 +1624,7 @@ static struct virtqueue *vring_create_virtqueue_packe=
d(
 =09vq->num_added =3D 0;
 =09vq->packed_ring =3D true;
 =09vq->use_dma_api =3D vring_use_dma_api(vdev);
+=09vq->parent =3D parent;
 =09list_add_tail(&vq->vq.list, &vdev->vqs);
 #ifdef DEBUG
 =09vq->in_use =3D false;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc4910750..a95af83aad9f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -65,6 +65,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @get_vq_parent: get the parent device for a virtqueue (optional).
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -88,6 +89,7 @@ struct virtio_config_ops {
 =09=09=09       const struct cpumask *cpu_mask);
 =09const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 =09=09=09int index);
+=09struct device *(*get_vq_parent)(struct virtio_device *vdev, int index);
 };
=20
 /* If driver didn't advertise the feature, it will never appear. */
--=20
2.19.1

