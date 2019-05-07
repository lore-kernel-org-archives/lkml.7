Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FFC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE93205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFwxsTPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEGQ7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:59:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35671 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEGQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:59:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so8488489plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YRsPPqUUm+7o9yGwTxKxPT6YGCuvxydyAJG1Zi+R4YM=;
        b=XFwxsTPOcqhP2VCcO0D/vxMzYiqIIEZb5OKEKNurrAuUvz006cE7jyVe3qFs1u2/HR
         U+3T2YgfWZ5rnb/Ki2f9g/RuZbbjR1zbltLsNjpvfFOe+zLeT+RdItb4iYSVcpm0udF5
         +2Q5GS1Y/hx8tQyb0OKJSR16XmNj8XHpf0BZekclaKuzdHx8iQ4C6tnL7XNupuTj9uKb
         0FkWizuH/o/S1If/guzYLQKJKW/Dke35D8Rilt6niMtInQUcgHHWncvboKHBoTwDc5PT
         RYrHRoCEugsYSbjo8P8y/9njhXPlcNIz9wyR6hpFwYV4W5q5V7yd42jfHkawfbxZN4eE
         whAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YRsPPqUUm+7o9yGwTxKxPT6YGCuvxydyAJG1Zi+R4YM=;
        b=k0fp5RaSugox04UPl+iwCirUbHaF8JSdVZn6ZX6GDVoS3SKUTHGklNP61fL4PzMVUp
         vq4ZTLz8uafDJzUkedg3ujhF9hOw6ibk2iPWePkW95ob0MfV7ZxTyzwmCcWY/NmkUv1a
         N986FCmeOXkBR3qGccbwaOTk/lwVDJIRtzCYAVZnHZUyvuHnx099EMQcXMGNMuS7djRL
         vVnzEnaLwUu0d0Ka5ZyNct5urF2+epbS7+WdLgc7n6DG4wCrp/sijMdTm0+qcJttd730
         kREIJw9ChuM6G2SzGEg/iWLard1zLK8uzr0go8Bx60OzMcoPSz/i6fAix6/rj/TQ4CeC
         q25w==
X-Gm-Message-State: APjAAAUthiI88yFCt0aNgpYKjQtIa2YGfofyaEI221tJIkIdAfB14Aqe
        iOeOEBs+rSxmLw9Q7+ZDyW4=
X-Google-Smtp-Source: APXvYqwOY1inbu6ZKJzL4V1MJFE56V/uBHZtJvIPxkz93JlgDpvNlZL1ooSN1ikqkxfk9aFCstkmlw==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr40872266plz.91.1557248339118;
        Tue, 07 May 2019 09:58:59 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:58:58 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 3/7] devcoredump: allow to create several coredump files in one device
Date:   Wed,  8 May 2019 01:58:30 +0900
Message-Id: <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device coredump mechanism currently allows drivers to create only a
single coredump file.  If there are several binary blobs to dump, we need
to define a binary format or conver to text format in order to put them
into a single coredump file.

This provides a new function that allows drivers to create several device
coredump files in one crashed device.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- Remove unneeded braces.
- Allocate device_entry followed by an array of devcd_file elements.

 drivers/base/devcoredump.c  | 155 ++++++++++++++++++++++++++++++--------------
 include/linux/devcoredump.h |  33 ++++++++++
 2 files changed, 139 insertions(+), 49 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e42d0b5..4dd6dba 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -25,16 +25,20 @@ static bool devcd_disabled;
 /* if data isn't read by userspace after 5 minutes then delete it */
 #define DEVCD_TIMEOUT	(HZ * 60 * 5)
 
