Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4108C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725FF216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="wTDmHl86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404713AbfHHWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:23:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38395 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404689AbfHHWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:23:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id z14so7552495pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KXMRKOkla55qnWsYXxlUnmTW+pbKayEwS/9LRWakDG8=;
        b=wTDmHl86ZcLAYBYZGgBI2vd8vuBJ+ORrjD+ulGSwml52Q2KhRYlTWrnPpWRtgdMiQA
         1lDyram8Y0qNvEw3u0OAkH6H/zcUpa955pTKZsibEg/8fxceaI38hDAfSLEYXQ5mwMGq
         Uwe8VP5+NK+PsCiIxepnR74Q2BCBLQPSXEomy6sLrH+hmSSUrE7Fb0Wqplf5t+MZBHDQ
         +2R6hpx4eOSqh7zmsnRro1xxOm5GHxGiq7m+lAIOIHEMN6rFUHx7AlqPjDVtaGfQuBbk
         +YyyWDJEB5U8jimuBdztq5CRVN0uLvvcVuCKKL6f3uA9KPlu9Nx5Ua8pzeBtrYahn3PH
         ulGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KXMRKOkla55qnWsYXxlUnmTW+pbKayEwS/9LRWakDG8=;
        b=hdV9bWGApjG2Cj6tPRqtk2XMqdTlFIi3w1ynk6utfv5XXydjvoK1V7tiJm6HE8Zlis
         20UDsveLjNabxUImHNyislv2Dk819XSr5PXKDZQ4A5iH3Ap52ovXrj7n0GYR47mA35Pn
         r4lIXmR/J2RGAO8B9xYe7BzFdDk873OlJlupY3EtXINYKMQIttptnHr6oo4VfT06I0Sy
         OO0vycdxzCS4f0lxDfP+G37/pPQ21lIDUy4iU9CqMusMuk1xX3UKij9mbMu7SI1S9Ggc
         yxn9u9T7NfK624DzHOBTRdK8ojv1/kXQO+b79zNW6oJ1wraw3LHTS8yC7O/8aGfP3PgQ
         gjKg==
X-Gm-Message-State: APjAAAU9ZikEEi3iFdNB3EftYAl2TU5+fSj8nAg8FeLyJZE0mX1feQwQ
        DaKNRYnzwd3QG+FavZDjIL21wnbfEP1mIA==
X-Google-Smtp-Source: APXvYqz/Bux726oq0ULlXMowmGDltzYQb7FMXtB+TjNmXzd52pLdiBaIEgfiYwuTFCqB2WkLnABW0Q==
X-Received: by 2002:a62:38c6:: with SMTP id f189mr17886283pfa.157.1565303038267;
        Thu, 08 Aug 2019 15:23:58 -0700 (PDT)
Received: from e6f2834286fb.pdc.gateworks.com (68-189-91-139.static.snlo.ca.charter.com. [68.189.91.139])
        by smtp.gmail.com with ESMTPSA id bg3sm3257856pjb.9.2019.08.08.15.23.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:23:57 -0700 (PDT)
From:   Matthew Michilot <mmichilot@gateworks.com>
X-Google-Original-From: Matthew Michilot <matthew.michilot@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Michilot <matthew.michilot@gmail.com>
Subject: [PATCH] USB: serial: ftdi_sio: add support for FT232H CBUS gpios
Date:   Thu,  8 Aug 2019 22:23:48 +0000
Message-Id: <20190808222348.4428-1-matthew.michilot@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for cbus gpios on FT232H. The cbus configuration is
stored in one word in the EEPROM at byte-offset 0x1a with the mux
config for ACBUS5, ACBUS6, ACBUS8 and ACBUS9 (only pins that can be
configured as I/O mode).

Tested using FT232H by configuring one ACBUS pin at a time.

Review-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Matthew Michilot <matthew.michilot@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 4b3a049561f3..c8d35faa8f61 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2023,6 +2023,46 @@ static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
 	return 0;
 }
 
+static int ftdi_gpio_init_ft232h(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	u8 *buf;
+	u16 cbus_config;
+	int ret;
+	int i;
+
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ftdi_read_eeprom(port->serial, buf, 0x1A, 4);
+	if (ret < 0)
+		goto out_free;
+
+	/*
+	 * FT232H CBUS Memory Map
+	 *
+	 * 0x1A: 8X (upper nibble -> AC5)
+	 * 0x1B: X8 (lower nibble -> AC6)
+	 * 0x1C: 88 (upper nibble -> AC8 | lower nibble -> AC9)
+	 */
+	cbus_config = (((buf[0] & 0xf0) | (buf[1] & 0xf)) << 8 | buf[2]);
+
+	priv->gc.ngpio = 4;
+	priv->gpio_altfunc = 0xff;
+
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		if ((cbus_config & 0xf) == FTDI_FTX_CBUS_MUX_GPIO)
+			priv->gpio_altfunc &= ~BIT(i);
+		cbus_config >>= 4;
+	}
+
+out_free:
+	kfree(buf);
+
+	return ret;
+}
+
 static int ftdi_gpio_init_ft232r(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -2104,6 +2144,9 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
 	case FTX:
 		result = ftdi_gpio_init_ftx(port);
 		break;
+	case FT232H:
+		result = ftdi_gpio_init_ft232h(port);
+		break;
 	default:
 		return 0;
 	}
-- 
2.17.1

