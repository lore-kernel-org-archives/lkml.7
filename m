Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F41C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F532087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9acBv37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfDOQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:40:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38157 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDOQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:40:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so21313016wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1LmeL6EpG1VgGJNqDDdpH/UKiQak73IczIGKf0xEuE=;
        b=M9acBv374WJ40VLFZCDxr9zyWz/Td7mJuCGHz7vYvbsrq+7Lo7/BsyQ2JoJWBMtqhe
         iug5Ielun+M1iWhOolOTUuUUhcPRcHP8DH5U0Z0bS1XLYRnSFcpb1MRoy2D1iqaYTSVv
         t1TVjsgbOQXyt2ycHWCXP41qJIc2yGckhn7adyc6R1n0YFX33wGJkIXEHeAABktK/str
         Jot1ulODlQCgHOHh6113QYSrZG/Fy7C9OuxQYCoEp2H0owzLki4g3TlLnD8lUCI44mxI
         9zKik/QGAaWirx7N54l7wA0K6EKKrPLHXzDA2YO/LM8+8fYXdXZ4qZnCjMgqZFI3lreT
         PMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1LmeL6EpG1VgGJNqDDdpH/UKiQak73IczIGKf0xEuE=;
        b=mzJn6Aeea82UI0kbVG/eXMDrrrO2R2HUXP3WJTRZ0606OB2rTFqwb2+BDxF7Sdgs6X
         duC1vVDM2KVTYI3V7pNSJDcp8Yn5I9E40nJqDGiMDVvh+21MkUfgRT6RnqZnH9TsG0gj
         SORB/6N7GzJ60O6PqlUQaOXeCjrFvkHiigJNRpP74zMECCyWK4E2REZN5rgM/gnnGX9s
         zkLeRh5l129ZA1FwURNRSYzvwwSu/69/U70PbdrY/XjcJNxOD63hzQ5gRMNfp5nOB+iW
         XIZFeuL9Z0XvmgxJpZ3sc1Y4nVUFnnOEDWaY5y/STZuz3l3MUEW+Ytt/i3FzS5ZLDyPq
         uQmQ==
X-Gm-Message-State: APjAAAWFgbxfVfV+mBR6weS1VPiZui6sTUw0u9GqUkChDkT2efa1lini
        kgl2kHxwNov+Hb+P5dPiNl5hPw==
X-Google-Smtp-Source: APXvYqzMcFM5O5CjpHlkKyMerpP+DarkSIdtJUlfI58itM1iVmB+PGXPBTX/6Ui+rnM5oEGCMxWzeA==
X-Received: by 2002:a1c:c18d:: with SMTP id r135mr22348297wmf.112.1555346422958;
        Mon, 15 Apr 2019 09:40:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm46142708wrt.4.2019.04.15.09.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 09:40:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     maxime.ripard@bootlin.com, gkohli@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: add NVMEM_SYSFS Kconfig
Date:   Mon, 15 Apr 2019 17:40:11 +0100
Message-Id: <20190415164011.2638-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many nvmem providers are not very keen on having default sysfs
nvmem entry, as most of the usecases for them are inside kernel
itself. And in some cases read/writes to some areas in nvmem are
restricted and trapped at secure monitor level, so accessing them
from userspace would result in board reboots.

This patch adds new NVMEM_SYSFS Kconfig to make binary sysfs entry
an optional one. This provision will give more flexibility to users.
This patch also moves existing sysfs code to a new file so that its
not compiled in when its not really required.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/ABI/stable/sysfs-bus-nvmem |   2 +
 drivers/nvmem/Kconfig                    |   9 +
 drivers/nvmem/Makefile                   |   3 +
 drivers/nvmem/core.c                     | 264 +----------------------
 drivers/nvmem/nvmem-sysfs.c              | 256 ++++++++++++++++++++++
 drivers/nvmem/nvmem.h                    |  62 ++++++
 6 files changed, 336 insertions(+), 260 deletions(-)
 create mode 100644 drivers/nvmem/nvmem-sysfs.c
 create mode 100644 drivers/nvmem/nvmem.h

diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem b/Documentation/ABI/stable/sysfs-bus-nvmem
index 5923ab4620c5..9ffba8576f7b 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -6,6 +6,8 @@ Description:
 		This file allows user to read/write the raw NVMEM contents.
 		Permissions for write to this file depends on the nvmem
 		provider configuration.
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled
 
 		ex:
 		hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index a90e9a1ebe55..e316811e9c04 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -13,6 +13,15 @@ menuconfig NVMEM
 
 if NVMEM
 
+config NVMEM_SYSFS
+	bool "/sys/bus/nvmem/devices/*/nvmem (sysfs interface)"
+	depends on SYSFS
+	help
+	 Say Y here to add a sysfs interface for NVMEM.
+
+	 This interface is mostly used by userspace applications to
+	 read/write directly into nvmem.
+
 config NVMEM_IMX_IIM
 	tristate "i.MX IC Identification Module support"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4c7ba12a7005..c1fe4768dfef 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -6,6 +6,9 @@
 obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
 
+obj-$(CONFIG_NVMEM_SYSFS)	+= nvmem_sysfs.o
+nvmem_sysfs-y			:= nvmem-sysfs.o
+
 # Devices
 obj-$(CONFIG_NVMEM_BCM_OCOTP)	+= nvmem-bcm-ocotp.o
 nvmem-bcm-ocotp-y		:= bcm-ocotp.o
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 5abebf2128b8..c7892c3da91f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -17,27 +17,7 @@
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/slab.h>
-
-struct nvmem_device {
-	struct module		*owner;
-	struct device		dev;
-	int			stride;
-	int			word_size;
-	int			id;
-	struct kref		refcnt;
-	size_t			size;
-	bool			read_only;
-	int			flags;
-	enum nvmem_type		type;
-	struct bin_attribute	eeprom;
-	struct device		*base_dev;
-	struct list_head	cells;
-	nvmem_reg_read_t	reg_read;
-	nvmem_reg_write_t	reg_write;
-	void *priv;
-};
-
-#define FLAG_COMPAT		BIT(0)
+#include "nvmem.h"
 
 struct nvmem_cell {
 	const char		*name;
@@ -61,18 +41,7 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
-static const char * const nvmem_type_str[] = {
-	[NVMEM_TYPE_UNKNOWN] = "Unknown",
-	[NVMEM_TYPE_EEPROM] = "EEPROM",
-	[NVMEM_TYPE_OTP] = "OTP",
-	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
-};
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static struct lock_class_key eeprom_lock_key;
-#endif
 
-#define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
 static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			  void *val, size_t bytes)
 {
@@ -91,187 +60,6 @@ static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
-static ssize_t type_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	struct nvmem_device *nvmem = to_nvmem_device(dev);
-
-	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
-}
-
-static DEVICE_ATTR_RO(type);
-
-static struct attribute *nvmem_attrs[] = {
-	&dev_attr_type.attr,
-	NULL,
-};
-
-static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr,
-				    char *buf, loff_t pos, size_t count)
-{
-	struct device *dev;
-	struct nvmem_device *nvmem;
-	int rc;
-
-	if (attr->private)
-		dev = attr->private;
-	else
-		dev = container_of(kobj, struct device, kobj);
-	nvmem = to_nvmem_device(dev);
-
-	/* Stop the user from reading */
-	if (pos >= nvmem->size)
-		return 0;
-
-	if (count < nvmem->word_size)
-		return -EINVAL;
-
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
-	count = round_down(count, nvmem->word_size);
-
-	rc = nvmem_reg_read(nvmem, pos, buf, count);
-
-	if (rc)
-		return rc;
-
-	return count;
-}
-
-static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr,
-				     char *buf, loff_t pos, size_t count)
-{
-	struct device *dev;
-	struct nvmem_device *nvmem;
-	int rc;
-
-	if (attr->private)
-		dev = attr->private;
-	else
-		dev = container_of(kobj, struct device, kobj);
-	nvmem = to_nvmem_device(dev);
-
-	/* Stop the user from writing */
-	if (pos >= nvmem->size)
-		return -EFBIG;
-
-	if (count < nvmem->word_size)
-		return -EINVAL;
-
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
-	count = round_down(count, nvmem->word_size);
-
-	rc = nvmem_reg_write(nvmem, pos, buf, count);
-
-	if (rc)
-		return rc;
-
-	return count;
-}
-
-/* default read/write permissions */
-static struct bin_attribute bin_attr_rw_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0644,
-	},
-	.read	= bin_attr_nvmem_read,
-	.write	= bin_attr_nvmem_write,
-};
-
-static struct bin_attribute *nvmem_bin_rw_attributes[] = {
-	&bin_attr_rw_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_rw_group = {
-	.bin_attrs	= nvmem_bin_rw_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_rw_dev_groups[] = {
-	&nvmem_bin_rw_group,
-	NULL,
-};
-
-/* read only permission */
-static struct bin_attribute bin_attr_ro_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0444,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
-static struct bin_attribute *nvmem_bin_ro_attributes[] = {
-	&bin_attr_ro_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_ro_group = {
-	.bin_attrs	= nvmem_bin_ro_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_ro_dev_groups[] = {
-	&nvmem_bin_ro_group,
-	NULL,
-};
-
-/* default read/write permissions, root only */
-static struct bin_attribute bin_attr_rw_root_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0600,
-	},
-	.read	= bin_attr_nvmem_read,
-	.write	= bin_attr_nvmem_write,
-};
-
-static struct bin_attribute *nvmem_bin_rw_root_attributes[] = {
-	&bin_attr_rw_root_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_rw_root_group = {
-	.bin_attrs	= nvmem_bin_rw_root_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
-	&nvmem_bin_rw_root_group,
-	NULL,
-};
-
-/* read only permission, root only */
-static struct bin_attribute bin_attr_ro_root_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0400,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
-static struct bin_attribute *nvmem_bin_ro_root_attributes[] = {
-	&bin_attr_ro_root_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_ro_root_group = {
-	.bin_attrs	= nvmem_bin_ro_root_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
-	&nvmem_bin_ro_root_group,
-	NULL,
-};
-
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
@@ -422,43 +210,6 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 	return rval;
 }
 
-/*
- * nvmem_setup_compat() - Create an additional binary entry in
- * drivers sys directory, to be backwards compatible with the older
- * drivers/misc/eeprom drivers.
- */
-static int nvmem_setup_compat(struct nvmem_device *nvmem,
-			      const struct nvmem_config *config)
-{
-	int rval;
-
-	if (!config->base_dev)
-		return -EINVAL;
-
-	if (nvmem->read_only)
-		nvmem->eeprom = bin_attr_ro_root_nvmem;
-	else
-		nvmem->eeprom = bin_attr_rw_root_nvmem;
-	nvmem->eeprom.attr.name = "eeprom";
-	nvmem->eeprom.size = nvmem->size;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	nvmem->eeprom.attr.key = &eeprom_lock_key;
-#endif
-	nvmem->eeprom.private = &nvmem->dev;
-	nvmem->base_dev = config->base_dev;
-
-	rval = device_create_bin_file(nvmem->base_dev, &nvmem->eeprom);
-	if (rval) {
-		dev_err(&nvmem->dev,
-			"Failed to create eeprom binary file %d\n", rval);
-		return rval;
-	}
-
-	nvmem->flags |= FLAG_COMPAT;
-
-	return 0;
-}
-
 /**
  * nvmem_register_notifier() - Register a notifier block for nvmem events.
  *
@@ -651,14 +402,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-	if (config->root_only)
-		nvmem->dev.groups = nvmem->read_only ?
-			nvmem_ro_root_dev_groups :
-			nvmem_rw_root_dev_groups;
-	else
-		nvmem->dev.groups = nvmem->read_only ?
-			nvmem_ro_dev_groups :
-			nvmem_rw_dev_groups;
+	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
 
 	device_initialize(&nvmem->dev);
 
@@ -669,7 +413,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		goto err_put_device;
 
 	if (config->compat) {
-		rval = nvmem_setup_compat(nvmem, config);
+		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
 			goto err_device_del;
 	}
@@ -696,7 +440,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
-		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
+		nvmem_sysfs_remove_compat(nvmem, config);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
new file mode 100644
index 000000000000..6f303b91f6e7
--- /dev/null
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Limited
+ */
+#include "nvmem.h"
+
+static const char * const nvmem_type_str[] = {
+	[NVMEM_TYPE_UNKNOWN] = "Unknown",
+	[NVMEM_TYPE_EEPROM] = "EEPROM",
+	[NVMEM_TYPE_OTP] = "OTP",
+	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key eeprom_lock_key;
+#endif
+
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
+}
+
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *nvmem_attrs[] = {
+	&dev_attr_type.attr,
+	NULL,
+};
+
+static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr,
+				    char *buf, loff_t pos, size_t count)
+{
+	struct device *dev;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	if (attr->private)
+		dev = attr->private;
+	else
+		dev = container_of(kobj, struct device, kobj);
+	nvmem = to_nvmem_device(dev);
+
+	/* Stop the user from reading */
+	if (pos >= nvmem->size)
+		return 0;
+
+	if (count < nvmem->word_size)
+		return -EINVAL;
+
+	if (pos + count > nvmem->size)
+		count = nvmem->size - pos;
+
+	count = round_down(count, nvmem->word_size);
+
+	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
+
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
+				     struct bin_attribute *attr,
+				     char *buf, loff_t pos, size_t count)
+{
+	struct device *dev;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	if (attr->private)
+		dev = attr->private;
+	else
+		dev = container_of(kobj, struct device, kobj);
+	nvmem = to_nvmem_device(dev);
+
+	/* Stop the user from writing */
+	if (pos >= nvmem->size)
+		return -EFBIG;
+
+	if (count < nvmem->word_size)
+		return -EINVAL;
+
+	if (pos + count > nvmem->size)
+		count = nvmem->size - pos;
+
+	count = round_down(count, nvmem->word_size);
+
+	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
+
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+/* default read/write permissions */
+static struct bin_attribute bin_attr_rw_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0644,
+	},
+	.read	= bin_attr_nvmem_read,
+	.write	= bin_attr_nvmem_write,
+};
+
+static struct bin_attribute *nvmem_bin_rw_attributes[] = {
+	&bin_attr_rw_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_rw_group = {
+	.bin_attrs	= nvmem_bin_rw_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_rw_dev_groups[] = {
+	&nvmem_bin_rw_group,
+	NULL,
+};
+
+/* read only permission */
+static struct bin_attribute bin_attr_ro_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0444,
+	},
+	.read	= bin_attr_nvmem_read,
+};
+
+static struct bin_attribute *nvmem_bin_ro_attributes[] = {
+	&bin_attr_ro_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_ro_group = {
+	.bin_attrs	= nvmem_bin_ro_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_ro_dev_groups[] = {
+	&nvmem_bin_ro_group,
+	NULL,
+};
+
+/* default read/write permissions, root only */
+static struct bin_attribute bin_attr_rw_root_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0600,
+	},
+	.read	= bin_attr_nvmem_read,
+	.write	= bin_attr_nvmem_write,
+};
+
+static struct bin_attribute *nvmem_bin_rw_root_attributes[] = {
+	&bin_attr_rw_root_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_rw_root_group = {
+	.bin_attrs	= nvmem_bin_rw_root_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
+	&nvmem_bin_rw_root_group,
+	NULL,
+};
+
+/* read only permission, root only */
+static struct bin_attribute bin_attr_ro_root_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0400,
+	},
+	.read	= bin_attr_nvmem_read,
+};
+
+static struct bin_attribute *nvmem_bin_ro_root_attributes[] = {
+	&bin_attr_ro_root_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_ro_root_group = {
+	.bin_attrs	= nvmem_bin_ro_root_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
+	&nvmem_bin_ro_root_group,
+	NULL,
+};
+
+const struct attribute_group **nvmem_sysfs_get_groups(
+					struct nvmem_device *nvmem,
+					const struct nvmem_config *config)
+{
+	if (config->root_only)
+		return nvmem->read_only ?
+			nvmem_ro_root_dev_groups :
+			nvmem_rw_root_dev_groups;
+
+	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
+}
+
+/*
+ * nvmem_setup_compat() - Create an additional binary entry in
+ * drivers sys directory, to be backwards compatible with the older
+ * drivers/misc/eeprom drivers.
+ */
+int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
+			      const struct nvmem_config *config)
+{
+	int rval;
+
+	if (!config->compat)
+		return 0;
+
+	if (!config->base_dev)
+		return -EINVAL;
+
+	if (nvmem->read_only)
+		nvmem->eeprom = bin_attr_ro_root_nvmem;
+	else
+		nvmem->eeprom = bin_attr_rw_root_nvmem;
+	nvmem->eeprom.attr.name = "eeprom";
+	nvmem->eeprom.size = nvmem->size;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	nvmem->eeprom.attr.key = &eeprom_lock_key;
+#endif
+	nvmem->eeprom.private = &nvmem->dev;
+	nvmem->base_dev = config->base_dev;
+
+	rval = device_create_bin_file(nvmem->base_dev, &nvmem->eeprom);
+	if (rval) {
+		dev_err(&nvmem->dev,
+			"Failed to create eeprom binary file %d\n", rval);
+		return rval;
+	}
+
+	nvmem->flags |= FLAG_COMPAT;
+
+	return 0;
+}
+
+void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
+			      const struct nvmem_config *config)
+{
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
+}
diff --git a/drivers/nvmem/nvmem.h b/drivers/nvmem/nvmem.h
new file mode 100644
index 000000000000..eb8ed7121fa3
--- /dev/null
+++ b/drivers/nvmem/nvmem.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DRIVERS_NVMEM_H
+#define _DRIVERS_NVMEM_H
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+
+struct nvmem_device {
+	struct module		*owner;
+	struct device		dev;
+	int			stride;
+	int			word_size;
+	int			id;
+	struct kref		refcnt;
+	size_t			size;
+	bool			read_only;
+	int			flags;
+	enum nvmem_type		type;
+	struct bin_attribute	eeprom;
+	struct device		*base_dev;
+	struct list_head	cells;
+	nvmem_reg_read_t	reg_read;
+	nvmem_reg_write_t	reg_write;
+	void *priv;
+};
+
+#define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
+#define FLAG_COMPAT		BIT(0)
+
+#ifdef CONFIG_NVMEM_SYSFS
+const struct attribute_group **nvmem_sysfs_get_groups(
+					struct nvmem_device *nvmem,
+					const struct nvmem_config *config);
+int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
+			      const struct nvmem_config *config);
+void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
+			      const struct nvmem_config *config);
+#else
+static inline const struct attribute_group **nvmem_sysfs_get_groups(
+					struct nvmem_device *nvmem,
+					const struct nvmem_config *config)
+{
+	return NULL;
+}
+
+static inline int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
+				      const struct nvmem_config *config)
+{
+	return -ENOSYS;
+}
+static inline void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
+			      const struct nvmem_config *config)
+{
+}
+#endif /* CONFIG_NVMEM_SYSFS */
+
+#endif /* _DRIVERS_NVMEM_H */
-- 
2.21.0

