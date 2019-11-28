Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945721774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Q97BIevk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfK1Mv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:51:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42591 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Mv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:51:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so30967657wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/Qtb3ZERKyiKM574EOCUn87VIOAQ2MiAJTI9WZq8LQ=;
        b=Q97BIevkGIp1y4UcUa6BeYIKIcwlLB7yRoPh4CA3a6dJNZYsUbyRQJpN3RV9EVmsDp
         mUiCVdEOOWVF+vwKGrsGIFW3lg2DCGAOFpd/Bp76xb90UVJSiJwZG/DjopYLetkhRBNk
         jy2lA1bE48RdwFzu2gM/uRfh8Pk2vR98Q1+nMMwFZlPGFPx8m8Glnc9g0wDmRgN3kG8N
         1JB/6JmmAEtZ/pEWb9pMbWPL0jj7NqYLMpcsLXl+mt+miXwvqFCnEi404OcWGZZRHTz7
         9hY5jzkCTvLeoBQ7NMHeoASYZ4cwpVQOX1yx7sud8k3g8t3jn47YS6Ii/qtcNajp2Wmq
         QLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/Qtb3ZERKyiKM574EOCUn87VIOAQ2MiAJTI9WZq8LQ=;
        b=mCehRRhsyn9ZPFu4QJNkPQvd39ZwI63iOcgrOZhFjpkeuzTaMi/7xSCDXRYBggdKK0
         kp/N9nVpiHTBhNaIMrZKX5V16HgjuJUcY1PeiYnx4N8zFbSPGTgACStBnuFskGWel1wz
         AgiRerUWBjwPz0VTsg/IVMTk09OgMk8QU6UZmvudwhicLXlggax1U5QtgqZX/pWovyt9
         kqYh7pvU0Na9E5xwb921eIMNoJjuGQ7jGEzIqowP4sWZo/rntNT3xQPRrbz3fZ0PRwMR
         Bmg+YLJ42gfCMoBXyNNdW4AQSMSkpyd60xaKulrVWQqXB+3nTlbddx0GiwDDS6hLa/Id
         gOaQ==
X-Gm-Message-State: APjAAAVWitVprxVvJMfQVXsl3LA8ovzymrziRlM9yAaE1X9EL36gu8wQ
        FiND8miXgFbdh5RwldQiK7lLs1jymZ1NmOev
X-Google-Smtp-Source: APXvYqwiSCqweZZ3jxD//3HM+oAedWhPc9yXhVekgzLINkqjous/lAUYSqfU7tc/1eEgnB80VR8uOw==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr26520284wrn.214.1574945512016;
        Thu, 28 Nov 2019 04:51:52 -0800 (PST)
Received: from rudolphp.sr1.9esec.dev (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id j11sm22959607wrq.26.2019.11.28.04.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:51:51 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/2] firmware: google: Expose coreboot tables over sysfs
Date:   Thu, 28 Nov 2019 13:50:51 +0100
Message-Id: <20191128125100.14291-3-patrick.rudolph@9elements.com>
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

Make all coreboot table entries available to userland. This is useful for
tools that are currently using /dev/mem.

Besides the tag and size also expose the raw table data itself.

Update the ABI documentation to explain the new sysfs interface.

Tools can easily scan for the right coreboot table by reading
/sys/bus/coreboot/devices/coreboot*/attributes/id
The binary table data can then be read from
/sys/bus/coreboot/devices/coreboot*/attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
 -v2:
	- Add ABI documentation
	- Add 0x prefix on hex values
	- Remove wrong ioremap hint as found by CI
 -v3:
	- Use BIN_ATTR_RO
---
 Documentation/ABI/stable/sysfs-bus-coreboot | 30 +++++++++++
 drivers/firmware/google/coreboot_table.c    | 57 +++++++++++++++++++++
 2 files changed, 87 insertions(+)

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
index 8d132e4f008a..1f7329d72f54 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -6,6 +6,7 @@
  *
  * Copyright 2017 Google Inc.
  * Copyright 2017 Samuel Holland <samuel@sholland.org>
+ * Copyright 2019 9elements Agency GmbH
  */
 
 #include <linux/acpi.h>
@@ -84,6 +85,60 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
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
+static ssize_t data_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr,
+			 char *buffer, loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct coreboot_device *device = CB_DEV(dev);
+
+	return memory_read_from_buffer(buffer, count, &offset,
+				       &device->entry, device->entry.size);
+}
+
+static BIN_ATTR_RO(data, 0);
+
+static struct bin_attribute *cb_dev_bin_attrs[] = {
+	&bin_attr_data,
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
@@ -104,6 +159,8 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
+		device->dev.groups = cb_dev_attr_groups;
+
 		memcpy(&device->entry, ptr_entry, entry->size);
 
 		ret = device_register(&device->dev);
-- 
2.21.0

