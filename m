Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7628E20672
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="PmFLvl34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKOQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:16:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50507 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:16:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so10203776wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVxHSx/minQx5d0tJI7s0eZgBU80i8rjqDZ6K3QTLuc=;
        b=PmFLvl34Ywer4Wi+BfDYl4JasRk9hvc+CVeCSzTbzSUY8ons28GoXPXrCaQ5fkiCo1
         jcx9b+Flgnv1ERWX9hMnls1XE4KhqCoZTeuFtMlM1VVP6uIef5yX4g03j6jUBhB+LSOg
         8tHjIiItg312SB8bZ7lTk2vJQAgIuFr1W4AAHP1+pR52GMXM57x8LiXVTuW/nyPytOKO
         gV7kZfj5gSrf8gqlcYCzA5jLbPYYX8HrzvRJIUmEzzNk0RhOqC+8RqcsDUzAKpObxxSo
         vXGmUx3qIazJp6jvkRPsq8A0keQ0r7zX/5243sZ+xBOQDC/5HJl2e7dnONWr26Kwc1Jm
         ZrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVxHSx/minQx5d0tJI7s0eZgBU80i8rjqDZ6K3QTLuc=;
        b=IsJhNT1RPKCORpJYJiYKBdeyk389ROKqFZtQfTxNBuwzsUnM75dYBVORop6rVJ0HUF
         aOVyFPK4eEtxcYpZgZKSv7zRO0RVhWleV2t2QMCeZnR9CFJrMIvzig7yE63ae81ICRjB
         xg5B6Tbu4qs9Si89cZk4Egng7be3ZjCknWz/MdxWAgY/DiM1K0RQ9AQSs9VaTUdrerKh
         CejlQ6eOOCWrtb/V9ANZlrhURa/lFLrdyPc94OBfV6fIrkmy7V3bf0IB/Puo6+9BjS+E
         HzC99Ou2/blb3p+kzWpl/2ax4zn+KO1by+TNk9HxHlcdLdV062aVo9ToK2GR5hXtxCO4
         S9qg==
X-Gm-Message-State: APjAAAXxAyiUUkiq4Fm5n5UCIVLZo4GlUKKy7EVJ8p+5XyisOd4nIbEa
        f1OSswbvGVc4lNmAKRK6gz0Pn9Fm8H7eQ8Eg
X-Google-Smtp-Source: APXvYqxOJPwnQnfs2DiWf+oCvT22TYgRLoTMNkeru2+85IdMaQItnEz5r7r5Ry3s+GEjZiKKGiFipg==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr16534329wmb.175.1573834582334;
        Fri, 15 Nov 2019 08:16:22 -0800 (PST)
Received: from rudolphp.sr1.9esec.dev (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id o5sm11637467wrx.15.2019.11.15.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:16:21 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 2/2] firmware: google: Expose coreboot tables over sysfs
Date:   Fri, 15 Nov 2019 17:15:16 +0100
Message-Id: <20191115161524.23738-3-patrick.rudolph@9elements.com>
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

Make all coreboot table entries available to userland. This is useful for
tools that are currently using /dev/mem.

Besides the tag and size also expose the raw table data itself.

Tools can easily scan for the right coreboot table by reading
/sys/bus/coreboot/devices/coreboot*/attributes/id
The binary table data can then be read from
/sys/bus/coreboot/devices/coreboot*/attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/coreboot_table.c | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 8d132e4f008a..baddf28a2103 100644
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
+	return sprintf(buffer, "%08x\n", device->entry.tag);
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

