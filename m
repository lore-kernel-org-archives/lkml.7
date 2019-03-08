Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D732C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7B20449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049893;
	bh=/2Y7g+Rsja9Jorc7r+0KHHfajtd0E8Jw3oaTw0ict1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rECs2AqFzz+b8EUT8QO6oA13URNSkRbvSl8lVC4I6EYs9uZPz4LuGEJi8xMsVcMlN
	 RVUF2sEe1Gx5yaI/CwP5CW95ZFxxNFpwONZpen9HSMvNImbCso2pNKy34GwSUqmm3h
	 iiIhu36AVYC6YOud6NcSAEweFuzYl/yZ8NkFWyjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCHM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfCHM6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0202C2085A;
        Fri,  8 Mar 2019 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049886;
        bh=/2Y7g+Rsja9Jorc7r+0KHHfajtd0E8Jw3oaTw0ict1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxJ9PpNmmGxX6Gm610mhklzttMFMPQTgvgSsOLokVzNdxltPf8krVuH15oMweOGsB
         Z9kUKaDuzwBJH9wxSjnOgLdB/olcVDRazvw2YOqMCN3GSaucIGDIIQaGkIr4JXfCep
         8B+rhNkw2PJHVqOTHjGzMVqgKaGs1fD3Oyo58+H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 18/68] qmi_wwan: Add support for Quectel EG12/EM12
Date:   Fri,  8 Mar 2019 13:49:48 +0100
Message-Id: <20190308124911.732376152@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kristian Evensen <kristian.evensen@gmail.com>

[ Upstream commit 822e44b45eb991c63487c5e2ce7d636411870a8d ]

Quectel EG12 (module)/EM12 (M.2 card) is a Cat. 12 LTE modem. The modem
behaves in the same way as the EP06, so the "set DTR"-quirk must be
applied and the diagnostic-interface check performed. Since the
diagnostic-check now applies to more modems, I have renamed the function
from quectel_ep06_diag_detected() to quectel_diag_detected().

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -976,6 +976,13 @@ static const struct usb_device_id produc
 					      0xff),
 		.driver_info	    = (unsigned long)&qmi_wwan_info_quirk_dtr,
 	},
+	{	/* Quectel EG12/EM12 */
+		USB_DEVICE_AND_INTERFACE_INFO(0x2c7c, 0x0512,
+					      USB_CLASS_VENDOR_SPEC,
+					      USB_SUBCLASS_VENDOR_SPEC,
+					      0xff),
+		.driver_info	    = (unsigned long)&qmi_wwan_info_quirk_dtr,
+	},
 
 	/* 3. Combined interface devices matching on interface number */
 	{QMI_FIXED_INTF(0x0408, 0xea42, 4)},	/* Yota / Megafon M100-1 */
@@ -1343,17 +1350,20 @@ static bool quectel_ec20_detected(struct
 	return false;
 }
 
-static bool quectel_ep06_diag_detected(struct usb_interface *intf)
+static bool quectel_diag_detected(struct usb_interface *intf)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_interface_descriptor intf_desc = intf->cur_altsetting->desc;
+	u16 id_vendor = le16_to_cpu(dev->descriptor.idVendor);
+	u16 id_product = le16_to_cpu(dev->descriptor.idProduct);
 
-	if (le16_to_cpu(dev->descriptor.idVendor) == 0x2c7c &&
-	    le16_to_cpu(dev->descriptor.idProduct) == 0x0306 &&
-	    intf_desc.bNumEndpoints == 2)
-		return true;
+	if (id_vendor != 0x2c7c || intf_desc.bNumEndpoints != 2)
+		return false;
 
-	return false;
+	if (id_product == 0x0306 || id_product == 0x0512)
+		return true;
+	else
+		return false;
 }
 
 static int qmi_wwan_probe(struct usb_interface *intf,
@@ -1390,13 +1400,13 @@ static int qmi_wwan_probe(struct usb_int
 		return -ENODEV;
 	}
 
-	/* Quectel EP06/EM06/EG06 supports dynamic interface configuration, so
+	/* Several Quectel modems supports dynamic interface configuration, so
 	 * we need to match on class/subclass/protocol. These values are
 	 * identical for the diagnostic- and QMI-interface, but bNumEndpoints is
 	 * different. Ignore the current interface if the number of endpoints
 	 * the number for the diag interface (two).
 	 */
-	if (quectel_ep06_diag_detected(intf))
+	if (quectel_diag_detected(intf))
 		return -ENODEV;
 
 	return usbnet_probe(intf, id);


