Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA57C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E360720869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890981;
	bh=aTktFn2E1LN+MdrxtOciFAoU5IS9FuN6Se/pNHHv8d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FqJ+UkyjRJQQEcUSelXu5EGfa3MMD1Xrg1coQ9ZmyD1/SjxnRORp8B6c2U/2Gzl/O
	 ippnGPEdtKYCCk7MG2Po9T5ZKXlVyV9dmY7fpQKooG+y9w0pAYnl83+ALbij8ogc0n
	 6gi87p2dG3oqmq1cUwxnjY69fpS2aKFhMkfEEB2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfK0Uj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfK0UjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE4C21770;
        Wed, 27 Nov 2019 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887162;
        bh=aTktFn2E1LN+MdrxtOciFAoU5IS9FuN6Se/pNHHv8d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lR9MuEYyHhWH/RemJuR6YR0VWs/0VgMocb3rnLJHA0Ge+QEF2YahsSvSB4EYdhoF+
         Mn9Zguew2M3CJLXUW+fBZVJZTCH5dJKBH1dwJqP0ePynCx/Jtvp3wlm7UPC6bGxlhd
         W3qABmgPqTPzHRhQm2yUxyCt73qtLcdbP/4pbs9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 121/132] virtio_console: move removal code
Date:   Wed, 27 Nov 2019 21:31:52 +0100
Message-Id: <20191127203032.748883183@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit aa44ec867030a72e8aa127977e37dec551d8df19 ]

Will make it reusable for error handling.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 72 +++++++++++++++++------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index bc4a804048205..5e0e29ee31d1a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1987,6 +1987,42 @@ static void remove_vqs(struct ports_device *portdev)
 	kfree(portdev->out_vqs);
 }
 
+static void virtcons_remove(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port, *port2;
+
+	portdev = vdev->priv;
+
+	spin_lock_irq(&pdrvdata_lock);
+	list_del(&portdev->list);
+	spin_unlock_irq(&pdrvdata_lock);
+
+	/* Disable interrupts for vqs */
+	vdev->config->reset(vdev);
+	/* Finish up work that's lined up */
+	if (use_multiport(portdev))
+		cancel_work_sync(&portdev->control_work);
+	else
+		cancel_work_sync(&portdev->config_work);
+
+	list_for_each_entry_safe(port, port2, &portdev->ports, list)
+		unplug_port(port);
+
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
+
+	/*
+	 * When yanking out a device, we immediately lose the
+	 * (device-side) queues.  So there's no point in keeping the
+	 * guest side around till we drop our final reference.  This
+	 * also means that any ports which are in an open state will
+	 * have to just stop using the port, as the vqs are going
+	 * away.
+	 */
+	remove_vqs(portdev);
+	kfree(portdev);
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2115,42 +2151,6 @@ fail:
 	return err;
 }
 
-static void virtcons_remove(struct virtio_device *vdev)
-{
-	struct ports_device *portdev;
-	struct port *port, *port2;
-
-	portdev = vdev->priv;
-
-	spin_lock_irq(&pdrvdata_lock);
-	list_del(&portdev->list);
-	spin_unlock_irq(&pdrvdata_lock);
-
-	/* Disable interrupts for vqs */
-	vdev->config->reset(vdev);
-	/* Finish up work that's lined up */
-	if (use_multiport(portdev))
-		cancel_work_sync(&portdev->control_work);
-	else
-		cancel_work_sync(&portdev->config_work);
-
-	list_for_each_entry_safe(port, port2, &portdev->ports, list)
-		unplug_port(port);
-
-	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-
-	/*
-	 * When yanking out a device, we immediately lose the
-	 * (device-side) queues.  So there's no point in keeping the
-	 * guest side around till we drop our final reference.  This
-	 * also means that any ports which are in an open state will
-	 * have to just stop using the port, as the vqs are going
-	 * away.
-	 */
-	remove_vqs(portdev);
-	kfree(portdev);
-}
-
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
-- 
2.20.1



