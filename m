Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF9C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB95921920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJBPPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:15:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49978 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:15:21 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iFgLW-00039D-7G; Wed, 02 Oct 2019 15:15:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Revert "usb: Avoid unnecessary LPM enabling and disabling during suspend and resume"
Date:   Wed,  2 Oct 2019 23:15:12 +0800
Message-Id: <20191002151512.28517-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d590c23111505635e1beb01006612971e5ede8aa.

Dell WD15 dock has a topology like this:
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M

Their IDs:
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp.
Bus 004 Device 004: ID 0bda:8153 Realtek Semiconductor Corp.

Ethernet cannot be detected after plugging ethernet cable to the dock,
the hub and roothub get runtime resumed and runtime suspended
immediately:
...
[  433.315169] xhci_hcd 0000:3a:00.0: hcd_pci_runtime_resume: 0
[  433.315204] usb usb4: usb auto-resume
[  433.315226] hub 4-0:1.0: hub_resume
[  433.315239] xhci_hcd 0000:3a:00.0: Get port status 4-1 read: 0x10202e2, return 0x10343
[  433.315264] usb usb4-port1: status 0343 change 0001
[  433.315279] xhci_hcd 0000:3a:00.0: clear port1 connect change, portsc: 0x10002e2
[  433.315293] xhci_hcd 0000:3a:00.0: Get port status 4-2 read: 0x2a0, return 0x2a0
[  433.317012] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
[  433.422282] xhci_hcd 0000:3a:00.0: Get port status 4-1 read: 0x10002e2, return 0x343

At this point the SMSC hub (usb 4-1) goes into compliance mode
(USB_SS_PORT_LS_COMP_MOD), and USB core tries to warm-reset it,

[  433.422307] usb usb4-port1: do warm reset
[  433.422311] usb 4-1: device reset not allowed in state 8
[  433.422339] hub 4-0:1.0: state 7 ports 2 chg 0002 evt 0000
[  433.422346] xhci_hcd 0000:3a:00.0: Get port status 4-1 read: 0x10002e2, return 0x343
[  433.422356] usb usb4-port1: do warm reset
[  433.422358] usb 4-1: device reset not allowed in state 8
[  433.422428] xhci_hcd 0000:3a:00.0: set port remote wake mask, actual port 0 status  = 0xf0002e2
[  433.422455] xhci_hcd 0000:3a:00.0: set port remote wake mask, actual port 1 status  = 0xe0002a0
[  433.422465] hub 4-0:1.0: hub_suspend
[  433.422475] usb usb4: bus auto-suspend, wakeup 1
[  433.426161] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
[  433.466209] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.510204] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.554051] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.598235] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.642154] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.686204] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.730205] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.774203] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.818207] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.862040] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
[  433.862053] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
[  433.862077] xhci_hcd 0000:3a:00.0: xhci_suspend: stopping port polling.
[  433.862096] xhci_hcd 0000:3a:00.0: // Setting command ring address to 0x8578fc001
[  433.862312] xhci_hcd 0000:3a:00.0: hcd_pci_runtime_suspend: 0
[  433.862445] xhci_hcd 0000:3a:00.0: PME# enabled
[  433.902376] xhci_hcd 0000:3a:00.0: restoring config space at offset 0xc (was 0x0, writing 0x20)
[  433.902395] xhci_hcd 0000:3a:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100403)
[  433.902490] xhci_hcd 0000:3a:00.0: PME# disabled
[  433.902504] xhci_hcd 0000:3a:00.0: enabling bus mastering
[  433.902547] xhci_hcd 0000:3a:00.0: // Setting command ring address to 0x8578fc001
[  433.902649] pcieport 0000:00:1b.0: PME: Spurious native interrupt!
[  433.902839] xhci_hcd 0000:3a:00.0: Port change event, 4-1, id 3, portsc: 0xb0202e2
[  433.902842] xhci_hcd 0000:3a:00.0: resume root hub
[  433.902845] xhci_hcd 0000:3a:00.0: handle_port_status: starting port polling.
[  433.902877] xhci_hcd 0000:3a:00.0: xhci_resume: starting port polling.
[  433.902889] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
[  433.902891] xhci_hcd 0000:3a:00.0: hcd_pci_runtime_resume: 0
[  433.902919] usb usb4: usb wakeup-resume
[  433.902942] usb usb4: usb auto-resume
[  433.902966] hub 4-0:1.0: hub_resume
...

However the warm-reset never success, the asserted PCI PME keeps the
runtime-resume, warm-reset and runtime-suspend loop which never bring it back
causing spurious interrupts floods.

After some trial and errors, the issue goes away if LPM on the SMSC hub
is disabled. Digging further, enabling and disabling LPM during runtime
resume and runtime suspend respectively can solve the issue.

So bring back the old LPM behavior, which the SMSC hub inside Dell WD15
depends on.

Fixes: d590c2311150 ("usb: Avoid unnecessary LPM enabling and disabling during suspend and resume")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..22a96d279b14 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3269,6 +3269,12 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		if (PMSG_IS_AUTO(msg))
 			goto err_ltm;
 	}
+	if (usb_unlocked_disable_lpm(udev)) {
+		dev_err(&udev->dev, "Failed to disable LPM before suspend\n.");
+		status = -ENOMEM;
+		if (PMSG_IS_AUTO(msg))
+			goto err_lpm3;
+	}
 
 	/* see 7.1.7.6 */
 	if (hub_is_superspeed(hub->hdev))
@@ -3295,7 +3301,9 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 	if (status) {
 		dev_dbg(&port_dev->dev, "can't suspend, status %d\n", status);
 
-		/* Try to enable USB3 LTM again */
+		/* Try to enable USB3 LPM and LTM again */
+		usb_unlocked_enable_lpm(udev);
+ err_lpm3:
 		usb_enable_ltm(udev);
  err_ltm:
 		/* Try to enable USB2 hardware LPM again */
@@ -3584,8 +3592,9 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		/* Try to enable USB2 hardware LPM */
 		usb_enable_usb2_hardware_lpm(udev);
 
-		/* Try to enable USB3 LTM */
+		/* Try to enable USB3 LTM and LPM */
 		usb_enable_ltm(udev);
+		usb_unlocked_enable_lpm(udev);
 	}
 
 	usb_unlock_port(port_dev);
-- 
2.17.1

