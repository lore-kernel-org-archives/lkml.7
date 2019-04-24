Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1A4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D23218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c50nKEv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbfDXOtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:49:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35766 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbfDXOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:49:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so17161711ljc.2;
        Wed, 24 Apr 2019 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bofPGkO0Fr+MuENc58WU9P5S59OCZQC8382116tFtCg=;
        b=c50nKEv/w+xO5RPKV7gxufTcXqfQ+1tT10gGQtegZOKIa6aYKeVzOCnewV2HGwleI9
         eVE4PXuaAC73S3WlUUKk0GRSZRReJsQ3DU04GmzMn0xA24D0Xp4hgYII5bj2q/7pFnhc
         nBo6Co17Tf+YoOZY4QcbOtZBJOkrpNOCAz6wMZCRK6TSIWpqxEYJrmS695Gagup0cxSc
         uKDFBu/cDNiKsBK4XFWeC9OIDx4meVYOKLD6YuBN5ncAHPb8LPFTmDDpwQZxdT2+tm5J
         fFdCyQnxRhKLWDJBLjICNzTlIMWGpn3kzOXwXmXvprzl3DSvzpXCxf5BQVFzUTImfWNz
         ytAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bofPGkO0Fr+MuENc58WU9P5S59OCZQC8382116tFtCg=;
        b=E4PTwP6JAxqm23LuPLsJtLfwNKA27vqEsCvyZIBIpO15aFkGc9D2o3vRh9phqAvAdJ
         0c4DtEA2TpKdZJz9uxWIrpWKh2fCQpiElzYFb2Io29lKu8T33N8esyWIuBGV/4rRyd7N
         w+0b3iFOa32vQnZAdkUT/pj/X/VCl+v0aSnaPTSjug1hU+nn2Foxy9AjNYHrpr8qBx9G
         /A4++AdQ1Mo4UXFn34no0PblKtWiiolyQtndYr3QtmXO7vktd+c9VMwC4B9AdFEltY+2
         ACUx5eMDGTcikCaoZylP7AJ71xSkly692tyDZPTvwqPs2hhMVLBNFSVubEQK+j/SWDWT
         o95w==
X-Gm-Message-State: APjAAAUYYVu9XqRwlXjTwzf0aYpitfg2ao4TyiKEqLEYBUlEul6byYAR
        nstz83Lz0jdNBW2JMuhBiJj/QlViKec=
X-Google-Smtp-Source: APXvYqyoXVZbgnCl1EFhYDQDLYZOELvk49LAXkjFsQlYlRe/vxojRIrDSRrx9IbwM0rTmBV8UcM7ug==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr17951314ljb.3.1556117383924;
        Wed, 24 Apr 2019 07:49:43 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id h26sm2273109lfm.11.2019.04.24.07.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 07:49:42 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usb251xb: Lock i2c-bus segment the hub resides
Date:   Wed, 24 Apr 2019 17:49:14 +0300
Message-Id: <20190424144914.10580-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
state. This is the mode the hub is supposed to be to let this driver
work correctly. But a race condition might happen right after reset
is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
function. In case if the reset pin is handled by a i2c GPIO expander,
which is also placed at the same i2c-bus segment as the usb251x
SMB-interface connected to, then the hub reset clearance might
cause the CFG_SEL[0] being latched in unpredictable state. So
sometimes the hub configuration mode might be 0x1 (as expected),
but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
interface activated and consequently causes this driver failure.

In order to fix the problem we must make sure the GPIO-reset chip doesn't
reside the same i2c-bus segment as the SMBus-interface of the hub. If
it doesn't, we can safely block the segment for the time the reset is
cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
just return an error. If we locked the i2c-bus segment and tried to
communicate with the GPIO-expander, it would cause a deadlock. If we didn't
lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/usb/misc/usb251xb.c | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 04684849d683..939b3bedd4c8 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/nls.h>
@@ -222,11 +223,44 @@ static const struct usb251xb_data usb2517i_data = {
 	.product_str = "USB2517i",
 };
 
+static int usb251xb_check_dev_children(struct device *dev, void *child)
+{
+	if (dev->type == &i2c_adapter_type) {
+		return device_for_each_child(dev, child,
+					     usb251xb_check_dev_children);
+	}
+
+	return (dev == child);
+}
+
+static int usb251x_check_gpio_chip(struct usb251xb *hub)
+{
+	struct gpio_chip *gc = gpiod_to_chip(hub->gpio_reset);
+	struct i2c_adapter *adap = hub->i2c->adapter;
+	int ret;
+
+	if (!hub->gpio_reset)
+		return 0;
+
+	if (!gc)
+		return -EINVAL;
+
+	ret = usb251xb_check_dev_children(&adap->dev, gc->parent);
+	if (ret) {
+		dev_err(hub->dev, "Reset GPIO chip is at the same i2c-bus\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void usb251xb_reset(struct usb251xb *hub, int state)
 {
 	if (!hub->gpio_reset)
 		return;
 
+	i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
+
 	gpiod_set_value_cansleep(hub->gpio_reset, state);
 
 	/* wait for hub recovery/stabilization */
@@ -234,6 +268,8 @@ static void usb251xb_reset(struct usb251xb *hub, int state)
 		usleep_range(500, 750);	/* >=500us at power on */
 	else
 		usleep_range(1, 10);	/* >=1us at power down */
+
+	i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
 }
 
 static int usb251xb_connect(struct usb251xb *hub)
@@ -621,6 +657,25 @@ static int usb251xb_probe(struct usb251xb *hub)
 		}
 	}
 
+	/*
+	 * usb251x SMBus-slave SCL lane is muxed with CFG_SEL0 pin. So if anyone
+	 * tries to work with the bus at the moment the hub reset is released,
+	 * it may cause an invalid config being latched by usb251x. Particularly
+	 * one of the config modes makes the hub loading a default registers
+	 * value without SMBus-slave interface activation. If the hub
+	 * accidentally gets this mode, this will cause the driver SMBus-
+	 * functions failure. Normally we could just lock the SMBus-segment the
+	 * hub i2c-interface resides for the device-specific reset timing. But
+	 * the GPIO controller, which is used to handle the hub reset, might be
+	 * placed at the same i2c-bus segment. In this case an error should be
+	 * returned since we can't safely use the GPIO controller to clear the
+	 * reset state (it may affect the hub configuration) and we can't lock
+	 * the i2c-bus segment (it will cause a deadlock).
+	 */
+	err = usb251x_check_gpio_chip(hub);
+	if (err)
+		return err;
+
 	err = usb251xb_connect(hub);
 	if (err) {
 		dev_err(dev, "Failed to connect hub (%d)\n", err);
-- 
2.21.0

