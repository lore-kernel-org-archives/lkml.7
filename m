Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE901C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D932083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc4lOkBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFURqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:46:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46648 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFURqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:46:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so3337246pls.13;
        Fri, 21 Jun 2019 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOzfrSBQx7bseKzVyQsdVbmfQCLl0xd/aHSfHTlwzzA=;
        b=Mc4lOkBKvT2SoxvOZpywDG5FzyphtfqDToPmp0kIRJTAk8W7iOj/YZU4eZUm0C0ap5
         MCGfd/oss9heDq16G8qyki1js79xO1xnwwRsSjTBb4+sVBvWb7HzqixhLMSYW+eMJYiq
         J+vISx2ZcIUf79gMqe9bWdXcX9g35e4afD/0k4G4mfpF5YpXE69TYTgjhNk6QHr467R/
         1U+7bJcP3hqzPbqBQFcV+pgnDLXkZq3FdMv22FvhaBIG7ddM9+Fv+bBA7QXAnkgwq0fM
         N92klloCW6rVzqANhgIAPulM98aF/bJ96a2pCAlwCmSpWezkPF5KCn1JbSnQAPnQjmXe
         xEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOzfrSBQx7bseKzVyQsdVbmfQCLl0xd/aHSfHTlwzzA=;
        b=B6PG+7ASD12LDKuyjZHgnv0Xl1rlj/R/OMERv5BDT+pUE1IOt9Kp09LOKsvrJ1Em4y
         jhx4X9c42dToJTP1y6O7s8s8arZ7Ibstg7vnlSS8Pt8RNszotVhYwNSVkeJJFLHlU1Ip
         U9AkI3bHTqdfjwdao+4Nuk/S5U5DCX5TxH9pdAYADEbJLSL6+tR3TKYEtkhx5ictNXIV
         4arVPcQnjy9IIKLa6vjnytfqBQrt1a4rS966EK8OvmdK+KnokBCD1U+LKkCv6GQRysC5
         +vkxgJIGAl+FpbgNRDp8dH0h87bfqHXhoCP0er/Fs1J5w3HRfGPw352VUo3Az+zDnT5p
         /9QA==
X-Gm-Message-State: APjAAAWe0eeQI4NebuVyRjXuqwaiCEhzOLrOqnJjQSa2kapHpbMA/AEA
        yHAIOroCWea0KVwC0n7Abc8=
X-Google-Smtp-Source: APXvYqzjqnabmOtxPVdIAZxapgdZYZ9sZfyBLyhXu5WV381IHIxfiyQc1CiuNfv4jnCS3a7eD8IBvw==
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr10887373pld.119.1561139176436;
        Fri, 21 Jun 2019 10:46:16 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id e6sm3884820pfn.71.2019.06.21.10.46.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 10:46:16 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, stern@rowland.harvard.edu,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 1/2] usbip: Skip DMA mapping and unmapping for urb at vhci
Date:   Sat, 22 Jun 2019 02:45:52 +0900
Message-Id: <20190621174553.28862-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621174553.28862-1-suwan.kim027@gmail.com>
References: <20190621174553.28862-1-suwan.kim027@gmail.com>
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

When vhci supports SG, it is useful to use native SG list instead
of mapped SG list because dma mapping fnuction can adjust the
number of SG list that is urb->num_mapped_sgs.

But hcd provides dma mapping and unmapping function by defualt.
Moreover, it causes unnecessary dma mapping and unmapping which
will be done again at the NIC driver and it wastes CPU cycles.
So, implement map_urb_for_dma and unmap_urb_for_dma function for
vhci in order to skip the dma mapping and unmapping procedure.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 667d9c0ec905..be87c8a63e24 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1287,6 +1287,18 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+			    gfp_t mem_flags)
+{
+	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
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
@@ -1303,6 +1315,9 @@ static const struct hc_driver vhci_hc_driver = {
 
 	.get_frame_number = vhci_get_frame_number,
 
+	.map_urb_for_dma = vhci_map_urb_for_dma,
+	.unmap_urb_for_dma = vhci_unmap_urb_for_dma,
+
 	.hub_status_data = vhci_hub_status,
 	.hub_control    = vhci_hub_control,
 	.bus_suspend	= vhci_bus_suspend,
-- 
2.20.1

