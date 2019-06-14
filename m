Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A303CC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F949206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfFNEe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:34:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNEe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:34:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2BCF3260D64
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, ncrews@chromium.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4] platform/chrome: cros_ec_lpc: Choose Microchip EC at runtime
Date:   Fri, 14 Jun 2019 06:34:17 +0200
Message-Id: <20190614043417.6661-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On many boards, communication between the kernel and the Embedded
Controller happens over an LPC bus. In these cases, the kernel config
CONFIG_CROS_EC_LPC is enabled. Some of these LPC boards contain a
Microchip Embedded Controller (MEC) that is different from the regular
EC. On these devices, the same LPC bus is used, but the protocol is
a little different. In these cases, the CONFIG_CROS_EC_LPC_MEC kernel
config is enabled. Currently, the kernel decides at compile-time whether
or not to use the MEC variant, and, when that kernel option is selected
it breaks the other boards. We would like a kind of runtime detection to
avoid this.

This patch adds that detection mechanism by probing the protocol at
runtime, first we assume that a MEC variant is connected, and if the
protocol fails it fallbacks to the regular EC. This adds a bit of
overload because we try to read twice on those LPC boards that doesn't
contain a MEC variant, but is a better solution than having to select the
EC variant at compile-time.

While here also fix the alignment in Kconfig file for this config option
replacing the spaces by tabs.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Tested-by: Nick Crews <ncrews@chromium.org>
---
Hi,

This is another attempt to solve the issue to be able to select at
runtime the CrOS MEC variant. My first thought was check for a device
ID, the MEC1322 has a register that contains the device ID, however I
am not sure if we can read that register from the host without
modifying the firmware. Also, I am not sure if the MEC1322 is the only
device used that supports that LPC protocol variant, so I ended with a
more easy solution, check if the protocol fails or not. Some background
on this issue can be found [1] and [2]

The patch has been tested on:
 - Acer Chromebook R11 (Cyan - MEC variant)
 - Pixel Chromebook 2015 (Samus - non-MEC variant)
 - Dell Chromebook 11 (Wolf - non-MEC variant)
 - Toshiba Chromebook (Leon - non-MEC variant)

Best regards,
 Enric

[1] https://bugs.chromium.org/p/chromium/issues/detail?id=932626
[2] https://chromium-review.googlesource.com/c/chromiumos/overlays/chromiumos-overlay/+/1474254

Changes in v4:
- Change the logic to test the protocols as suggested by Nick Crews.
- Add the proper cros_ec_lpc_mec.h include. (Nick Crews)
- Fix some const and missing casts. (Nick Crews)
- Clean up related doc-strings. (Nick Crews)

Changes in v3:
- Kconfig: Split across multiple lines to keep it under 80 characters.
- Improve kernel-doc as suggested by Nick Crews.
- Convert msg in write function to const.
- Add rb and tb tags.

Changes in v2:
- Remove global bool to indicate the kind of variant as suggested by Ezequiel.
- Create an internal operations struct to allow different variants.

 drivers/platform/chrome/Kconfig           | 29 +++------
 drivers/platform/chrome/Makefile          |  2 +-
 drivers/platform/chrome/cros_ec_lpc.c     | 78 ++++++++++++++++-------
 drivers/platform/chrome/cros_ec_lpc_mec.h | 14 ++++
 drivers/platform/chrome/cros_ec_lpc_reg.c | 41 ++++--------
 drivers/platform/chrome/cros_ec_lpc_reg.h | 23 +++----
 drivers/platform/chrome/wilco_ec/Kconfig  |  2 +-
 7 files changed, 98 insertions(+), 91 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 2826f7136f65..453e69733842 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -83,28 +83,17 @@ config CROS_EC_SPI
 	  'pre-amble' bytes before the response actually starts.
 
 config CROS_EC_LPC
-        tristate "ChromeOS Embedded Controller (LPC)"
-        depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
-        help
-          If you say Y here, you get support for talking to the ChromeOS EC
-          over an LPC bus. This uses a simple byte-level protocol with a
-          checksum. This is used for userspace access only. The kernel
-          typically has its own communication methods.
-
-          To compile this driver as a module, choose M here: the
-          module will be called cros_ec_lpc.
-
-config CROS_EC_LPC_MEC
-	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
-	depends on CROS_EC_LPC
-	default n
+	tristate "ChromeOS Embedded Controller (LPC)"
+	depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
 	help
-	  If you say Y here, a variant LPC protocol for the Microchip EC
-	  will be used. Note that this variant is not backward compatible
-	  with non-Microchip ECs.
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  over an LPC bus, including the LPC Microchip EC (MEC) variant.
+	  This uses a simple byte-level protocol with a checksum. This is
+	  used for userspace access only. The kernel typically has its own
+	  communication methods.
 
