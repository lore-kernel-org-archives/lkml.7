Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551EFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35617206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfJGS2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:28:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:28:52 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iHXkW-0003Z9-UU; Mon, 07 Oct 2019 18:28:49 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] usb: core: Make port power cycle a separate helper function
Date:   Tue,  8 Oct 2019 02:28:39 +0800
Message-Id: <20191007182840.4867-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function, hub_port_power_cycle() to power cycle port's power.
It'll be used by a following patch.

In addition to that, check the return value of usb_hub_set_port_power(),
so we don't need to wait if the set power operation fails.

Furthermore, remove parameter *hdev from usb_hub_set_port_power(), since
we can get *hdev from *hub directly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c  | 29 +++++++++++++++++++++++------
 drivers/usb/core/hub.h  |  3 +--
 drivers/usb/core/port.c |  4 ++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..6655a6a1651b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -817,9 +817,9 @@ static void hub_tt_work(struct work_struct *work)
  *
  * Return: 0 if successful. A negative error code otherwise.
  */
-int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
-			   int port1, bool set)
+int usb_hub_set_port_power(struct usb_hub *hub, int port1, bool set)
 {
+	struct usb_device *hdev = hub->hdev;
 	int ret;
 
 	if (set)
@@ -2739,6 +2739,26 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
 		|| link_state == USB_SS_PORT_LS_COMP_MOD;
 }
 
+static void hub_port_power_cycle(struct usb_hub *hub, int port1)
+{
+	int ret;
+
+	ret = usb_hub_set_port_power(hub, port1, false);
+	if (ret) {
+		dev_info(&udev->dev, "failed to disable port power\n");
+		return;
+	}
+
+	msleep(2 * hub_power_on_good_delay(hub));
+	ret = usb_hub_set_port_power(hub, port1, true);
+	if (ret) {
+		dev_info(&udev->dev, "failed to enable port power\n");
+		return;
+	}
+
+	msleep(hub_power_on_good_delay(hub));
+}
+
 static int hub_port_wait_reset(struct usb_hub *hub, int port1,
 			struct usb_device *udev, unsigned int delay, bool warm)
 {
@@ -5131,10 +5151,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		/* When halfway through our retry count, power-cycle the port */
 		if (i == (SET_CONFIG_TRIES / 2) - 1) {
 			dev_info(&port_dev->dev, "attempt power cycle\n");
-			usb_hub_set_port_power(hdev, hub, port1, false);
-			msleep(2 * hub_power_on_good_delay(hub));
-			usb_hub_set_port_power(hdev, hub, port1, true);
-			msleep(hub_power_on_good_delay(hub));
+			hub_port_power_cycle(hub, port1);
 		}
 	}
 	if (hub->hdev->parent ||
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index a9e24e4b8df1..325a55637a6f 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -113,8 +113,7 @@ extern int usb_hub_create_port_device(struct usb_hub *hub,
 		int port1);
 extern void usb_hub_remove_port_device(struct usb_hub *hub,
 		int port1);
-extern int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
-		int port1, bool set);
+extern int usb_hub_set_port_power(struct usb_hub *hub, int port1, bool set);
 extern struct usb_hub *usb_hub_to_struct_hub(struct usb_device *hdev);
 extern int hub_port_debounce(struct usb_hub *hub, int port1,
 		bool must_be_connected);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index bbbb35fa639f..0fc6f24c6da1 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -214,7 +214,7 @@ static int usb_port_runtime_resume(struct device *dev)
 		pm_runtime_get_sync(&peer->dev);
 
 	usb_autopm_get_interface(intf);
-	retval = usb_hub_set_port_power(hdev, hub, port1, true);
+	retval = usb_hub_set_port_power(hub, port1, true);
 	msleep(hub_power_on_good_delay(hub));
 	if (udev && !retval) {
 		/*
@@ -267,7 +267,7 @@ static int usb_port_runtime_suspend(struct device *dev)
 		return -EBUSY;
 
 	usb_autopm_get_interface(intf);
-	retval = usb_hub_set_port_power(hdev, hub, port1, false);
+	retval = usb_hub_set_port_power(hub, port1, false);
 	usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
 	if (!port_dev->is_superspeed)
 		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_ENABLE);
-- 
2.17.1

