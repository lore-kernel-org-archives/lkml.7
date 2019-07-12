Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB7C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04432166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934610;
	bh=T/Oa2dK6GoM4tKHT07w1iRVwjd7s80b2skmvamRAhPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XCNDQdlw3dqoKELP+keT90NvqNBbWqut8MuE6XtcY275/pMgKNvviUzEfbiGhJT7p
	 cXf2yyNxgNk9hR7BuuUKrNTp/w+CqKdMAcaOj4KTABBE6hQtPvApn2FnWYFtjYJj4Q
	 OQJ1m60S3Fz8FxjGsa2fVE3VQhhk2lGs3ri0U/Is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfGLMaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfGLMaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:30:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551592166E;
        Fri, 12 Jul 2019 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934601;
        bh=T/Oa2dK6GoM4tKHT07w1iRVwjd7s80b2skmvamRAhPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpyrH+f/u7gLSFYTyPqhZzArJGu35UIHdJKAUsITv226X/70oQp/6LKi5S68DngcO
         h4To0vjRquMbpTZrWMoLgde/iyDTsHloqagqJYUhHk6GKDZ2lkfWmmXHuq+WNjA98P
         LVYMz2hiXu/w7pd2zOU7Wxr9AI/qRySQ77kK6nj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andreas Fritiofson <andreas.fritiofson@unjo.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.1 108/138] USB: serial: ftdi_sio: add ID for isodebug v1
Date:   Fri, 12 Jul 2019 14:19:32 +0200
Message-Id: <20190712121632.904395964@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
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
@@ -1029,6 +1029,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
 	/* EZPrototypes devices */
 	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
+	{ USB_DEVICE_INTERFACE_NUMBER(UNJO_VID, UNJO_ISODEBUG_V1_PID, 1) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1543,3 +1543,9 @@
 #define CHETCO_SEASMART_DISPLAY_PID	0xA5AD /* SeaSmart NMEA2000 Display */
 #define CHETCO_SEASMART_LITE_PID	0xA5AE /* SeaSmart Lite USB Adapter */
 #define CHETCO_SEASMART_ANALOG_PID	0xA5AF /* SeaSmart Analog Adapter */
+
+/*
+ * Unjo AB
+ */
+#define UNJO_VID			0x22B7
+#define UNJO_ISODEBUG_V1_PID		0x150D


