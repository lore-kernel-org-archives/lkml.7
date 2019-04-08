Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2121473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDHMd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfDHMd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:33:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72B98307D964;
        Mon,  8 Apr 2019 12:33:27 +0000 (UTC)
Received: from localhost (ovpn-117-86.ams2.redhat.com [10.36.117.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 023115D719;
        Mon,  8 Apr 2019 12:33:26 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] virtio: Honour 'may_reduce_num' in vring_create_virtqueue
Date:   Mon,  8 Apr 2019 14:33:22 +0200
Message-Id: <20190408123322.24086-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 08 Apr 2019 12:33:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vring_create_virtqueue() allows the caller to specify via the
may_reduce_num parameter whether the vring code is allowed to
allocate a smaller ring than specified.

However, the split ring allocation code tries to allocate a
smaller ring on allocation failure regardless of what the
caller specified. This may cause trouble for e.g. virtio-pci
in legacy mode, which does not support ring resizing. (The
packed ring code does not resize in any case.)

Let's fix this by bailing out immediately in the split ring code
if the requested size cannot be allocated and may_reduce_num has
not been specified.

While at it, fix a typo in the usage instructions.

Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 include/linux/virtio_ring.h  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 18846afb39da..5df92c308286 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -882,6 +882,8 @@ static struct virtqueue *vring_create_virtqueue_split(
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
 			break;
+		if (!may_reduce_num)
+			return NULL;
 	}
 
 	if (!num)
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index fab02133a919..3dc70adfe5f5 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -63,7 +63,7 @@ struct virtqueue;
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
- * expected.  The caller should query virtqueue_get_ring_size to learn
+ * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
  */
 struct virtqueue *vring_create_virtqueue(unsigned int index,
-- 
2.17.2

