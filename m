Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FEF2158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfK2Rl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:41:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfK2Rl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:41:27 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iakGi-0005XR-JC; Fri, 29 Nov 2019 17:41:25 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/2] USB: core: Attempt power cycle port when it's in eSS.Disabled state
Date:   Sat, 30 Nov 2019 01:41:15 +0800
Message-Id: <20191129174115.31683-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129174115.31683-1-kai.heng.feng@canonical.com>
References: <20191129174115.31683-1-kai.heng.feng@canonical.com>
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
despite the warm reset attempts. Accoding to spec this can be caused by
invalid VBus, after some expiremets, the SMSC hub can be brought back
after a powercycle.

So let's power cycle the port at the end of reset resume attempt, if
it's in eSS.Disabled state.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Lower dev_info() to dev_dbg().

 drivers/usb/core/hub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6b6cd76ac5e6..a2e6001046f5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2739,6 +2739,18 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
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
 	struct usb_port *port_dev = hub->ports[port1  - 1];
@@ -3601,6 +3613,10 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 	if (status < 0) {
 		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
 		hub_port_logical_disconnect(hub, port1);
+		if (hub_port_power_cycle_required(hub, port1, portstatus)) {
+			dev_dbg(&udev->dev, "device in disabled state, attempt power cycle\n");
+			hub_port_power_cycle(hub, port1);
+		}
 	} else  {
 		/* Try to enable USB2 hardware LPM */
 		usb_enable_usb2_hardware_lpm(udev);
-- 
2.17.1

