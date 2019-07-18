Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BDC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676D72077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419687;
	bh=X2/lEcq6scKsMBWfNNSoFC09TD54ijIEPNUAJEBlZag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tUYY0z5icTeG8gWFq/i7KCRXXF23PETRQlOG8ODV4pa+LOiBkb7TXGfrWoTCIhxUD
	 WBA5andnYq0n/Sp5rX/cZp3B6oP4nGtP8Npcg1s0r9gjS5ISqVNaBu/suKkfT7rXom
	 2Rb3XIbA4G8otFzIZHH/lbmXSJXmCq6N0O9HUil0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403915AbfGRDOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389327AbfGRDOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:41 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7604E21855;
        Thu, 18 Jul 2019 03:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419680;
        bh=X2/lEcq6scKsMBWfNNSoFC09TD54ijIEPNUAJEBlZag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGyGwIO0SLrtMxNaK7pffZ2j4FoqRDitiF/FtP26L3D8uzQWehx6K1jofvNL5NKy4
         zebWcsXah0/pbb7qE3mkMQsXDixeHfAG3W7AUF0vpaMojHJvkEpniTiII08eZ8NEQY
         7UCwRODeyS6py2ovVXpi6vIkM3W/G8xmINCRye00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andreas Fritiofson <andreas.fritiofson@unjo.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 19/40] USB: serial: ftdi_sio: add ID for isodebug v1
Date:   Thu, 18 Jul 2019 12:02:15 +0900
Message-Id: <20190718030046.745450870@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Fritiofson <andreas.fritiofson@unjo.com>

commit f8377eff548170e8ea8022c067a1fbdf9e1c46a8 upstream.

This adds the vid:pid of the isodebug v1 isolated JTAG/SWD+UART. Only the
second channel is available for use as a serial port.

Signed-off-by: Andreas Fritiofson <andreas.fritiofson@unjo.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    1 +
 drivers/usb/serial/ftdi_sio_ids.h |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1024,6 +1024,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
 	/* EZPrototypes devices */
 	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
+	{ USB_DEVICE_INTERFACE_NUMBER(UNJO_VID, UNJO_ISODEBUG_V1_PID, 1) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1542,3 +1542,9 @@
 #define CHETCO_SEASMART_DISPLAY_PID	0xA5AD /* SeaSmart NMEA2000 Display */
 #define CHETCO_SEASMART_LITE_PID	0xA5AE /* SeaSmart Lite USB Adapter */
 #define CHETCO_SEASMART_ANALOG_PID	0xA5AF /* SeaSmart Analog Adapter */
+
+/*
+ * Unjo AB
+ */
+#define UNJO_VID			0x22B7
+#define UNJO_ISODEBUG_V1_PID		0x150D


