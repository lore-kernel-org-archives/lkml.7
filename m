Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD508C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2E2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfGELFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfGELFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:05:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D1D63073AFE;
        Fri,  5 Jul 2019 11:05:11 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-149.ams2.redhat.com [10.36.117.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5113084335;
        Fri,  5 Jul 2019 11:05:09 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 3/3] vsock/virtio: fix flush of works during the .remove()
Date:   Fri,  5 Jul 2019 13:04:54 +0200
Message-Id: <20190705110454.95302-4-sgarzare@redhat.com>
In-Reply-To: <20190705110454.95302-1-sgarzare@redhat.com>
References: <20190705110454.95302-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 05 Jul 2019 11:05:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the flush of works after vdev->config->del_vqs(vdev),
because we need to be sure that no workers run before to free the
'vsock' object.

Since we stopped the workers using the [tx|rx|event]_run flags,
we are sure no one is accessing the device while we are calling
vdev->config->reset(vdev), so we can safely move the workers' flush.

Before the vdev->config->del_vqs(vdev), workers can be scheduled
by VQ callbacks, so we must flush them after del_vqs(), to avoid
use-after-free of 'vsock' object.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4dbdce7746bd..0815d1357861 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -681,12 +681,6 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	rcu_assign_pointer(the_virtio_vsock, NULL);
 	synchronize_rcu();
 
-	flush_work(&vsock->loopback_work);
-	flush_work(&vsock->rx_work);
-	flush_work(&vsock->tx_work);
-	flush_work(&vsock->event_work);
-	flush_work(&vsock->send_pkt_work);
-
 	/* Reset all connected sockets when the device disappear */
 	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
 
@@ -741,6 +735,15 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
 
+	/* Other works can be queued before 'config->del_vqs()', so we flush
+	 * all works before to free the vsock object to avoid use after free.
+	 */
+	flush_work(&vsock->loopback_work);
+	flush_work(&vsock->rx_work);
+	flush_work(&vsock->tx_work);
+	flush_work(&vsock->event_work);
+	flush_work(&vsock->send_pkt_work);
+
 	mutex_unlock(&the_virtio_vsock_mutex);
 
 	kfree(vsock);
-- 
2.20.1

