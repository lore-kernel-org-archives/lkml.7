Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5DBC04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 01:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7ED20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 01:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="sQp6UxKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEEBx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 21:53:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38719 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEEBxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 21:53:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so4868047pfo.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 18:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=km6nvMFOsSwfEhLerIzEth+9iCizOTyYju+loT0I83o=;
        b=sQp6UxKr7uhqm11eKXZj0r3ycIeOua2uD3eP6V4NK0AXF1W2EmzjfumW2bnGLWFtAJ
         02gmAu84af2WuLRdtuBKwWutQ1aQVLK0I8tjBJrTFG2WVYU6xM37A5vJIBbCnyBDiuXC
         c2qjhB8MFx55OR/93NWkh8x1wyktKmAF8nWIcmRbA2FD4BQhWY//XHZEdeQtyK3VBTXx
         T+VxBESrQFR+qWyryt1JDNIzmdKssaGjLhMg2hHsXTcVgdK0dAf2bz3W+f+NPJ08jDbL
         qbufY2a42LT3n5T80W3XIFXa2Nb7XQtzkkH8wzhJz0qEXNkmEb96gmHyOKXOBOzf6nPM
         JHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=km6nvMFOsSwfEhLerIzEth+9iCizOTyYju+loT0I83o=;
        b=Sf/yXFWy+RLbSkCRovktJJ1mQeV/LQLnuAZL74rY6QLAMcGabAP2EltGAQh78VqKCO
         B4JVIDjrXnLj3TNiQXf8SGJSV0u2gZxI7NX9+/A4MXKRceX9tJJAi3l511WIjkI+dL5c
         /P39l8DJxImNrewUMmU/qO5++ZoKZgS/Jk0bNOquC1D6N7wZ4pcFl6DIU9Fs5vRtK7Ka
         UYWcaV+HLECKQCdb1t+EiF2XmpVx7LLKYJbuNyO+ryJJ29PrY2EHupBTHDX0VZTxtgQ3
         28onoy04ownaUf594un4N/HF4AVrO+H6AYyvf+BoggHKkbzlD9Pf2koCVv2rmeU6TaOZ
         vtJg==
X-Gm-Message-State: APjAAAXmyQH3Cr5IEK3zX7ZOqNhSlCWRBReMfCKnGeryIT1JtujTz1+p
        XWU6+z/9gptZHr6Pc74RzgGa0Q==
X-Google-Smtp-Source: APXvYqyQtLpEoifSX/2dZlgVV/Kt/1fOK6SLnyj8gwJqY1dF3VPwiE14cIMt3z4H60jzjadH4YDE3w==
X-Received: by 2002:a65:6688:: with SMTP id b8mr21704064pgw.81.1557021235040;
        Sat, 04 May 2019 18:53:55 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id b77sm14112877pfj.99.2019.05.04.18.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 18:53:54 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH] virtio_console: remove vq buf while unpluging port
Date:   Sun,  5 May 2019 09:53:42 +0800
Message-Id: <1557021222-5133-1-git-send-email-pizhenwei@bytedance.com>
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

