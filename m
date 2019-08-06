Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C15CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D02070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiGPUygX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfHFMcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:32:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36746 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfHFMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:32:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so41442774pfl.3;
        Tue, 06 Aug 2019 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wkQ6ra85+YOSDMOu2ukwsYI4DdQs7Y4YX0vbulUTao=;
        b=WiGPUygXPxJ3OLDyHOl0nXzUF62zjbbVirmLFoe1Vju9fKdOA8gVsZeBE/5QHKe5LO
         DNRr0I80SX7Cpi60YPMDO3LZwQ0eCQ00BvpKQTAWahtwotpBqLs5SQ7pWSlj63JndE7H
         i4BKtc+WX2fD36/4//8h8DNPutJ70nFUJ2XXNIVBLpSuEIBgHabtBwpu1KLzOV7le7nx
         85oQVb3DTtQ6kq67f8+SrbOqywTTvKteUTSx5iQCLsAcHZM0yB4xRWy0FhAjdvFWhIfO
         aI/PovSoAG00yLSZYlPdq9DQDJK2hptT1aytlrcrJF8G1RSKZS7v7oUBPzGO1kIDGpu6
         1wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wkQ6ra85+YOSDMOu2ukwsYI4DdQs7Y4YX0vbulUTao=;
        b=OvUpZ1nxy870momFaeQgScZkVj+Keq26dzS6mImNHAs0/Pr3uvfrHTHdzcW1ZRkyTX
         va8iTbvAsyPKnoTzwRAgZlYhm9XGLn5ohkRPbVydTWb5uzvALt/cSM0yyVAlGw0E+PKA
         E1d+I4aGEep3TKWziCRoGefEpOEXPy0A8Hy49n3JZ8BYojn36xoXE0wgpxMTtJtsmOQ2
         SBqEKtY6v7RtMnt2RDrVn0baGoyhZuL9BXQz0Tcedbjb6ZZfmgstvCz99sGuNzZNVxxZ
         OAaOzIcfe0iqQUv110u091Yqd83H7lg8657TUf3KMiXL78Jpjoe7BjLsTEEw41tZt8Lz
         6jHQ==
X-Gm-Message-State: APjAAAURRvSbsc5JaMnLejFjmbqHujyUoTnnfGlkkWjLN5izo5ByLmEH
        I0eJN7CsLzUxjNU2JgxG7So=
X-Google-Smtp-Source: APXvYqwYGvGijLithyrZDnxlNsOxZC7g3Nr4VrvG/Xxo5GFIirFjp6u/fooSNBH8AvXIQ05SinJgPQ==
X-Received: by 2002:aa7:9f8b:: with SMTP id z11mr3501894pfr.121.1565094744223;
        Tue, 06 Aug 2019 05:32:24 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.125])
        by smtp.googlemail.com with ESMTPSA id a12sm15427778pgv.48.2019.08.06.05.32.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:32:23 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 1/2] usbip: Skip DMA mapping and unmapping for urb at vhci
Date:   Tue,  6 Aug 2019 21:31:53 +0900
Message-Id: <20190806123154.23798-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806123154.23798-1-suwan.kim027@gmail.com>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
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
v3 - v4:
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
index 000ab7225717..429e4e989f38 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+				gfp_t mem_flags)
+{
+	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
+		pr_err("SG is not supported for isochronous transfer\n");
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

