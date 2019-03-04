Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E24C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADF52075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCDNFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:05:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfCDNFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:05:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4AB30821C0;
        Mon,  4 Mar 2019 13:05:20 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (dhcp-10-65-161-28.pnq.redhat.com [10.65.161.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49E0D60852;
        Mon,  4 Mar 2019 13:05:15 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        mst@redhat.com, pagupta@redhat.com, xiaohli@redhat.com
Subject: [PATCH] virtio_console: free unused buffers with virtio port
Date:   Mon,  4 Mar 2019 18:35:11 +0530
Message-Id: <20190304130511.14450-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 04 Mar 2019 13:05:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
  deffered detaching of unused buffer to virtio device unplug time. 

  This causes unplug/replug of single port in virtio device with an 
  error "Error allocating inbufs\n". As we don't free the unused buffers 
  attached with the port. Re-plug the same port tries to allocate new
  buffers in virtqueue and results in this error if queue is full. 

  This patch removes the unused buffers in vq's when we unplug the port.
  This is the best we can do as we cannot call device_reset because virtio 
  device is still active. This was the working behaviour before the change 
  introduced in commit b3258ff1d6.

  Reported-by: Xiaohui Li <xiaohli@redhat.com>
  Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
  Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/char/virtio_console.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fbeb71953526..5fbf2ac73111 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
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
 
@@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device *portdev)
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
2.20.1

