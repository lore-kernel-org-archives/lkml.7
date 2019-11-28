Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EED42176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="MNLpt3U6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK1Mvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:51:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34146 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1Mvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:51:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so30932042wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BT5HmN6JZ5OG28KXs+NMJ8uueVa88wJcLvt0GsOJPo=;
        b=MNLpt3U6DymTaDgSDDwnGP0g1XxCa3+iJG6q/TlSmD4XaioNJfr1xVeqn9oIm48VKy
         JxR5GQSZ5hZI24mRVBJsWIMsekJ7FTwpGn5YqAvpbXVBt9LjqH1ek08ackDlI5YJcK29
         vPwP61KAf8amFdnYex3W0JewoqojzbGUK9yTeZ3wKqxtNKq+jIo+gtMG5PxD2+OFHflX
         tAASz1t9dj2A9fFMaFgs/mKQ/C2vcOxiw/GtjEKIrEnOYLsFa5gUcN4MjYO+VfRh9DOK
         DXlknjtFCmw8yPDMSOtfrQr+ENLDL+iIseh+ytMUXVK8yJTd2n1MKrEswJC/CFBGZSOZ
         BLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BT5HmN6JZ5OG28KXs+NMJ8uueVa88wJcLvt0GsOJPo=;
        b=aoSvQdx0I/rwudBcGK1/ZPLAR0kg079Jmt1KtUz15ssOVQnEXzEz86XfSMG7tL1ItT
         IRBmUuZKOv2/sruVCJ9+/fsM+bzg4uAtdmppNSdE2/v//WHRQD3B/8Zj+wkIhr4yNFJP
         5NAR5oCySWL2gknIBfPHMTMsIxZ8JSZo9D9x6B4HFEYbxCLnowwTaEKgtrL0ByOnABgQ
         F0OUidyFIhOe7s/xfHkVKIJOIpSUWo98Hd4ADuiaAvCvWgw6p8LVsl0W1A9cpj0NjHn7
         Ko15vXAaaqriunq6k/634/MipcREXaDlX3du3aB3znpy0uSDTvm8s5/m5/cESli5y6yG
         YlqA==
X-Gm-Message-State: APjAAAXhtkpE9yAIN8VhOBGKK6DEPe+kmgn8Or3oxb9H1tzldKSVKmRR
        vnZKpzn3h6Onxkz8hXc7g8OGO8nTQv0EkGJv
X-Google-Smtp-Source: APXvYqykQCQ8xILefkitGfhfR9S/+/+8uK4r81PozR6+ZXktTaZ5xIa8SS6gmBmMMiY0op25D24DYg==
X-Received: by 2002:a5d:4592:: with SMTP id p18mr9776431wrq.40.1574945500451;
        Thu, 28 Nov 2019 04:51:40 -0800 (PST)
Received: from rudolphp.sr1.9esec.dev (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id j11sm22959607wrq.26.2019.11.28.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:51:39 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
Date:   Thu, 28 Nov 2019 13:50:50 +0100
Message-Id: <20191128125100.14291-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128125100.14291-1-patrick.rudolph@9elements.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
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
 -v3:
	- Use BIN_ATTR_RO
---
 Documentation/ABI/stable/sysfs-bus-coreboot |  43 ++++++
 drivers/firmware/google/Kconfig             |   9 ++
 drivers/firmware/google/Makefile            |   1 +
 drivers/firmware/google/cbmem-coreboot.c    | 159 ++++++++++++++++++++
 drivers/firmware/google/coreboot_table.h    |  13 ++
 5 files changed, 225 insertions(+)
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
index 000000000000..c67651a9c287
--- /dev/null
+++ b/drivers/firmware/google/cbmem-coreboot.c
@@ -0,0 +1,159 @@
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
+static ssize_t data_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr,
+			 char *buffer, loff_t offset, size_t count)
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
+static BIN_ATTR_RO(data, 0);
+
+static struct bin_attribute *cb_mem_bin_attrs[] = {
+	&bin_attr_data,
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

