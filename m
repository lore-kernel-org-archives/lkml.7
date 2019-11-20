Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7888C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74742252C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="f7xLTrPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfKTNkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44028 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKTNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so28167410wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHnopwWvkmmTnJVl2X6mKxjcUforEZXEgcJgrEmjAB0=;
        b=f7xLTrPBQvQxEF9vkj2upkWeReLoDBCeQFkkhGeuGdXmxpYd2OtAzoXGDBuEx/8C/k
         m5bxP2LjKSSkyW6ge8Op8AF7EowaRz+PqyzmjsLdNYj72LGIkn5sQY61kjUC9SODE4Zs
         es0tYHkUSMdKQY1qviz2GHB3e8BGVqGfBe2fcywh43arhWUlnSohr1Wgc/pwN4Hpw+Sf
         cV0yTfiQa3TaL6fMJ2NRPUNvtA6pJf7LKFlsxNQQX3xKxpoR2E8oOLTCeZT6T6LefMGH
         TOrpYycWxDbn9WJuw+SuNsRIDR9y0fhx7hr7vtIDGX2VztQtcz3Dja317H903tX9AvKi
         TLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHnopwWvkmmTnJVl2X6mKxjcUforEZXEgcJgrEmjAB0=;
        b=YSSgA2ZGFQZEGzWMTTLVzUjN0UezgrGPKHMlNaNhDWOkdm6t7xRwAjcJ0EiAXCoABR
         x6aJyVIb8Vfae4MEmvR6lNgQeCrScsxiex7wmpgEim1hqcheXAt7sr4HeJ/jfHe5pqh6
         uPRK4hqWRfnaqWJwHR2R4xjWQNuwvbxXL9J6KI/1StJuk97PWD6GuSXPFeUrY9AZJqQl
         b0HiiL4BzscaAEPur00nC7yNvKIDAPcgz/c/3yH4tg2/k8+cD86f+0JSDG8LPkVzTIMg
         7yvxRPZGMxVYPy843JG0IBHRhjcz35DASSm5pIr/DheuzC/18oPKgHA1UnCcHmRyyAZE
         KgoA==
X-Gm-Message-State: APjAAAW8dnKKnG1ifUz1Qc8QCFnpB8frmeNi9B+H31J8zA60zNVRWfez
        2F02+G15e/SyJLt7A6SPho8M3JC7AoJCdPXl
X-Google-Smtp-Source: APXvYqytR5W4sutvEVJ8ouG28aGrhHuENey/qExiXx4Z8sNpH35Paux596NhGHjc2DyilnsOLpo+Cg==
X-Received: by 2002:adf:fa4a:: with SMTP id y10mr3506109wrr.177.1574257242554;
        Wed, 20 Nov 2019 05:40:42 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t14sm30473434wrw.87.2019.11.20.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:40:42 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH 2/2] firmware: google: Expose coreboot tables over sysfs
Date:   Wed, 20 Nov 2019 14:39:47 +0100
Message-Id: <20191120133958.13160-3-patrick.rudolph@9elements.com>
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

Make all coreboot table entries available to userland. This is useful for
tools that are currently using /dev/mem.

Besides the tag and size also expose the raw table data itself.

Update the ABI documentation to explain the new sysfs interface.

Tools can easily scan for the right coreboot table by reading
/sys/bus/coreboot/devices/coreboot*/attributes/id
The binary table data can then be read from
/sys/bus/coreboot/devices/coreboot*/attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 -v2:
	- Add ABI documentation
	- Add 0x prefix on hex values
	- Remove wrong ioremap hint as found by CI
---
 Documentation/ABI/stable/sysfs-bus-coreboot | 30 +++++++++++
 drivers/firmware/google/coreboot_table.c    | 60 +++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/ABI/stable/sysfs-bus-coreboot
index 1b04b8abc858..0f28601229f3 100644
--- a/Documentation/ABI/stable/sysfs-bus-coreboot
+++ b/Documentation/ABI/stable/sysfs-bus-coreboot
@@ -41,3 +41,33 @@ Description:
 		buffer.
 		The file holds a read-only binary representation of the CBMEM
 		buffer.
+
+What:		/sys/bus/coreboot/devices/.../attributes/id
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named attributes/id.
+		The file holds an ASCII representation of the coreboot table ID
+		in hex (e.g. 0x000000ef). On coreboot enabled platforms the ID is
+		usually called TAG.
+
+What:		/sys/bus/coreboot/devices/.../attributes/size
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		attributes/size.
+		The file holds an ASCII representation as decimal number of the
+		coreboot table size (e.g. 64).
+
+What:		/sys/bus/coreboot/devices/.../attributes/data
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		attributes/data.
+		The file holds a read-only binary representation of the coreboot
+		table.
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 8d132e4f008a..d3a6379fb2a6 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -6,6 +6,7 @@
  *
  * Copyright 2017 Google Inc.
  * Copyright 2017 Samuel Holland <samuel@sholland.org>
+ * Copyright 2019 9elements Agency GmbH
  */
 
 #include <linux/acpi.h>
@@ -84,6 +85,63 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buffer)
+{
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return sprintf(buffer, "0x%08x\n", device->entry.tag);
+}
+
+static ssize_t size_show(struct device *dev,
+			 struct device_attribute *attr, char *buffer)
+{
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return sprintf(buffer, "%u\n", device->entry.size);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(size);
+
+static struct attribute *cb_dev_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_size.attr,
+	NULL
+};
+
+static ssize_t table_data_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buffer, loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return memory_read_from_buffer(buffer, count, &offset,
+				       &device->entry, device->entry.size);
+}
+
+static struct bin_attribute coreboot_attr_data = {
+	.attr = { .name = "data", .mode = 0444 },
+	.read = table_data_read,
+};
+
+static struct bin_attribute *cb_dev_bin_attrs[] = {
+	&coreboot_attr_data,
+	NULL
+};
+
+static const struct attribute_group cb_dev_attr_group = {
+	.name = "attributes",
+	.attrs = cb_dev_attrs,
+	.bin_attrs = cb_dev_bin_attrs,
+};
+
+static const struct attribute_group *cb_dev_attr_groups[] = {
+	&cb_dev_attr_group,
+	NULL
+};
+
 static int coreboot_table_populate(struct device *dev, void *ptr)
 {
 	int i, ret;
@@ -104,6 +162,8 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
+		device->dev.groups = cb_dev_attr_groups;
+
 		memcpy(&device->entry, ptr_entry, entry->size);
 
 		ret = device_register(&device->dev);
-- 
2.21.0

