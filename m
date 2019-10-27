Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C997CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4109820717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfJ0KIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 06:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfJ0KIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 06:08:13 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0D353688E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 10:08:12 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id j10so7326995qka.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 03:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2LKFbpd/57zdcxL2B5zndGKqrGlJbgH02f3Dnv6OaXo=;
        b=b0q/HOzP4XV+3Pxa7DuvP3/87Qf3fG5RSOIsnTRG9zWda++nDhY/KMGNME22r1BTXG
         nAvIXqmGGM8hzNl3GLVKtsiCXtAOBmb+xcGHFXyjVGeqzQDgpjrZ4/G5T8f35Wt4V+bI
         rFiVwNsptkMXQqfjIn1Aof18ioRVi4JxfLmZshx0xw8YH5Is3718wIlUlh6v4hrQo+OD
         MSYd/KVkQ4J4PvNw0U6bxf7p0UNNnITlF2nd5HIvLv4eMvcw5zuqsjPyTEAPbbUCwWBn
         Mg3icjIN3yqdBJEHf3F/B11IAuUxua6XG77nKLnAg0C3BGy5BXlfBuXbmVs6m9UuBmOK
         tPPA==
X-Gm-Message-State: APjAAAX0BNIV4/2q/ZRNlQ/lzvHUTw5KaEt3pByVl5pxM/YgcnSuUVBa
        g8wVQifMQpQo/NNfI4iYJucxLct8uaXhFMRn9jjS7NbwxVSdJtHSp26aeg/smHnihFdptho5TfO
        hUUqHk+m2IGESond+NYrskhgg
X-Received: by 2002:ac8:3711:: with SMTP id o17mr12438947qtb.159.1572170891949;
        Sun, 27 Oct 2019 03:08:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4yH+6ZR2wBZq+Jvuc7lC5oL5AYqVi9r9IYLRVIAL0mc77PKJB7RThLM03NDFUqz9i1FUPjw==
X-Received: by 2002:ac8:3711:: with SMTP id o17mr12438933qtb.159.1572170891717;
        Sun, 27 Oct 2019 03:08:11 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id y33sm7072062qta.18.2019.10.27.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 03:08:11 -0700 (PDT)
Date:   Sun, 27 Oct 2019 06:08:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marvin Liu <yong.liu@intel.com>, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_ring: fix stalls for packed rings
Message-ID: <20191027100705.11644-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marvin Liu <yong.liu@intel.com>

When VIRTIO_F_RING_EVENT_IDX is negotiated, virtio devices can
use virtqueue_enable_cb_delayed_packed to reduce the number of device
interrupts.  At the moment, this is the case for virtio-net when the
napi_tx module parameter is set to false.

In this case, the virtio driver selects an event offset and expects that
the device will send a notification when rolling over the event offset
in the ring.  However, if this roll-over happens before the event
suppression structure update, the notification won't be sent. To address
this race condition the driver needs to check wether the device rolled
over the offset after updating the event suppression structure.

With VIRTIO_F_RING_PACKED, the virtio driver did this by reading the
flags field of the descriptor at the specified offset.

Unfortunately, checking at the event offset isn't reliable: if
descriptors are chained (e.g. when INDIRECT is off) not all descriptors
are overwritten by the device, so it's possible that the device skipped
the specific descriptor driver is checking when writing out used
descriptors. If this happens, the driver won't detect the race condition
and will incorrectly expect the device to send a notification.

For virtio-net, the result will be a TX queue stall, with the
transmission getting blocked forever.

With the packed ring, it isn't easy to find a location which is
guaranteed to change upon the roll-over, except the next device
descriptor, as described in the spec:

        Writes of device and driver descriptors can generally be
        reordered, but each side (driver and device) are only required to
        poll (or test) a single location in memory: the next device descriptor after
        the one they processed previously, in circular order.

while this might be sub-optimal, let's do exactly this for now.

Cc: stable@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Marvin Liu <yong.liu@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

So this is what I have in my tree now - this is just Marvin's patch
with a tweaked description.


 drivers/virtio/virtio_ring.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bdc08244a648..a8041e451e9e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1499,9 +1499,6 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 		 * counter first before updating event flags.
 		 */
 		virtio_wmb(vq->weak_barriers);
-	} else {
-		used_idx = vq->last_used_idx;
-		wrap_counter = vq->packed.used_wrap_counter;
 	}
 
 	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
@@ -1518,7 +1515,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	 */
 	virtio_mb(vq->weak_barriers);
 
-	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
+	if (is_used_desc_packed(vq,
+				vq->last_used_idx,
+				vq->packed.used_wrap_counter)) {
 		END_USE(vq);
 		return false;
 	}
-- 
MST
