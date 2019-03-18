Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9509621473
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jz53revs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCRQiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:38:16 -0400
Received: from m12-14.163.com ([220.181.12.14]:47634 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfCRQiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QVP+mNdh9JQ8SXWVxa
        0LsfrEAoXTltpaUmBaTCfZPws=; b=jz53revsSt/nY7NnTneTyAXjP+ZaMSv7c5
        oOyZPqT1Vukqa15uJKdK8q3gWOz2N29dT3oCmakT7A0RKI7vZ71aJoskuD6eqm6l
        UzNW8FVrqFYzr3Ju9XNzcbnxFvXkpR6Izx8bwrUkY6TJ1aiOMJ6Dttb4LRbedEB+
        UXNY1DQ+I=
Received: from localhost.localdomain (unknown [58.38.66.149])
        by smtp10 (Coremail) with SMTP id DsCowACHGftgyY9cV5K1LQ--.56167S3;
        Tue, 19 Mar 2019 00:37:53 +0800 (CST)
From:   VizXu <xujiweigo@163.com>
To:     valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        VizXu <xujiweigo@163.com>
Subject: [PATCH] Add code to support USBIP Project for Windows
Date:   Mon, 18 Mar 2019 09:37:28 -0700
Message-Id: <1552927048-15857-1-git-send-email-xujiweigo@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowACHGftgyY9cV5K1LQ--.56167S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxur48Cry3Jry5XryDKw45Jrb_yoW5tr4Dpa
        yUJFyYyrykJFsxur43ArWrua45Wan2kay5Wry7Kw1a9rnFy3y7AFyDtr93Cr4xGrW7JFya
        vFyvgas8KrW7u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBa0PUUUUU=
X-Originating-IP: [58.38.66.149]
X-CM-SenderInfo: 50xmx4phlj0qqrwthudrp/1tbiUQF7iFWBJ76XMAAAsJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: VizXu <xujiweigo@163.com>
---
 drivers/usb/usbip/stub_dev.c     |  4 ++++
 drivers/usb/usbip/stub_rx.c      | 37 +++++++++++++++++++++++++++++++++++++
 drivers/usb/usbip/usbip_common.h | 16 ++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index c0d6ff1..be95c72 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -270,6 +270,10 @@ static struct stub_device *stub_device_alloc(struct usb_device *udev)
 	sdev->ud.tcp_socket	= NULL;
 	sdev->ud.sockfd		= -1;
 
+#ifdef SUPPORT_WIN
+	sdev->ud.is_configured = false;
+#endif
+
 	INIT_LIST_HEAD(&sdev->priv_init);
 	INIT_LIST_HEAD(&sdev->priv_tx);
 	INIT_LIST_HEAD(&sdev->priv_free);
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 97b09a4..8e004bc 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -11,6 +11,35 @@
 #include "usbip_common.h"
 #include "stub.h"
 
+#ifdef SUPPORT_WIN
+static int usbip_device_init_configuration(struct usbip_device *ud)
+{
+	struct usb_ctrlrequest req;
+	__u16 config;
+	int err;
+
+	struct stub_device *sdev = container_of(ud, struct stub_device, ud);
+
+	struct usb_device *udev = sdev->udev;
+
+	req.bRequest = USB_REQ_SET_CONFIGURATION;
+	req.bRequestType = USB_RECIP_DEVICE;
+	req.wIndex	= 0x00;
+	req.wLength = 0x00;
+	req.wValue	= 0x01;
+	config = le16_to_cpu(req.wValue);
+
+	err = usb_set_configuration(udev, config);
+	if (err && err != -ENODEV) {
+		dev_err(&udev->dev, "%s can't set config\n", "usbip_device_init_configuration");
+		return -1;
+	}
+	ud->is_configured = true;
+
+	return 0;
+}
+#endif
+
 static int is_clear_halt_cmd(struct urb *urb)
 {
 	struct usb_ctrlrequest *req;
@@ -579,6 +608,14 @@ int stub_rx_loop(void *data)
 {
 	struct usbip_device *ud = data;
 
+#ifdef SUPPORT_WIN
+	if (!ud->is_configured) {
+		if (-1 == usbip_device_init_configuration(ud)) {
+			usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
+		}
+	}
+#endif
+
 	while (!kthread_should_stop()) {
 		if (usbip_event_happened(ud))
 			break;
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index bf8afe9..b5189e6 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -122,6 +122,17 @@ extern struct device_attribute dev_attr_usbip_debug;
 #define USBIP_DIR_IN	0x01
 
 /**
+* Support USBIP project for Windows: http://usbip.sourceforge.net/
+*	The configuration is not initialized after an USB device bound in Linux
+* 	and that would make Linux kernel crash if usbip.exe attach it.
+*	I've analysized this process with wireshark and found that usbip.exe
+*	would not "SET CONFIGURATION Request". I suppose the process of loading
+*	a USB device is different between Linux and Windows.
+*	Make a usb_set_configuration at the first time would fix this issue.
+*/
+#define SUPPORT_WIN
+
+/**
  * struct usbip_header_basic - data pertinent to every request
  * @command: the usbip request type
  * @seqnum: sequential number that identifies requests; incremented per
@@ -257,6 +268,11 @@ struct usbip_device {
 	spinlock_t lock;
 
 	int sockfd;
+
+#ifdef SUPPORT_WIN
+	bool is_configured;
+#endif
+
 	struct socket *tcp_socket;
 
 	struct task_struct *tcp_rx;
-- 
2.7.4


