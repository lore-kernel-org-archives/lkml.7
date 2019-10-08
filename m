Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E688CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4F0206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Iwr0Q79U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfJHLyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:54:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54791 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfJHLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:54:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so2821233wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 04:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHpb4y5Jge7bT4i0hXsaWPVC1oPVGh0Dw3VnnTFspt4=;
        b=Iwr0Q79UZEa0k7li7kubbpoQonu85WoRHNCpp+4gDBErUJbJ7JnAqKkPbTlF2igkLK
         640BsQhj2FI7iq6G90sLcjZCe2e4wDRNx8gK8Do6rvtyB1IN4okKFltajkPUxql4C1zQ
         ySoN2J1WbQDeDmSiuCyaIXJbC8RXjg1oKGbds29+iXaDsGb/QOu3wiJMQCtvk7myRnE7
         0/y9ykdl5yLrEEbpUn3S14X1Ej/SgHnPGeLW6m7ChHMUekv9Ofl6k2QWfl1c73RKMZx/
         RPHLBviiCgGHZhWxK9kJqdVz1iThwIaeWEz81HYMn6Wjz74XiQhQ7ySMUQZOtNUMfhBb
         Dhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHpb4y5Jge7bT4i0hXsaWPVC1oPVGh0Dw3VnnTFspt4=;
        b=C21uaoC7Ur/Uw9bn7PzTMIElIL70y6VbJJ4nxAh8x7Y+R0gShn2OcATIfN8A3JAWB2
         oc/dm9GcTQf0LMgGEjQBExMILpLH1IG4ogkDn8ZN6xUGbBrSbydH2wdC9dRJRL9NG+T+
         xBnrjrkuGmr+a1pnuhj8GPenyG6JHMLsRUhU/POxxlKDShTiNj4bVZaVkleDTOKj7uI/
         l0AXcSRdpY8gxm/Oj/ztQyLBsXiTn7fpRXP7f2rjuh1hA+pr+eAQC+pmGuwy6JcOx3Nv
         KzgpG+d9awddm+N0XMa5eVnJ79KtQLs0y5PmPmb1VLNSu6dcyvmsw1cI1UUP73PIEjNk
         qnbw==
X-Gm-Message-State: APjAAAWdLEqR5AMJqT3tb0VamB+hjcDZ14mTtW5ChoAwPQ4yOx5w+Jve
        0icDzWOGhBxJ+jHCwNOJGJvfQC1sn4x8FnY1
X-Google-Smtp-Source: APXvYqxKn1ukqj5qIz5mpa3b8wPigQccMPCapzUmn1WmYmcjpoM/j+5h+fjkwSXyJMofAC1crl6HGA==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr3732130wmj.6.1570535639544;
        Tue, 08 Oct 2019 04:53:59 -0700 (PDT)
Received: from rudolphp.sr1.9esec.dev (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id l7sm19273741wrv.77.2019.10.08.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 04:53:58 -0700 (PDT)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 1/2] firmware: coreboot: Export the binary FMAP
Date:   Tue,  8 Oct 2019 13:53:25 +0200
Message-Id: <20191008115342.28483-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Expose coreboot's binary FMAP[1] to /sys/firmware/fmap.

coreboot copies the FMAP to a CBMEM buffer at boot since CB:35377[2],
allowing an architecture independ way of exposing the FMAP to userspace.

Will be used by fwupd[3] to determine the current firmware layout.

[1]: https://doc.coreboot.org/lib/flashmap.html
[2]: https://review.coreboot.org/c/coreboot/+/35377
[3]: https://fwupd.org/

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/Kconfig           |   8 ++
 drivers/firmware/google/Makefile          |   1 +
 drivers/firmware/google/fmap-coreboot.c   | 156 ++++++++++++++++++++++
 drivers/firmware/google/fmap-coreboot.h   |  13 ++
 drivers/firmware/google/fmap_serialized.h |  59 ++++++++
 5 files changed, 237 insertions(+)
 create mode 100644 drivers/firmware/google/fmap-coreboot.c
 create mode 100644 drivers/firmware/google/fmap-coreboot.h
 create mode 100644 drivers/firmware/google/fmap_serialized.h

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a3a6ca659ffa..5fbbd7b8fef6 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -74,4 +74,12 @@ config GOOGLE_VPD
 	  This option enables the kernel to expose the content of Google VPD
 	  under /sys/firmware/vpd.
 
