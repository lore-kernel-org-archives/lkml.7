Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A12C468A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B34920843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR6sdkSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfGEQoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:44:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfGEQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:44:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so4540250pff.9;
        Fri, 05 Jul 2019 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIdsJBlUPjM8WHpD9LJ2+yFLP6iSJp64o+eyXmvQqGk=;
        b=VR6sdkSXJEC5bHIKzOT/KyH1uGDpKv4JevF6CuhEF5ZY563whg1aSoBiDdF4lhwwBs
         CxL61+V7P51n/NS8Kz6seRGIbY2xdDKi766ERvLfgX6caEggG0Kwnrz5Pn84R7U1k/Mv
         MIP2XPw1ExNPRnDWkBcOBmu4xpflmw+JPeJU5ma7xdxcnDNw9Wbs1taWAPBORrY6IfWM
         65NaADI888HDT/WvgQeQ9sJ52pXhP8swvbDPzLqcounLdRHbAQ4hg0VC94GdTsrjwbSL
         WAPL/YLFdAVcRiBprcI9FbaQj3XH1Du/aOxn+m9Mp6/7QyQY8FJm1A2r0WI+r+hV5H9i
         nDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIdsJBlUPjM8WHpD9LJ2+yFLP6iSJp64o+eyXmvQqGk=;
        b=lUUj+KcmxRVI4w/wZh1jKIz1RAChhb/delRAsYXaklvJo87m25Tp+hYgGbr15kplKt
         2KE1jVE9V+/Iw/gMYgMUoEU5Q0fAsvvRRlDTlg5daBGqpMaGALiJjKmgvYUMvWjXmb2/
         29nI/xZ/1V9sds6D+3WrzgkuZ4GuMr7uUyT4E2boccLueLy5flAxgOB3g1oieZswQiRu
         Kt8V5HICmToY7CM/8fS63db1qAP5aunzO5ZHzXvQ1/ODM/r/Bx9GZTiALiymZqT8dz2+
         N0RMxywwOoqRmwcKOPowmLYtVPw1CFromUOfCQR8Qzyg0obPKJfJMqTsFKwCVBznhp2l
         nE6g==
X-Gm-Message-State: APjAAAVNoJORuYtfyfj3WmCk8j1aA6XeezIB5w1t6m4umAhhCzxjZdmz
        dIcr4NYqNz3GgoXOt/tM4uA=
X-Google-Smtp-Source: APXvYqwCArqwUJuXC9T9nN7v42JALBz3boQHRxT3qJYCOVu6j+RoDv5iT/D6bvm02zfvo2cvEVsXqA==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr6992363pji.142.1562345073499;
        Fri, 05 Jul 2019 09:44:33 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id n89sm22033297pjc.0.2019.07.05.09.44.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:44:33 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 1/2] usbip: Skip DMA mapping and unmapping for urb at vhci
Date:   Sat,  6 Jul 2019 01:43:54 +0900
Message-Id: <20190705164355.14025-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164355.14025-1-suwan.kim027@gmail.com>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
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

When it comes to supporting SG for vhci, it is useful to use native
SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
fnuction can adjust the number of SG list (urb->num_mapped_sgs).

But HCD provides DMA mapping and unmapping function by default.
Moreover, it causes unnecessary DMA mapping and unmapping which
will be done again at the NIC driver and it wastes CPU cycles.
So, implement map_urb_for_dma and unmap_urb_for_dma function for
vhci in order to skip the DMA mapping and unmapping procedure.

To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
urb->transfer_flags if URB has SG list and this flag will tell the
stub driver to use SG list.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 000ab7225717..14fc6d9f4e6a 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+			gfp_t mem_flags)
+{
+	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
+
+	if (urb->num_sgs)
+		urb->transfer_flags |= URB_DMA_MAP_SG;
+
+       return 0;
+}
+
+static void vhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+{
+       dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");
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

