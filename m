Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E710C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30E320672
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="IBWoO0v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKOQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:16:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52067 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:16:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so10208524wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZqceDQikfwcq3Nvw02gjsRn2xdIpUGJa9rnE0W3RlE=;
        b=IBWoO0v5WmiB8zY+qGN5c1TsROPzgecz6n+Wdl4VgNYDFvPF2ywLPMLOsQWRW3TdsF
         B1WK+wGVVKaZJbLNaCpz0pd2HzwMazDnkxBDdZuUliXX7/NFttg6n+DEk57IfJRgrMho
         yeL9bOI7kncBOwfpJe0IeuzvWARxG461W+Pg5WjweSIFfC08j3dv817ejW7UwuYOdq9E
         3tVU8Y1KIB/ssGtEGzmdz69IOXfI9slGF/7ZR7NGDNBxxF6QdVv6V5VhV2YUiwixDbx6
         fl1SiVmQUhQ/X2n4/zkXQBpNeGt+dL8pAkow/cLzr7NIFkL4CPYUfMW8nTo95LXuZbej
         us7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZqceDQikfwcq3Nvw02gjsRn2xdIpUGJa9rnE0W3RlE=;
        b=GsmVOYMxFEtiaz7ptovf31eUFFm4/mDG2lGuiuIlSgZ0SRNRRzQ79AFaYAZawYsRXa
         uS1loeM7wenQH4A6pnp1C0XV1czxit0NJSwEQMDN5YfX4GdonsVMGXy+V/4xycz3rwCb
         STq93JUFbkwfTkiwbZguiUsLy40jSieMcXz11xkZpR/GxWadOi0ecDDPLIJCOOkcldbr
         YuWl0fcM7fwSHdklWboecXUsuHeSBoxHEiFPfhDaMnXTBLANt040nyC8+K+pfK5firtz
         YtL0Pg2to1HJ3jA+wb9YXiVeWVF4p6RhjVTAG/D6U3sUEzmVu0d9mqhuyHqbI2KhX3OV
         OFFg==
X-Gm-Message-State: APjAAAWvhI/+ExsdBzQqRjbzshpYSUb4ygxnQauTL63crcepYFYoWNvP
        fwaScHD4dO9AcjiugLfUEkYVvwgwmKzmRrhE
X-Google-Smtp-Source: APXvYqz1z34oCiIRopUO5UDvh/TK+R+OIvJUwMgiN+cz9O/d2FA2bMZVcq2dnzF8DoJBDnwk52rEnQ==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr16174494wme.104.1573834569414;
        Fri, 15 Nov 2019 08:16:09 -0800 (PST)
Received: from rudolphp.sr1.9esec.dev (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id o5sm11637467wrx.15.2019.11.15.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:16:08 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] firmware: google: Expose CBMEM over sysfs
Date:   Fri, 15 Nov 2019 17:15:15 +0100
Message-Id: <20191115161524.23738-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115161524.23738-1-patrick.rudolph@9elements.com>
References: <20191115161524.23738-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Make all CBMEM buffers available to userland. This is useful for tools
that are currently using /dev/mem.

Make the id, size and address available, as well as the raw table data.

Tools can easily scan the right CBMEM buffer by reading
/sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/id
The binary table data can then be read from
/sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/Kconfig          |   9 ++
 drivers/firmware/google/Makefile         |   1 +
 drivers/firmware/google/cbmem-coreboot.c | 162 +++++++++++++++++++++++
 drivers/firmware/google/coreboot_table.h |  13 ++
 4 files changed, 185 insertions(+)
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a3a6ca659ffa..11a67c397ab3 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -58,6 +58,15 @@ config GOOGLE_FRAMEBUFFER_COREBOOT
 	  This option enables the kernel to search for a framebuffer in
 	  the coreboot table.  If found, it is registered with simplefb.
 
+config GOOGLE_CBMEM_COREBOOT
+	tristate "Coreboot CBMEM access"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  This option exposes all available CBMEM buffers to userland.
+	  The CBMEM id, size and address as well as the raw table data
+	  are exported as sysfs attributes of the corresponding coreboot
+	  table.
+
 config GOOGLE_MEMCONSOLE_COREBOOT
 	tristate "Firmware Memory Console"
 	depends on GOOGLE_COREBOOT_TABLE
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d17caded5d88..62053cd6d058 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_GOOGLE_SMI)		+= gsmi.o
 obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        += coreboot_table.o
+obj-$(CONFIG_GOOGLE_CBMEM_COREBOOT)        += cbmem-coreboot.o
 obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
