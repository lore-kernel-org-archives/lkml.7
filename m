Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC349C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7980C2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TQzQsGUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZOuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:50:11 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5961 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:50:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31a870000>; Fri, 26 Apr 2019 07:49:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:50:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 07:50:10 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:10 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:09 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:50:09 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31aa10003>; Fri, 26 Apr 2019 07:50:09 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 1/6] usb: hub:Extend usb_hub_clear_tt_buffer parameter
Date:   Fri, 26 Apr 2019 22:50:06 +0800
Message-ID: <1556290206-9393-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290183; bh=VQ9YrfJwsmQ+0troAPFeYUfgX6DDDEB8ACTWzHBrZC0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=TQzQsGUz7YUAwYXzfTjWzhgbjRiCqwcF8vuaE5GNvQJ2JfHaMdee98gqc8bpvP5Mi
         64rOlNoLur5deZzyjgZB4R704y9pehK8yHPTMUv9XgXLkAwtWT+1KSr3B5IVh+eg+w
         KjTFvIZhzMhBGIFm5BhkxXXaFk83KDj8anJr98AmVLSdqDgTfskHQywErXzSYaIvyb
         GTlrcirfRBX86JHCYx6u76er5NtWseb26nZ7zE82QsFwaW5BS8/q48KT4HlU+J2tTt
         lz2Kzlzp7tL0iIBojpNomu7by1AOWAeQsUkMjTsJnbeqGmXiAsqGDgSnHrI66aHPRD
         kyToOb2hyP/Zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend usb_hub_clear_tt_buffer parameter to specify device number
that will have the TT state of its hub cleared.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/core/hub.c  | 5 +++--
 include/linux/usb/hcd.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 15a2934dc29d..4dec054c9776 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -840,6 +840,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 /**
  * usb_hub_clear_tt_buffer - clear control/bulk TT state in high speed hub
  * @urb: an URB associated with the failed or incomplete split transaction
+ * @devnum : device number that will have the TT state of its hub cleared
  *
  * High speed HCDs use this to tell the hub driver that some split control or
  * bulk transaction failed in a way that requires clearing internal state of
@@ -851,7 +852,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
  *
  * Return: 0 if successful. A negative error code otherwise.
  */
-int usb_hub_clear_tt_buffer(struct urb *urb)
+int usb_hub_clear_tt_buffer(struct urb *urb, int devnum)
 {
 	struct usb_device	*udev = urb->dev;
 	int			pipe = urb->pipe;
@@ -873,7 +874,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
 	/* info that CLEAR_TT_BUFFER needs */
 	clear->tt = tt->multi ? udev->ttport : 1;
 	clear->devinfo = usb_pipeendpoint (pipe);
-	clear->devinfo |= udev->devnum << 4;
+	clear->devinfo |= devnum << 4;
 	clear->devinfo |= usb_pipecontrol(pipe)
 			? (USB_ENDPOINT_XFER_CONTROL << 11)
 			: (USB_ENDPOINT_XFER_BULK << 11);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 695931b03684..01720f1f7d62 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -559,7 +559,7 @@ struct usb_tt_clear {
 	struct usb_host_endpoint	*ep;
 };
 
-extern int usb_hub_clear_tt_buffer(struct urb *urb);
+extern int usb_hub_clear_tt_buffer(struct urb *urb, int devnum);
 extern void usb_ep0_reinit(struct usb_device *);
 
 /* (shifted) direction/type/recipient from the USB 2.0 spec, table 9.2 */
-- 
2.1.4

