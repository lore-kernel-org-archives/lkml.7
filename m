Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2DBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133932252F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="D7qWuqMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfKTNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44212 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfKTNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so2019789wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enPQE3qpGxWS4NGeTA9BdryYelW46BMD+Kev//zqz60=;
        b=D7qWuqMIUHY6GAEn0HnoJMxDQM7FY0EvRF4RARczoupXvwrkB1DRbGGX5WDRZ0YU2N
         RgkLHUaZt1csV+uFcGqFRE9Opscgzor7QRoxNrceAkyjCIG6BRldxhOgyB9gMSWT37QT
         Mx/Dmc++UtAsLhGmQFqkVlKP8BB4Np303M1SXwebl12pan1ZTWldLVCGk3qB+dMS/syl
         6EWvSWaOnHABSDeYFz0vXRBPywINeg5X/JiCkSr0zc9qZkOJC4+3vRdGtRaRW1sgFFuI
         XjOGwG7RC18mrs+iltpbKPmcfPduvyDBPsp0cEHl96WgU6lQhi0euGcd7UAV7fkeVGAt
         meZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enPQE3qpGxWS4NGeTA9BdryYelW46BMD+Kev//zqz60=;
        b=mN+h+Ep8hWnYoMjNfViHghdRtc44k6CkJRU0Ro0jemMIPsn0yRxxdVJ0eEEFJbXm6T
         Onm3m5cj28mwkarcPyb6q2RoZ3MDtJwZWENJppPv3P/vZqn8QnxAltIArC/B6iZ0a4gq
         RgO9JRFXcEy0V7Qo+Gifddsu8+/qE3M1n94VAt+yN+8l3c3VfniEklFKRmRU1Ig1nz5i
         kKZO8WWyutLE7WEb1dy/BmNiD+qavzoRhCPfgKvQzyvDB5AcFLn++o7ImwVr8N8lh6IX
         fYABbHOhXH5sD5VkZxbaR6UftxQY7k8rfU3s/HeC1xOyNY1FfFzX86GSrvJ5Qv9zPGsT
         lqDA==
X-Gm-Message-State: APjAAAWa7dcql5EXKbsPAuY4WJ5zHeSNLSGihCSJEXiMccPti/Hl7y7X
        xsIXtEyJ/4KHVZ6ZJr33crLUYKleqgiX2Nve
X-Google-Smtp-Source: APXvYqzuTD+tHSu05wQeeJij+X9iLWay+/kDLOm5ofPqTDljoJpL1wAoWsJ/PsRqyo3ZaziCMO9tZg==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr3199956wro.370.1574257229551;
        Wed, 20 Nov 2019 05:40:29 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t14sm30473434wrw.87.2019.11.20.05.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:40:28 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] firmware: google: Expose CBMEM over sysfs
Date:   Wed, 20 Nov 2019 14:39:46 +0100
Message-Id: <20191120133958.13160-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120133958.13160-1-patrick.rudolph@9elements.com>
References: <20191120133958.13160-1-patrick.rudolph@9elements.com>
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
or
/sys/bus/coreboot/devices/coreboot*/cbmem_attributes/id

The binary table data can then be read from
/sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/data
or
/sys/bus/coreboot/devices/coreboot*/cbmem_attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 -v2:
	- Add ABI documentation
	- Add 0x prefix on hex values
---
 Documentation/ABI/stable/sysfs-bus-coreboot |  43 ++++++
 drivers/firmware/google/Kconfig             |   9 ++
 drivers/firmware/google/Makefile            |   1 +
 drivers/firmware/google/cbmem-coreboot.c    | 162 ++++++++++++++++++++
 drivers/firmware/google/coreboot_table.h    |  13 ++
 5 files changed, 228 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-coreboot
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/ABI/stable/sysfs-bus-coreboot
new file mode 100644
index 000000000000..1b04b8abc858
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-coreboot
@@ -0,0 +1,43 @@
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/id
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/id if the device corresponds to a CBMEM
+		buffer.
+		The file holds an ASCII representation of the CBMEM ID in hex
+		(e.g. 0xdeadbeef).
+
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/size
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/size if the device corresponds to a CBMEM
+		buffer.
+		The file holds an representation as decimal number of the
+		CBMEM buffer size (e.g. 64).
+
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/address
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/address if the device corresponds to a CBMEM
+		buffer.
+		The file holds an ASCII representation of the physical address
+		of the CBMEM buffer in hex (e.g. 0x000000008000d000).
+
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/data
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/data if the device corresponds to a CBMEM
+		buffer.
+		The file holds a read-only binary representation of the CBMEM
+		buffer.
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
index 000000000000..672f25313055
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
+	void *remap;
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
+	return sprintf(buffer, "0x%08x\n", priv->entry.id);
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
+	return sprintf(buffer, "0x%016llx\n", priv->entry.address);
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