+config GOOGLE_FMAP
+	tristate "Coreboot FMAP access"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  This option enables the kernel to search for a Google FMAP in
+	  the coreboot table.  If found, this binary file is exported to userland
+	  in the file /sys/firmware/fmap.
+
 endif # GOOGLE_FIRMWARE
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d17caded5d88..6d31fe167700 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
+obj-$(CONFIG_GOOGLE_FMAP)                  += fmap-coreboot.o
 
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
diff --git a/drivers/firmware/google/fmap-coreboot.c b/drivers/firmware/google/fmap-coreboot.c
new file mode 100644
index 000000000000..14050030ebc6
--- /dev/null
+++ b/drivers/firmware/google/fmap-coreboot.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * fmap-coreboot.c
+ *
+ * Exports the binary FMAP through coreboot table.
+ *
+ * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
+ * Copyright 2017 Google Inc.
+ * Copyright 2019 9elements Agency GmbH <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/io.h>
+
+#include "coreboot_table.h"
+#include "fmap_serialized.h"
+
+#define CB_TAG_FMAP 0x37
+
+static void *fmap;
+static u32 fmap_size;
+
+/*
+ * Convert FMAP region to name.
+ * The caller has to free the string.
+ * Return NULL if no containing region was found.
+ */
+const char *coreboot_fmap_region_to_name(const u32 start, const u32 size)
+{
+	const char *name = NULL;
+	struct fmap *iter;
+	u32 size_old = ~0;
+	int i;
+
+	iter = fmap;
+	/* Find smallest containing region */
+	for (i = 0; i < iter->nareas && fmap; i++) {
+		if (iter->areas[i].offset <= start &&
+		    iter->areas[i].size >= size &&
+		    iter->areas[i].size <= size_old) {
+			size_old = iter->areas[i].size;
+			name = iter->areas[i].name;
+		}
+	}
+
+	if (name)
+		return kstrdup(name, GFP_KERNEL);
+	return NULL;
+}
+EXPORT_SYMBOL(coreboot_fmap_region_to_name);
+
+static ssize_t fmap_read(struct file *filp, struct kobject *kobp,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t pos, size_t count)
+{
+	if (!fmap)
+		return -ENODEV;
+
+	return memory_read_from_buffer(buf, count, &pos, fmap, fmap_size);
+}
+
+static int fmap_probe(struct coreboot_device *dev)
+{
+	struct lb_cbmem_ref *cbmem_ref = &dev->cbmem_ref;
+	struct fmap *header;
+
+	if (!cbmem_ref)
+		return -ENODEV;
+
+	header = memremap(cbmem_ref->cbmem_addr, sizeof(*header), MEMREMAP_WB);
+	if (!header) {
+		pr_warn("coreboot: Failed to remap FMAP\n");
+		return -ENOMEM;
+	}
+
+	/* Validate FMAP signature */
+	if (memcmp(header->signature, FMAP_SIGNATURE,
+		   sizeof(header->signature))) {
+		pr_warn("coreboot: FMAP signature mismatch\n");
+		memunmap(header);
+		return -ENODEV;
+	}
+
+	/* Validate FMAP version */
+	if (header->ver_major != FMAP_VER_MAJOR) {
+		pr_warn("coreboot: FMAP version not supported\n");
+		memunmap(header);
+		return -ENODEV;
+	}
+
+	pr_info("coreboot: Got valid FMAP v%u.%u for 0x%x byte ROM\n",
+		header->ver_major, header->ver_minor, header->size);
+
+	fmap_size = sizeof(*header) + header->nareas * sizeof(struct fmap_area);
+	memunmap(header);
+
+	fmap = devm_memremap(&dev->dev, cbmem_ref->cbmem_addr, fmap_size,
+			     MEMREMAP_WB);
+	if (!fmap) {
+		pr_warn("coreboot: Failed to remap FMAP\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int fmap_remove(struct coreboot_device *dev)
+{
+	struct platform_device *pdev = dev_get_drvdata(&dev->dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static struct coreboot_driver fmap_driver = {
+	.probe = fmap_probe,
+	.remove = fmap_remove,
+	.drv = {
+		.name = "fmap",
+	},
+	.tag = CB_TAG_FMAP,
+};
+
+static struct bin_attribute fmap_bin_attr = {
+	.attr = {.name = "fmap", .mode = 0444},
+	.read = fmap_read,
+};
+
+static int __init coreboot_fmap_init(void)
+{
+	int err;
+
+	err = sysfs_create_bin_file(firmware_kobj, &fmap_bin_attr);
+	if (err)
+		return err;
+
+	return coreboot_driver_register(&fmap_driver);
+}
+
+static void coreboot_fmap_exit(void)
+{
+	coreboot_driver_unregister(&fmap_driver);
+	sysfs_remove_bin_file(firmware_kobj, &fmap_bin_attr);
+}
+
+module_init(coreboot_fmap_init);
+module_exit(coreboot_fmap_exit);
+
+MODULE_AUTHOR("9elements Agency GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/fmap-coreboot.h b/drivers/firmware/google/fmap-coreboot.h
new file mode 100644
index 000000000000..7107a01af0e3
--- /dev/null
+++ b/drivers/firmware/google/fmap-coreboot.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * bootmedia-coreboot.h
+ *
+ * Copyright 2019 9elements Agency GmbH <patrick.rudolph@9elements.com>
+ */
+
+#ifndef __FMAP_COREBOOT_H
+#define __FMAP_COREBOOT_H
+
+const char *coreboot_fmap_region_to_name(const u32 start, const u32 size);
+
+#endif /* __FMAP_COREBOOT_H */
diff --git a/drivers/firmware/google/fmap_serialized.h b/drivers/firmware/google/fmap_serialized.h
new file mode 100644
index 000000000000..a001e47fa244
--- /dev/null
+++ b/drivers/firmware/google/fmap_serialized.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2010, Google Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *    * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above
+ * copyright notice, this list of conditions and the following disclaimer
+ * in the documentation and/or other materials provided with the
+ * distribution.
+ *    * Neither the name of Google Inc. nor the names of its
+ * contributors may be used to endorse or promote products derived from
+ * this software without specific prior written permission.
+ *
+ */
+
+#ifndef FLASHMAP_SERIALIZED_H__
+#define FLASHMAP_SERIALIZED_H__
+
+#define FMAP_SIGNATURE		"__FMAP__"
+#define FMAP_VER_MAJOR		1	/* this header's FMAP major version */
+#define FMAP_VER_MINOR		1	/* this header's FMAP minor version */
+#define FMAP_STRLEN		32	/* maximum length for strings,
+					 * including null-terminator
+					 */
+
+enum fmap_flags {
+	FMAP_AREA_STATIC	= 1 << 0,
+	FMAP_AREA_COMPRESSED	= 1 << 1,
+	FMAP_AREA_RO		= 1 << 2,
+	FMAP_AREA_PRESERVE	= 1 << 3,
+};
+
+/* Mapping of volatile and static regions in firmware binary */
+struct fmap_area {
+	u32 offset;                /* offset relative to base */
+	u32 size;                  /* size in bytes */
+	u8  name[FMAP_STRLEN];     /* descriptive name */
+	u16 flags;                 /* flags for this area */
+} __packed;
+
+struct fmap {
+	u8  signature[8];	/* "__FMAP__" (0x5F5F464D41505F5F) */
+	u8  ver_major;		/* major version */
+	u8  ver_minor;		/* minor version */
+	u64 base;		/* address of the firmware binary */
+	u32 size;		/* size of firmware binary in bytes */
+	u8  name[FMAP_STRLEN];	/* name of this firmware binary */
+	u16 nareas;		/* number of areas described by
+				 * fmap_areas[] below
+				 */
+	struct fmap_area areas[];
+} __packed;
+
+#endif	/* FLASHMAP_SERIALIZED_H__ */
-- 
2.21.0

