Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6B8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAAF217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfHHLgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:36:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfHHLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:36:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19EF0300BEA9;
        Thu,  8 Aug 2019 11:36:16 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EF04612BF;
        Thu,  8 Aug 2019 11:36:13 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     amit@kernel.org, mst@redhat.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, pagupta@redhat.com
Subject: [PATCH v2 1/2] virtio_console: free unused buffers with port delete
Date:   Thu,  8 Aug 2019 17:06:05 +0530
Message-Id: <20190808113606.19504-2-pagupta@redhat.com>
In-Reply-To: <20190808113606.19504-1-pagupta@redhat.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 08 Aug 2019 11:36:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
  deferred detaching of unused buffer to virtio device unplug time.

  This causes unplug/replug of single port in virtio device with an
  error "Error allocating inbufs\n". As we don't free the unused buffers
  attached with the port. Re-plug the same port tries to allocate new
  buffers in virtqueue and results in this error if queue is full.

  This patch removes the unused buffers in vq's when we unplug the port.
  This is the best we can do as we cannot call device_reset because virtio
  device is still active.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/char/virtio_console.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7270e7b69262..e8be82f1bae9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1494,15 +1494,25 @@ static void remove_port(struct kref *kref)
 	kfree(port);
 }
 
+static void remove_unused_bufs(struct virtqueue *vq)
+{
+	struct port_buffer *buf;
+
+	while ((buf = virtqueue_detach_unused_buf(vq)))
+		free_buf(buf, true);
+}
+
 static void remove_port_data(struct port *port)
 {
 	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
+	remove_unused_bufs(port->in_vq);
 	spin_unlock_irq(&port->inbuf_lock);
 
 	spin_lock_irq(&port->outvq_lock);
 	reclaim_consumed_buffers(port);
+	remove_unused_bufs(port->out_vq);
 	spin_unlock_irq(&port->outvq_lock);
 }
 
@@ -1938,11 +1948,9 @@ static void remove_vqs(struct ports_device *portdev)
 	struct virtqueue *vq;
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
-		struct port_buffer *buf;
 
 		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
+		remove_unused_bufs(vq);
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
-- 
2.21.0

