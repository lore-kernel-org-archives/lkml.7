Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BADC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE922178F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887496;
	bh=2B1TO9U0JJWHutMSGqxzc5uvWPcGaGlSdTFQaLGEKu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7YpjzKZcJlG9++0E8Fq+zd7Oi5QNp0mUw4A79DMFHww7mZqYa7dEsb1/9bW94kMX
	 hD56Qe80EeXUhYJkoQ6/qNQCQNLK4u+gkG/TQFW5lT4hqHHaFQNYD7sFszGpPH6+qK
	 zCQjbTfnN1LO4+BAC+0bC3VYEFYB1CJUG2xOqpF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfK0Uoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:44:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfK0Uow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:44:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0FD2166E;
        Wed, 27 Nov 2019 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887492;
        bh=2B1TO9U0JJWHutMSGqxzc5uvWPcGaGlSdTFQaLGEKu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwzMusWoFka51C2ROcepNNhiF98Gre1MZ3DciL1GeAJXJ0GKJEYjJuA1zH1ZybHk5
         pfjhVdbFLUdMZOgczN3Re5gMAKR/cHT9IEJMmwGkux39WdIFAYE0ZK98/tVzbPobVc
         a2Q+SdAQe10JfnO22f3HQBZ+PHSbhfzoiD2DPt08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 132/151] virtio_console: reset on out of memory
Date:   Wed, 27 Nov 2019 21:31:55 +0100
Message-Id: <20191127203046.392102374@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 5c60300d68da32ca77f7f978039dc72bfc78b06b ]

When out of memory and we can't add ctrl vq buffers,
probe fails. Unfortunately the error handling is
out of spec: it calls del_vqs without bothering
to reset the device first.

To fix, call the full cleanup function in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 800ced0a5a247..43724bd8a0c0a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2073,6 +2073,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
+	INIT_LIST_HEAD(&portdev->list);
 
 	virtio_device_ready(portdev->vdev);
 
@@ -2090,8 +2091,15 @@ static int virtcons_probe(struct virtio_device *vdev)
 		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
-			err = -ENOMEM;
-			goto free_vqs;
+			/*
+			 * The host might want to notify mgmt sw about device
+			 * add failure.
+			 */
+			__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+					   VIRTIO_CONSOLE_DEVICE_READY, 0);
+			/* Device was functional: we need full cleanup. */
+			virtcons_remove(vdev);
+			return -ENOMEM;
 		}
 	} else {
 		/*
@@ -2122,11 +2130,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_vqs:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
-	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
-- 
2.20.1



