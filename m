Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0712087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui1YNlS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfDPP4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:56:37 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55832 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfDPP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:56:34 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so33802428itc.5;
        Tue, 16 Apr 2019 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LZIvTcd96WbWgUj6Nl0WRY3WUo/14uX37QidroQ5rk8=;
        b=Ui1YNlS4FCX4CMA6CgIR86nCBMtAh8nZer8Zyal47bDJ5xHJp78kBobrtRYNiNADk1
         o4mjlnDzGQdE6Z0D9rPrCmZN2Y46wyS+2pMsTj1mLrxyZKhVZy8J2j6g42oBb9YJNQKU
         WfLqLnsAncGGCoiFgGN+c4i5QX7RdLks4JciBT0OY4ok5tuBThI/EIECXoXMR0kKBQca
         gfDCy6xdtnA9Ht+R4Gh3XKus/t5dYT/kUSXi8nlprV8scFu4lEiT43tjsnKQQk6sBeAn
         lZN99KxSLqQ9J6BIGwwYcxJ2XKbHT62sY9xIBMBV9jMXYv2SUvAyMbUOG9+raNykdtoX
         ojCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LZIvTcd96WbWgUj6Nl0WRY3WUo/14uX37QidroQ5rk8=;
        b=N/0C8DeXLfju2mqGLZiumeb42gpuPFZxGjuxlLMWrFpZB32gsfV2FE3R0Qr5EE30oO
         KATJqlcOZHAtFL+iZO4ZZL/+u4M3WtZ3Ffb133Ctmq7rN276s6T+rVUEN8utytunXpSH
         VjuOH7CchqRIyHLmWBRufjYt9y3cX7Cd7teMHEv+MKVz99HheG0/EHiebrgzYfvJC+M0
         omSKPJIA53fZk0xwO9UZYbpkHPT+SlVtQxY3e4L4jmN1zgqmEg8Xez3Mc+9kPWFJ4DyW
         HaL71Jp9Hg2rn4YX4dZQJcl/8PmykChewTOXasajeJmhErNE943aDN0NqADxZf6xbcq3
         RSbQ==
X-Gm-Message-State: APjAAAUMQYxEfmyiLACgO9MkTPKvIyoo/c2qABq4e/JsGvMON7xxIz+i
        +H40m9zYAfvqJGCjtAuZBfw=
X-Google-Smtp-Source: APXvYqytLruEYzG85v59xVKihuZocoO2g3PC0x1YvGE38G4FIZLnh4KIgTvEy0j21W3cSf9OyteCkw==
X-Received: by 2002:a24:5306:: with SMTP id n6mr14574142itb.101.1555430193130;
        Tue, 16 Apr 2019 08:56:33 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 64sm9766630ite.42.2019.04.16.08.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:56:32 -0700 (PDT)
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
        netdev@vger.kernel.org
Subject: [PATCH v11 6/7] fieldbus_dev: support HMS Profinet IRT industrial controller
Date:   Tue, 16 Apr 2019 11:56:17 -0400
Message-Id: <20190416155618.1369-7-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416155618.1369-1-TheSven73@gmail.com>
References: <20190416155618.1369-1-TheSven73@gmail.com>
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
 .../staging/fieldbus/anybuss/hms-profinet.c   | 228 ++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/staging/fieldbus/anybuss/hms-profinet.c

diff --git a/drivers/staging/fieldbus/anybuss/Kconfig b/drivers/staging/fieldbus/anybuss/Kconfig
index e257f8a517bb..41f241c73826 100644
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
index 000000000000..c5db648aa65f
--- /dev/null
+++ b/drivers/staging/fieldbus/anybuss/hms-profinet.c
@@ -0,0 +1,228 @@
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
+
+/* move to <linux/fieldbus_dev.h> when taking this out of staging */
+#include "../fieldbus_dev.h"
+
+/* move to <linux/anybuss-client.h> when taking this out of staging */
+#include "anybuss-client.h"
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

