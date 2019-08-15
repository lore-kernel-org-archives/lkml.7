Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D091C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2482063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnGKfGQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfHORl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:41:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfHORl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:41:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so1595833pgi.6;
        Thu, 15 Aug 2019 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ItZidBUf697ScM1HdSkE4tHlaXM51upzkEib4CqA/pY=;
        b=hnGKfGQe01l3dSshgshM4c/cZvihrL5Rh4HV5BO3ByLpi8+P2VUEyFKzjbo6j8jZOO
         5i9jEfAeoqMqID44E7uDRarzUw/OyOI1YcPC5WJAuFtRWYsSoLyN1psGijTSUG/dXbTE
         JO44Qo8Xv8vrA/HNtYEIyuS1X9mRjTtiLrQRKrbM+psCqnG6j/NYKOIYWHJ43s+OdB69
         cfWXpi0sFStjTTAOAxdkjNEsfPfUK1JXZ0YesXFQzwM65d9rwftySgsaNaoId6porTrx
         1hZo6lZZXibKHZTxd1PSIQK5z2EKpkr1OJxuIYFp95vKs4ZRSYFGdjgDHz/ab38R1D9t
         c3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ItZidBUf697ScM1HdSkE4tHlaXM51upzkEib4CqA/pY=;
        b=WujqhhXRWp9yTnWM39Wy9ysxGnIZyOohxvy7lOLTPSJhoM/KUp/qvJxhoaLRnuQGGc
         nBPfsad/vlfYYpgoeUYzn4tZY+6X9Vd6ducL1szRqQnljBY0MxEixBmm12KZOV9vPwyV
         YP3Nw+bH6eM0azFfdHFA1XugvSvCNJkoqSd2Kjs/uDadRqGcj9SJ547R6ClPJC4g42dV
         8xYUDWmEV2FPIhPZnPi3UH4b8ToVt86KW8USaPiSumS7NDuGJgurQcaEig4LZtlCAYia
         hkb7bZUqDEFmjzxISM+8l8PcfNaqqUv2n5quYlIpQAKmBlVsGXMH4e/M+j4Qo1/+gDSm
         oBVw==
X-Gm-Message-State: APjAAAXFwFuy7ci+WyMyi4Uaz9lWl9M0Rk2tgAsUTZ/og7g/G3Jv20Ri
        wbH07xhxkFv0qiTDfrevaVo=
X-Google-Smtp-Source: APXvYqz4+9crOMkf9DxJf0OwlOMNnnUVYR1SUToP0xKojERpDXMDfeCIPRu8mKC6Iu/TDiCaCfUc5w==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr3312753pjw.60.1565890887150;
        Thu, 15 Aug 2019 10:41:27 -0700 (PDT)
Received: from e6f2834286fb.pdc.gateworks.com (68-189-91-139.static.snlo.ca.charter.com. [68.189.91.139])
        by smtp.gmail.com with ESMTPSA id s24sm2756670pgm.3.2019.08.15.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:41:26 -0700 (PDT)
From:   Matthew Michilot <matthew.michilot@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Michilot <matthew.michilot@gmail.com>
Subject: [PATCH v2] USB: serial: ftdi_sio: add support for FT232H CBUS gpios
Date:   Thu, 15 Aug 2019 17:40:54 +0000
Message-Id: <20190815174054.20240-1-matthew.michilot@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808222348.4428-1-matthew.michilot@gmail.com>
References: <20190808222348.4428-1-matthew.michilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for cbus gpios on FT232H. The cbus configuration is
stored in one word in the EEPROM at byte-offset 0x1a with the mux
config for ACBUS5, ACBUS6, ACBUS8 and ACBUS9 (only pins that can be
configured as I/O mode).

Tested using FT232H by configuring one ACBUS pin at a time.

Signed-off-by: Matthew Michilot <matthew.michilot@gmail.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
---
V2:
- made hex notation all lowercase for consistency
- allocated 4 bytes instead of 2 bytes for buffer
- improved documentation on FT232H CBUS memory mapping
- fixed CBUS pins being incorrectly mapped to the wrong gpios
- sorted case labels alphabetically
---
 drivers/usb/serial/ftdi_sio.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 4b3a049561f3..01e4ecccd079 100644
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
+	buf = kmalloc(4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ftdi_read_eeprom(port->serial, buf, 0x1a, 4);
+	if (ret < 0)
+		goto out_free;
+
+	/*
+	 * FT232H CBUS Memory Map
+	 *
+	 * 0x1a: X- (upper nibble -> AC5)
+	 * 0x1b: -X (lower nibble -> AC6)
+	 * 0x1c: XX (upper nibble -> AC9 | lower nibble -> AC8)
+	 */
+	cbus_config = buf[2] << 8 | (buf[1] & 0xf) << 4 | (buf[0] & 0xf0) >> 4;
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
@@ -2098,6 +2138,9 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
 	int result;
 
 	switch (priv->chip_type) {
+	case FT232H:
+		result = ftdi_gpio_init_ft232h(port);
+		break;
 	case FT232RL:
 		result = ftdi_gpio_init_ft232r(port);
 		break;
-- 
2.17.1

