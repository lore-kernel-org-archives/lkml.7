Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B102C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78F20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D5SdTRYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfDOTU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:20:27 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57352 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfDOTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:20:24 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C502D10C12A7;
        Mon, 15 Apr 2019 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555356023; bh=XE5KlxeBcaMGeU9oOTfynmEvKq//ui0hxk9gOzVB3Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=D5SdTRYtiO+kOXffAiHnBKZq2L2kxq2xUsZz2li1FdjcplgyPTEd87I7TlhHCMk89
         tqcxVSlTmzqztL9wh7KaRnvGR0EBlKh75QCm69HOA8Rflgzig2ITRMyJZo0l7GivuD
         cB4HBTR4ipiiywbnE8V/Mpl/RvkcugKqWz8U+sUEI0bqTofQl3g4T2e5rAfIenL6i0
         77tvlptykrj34xf9WpfKQHk3CybxmrBgZ+FdxJeOSuNnSY0JvMJgPu5R5RpCWzS3I9
         ga1zt1udot3FD/PfqZElz3YjPNrS/GpRNqeSUTPpyPIjP8WEs6UfscVGNxoRVZhUnG
         mZM3b+zqwalYw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id DAA0B546A;
        Mon, 15 Apr 2019 12:19:50 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de,
        jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com, Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH 1/3] remap: Add I3C bus support
Date:   Mon, 15 Apr 2019 21:19:39 +0200
Message-Id: <c38e3cb9e8524af58c995a9cf1f79ddba69b47b4.1555354268.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for I3C bus.
This is a simple implementation that only give support
for Read and Write commands.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/base/regmap/Kconfig      |  6 +++-
 drivers/base/regmap/Makefile     |  1 +
 drivers/base/regmap/regmap-i3c.c | 62 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           | 20 +++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef4..c8bbf53 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,7 +4,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_I3C)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	bool
 
@@ -49,3 +49,7 @@ config REGMAP_SOUNDWIRE
 config REGMAP_SCCB
 	tristate
 	depends on I2C
+
+config REGMAP_I3C
+	tristate
+	depends on I3C
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index f5b4e88..ff6c7d8 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
 obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
 obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
+obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/regmap-i3c.c
new file mode 100644
index 0000000..565997b
--- /dev/null
+++ b/drivers/base/regmap/regmap-i3c.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#include <linux/regmap.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/module.h>
+
+static int regmap_i3c_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct i3c_device *i3c = dev_to_i3cdev(dev);
+	struct i3c_priv_xfer xfers[] = {
+		{
+			.rnw = false,
+			.len = count,
+			.data.out = data,
+		},
+	};
+
+	return i3c_device_do_priv_xfers(i3c, xfers, 1);
+}
+
+static int regmap_i3c_read(void *context,
+			   const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i3c_device *i3c = dev_to_i3cdev(dev);
+	struct i3c_priv_xfer xfers[2];
+
+	xfers[0].rnw = false;
+	xfers[0].len = reg_size;
+	xfers[0].data.out = reg;
+
+	xfers[1].rnw = true;
+	xfers[1].len = val_size;
+	xfers[1].data.in = val;
+
+	return i3c_device_do_priv_xfers(i3c, xfers, 2);
+}
+
+static struct regmap_bus regmap_i3c = {
+	.write = regmap_i3c_write,
+	.read = regmap_i3c_read,
+};
+
+struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
+{
+	return __devm_regmap_init(&i3c->dev, &regmap_i3c, &i3c->dev, config,
+				  lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_i3c);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index daeec7d..f65984d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -25,6 +25,7 @@ struct module;
 struct clk;
 struct device;
 struct i2c_client;
+struct i3c_device;
 struct irq_domain;
 struct slim_device;
 struct spi_device;
@@ -624,6 +625,10 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
  * for each call. No-op if CONFIG_LOCKDEP is not set.
@@ -982,6 +987,21 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 #define devm_regmap_init_slimbus(slimbus, config)			\
 	__regmap_lockdep_wrapper(__devm_regmap_init_slimbus, #config,	\
 				slimbus, config)
+
+/**
+ * devm_regmap_init_i3c() - Initialise managed register map
+ *
+ * @i3c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_i3c(i3c, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_i3c, #config,	\
+				i3c, config)
+
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
-- 
2.7.4

