Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7573AFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446A720872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263460;
	bh=Yzw/3d2j0WY5wr/qB3QLvmZXyYZmfj5Lu6FIZXpaxn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G3xCx+JCnA7YJQwM8+zaZqcl//iN9cVObbxlmosAjfFKJ0mYX+xXVw2eYTmRtBRDC
	 lkWM0ULG5a+cnedVsdv1uUAtg8mDBXd7k6KUlIk1zoiy96koO4dLaBqoeIM4FhmnCO
	 5RlMpOge27rh7CT9UYLWWJSZ+vM6Z2pfFBJQS6uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406842AbfJPWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438386AbfJPV7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:05 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3FA222C2;
        Wed, 16 Oct 2019 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263145;
        bh=Yzw/3d2j0WY5wr/qB3QLvmZXyYZmfj5Lu6FIZXpaxn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucsyybagAhDbL4f3M04j3E5ABDv4FPJbJwaUfv5aEndzXepq1K+sqLwmdSVCaW5kJ
         puMeIvjkKoBmdlg9k6l3Uia33ujBvnxNGBs7X7R73NdGcvJQYfqkewkMbacBJdr5NU
         9dyJtOzFj+NOqHLweYfJOrXTtTD0k5gtsS6Yc9YU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beni Mahler <beni.mahler@gmx.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 027/112] USB: serial: ftdi_sio: add device IDs for Sienna and Echelon PL-20
Date:   Wed, 16 Oct 2019 14:50:19 -0700
Message-Id: <20191016214852.704485914@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
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
@@ -1030,6 +1030,9 @@ static const struct usb_device_id id_tab
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
@@ -39,6 +39,9 @@
 
 #define FTDI_LUMEL_PD12_PID	0x6002
 
+/* Sienna Serial Interface by Secyourit GmbH */
+#define FTDI_SIENNA_PID		0x8348
+
 /* Cyber Cortex AV by Fabulous Silicon (http://fabuloussilicon.com) */
 #define CYBER_CORTEX_AV_PID	0x8698
 
@@ -689,6 +692,12 @@
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


