Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D304C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D878B21880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr8Wxz0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbfHHPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:55:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42437 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfHHPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:55:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so44321847pff.9;
        Thu, 08 Aug 2019 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCmBSrNvfnQh4RGFGxzKU7/e+KnBtf1L1cfQCo9aVVE=;
        b=jr8Wxz0rO9NjkhVbYLc8a65PdglxPLiMMa1xceUlCaO0VgA9oPkI38ZN6REK63GbXy
         AOBi/CHTbk9Je6ZRFDzzD2YKtZlAFVpcL644Bxn2A43VklvUr+TXdOLnYcrxEb60wuAU
         /QjOkRve3Om5AhqNzUOJYfPEj99rNtHto73VKLWCktH9USFFNU2xVAXoz63Yb84xwS1Y
         6vBJrbUKOt+03WKFjAFduufjwPvY5j9FSHmFYGPOPNIMLuAQKKw9Y37CSOFhrQ7lH/2d
         mp7+hgatYUC4vxo6egCL/aoTZ1KNzX9UpqLe8Ib1pMOjSSYoEYvJHcpSQWdwuO1fjHY4
         Nw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCmBSrNvfnQh4RGFGxzKU7/e+KnBtf1L1cfQCo9aVVE=;
        b=JbgcQMpNVYH8XxSOzS/h75y6eYUU31h+eN9OgTbkXVho+9TRnz7ejra0umZLryd5fg
         sUYwHP8qK6PXQXD3dr/uZcnyxVuRMr6D19PtwUu8vHMB6pRYhZFshd6RYaoNECMKD1ny
         xYegEDukfrZwySZuL8FN/bObsGkGtzaCfrfiG1Au8gHvCkaVFigMxSYPjsUPINKdxBIz
         IcOzn4jgRVIzFzu54CM4UZf+XZUSAYdUA45dNglEhzSGNw9RvZDmelHAK8uSn9lwMPNJ
         d0LqUJ08a04cwJGjHBn2v0oWEozBIS8WDe7UMAIzNfMUKsYMMjA83HBL9CotCTvfdsWG
         7SHg==
X-Gm-Message-State: APjAAAVTJRi8LrLfnqV52n3evFltrxLCa5+Gvscw2wtFB7SxnslCmkIz
        lPXcjEuxfnw2SBzXh+4kISY=
X-Google-Smtp-Source: APXvYqxs8nTqj7eeCJOR6O+Gah3tlqYLwqVsxJRjBqL6xwJgQ7zMFsqyQIZocYVHTwm7OzsQ0ig9vQ==
X-Received: by 2002:a63:58c:: with SMTP id 134mr13926734pgf.106.1565279700330;
        Thu, 08 Aug 2019 08:55:00 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id c98sm3054805pje.1.2019.08.08.08.54.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:54:59 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v5 1/2] usbip: Skip DMA mapping and unmapping for urb at vhci
Date:   Fri,  9 Aug 2019 00:54:34 +0900
Message-Id: <20190808155435.10050-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808155435.10050-1-suwan.kim027@gmail.com>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhci doesn’t do DMA for remote device. Actually, the real DMA
operation is done by network card driver. vhci just passes virtual
address of the buffer to the network stack, so vhci doesn’t use and
need dma address of the buffer of the URB.

But HCD provides DMA mapping and unmapping function by default.
Moreover, it causes unnecessary DMA mapping and unmapping which
will be done again at the NIC driver and it wastes CPU cycles.
So, implement map_urb_for_dma and unmap_urb_for_dma function for
vhci in order to skip the DMA mapping and unmapping procedure.

When it comes to supporting SG for vhci, it is useful to use native
SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
fnuction can adjust the number of SG list (urb->num_mapped_sgs).
And vhci_map_urb_for_dma() prevents isoc pipe from using SG as
hcd_map_urb_for_dma() does.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
v4 - v5
- Replace pr_err() with dev_err() in the error path.

v3 - v4
- Replace WARN_ON() with pr_err() in the error path.

v2 - v3
- Move setting URB_DMA_MAP_SG flag to the patch 2.
- Prevent isoc pipe from using SG buffer.

v1 - v2
- Add setting URB_DMA_MAP_SG flag in urb->transfer_flags to tell
stub driver to use SG buffer.
---
 drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 000ab7225717..ea82b932a2f9 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+				gfp_t mem_flags)
+{
+	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
+		dev_err(&urb->dev->dev, "SG is not supported for isochronous transfer\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void vhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+{
+	dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");
+}
+
 static const struct hc_driver vhci_hc_driver = {
 	.description	= driver_name,
 	.product_desc	= driver_desc,
@@ -1304,6 +1320,9 @@ static const struct hc_driver vhci_hc_driver = {
 
 	.get_frame_number = vhci_get_frame_number,
 
+	.map_urb_for_dma = vhci_map_urb_for_dma,
+	.unmap_urb_for_dma = vhci_unmap_urb_for_dma,
+
 	.hub_status_data = vhci_hub_status,
 	.hub_control    = vhci_hub_control,
 	.bus_suspend	= vhci_bus_suspend,
-- 
2.20.1

