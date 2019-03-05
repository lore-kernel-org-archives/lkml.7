Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80958C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5050C2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz2B+wm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfCEWFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:05:44 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37420 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfCEWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:05:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id k14so8266079ywe.4;
        Tue, 05 Mar 2019 14:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7oj10rQ2nZaSEPYYo4RkzCC2jnK7sjJGOd6R5kpo+4=;
        b=cz2B+wm0B7DRd5J9HyP0VuyikpkkRZTtQ4FI+63XSEs51gL/Uaz5tg3O97z1daL+0M
         0lLXqUfthdr9wqH+UR1s1mKD8JmovlbIdVVn+0RFHtsEroL4/dgIoZN/ksx9dIrGDCBS
         0g4QnPLa1hJDK9aYnSmMgsfbpA1Jb1y/T+jbVca+e08tEYxUkUk1iKh0zsRX+uEuxza4
         GG+l7+NZ85BHCIMD/Cg3nkkJcEOXDWCiDmw/AjRhyHw5bPXQEcRT1HN3r3K8biakrdwn
         YtCPiiqMg1U3EvrLEGTTXLrwvQHz6VjXvB9BK9svx8qKcYjhB5RzxM1O1GVgL7Qu5xH2
         tcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7oj10rQ2nZaSEPYYo4RkzCC2jnK7sjJGOd6R5kpo+4=;
        b=o8RriANhIgRYSpNEPJRvc7HIHZtFCtM/Q+y3XOR89Cuzsrw/2cC2rrp4119GAlrBY2
         PIXP31XzjXix9vcxSsX9BmNekUunyh5Q9Ph+6qbigj5LCL/FFZ+hu1xOl4blbCq785OA
         /CwFrrRKhGqxB1My35SUrBhDEdX08B4TPsCkrgfnHr3y3sofOtQXuWGR898D48Ysu1Vw
         1eU0OQMxaU+uanF4/BC60qfS1rwbsWx4EaLUC7VeyVos2irYRqNUQaJSTt/YA6QfHPJx
         2c/TF/5ofCwqEZEAUKeVaGk2lepBOG5cAkb9A88HvvfowIx5HbcZwoEGv0uZO59FMuiN
         zxEg==
X-Gm-Message-State: APjAAAXULTd50LQK3jYUoAfWqwcbTA7vAVZJwNaPThNMPE/xos9M5X70
        TByIJF5mtPZ1ZLma91wocA==
X-Google-Smtp-Source: APXvYqypChb6qijAAZgOmzYL7rQ2MlpOr03QGuIGnf29YV/l+h3bqxuv0jNoM4rRb1ZOk2QvA/ZL0A==
X-Received: by 2002:a81:990d:: with SMTP id q13mr2922259ywg.505.1551823542684;
        Tue, 05 Mar 2019 14:05:42 -0800 (PST)
Received: from localhost.localdomain ([216.21.169.52])
        by smtp.gmail.com with ESMTPSA id 81sm4126309ywr.21.2019.03.05.14.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 14:05:42 -0800 (PST)
From:   George McCollister <george.mccollister@gmail.com>
To:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        George McCollister <george.mccollister@gmail.com>
Subject: [PATCH] USB: serial: ftdi_sio: add additional NovaTech products
Date:   Tue,  5 Mar 2019 16:05:03 -0600
Message-Id: <20190305220503.8022-1-george.mccollister@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PIDs for the NovaTech OrionLX+ and Orion I/O so they can be
automatically detected.

Signed-off-by: George McCollister <george.mccollister@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 77ef4c481f3c..4e0da23a0210 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -609,6 +609,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLXM_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLX_PLUS_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORION_IO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SYNAPSE_SS200_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CUSTOMWARE_MINIPLEX_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CUSTOMWARE_MINIPLEX2_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 975d02666c5a..cb0adba174a7 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -567,7 +567,9 @@
 /*
  * NovaTech product ids (FTDI_VID)
  */
-#define FTDI_NT_ORIONLXM_PID	0x7c90	/* OrionLXm Substation Automation Platform */
+#define FTDI_NT_ORIONLXM_PID		0x7c90	/* OrionLXm Substation Automation Platform */
+#define FTDI_NT_ORIONLX_PLUS_PID	0x7c91	/* OrionLX+ Substation Automation Platform */
+#define FTDI_NT_ORION_IO_PID		0x7c92	/* Orion I/O */
 
 /*
  * Synapse Wireless product ids (FTDI_VID)
-- 
2.20.1

