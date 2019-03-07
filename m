Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B541C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5320851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCzCJx7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCGLYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:24:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36626 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfCGLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:24:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so8894090wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rtTkDqCTtbDkRL5PApZnovCWpW8I79VflOeHXNVQ81o=;
        b=DCzCJx7N+kcFOXjehqokRJ+o9BSiWp1FlC/lEGeWsgJrV7Pq13/+VSxRRn/kVxQxsE
         LjnB+8LBjBoh2VT2xLRzk9KOlup6g8WABr5nP66cIigiEflBY2dE3uIHoFe5ga/2HdGz
         slHgHu0CphNheHuOGDHJcEQ/flj9/LDHpLNnPAredWvIjTPU6mmO2/cKiZ8pAgzEJiff
         hsfDVncwcTTWmsTbYdJlJjEhbnqpHTE+1+Ek9B/S8Xyi5jngafmmZPhFdw0lRRw/wQf7
         OSnvnqQPulimPdO1VpAvOdiPOakya3VT799RnVDIycoU79SVatyb1vVfKzB2BplMNkkq
         L6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rtTkDqCTtbDkRL5PApZnovCWpW8I79VflOeHXNVQ81o=;
        b=ro8mwF+6wjmGQ2+Vy0pW2vl0PPNXHNwSqCy3RXtOYEjKw/0l0XSqIhD4y2zzh5SOqX
         g0xiO48HJ5gJKWSPD76ZygJFmi7dghEQpKGQGKsbxNv2OtcSVN/bygkBkTzP9TAoK3xn
         7ICVjCCfR7JhQ1rVusZu0z25utpAlMxVlnbreeoazBZPjuQ4GI0LsZFuGO4D0N7Q5by/
         mzsQ2ImRMsr/HWTGIOWx9x3IEkJ1dlY1YOmnFktpIoanWaxErIuAhjrXiWmjbRVGg81K
         l5PupNxd61jKWyyPbz67panrzUnBE5xF4YjoSoFznY/4XCi+UUp6ewPf4l9HQ0XF3IGq
         JlYQ==
X-Gm-Message-State: APjAAAV0XO97rzIBKf9wMMJZEbt8GIDonLelQOekoD0U6Q8ycIbtI/ej
        BPmPRKZFVyd7ZlSwEChgPvk=
X-Google-Smtp-Source: APXvYqx50gDvZVCN9ZDzQFYz4r3mOSrS6Wq9FfFRhUIRWO1xKEUrMW/5kHSSLdWPx5nrLlpV1iqXlQ==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr5345061wma.112.1551957841589;
        Thu, 07 Mar 2019 03:24:01 -0800 (PST)
Received: from tango-charlie.RL.local ([194.75.40.178])
        by smtp.gmail.com with ESMTPSA id q17sm3576956wrx.38.2019.03.07.03.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 03:24:00 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: [PATCH] w1: add support for MAX31826 digital temperature sensor with 1Kb eeprom
Date:   Thu,  7 Mar 2019 11:23:53 +0000
Message-Id: <1551957833-6357-1-git-send-email-prabhakar.csengg@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch adds support for max31826 temperature sensor with
1Kb eeprom.

the temprature values can be read from file:
/sys/bus/w1/devices/3b-0000003c0cfe/w1_slave

and the eeprom can be read/written from file:
/sys/bus/w1/devices/3b-0000003c0cfe/eeprom

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31826.pdf

 Temperature reading example:
 /sys/bus/w1/devices/3b-0000003c0cfe$ cat w1_slave 
 87 02 ff ff f0 ff ff ff b0 : crc=b0 YES
 87 02 ff ff f0 ff ff ff b0 t=40437

 Reading the eeprom contents:
 /sys/bus/w1/devices/3b-0000003c0cfe$ cat eeprom  | hexdump -Cv                                                                                                                             
 00000000  48 65 6c 6c 6f 20 57 6f  72 6c 64 20 4d 41 78 33  |Hello World MAx3|
 00000010  31 38 32 36 20 74 65 6d  70 65 72 61 74 75 72 65  |1826 temperature|
 00000020  20 73 65 6e 73 6f 72 20  77 69 74 68 20 31 4b 20  | sensor with 1K |
 00000030  65 65 70 72 6f 6d 20 0a  00 00 00 00 00 00 00 00  |eeprom .........|
 00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000080

 drivers/w1/slaves/Kconfig       |   9 +
 drivers/w1/slaves/Makefile      |   1 +
 drivers/w1/slaves/w1_max31826.c | 490 ++++++++++++++++++++++++++++++++++++++++
 drivers/w1/w1_family.h          |   1 +
 4 files changed, 501 insertions(+)
 create mode 100644 drivers/w1/slaves/w1_max31826.c

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index cfe74d0..fcac213 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -132,4 +132,13 @@ config W1_SLAVE_BQ27000
 	  Say Y here if you want to use a hdq
 	  bq27000 slave support.
 
