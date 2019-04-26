Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4962920693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYQUEDun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDZKrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:47:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33613 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:47:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so2160491lfm.0;
        Fri, 26 Apr 2019 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9WmBj7lYS3B9JO11dPKodyj6vLzXViJHTZDgC2h0T8=;
        b=mYQUEDun/9QyUHJmOREcbNmw3b5fNI2u65bIzrZMlPq22QmuL24jsLtzZ7k46L+Eh9
         A0Ei+jiYHd3jgBWuURFXtl9rJYGmxRbFkr5ABF+CZ2NKHI+X4H2ZlzoPHQIuj0BgaDNK
         e8jdpaVP5lBNHivdvX5U13BChJzvZHn5v8sxixBM/86fU2nScwKIski5Cg98VBiEUYaT
         FoxqjH3sHixBrpWJSFG8ZsQSVFBoj+bkZ+C8/bi7a56KtWW7kGQ2eDUpX0tvbI47JFxg
         p0imXFOU2wQyWUdgwHJSsxyYMib5GsKoq4bd8U6X9k+NkksE+NHCol2InZH/nVtQo7fS
         yIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9WmBj7lYS3B9JO11dPKodyj6vLzXViJHTZDgC2h0T8=;
        b=Wced/0FIc5zfvR4g2WqdStLo63uhfDRYD8TeDLeULNcxt9ToFclBzcntkA3aaHq4DQ
         EmaZyCClBr11XSM29GXz8Fiu7gyVDias0GSAAgtKdlbSIHiet2oCr3WimP777bbf0oPh
         OPZcEl6Z+GX/vM/BbXlCUFNY//qJBbuWdTQjqB89ocj1EqW803jXwEgtR7qTJWLDodSu
         A+8RLc+QWXCmkGz1ti1KmwuxXL2xkdBeX5U/hkpJ4ORvKjPB4rqmhsvMxpEvAXOBxqH6
         O04piLzBX5QGbOc99yptySWHUcSKQpyieSvU/QIIk+r+aLmh/9OQAJmLMoyBQHJfQS1e
         vCXw==
X-Gm-Message-State: APjAAAXVYhqtk/w2Pyj47knrXHPYHu9T4QJvfx60i3gkDzDCoZtBAxvu
        MEdn6jv9bsyuiqhk+ZXgF9k=
X-Google-Smtp-Source: APXvYqwkbpmvQPjj5HIpaDDvrc5bAqcingJoTDlqH73duzuzxHQKS+3BtgTR5BD+WM94vYTL6KRj6w==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr6435872lfc.153.1556275634600;
        Fri, 26 Apr 2019 03:47:14 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id 10sm1801799ljc.48.2019.04.26.03.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:47:13 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Date:   Fri, 26 Apr 2019 13:46:50 +0300
Message-Id: <20190426104650.30240-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424144914.10580-1-fancer.lancer@gmail.com>
References: 
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
Changelog v2
- Execute the check code only if GPIOLIB is enabled (reported by
  a build robot).
---
 drivers/usb/misc/usb251xb.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 04684849d683..cdc80e8c2d8a 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/nls.h>
@@ -222,11 +223,51 @@ static const struct usb251xb_data usb2517i_data = {
 	.product_str = "USB2517i",
 };
 
+#ifdef CONFIG_GPIOLIB
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
+#else
+static int usb251x_check_gpio_chip(struct usb251xb *hub)
+{
+	return 0;
+}
+#endif
+
 static void usb251xb_reset(struct usb251xb *hub, int state)
 {
 	if (!hub->gpio_reset)
 		return;
 
+	i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
+
 	gpiod_set_value_cansleep(hub->gpio_reset, state);
 
 	/* wait for hub recovery/stabilization */
@@ -234,6 +275,8 @@ static void usb251xb_reset(struct usb251xb *hub, int state)
 		usleep_range(500, 750);	/* >=500us at power on */
 	else
 		usleep_range(1, 10);	/* >=1us at power down */
+
+	i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
 }
 
 static int usb251xb_connect(struct usb251xb *hub)
@@ -621,6 +664,25 @@ static int usb251xb_probe(struct usb251xb *hub)
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

