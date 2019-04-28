Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30653C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F40208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="jQLqlF84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfD1BuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:50:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39458 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfD1BuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:50:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id e92so3347654plb.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=km6nvMFOsSwfEhLerIzEth+9iCizOTyYju+loT0I83o=;
        b=jQLqlF84DIuvSU/M49N2V9MjXSTIvD8x3osrCxUMBbW2s6ihFsDPhgMO8+Qjp3zhjQ
         wYXhJzfgmHDAMxRWTr55M2uPpVu+1DJpU18TdOKGPsXHb7vf43Aiifp/5Z8EUSavFa6O
         o42G7iWrcv3jN39cbKtjbVj9GF1+mB3P5EAqR5PnQQyLg8SW8Xcn91ESiumoU2UfWmlL
         i5+/lXnWnqGXetW1gqM4bxwP2HqJyhhMdytXAK5H41f9ZGTuwcj/Xd6ep5Qijs7NeRM7
         fMyLIq73bA182xzs/IzAxPC9wDumw50ArG56A/6wtTZAg1SMfjy18sC2VnnpjfCAQdCA
         32+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=km6nvMFOsSwfEhLerIzEth+9iCizOTyYju+loT0I83o=;
        b=TvW3uom1hZ/j3/9Yisgp6OnVwYroMRQbzVBwsS+WXbmC9lwWqY7zKyi0oCPPRJH7tb
         exV0pzA72uipf9iVtYS3rPWEsSl2/nMXi34scuyeQiFS5UTse3RfUKRFv5iVIk9bLlIr
         yzJ8wPXmDmCe3I7ASmCII7hIQkSLu2jfbKgJ3JtngublTsIR8augSdvW3+CzbrpU6F+1
         0daCOEG+0L64CuQO8O8tpMF2OBEJoYsdXDcMc6bR9JZvwdVEFAVPrmV3pcmMrsNMMelH
         DIEtdX53ybnWUpltlXUCZeQad+08nkJ/HTT8XBbx6hTCL3xvw1NAE9evDpce9phiJEG/
         9IOg==
X-Gm-Message-State: APjAAAVcVqYsnMVwRdfsiZV781OqAEDlTSLf1VRIvN9iAGPxU6la4pCZ
        Kc/VEnyDhVad/rBFnOXovQHcLw==
X-Google-Smtp-Source: APXvYqw3cjqwBUbWVRIw2KkzcON84vhFih1xRtKjnqg2bMnhFOcX1TpqmM5A6Ma6oxhNk1oJONB94Q==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr54620308plb.191.1556416210711;
        Sat, 27 Apr 2019 18:50:10 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id l15sm37555522pfi.79.2019.04.27.18.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Apr 2019 18:50:09 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH] virtio_console: remove vq buf while unpluging port
Date:   Sun, 28 Apr 2019 09:50:04 +0800
Message-Id: <1556416204-30311-1-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bug can be easily reproduced:
Host# cat guest-agent.xml
<channel type="unix">
  <source mode="bind" path="/var/lib/libvirt/qemu/stretch.agent"/>
  <target type="virtio" name="org.qemu.guest_agent.0" state="connected"/>
</channel>
Host# virsh attach-device instance guest-agent.xml
Host# virsh detach-device instance guest-agent.xml
Host# virsh attach-device instance guest-agent.xml

and guest report: virtio-ports vport0p1: Error allocating inbufs

The reason is that the port is unplugged and the vq buf still remained.
So, fix two cases in this patch:
1, fix memory leak with attach-device/detach-device.
2, fix logic bug with attach-device/detach-device/attach-device.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/char/virtio_console.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fbeb719..f6e37f4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -251,6 +251,7 @@ struct port {
 
 /* This is the very early arch-specified put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
+static void remove_vq(struct virtqueue *vq);
 
 static struct port *find_port_by_vtermno(u32 vtermno)
 {
@@ -1550,6 +1551,9 @@ static void unplug_port(struct port *port)
 	}
 
 	remove_port_data(port);
+	spin_lock_irq(&port->inbuf_lock);
+	remove_vq(port->in_vq);
+	spin_unlock_irq(&port->inbuf_lock);
 
 	/*
 	 * We should just assume the device itself has gone off --
@@ -1945,17 +1949,22 @@ static const struct file_operations portdev_fops = {
 	.owner = THIS_MODULE,
 };
 
+static void remove_vq(struct virtqueue *vq)
+{
+	struct port_buffer *buf;
+
+	flush_bufs(vq, true);
+	while ((buf = virtqueue_detach_unused_buf(vq)))
+		free_buf(buf, true);
+}
+
 static void remove_vqs(struct ports_device *portdev)
 {
 	struct virtqueue *vq;
 
-	virtio_device_for_each_vq(portdev->vdev, vq) {
-		struct port_buffer *buf;
+	virtio_device_for_each_vq(portdev->vdev, vq)
+		remove_vq(vq);
 
-		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
-	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
-- 
2.7.4

