Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C9C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFD6213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/uim5G3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfFRO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:28:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46744 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:28:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so7772154pgr.13;
        Tue, 18 Jun 2019 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1/I1Ufg34C1B6zIIvwm9i0iJRfJjNFEn+RuFULwkks=;
        b=X/uim5G3SmB9Xn2yHbi9R3F9S7lYpaRSc3ObBExc0ZSS7XysMJ6XJP/zBscub2V7k4
         NN3zK4x8BkffqHiiYqCfVpo4BZ28/fmHjG9iE5M4czIysaZaYINWD51MA46HmTC5nOv5
         HA0J0+S+vp+onfN4Lmk02VrBmgW2/tLbejUoUGFUfGM6A3OGCOOax2HYIM6FNl4K0Cfm
         S0n/PCUYXsOu8u2kcA5nWKVstg1LtBss7WkBBdXLpiu2QGrMxQKW7r9ajuO0wDZ5NBtX
         EM0nVm/iwtgpxHL5hjjcEJCY5vuKjQAMrJccyI8K0l2HcsTGgGra4K4P/lHLQj03nkQH
         u7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1/I1Ufg34C1B6zIIvwm9i0iJRfJjNFEn+RuFULwkks=;
        b=mJeYEM1mSTnMOng5Eue3OPp3o6HEQ81lPznfyGJEvi9aRvfQsFH1YV1hx3cl81k/dK
         T8JKx4KtEdSiMLF93NLE9DdEfw8LmH7VbSG+WowYS0K0Bg5ImT/uJlLjRKREmwMSxuka
         Sq5DXBEh83ftxnzv/xazKCiuSIOVPuQjx8dp5rL4y5UBN6N3Vta3BPAV7RO02Q2YFEGi
         9PyLwxUMs0FST/QuGpFwkkqqQ/akgyWDeUsItHjVH3+j6gDJPaaHVkmn7aAMZSIYwlOf
         7WxIUiqAztRvGZBPKQpBPg77eIJtqdIyLwmErOXwHyBaVjsOc/sVSqCONK3xHUtkKWSE
         HSng==
X-Gm-Message-State: APjAAAXBLHCXcKO144k08ztliCuJLA+aqkjHcSDmdOm0qiM27zEVZq14
        GFXuz8NyeG2GBX0DIg2EJqQKjs8s
X-Google-Smtp-Source: APXvYqxZIh1souW32CVhRK4cZknFCWaDje8FAbLxO+CiAtzHtj7ky872ihEDRNnp9vkukaxZ6O0gxA==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr3106520pgj.61.1560868128219;
        Tue, 18 Jun 2019 07:28:48 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id d6sm13902340pgf.55.2019.06.18.07.28.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:28:47 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH] usbip: Implement map_urb_for_dma function for vhci to skip dma mapping
Date:   Tue, 18 Jun 2019 23:28:17 +0900
Message-Id: <20190618142817.16844-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhci doesn’t do dma for remote device. Actually, the real dma
operation is done by network card driver. So, vhci doesn’t use and
need dma address of transfer buffer of urb.

But hcd provides dma mapping function by defualt in usb_hcd_submit_urb()
and it causes unnecessary dma mapping which will be done again at
NIC driver and it wastes CPU cycles. So, implement map_urb_for_dma
function for vhci in order to skip the dma mapping procedure.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 667d9c0ec905..9df4d9e36788 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1287,6 +1287,13 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+			    gfp_t mem_flags)
+{
+	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
+	return 0;
+}
+
 static const struct hc_driver vhci_hc_driver = {
 	.description	= driver_name,
 	.product_desc	= driver_desc,
@@ -1302,6 +1309,7 @@ static const struct hc_driver vhci_hc_driver = {
 	.urb_dequeue	= vhci_urb_dequeue,
 
 	.get_frame_number = vhci_get_frame_number,
+	.map_urb_for_dma = vhci_map_urb_for_dma,
 
 	.hub_status_data = vhci_hub_status,
 	.hub_control    = vhci_hub_control,
-- 
2.20.1

