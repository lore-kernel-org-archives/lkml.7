Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCFDCA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBACB222C1
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUG/0FD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbfKEHSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:18:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34840 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387567AbfKEHSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:18:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so14504443pfq.2;
        Mon, 04 Nov 2019 23:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=C3V4q8Hphd3d9zZDUmVOsx50l1MD7niZTtsL+eJD5Xk=;
        b=pUG/0FD5lCFtTdXCgxqI4lo5/O/mgY/aD8EIT5edKtpPwr5U+n7tOaXHOUCNre9cPs
         hNVhellWuDPlz6Lse9Axfa4kXVnDRj4DiWW14fPpcSKX93Ywy1n9w44jDDdfKMBJociO
         btB8nIs4TLLcpdxteBijGwN1c5YadKV1lm0BUc7AU+8b9giEB+UjXdz3sKZ7gmeET6Wm
         QMABkeyXHn4SXOvj+odqkX9KcQM9qhUIElAXyKCBsFHbLUGpM4XyMox0NWbqKEuDCBKt
         CagnRkLOc5rIxp7P4v1ItUsZgmZG/SW0GejRxGPTFQwMzo9R0u8YRH7fC5KcNd2IpPwq
         rpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C3V4q8Hphd3d9zZDUmVOsx50l1MD7niZTtsL+eJD5Xk=;
        b=cnaPMMSRBYGe+/TaarHXhh51eqitgirxYdN5eRp3EMnj41zeFFks0RpTWK+KVinVXn
         OCMu9qbR6nzTJFHKo+HBSxbdsekSbwne11DBnc2YZ9qZH4ugERj8f4ipPbxTJuIz3FFe
         QE2dhxjiBOCaHQdLyfIGgDJJRmtVb7ZkqxRi2L+rN8tZJDdL+LMOCTDyL7xUz2zb4tt+
         O7aPrRTogo23Giam5Kv7W3EFoUDppkNUTOm3cKbo0rnH08qONlsUb8Zd77W5njvb/e0/
         ilySAnf5Nc3ZxvhrOKulSq5SnnuKqiqiOYoiskNURACjXxtVbOLE4PnFfDH7HlN3TSJN
         tvtQ==
X-Gm-Message-State: APjAAAUHteGfbDLIc/7A5dTAcxz5g7QyKpQzgwUo6Q9HG2EBAtMPWnLH
        isUHZVvqKCup05wY/apwiPh5NRDqJvcyuA==
X-Google-Smtp-Source: APXvYqzOvn/ex1lQYcl1oh+qsjmUqHpXF3lcZ5ByMaJRPk750mwe/kzcRhzeoUa4RXNdPneAoVkrzA==
X-Received: by 2002:a17:90a:326b:: with SMTP id k98mr4580647pjb.50.1572938330201;
        Mon, 04 Nov 2019 23:18:50 -0800 (PST)
Received: from localhost ([2402:3a80:680:8b3a:2a4c:218c:b0b3:eada])
        by smtp.gmail.com with ESMTPSA id w24sm6929812pfn.136.2019.11.04.23.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 23:18:49 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:48:46 +0530
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, mchehab+samsung@kernel.org, christian@brauner.io,
        neilb@suse.com, willy@infradead.org,
        jaskaransingh7654321@gmail.com, tobin@kernel.org,
        stefanha@redhat.com, hofrat@osadl.org, gregkh@linuxfoundation.org,
        jeffrey.t.kirsher@intel.com, linux-doc@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH][RESEND] docs: filesystems: sysfs: convert sysfs.txt to reST
Message-ID: <20191105071846.GA28727@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts sysfs.txt to sysfs.rst, and adds a corresponding
entry in index.rst.

Most of the whitespacing and indentation is kept similar to the
original document.

