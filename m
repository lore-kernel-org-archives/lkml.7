Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB9FC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777A72133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfDBNoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43454 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731477AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002og-JA; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004vv-82; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oliver Neukum" <oneukum@suse.com>,
        "Macpaul Lin" <macpaul.lin@mediatek.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Johan Hovold" <johan@kernel.org>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.502708862@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 68/99] cdc-acm: fix abnormal DATA RX issue for
 Mediatek Preloader.
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Macpaul Lin <macpaul.lin@mediatek.com>

commit eafb27fa5283599ce6c5492ea18cf636a28222bb upstream.

Mediatek Preloader is a proprietary embedded boot loader for loading
Little Kernel and Linux into device DRAM.

This boot loader also handle firmware update. Mediatek Preloader will be
enumerated as a virtual COM port when the device is connected to Windows
or Linux OS via CDC-ACM class driver. When the USB enumeration has been
done, Mediatek Preloader will send out handshake command "READY" to PC
actively instead of waiting command from the download tool.

Since Linux 4.12, the commit "tty: reset termios state on device
registration" (93857edd9829e144acb6c7e72d593f6e01aead66) causes Mediatek
Preloader receiving some abnoraml command like "READYXX" as it sent.
This will be recognized as an incorrect response. The behavior change
also causes the download handshake fail. This change only affects
subsequent connects if the reconnected device happens to get the same minor
number.

By disabling the ECHO termios flag could avoid this problem. However, it
cannot be done by user space configuration when download tool open
/dev/ttyACM0. This is because the device running Mediatek Preloader will
send handshake command "READY" immediately once the CDC-ACM driver is
ready.

This patch wants to fix above problem by introducing "DISABLE_ECHO"
property in driver_info. When Mediatek Preloader is connected, the
CDC-ACM driver could disable ECHO flag in termios to avoid the problem.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/class/cdc-acm.c | 10 ++++++++++
 drivers/usb/class/cdc-acm.h |  1 +
 2 files changed, 11 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -499,6 +499,13 @@ static int acm_tty_install(struct tty_dr
 	if (retval)
 		goto error_init_termios;
 
+	/*
+	 * Suppress initial echoing for some devices which might send data
+	 * immediately after acm driver has been installed.
+	 */
+	if (acm->quirks & DISABLE_ECHO)
+		tty->termios.c_lflag &= ~ECHO;
+
 	tty->driver_data = acm;
 
 	return 0;
@@ -1690,6 +1697,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0e8d, 0x0003), /* FIREFLY, MediaTek Inc; andrey.arapov@gmail.com */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
+	{ USB_DEVICE(0x0e8d, 0x2000), /* MediaTek Inc Preloader */
+	.driver_info = DISABLE_ECHO, /* DISABLE ECHO in termios flag */
+	},
 	{ USB_DEVICE(0x0e8d, 0x3329), /* MediaTek Inc GPS */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -135,3 +135,4 @@ struct acm {
 #define QUIRK_CONTROL_LINE_STATE	BIT(6)
 #define CLEAR_HALT_CONDITIONS		BIT(7)
 #define SEND_ZERO_PACKET		BIT(8)
+#define DISABLE_ECHO			BIT(9)

