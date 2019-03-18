Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E84220863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY05XLx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCRSEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:04:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37833 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfCRSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:03:59 -0400
Received: by mail-it1-f196.google.com with SMTP id z124so22778460itc.2;
        Mon, 18 Mar 2019 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CszCGb0HzVAWjg134MC+inHKyvuOtW7LfPtZusGAJ5o=;
        b=KY05XLx4voKR8xkUqWw4gDI1qAaNmfeHcV98Yf8czbtFk29i7gGpLmfcnuWSXnRZVH
         EfsM1UxiKMXzDZfw+mc7I4PiLU8+kgUwnUn/K+WnQNvMHiimBhWqr/BTUmIQZoH+gkZX
         3M5M+ppy2kZWSA8SiT9wqCjs9i+hKSGmjMF9OgWe9AJRZtWqTQX1oR4p+iWpz0cn6x82
         /iKjjarzq7rROynJErptX3x4SBKdyTijJXXfrt14vpz7U8HjqRSNEc1szDYr1R+G7+CT
         7k1YSu5S0Ik0ZmMhfFYfUYXEPs7wjnUK4jKhxa3HVQgaH966giia/AQa9DJQ7yvsfasF
         POrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CszCGb0HzVAWjg134MC+inHKyvuOtW7LfPtZusGAJ5o=;
        b=sY0ia+Fceb5OxGA0bdk0OIDxAjbeaVjHNa5waEH/Qq82xr6HSibKKPG4BnLVzZQ2T9
         9K4tcjs9JEWgXjbKYgoQk+98s2L8N6+MgRIBAdDv0kka4ZEII2nGcb0RKlSLL/Pia6Lf
         mu036s8Kq9aturfQZkKBVL7TedkvfmG2V8vTNtx9+i7HYpveUlUSaKVqiRfgnLRaomSu
         T/9Nb2ihzrtyrptOPrtVm1azvBstk941Oduw7dgG2XyTuUdl21SFYuvgXFOjJFnkMRYt
         NoW0uVHgjKumRmEIWH04QxPhp8bnU290sAZ4m8IIYH/pOuE4Q8+XioLRpBPf9luwTfjO
         G45A==
X-Gm-Message-State: APjAAAVIJhEWrt3MMB/DsmwlTEdiZDLMejxB8ZcIRRF/SxNdqKAnBlzw
        w8C6OQzQ2Sc8nElLqoQbHbs=
X-Google-Smtp-Source: APXvYqxuWI2XDNsFDPcIgYh/QExsmYioz3jMnsj9UQ8rmc+ugbDyQr1uJen3gav04u5O8wWnJG3DsA==
X-Received: by 2002:a05:660c:94a:: with SMTP id h10mr114366itl.54.1552932237618;
        Mon, 18 Mar 2019 11:03:57 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 76sm9956itk.40.2019.03.18.11.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:03:56 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        linux-netdev@vger.kernel.org
Subject: [PATCH v9 6/6] fieldbus_dev: support HMS Profinet IRT industrial controller
Date:   Mon, 18 Mar 2019 14:03:38 -0400
Message-Id: <20190318180338.23964-7-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318180338.23964-1-TheSven73@gmail.com>
References: <20190318180338.23964-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Anybus-S PROFINET IRT communication module provides instant integration
to any Ethernet based LAN via SMTP, FTP, HTTP as well as PROFINET and
Modbus-TCP. Additional protocols can be implemented on top of TCP/IP
or UDP using the transparent socket interface.

Official documentation:
https://www.anybus.com/docs/librariesprovider7/default-document-library
/manuals-design-guides/hms-hmsi-168-52.pdf

This implementation is an Anybus-S client driver, designed to be
instantiated by the Anybus-S bus driver when it discovers the Profinet
card.

If loaded successfully, the driver registers itself as a fieldbus_dev,
and userspace can access it through the fieldbus_dev interface.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/anybuss/Kconfig      |  16 ++
 drivers/staging/fieldbus/anybuss/Makefile     |   1 +
 .../staging/fieldbus/anybuss/hms-profinet.c   | 224 ++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/staging/fieldbus/anybuss/hms-profinet.c

