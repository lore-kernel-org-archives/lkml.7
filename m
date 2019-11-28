Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331C020880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574938525;
	bh=lLJJ20+1Kf0z7RwaP9GF+SreDiq2IVYE6EiZ/qH42vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHqAI9KNkqegwiPyOFMZTMC7iimoMmYLjCcQN+nRfBKBnGGcCD1XtsQ8MtrYgTlV7
	 tNJEZhW49w+tkIa0dHRl4d8gQA+I8L8xqLgoEukyhYW+wA7XFIQ95rlBHFcAYbYBzw
	 FfrAA+r0JhyKm9Go4jeSiurAzfY8YDd12bsiOeV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfK1KzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfK1KzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:55:20 -0500
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB9F21787;
        Thu, 28 Nov 2019 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574938519;
        bh=lLJJ20+1Kf0z7RwaP9GF+SreDiq2IVYE6EiZ/qH42vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCG+x0QCcmY4hxoE5yZNhO9eZXUNLTq+yA4kI5gERhl590TU8MowUDCxaBhqzAJMy
         olzsEDlu7aa1K94vqqv6Ar7Bgv3A5MsOhbsa4yv+5m5CMgqKSp4LxAb+Wp14BZkV+Q
         C8MIVxlQxt9s43fQjCL8r65OB0g9gb8vHpROfZis=
From:   kbingham@kernel.org
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Simon Goda <simon.goda@doulos.com>
Cc:     Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH 3/3] drivers: auxdisplay: Add JHD1313 I2C interface driver
Date:   Thu, 28 Nov 2019 10:55:08 +0000
Message-Id: <20191128105508.3916-4-kbingham@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128105508.3916-1-kbingham@kernel.org>
References: <20191128105508.3916-1-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kbingham@kernel.org>

Provide an auxdisplay driver for the JHD1313 as used by the Grove-LCD
RGB Backlight module [0]. A datasheet for the JHD1214 is provided by
seeed [1], which assumes that they are similar parts.

The backlight for the Grove-LCD is already controllable with the PCA963x
driver.

[0] http://wiki.seeedstudio.com/Grove-LCD_RGB_Backlight/
[1] https://seeeddoc.github.io/Grove-LCD_RGB_Backlight/res/JHD1214Y_YG_1.0.pdf

Signed-off-by: Simon Goda <simon.goda@doulos.com>
Signed-off-by: Kieran Bingham <kbingham@kernel.org>
---
 MAINTAINERS                  |   4 ++
 drivers/auxdisplay/Kconfig   |  12 ++++
 drivers/auxdisplay/Makefile  |   1 +
 drivers/auxdisplay/jhd1313.c | 111 +++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 drivers/auxdisplay/jhd1313.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f075b866aaf..640f099ff7fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8837,6 +8837,10 @@ S:	Maintained
 F:	Documentation/admin-guide/jfs.rst
 F:	fs/jfs/
 
+JHD1313 LCD Dispaly driver
+M:	Kieran Bingham <kbingham@kernel.org>
+F:	drivers/auxdisplay/jhd1313.c
+
 JME NETWORK DRIVER
 M:	Guo-Fu Tseng <cooldavid@cooldavid.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index b8313a04422d..cfc61c1abdee 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -27,6 +27,18 @@ config HD44780
 	  kernel and started at boot.
 	  If you don't understand what all this is about, say N.
 
+config JHD1313
+	tristate "JHD1313 Character LCD support"
+	depends on I2C
+	select CHARLCD
+	---help---
+	  Enable support for Character LCDs using a JHD1313 controller on I2C.
+	  The LCD is accessible through the /dev/lcd char device (10, 156).
+	  This code can either be compiled as a module, or linked into the
+	  kernel and started at boot.
+	  This supports the LCD panel on the Grove 16x2 LCD series.
+	  If you don't understand what all this is about, say N.
+
 config KS0108
 	tristate "KS0108 LCD Controller"
 	depends on PARPORT_PC
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index cf54b5efb07e..6e1405a61925 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
 obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
 obj-$(CONFIG_HD44780)		+= hd44780.o
+obj-$(CONFIG_JHD1313)		+= jhd1313.o
 obj-$(CONFIG_HT16K33)		+= ht16k33.o
 obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
diff --git a/drivers/auxdisplay/jhd1313.c b/drivers/auxdisplay/jhd1313.c
new file mode 100644
index 000000000000..abf270e128ac
--- /dev/null
+++ b/drivers/auxdisplay/jhd1313.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * JHD1313 I2C Character LCD driver for Linux.
+ *
+ * Kieran Bingham <kbingham@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+#include <linux/i2c.h>
+
+#include "charlcd.h"
+
+struct jhd1313 {
+	struct i2c_client *client;
+};
+
+static void jhd1313_write_cmd(struct charlcd *lcd, int cmd)
+{
+	struct jhd1313 *jhd = lcd->drvdata;
+	struct i2c_client *client = jhd->client;
+
+	i2c_smbus_write_byte_data(client, 0x00, cmd);
+}
+
+static void jhd1313_write_data(struct charlcd *lcd, int data)
+{
+	struct jhd1313 *jhd = lcd->drvdata;
+	struct i2c_client *client = jhd->client;
+
+	i2c_smbus_write_byte_data(client, 0x40, data);
+}
+
+static const struct charlcd_ops jhd1313_ops = {
+	.write_cmd	= jhd1313_write_cmd,
+	.write_data	= jhd1313_write_data,
+};
+
+static int jhd1313_probe(struct i2c_client *client)
+{
+	struct charlcd *lcd;
+	struct jhd1313 *jhd;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+		dev_err(&client->dev, "i2c_check_functionality error\n");
+		return -EIO;
+	}
+
+	lcd = charlcd_alloc(sizeof(struct jhd1313));
+	if (!lcd)
+		return -ENOMEM;
+
+	jhd = lcd->drvdata;
+	i2c_set_clientdata(client, lcd);
+	jhd->client = client;
+
+	lcd->width = 16;
+	lcd->height = 2;
+	lcd->ifwidth = 8;
+	lcd->ops = &jhd1313_ops;
+
+	ret = charlcd_register(lcd);
+	if (ret) {
+		charlcd_free(lcd);
+		dev_err(&client->dev, "Failed to register JHD1313");
+	}
+
+	return ret;
+}
+
+static int jhd1313_remove(struct i2c_client *client)
+{
+	struct charlcd *lcd = i2c_get_clientdata(client);
+
+	charlcd_unregister(lcd);
+	charlcd_free(lcd);
+
+	return 0;
+}
+
+static const struct i2c_device_id jhd1313_id[] = {
+	{ "jhd1313", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, jhd1313_id);
+
+static const struct of_device_id jhd1313_of_table[] = {
+	{ .compatible = "jhd,jhd1313" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhd1313_of_table);
+
+static struct i2c_driver jhd1313_driver = {
+	.driver = {
+		.name = "jhd1313",
+		.of_match_table = jhd1313_of_table,
+	},
+	.probe_new = jhd1313_probe,
+	.remove = jhd1313_remove,
+	.id_table = jhd1313_id,
+};
+
+module_i2c_driver(jhd1313_driver);
+
+MODULE_DESCRIPTION("JHD1313 I2C Character LCD driver");
+MODULE_AUTHOR("Kieran Bingham <kbingham@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