diff --git a/drivers/firmware/google/cbmem-coreboot.c b/drivers/firmware/google/cbmem-coreboot.c
new file mode 100644
index 000000000000..94b93d8351fe
--- /dev/null
+++ b/drivers/firmware/google/cbmem-coreboot.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * fmap-coreboot.c
+ *
+ * Exports CBMEM as attributes in sysfs.
+ *
+ * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
+ * Copyright 2017 Google Inc.
+ * Copyright 2019 9elements Agency GmbH
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "coreboot_table.h"
+
+#define CB_TAG_CBMEM_ENTRY 0x31
+
+struct cb_priv {
+	void __iomem *remap;
+	struct lb_cbmem_entry entry;
+};
+
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buffer)
+{
+	const struct cb_priv *priv;
+
+	priv = (const struct cb_priv *)dev_get_platdata(dev);
+
+	return sprintf(buffer, "%08x\n", priv->entry.id);
+}
+
+static ssize_t size_show(struct device *dev,
+			 struct device_attribute *attr, char *buffer)
+{
+	const struct cb_priv *priv;
+
+	priv = (const struct cb_priv *)dev_get_platdata(dev);
+
+	return sprintf(buffer, "%u\n", priv->entry.size);
+}
+
+static ssize_t address_show(struct device *dev,
+			    struct device_attribute *attr, char *buffer)
+{
+	const struct cb_priv *priv;
+
+	priv = (const struct cb_priv *)dev_get_platdata(dev);
+
+	return sprintf(buffer, "%016llx\n", priv->entry.address);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(size);
+static DEVICE_ATTR_RO(address);
+
+static struct attribute *cb_mem_attrs[] = {
+	&dev_attr_address.attr,
+	&dev_attr_id.attr,
+	&dev_attr_size.attr,
+	NULL
+};
+
+static ssize_t cbmem_data_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buffer, loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	const struct cb_priv *priv;
+
+	priv = (const struct cb_priv *)dev_get_platdata(dev);
+
+	return memory_read_from_buffer(buffer, count, &offset,
+				       priv->remap, priv->entry.size);
+}
+
+static struct bin_attribute coreboot_attr_data = {
+	.attr = { .name = "data", .mode = 0444 },
+	.read = cbmem_data_read,
+};
+
+static struct bin_attribute *cb_mem_bin_attrs[] = {
+	&coreboot_attr_data,
+	NULL
+};
+
+static struct attribute_group cb_mem_attr_group = {
+	.name = "cbmem_attributes",
+	.attrs = cb_mem_attrs,
+	.bin_attrs = cb_mem_bin_attrs,
+};
+
+static int cbmem_probe(struct coreboot_device *cdev)
+{
+	struct device *dev = &cdev->dev;
+	struct cb_priv *priv;
+	int err;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
+
+	priv->remap = memremap(priv->entry.address,
+			       priv->entry.entry_size, MEMREMAP_WB);
+	if (!priv->remap) {
+		err = -ENOMEM;
+		goto failure;
+	}
+
+	err = sysfs_create_group(&dev->kobj, &cb_mem_attr_group);
+	if (err) {
+		dev_err(dev, "failed to create sysfs attributes: %d\n", err);
+		memunmap(priv->remap);
+		goto failure;
+	}
+
+	dev->platform_data = priv;
+
+	return 0;
+failure:
+	kfree(priv);
+	return err;
+}
+
+static int cbmem_remove(struct coreboot_device *cdev)
+{
+	struct device *dev = &cdev->dev;
+	const struct cb_priv *priv;
+
+	priv = (const struct cb_priv *)dev_get_platdata(dev);
+
+	sysfs_remove_group(&dev->kobj, &cb_mem_attr_group);
+
+	if (priv)
+		memunmap(priv->remap);
+	kfree(priv);
+
+	dev->platform_data = NULL;
+
+	return 0;
+}
+
+static struct coreboot_driver cbmem_driver = {
+	.probe = cbmem_probe,
+	.remove = cbmem_remove,
+	.drv = {
+		.name = "cbmem",
+	},
+	.tag = CB_TAG_CBMEM_ENTRY,
+};
+
+module_coreboot_driver(cbmem_driver);
+
+MODULE_AUTHOR("9elements Agency GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 7b7b4a6eedda..506048c724d8 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -59,6 +59,18 @@ struct lb_framebuffer {
 	u8  reserved_mask_size;
 };
 
+/* There can be more than one of these records as there is one per cbmem entry.
+ * Describes a buffer in memory containing runtime data.
+ */
+struct lb_cbmem_entry {
+	u32 tag;
+	u32 size;
+
+	u64 address;
+	u32 entry_size;
+	u32 id;
+};
+
 /* A device, additionally with information from coreboot. */
 struct coreboot_device {
 	struct device dev;
@@ -66,6 +78,7 @@ struct coreboot_device {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
 		struct lb_framebuffer framebuffer;
+		struct lb_cbmem_entry cbmem_entry;
 	};
 };
 
-- 
2.21.0

