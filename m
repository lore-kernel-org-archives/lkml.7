Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795BD20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="GMmhPS0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCGMx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:53:27 -0500
Received: from mail.nic.cz ([217.31.204.67]:34456 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfCGMxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:53:20 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 4AFCF63410;
        Thu,  7 Mar 2019 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551963195; bh=FbA2fzeP8VZO6hxFh7qYEAludupumW9GiLa3g2Ijte4=;
        h=From:To:Date;
        b=GMmhPS0XBr/NA32ErONEsCCaExdk7hsjQo8LTPkE795cwO+DTWYEEDSI7JhtFaC6T
         /6KUI8F+xusqUvXP/9gmvKfxTGkIWUKJNtSF/6zX4lAru+bof0RmdfW4xERAVAkvjG
         W+ZnWAcQAqDxBfINQllaIVlq9yNJ1G9FeoGpG9Is=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v4 armsoc/drivers/bus+gpio 1/5] bus: Add support for Moxtet bus
Date:   Thu,  7 Mar 2019 13:52:47 +0100
Message-Id: <20190307125251.724-2-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307125251.724-1-marek.behun@nic.cz>
References: <20190307125251.724-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Turris Mox router different modules can be connected to the main
CPU board: currently a module with a SFP cage, a module with MiniPCIe
connector, a PCIe pass-through MiniPCIe connector module, a 4-port
switch module, an 8-port switch module, and a 4-port USB3 module.

For example:
  [CPU]-[PCIe-pass-through]-[PCIe]-[8-port switch]-[8-port switch]-[SFP]

Each of this modules has an input and output shift register, and these
are connected via SPI to the CPU board.

Via SPI we are able to discover which modules are connected, in which
order, and we can also read some information about the modules (eg.
their interrupt status), and configure them.
From each module 8 bits can be read (of which low 4 bits identify the
module) and 8 bits can be written.

For example from the module with a SFP cage we can read the LOS,
TX-FAULT and MOD-DEF0 signals, while we can write TX-DISABLE and
RATE-SELECT signals.

This driver creates a new bus type, called "moxtet". For each Mox module
it finds via SPI, it creates a new device on the moxtet bus so that
drivers can be written for them.

It also implements a virtual interrupt controller for the modules which
send their interrupt status over the SPI shift register. These modules
do this in addition to sending their interrupt status via the shared
interrupt line. When the shared interrupt is triggered, we read from the
shift register and handle IRQs for all devices which are in interrupt.

The topology of how Mox modules are connected can then be read by
listing /sys/bus/moxtet/devices.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 MAINTAINERS                      |   7 +
 drivers/bus/Kconfig              |  10 +
 drivers/bus/Makefile             |   1 +
 drivers/bus/moxtet.c             | 886 +++++++++++++++++++++++++++++++
 include/dt-bindings/bus/moxtet.h |  16 +
 include/linux/moxtet.h           | 109 ++++
 6 files changed, 1029 insertions(+)
 create mode 100644 drivers/bus/moxtet.c
 create mode 100644 include/dt-bindings/bus/moxtet.h
 create mode 100644 include/linux/moxtet.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a419acaa01c5..d96d36c83bc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1498,6 +1498,13 @@ F:	drivers/clocksource/timer-atlas7.c
 N:	[^a-z]sirf
 X:	drivers/gnss
 
+ARM/CZ.NIC TURRIS MOX SUPPORT
+M:	Marek Behun <marek.behun@nic.cz>
+W:	http://mox.turris.cz
+S:	Maintained
+F:	include/linux/moxtet.h
+F:	drivers/bus/moxtet.c
+
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..6b331061d34b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -29,6 +29,16 @@ config BRCMSTB_GISB_ARB
 	  arbiter. This driver provides timeout and target abort error handling
 	  and internal bus master decoding.
 
+config MOXTET
+	tristate "CZ.NIC Turris Mox module configuration bus"
+	depends on SPI_MASTER && OF
+	help
+	  Say yes here to add support for the module configuration bus found
+	  on CZ.NIC's Turris Mox. This is needed for the ability to discover
+	  the order in which the modules are connected and to get/set some of
+	  their settings. For example the GPIOs on Mox SFP module are
+	  configured through this bus.
+
 config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ca300b1914ce..16b43d3468c6 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 
 obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+obj-$(CONFIG_MOXTET)		+= moxtet.o
 
 # DPAA2 fsl-mc bus
 obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
