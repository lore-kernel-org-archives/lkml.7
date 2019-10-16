Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0230ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A772207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264516;
	bh=OLGdegQHa3DJYJi1u/8icXbWKnf3l+8tAQ9VivWuHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p05mz3BWeUSAyxDp2YwFBmJduwVs7QwyLN2FHzWYDXMYKZKu1D7Gs44/R3gKVX4Fe
	 LEN0OaiVkkpFeETrp3Ocw41vuo2DiYn8PzUGtcyjQP4XPsTq/sXXyQcND8Gk14eeii
	 e5Hzee9IG6WudcMewQEaaoHydsG6w8Bm6MqHgS3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439389AbfJPWVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394868AbfJPVx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:28 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 161C3218DE;
        Wed, 16 Oct 2019 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262808;
        bh=OLGdegQHa3DJYJi1u/8icXbWKnf3l+8tAQ9VivWuHj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERasPI9cZBMXK9W+VRKSPZJ1S5tZdKDRIA0x7n/hXUWrxz8xAxAWFqKqLSMh0EFJQ
         r2IfT0Yv8SOLsI5E8x0C2jPguQortJnixDzHieX3aWfjtUZhQY9hVi7JJo4YrTmjZ2
         S8W+TJbhqJ5U3PqCEwpHBXdZ7DtltZfY8A3WWl80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beni Mahler <beni.mahler@gmx.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 50/79] USB: serial: ftdi_sio: add device IDs for Sienna and Echelon PL-20
Date:   Wed, 16 Oct 2019 14:50:25 -0700
Message-Id: <20191016214814.086738098@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beni Mahler <beni.mahler@gmx.net>

commit 357f16d9e0194cdbc36531ff88b453481560b76a upstream.

Both devices added here have a FTDI chip inside. The device from Echelon
is called 'Network Interface' it is actually a LON network gateway.

 ID 0403:8348 Future Technology Devices International, Ltd
 https://www.eltako.com/fileadmin/downloads/de/datenblatt/Datenblatt_PL-SW-PROF.pdf

 ID 0920:7500 Network Interface
 https://www.echelon.com/products/u20-usb-network-interface

Signed-off-by: Beni Mahler <beni.mahler@gmx.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    3 +++
 drivers/usb/serial/ftdi_sio_ids.h |    9 +++++++++
 2 files changed, 12 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1025,6 +1025,9 @@ static const struct usb_device_id id_tab
 	/* EZPrototypes devices */
 	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(UNJO_VID, UNJO_ISODEBUG_V1_PID, 1) },
+	/* Sienna devices */
+	{ USB_DEVICE(FTDI_VID, FTDI_SIENNA_PID) },
+	{ USB_DEVICE(ECHELON_VID, ECHELON_U20_PID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -38,6 +38,9 @@
 
 #define FTDI_LUMEL_PD12_PID	0x6002
 
+/* Sienna Serial Interface by Secyourit GmbH */
+#define FTDI_SIENNA_PID		0x8348
+
 /* Cyber Cortex AV by Fabulous Silicon (http://fabuloussilicon.com) */
 #define CYBER_CORTEX_AV_PID	0x8698
 
@@ -688,6 +691,12 @@
 #define BANDB_ZZ_PROG1_USB_PID	0xBA02
 
 /*
+ * Echelon USB Serial Interface
+ */
+#define ECHELON_VID		0x0920
+#define ECHELON_U20_PID		0x7500
+
+/*
  * Intrepid Control Systems (http://www.intrepidcs.com/) ValueCAN and NeoVI
  */
 #define INTREPID_VID		0x093C


