Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02ABC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AF221881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IasK3Q2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfFSPlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:41:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43968 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:41:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so9975728pfg.10;
        Wed, 19 Jun 2019 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkiWE/zp1jKsrQI1Q/KB+EfF9ySaqYmDKlecitQY2q8=;
        b=IasK3Q2dzh9JkLOqt7ZBHvPQPADVvU4ZUITgyCdLoyZqug28NxK1MQrI0EFgX3mo+C
         HtXnQSnhskx8pVPRR/06ExunX+ork4XkS/01gn/Lc1dneohLRWs5zaK9G0Ys4Zoc6P0e
         BYdFP3iq3W0BFeggmAvIyYjnryYearr+WECJg3gFHV/PWOqVJ1N8xsqrwhHEyasNf0gy
         iKLc2btANa924FtL2CYfZwEzRdC2QUoN/1OIfktShivCeICvZdVr6e2dkqAwiq+0w2XY
         I72ZnbK0XUFRq/gIbZFoh7BHz2IfIGkD8jszT0+EIkDCXU/hBcnHc2hO1cl86M0la2gH
         y8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkiWE/zp1jKsrQI1Q/KB+EfF9ySaqYmDKlecitQY2q8=;
        b=NtjdHQqeQVw4P7HFoN54ZcxHKbwXZyRaYjrhW5Iafh1SB7kP8PkIgZcx3udAOur16M
         AFtAweRfhbwvQ7z8U7fJH0p3DG0qoLzD2qwgAWje3cpRWZ1O8rfIaTSrx98Ip9KLR6sO
         stdXmEudj9QH9cQm22ZQheTdx69IM/784bKJhun6V/m2yBMHloGdf2BniuhVxAuZgtZl
         EDuQyxzu3jvROdQ+K3bfCGyghiG4qs1neAR3rp2aqLU7j9OAu5WCLKAkcphQBF5oOWcN
         MV6rYUpxsAdPX/yhSCzPWu9GQGqSG3cyNYx5USEHmt2V05vo3WeqIjQEoVYWPXEujy14
         mgHA==
X-Gm-Message-State: APjAAAWETTk7S9PHRIv7qbhUY9gNqtNyp65hT2vTXMLljC50wKMADmx5
        IUgb/6PCL4TUl1yydBPze8c=
X-Google-Smtp-Source: APXvYqwcTU2aL/9y/rjim5bCbUsnDIM5QBVqan2+nXDiqUpYU7ZAFkgSGbSK2RyRvr3oBekFECwRlA==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr12094988pjq.43.1560958871261;
        Wed, 19 Jun 2019 08:41:11 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id 85sm20966823pgb.52.2019.06.19.08.41.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:41:10 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2] usbip: Skip DMA mapping and unmapping for urb at vhci
Date:   Thu, 20 Jun 2019 00:40:41 +0900
Message-Id: <20190619154041.30363-1-suwan.kim027@gmail.com>
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

But hcd provides dma mapping and unmapping function by defualt and
it causes unnecessary dma mapping and unmapping which will be done
again at the NIC driver and it wastes CPU cycles. So, implement
map_urb_for_dma and unmap_urb_for_dma function for vhci in order to
skip the dma mapping and unmapping procedure.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
v2 
 - Rename the subject of the patch
 - Add unmap_urb_for_dma function according to Alan's comment
---
 drivers/usb/usbip/vhci_hcd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 667d9c0ec905..e26ce22c1b0f 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1287,6 +1287,18 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	return 0;
 }
 
+static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+			    gfp_t mem_flags)
+{
+	dev_dbg(&hcd->self.root_hub->dev, "vhci does not map for dma\n");
+	return 0;
+}
+
+static void vhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+{
+	dev_dbg(&hcd->self.root_hub->dev, "vhci does not unmap for dma\n");
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