diff --git a/drivers/staging/fieldbus/anybuss/Kconfig b/drivers/staging/fieldbus/anybuss/Kconfig
index 7e563a78be13..2ae2daf71d70 100644
--- a/drivers/staging/fieldbus/anybuss/Kconfig
+++ b/drivers/staging/fieldbus/anybuss/Kconfig
@@ -20,4 +20,20 @@ config ARCX_ANYBUS_CONTROLLER
 	  There is also a CAN power readout, unrelated to the Anybus,
 	  modelled as a regulator.
 
+config HMS_PROFINET
+	tristate "HMS Profinet IRT Controller (Anybus-S)"
+	depends on FIELDBUS_DEV && HMS_ANYBUSS_BUS
+	help
+	  If you say yes here you get support for the HMS Industrial
+	  Networks Profinet IRT Controller.
+
+	  It will be registered with the kernel as a fieldbus_dev,
+	  so userspace can interact with it via the fieldbus_dev userspace
+	  interface(s).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called hms-profinet.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/staging/fieldbus/anybuss/Makefile b/drivers/staging/fieldbus/anybuss/Makefile
index 7198b080926b..3ad3dcc6be56 100644
--- a/drivers/staging/fieldbus/anybuss/Makefile
+++ b/drivers/staging/fieldbus/anybuss/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_HMS_ANYBUSS_BUS)	+= anybuss_core.o
 anybuss_core-y			+= host.o
 
 obj-$(CONFIG_ARCX_ANYBUS_CONTROLLER) += arcx-anybus.o
