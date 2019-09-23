Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9B7C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632D320867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfIWKtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:49:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41780 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732076AbfIWKtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:49:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CBAF1A02C7;
        Mon, 23 Sep 2019 12:49:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C6A91A002E;
        Mon, 23 Sep 2019 12:49:39 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E6CD6402EE;
        Mon, 23 Sep 2019 18:49:33 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc:     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] usb: hub add filter for device with specific VID&PID
Date:   Mon, 23 Sep 2019 18:51:02 +0800
Message-Id: <20190923105102.37413-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT "Unsupported
Device" Message require to stop enumerating device with VID=0x1a0a PID=0x0201
and pop message to declare this device is not supported.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/usb/core/hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bbcfa63..3cda0da 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4982,6 +4982,18 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (status < 0)
 			goto loop;
 
+		 /* USB 2.0 Embedded Host PET Automated Test (CH6)
+		 * 6.7.23 A-UUT "Unsupported Device" Message
+		 * require to filter out below device when enumeration
+		 */
+		if ((udev->descriptor.idVendor == 0x1a0a)
+		 && (udev->descriptor.idProduct == 0x0201)) {
+			dev_err(&udev->dev, "This device is not supported: idVendor=0x%x idProduct=0x%x\n",
+				udev->descriptor.idVendor,
+				udev->descriptor.idProduct);
+			goto done;
+		}
+
 		if (udev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(2000);
 
-- 
2.7.4

