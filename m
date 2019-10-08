Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDABC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB777206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ACkFV+Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfJHLyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:54:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52121 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfJHLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:54:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so2835775wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6cLNIibeTIK82QCll5CTrLqaXyHM8hh5YWTiuB41j4=;
        b=ACkFV+FvXymweclUVq0OdJhTH7NFfqNnK9mz6INicNXoAbPNIXCtUFcsZYq05+UNq6
         UeDEzAmAIi8mLdOwhG2wtj7agZjgjleaQzFhY5bVehIXJbhOTc0AQqseCP3pmz+DAyER
         yBG4+WFKAA6KpWKul8kWYVktTlCwZ4j4hxrmpDyddQYqqa0emqgzF/dzJkl4ne5kWckG
         AI/3u52Ks3I4ssqHLl5LeOXg3FlZzDGr/LDb9gqQcHv0vYQbImJ6IF5G17kLqGm1XvA9
         57WPesHq7b4a4fYuTmPOhJMQpPOKfXLrjYPdlDy46iz1K49w2j/O6hzxswG8KJNOHzV5
         rwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6cLNIibeTIK82QCll5CTrLqaXyHM8hh5YWTiuB41j4=;
        b=Qkaizyse/lL+HBLY0HBiTU9OyYOxfATA9xtLslbA3GJRpllDgIVdWN99sOXlPZIUT4
         DPGRp/TLGch7plcLg1x7dzRMxdZspjfnrVmGIqAmjVJ/UxsBhZthIX1LQQKXylfxgsZr
         ik8Dll3lrzWgrIQtGQ2AeFaNsuvRjpiwFVYpbHxVF33sWA/e4LEM7UrYRpBIXG9X+YM1
         hIWHMGxNzyn1Y9K/P+eZ0jknsvMEM+ZZkJ2CnuPH84UMX7xPuqvAdiKBFuh9eB2/VNl9
         0PwpP40C5uxmSqhebqCWisPQmBcLFX6Cv6+GdpbxnhgGU1vDSZ3pdsUuQJAo1ZDyzfFF
         jooQ==
X-Gm-Message-State: APjAAAXPqZFVQ4M9Vua/tpc1JgNftmu4GuiSBvBHaH8pRWDNNjkh37yn
        ARnOFNhCV0vJKLDsjVzbDV5J7WP+cyplhxFX
X-Google-Smtp-Source: APXvYqzezkq/bhLD4X0Q5urn8uPDzMGPxS2jlRQfQf+3znujeyyVxZjyy6T1MQGxY35UGUKQcl1VQw==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr3245828wmj.158.1570535656798;
        Tue, 08 Oct 2019 04:54:16 -0700 (PDT)
