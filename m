Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF75FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40A8217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFaE7hvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405590AbfHBRhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:37:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36052 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbfHBRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:37:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so33923776plt.3;
        Fri, 02 Aug 2019 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=me5T3lDP0XHqzPg3hsXbz18y3fE9lT7QG8JAwG3e6dw=;
        b=qFaE7hvZGut8iWN8Jn/ffF/evZUbFkxFQPkMUm/ZfuX9YMYAGrrJYwIgTsg5tTPOIc
         E570f2F1IDetChqThDcmIX+Y6/5bpdaZLNitmRtDoOg8jM1ZSOBO3riucJAx7pXNz6Is
         52247nXfRuRCeezPQJtU+xac9H03pGK2bSbjlRriPMt/xhqhron9+bXcCdMceOBOSSig
         6YrTXwooSFEnbkfL6uMkZ39Nh9WhBEbI5rvfj0Z05tvaz9bfPIPVwcw+X+KwEjdzEzAY
         /9tVHVVyGjhtmvVqHrrZhQEpW67dAZyHhLW5I0+iteJyVZDUsQTfZAOFdD4w0IciW7+S
         d1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=me5T3lDP0XHqzPg3hsXbz18y3fE9lT7QG8JAwG3e6dw=;
        b=eLlF2C4L8toYJS6ppot5LbKE9UgTWI1NsoFYrvkHw5XaZZixHqqbOxmKyqrRWKntfm
         tvUcJxf3EuCDNv0Vc0nQWcIQPlDyPh0q2jD6CpjNiG8LzPiJ5aerbkLr3+s95fkTIyPe
         VutfzIGxzUZVPGSW0eLknqNKLp+EplTEBHoDTLG0xRrS1E+rwZx4aPDo7GAR6ilmBHk5
         9aMAAoIC5N343gAERd1oaVY5+Kvo9o1ZA0GZXBjQa0QCQ+olFoviBdlbDRe6/8uYymd1
         DAUTNlaqU+ajXDRRHedaCquE9iUggIKXDm0/3A50TwB8WyHqwOn0A/z+ifdBkquzp7mR
         bsRg==
X-Gm-Message-State: APjAAAVsOH+JZxZscjvlmvmm0Rb8WH2qPhOCFt75fvrtCf9Z3iPo+oB8
        UTWIOf1MraQt1FefOzjoiTo=
X-Google-Smtp-Source: APXvYqz+56v9dCnIsMT5Z3PP/An82d2HvShpib5agLhdjPNBZoRqSrNZSPbTJ9lD3XwOc5duw2foNg==
X-Received: by 2002:a17:902:2a26:: with SMTP id i35mr130452561plb.315.1564767425535;
        Fri, 02 Aug 2019 10:37:05 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id a20sm7992911pjo.0.2019.08.02.10.37.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 10:37:05 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v3 1/2] usbip: Skip DMA mapping and unmapping for urb at vhci
Date:   Sat,  3 Aug 2019 02:36:50 +0900
Message-Id: <20190802173651.22247-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802173651.22247-1-suwan.kim027@gmail.com>
References: <20190802173651.22247-1-suwan.kim027@gmail.com>
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
 drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 000ab7225717..c62f7fa8118c 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+		gfp_t mem_flags)
+{
+	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
+		WARN_ON(1);
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

