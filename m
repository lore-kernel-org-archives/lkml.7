Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB32178F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887510;
	bh=KIESMiKpbaniYyzcqsRpnmAFJ4O+JMw36QeHJIea514=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dsn4Jh/8htm0Fj6nhxUYAs3D8zie23UrdqbfZlLnEKFYX95904/qdunCeq/KZD06F
	 z83xEj9b5HgVF/R7o8gKxV7udNQQvMzMdlrZa19RSaTHURK/MKYjm7T4nK1ZBr61bA
	 WGEOo0eHMNY1y9iZtL0/9v8BbP/yZA0zgC3mxnzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfK0UpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbfK0UpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CC5217BC;
        Wed, 27 Nov 2019 20:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887504;
        bh=KIESMiKpbaniYyzcqsRpnmAFJ4O+JMw36QeHJIea514=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOgLKH9MrK2FmD3wtO5Jmi054iIArXOFnAEvGEnBv9OWvBoxmpS9vwG5BLfZdQpte
         i+Ae1jAkTSMpXrGLbTgEFf1bMUcOkuSkXmzevtopcmKFDehBu6YktKAGs6EDq4FDQ3
         f/w4p/YhsCWaL9U2SmobhMzRggg4c1O3N5fGKUsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 137/151] virtio_console: drop custom control queue cleanup
Date:   Wed, 27 Nov 2019 21:32:00 +0100
Message-Id: <20191127203046.869139354@linuxfoundation.org>
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

[ Upstream commit 61a8950c5c5708cf2068b29ffde94e454e528208 ]

We now cleanup all VQs on device removal - no need
to handle the control VQ specially.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7de24040f39c1..8975ea08d6c01 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1993,21 +1993,6 @@ static void remove_vqs(struct ports_device *portdev)
 	kfree(portdev->out_vqs);
 }
 
-static void remove_controlq_data(struct ports_device *portdev)
-{
-	struct port_buffer *buf;
-	unsigned int len;
-
-	if (!use_multiport(portdev))
-		return;
-
-	while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
-		free_buf(buf, true);
-
-	while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
-		free_buf(buf, true);
-}
-
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2168,7 +2153,6 @@ static void virtcons_remove(struct virtio_device *vdev)
 	 * have to just stop using the port, as the vqs are going
 	 * away.
 	 */
-	remove_controlq_data(portdev);
 	remove_vqs(portdev);
 	kfree(portdev);
 }
@@ -2213,7 +2197,6 @@ static int virtcons_freeze(struct virtio_device *vdev)
 	 */
 	if (use_multiport(portdev))
 		virtqueue_disable_cb(portdev->c_ivq);
-	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
 		virtqueue_disable_cb(port->in_vq);
-- 
2.20.1



