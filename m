Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E8C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5E2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j6nBZITi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfEJJC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:02:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16129 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEJJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:02:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd53e280000>; Fri, 10 May 2019 02:02:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 May 2019 02:02:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 May 2019 02:02:25 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 May
 2019 09:02:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 May 2019 09:02:24 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd53e1e0000>; Fri, 10 May 2019 02:02:24 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <keescook@chromium.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v8 1/2] usb: hub : Add devaddr in struct usb_device
Date:   Fri, 10 May 2019 17:02:16 +0800
Message-ID: <1557478937-30486-2-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1557478937-30486-1-git-send-email-jilin@nvidia.com>
References: <1557478937-30486-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557478953; bh=NPO5dR7LI3+uUpYG3tziaQyizFgC4YdXAiyWfwHviu4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=j6nBZITiSZqJmmAPjsPCYlRSs0Z0fHPtyJcNQp6LHFW7GoHPeNS4tlVPtlLi3/UWp
         +YtH+gZ10AHydDTr6fCpI03guAC+RDE59avo54jImxSa0lCmoMxPC2AhT9Ff8dA3uM
         EGKBP6HDfrsQljkbYLKTAg/L/LlkPD6d77iLYUP6qG98RE4odQX/Am/rzvVH/lksX0
         Pos8s3NSzDI3uIGJ0yT7WTcotrjpkiu9463athF440+sHqHc7EHsEyFBWw/xPyd+Qj
         zu4g79gAQ2Vbfv3O4mM3rFKKft1ac7TKYu1Ct7AdB38rDvKGm2/0f87UeJHAjbMF7n
         j1z2u9iZT43gg==
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

 drivers/usb/core/hub.c | 4 +++-
 include/linux/usb.h    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 15a2934dc29d..078894023797 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -873,7 +873,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
 	/* info that CLEAR_TT_BUFFER needs */
 	clear->tt = tt->multi ? udev->ttport : 1;
 	clear->devinfo = usb_pipeendpoint (pipe);
-	clear->devinfo |= udev->devnum << 4;
+	clear->devinfo |= (u16) (udev->devaddr << 4);
 	clear->devinfo |= usb_pipecontrol(pipe)
 			? (USB_ENDPOINT_XFER_CONTROL << 11)
 			: (USB_ENDPOINT_XFER_BULK << 11);
@@ -2125,6 +2125,8 @@ static void update_devnum(struct usb_device *udev, int devnum)
 	/* The address for a WUSB device is managed by wusbcore. */
 	if (!udev->wusb)
 		udev->devnum = devnum;
+	if (!udev->devaddr)
+		udev->devaddr = (u8) devnum;
 }
 
 static void hub_free_dev(struct usb_device *udev)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 4229eb74bd2c..db38c13a6b1d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -565,6 +565,7 @@ struct usb3_lpm_parameters {
  * @tx_lanes: number of tx lanes in use, USB 3.2 adds dual-lane support
  * @tt: Transaction Translator info; used with low/full speed dev, highspeed hub
  * @ttport: device port on that tt hub
+ * @devaddr: device address, XHCI: assigned by HW, others: same as devnum
  * @toggle: one bit for each endpoint, with ([0] = IN, [1] = OUT) endpoints
  * @parent: our hub, unless we're the root
  * @bus: bus we're part of
@@ -641,6 +642,7 @@ struct usb_device {
 
 	struct usb_tt	*tt;
 	int		ttport;
+	u8 devaddr;
 
 	unsigned int toggle[2];
 
-- 
2.1.4