Received: from rudolphp.sr1.9esec.dev (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id l7sm19273741wrv.77.2019.10.08.04.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 04:54:16 -0700 (PDT)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
Date:   Tue,  8 Oct 2019 13:53:26 +0200
Message-Id: <20191008115342.28483-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008115342.28483-1-patrick.rudolph@9elements.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Expose the name of the active CBFS partition under
/sys/firmware/cbfs_active_partition

In case of Google's VBOOT[1] that currently can be one of:
"FW_MAIN_A", "FW_MAIN_B" or "COREBOOT"

Will be used by fwupd[2] to determinde the active partition in the
VBOOT A/B partition update scheme.

[1]: https://doc.coreboot.org/security/vboot/index.html
[2]: https://fwupd.org/

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/Kconfig              |  10 ++
 drivers/firmware/google/Makefile             |   1 +
 drivers/firmware/google/bootmedia-coreboot.c | 115 +++++++++++++++++++
 drivers/firmware/google/coreboot_table.h     |  13 +++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/firmware/google/bootmedia-coreboot.c

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 5fbbd7b8fef6..f58b723d77de 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -82,4 +82,14 @@ config GOOGLE_FMAP
 	  the coreboot table.  If found, this binary file is exported to userland
 	  in the file /sys/firmware/fmap.
 
+config GOOGLE_BOOTMEDIA
+	tristate "Coreboot bootmedia params access"
+	depends on GOOGLE_COREBOOT_TABLE
+	depends on GOOGLE_FMAP
+	help
+	  This option enables the kernel to search for a boot media params
+	  table, providing the active CBFS partition.  If found, the name of
+	  the partition is exported to userland in the file
+	  /sys/firmware/cbfs_active_partition.
+
 endif # GOOGLE_FIRMWARE
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index 6d31fe167700..e47c59376566 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
 obj-$(CONFIG_GOOGLE_FMAP)                  += fmap-coreboot.o
+obj-$(CONFIG_GOOGLE_BOOTMEDIA)             += bootmedia-coreboot.o
 
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
diff --git a/drivers/firmware/google/bootmedia-coreboot.c b/drivers/firmware/google/bootmedia-coreboot.c
new file mode 100644
index 000000000000..09c0caedaf05
--- /dev/null
+++ b/drivers/firmware/google/bootmedia-coreboot.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * bootmedia-coreboot.c
+ *
+ * Exports the active VBOOT partition name through boot media params.
+ *
+ * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
+ * Copyright 2017 Google Inc.
+ * Copyright 2019 Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include "coreboot_table.h"
+#include "fmap-coreboot.h"
+
+#define CB_TAG_BOOT_MEDIA_PARAMS 0x30
+
+/* The current CBFS partition */
+static char *name;
+
+static ssize_t cbfs_active_partition_read(struct file *filp,
+					  struct kobject *kobp,
+					  struct bin_attribute *bin_attr,
+					  char *buf,
+					  loff_t pos, size_t count)
+{
+	if (!name)
+		return -ENODEV;
+
+	return memory_read_from_buffer(buf, count, &pos, name, strlen(name));
+}
+
+static int bmp_probe(struct coreboot_device *dev)
+{
+	struct lb_boot_media_params *b = &dev->bmp;
+	const char *tmp;
+
+	/* Sanity checks on the data we got */
+	if ((b->cbfs_offset == ~0) ||
+	    b->cbfs_size == 0 ||
+	    ((b->cbfs_offset + b->cbfs_size) > b->boot_media_size)) {
+		pr_warn("coreboot: Boot media params contains invalid data\n");
+		return -ENODEV;
+	}
+
+	tmp = coreboot_fmap_region_to_name(b->cbfs_offset, b->cbfs_size);
+	if (!tmp) {
+		pr_warn("coreboot: Active CBFS region not found in FMAP\n");
+		return -ENODEV;
+	}
+
+	name = devm_kmalloc(&dev->dev, strlen(tmp) + 2, GFP_KERNEL);
+	if (!name) {
+		kfree(tmp);
+		return -ENODEV;
+	}
+	snprintf(name, strlen(tmp) + 2, "%s\n", tmp);
+
+	kfree(tmp);
+
+	return 0;
+}
+
+static int bmp_remove(struct coreboot_device *dev)
+{
+	struct platform_device *pdev = dev_get_drvdata(&dev->dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static struct coreboot_driver bmp_driver = {
+	.probe = bmp_probe,
+	.remove = bmp_remove,
+	.drv = {
+		.name = "bootmediaparams",
+	},
+	.tag = CB_TAG_BOOT_MEDIA_PARAMS,
+};
+
+static struct bin_attribute cbfs_partition_bin_attr = {
+	.attr = {.name = "cbfs_active_partition", .mode = 0444},
+	.read = cbfs_active_partition_read,
+};
+
+static int __init coreboot_bmp_init(void)
+{
+	int err;
+
+	err = sysfs_create_bin_file(firmware_kobj, &cbfs_partition_bin_attr);
+	if (err)
+		return err;
+
+	return coreboot_driver_register(&bmp_driver);
+}
+
+static void coreboot_bmp_exit(void)
+{
+	coreboot_driver_unregister(&bmp_driver);
+	sysfs_remove_bin_file(firmware_kobj, &cbfs_partition_bin_attr);
+}
+
+module_init(coreboot_bmp_init);
+module_exit(coreboot_bmp_exit);
+
+MODULE_AUTHOR("9elements Agency GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 7b7b4a6eedda..a03e039425b8 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -59,6 +59,18 @@ struct lb_framebuffer {
 	u8  reserved_mask_size;
 };
 
+/* coreboot table with TAG 0x30 */
+struct lb_boot_media_params {
+	u32 tag;
+	u32 size;
+
+	/* offsets are relative to start of boot media */
+	u64 fmap_offset;
+	u64 cbfs_offset;
+	u64 cbfs_size;
+	u64 boot_media_size;
+};
+
 /* A device, additionally with information from coreboot. */
 struct coreboot_device {
 	struct device dev;
@@ -66,6 +78,7 @@ struct coreboot_device {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
 		struct lb_framebuffer framebuffer;
+		struct lb_boot_media_params bmp;
 	};
 };
 
-- 
2.21.0