-struct devcd_entry {
-	struct device devcd_dev;
-	void *data;
-	size_t datalen;
-	struct module *owner;
+struct devcd_file {
+	struct bin_attribute bin_attr;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
 	void (*free)(void *data);
+};
+
+struct devcd_entry {
+	struct device devcd_dev;
+	struct module *owner;
 	struct delayed_work del_wk;
 	struct device *failing_dev;
+	int num_files;
+	struct devcd_file files[];
 };
 
 static struct devcd_entry *dev_to_devcd(struct device *dev)
@@ -45,8 +49,14 @@ static struct devcd_entry *dev_to_devcd(struct device *dev)
 static void devcd_dev_release(struct device *dev)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
+	int i;
+
+	for (i = 0; i < devcd->num_files; i++) {
+		struct devcd_file *file = &devcd->files[i];
+
+		file->free(file->bin_attr.private);
+	}
 
-	devcd->free(devcd->data);
 	module_put(devcd->owner);
 
 	/*
@@ -64,9 +74,14 @@ static void devcd_dev_release(struct device *dev)
 static void devcd_del(struct work_struct *wk)
 {
 	struct devcd_entry *devcd;
+	int i;
 
 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
 
+	for (i = 0; i < devcd->num_files; i++)
+		device_remove_bin_file(&devcd->devcd_dev,
+				       &devcd->files[i].bin_attr);
+
 	device_del(&devcd->devcd_dev);
 	put_device(&devcd->devcd_dev);
 }
@@ -75,10 +90,11 @@ static ssize_t devcd_data_read(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
 			       char *buffer, loff_t offset, size_t count)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct devcd_entry *devcd = dev_to_devcd(dev);
+	struct devcd_file *file =
+		container_of(bin_attr, struct devcd_file, bin_attr);
 
-	return devcd->read(buffer, offset, count, devcd->data, devcd->datalen);
+	return file->read(buffer, offset, count, bin_attr->private,
+			  bin_attr->size);
 }
 
 static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
@@ -93,25 +109,6 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute devcd_attr_data = {
-	.attr = { .name = "data", .mode = S_IRUSR | S_IWUSR, },
-	.size = 0,
-	.read = devcd_data_read,
-	.write = devcd_data_write,
-};
-
-static struct bin_attribute *devcd_dev_bin_attrs[] = {
-	&devcd_attr_data, NULL,
-};
-
-static const struct attribute_group devcd_dev_group = {
-	.bin_attrs = devcd_dev_bin_attrs,
-};
-
-static const struct attribute_group *devcd_dev_groups[] = {
-	&devcd_dev_group, NULL,
-};
-
 static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
@@ -157,7 +154,6 @@ static struct class devcd_class = {
 	.name		= "devcoredump",
 	.owner		= THIS_MODULE,
 	.dev_release	= devcd_dev_release,
-	.dev_groups	= devcd_dev_groups,
 	.class_groups	= devcd_class_groups,
 };
 
@@ -234,30 +230,55 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				  offset);
 }
 
+static struct devcd_entry *devcd_alloc(struct dev_coredumpm_bulk_data *files,
+				       int num_files, gfp_t gfp)
+{
+	struct devcd_entry *devcd;
+	int i;
+
+	devcd = kzalloc(struct_size(devcd, files, num_files), gfp);
+	if (!devcd)
+		return NULL;
+
+	devcd->num_files = num_files;
+
+	for (i = 0; i < devcd->num_files; i++) {
+		struct devcd_file *file = &devcd->files[i];
+
+		sysfs_bin_attr_init(&file->bin_attr);
+		file->bin_attr.attr.name = files[i].name;
+
+		file->bin_attr.attr.mode = 0600;
+		file->bin_attr.size = files[i].datalen;
+		file->bin_attr.private = files[i].data;
+		file->bin_attr.read = devcd_data_read;
+		file->bin_attr.write = devcd_data_write;
+
+		file->read = files[i].read;
+		file->free = files[i].free;
+	}
+
+	return devcd;
+}
+
 /**
- * dev_coredumpm - create device coredump with read/free methods
+ * dev_coredumpm_bulk - create a number of device coredump files
  * @dev: the struct device for the crashed device
  * @owner: the module that contains the read/free functions, use %THIS_MODULE
- * @data: data cookie for the @read/@free functions
- * @datalen: length of the data
  * @gfp: allocation flags
- * @read: function to read from the given buffer
- * @free: function to free the given buffer
+ * @files: the configuration of device coredump files
+ * @num_files: the number of device coredump files to create
  *
- * Creates a new device coredump for the given device. If a previous one hasn't
- * been read yet, the new coredump is discarded. The data lifetime is determined
- * by the device coredump framework and when it is no longer needed the @free
- * function will be called to free the data.
+ * This function allows drivers to create several device coredump files in
+ * one crashed device.
  */
-void dev_coredumpm(struct device *dev, struct module *owner,
-		   void *data, size_t datalen, gfp_t gfp,
-		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
-				   void *data, size_t datalen),
-		   void (*free)(void *data))
+void dev_coredumpm_bulk(struct device *dev, struct module *owner, gfp_t gfp,
+			struct dev_coredumpm_bulk_data *files, int num_files)
 {
 	static atomic_t devcd_count = ATOMIC_INIT(0);
 	struct devcd_entry *devcd;
 	struct device *existing;
+	int i;
 
 	if (devcd_disabled)
 		goto free;
@@ -272,15 +293,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	if (!try_module_get(owner))
 		goto free;
 
-	devcd = kzalloc(sizeof(*devcd), gfp);
+	devcd = devcd_alloc(files, num_files, gfp);
 	if (!devcd)
 		goto put_module;
 
 	devcd->owner = owner;
-	devcd->data = data;
-	devcd->datalen = datalen;
-	devcd->read = read;
-	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
 
 	device_initialize(&devcd->devcd_dev);
@@ -292,6 +309,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
+	for (i = 0; i < devcd->num_files; i++) {
+		if (device_create_bin_file(&devcd->devcd_dev,
+					   &devcd->files[i].bin_attr))
+			/* nothing - some files will be missing */;
+	}
+
 	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
 			      "failing_device"))
 		/* nothing - symlink will be missing */;
