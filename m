Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED584ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2562206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfJGS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:28:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57876 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:28:55 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iHXka-0003ZK-QF; Mon, 07 Oct 2019 18:28:53 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] usb: core: Attempt power cycle when port is in eSS.Disabled state
Date:   Tue,  8 Oct 2019 02:28:40 +0800
Message-Id: <20191007182840.4867-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007182840.4867-1-kai.heng.feng@canonical.com>
References: <20191007182840.4867-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
then connects to ASMedia xHCI's root hub:

/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M

Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter

The SMSC hub may disconnect after system resume from suspend. When this
happens, the reset resume attempt fails, and the last resort to disable
the port and see something comes up later, also fails.

When the issue occurs, the link state stays in eSS.Disabled state
despite the warm reset attempts. The USB spec mentioned this can be
caused by invalid VBus, and after some expiremets, it does show that the
SMSC hub can be brought back after a power cycle.

So let's power cycle the port at the end of reset resume attempt, if
it's in eSS.Disabled state.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6655a6a1651b..5f50aca7cf67 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2739,20 +2739,33 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
 		|| link_state == USB_SS_PORT_LS_COMP_MOD;
 }
 
+static bool hub_port_power_cycle_required(struct usb_hub *hub, int port1,
+		u16 portstatus)
+{
+	u16 link_state;
+
+	if (!hub_is_superspeed(hub->hdev))
+		return false;
+
+	link_state = portstatus & USB_PORT_STAT_LINK_STATE;
+	return link_state == USB_SS_PORT_LS_SS_DISABLED;
+}
+
 static void hub_port_power_cycle(struct usb_hub *hub, int port1)
 {
+	struct usb_port *port_dev = hub->ports[port1  - 1];
 	int ret;
 
 	ret = usb_hub_set_port_power(hub, port1, false);
 	if (ret) {
-		dev_info(&udev->dev, "failed to disable port power\n");
+		dev_info(&port_dev->dev, "failed to disable port power\n");
 		return;
 	}
 
 	msleep(2 * hub_power_on_good_delay(hub));
 	ret = usb_hub_set_port_power(hub, port1, true);
 	if (ret) {
-		dev_info(&udev->dev, "failed to enable port power\n");
+		dev_info(&port_dev->dev, "failed to enable port power\n");
 		return;
 	}
 
@@ -3600,6 +3613,10 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 	if (status < 0) {
 		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
 		hub_port_logical_disconnect(hub, port1);
+		if (hub_port_power_cycle_required(hub, port1, portstatus)) {
+			dev_info(&udev->dev, "device in disabled state, attempt power cycle\n");
+			hub_port_power_cycle(hub, port1);
+		}
 	} else  {
 		/* Try to enable USB2 hardware LPM */
 		usb_enable_usb2_hardware_lpm(udev);
-- 
2.17.1