new file mode 100644
index 000000000000..1ee4570e7e17
--- /dev/null
+++ b/drivers/bus/moxtet.c
@@ -0,0 +1,886 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Turris Mox module configuration bus driver
+ *
+ * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ */
+
+#include <dt-bindings/bus/moxtet.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/moxtet.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/spi/spi.h>
+
+/*
+ * @name:	module name for sysfs
+ * @hwirq_base:	base index for IRQ for this module (-1 if no IRQs)
+ * @nirqs:	how many interrupts does the shift register provide
+ * @desc:	module description for kernel log
+ */
+static const struct {
+	const char *name;
+	int hwirq_base;
+	int nirqs;
+	const char *desc;
+} mox_module_table[] = {
+	/* do not change order of this array! */
+	{ NULL,		 0,			0, NULL },
+	{ "sfp",	-1,			0, "MOX D (SFP cage)" },
+	{ "pci",	MOXTET_IRQ_PCI,		1, "MOX B (Mini-PCIe)" },
+	{ "topaz",	MOXTET_IRQ_TOPAZ,	1, "MOX C (4 port switch)" },
+	{ "peridot",	MOXTET_IRQ_PERIDOT(0),	1, "MOX E (8 port switch)" },
+	{ "usb3",	MOXTET_IRQ_USB3,	2, "MOX F (USB 3.0)" },
+	{ "pci-bridge",	-1,			0, "MOX G (Mini-PCIe bridge)" },
+};
+
+static inline bool mox_module_known(unsigned int id)
+{
+	return id >= TURRIS_MOX_MODULE_FIRST && id <= TURRIS_MOX_MODULE_LAST;
+}
+
+static inline const char *mox_module_name(unsigned int id)
+{
+	if (mox_module_known(id))
+		return mox_module_table[id].name;
+	else
+		return "unknown";
+}
+
+#define DEF_MODULE_ATTR(name, fmt, ...)					\
+static ssize_t								\
+module_##name##_show(struct device *dev, struct device_attribute *a,	\
+		     char *buf)						\
+{									\
+	struct moxtet_device *mdev = to_moxtet_device(dev);		\
+	return sprintf(buf, (fmt), __VA_ARGS__);			\
+}									\
+static DEVICE_ATTR_RO(module_##name)
+
+DEF_MODULE_ATTR(id, "0x%x\n", mdev->id);
+DEF_MODULE_ATTR(name, "%s\n", mox_module_name(mdev->id));
+DEF_MODULE_ATTR(description, "%s\n",
+		mox_module_known(mdev->id) ? mox_module_table[mdev->id].desc
+					   : "");
+
+static struct attribute *moxtet_dev_attrs[] = {
+	&dev_attr_module_id.attr,
+	&dev_attr_module_name.attr,
+	&dev_attr_module_description.attr,
+	NULL,
+};
+
+static const struct attribute_group moxtet_dev_group = {
+	.attrs = moxtet_dev_attrs,
+};
+
+static const struct attribute_group *moxtet_dev_groups[] = {
+	&moxtet_dev_group,
+	NULL,
+};
+
+static int moxtet_match(struct device *dev, struct device_driver *drv)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet_driver *tdrv = to_moxtet_driver(drv);
+	const enum turris_mox_module_id *t;
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (!tdrv->id_table)
+		return 0;
+
+	for (t = tdrv->id_table; *t; ++t)
+		if (*t == mdev->id)
+			return 1;
+
+	return 0;
+}
+
+struct bus_type moxtet_bus_type = {
+	.name		= "moxtet",
+	.dev_groups	= moxtet_dev_groups,
+	.match		= moxtet_match,
+};
+EXPORT_SYMBOL_GPL(moxtet_bus_type);
+
+int __moxtet_register_driver(struct module *owner,
+			     struct moxtet_driver *mdrv)
+{
+	mdrv->driver.owner = owner;
+	mdrv->driver.bus = &moxtet_bus_type;
+	return driver_register(&mdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__moxtet_register_driver);
+
+static int moxtet_dev_check(struct device *dev, void *data)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet_device *new_dev = data;
+
+	if (mdev->moxtet == new_dev->moxtet && mdev->id == new_dev->id &&
+	    mdev->idx == new_dev->idx)
+		return -EBUSY;
+	return 0;
+}
+
+static void moxtet_dev_release(struct device *dev)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+
+	put_device(mdev->moxtet->dev);
+	kfree(mdev);
+}
+
+static struct moxtet_device *
+moxtet_alloc_device(struct moxtet *moxtet)
+{
+	struct moxtet_device *dev;
+
+	if (!get_device(moxtet->dev))
+		return NULL;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		put_device(moxtet->dev);
+		return NULL;
+	}
+
+	dev->moxtet = moxtet;
+	dev->dev.parent = moxtet->dev;
+	dev->dev.bus = &moxtet_bus_type;
+	dev->dev.release = moxtet_dev_release;
+
+	device_initialize(&dev->dev);
+
+	return dev;
+}
+
+static int moxtet_add_device(struct moxtet_device *dev)
+{
+	static DEFINE_MUTEX(add_mutex);
+	int ret;
+
+	if (dev->idx >= TURRIS_MOX_MAX_MODULES || dev->id > 0xf)
+		return -EINVAL;
+
+	dev_set_name(&dev->dev, "moxtet-%s.%u", mox_module_name(dev->id),
+		     dev->idx);
+
+	mutex_lock(&add_mutex);
+
+	ret = bus_for_each_dev(&moxtet_bus_type, NULL, dev,
+			       moxtet_dev_check);
+	if (ret)
+		goto done;
+
+	ret = device_add(&dev->dev);
+	if (ret < 0)
+		dev_err(dev->moxtet->dev, "can't add %s, status %d\n",
+			dev_name(dev->moxtet->dev), ret);
+
+done:
+	mutex_unlock(&add_mutex);
+	return ret;
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	if (dev->of_node) {
+		of_node_clear_flag(dev->of_node, OF_POPULATED);
+		of_node_put(dev->of_node);
+	}
+
+	device_unregister(dev);
+
+	return 0;
+}
+
+static struct moxtet_device *
+of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
+{
+	struct moxtet_device *dev;
+	u32 val;
+	int ret;
+
+	dev = moxtet_alloc_device(moxtet);
+	if (!dev) {
+		dev_err(moxtet->dev,
+			"Moxtet device alloc error for %pOF\n", nc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = of_property_read_u32(nc, "reg", &val);
+	if (ret) {
+		dev_err(moxtet->dev, "%pOF has no valid 'reg' property (%d)\n",
+			nc, ret);
+		goto err_put;
+	}
+
+	dev->idx = val;
+
+	if (dev->idx >= TURRIS_MOX_MAX_MODULES) {
+		dev_err(moxtet->dev, "%pOF Moxtet address 0x%x out of range\n",
+			nc, dev->idx);
+		ret = -EINVAL;
+		goto err_put;
+	}
+
+	dev->id = moxtet->modules[dev->idx];
+
+	if (!dev->id) {
+		dev_err(moxtet->dev, "%pOF Moxtet address 0x%x is empty\n", nc,
+			dev->idx);
+		ret = -ENODEV;
+		goto err_put;
+	}
+
+	of_node_get(nc);
+	dev->dev.of_node = nc;
+
+	ret = moxtet_add_device(dev);
+	if (ret) {
+		dev_err(moxtet->dev,
+			"Moxtet device register error for %pOF\n", nc);
+		of_node_put(nc);
+		goto err_put;
+	}
+
+	return dev;
+
+err_put:
+	put_device(&dev->dev);
+	return ERR_PTR(ret);
+}
+
+static void of_register_moxtet_devices(struct moxtet *moxtet)
+{
+	struct moxtet_device *dev;
+	struct device_node *nc;
+
+	if (!moxtet->dev->of_node)
+		return;
+
+	for_each_available_child_of_node(moxtet->dev->of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
+		dev = of_register_moxtet_device(moxtet, nc);
+		if (IS_ERR(dev)) {
+			dev_warn(moxtet->dev,
+				 "Failed to create Moxtet device for %pOF\n",
+				 nc);
+			of_node_clear_flag(nc, OF_POPULATED);
+		}
+	}
+}
+
+static void
+moxtet_register_devices_from_topology(struct moxtet *moxtet)
+{
+	struct moxtet_device *dev;
+	int i, ret;
+
+	for (i = 0; i < moxtet->count; ++i) {
+		dev = moxtet_alloc_device(moxtet);
+		if (!dev) {
+			dev_err(moxtet->dev, "Moxtet device %u alloc error\n",
+				i);
+			continue;
+		}
+
+		dev->idx = i;
+		dev->id = moxtet->modules[i];
+
+		ret = moxtet_add_device(dev);
+		if (ret && ret != -EBUSY) {
+			put_device(&dev->dev);
+			dev_err(moxtet->dev,
+				"Moxtet device %u register error: %i\n", i,
+				ret);
+		}
+	}
+}
+
+/*
+ * @nsame:	how many modules with same id are already in moxtet->modules
+ */
+static int moxtet_set_irq(struct moxtet *moxtet, int idx, int id, int nsame)
+{
+	int i, first;
+	struct moxtet_irqpos *pos;
+
+	first = mox_module_table[id].hwirq_base +
+		nsame * mox_module_table[id].nirqs;
+
+	if (first + mox_module_table[id].nirqs > MOXTET_NIRQS)
+		return -EINVAL;
+
+	for (i = 0; i < mox_module_table[id].nirqs; ++i) {
+		pos = &moxtet->irq.position[first + i];
+		pos->idx = idx;
+		pos->bit = i;
+		moxtet->irq.exists |= BIT(first + i);
+	}
+
+	return 0;
+}
+
+static int moxtet_find_topology(struct moxtet *moxtet)
+{
+	u8 buf[TURRIS_MOX_MAX_MODULES];
+	int cnts[TURRIS_MOX_MODULE_LAST];
+	int i, ret;
+
+	memset(cnts, 0, sizeof(cnts));
+
+	ret = spi_read(to_spi_device(moxtet->dev), buf, TURRIS_MOX_MAX_MODULES);
+	if (ret < 0)
+		return ret;
+
+	if (buf[0] == TURRIS_MOX_CPU_ID_EMMC) {
+		dev_info(moxtet->dev, "Found MOX A (eMMC CPU) module\n");
+	} else if (buf[0] == TURRIS_MOX_CPU_ID_SD) {
+		dev_info(moxtet->dev, "Found MOX A (CPU) module\n");
+	} else {
+		dev_err(moxtet->dev, "Invalid Turris MOX A CPU module 0x%02x\n",
+			buf[0]);
+		return -ENODEV;
+	}
+
+	moxtet->count = 0;
+
+	for (i = 1; i < TURRIS_MOX_MAX_MODULES; ++i) {
+		int id;
+
+		if (buf[i] == 0xff)
+			break;
+
+		id = buf[i] & 0xf;
+
+		moxtet->modules[i-1] = id;
+		++moxtet->count;
+
+		if (mox_module_known(id)) {
+			dev_info(moxtet->dev, "Found %s module\n",
+				 mox_module_table[id].desc);
+
+			if (moxtet_set_irq(moxtet, i-1, id, cnts[id]++) < 0)
+				dev_err(moxtet->dev,
+					"  Cannot set IRQ for module %s\n",
+					mox_module_table[id].desc);
+		} else {
+			dev_warn(moxtet->dev,
+				 "Unknown Moxtet module found (ID 0x%02x)\n",
+				 id);
+		}
+	}
+
+	return 0;
+}
+
+static int moxtet_spi_read(struct moxtet *moxtet, u8 *buf)
+{
+	struct spi_transfer xfer = {
+		.rx_buf = buf,
+		.tx_buf = moxtet->tx,
+		.len = moxtet->count + 1
+	};
+	int ret;
+
+	mutex_lock(&moxtet->lock);
+
+	ret = spi_sync_transfer(to_spi_device(moxtet->dev), &xfer, 1);
+
+	mutex_unlock(&moxtet->lock);
+
+	return ret;
+}
+
+int moxtet_device_read(struct device *dev)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet *moxtet = mdev->moxtet;
+	u8 buf[TURRIS_MOX_MAX_MODULES];
+	int ret;
+
+	if (mdev->idx >= moxtet->count)
+		return -EINVAL;
+
+	ret = moxtet_spi_read(moxtet, buf);
+	if (ret < 0)
+		return ret;
+
+	return buf[mdev->idx + 1] >> 4;
+}
+EXPORT_SYMBOL_GPL(moxtet_device_read);
+
+int moxtet_device_write(struct device *dev, u8 val)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet *moxtet = mdev->moxtet;
+	int ret;
+
+	if (mdev->idx >= moxtet->count)
+		return -EINVAL;
+
+	mutex_lock(&moxtet->lock);
+
+	moxtet->tx[moxtet->count - mdev->idx] = val;
+
+	ret = spi_write(to_spi_device(moxtet->dev), moxtet->tx,
+			moxtet->count + 1);
+
+	mutex_unlock(&moxtet->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(moxtet_device_write);
+
+int moxtet_device_written(struct device *dev)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet *moxtet = mdev->moxtet;
+
+	if (mdev->idx >= moxtet->count)
+		return -EINVAL;
+
+	return moxtet->tx[moxtet->count - mdev->idx];
+}
+EXPORT_SYMBOL_GPL(moxtet_device_written);
+
+#ifdef CONFIG_DEBUG_FS
+static int moxtet_debug_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t input_read(struct file *file, char __user *buf, size_t len,
+			  loff_t *ppos)
+{
+	struct moxtet *moxtet = file->private_data;
+	u8 bin[TURRIS_MOX_MAX_MODULES];
+	u8 hex[sizeof(buf) * 2 + 1];
+	int ret, n;
+
+	ret = moxtet_spi_read(moxtet, bin);
+	if (ret < 0)
+		return ret;
+
+	n = moxtet->count + 1;
+	bin2hex(hex, bin, n);
+
+	hex[2*n] = '\n';
+
+	return simple_read_from_buffer(buf, len, ppos, hex, 2*n + 1);
+}
+
+static const struct file_operations input_fops = {
+	.owner	= THIS_MODULE,
+	.open	= moxtet_debug_open,
+	.read	= input_read,
+	.llseek	= no_llseek,
+};
+
+static ssize_t output_read(struct file *file, char __user *buf, size_t len,
+			   loff_t *ppos)
+{
+	struct moxtet *moxtet = file->private_data;
+	u8 hex[TURRIS_MOX_MAX_MODULES * 2 + 1];
+	u8 *p = hex;
+	int i;
+
+	mutex_lock(&moxtet->lock);
+
+	for (i = 0; i < moxtet->count; ++i)
+		p = hex_byte_pack(p, moxtet->tx[moxtet->count - i]);
+
+	mutex_unlock(&moxtet->lock);
+
+	*p++ = '\n';
+
+	return simple_read_from_buffer(buf, len, ppos, hex, p - hex);
+}
+
+static ssize_t output_write(struct file *file, const char __user *buf,
+			    size_t len, loff_t *ppos)
+{
+	struct moxtet *moxtet = file->private_data;
+	u8 bin[TURRIS_MOX_MAX_MODULES];
+	u8 hex[sizeof(bin) * 2 + 1];
+	size_t res;
+	loff_t dummy = 0;
+	int err, i;
+
+	if (len > 2 * moxtet->count + 1 || len < 2 * moxtet->count)
+		return -EINVAL;
+
+	res = simple_write_to_buffer(hex, sizeof(hex), &dummy, buf, len);
+	if (res < 0)
+		return res;
+
+	if (len % 2 == 1 && hex[len - 1] != '\n')
+		return -EINVAL;
+
+	err = hex2bin(bin, hex, moxtet->count);
+	if (err < 0)
+		return -EINVAL;
+
+	mutex_lock(&moxtet->lock);
+
+	for (i = 0; i < moxtet->count; ++i)
+		moxtet->tx[moxtet->count - i] = bin[i];
+
+	err = spi_write(to_spi_device(moxtet->dev), moxtet->tx,
+			moxtet->count + 1);
+
+	mutex_unlock(&moxtet->lock);
+
+	return err < 0 ? err : len;
+}
+
+static const struct file_operations output_fops = {
+	.owner	= THIS_MODULE,
+	.open	= moxtet_debug_open,
+	.read	= output_read,
+	.write	= output_write,
+	.llseek	= no_llseek,
+};
+
+static int moxtet_register_debugfs(struct moxtet *moxtet)
+{
+	struct dentry *root, *entry;
+
+	root = debugfs_create_dir("moxtet", NULL);
+
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	entry = debugfs_create_file_unsafe("input", 0444, root, moxtet,
+					   &input_fops);
+	if (IS_ERR(entry))
+		goto err_remove;
+
+	entry = debugfs_create_file_unsafe("output", 0644, root, moxtet,
+					   &output_fops);
+	if (IS_ERR(entry))
+		goto err_remove;
+
+	moxtet->debugfs_root = root;
+
+	return 0;
+err_remove:
+	debugfs_remove_recursive(root);
+	return PTR_ERR(entry);
+}
+
+static void moxtet_unregister_debugfs(struct moxtet *moxtet)
+{
+	debugfs_remove_recursive(moxtet->debugfs_root);
+}
+#else
+static inline int moxtet_register_debugfs(struct moxtet *moxtet)
+{
+	return 0;
+}
+
+static inline void moxtet_unregister_debugfs(struct moxtet *moxtet)
+{
+}
+#endif
+
+static int moxtet_irq_domain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hw)
+{
+	struct moxtet *moxtet = d->host_data;
+
+	if (hw >= MOXTET_NIRQS || !(moxtet->irq.exists & BIT(hw))) {
+		dev_err(moxtet->dev, "Invalid hw irq number\n");
+		return -EINVAL;
+	}
+
+	irq_set_chip_data(irq, d->host_data);
+	irq_set_chip_and_handler(irq, &moxtet->irq.chip, handle_level_irq);
+
+	return 0;
+}
+
+static int moxtet_irq_domain_xlate(struct irq_domain *d,
+				   struct device_node *ctrlr,
+				   const u32 *intspec, unsigned int intsize,
+				   unsigned long *out_hwirq,
+				   unsigned int *out_type)
+{
+	struct moxtet *moxtet = d->host_data;
+	int irq;
+
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+
+	irq = intspec[0];
+
+	if (irq >= MOXTET_NIRQS || !(moxtet->irq.exists & BIT(irq)))
+		return -EINVAL;
+
+	*out_hwirq = irq;
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static const struct irq_domain_ops moxtet_irq_domain = {
+	.map = moxtet_irq_domain_map,
+	.xlate = moxtet_irq_domain_xlate,
+};
+
+static void moxtet_irq_mask(struct irq_data *d)
+{
+	struct moxtet *moxtet = irq_data_get_irq_chip_data(d);
+
+	moxtet->irq.masked |= BIT(d->hwirq);
+}
+
+static void moxtet_irq_unmask(struct irq_data *d)
+{
+	struct moxtet *moxtet = irq_data_get_irq_chip_data(d);
+
+	moxtet->irq.masked &= ~BIT(d->hwirq);
+}
+
+static void moxtet_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct moxtet *moxtet = irq_data_get_irq_chip_data(d);
+	struct moxtet_irqpos *pos = &moxtet->irq.position[d->hwirq];
+	int id;
+
+	id = moxtet->modules[pos->idx];
+
+	seq_printf(p, " moxtet-%s.%i#%i", mox_module_name(id), pos->idx,
+		   pos->bit);
+}
+
+static const struct irq_chip moxtet_irq_chip = {
+	.name			= "moxtet",
+	.irq_mask		= moxtet_irq_mask,
+	.irq_unmask		= moxtet_irq_unmask,
+	.irq_print_chip		= moxtet_irq_print_chip,
+};
+
+static int moxtet_irq_read(struct moxtet *moxtet, unsigned long *map)
+{
+	struct moxtet_irqpos *pos = moxtet->irq.position;
+	u8 buf[TURRIS_MOX_MAX_MODULES];
+	int i, ret;
+
+	ret = moxtet_spi_read(moxtet, buf);
+	if (ret < 0)
+		return ret;
+
+	*map = 0;
+
+	for_each_set_bit(i, &moxtet->irq.exists, MOXTET_NIRQS) {
+		if (!(buf[pos[i].idx + 1] & BIT(4 + pos[i].bit)))
+			set_bit(i, map);
+	}
+
+	return 0;
+}
+
+static irqreturn_t moxtet_irq_thread_fn(int irq, void *data)
+{
+	struct moxtet *moxtet = data;
+	unsigned long set;
+	int nhandled = 0, i, sub_irq, ret;
+
+	ret = moxtet_irq_read(moxtet, &set);
+	if (ret < 0)
+		goto out;
+
+	set &= ~moxtet->irq.masked;
+
+	do {
+		for_each_set_bit(i, &set, MOXTET_NIRQS) {
+			sub_irq = irq_find_mapping(moxtet->irq.domain, i);
+			handle_nested_irq(sub_irq);
+			dev_dbg(moxtet->dev, "%i irq\n", i);
+			++nhandled;
+		}
+
+		ret = moxtet_irq_read(moxtet, &set);
+		if (ret < 0)
+			goto out;
+
+		set &= ~moxtet->irq.masked;
+	} while (set);
+
+out:
+	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
+}
+
+static void moxtet_irq_free(struct moxtet *moxtet)
+{
+	int i, irq;
+
+	for (i = 0; i < MOXTET_NIRQS; ++i) {
+		if (moxtet->irq.exists & BIT(i)) {
+			irq = irq_find_mapping(moxtet->irq.domain, i);
+			irq_dispose_mapping(irq);
+		}
+	}
+
+	irq_domain_remove(moxtet->irq.domain);
+}
+
+static int moxtet_irq_setup(struct moxtet *moxtet)
+{
+	int i, ret;
+
+	moxtet->irq.domain = irq_domain_add_simple(moxtet->dev->of_node,
+						   MOXTET_NIRQS, 0,
+						   &moxtet_irq_domain, moxtet);
+	if (moxtet->irq.domain == NULL) {
+		dev_err(moxtet->dev, "Could not add IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < MOXTET_NIRQS; ++i)
+		if (moxtet->irq.exists & BIT(i))
+			irq_create_mapping(moxtet->irq.domain, i);
+
+	moxtet->irq.chip = moxtet_irq_chip;
+	moxtet->irq.masked = ~0;
+
+	ret = request_threaded_irq(moxtet->dev_irq, NULL, moxtet_irq_thread_fn,
+				   IRQF_ONESHOT, "moxtet", moxtet);
+	if (ret < 0)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	moxtet_irq_free(moxtet);
+	return ret;
+}
+
+static int moxtet_probe(struct spi_device *spi)
+{
+	struct moxtet *moxtet;
+	int ret;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	moxtet = devm_kzalloc(&spi->dev, sizeof(struct moxtet),
+			      GFP_KERNEL);
+	if (!moxtet)
+		return -ENOMEM;
+
+	moxtet->dev = &spi->dev;
+	spi_set_drvdata(spi, moxtet);
+
+	mutex_init(&moxtet->lock);
+
+	moxtet->dev_irq = of_irq_get(moxtet->dev->of_node, 0);
+	if (moxtet->dev_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (moxtet->dev_irq <= 0) {
+		dev_err(moxtet->dev, "No IRQ resource found\n");
+		return -ENXIO;
+	}
+
+	ret = moxtet_find_topology(moxtet);
+	if (ret < 0)
+		return ret;
+
+	if (moxtet->irq.exists) {
+		ret = moxtet_irq_setup(moxtet);
+		if (ret < 0)
+			return ret;
+	}
+
+	of_register_moxtet_devices(moxtet);
+	moxtet_register_devices_from_topology(moxtet);
+
+	ret = moxtet_register_debugfs(moxtet);
+	if (ret < 0)
+		dev_warn(moxtet->dev, "Failed creating debugfs entries: %i\n",
+			 ret);
+
+	return 0;
+}
+
+static int moxtet_remove(struct spi_device *spi)
+{
+	struct moxtet *moxtet = spi_get_drvdata(spi);
+	int dummy;
+
+	free_irq(moxtet->dev_irq, moxtet);
+
+	moxtet_irq_free(moxtet);
+
+	moxtet_unregister_debugfs(moxtet);
+
+	dummy = device_for_each_child(moxtet->dev, NULL, __unregister);
+
+	mutex_destroy(&moxtet->lock);
+
+	return 0;
+}
+
+static const struct of_device_id moxtet_dt_ids[] = {
+	{ .compatible = "cznic,moxtet" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, moxtet_dt_ids);
+
+static struct spi_driver moxtet_spi_driver = {
+	.driver = {
+		.name		= "moxtet",
+		.of_match_table = moxtet_dt_ids,
+	},
+	.probe		= moxtet_probe,
+	.remove		= moxtet_remove,
+};
+
+static int __init moxtet_init(void)
+{
+	int ret;
+
+	ret = bus_register(&moxtet_bus_type);
+	if (ret < 0) {
+		pr_err("moxtet bus registration failed: %d\n", ret);
+		goto error;
+	}
+
+	ret = spi_register_driver(&moxtet_spi_driver);
+	if (ret < 0) {
+		pr_err("moxtet spi driver registration failed: %d\n", ret);
+		goto error_bus;
+	}
+
+	return 0;
+
+error_bus:
+	bus_unregister(&moxtet_bus_type);
+error:
+	return ret;
+}
+postcore_initcall_sync(moxtet_init);
+
+static void __exit moxtet_exit(void)
+{
+	spi_unregister_driver(&moxtet_spi_driver);
+	bus_unregister(&moxtet_bus_type);
+}
+module_exit(moxtet_exit);
+
+MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_DESCRIPTION("CZ.NIC's Turris Mox module configuration bus");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/bus/moxtet.h b/include/dt-bindings/bus/moxtet.h
new file mode 100644
index 000000000000..dc9345440ebe
--- /dev/null
+++ b/include/dt-bindings/bus/moxtet.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Constant for device tree bindings for Turris Mox module configuration bus
+ *
+ * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ */
+
+#ifndef _DT_BINDINGS_BUS_MOXTET_H
+#define _DT_BINDINGS_BUS_MOXTET_H
+
+#define MOXTET_IRQ_PCI		0
+#define MOXTET_IRQ_USB3		4
+#define MOXTET_IRQ_PERIDOT(n)	(8 + (n))
+#define MOXTET_IRQ_TOPAZ	12
+
+#endif /* _DT_BINDINGS_BUS_MOXTET_H */
diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
new file mode 100644
index 000000000000..490db6886dcc
--- /dev/null
+++ b/include/linux/moxtet.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Turris Mox module configuration bus driver
+ *
+ * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ */
+
+#ifndef __LINUX_MOXTET_H
+#define __LINUX_MOXTET_H
+
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mutex.h>
+
+#define TURRIS_MOX_MAX_MODULES	10
+
+enum turris_mox_cpu_module_id {
+	TURRIS_MOX_CPU_ID_EMMC	= 0x00,
+	TURRIS_MOX_CPU_ID_SD	= 0x10,
+};
+
+enum turris_mox_module_id {
+	TURRIS_MOX_MODULE_FIRST		= 0x01,
+
+	TURRIS_MOX_MODULE_SFP		= 0x01,
+	TURRIS_MOX_MODULE_PCI		= 0x02,
+	TURRIS_MOX_MODULE_TOPAZ		= 0x03,
+	TURRIS_MOX_MODULE_PERIDOT	= 0x04,
+	TURRIS_MOX_MODULE_USB3		= 0x05,
+	TURRIS_MOX_MODULE_PCI_BRIDGE	= 0x06,
+
+	TURRIS_MOX_MODULE_LAST		= 0x06,
+};
+
+#define MOXTET_NIRQS	16
+
+extern struct bus_type moxtet_type;
+
+struct moxtet {
+	struct device			*dev;
+	struct mutex			lock;
+	u8				modules[TURRIS_MOX_MAX_MODULES];
+	int				count;
+	u8				tx[TURRIS_MOX_MAX_MODULES];
+	int				dev_irq;
+	struct {
+		struct irq_domain	*domain;
+		struct irq_chip		chip;
+		unsigned long		masked, exists;
+		struct moxtet_irqpos {
+					u8 idx;
+					u8 bit;
+		} position[MOXTET_NIRQS];
+	} irq;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry			*debugfs_root;
+#endif
+};
+
+struct moxtet_driver {
+	const enum turris_mox_module_id	*id_table;
+	struct device_driver		driver;
+};
+
+static inline struct moxtet_driver *
+to_moxtet_driver(struct device_driver *drv)
+{
+	if (!drv)
+		return NULL;
+	return container_of(drv, struct moxtet_driver, driver);
+}
+
+extern int __moxtet_register_driver(struct module *owner,
+				    struct moxtet_driver *mdrv);
+
+static inline void moxtet_unregister_driver(struct moxtet_driver *mdrv)
+{
+	if (mdrv)
+		driver_unregister(&mdrv->driver);
+}
+
+#define moxtet_register_driver(driver) \
+	__moxtet_register_driver(THIS_MODULE, driver)
+
+#define module_moxtet_driver(__moxtet_driver) \
+	module_driver(__moxtet_driver, moxtet_register_driver, \
+			moxtet_unregister_driver)
+
+struct moxtet_device {
+	struct device			dev;
+	struct moxtet			*moxtet;
+	enum turris_mox_module_id	id;
+	unsigned int			idx;
+};
+
+extern int moxtet_device_read(struct device *dev);
+extern int moxtet_device_write(struct device *dev, u8 val);
+extern int moxtet_device_written(struct device *dev);
+
+static inline struct moxtet_device *
+to_moxtet_device(struct device *dev)
+{
+	if (!dev)
+		return NULL;
+	return container_of(dev, struct moxtet_device, dev);
+}
+
+#endif /* __LINUX_MOXTET_H */
-- 
2.19.2