Changes to the original document include:

 - Adding an authors statement in the header.
 - Replacing the underscores in the title with asterisks. This is so
   that the "The" in the title appears in italics in HTML.
 - Replacing the tilde (~) headings with equal signs, for reST section
   headings.
 - List out the helper macros with backquotes and corresponding description
   on the next line.
 - Placing C code and shell code in reST code blocks, with an indentation
   of an 8 length tab.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{sysfs.txt => sysfs.rst}      | 323 ++++++++++--------
 2 files changed, 189 insertions(+), 135 deletions(-)
 rename Documentation/filesystems/{sysfs.txt => sysfs.rst} (60%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 2c3a9f761205..18b5ea780b9b 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -46,4 +46,5 @@ Documentation for filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
+   sysfs
    virtiofs
diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.rst
similarity index 60%
rename from Documentation/filesystems/sysfs.txt
rename to Documentation/filesystems/sysfs.rst
index ddf15b1b0d5a..de0de5869323 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.rst
@@ -1,15 +1,18 @@
+======================================================
+sysfs - *The* filesystem for exporting kernel objects.
+======================================================
 
-sysfs - _The_ filesystem for exporting kernel objects. 
+Authors:
 
-Patrick Mochel	<mochel@osdl.org>
-Mike Murphy <mamurph@cs.clemson.edu>
+- Patrick Mochel	<mochel@osdl.org>
+- Mike Murphy   	<mamurph@cs.clemson.edu>
 
-Revised:    16 August 2011
-Original:   10 January 2003
+| Revised:    16 August 2011
+| Original:   10 January 2003
 
 
 What it is:
-~~~~~~~~~~~
+===========
 
 sysfs is a ram-based filesystem initially based on ramfs. It provides
 a means to export kernel data structures, their attributes, and the 
@@ -21,16 +24,18 @@ interface.
 
 
 Using sysfs
-~~~~~~~~~~~
+===========
 
 sysfs is always compiled in if CONFIG_SYSFS is defined. You can access
 it by doing:
 
-    mount -t sysfs sysfs /sys 
+.. code-block:: sh
+
+	mount -t sysfs sysfs /sys
 
 
 Directory Creation
-~~~~~~~~~~~~~~~~~~
+==================
 
 For every kobject that is registered with the system, a directory is
 created for it in sysfs. That directory is created as a subdirectory
@@ -48,7 +53,7 @@ only modified directly by the function sysfs_schedule_callback().
 
 
 Attributes
-~~~~~~~~~~
+==========
 
 Attributes can be exported for kobjects in the form of regular files in
 the filesystem. Sysfs forwards file I/O operations to methods defined
@@ -67,15 +72,16 @@ you publicly humiliated and your code rewritten without notice.
 
 An attribute definition is simply:
 
-struct attribute {
-        char                    * name;
-        struct module		*owner;
-        umode_t                 mode;
-};
+.. code-block:: c
 
+	struct attribute {
+		char                    * name;
+		struct module		*owner;
+		umode_t                 mode;
+	};
 
-int sysfs_create_file(struct kobject * kobj, const struct attribute * attr);
-void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr);
+	int sysfs_create_file(struct kobject * kobj, const struct attribute * attr);
+	void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr);
 
 
 A bare attribute contains no means to read or write the value of the
@@ -85,36 +91,44 @@ a specific object type.
 
 For example, the driver model defines struct device_attribute like:
 
-struct device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count);
-};
+.. code-block:: c
+
+	struct device_attribute {
+		struct attribute	attr;
+		ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+				char *buf);
+		ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count);
+	};
 
-int device_create_file(struct device *, const struct device_attribute *);
-void device_remove_file(struct device *, const struct device_attribute *);
+	int device_create_file(struct device *, const struct device_attribute *);
+	void device_remove_file(struct device *, const struct device_attribute *);
 
 It also defines this helper for defining device attributes: 
 
-#define DEVICE_ATTR(_name, _mode, _show, _store) \
-struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
+.. code-block:: c
+
+	#define DEVICE_ATTR(_name, _mode, _show, _store) \
+	struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
 
 For example, declaring
 
-static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo);
+.. code-block:: c
+
+	static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo);
 
 is equivalent to doing:
 
-static struct device_attribute dev_attr_foo = {
-	.attr = {
-		.name = "foo",
-		.mode = S_IWUSR | S_IRUGO,
-	},
-	.show = show_foo,
-	.store = store_foo,
-};
+.. code-block:: c
+
+	static struct device_attribute dev_attr_foo = {
+		.attr = {
+			.name = "foo",
+			.mode = S_IWUSR | S_IRUGO,
+		},
+		.show = show_foo,
+		.store = store_foo,
+	};
 
 Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
 considered a bad idea." so trying to set a sysfs file writable for
@@ -124,31 +138,45 @@ For the common cases sysfs.h provides convenience macros to make
 defining attributes easier as well as making code more concise and
 readable. The above case could be shortened to:
 
-static struct device_attribute dev_attr_foo = __ATTR_RW(foo);
+.. code-block:: c
+
+	static struct device_attribute dev_attr_foo = __ATTR_RW(foo);
 
 the list of helpers available to define your wrapper function is:
