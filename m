Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F6CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E07C21D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="xKpDBmuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJSUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 16:38:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41398 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfJSUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 16:38:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so9656344wrm.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBR1v7uBP8kmkRpFM2O2jzmU259Bc51m37VOsHKjHgM=;
        b=xKpDBmuFx7Zhe4CMamLMWEFYpG8SLs/75BQv+lbsN1JF54va6GsPl2s9f7X2y+cV3N
         Wi77NJh0aklZrKnEoph69paQolSYOMe7nVUn2L8TCz/7pUiz8+q6ER/G4tBZ9qG6eHoB
         jjWSfB+hK/YiIhuof2X4IiB97BqnDZavWG7S5Up3EsUlI5VD2ea0gTTCeMpw5qWQ+ztf
         IJt7yLsSUcxEvRzCwwlu7adhqQDOp7SpJokClu4b/YTeVt0vevNJJvqs+kVsHx73T1RY
         qU5X+UloiU40zNffZ79WIAoOQyAzcYHQRRAJLjRMX8WzghXQAlSjpgnmuhp9y+tCsR3S
         IIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBR1v7uBP8kmkRpFM2O2jzmU259Bc51m37VOsHKjHgM=;
        b=i3bHFW5pNhUys7kNwdC+2OZ6XZyDx1e8aP9155mv8WVJtWC6FVxH/cv/94JKG0E6vy
         SMvBMFwo1pwmjPTEpJznT79kqVmvJLew509It7gEWjIe32pgBeBOnJCIs8avnZ6/UGgT
         NIJ0YVd6zzDCwwhkDvt4zsSvW7sfUg4/iKzEe2HsYMx/ExIzlHdAwXtA0r45yWkcUYrO
         bTyHWj+ENT4CCrDjSgghVpEyDapTHnsFSq66/+AjHw4bLzWsQ/Hr50dTSdetHsGQFTA0
         vr0wBKggURKyF0M2sznH9W2RPf7wE/w90DYS/1HZi47bH4hNtKEwioXlmV5sT3Q3OXWb
         bWSA==
X-Gm-Message-State: APjAAAX0bVirgebJSh3gVKQGP8EdrPYd13qfj85SbH0R5yEvKLIc6Isz
        wmUSM9XRON1HRFBDauL1zL8qWcuN8RQ=
X-Google-Smtp-Source: APXvYqwHbvCohong2u0QmxlcCbCQn7gm9epWMgVOyIG1gJ5IQ9xIaOvoJMZuCeL5j5/YM0vOJBSVcw==
X-Received: by 2002:adf:f447:: with SMTP id f7mr8758659wrp.210.1571517529380;
        Sat, 19 Oct 2019 13:38:49 -0700 (PDT)
Received: from localhost.localdomain (host44-4-dynamic.8-87-r.retail.telecomitalia.it. [87.8.4.44])
        by smtp.gmail.com with ESMTPSA id f6sm7633573wrm.61.2019.10.19.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 13:38:48 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     zbr@ioremap.net, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH v2] w1: new driver. DS2430 chip
Date:   Sat, 19 Oct 2019 22:40:15 +0200
Message-Id: <20191019204015.61474-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for ds2430, 1 page, 256bit (32bytes) eeprom
(family 0x14).

Tests done:

32 bytes dump:

x@y:~# hexdump -C -n 32 /sys/bus/w1/devices/14-00000158556e/eeprom
00000000  39 39 0a 00 00 36 0a ff  ff ff ff ff ff ff ff ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000020

34 bytes dump: 32 only displayed

x@y:~# hexdump -C -n 34 /sys/bus/w1/devices/14-00000158556e/eeprom
00000000  39 39 0a 00 00 36 0a ff  ff ff ff ff ff ff ff ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000020

pattern write:

x@y:~# echo 123456789 > /sys/bus/w1/devices/14-00000158556e/eeprom
x@y:~# hexdump -C -n 54 /sys/bus/w1/devices/14-00000158556e/eeprom
00000000  31 32 33 34 35 36 37 38  39 0a ff ff ff ff ff ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000020

specific address 1-byte write

x@y:~# dd if=/dev/zero of=/sys/bus/w1/devices/14-00000158556e/eeprom \
		count=1 bs=1 seek=4
1+0 records in
1+0 records out
x@y:~# hexdump -C -n 54 /sys/bus/w1/devices/14-00000158556e/eeprom
00000000  31 32 33 34 00 36 37 38  39 0a ff ff ff ff ff ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000020

writing binary block

x@y:~# cat dump-128bytes.bin > /sys/bus/w1/devices/14-00000158556e/eeprom
cat: write error: File too large

x@y:~# cat dump-32bytes.bin > /sys/bus/w1/devices/14-00000158556e/eeprom
x@y:~# hexdump -C -n 54 /sys/bus/w1/devices/14-00000158556e/eeprom
00000000  10 0b 5b ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff 40
00000020

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/w1/slaves/Kconfig     |   8 +
 drivers/w1/slaves/Makefile    |   1 +
 drivers/w1/slaves/w1_ds2430.c | 295 ++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/w1/slaves/w1_ds2430.c

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index b7847636501d..687753889c34 100644
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
index 000000000000..6fb0563fb2ae
--- /dev/null
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -0,0 +1,295 @@
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
+#define W1_F14_EEPROM_SIZE	32
+#define W1_F14_PAGE_COUNT	1
+#define W1_F14_PAGE_BITS	5
+#define W1_F14_PAGE_SIZE	(1 << W1_F14_PAGE_BITS)
+#define W1_F14_PAGE_MASK	0x1F
+
+#define W1_F14_SCRATCH_BITS	5
+#define W1_F14_SCRATCH_SIZE	(1 << W1_F14_SCRATCH_BITS)
+#define W1_F14_SCRATCH_MASK	(W1_F14_SCRATCH_SIZE-1)
+
+#define W1_F14_READ_EEPROM	0xF0
+#define W1_F14_WRITE_SCRATCH	0x0F
+#define W1_F14_READ_SCRATCH	0xAA
+#define W1_F14_COPY_SCRATCH	0x55
+#define W1_F14_VALIDATION_KEY	0xa5
+
+#define W1_F14_TPROG_MS		11
+#define W1_F14_READ_RETRIES	10
+#define W1_F14_READ_MAXLEN	W1_F14_SCRATCH_SIZE
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
+	u8 wrbuf[2];
+	u8 cmp[W1_F14_READ_MAXLEN];
+	int tries = W1_F14_READ_RETRIES;
+
+	do {
+		wrbuf[0] = W1_F14_READ_EEPROM;
+		wrbuf[1] = off & 0xff;
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
+	u8 wrbuf[2];
+	u8 rdbuf[W1_F14_SCRATCH_SIZE + 3];
+
+retry:
+
+	/* Write the data to the scratchpad */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] = W1_F14_WRITE_SCRATCH;
+	wrbuf[1] = addr & 0xff;
+
+	w1_write_block(sl->master, wrbuf, 2);
+	w1_write_block(sl->master, data, len);
+
+	/* Read the scratchpad and verify */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	w1_write_8(sl->master, W1_F14_READ_SCRATCH);
+	w1_read_block(sl->master, rdbuf, len + 2);
+
+	/*
+	 * Compare what was read against the data written
+	 * Note: on read scratchpad, device returns 2 bulk 0xff bytes,
+	 * to be discarded.
+	 */
+	if ((memcmp(data, &rdbuf[2], len) != 0)) {
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
+	wrbuf[1] = W1_F14_VALIDATION_KEY;
+	w1_write_block(sl->master, wrbuf, 2);
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