-	  If you have a ChromeOS Embedded Controller Microchip EC variant
-	  choose Y here.
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_lpcs.
 
 config CROS_EC_PROTO
         bool
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 1b2f1dcfcd5c..da9aa08d9fa6 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
-cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
+cros_ec_lpcs-objs			+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index c9c240fbe7c6..d6ba6b464abc 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -23,11 +23,29 @@
 #include <linux/printk.h>
 #include <linux/suspend.h>
 
+#include "cros_ec_lpc_mec.h"
 #include "cros_ec_lpc_reg.h"
 
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
 
+/**
+ * struct lpc_driver_ops - LPC driver operations
+ * @read: Copy length bytes from EC address offset into buffer dest. Returns
+ *        the 8-bit checksum of all bytes read.
+ * @write: Copy length bytes from buffer msg into EC address offset. Returns
+ *         the 8-bit checksum of all bytes written.
+ */
+struct lpc_driver_ops {
+	u8 (*read)(unsigned int offset, unsigned int length, u8 *dest);
+	u8 (*write)(unsigned int offset, unsigned int length, const u8 *msg);
+};
+
+static struct lpc_driver_ops cros_ec_lpc_ops = {
+	.read	= cros_ec_lpc_mec_read_bytes,
+	.write	= cros_ec_lpc_mec_write_bytes,
+};
+
 /* True if ACPI device is present */
 static bool cros_ec_lpc_acpi_device_found;
 
@@ -38,7 +56,7 @@ static int ec_response_timed_out(void)
 
 	usleep_range(200, 300);
 	do {
-		if (!(cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_CMD, 1, &data) &
+		if (!(cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_CMD, 1, &data) &
 		    EC_LPC_STATUS_BUSY_MASK))
 			return 0;
 		usleep_range(100, 200);
@@ -58,11 +76,11 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 	ret = cros_ec_prepare_tx(ec, msg);
 
 	/* Write buffer */
-	cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
+	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
 
 	/* Here we go */
 	sum = EC_COMMAND_PROTOCOL_3;
-	cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
+	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
 
 	if (ec_response_timed_out()) {
 		dev_warn(ec->dev, "EC responsed timed out\n");
@@ -71,15 +89,15 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 	}
 
 	/* Check result */
-	msg->result = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_DATA, 1, &sum);
+	msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
 	ret = cros_ec_check_result(ec, msg);
 	if (ret)
 		goto done;
 
 	/* Read back response */
 	dout = (u8 *)&response;
-	sum = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
-				     dout);
+	sum = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
+				   dout);
 
 	msg->result = response.result;
 
@@ -92,9 +110,9 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 	}
 
 	/* Read response and process checksum */
-	sum += cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PACKET +
-				      sizeof(response), response.data_len,
-				      msg->data);
+	sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET +
+				    sizeof(response), response.data_len,
+				    msg->data);
 
 	if (sum) {
 		dev_err(ec->dev,
@@ -134,17 +152,17 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
 	sum = msg->command + args.flags + args.command_version + args.data_size;
 
 	/* Copy data and update checksum */
-	sum += cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
-				       msg->data);
+	sum += cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
+				     msg->data);
 
 	/* Finalize checksum and write args */
 	args.checksum = sum;
-	cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
-				(u8 *)&args);
+	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
+			      (u8 *)&args);
 
 	/* Here we go */
 	sum = msg->command;
-	cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
+	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
 
 	if (ec_response_timed_out()) {
 		dev_warn(ec->dev, "EC responsed timed out\n");
@@ -153,14 +171,13 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
 	}
 
 	/* Check result */
-	msg->result = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_DATA, 1, &sum);
+	msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
 	ret = cros_ec_check_result(ec, msg);
 	if (ret)
 		goto done;
 
 	/* Read back args */
-	cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
-			       (u8 *)&args);
+	cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_ARGS, sizeof(args), (u8 *)&args);
 
 	if (args.data_size > msg->insize) {
 		dev_err(ec->dev,
@@ -174,8 +191,8 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
 	sum = msg->command + args.flags + args.command_version + args.data_size;
 
 	/* Read response and update checksum */
-	sum += cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PARAM, args.data_size,
-				      msg->data);
+	sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
+				    msg->data);
 
 	/* Verify checksum */
 	if (args.checksum != sum) {
@@ -205,13 +222,13 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
 
 	/* fixed length */
 	if (bytes) {
-		cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + offset, bytes, s);
+		cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + offset, bytes, s);
 		return bytes;
 	}
 
 	/* string */
 	for (; i < EC_MEMMAP_SIZE; i++, s++) {
-		cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + i, 1, s);
+		cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + i, 1, s);
 		cnt++;
 		if (!*s)
 			break;