+obj-$(CONFIG_HMS_PROFINET)	+= hms-profinet.o
diff --git a/drivers/staging/fieldbus/anybuss/hms-profinet.c b/drivers/staging/fieldbus/anybuss/hms-profinet.c
new file mode 100644
index 000000000000..89eae3251a69
--- /dev/null
+++ b/drivers/staging/fieldbus/anybuss/hms-profinet.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMS Profinet Client Driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/fieldbus_dev.h>
+#include <linux/anybuss-client.h>
+
+#define PROFI_DPRAM_SIZE	512
+
+/*
+ * ---------------------------------------------------------------
+ * Anybus Profinet mailbox messages - definitions
+ * ---------------------------------------------------------------
+ * note that we're depending on the layout of these structures being
+ * exactly as advertised.
+ */
+
+struct msg_mac_addr {
+	u8 addr[6];
+};
+
+struct profi_priv {
+	struct fieldbus_dev fbdev;
+	struct anybuss_client *client;
+	struct mutex enable_lock; /* serializes card enable */
+	bool power_on;
+};
+
+static ssize_t
+profi_read_area(struct fieldbus_dev *fbdev, char __user *buf, size_t size,
+		loff_t *offset)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+
+	return anybuss_read_output(priv->client, buf, size, offset);
+}
+
+static ssize_t
+profi_write_area(struct fieldbus_dev *fbdev, const char __user *buf,
+		 size_t size, loff_t *offset)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+
+	return anybuss_write_input(priv->client, buf, size, offset);
+}
+
+static int profi_id_get(struct fieldbus_dev *fbdev, char *buf,
+			size_t max_size)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+	struct msg_mac_addr response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0010, &response,
+			       sizeof(response));
+	if (ret < 0)
+		return ret;
+	return snprintf(buf, max_size, "%02X:%02X:%02X:%02X:%02X:%02X\n",
+		response.addr[0], response.addr[1],
+		response.addr[2], response.addr[3],
+		response.addr[4], response.addr[5]);
+}
+
+static bool profi_enable_get(struct fieldbus_dev *fbdev)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+	bool power_on;
+
+	mutex_lock(&priv->enable_lock);
+	power_on = priv->power_on;
+	mutex_unlock(&priv->enable_lock);
+
+	return power_on;
+}
+
+static int __profi_enable(struct profi_priv *priv)
+{
+	int ret;
+	struct anybuss_client *client = priv->client;
+	/* Initialization Sequence, Generic Anybus Mode */
+	const struct anybuss_memcfg mem_cfg = {
+		.input_io = 220,
+		.input_dpram = PROFI_DPRAM_SIZE,
+		.input_total = PROFI_DPRAM_SIZE,
+		.output_io = 220,
+		.output_dpram = PROFI_DPRAM_SIZE,
+		.output_total = PROFI_DPRAM_SIZE,
+		.offl_mode = AB_OFFL_MODE_CLEAR,
+	};
+
+	/*
+	 * switch anybus off then on, this ensures we can do a complete
+	 * configuration cycle in case anybus was already on.
+	 */
+	anybuss_set_power(client, false);
+	ret = anybuss_set_power(client, true);
+	if (ret)
+		goto err;
+	ret = anybuss_start_init(client, &mem_cfg);
+	if (ret)
+		goto err;
+	ret = anybuss_finish_init(client);
+	if (ret)
+		goto err;
+	priv->power_on = true;
+	return 0;
+
+err:
+	anybuss_set_power(client, false);
+	priv->power_on = false;
+	return ret;
+}
+
+static int __profi_disable(struct profi_priv *priv)
+{
+	struct anybuss_client *client = priv->client;
+
+	anybuss_set_power(client, false);
+	priv->power_on = false;
+	return 0;
+}
+
+static int profi_simple_enable(struct fieldbus_dev *fbdev, bool enable)
+{
+	int ret;
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+
+	mutex_lock(&priv->enable_lock);
+	if (enable)
+		ret = __profi_enable(priv);
+	else
+		ret = __profi_disable(priv);
+	mutex_unlock(&priv->enable_lock);
+
+	return ret;
+}
+
+static void profi_on_area_updated(struct anybuss_client *client)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	fieldbus_dev_area_updated(&priv->fbdev);
+}
+
+static void profi_on_online_changed(struct anybuss_client *client, bool online)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	fieldbus_dev_online_changed(&priv->fbdev, online);
+}
+
+static int profinet_probe(struct anybuss_client *client)
+{
+	struct profi_priv *priv;
+	struct device *dev = &client->dev;
+	int err;
+
+	client->on_area_updated = profi_on_area_updated;
+	client->on_online_changed = profi_on_online_changed;
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	mutex_init(&priv->enable_lock);
+	priv->client = client;
+	priv->fbdev.read_area_sz = PROFI_DPRAM_SIZE;
+	priv->fbdev.write_area_sz = PROFI_DPRAM_SIZE;
+	priv->fbdev.card_name = "HMS Profinet IRT (Anybus-S)";
+	priv->fbdev.fieldbus_type = FIELDBUS_DEV_TYPE_PROFINET;
+	priv->fbdev.read_area = profi_read_area;
+	priv->fbdev.write_area = profi_write_area;
+	priv->fbdev.fieldbus_id_get = profi_id_get;
+	priv->fbdev.enable_get = profi_enable_get;
+	priv->fbdev.simple_enable_set = profi_simple_enable;
+	priv->fbdev.parent = dev;
+	err = fieldbus_dev_register(&priv->fbdev);
+	if (err < 0)
+		return err;
+	dev_info(dev, "card detected, registered as %s",
+		 dev_name(priv->fbdev.dev));
+	anybuss_set_drvdata(client, priv);
+
+	return 0;
+}
+
+static int profinet_remove(struct anybuss_client *client)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	fieldbus_dev_unregister(&priv->fbdev);
+	return 0;
+}
+
+static struct anybuss_client_driver profinet_driver = {
+	.probe = profinet_probe,
+	.remove = profinet_remove,
+	.driver		= {
+		.name   = "hms-profinet",
+		.owner	= THIS_MODULE,
+	},
+	.fieldbus_type = 0x0089,
+};
+
+static int __init profinet_init(void)
+{
+	return anybuss_client_driver_register(&profinet_driver);
+}
+module_init(profinet_init);
+
+static void __exit profinet_exit(void)
+{
+	return anybuss_client_driver_unregister(&profinet_driver);
+}
+module_exit(profinet_exit);
+
+MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@gmail.com>");
+MODULE_DESCRIPTION("HMS Profinet IRT Driver (Anybus-S)");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

