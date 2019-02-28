Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EAEC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04A020C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366949;
	bh=j4xO8ieHayLvGJjdIPnCHMk40tAW0kTHh90+LsUQ++g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+nwCxZcIMRXlI1viLnwx1t2uh77mmqEq2eeZnOvdk0GSsYHGnq/AfPToylBytc1g
	 5GiF/JNANLNsFka5jgUOM8xUP/pmjZMLceje2DUBoj8RV4NM629/g3BMlrpeR/SiTa
	 wI5JHe4lfX1IrImxyis1bp+W11+bRrno7HimhkcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbfB1PPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388281AbfB1PP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:15:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1B1218E0;
        Thu, 28 Feb 2019 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366928;
        bh=j4xO8ieHayLvGJjdIPnCHMk40tAW0kTHh90+LsUQ++g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3IcUlpsC8BaN3XKKQnrnriOophy54nrUK92mJNcCrD7JNdIsW7eZDwIV/RMvNRzh
         gVtc6J1Uyk/T/WdxYGzDLsmBHwdQhLTrELIAtrirmE0rK6YZlCW1/VdGY4vvCDaBXP
         uQLb2rqwII3Y3A9JZnryU54ljW4FDWfehDAQfYNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/19] vsock/virtio: fix kernel panic after device hot-unplug
Date:   Thu, 28 Feb 2019 10:15:04 -0500
Message-Id: <20190228151517.12705-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151517.12705-1-sashal@kernel.org>
References: <20190228151517.12705-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 22b5c0b63f32568e130fa2df4ba23efce3eb495b ]

virtio_vsock_remove() invokes the vsock_core_exit() also if there
are opened sockets for the AF_VSOCK protocol family. In this way
the vsock "transport" pointer is set to NULL, triggering the
kernel panic at the first socket activity.

This patch move the vsock_core_init()/vsock_core_exit() in the
virtio_vsock respectively in module_init and module_exit functions,
that cannot be invoked until there are open sockets.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1609699
Reported-by: Yan Fu <yafu@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 936d7eee62d03..6cbc08d82e7fd 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -71,6 +71,9 @@ static u32 virtio_transport_get_local_cid(void)
 {
 	struct virtio_vsock *vsock = virtio_vsock_get();
 
+	if (!vsock)
+		return VMADDR_CID_ANY;
+
 	return vsock->guest_cid;
 }
 
@@ -495,10 +498,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	virtio_vsock_update_guest_cid(vsock);
 
-	ret = vsock_core_init(&virtio_transport.transport);
-	if (ret < 0)
-		goto out_vqs;
-
 	vsock->rx_buf_nr = 0;
 	vsock->rx_buf_max_nr = 0;
 	atomic_set(&vsock->queued_replies, 0);
@@ -526,8 +525,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	mutex_unlock(&the_virtio_vsock_mutex);
 	return 0;
 
-out_vqs:
-	vsock->vdev->config->del_vqs(vsock->vdev);
 out:
 	kfree(vsock);
 	mutex_unlock(&the_virtio_vsock_mutex);
@@ -567,7 +564,6 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 
 	mutex_lock(&the_virtio_vsock_mutex);
 	the_virtio_vsock = NULL;
-	vsock_core_exit();
 	mutex_unlock(&the_virtio_vsock_mutex);
 
 	vdev->config->del_vqs(vdev);
@@ -600,14 +596,28 @@ static int __init virtio_vsock_init(void)
 	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", 0, 0);
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
+
 	ret = register_virtio_driver(&virtio_vsock_driver);
 	if (ret)
-		destroy_workqueue(virtio_vsock_workqueue);
+		goto out_wq;
+
+	ret = vsock_core_init(&virtio_transport.transport);
+	if (ret)
+		goto out_vdr;
+
+	return 0;
+
+out_vdr:
+	unregister_virtio_driver(&virtio_vsock_driver);
+out_wq:
+	destroy_workqueue(virtio_vsock_workqueue);
 	return ret;
+
 }
 
 static void __exit virtio_vsock_exit(void)
 {
+	vsock_core_exit();
 	unregister_virtio_driver(&virtio_vsock_driver);
 	destroy_workqueue(virtio_vsock_workqueue);
 }
-- 
2.19.1