-__ATTR_RO(name): assumes default name_show and mode 0444
-__ATTR_WO(name): assumes a name_store only and is restricted to mode
-                 0200 that is root write access only.
-__ATTR_RO_MODE(name, mode): fore more restrictive RO access currently
-                 only use case is the EFI System Resource Table
-                 (see drivers/firmware/efi/esrt.c)
-__ATTR_RW(name): assumes default name_show, name_store and setting
-                 mode to 0644.
-__ATTR_NULL: which sets the name to NULL and is used as end of list
-                 indicator (see: kernel/workqueue.c)
+
+``__ATTR_RO(name)``
+	assumes default name_show and mode 0444
+
+``__ATTR_WO(name)``
+	assumes a name_store only and is restricted to mode
+	0200 that is root write access only.
+
+``__ATTR_RO_MODE(name, mode)``
+	for more restrictive RO access currently
+	only use case is the EFI System Resource Table
+	(see drivers/firmware/efi/esrt.c)
+
+``__ATTR_RW(name)``
+	assumes default name_show, name_store and setting
+	mode to 0644.
+
+``__ATTR_NULL``
+	which sets the name to NULL and is used as end of list
+	indicator (see: kernel/workqueue.c)
 
 Subsystem-Specific Callbacks
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+============================
 
 When a subsystem defines a new attribute type, it must implement a
 set of sysfs operations for forwarding read and write calls to the
 show and store methods of the attribute owners. 
 
-struct sysfs_ops {
-        ssize_t (*show)(struct kobject *, struct attribute *, char *);
-        ssize_t (*store)(struct kobject *, struct attribute *, const char *, size_t);
-};
+.. code-block:: c
+
+	struct sysfs_ops {
+		ssize_t (*show)(struct kobject *, struct attribute *, char *);
+		ssize_t (*store)(struct kobject *, struct attribute *, const char *, size_t);
+	};
 
 [ Subsystems should have already defined a struct kobj_type as a
 descriptor for this type, which is where the sysfs_ops pointer is
@@ -162,37 +190,41 @@ calls the associated methods.
 
 To illustrate:
 
-#define to_dev(obj) container_of(obj, struct device, kobj)
-#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
+.. code-block:: c
 
-static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
-                             char *buf)
-{
-        struct device_attribute *dev_attr = to_dev_attr(attr);
-        struct device *dev = to_dev(kobj);
-        ssize_t ret = -EIO;
+	#define to_dev(obj) container_of(obj, struct device, kobj)
+	#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
-        if (dev_attr->show)
-                ret = dev_attr->show(dev, dev_attr, buf);
-        if (ret >= (ssize_t)PAGE_SIZE) {
-                printk("dev_attr_show: %pS returned bad count\n",
-                                dev_attr->show);
-        }
-        return ret;
-}
+	static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
+	                             char *buf)
+	{
+		struct device_attribute *dev_attr = to_dev_attr(attr);
+		struct device *dev = to_dev(kobj);
+		ssize_t ret = -EIO;
+
+		if (dev_attr->show)
+			ret = dev_attr->show(dev, dev_attr, buf);
+		if (ret >= (ssize_t)PAGE_SIZE) {
+			printk("dev_attr_show: %pS returned bad count\n",
+	                                dev_attr->show);
+	        }
+	        return ret;
+	}
 
 
 
 Reading/Writing Attribute Data
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==============================
 
 To read or write attributes, show() or store() methods must be
 specified when declaring the attribute. The method types should be as
 simple as those defined for device attributes:
 
-ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf);
-ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-                 const char *buf, size_t count);
+.. code-block:: c
+
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
 
 IOW, they should take only an object, an attribute, and a buffer as parameters.
 
@@ -253,21 +285,23 @@ Other notes:
 
 A very simple (and naive) implementation of a device attribute is:
 
-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
-                         char *buf)
-{
-	return scnprintf(buf, PAGE_SIZE, "%s\n", dev->name);
-}
+.. code-block:: c
 
-static ssize_t store_name(struct device *dev, struct device_attribute *attr,
-                          const char *buf, size_t count)
-{
-        snprintf(dev->name, sizeof(dev->name), "%.*s",
-                 (int)min(count, sizeof(dev->name) - 1), buf);
-	return count;
-}
+	static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+	{
+		return scnprintf(buf, PAGE_SIZE, "%s\n", dev->name);
+	}
 
