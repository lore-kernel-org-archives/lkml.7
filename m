Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED461CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C959C2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439805AbfJRQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfJRQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:47:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C28CA328E;
        Fri, 18 Oct 2019 16:47:25 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-247.ams2.redhat.com [10.36.116.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A0915D713;
        Fri, 18 Oct 2019 16:47:19 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] virtio_console: allocate inbufs in add_port() only if it is needed
Date:   Fri, 18 Oct 2019 18:47:18 +0200
Message-Id: <20191018164718.15999-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 16:47:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we hot unplug a virtserialport and then try to hot plug again,
it fails:

(qemu) chardev-add socket,id=serial0,path=/tmp/serial0,server,nowait
(qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
                  chardev=serial0,id=serial0,name=serial0
(qemu) device_del serial0
(qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
                  chardev=serial0,id=serial0,name=serial0
kernel error:
  virtio-ports vport2p2: Error allocating inbufs
qemu error:
  virtio-serial-bus: Guest failure in adding port 2 for device \
                     virtio-serial0.0

This happens because buffers for the in_vq are allocated when the port is
added but are not released when the port is unplugged.

They are only released when virtconsole is removed (see a7a69ec0d8e4)

To avoid the problem and to be symmetric, we could allocate all the buffers
in init_vqs() as they are released in remove_vqs(), but it sounds like
a waste of memory.

Rather than that, this patch changes add_port() logic to only allocate the
buffers if the in_vq has available free slots.

Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
Cc: mst@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/char/virtio_console.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7270e7b69262..77105166fe01 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1421,12 +1421,17 @@ static int add_port(struct ports_device *portdev, u32 id)
 	spin_lock_init(&port->outvq_lock);
 	init_waitqueue_head(&port->waitqueue);
 
-	/* Fill the in_vq with buffers so the host can send us data. */
-	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
-	if (!nr_added_bufs) {
-		dev_err(port->dev, "Error allocating inbufs\n");
-		err = -ENOMEM;
-		goto free_device;
+	/* if the in_vq has not already been filled (the port has already been
+	 * used and unplugged), fill the in_vq with buffers so the host can
+	 * send us data.
+	 */
+	if (port->in_vq->num_free != 0) {
+		nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
+		if (!nr_added_bufs) {
+			dev_err(port->dev, "Error allocating inbufs\n");
+			err = -ENOMEM;
+			goto free_device;
+		}
 	}
 
 	if (is_rproc_serial(port->portdev->vdev))
-- 
2.21.0