+config W1_SLAVE_MAX31826
+	tristate "MAX31826 slave support"
+	help
+	  If you enable this you will have the MAX31826
+	  chip support.
+
+	  Say Y here if you want to use a 1-wire
+	  digital temperature sensor with 1kb EEPROM
+
 endmenu
diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
index 1e9989a..2b31d99 100644
--- a/drivers/w1/slaves/Makefile
+++ b/drivers/w1/slaves/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_W1_SLAVE_DS2780)	+= w1_ds2780.o
 obj-$(CONFIG_W1_SLAVE_DS2781)	+= w1_ds2781.o
 obj-$(CONFIG_W1_SLAVE_BQ27000)	+= w1_bq27000.o
 obj-$(CONFIG_W1_SLAVE_DS28E04)	+= w1_ds28e04.o
+obj-$(CONFIG_W1_SLAVE_MAX31826)	+= w1_max31826.o
diff --git a/drivers/w1/slaves/w1_max31826.c b/drivers/w1/slaves/w1_max31826.c
new file mode 100644
index 0000000..6ff544b
--- /dev/null
+++ b/drivers/w1/slaves/w1_max31826.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * w1_max31826.c - w1 family 2d (MAX31826) driver
+ *
+ * Copyright (c) 2019 Lad, Prabhakar <prabhakar.csengg@gmail.com>
+ *
+ * Heavily inspired by w1_ds2413 and w1_therm driver from
+ * Bernhard Weirich <bernhard.weirich@riedel.net> and
+ * Evgeniy Polyakov <zbr@ioremap.net>
+ *
+ */
+
+#include <asm/types.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include "../w1.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+
+/* Allow the strong pullup to be disabled, but default to enabled.
+ * If it was disabled a parasite powered device might not get the require
+ * current to do a temperature conversion.  If it is enabled parasite powered
+ * devices have a better chance of getting the current required.
+ * In case the parasite power-detection is not working (seems to be the case
+ * for some DS18S20) the strong pullup can also be forced, regardless of the
+ * power state of the devices.
+ *
+ * Summary of options:
+ * - strong_pullup = 0	Disable strong pullup completely
+ * - strong_pullup = 1	Enable automatic strong pullup detection
+ * - strong_pullup = 2	Force strong pullup
+ */
+static int w1_strong_pullup = 1;
+module_param_named(strong_pullup, w1_strong_pullup, int, 0);
+
+#define W1_F2D_EEPROM_SIZE		128
+#define W1_F2D_PAGE_COUNT		4
+#define W1_F2D_PAGE_BITS		5
+#define W1_F2D_PAGE_SIZE		(1<<W1_F2D_PAGE_BITS)
+#define W1_F2D_PAGE_MASK		0x1F
+
+#define W1_F2D_SCRATCH_BITS  3
+#define W1_F2D_SCRATCH_SIZE  (1<<W1_F2D_SCRATCH_BITS)
+#define W1_F2D_SCRATCH_MASK  (W1_F2D_SCRATCH_SIZE-1)
+
+#define W1_F2D_READ_EEPROM		0xF0
+#define W1_F2D_WRITE_SCRATCH		0x0F
+#define W1_F2D_READ_SCRATCH		0xAA
+#define W1_F2D_COPY_SCRATCH		0x55
+#define W1_F2D_COPY_SCRATCHPAD2_DO	0xA5
+
+
+#define W1_F2D_TPROG_MS			25
+#define W1_F2D_READ_RETRIES		10
+#define W1_F2D_READ_MAXLEN		8
+
+/*
+ * Check the file size bounds and adjusts count as needed.
+ * This would not be needed if the file size didn't reset to 0 after a write.
+ */
+static inline size_t w1_f2d_fix_count(loff_t off, size_t count, size_t size)
+{
+	if (off > size)
+		return 0;
+
+	if ((off + count) > size)
+		return size - off;
+
+	return count;
+}
+
+/*
+ * Read a block from W1 ROM two times and compares the results.
+ * If they are equal they are returned, otherwise the read
+ * is repeated W1_F2D_READ_RETRIES times.
+ *
+ * count must not exceed W1_F2D_READ_MAXLEN.
+ */
+static int w1_f2d_readblock(struct w1_slave *sl, int off, int count, char *buf)
+{
+	u8 wrbuf[3];
+	u8 cmp[W1_F2D_READ_MAXLEN];
+	int tries = W1_F2D_READ_RETRIES;
+
+	do {
+		wrbuf[0] = W1_F2D_READ_EEPROM;
+		wrbuf[1] = off;
+
+		if (w1_reset_select_slave(sl))
+			return -1;
+
+		w1_write_block(sl->master, wrbuf, 2);
+		w1_read_block(sl->master, buf, count);
+
+		if (w1_reset_select_slave(sl))
+			return -1;
+
+		w1_write_block(sl->master, wrbuf, 2);
+		w1_read_block(sl->master, cmp, count);
+
+		if (!memcmp(cmp, buf, count))
+			return 0;
+	} while (--tries);
+
+	dev_err(&sl->dev, "proof reading failed %d times\n",
+			W1_F2D_READ_RETRIES);
+
+	return -1;
+}
+
+static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
+			   struct bin_attribute *bin_attr, char *buf,
+			   loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int todo = count;
+
+	count = w1_f2d_fix_count(off, count, W1_F2D_EEPROM_SIZE);
+	if (count == 0)
+		return 0;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* read directly from the EEPROM in chunks of W1_F2D_READ_MAXLEN */
+	while (todo > 0) {
+		int block_read;
+
+		if (todo >= W1_F2D_READ_MAXLEN)
+			block_read = W1_F2D_READ_MAXLEN;
+		else
+			block_read = todo;
+
+		if (w1_f2d_readblock(sl, off, block_read, buf) < 0)
+			count = -EIO;
+
+		todo -= W1_F2D_READ_MAXLEN;
+		buf += W1_F2D_READ_MAXLEN;
+		off += W1_F2D_READ_MAXLEN;
+	}
+
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return count;
+}
+
+/*
+ * Writes to the scratchpad and reads it back for verification.
+ * Then copies the scratchpad to EEPROM.
+ * The data must be aligned at W1_F2D_SCRATCH_SIZE bytes and
+ * must be W1_F2D_SCRATCH_SIZE bytes long.
+ * The master must be locked.
+ *
+ * @param sl	The slave structure
+ * @param addr	Address for the write
+ * @param len   length must be <= (W1_F2D_PAGE_SIZE - (addr & W1_F2D_PAGE_MASK))
+ * @param data	The data to write
+ * @return	0=Success -1=failure
+ */
+static int w1_f2d_write(struct w1_slave *sl, int addr, int len, const u8 *data)
+{
+	int tries = W1_F2D_READ_RETRIES;
+	u8 rdbuf[W1_F2D_SCRATCH_SIZE + 3];
+	u8 wrbuf[4];
+
+retry:
+	/* Write the data to the scratchpad */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F2D_WRITE_SCRATCH;
+	wrbuf[1] = addr;
+	w1_write_block(sl->master, wrbuf, 2);
+	w1_write_block(sl->master, data, len);
+
+	/* Read the scratchpad and verify */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F2D_READ_SCRATCH;
+	wrbuf[1] = addr;
+	w1_write_block(sl->master, wrbuf, 2);
+	w1_read_block(sl->master, rdbuf, len);
+
+	/* Compare what was read against the data written */
+	if ((memcmp(data, &rdbuf, len) != 0)) {
+		if (--tries)
+			goto retry;
+
+		dev_err(&sl->dev,
+			"could not write to eeprom, scratchpad compare failed %d times\n",
+			W1_F2D_READ_RETRIES);
+
+		return -1;
+	}
+
+	/* Copy the scratchpad to EEPROM */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F2D_COPY_SCRATCH;
+	wrbuf[1] = W1_F2D_COPY_SCRATCHPAD2_DO;
+	w1_write_block(sl->master, wrbuf, 2);
+
+	/* Sleep for tprog ms to wait for the write to complete */
+	msleep(W1_F2D_TPROG_MS);
+
+	/* Reset the bus to wake up the EEPROM  */
+	w1_reset_bus(sl->master);
+
+	return 0;
+}
+
+static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *bin_attr, char *buf,
+			    loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int addr, len;
+	int copy;
+
+	count = w1_f2d_fix_count(off, count, W1_F2D_EEPROM_SIZE);
+	if (count == 0)
+		return 0;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* Can only write data in blocks of the size of the scratchpad */
+	addr = off;
+	len = count;
+	while (len > 0) {
+
+		/* if len too short or addr not aligned */
+		if (len < W1_F2D_SCRATCH_SIZE || addr & W1_F2D_SCRATCH_MASK) {
+			char tmp[W1_F2D_SCRATCH_SIZE];
+
+			/* read the block and update the parts to be written */
+			if (w1_f2d_readblock(sl, addr & ~W1_F2D_SCRATCH_MASK,
+					W1_F2D_SCRATCH_SIZE, tmp)) {
+				count = -EIO;
+				goto out_up;
+			}
+
+			/* copy at most to the boundary of the PAGE or len */
+			copy = W1_F2D_SCRATCH_SIZE -
+				(addr & W1_F2D_SCRATCH_MASK);
+
+			if (copy > len)
+				copy = len;
+
+			memcpy(&tmp, buf, copy);
+			if (w1_f2d_write(sl, addr & ~W1_F2D_SCRATCH_MASK,
+					W1_F2D_SCRATCH_SIZE, tmp) < 0) {
+				count = -EIO;
+				goto out_up;
+			}
+		} else {
+
+			copy = W1_F2D_SCRATCH_SIZE;
+			if (w1_f2d_write(sl, addr, copy, buf) < 0) {
+				count = -EIO;
+				goto out_up;
+			}
+		}
+		buf += copy;
+		addr += copy;
+		len -= copy;
+	}
+
+out_up:
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return count;
+}
+
+struct w1_therm_family_data {
+	uint8_t rom[9];
+	atomic_t refcnt;
+};
+
+/* return the address of the refcnt in the family data */
+#define THERM_REFCNT(family_data) \
+	(&((struct w1_therm_family_data *)family_data)->refcnt)
+
+static int w1_therm_add_slave(struct w1_slave *sl)
+{
+	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
+		GFP_KERNEL);
+	if (!sl->family_data)
+		return -ENOMEM;
+	atomic_set(THERM_REFCNT(sl->family_data), 1);
+	return 0;
+}
+
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+	int refcnt = atomic_sub_return(1, THERM_REFCNT(sl->family_data));
+
+	while (refcnt) {
+		msleep(1000);
+		refcnt = atomic_read(THERM_REFCNT(sl->family_data));
+	}
+	kfree(sl->family_data);
+	sl->family_data = NULL;
+}
+
+#define MILLIDEGREES_C		(1000 / 16)
+
+static inline int w1_convert_temp(u8 rom[9])
+{
+	s16 t = le16_to_cpup((__le16 *)rom);
+
+	return t * MILLIDEGREES_C;
+}
+
+static ssize_t w1_slave_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	struct w1_master *dev = sl->master;
+	u8 rom[9], crc, verdict, external_power;
+	int i, ret, max_trying = 10;
+	ssize_t c = PAGE_SIZE;
+	u8 *family_data = sl->family_data;
+
+	ret = mutex_lock_interruptible(&dev->bus_mutex);
+	if (ret != 0)
+		goto post_unlock;
+
+	if (!sl->family_data) {
+		ret = -ENODEV;
+		goto pre_unlock;
+	}
+
+	/* prevent the slave from going away in sleep */
+	atomic_inc(THERM_REFCNT(family_data));
+	memset(rom, 0, sizeof(rom));
+
+	while (max_trying--) {
+
+		verdict = 0;
+		crc = 0;
+
+		if (!w1_reset_select_slave(sl)) {
+			int count = 0;
+			unsigned int tm = 750;
+			unsigned long sleep_rem;
+
+			w1_write_8(dev, W1_READ_PSUPPLY);
+			external_power = w1_read_8(dev);
+
+			if (w1_reset_select_slave(sl))
+				continue;
+
+			/* 750ms strong pullup (or delay) after the convert */
+			if (w1_strong_pullup == 2 ||
+					(!external_power && w1_strong_pullup))
+				w1_next_pullup(dev, tm);
+
+			w1_write_8(dev, W1_CONVERT_TEMP);
+
+			if (external_power) {
+				mutex_unlock(&dev->bus_mutex);
+
+				sleep_rem = msleep_interruptible(tm);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto post_unlock;
+				}
+
+				ret = mutex_lock_interruptible(&dev->bus_mutex);
+				if (ret != 0)
+					goto post_unlock;
+			} else if (!w1_strong_pullup) {
+				sleep_rem = msleep_interruptible(tm);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto pre_unlock;
+				}
+			}
+
+			if (!w1_reset_select_slave(sl)) {
+
+				w1_write_8(dev, W1_READ_SCRATCHPAD);
+				count = w1_read_block(dev, rom, 9);
+				if (count != 9) {
+					dev_warn(device,
+						 "w1_read_block() returned %u instead of 9.\n",
+						count);
+				}
+
+				crc = w1_calc_crc8(rom, 8);
+
+				if (rom[8] == crc)
+					verdict = 1;
+			}
+		}
+
+		if (verdict)
+			break;
+	}
+
+	for (i = 0; i < 9; ++i)
+		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ", rom[i]);
+	c -= snprintf(buf + PAGE_SIZE - c, c, ": crc=%02x %s\n",
+			   crc, (verdict) ? "YES" : "NO");
+	if (verdict)
+		memcpy(family_data, rom, sizeof(rom));
+	else
+		dev_warn(device, "Read failed CRC check\n");
+
+	for (i = 0; i < 9; ++i)
+		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ",
+			      ((u8 *)family_data)[i]);
+
+	c -= snprintf(buf + PAGE_SIZE - c, c, "t=%d\n",
+		w1_convert_temp(rom));
+	ret = PAGE_SIZE - c;
+
+pre_unlock:
+	mutex_unlock(&dev->bus_mutex);
+
+post_unlock:
+	atomic_dec(THERM_REFCNT(family_data));
+	return ret;
+}
+
+static DEVICE_ATTR_RO(w1_slave);
+
+static struct attribute *w1_therm_attrs[] = {
+	&dev_attr_w1_slave.attr,
+	NULL,
+};
+static const struct attribute_group w1_therm_group = {
+	.attrs = w1_therm_attrs,
+};
+
+static BIN_ATTR_RW(eeprom, W1_F2D_EEPROM_SIZE);
+
+static struct bin_attribute *w1_f2d_bin_attrs[] = {
+	&bin_attr_eeprom,
+	NULL,
+};
+
+static const struct attribute_group w1_f2d_group = {
+	.bin_attrs = w1_f2d_bin_attrs,
+};
+
+static const struct attribute_group *w1_f2d_groups[] = {
+	&w1_f2d_group,
+	&w1_therm_group,
+	NULL,
+};
+
+static struct w1_family_ops w1_f2d_fops = {
+	.add_slave	= w1_therm_add_slave,
+	.remove_slave	= w1_therm_remove_slave,
+	.groups		= w1_f2d_groups,
+};
+
+
+static struct w1_family w1_family_2d = {
+	.fid = W1_FAMILY_MAX31826,
+	.fops = &w1_f2d_fops,
+};
+
+static int __init w1_f2d_init(void)
+{
+	return w1_register_family(&w1_family_2d);
+}
+
+static void __exit w1_f2d_fini(void)
+{
+	w1_unregister_family(&w1_family_2d);
+}
+
+module_init(w1_f2d_init);
+module_exit(w1_f2d_fini);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Lad, Prabhakar <prabhakar.csengg@gmail.com>");
+MODULE_DESCRIPTION("w1 family 2d driver for MAX31826, Digital Temperature Sensor with 1kb EEPROM");
+MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_MAX31826));
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
index ed5dcb8..47243b8 100644
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -43,6 +43,7 @@
 #define W1_FAMILY_DS2413	0x3A
 #define W1_FAMILY_DS2406	0x12
 #define W1_THERM_DS1825		0x3B
+#define W1_FAMILY_MAX31826	0x3B
 #define W1_FAMILY_DS2781	0x3D
 #define W1_THERM_DS28EA00	0x42
 
-- 
2.7.4

