Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6727FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A0224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfLEJWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:22:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58518 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfLEJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:21:59 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1icnKb-0000Ms-Dk; Thu, 05 Dec 2019 09:21:53 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     alex_lu@realsil.com.cn, pkshih@realtek.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [RESEND] [PATCH] Bluetooth: btusb: Disable runtime suspend on Realtek devices
Date:   Thu,  5 Dec 2019 17:21:48 +0800
Message-Id: <20191205092148.18239-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 9e45524a0111 ("Bluetooth: btusb: Fix suspend issue for
Realtek devices") both WiFi and Bluetooth stop working after reboot:
[   34.322617] usb 1-8: reset full-speed USB device number 3 using xhci_hcd
[   34.450401] usb 1-8: device descriptor read/64, error -71
[   34.694375] usb 1-8: device descriptor read/64, error -71
...
[   44.599111] rtw_pci 0000:02:00.0: failed to poll offset=0x5 mask=0x3 value=0x0
[   44.599113] rtw_pci 0000:02:00.0: mac power on failed
[   44.599114] rtw_pci 0000:02:00.0: failed to power on mac
[   44.599114] rtw_pci 0000:02:00.0: leave idle state failed
[   44.599492] rtw_pci 0000:02:00.0: failed to leave ips state
[   44.599493] rtw_pci 0000:02:00.0: failed to leave idle state

That commit removed USB_QUIRK_RESET_RESUME, which not only resets the USB
device after resume, it also prevents the device from being runtime
suspended by USB core. My experiment shows if the Realtek btusb device
ever runtime suspends once, the entire wireless module becomes useless
after reboot.

So let's explicitly disable runtime suspend on Realtek btusb device for
now.

Fixes: 9e45524a0111 ("Bluetooth: btusb: Fix suspend issue for Realtek devices")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d9cd0677d41c..0eaeca0a64fb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3832,6 +3832,10 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+
+		err = usb_autopm_get_interface(intf);
+		if (err < 0)
+			goto out_free_dev;
 	}
 
 	if (id->driver_info & BTUSB_AMP) {
-- 
2.17.1

