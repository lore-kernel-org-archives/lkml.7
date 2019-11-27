Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6255EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392F22154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889331;
	bh=+jjDHJxZIeqTOnINzZNlGxXqKuwC1sqvGEFai89MMkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+5b2eNqNHofCQ6+ChqdE/jzKqzIzPWGKgKyAi/EGD0dzmA49JmDPjO4syIAW+kPE
	 iiZeZ3P0mTpMEzCbnUHMXNt/wqs9gt5n3A+b1dV9T2/jAgG4Bm8B48NdgyaZIqDWsK
	 VmZItTvMhj+jDzxorbyadPTctE2xudfsIjdIQiGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfK0VPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387690AbfK0VPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:15:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D26D2154A;
        Wed, 27 Nov 2019 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889320;
        bh=+jjDHJxZIeqTOnINzZNlGxXqKuwC1sqvGEFai89MMkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7NX2J/9qIFPtIHrBq5i+gWMeyC9Ge1kokwPN9OCXHaxKim0yRWTK3QElM41SaDrx
         WFmo5vzaT6G5HcQhbvEJtbdFteVml09cUioW64MRPxgzU4hvyhxjZ6cfncjocrTUWA
         +aL+yZbWPSrX2pHGK6j4+Bu87r/gavwWz93qn0KM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 59/66] USB: serial: mos7840: add USB ID to support Moxa UPort 2210
Date:   Wed, 27 Nov 2019 21:32:54 +0100
Message-Id: <20191127202739.902656298@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
References: <20191127202632.536277063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Löbl <pavel@loebl.cz>

commit e696d00e65e81d46e911f24b12e441037bf11b38 upstream.

Add USB ID for MOXA UPort 2210. This device contains mos7820 but
it passes GPIO0 check implemented by driver and it's detected as
mos7840. Hence product id check is added to force mos7820 mode.

Signed-off-by: Pavel Löbl <pavel@loebl.cz>
Cc: stable <stable@vger.kernel.org>
[ johan: rename id defines and add vendor-id check ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/mos7840.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -119,11 +119,15 @@
 /* This driver also supports
  * ATEN UC2324 device using Moschip MCS7840
  * ATEN UC2322 device using Moschip MCS7820
+ * MOXA UPort 2210 device using Moschip MCS7820
  */
 #define USB_VENDOR_ID_ATENINTL		0x0557
 #define ATENINTL_DEVICE_ID_UC2324	0x2011
 #define ATENINTL_DEVICE_ID_UC2322	0x7820
 
+#define USB_VENDOR_ID_MOXA		0x110a
+#define MOXA_DEVICE_ID_2210		0x2210
+
 /* Interrupt Routine Defines    */
 
 #define SERIAL_IIR_RLS      0x06
@@ -195,6 +199,7 @@ static const struct usb_device_id id_tab
 	{USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL2_4)},
 	{USB_DEVICE(USB_VENDOR_ID_ATENINTL, ATENINTL_DEVICE_ID_UC2324)},
 	{USB_DEVICE(USB_VENDOR_ID_ATENINTL, ATENINTL_DEVICE_ID_UC2322)},
+	{USB_DEVICE(USB_VENDOR_ID_MOXA, MOXA_DEVICE_ID_2210)},
 	{}			/* terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
@@ -2020,6 +2025,7 @@ static int mos7840_probe(struct usb_seri
 				const struct usb_device_id *id)
 {
 	u16 product = le16_to_cpu(serial->dev->descriptor.idProduct);
+	u16 vid = le16_to_cpu(serial->dev->descriptor.idVendor);
 	u8 *buf;
 	int device_type;
 
@@ -2030,6 +2036,11 @@ static int mos7840_probe(struct usb_seri
 		goto out;
 	}
 
+	if (vid == USB_VENDOR_ID_MOXA && product == MOXA_DEVICE_ID_2210) {
+		device_type = MOSCHIP_DEVICE_ID_7820;
+		goto out;
+	}
+
 	buf = kzalloc(VENDOR_READ_LENGTH, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;


