Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC02D23B24
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VxvQ1fSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfE2Oz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:55:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13163 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2Oz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:55:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cee9d7c0001>; Wed, 29 May 2019 07:55:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 May 2019 07:55:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 May 2019 07:55:56 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 May
 2019 14:55:56 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 May
 2019 14:55:55 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 May 2019 14:55:56 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cee9d7a0000>; Wed, 29 May 2019 07:55:55 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <Thinh.Nguyen@synopsys.com>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v11 1/2] usb: Add devaddr in struct usb_device
Date:   Wed, 29 May 2019 22:55:48 +0800
Message-ID: <1559141749-5159-2-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1559141749-5159-1-git-send-email-jilin@nvidia.com>
References: <1559141749-5159-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559141756; bh=LhZhB75BTveu00eJi8mSRiwZDXCi3AiW0Glx+wWO4OE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=VxvQ1fSPz3oth6gpZ0kLcPS+u46XCQdZ45gfAQCZ1xYApzu6YWmWLzzdttOrkg8dI
         83SBFHSNwpZObj3WniUHVb9EYiGueyLlRHsue94y8TwJpkb1w2KBi8uz7gcSZ14oGn
         mTv0e/rIRTQAmeHxfiuOso0/84Pp3+648IzbwTuL4Zfh/6/zuS50PfrOU77ZNmUpAI
         13wft3n7ERlcFiHudGYIJKJp6rGSDhEldK9M0XFuKIMZDJgRgD+wkyi0lOYuIfiadO
         nsvDMxOQmwhiUY7L5dTs/GsS9cOGcKv90vLwOIaYrbNI7om6rPuSOto4uN3jr9tDh/
         +Pqy/1DkjvgEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Clear_TT_Buffer request sent to the hub includes the address of
the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
uses udev->devnum to set the address wValue. This won't work for
devices connected to xHC.

For other host controllers udev->devnum is the same as the address of
the usb device, chosen and set by usb core. With xHC the controller
hardware assigns the address, and won't be the same as devnum.

Here we add devaddr in "struct usb_device" for
usb_hub_clear_tt_buffer() to use.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
    , remove its claiming in xhci.h
v3: Add description for clearing_tt (xhci.h)
v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
    to protect for Clear_TT_Buffer to be run serially.
    Remove xhci_clear_tt_buffer_complete as it's not necessary.
    Same reason as the above.
    Extend usb_hub_clear_tt_buffer parameter
v5: Not extending usb_hub_clear_tt_buffer parameter
    Add description.
v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
v7: Add devaddr field in "struct usb_device"
v8: split as two patches, change type from int to u8 for devaddr.
v9: Use pahole to find place to put devaddr in struct usb_device.
    Remove space between type cast and variable.
    hub.c changed from v8
    clear->devinfo |= (u16) (udev->devaddr << 4);
    to 
    clear->devinfo |= ((u16)udev->devaddr) << 4;
    to solve a problem if devaddr is larger than 16.
v10 Initialize devaddr in xhci_setup_device()
    Move devaddr to be below "u8 level"
v11 Add xhci.c "slot_ctx = ..."

 drivers/usb/core/hub.c  | 4 +++-
 drivers/usb/host/xhci.c | 2 ++
 include/linux/usb.h     | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 572e8c26a129..82cc3766cb23 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -873,7 +873,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
 	/* info that CLEAR_TT_BUFFER needs */
 	clear->tt = tt->multi ? udev->ttport : 1;
 	clear->devinfo = usb_pipeendpoint (pipe);
-	clear->devinfo |= udev->devnum << 4;
+	clear->devinfo |= ((u16)udev->devaddr) << 4;
 	clear->devinfo |= usb_pipecontrol(pipe)
 			? (USB_ENDPOINT_XFER_CONTROL << 11)
 			: (USB_ENDPOINT_XFER_BULK << 11);
@@ -2125,6 +2125,8 @@ static void update_devnum(struct usb_device *udev, int devnum)
 	/* The address for a WUSB device is managed by wusbcore. */
 	if (!udev->wusb)
 		udev->devnum = devnum;
+	if (!udev->devaddr)
+		udev->devaddr = (u8)devnum;
 }
 
 static void hub_free_dev(struct usb_device *udev)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 20db378a6012..4f92643e3a4c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4125,6 +4125,8 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	/* Zero the input context control for later use */
 	ctrl_ctx->add_flags = 0;
 	ctrl_ctx->drop_flags = 0;
+	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->out_ctx);
+	udev->devaddr = (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
 		       "Internal device address = %d",
diff --git a/include/linux/usb.h b/include/linux/usb.h
index ae82d9d1112b..83d35d993e8c 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -578,6 +578,7 @@ struct usb3_lpm_parameters {
  * @bus_mA: Current available from the bus
  * @portnum: parent port number (origin 1)
  * @level: number of USB hub ancestors
+ * @devaddr: device address, XHCI: assigned by HW, others: same as devnum
  * @can_submit: URBs may be submitted
  * @persist_enabled:  USB_PERSIST enabled for this device
  * @have_langid: whether string_langid is valid
@@ -661,6 +662,7 @@ struct usb_device {
 	unsigned short bus_mA;
 	u8 portnum;
 	u8 level;
+	u8 devaddr;
 
 	unsigned can_submit:1;
 	unsigned persist_enabled:1;
-- 
2.1.4

