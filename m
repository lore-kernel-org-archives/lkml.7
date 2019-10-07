Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709BECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7ED2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="fZj6LFQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfJGUlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:41:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39313 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:41:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so21240503qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPrA4mIfQ4/hcA3rFsBRZkV6KJobzsJWBCFFuvu9xB0=;
        b=fZj6LFQnphhLC8MMPwhbsOu7esD7t06XT1KXy5JrGkkDHF4TwGJ+8FskswzygBR2bI
         jik91dbConbl0CIfd/y1MIEp7OVtLXb9bWDTTbItGFwlMOLw6Gh+MJJKe5HnsOb6BTWV
         2Weno1pLvAG1rEJ+e3/BrTqoXrMg/esx6Xw/w261AfWgI1U1AY7atTdTbPVUNwP1u3Hv
         gTZQ9Ye25zFyY6kXUscvRd+xqqHLGLksP89dWGH45OEfK88ur3MJSpn/RRF7ufFXi5Ua
         ihVn1VBuGl43bT+csX+IpcmKXpGrAVhkCqbG9OTJ237kmr9p7mAUXmDHMMs8lwigiUN3
         Jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPrA4mIfQ4/hcA3rFsBRZkV6KJobzsJWBCFFuvu9xB0=;
        b=eD1WZwQ8xBNCliP7KK0YoJpzMZXeTXmIH36cfHwId/Y7zZMzVGjDgIfbVaPmiTtsSQ
         pe3XxsvPqXhg+3v+2sCo/donpTTuGitAlgUJFfSDeWlgtio9TeY4yem4MJAxDXW6ZZoR
         jcPzflaS2dPndkYODJVFFyMliv5yMw6ZSvG7RybA78Y61f+JDMuFWmgprNA3WhNLnTlF
         ODIqHlEUSCaB4vPiXQVLD++OHgcHoI51S+BSuw9iW54KifFCHNBOrmoWJsAaP0B6tbgm
         2TjV8G+isJtix7wngoE/VgN3o8/8tDYacMGYvKRv9JSkDv7+suAxX8pYf25CqmcRRI8s
         lcCg==
X-Gm-Message-State: APjAAAWmfPq57GyirVqoBgSxASP/hF9DHOpaHKTBKc8R6JCfU5tvSNTF
        RcHifjY8Xpu7D7CE1ISXi4dFp3T3zgs=
X-Google-Smtp-Source: APXvYqzmRuiSqocNrWzEfULfqRZNpNmIl5GnwaeH3DF4tlFLvEItjzXchjKkHZpKQC2ZCek+oPmQLw==
X-Received: by 2002:ac8:2cdc:: with SMTP id 28mr29646909qtx.212.1570480872908;
        Mon, 07 Oct 2019 13:41:12 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host56-205-dynamic.58-82-r.retail.telecomitalia.it. [82.58.205.56])
        by smtp.gmail.com with ESMTPSA id a11sm7837539qkc.123.2019.10.07.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 13:41:12 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] w1: new driver. DS2430 chip
Date:   Mon,  7 Oct 2019 22:42:23 +0200
Message-Id: <20191007204223.1511867-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot log
...
Driver for 1-wire Dallas network protocol.
w1_master_driver w1_bus_master1:
  Attaching one wire slave 14.00000158556e crc f7

00000000  11 22 33 ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000020

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/w1/slaves/Kconfig     |   8 +
 drivers/w1/slaves/Makefile    |   1 +
 drivers/w1/slaves/w1_ds2430.c | 294 ++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/w1/slaves/w1_ds2430.c

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index ebed495b9e69..e395f5698c43 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -74,6 +74,14 @@ config W1_SLAVE_DS2805
           organized as 7 pages of 16 bytes each with 64bit
           unique number. Requires OverDrive Speed to talk to.
 
+config W1_SLAVE_DS2430
+	tristate "256b EEPROM family support (DS2430)"
+	help
+	  Say Y here if you want to use a 1-wire 256bit EEPROM
+	  family device (DS2430).
+	  This EEPROM is organized as one page of 32 bytes for random
+	  access.
+
 config W1_SLAVE_DS2431
 	tristate "1kb EEPROM family support (DS2431)"
 	help
diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
index 8e9655eaa478..278bcf2a9bfd 100644
--- a/drivers/w1/slaves/Makefile
+++ b/drivers/w1/slaves/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_W1_SLAVE_DS2408)	+= w1_ds2408.o
 obj-$(CONFIG_W1_SLAVE_DS2413)	+= w1_ds2413.o
 obj-$(CONFIG_W1_SLAVE_DS2406)	+= w1_ds2406.o
 obj-$(CONFIG_W1_SLAVE_DS2423)	+= w1_ds2423.o
+obj-$(CONFIG_W1_SLAVE_DS2430)	+= w1_ds2430.o
 obj-$(CONFIG_W1_SLAVE_DS2431)	+= w1_ds2431.o
 obj-$(CONFIG_W1_SLAVE_DS2805)	+= w1_ds2805.o
 obj-$(CONFIG_W1_SLAVE_DS2433)	+= w1_ds2433.o
diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
new file mode 100644
index 000000000000..4586dc7effac
--- /dev/null
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * w1_ds2430.c - w1 family 14 (DS2430) driver
+ **
+ * Copyright (c) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
+ *
+ * Cloned and modified from ds2431
+ * Copyright (c) 2008 Bernhard Weirich <bernhard.weirich@riedel.net>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include <linux/w1.h>
+
+#define W1_EEPROM_DS2430	0x14
+
+#define W1_F14_EEPROM_SIZE	128
+#define W1_F14_PAGE_COUNT	1
+#define W1_F14_PAGE_BITS	5
+#define W1_F14_PAGE_SIZE	(1 << W1_F14_PAGE_BITS)
+#define W1_F14_PAGE_MASK	0x1F
+
+#define W1_F14_SCRATCH_BITS	3
+#define W1_F14_SCRATCH_SIZE	(1 << W1_F14_SCRATCH_BITS)
+#define W1_F14_SCRATCH_MASK	(W1_F14_SCRATCH_SIZE-1)
+
+#define W1_F14_READ_EEPROM	0xF0
+#define W1_F14_WRITE_SCRATCH	0x0F
+#define W1_F14_READ_SCRATCH	0xAA
+#define W1_F14_COPY_SCRATCH	0x55
+
+#define W1_F14_TPROG_MS		11
+#define W1_F14_READ_RETRIES	10
+#define W1_F14_READ_MAXLEN	8
+
+/*
+ * Check the file size bounds and adjusts count as needed.
+ * This would not be needed if the file size didn't reset to 0 after a write.
+ */
+static inline size_t w1_f14_fix_count(loff_t off, size_t count, size_t size)
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
+ * is repeated W1_F14_READ_RETRIES times.
+ *
+ * count must not exceed W1_F14_READ_MAXLEN.
+ */
+static int w1_f14_readblock(struct w1_slave *sl, int off, int count, char *buf)
+{
+	u8 wrbuf[3];
+	u8 cmp[W1_F14_READ_MAXLEN];
+	int tries = W1_F14_READ_RETRIES;
+
+	do {
+		wrbuf[0] = W1_F14_READ_EEPROM;
+		wrbuf[1] = off & 0xff;
+		wrbuf[2] = off >> 8;
+
+		if (w1_reset_select_slave(sl))
+			return -1;
+
+		w1_write_block(sl->master, wrbuf, 3);
+		w1_read_block(sl->master, buf, count);
+
+		if (w1_reset_select_slave(sl))
+			return -1;
+
+		w1_write_block(sl->master, wrbuf, 3);
+		w1_read_block(sl->master, cmp, count);
+
+		if (!memcmp(cmp, buf, count))
+			return 0;
+	} while (--tries);
+
+	dev_err(&sl->dev, "proof reading failed %d times\n",
+			W1_F14_READ_RETRIES);
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
+	count = w1_f14_fix_count(off, count, W1_F14_EEPROM_SIZE);
+	if (count == 0)
+		return 0;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* read directly from the EEPROM in chunks of W1_F14_READ_MAXLEN */
+	while (todo > 0) {
+		int block_read;
+
+		if (todo >= W1_F14_READ_MAXLEN)
+			block_read = W1_F14_READ_MAXLEN;
+		else
+			block_read = todo;
+
+		if (w1_f14_readblock(sl, off, block_read, buf) < 0)
+			count = -EIO;
+
+		todo -= W1_F14_READ_MAXLEN;
+		buf += W1_F14_READ_MAXLEN;
+		off += W1_F14_READ_MAXLEN;
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
+ * The data must be aligned at W1_F14_SCRATCH_SIZE bytes and
+ * must be W1_F14_SCRATCH_SIZE bytes long.
+ * The master must be locked.
+ *
+ * @param sl	The slave structure
+ * @param addr	Address for the write
+ * @param len   length must be <= (W1_F14_PAGE_SIZE - (addr & W1_F14_PAGE_MASK))
+ * @param data	The data to write
+ * @return	0=Success -1=failure
+ */
+static int w1_f14_write(struct w1_slave *sl, int addr, int len, const u8 *data)
+{
+	int tries = W1_F14_READ_RETRIES;
+	u8 wrbuf[4];
+	u8 rdbuf[W1_F14_SCRATCH_SIZE + 3];
+	u8 es = (addr + len - 1) % W1_F14_SCRATCH_SIZE;
+
+retry:
+
+	/* Write the data to the scratchpad */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F14_WRITE_SCRATCH;
+	wrbuf[1] = addr & 0xff;
+	wrbuf[2] = addr >> 8;
+
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_write_block(sl->master, data, len);
+
+	/* Read the scratchpad and verify */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	w1_write_8(sl->master, W1_F14_READ_SCRATCH);
+	w1_read_block(sl->master, rdbuf, len + 3);
+
+	/* Compare what was read against the data written */
+	if ((rdbuf[0] != wrbuf[1]) || (rdbuf[1] != wrbuf[2]) ||
+	    (rdbuf[2] != es) || (memcmp(data, &rdbuf[3], len) != 0)) {
+
+		if (--tries)
+			goto retry;
+
+		dev_err(&sl->dev,
+			"could not write to eeprom, scratchpad compare failed %d times\n",
+			W1_F14_READ_RETRIES);
+
+		return -1;
+	}
+
+	/* Copy the scratchpad to EEPROM */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F14_COPY_SCRATCH;
+	wrbuf[3] = es;
+	w1_write_block(sl->master, wrbuf, 4);
+
+	/* Sleep for tprog ms to wait for the write to complete */
+	msleep(W1_F14_TPROG_MS);
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
+	count = w1_f14_fix_count(off, count, W1_F14_EEPROM_SIZE);
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
+		if (len < W1_F14_SCRATCH_SIZE || addr & W1_F14_SCRATCH_MASK) {
+			char tmp[W1_F14_SCRATCH_SIZE];
+
+			/* read the block and update the parts to be written */
+			if (w1_f14_readblock(sl, addr & ~W1_F14_SCRATCH_MASK,
+					W1_F14_SCRATCH_SIZE, tmp)) {
+				count = -EIO;
+				goto out_up;
+			}
+
+			/* copy at most to the boundary of the PAGE or len */
+			copy = W1_F14_SCRATCH_SIZE -
+				(addr & W1_F14_SCRATCH_MASK);
+
+			if (copy > len)
+				copy = len;
+
+			memcpy(&tmp[addr & W1_F14_SCRATCH_MASK], buf, copy);
+			if (w1_f14_write(sl, addr & ~W1_F14_SCRATCH_MASK,
+					W1_F14_SCRATCH_SIZE, tmp) < 0) {
+				count = -EIO;
+				goto out_up;
+			}
+		} else {
+
+			copy = W1_F14_SCRATCH_SIZE;
+			if (w1_f14_write(sl, addr, copy, buf) < 0) {
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
+static BIN_ATTR_RW(eeprom, W1_F14_EEPROM_SIZE);
+
+static struct bin_attribute *w1_f14_bin_attrs[] = {
+	&bin_attr_eeprom,
+	NULL,
+};
+
+static const struct attribute_group w1_f14_group = {
+	.bin_attrs = w1_f14_bin_attrs,
+};
+
+static const struct attribute_group *w1_f14_groups[] = {
+	&w1_f14_group,
+	NULL,
+};
+
+static struct w1_family_ops w1_f14_fops = {
+	.groups	= w1_f14_groups,
+};
+
+static struct w1_family w1_family_14 = {
+	.fid = W1_EEPROM_DS2430,
+	.fops = &w1_f14_fops,
+};
+module_w1_family(w1_family_14);
+
+MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
+MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256kb EEPROM");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2430));
-- 
2.23.0