@@ -309,7 +332,41 @@ void dev_coredumpm(struct device *dev, struct module *owner,
  put_module:
 	module_put(owner);
  free:
-	free(data);
+	for (i = 0; i < num_files; i++)
+		files[i].free(files[i].data);
+}
+EXPORT_SYMBOL_GPL(dev_coredumpm_bulk);
+
+/**
+ * dev_coredumpm - create device coredump with read/free methods
+ * @dev: the struct device for the crashed device
+ * @owner: the module that contains the read/free functions, use %THIS_MODULE
+ * @data: data cookie for the @read/@free functions
+ * @datalen: length of the data
+ * @gfp: allocation flags
+ * @read: function to read from the given buffer
+ * @free: function to free the given buffer
+ *
+ * Creates a new device coredump for the given device. If a previous one hasn't
+ * been read yet, the new coredump is discarded. The data lifetime is determined
+ * by the device coredump framework and when it is no longer needed the @free
+ * function will be called to free the data.
+ */
+void dev_coredumpm(struct device *dev, struct module *owner,
+		   void *data, size_t datalen, gfp_t gfp,
+		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
+				   void *data, size_t datalen),
+		   void (*free)(void *data))
+{
+	struct dev_coredumpm_bulk_data bulk_data = {
+		.name = "data",
+		.data = data,
+		.datalen = datalen,
+		.read = read,
+		.free = free,
+	};
+
+	dev_coredumpm_bulk(dev, owner, gfp, &bulk_data, 1);
 }
 EXPORT_SYMBOL_GPL(dev_coredumpm);
 
diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index 269521f..9addb6f 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -65,6 +65,26 @@ static inline void _devcd_free_sgtable(struct scatterlist *table)
 	kfree(delete_iter);
 }
 
+/**
+ * struct dev_coredumpm_bulk_data - Data used for dev_coredumpm_bulk
+ *
+ * @name: coredump file name
+ * @data: data cookie for the @read/@free functions
+ * @datalen: length of the data
+ * @read: function to read from the given buffer
+ * @free: function to free the given buffer
+ *
+ * An array of this structure is passed as argument to dev_coredumpm_bulk, and
+ * used to describe each device coredump.
+ */
+struct dev_coredumpm_bulk_data {
+	char *name;
+	void *data;
+	size_t datalen;
+	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
+			void *data, size_t datalen);
+	void (*free)(void *data);
+};
 
 #ifdef CONFIG_DEV_COREDUMP
 void dev_coredumpv(struct device *dev, void *data, size_t datalen,
@@ -76,6 +96,9 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 				   void *data, size_t datalen),
 		   void (*free)(void *data));
 
+void dev_coredumpm_bulk(struct device *dev, struct module *owner, gfp_t gfp,
+			struct dev_coredumpm_bulk_data *files, int num_files);
+
 void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
 #else
@@ -95,6 +118,16 @@ dev_coredumpm(struct device *dev, struct module *owner,
 	free(data);
 }
 
+static inline
+void dev_coredumpm_bulk(struct device *dev, struct module *owner, gfp_t gfp,
+			struct dev_coredumpm_bulk_data *files, int num_files)
+{
+	int i;
+
+	for (i = 0; i < num_files; i++)
+		files[i].free(files[i].data);
+}
+
 static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 				  size_t datalen, gfp_t gfp)
 {
-- 
2.7.4