-static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
+	static ssize_t store_name(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+	{
+	        snprintf(dev->name, sizeof(dev->name), "%.*s",
+	                 (int)min(count, sizeof(dev->name) - 1), buf);
+		return count;
+	}
+
+	static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
 
 
 (Note that the real implementation doesn't allow userspace to set the 
@@ -275,28 +309,28 @@ name for a device.)
 
 
 Top Level Directory Layout
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+==========================
 
 The sysfs directory arrangement exposes the relationship of kernel
 data structures. 
 
-The top level sysfs directory looks like:
+The top level sysfs directory looks like: ::
 
-block/
-bus/
-class/
-dev/
-devices/
-firmware/
-net/
-fs/
+  block/
+  bus/
+  class/
+  dev/
+  devices/
+  firmware/
+  net/
+  fs/
 
 devices/ contains a filesystem representation of the device tree. It maps
 directly to the internal kernel device tree, which is a hierarchy of
 struct device. 
 
 bus/ contains flat directory layout of the various bus types in the
-kernel. Each bus's directory contains two subdirectories:
+kernel. Each bus's directory contains two subdirectories: ::
 
 	devices/
 	drivers/
@@ -326,80 +360,99 @@ TODO: Finish this section.
 
 
 Current Interfaces
-~~~~~~~~~~~~~~~~~~
+==================
 
 The following interface layers currently exist in sysfs:
 
 
-- devices (include/linux/device.h)
-----------------------------------
+devices (include/linux/device.h)
+--------------------------------
 Structure:
 
-struct device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count);
-};
+.. code-block:: c
+
+	struct device_attribute {
+		struct attribute	attr;
+		ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+	                   	char *buf);
+		ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count);
+	};
 
 Declaring:
 
-DEVICE_ATTR(_name, _mode, _show, _store);
+.. code-block:: c
+
+	DEVICE_ATTR(_name, _mode, _show, _store);
 
 Creation/Removal:
 
-int device_create_file(struct device *dev, const struct device_attribute * attr);
-void device_remove_file(struct device *dev, const struct device_attribute * attr);
+.. code-block:: c
+
+	int device_create_file(struct device *dev, const struct device_attribute * attr);
+	void device_remove_file(struct device *dev, const struct device_attribute * attr);
 
 
-- bus drivers (include/linux/device.h)
---------------------------------------
+bus drivers (include/linux/device.h)
+------------------------------------
+
 Structure:
 
-struct bus_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct bus_type *, char * buf);
-        ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
-};
+.. code-block:: c
+
+	struct bus_attribute {
+	        struct attribute        attr;
+	        ssize_t (*show)(struct bus_type *, char * buf);
+	        ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
+	};
 
 Declaring:
 
-static BUS_ATTR_RW(name);
-static BUS_ATTR_RO(name);
-static BUS_ATTR_WO(name);
+.. code-block:: c
+
+	static BUS_ATTR_RW(name);
+	static BUS_ATTR_RO(name);
+	static BUS_ATTR_WO(name);
 
 Creation/Removal:
 
-int bus_create_file(struct bus_type *, struct bus_attribute *);
-void bus_remove_file(struct bus_type *, struct bus_attribute *);
+.. code-block:: c
+
+	int bus_create_file(struct bus_type *, struct bus_attribute *);
+	void bus_remove_file(struct bus_type *, struct bus_attribute *);
 
 
-- device drivers (include/linux/device.h)
------------------------------------------
+device drivers (include/linux/device.h)
+---------------------------------------
 
 Structure:
 
-struct driver_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device_driver *, char * buf);
-        ssize_t (*store)(struct device_driver *, const char * buf,
-                         size_t count);
-};
+.. code-block:: c
+
+	struct driver_attribute {
+	        struct attribute        attr;
+	        ssize_t (*show)(struct device_driver *, char * buf);
+	        ssize_t (*store)(struct device_driver *, const char * buf,
+	                         size_t count);
+	};
 
 Declaring:
 
-DRIVER_ATTR_RO(_name)
-DRIVER_ATTR_RW(_name)
+.. code-block:: c
+
+	DRIVER_ATTR_RO(_name)
+	DRIVER_ATTR_RW(_name)
 
 Creation/Removal:
 
-int driver_create_file(struct device_driver *, const struct driver_attribute *);
-void driver_remove_file(struct device_driver *, const struct driver_attribute *);
+.. code-block:: c
+
+	int driver_create_file(struct device_driver *, const struct driver_attribute *);
+	void driver_remove_file(struct device_driver *, const struct driver_attribute *);
 
 
 Documentation
-~~~~~~~~~~~~~
+=============
 
 The sysfs directory structure and the attributes in each directory define an
 ABI between the kernel and user space. As for any ABI, it is important that
-- 
2.21.0