@@ -248,10 +265,23 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
+	/*
+	 * Read the mapped ID twice, the first one is assuming the
+	 * EC is a Microchip Embedded Controller (MEC) variant, if the
+	 * protocol fails, fallback to the non MEC variant and try to
+	 * read again the ID.
+	 */
+	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
 	if (buf[0] != 'E' || buf[1] != 'C') {
-		dev_err(dev, "EC ID not detected\n");
-		return -ENODEV;
+		/* Re-assign read/write operations for the non MEC variant */
+		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
+		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
+		cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2,
+				     buf);
+		if (buf[0] != 'E' || buf[1] != 'C') {
+			dev_err(dev, "EC ID not detected\n");
+			return -ENODEV;
+		}
 	}
 
 	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
index aa1018f6b0f2..fcaabdbb5e62 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -76,4 +76,18 @@ int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length);
 u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 			    unsigned int offset, unsigned int length, u8 *buf);
 
+/*
+ * An instance of the read function of struct lpc_driver_ops, used for the
+ * MEC variant of LPC EC.
+ */
+u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
+			      u8 *dest);
+
+/*
+ * An instance of the write function of struct lpc_driver_ops, used for the
+ * MEC variant of LPC EC.
+ */
+u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
+			       const u8 *msg);
+
 #endif /* __CROS_EC_LPC_MEC_H */
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
index 0f5cd0ac8b49..3bfeb5ad59ba 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.c
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
@@ -9,7 +9,7 @@
 
 #include "cros_ec_lpc_mec.h"
 
-static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
+u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
 {
 	int i;
 	int sum = 0;
@@ -23,7 +23,8 @@ static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
 	return sum;
 }
 
-static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
+u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
+			   const u8 *msg)
 {
 	int i;
 	int sum = 0;
@@ -37,9 +38,9 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
 	return sum;
 }
 
-#ifdef CONFIG_CROS_EC_LPC_MEC
 
-u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
+u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
+			      u8 *dest)
 {
 	int in_range = cros_ec_lpc_mec_in_range(offset, length);
 
@@ -50,10 +51,12 @@ u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
 		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
 					 offset - EC_HOST_CMD_REGION0,
 					 length, dest) :
-		lpc_read_bytes(offset, length, dest);
+		cros_ec_lpc_read_bytes(offset, length, dest);
+
 }
 
-u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
+u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
+			       const u8 *msg)
 {
 	int in_range = cros_ec_lpc_mec_in_range(offset, length);
 
@@ -63,8 +66,8 @@ u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
 	return in_range ?
 		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
 					 offset - EC_HOST_CMD_REGION0,
-					 length, msg) :
-		lpc_write_bytes(offset, length, msg);
+					 length, (u8 *)msg) :
+		cros_ec_lpc_write_bytes(offset, length, msg);
 }
 
 void cros_ec_lpc_reg_init(void)
@@ -77,25 +80,3 @@ void cros_ec_lpc_reg_destroy(void)
 {
 	cros_ec_lpc_mec_destroy();
 }
-
-#else /* CONFIG_CROS_EC_LPC_MEC */
-
-u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
-{
-	return lpc_read_bytes(offset, length, dest);
-}
-
-u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
-{
-	return lpc_write_bytes(offset, length, msg);
-}
-
-void cros_ec_lpc_reg_init(void)
-{
-}
-
-void cros_ec_lpc_reg_destroy(void)
-{
-}
-
-#endif /* CONFIG_CROS_EC_LPC_MEC */
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.h b/drivers/platform/chrome/cros_ec_lpc_reg.h
index 416fd2572182..f12115293e47 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.h
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.h
@@ -8,25 +8,18 @@
 #ifndef __CROS_EC_LPC_REG_H
 #define __CROS_EC_LPC_REG_H
 
-/**
- * cros_ec_lpc_read_bytes - Read bytes from a given LPC-mapped address.
- * Returns 8-bit checksum of all bytes read.
- *
- * @offset: Base read address
- * @length: Number of bytes to read
- * @dest: Destination buffer
+/*
+ * A generic instance of the read function of struct lpc_driver_ops, used for
+ * the LPC EC.
  */
 u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest);
 
-/**
- * cros_ec_lpc_write_bytes - Write bytes to a given LPC-mapped address.
- * Returns 8-bit checksum of all bytes written.
- *
- * @offset: Base write address
- * @length: Number of bytes to write
- * @msg: Write data buffer
+/*
+ * A generic instance of the write function of struct lpc_driver_ops, used for
+ * the LPC EC.
  */
-u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg);
+u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
+			   const u8 *msg);
 
 /**
  * cros_ec_lpc_reg_init
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index fd29cbfd3d5d..c63ff2508409 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config WILCO_EC
 	tristate "ChromeOS Wilco Embedded Controller"
-	depends on ACPI && X86 && CROS_EC_LPC && CROS_EC_LPC_MEC
+	depends on ACPI && X86 && CROS_EC_LPC
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
 	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
-- 
2.20.1

