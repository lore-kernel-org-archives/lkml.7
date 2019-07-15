Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5870EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE5220665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXwUD3Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbfGOVVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:21:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfGOVVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:21:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so8326895pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGFluWUQeb793ccUxoO6ykF17I/3PMOKAprht6pktCA=;
        b=GXwUD3QyEOJ7ZBkCF0Zx941tElovhC9DV/IATPb5vNCddy+uoY4yrMsVqR0mc6aJ1F
         pyyXJ7meZvI62jetvtbNvpLSW0vtifZ6VmL15I167aaWx2GZwQr3KihyQcPeqPUs+6Jk
         EDIYe42ts24rF0V2po0vUpRFGdAXMmrXgwoCm5d+JeDFVVHGnQykJffcZOEn3XONYr+q
         3kx2h9oeA/4m5lwoa8xA/ThuuMF3A4ThlcYJzD1P/qCUZHGFntSQLtyJqK9JtpAo8AKc
         wnZY2sr4CFAGuyCrw4ZSRlrRmFXQnujaXYgJbbmo0FZtamiUk/lSYLER5b8Uyvmigh3Q
         xsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGFluWUQeb793ccUxoO6ykF17I/3PMOKAprht6pktCA=;
        b=l5Hwco1pTCO1rknQ+MX5EtxyM2cziSypXBykVgZFtIheGcETj0eX/3mgcENnDdiRQh
         7UZtLH7iunOl4cMYRXXoYEp9vFBNdF5y501uNbbRAFRJ+ereaxKSiIzKsjma0ULFWRSC
         qj0z1LQB9TOFrQuFxETjirLFFL4sxmAtTzMU+q3Ly2DIJfes6SEiFhsi3MaTO1wU+IaM
         tvmTlLZmJipSyaF9QUZl0lnO9eUVCTU/FQwAcQ/nlhRkNYGRkmt1IiaFkTGN4pZOpUOO
         /19je4HbuulQ57qMQRYPC3/BTbQlBwlcubHoeBXLteIeu9O9dZp4RkDMGA5N43dBLV0d
         fAew==
X-Gm-Message-State: APjAAAXLEtB2N6UU0e99Iryp9dcHlwMQ0Nugz2s44f2W7+ELRt24xH5i
        w7PLgrIBWpZLuyj7xtaSG+k=
X-Google-Smtp-Source: APXvYqzr7FFs4XOG9IxHqCbJ7k5U3D26E1PwxhgFTd8zgOUqjHdm4oLfH4cGEV+zzYhNgWW602aHZw==
X-Received: by 2002:a63:2744:: with SMTP id n65mr16404275pgn.277.1563225688177;
        Mon, 15 Jul 2019 14:21:28 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b6sm16820322pgq.26.2019.07.15.14.21.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 14:21:27 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Geordan Neukum <gneukum1@gmail.com>,
        Jeremy Sowden <jeremy@azazel.net>,
        Vandana BN <bnvandana@gmail.com>, devel@driverdev.osuosl.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH] staging: kpc2000: whitespace and line length cleanup
Date:   Mon, 15 Jul 2019 14:21:23 -0700
Message-Id: <20190715212123.432-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715212123.432-1-jhubbard@nvidia.com>
References: <20190715212123.432-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This commit was created by running indent(1):
    `indent -linux`

...and then applying some manual corrections and
cleanup afterward, to keep it sane. No functional changes
were made.

In addition to whitespace changes, some strings were split,
but not strings that were likely to be a grep problem
(in other words, if a user is likely to grep for a string
within the driver, that should still work in most cases).

A few "void * foo" cases were fixed to be "void *foo".

That was enough to make checkpatch.pl run without errors,
although note that there are lots of serious warnings
remaining--but those require functional, not just whitespace
changes. So those are left for a separate patch.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Sandström <simon@nikanor.nu>
Cc: Geordan Neukum <gneukum1@gmail.com>
Cc: Jeremy Sowden <jeremy@azazel.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Vandana BN <bnvandana@gmail.com>
Cc: devel@driverdev.osuosl.org
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c         | 189 +++++++++++------
 drivers/staging/kpc2000/kpc2000_spi.c         | 116 +++++-----
 drivers/staging/kpc2000/kpc_dma/dma.c         | 109 ++++++----
 drivers/staging/kpc2000/kpc_dma/fileops.c     | 199 +++++++++++-------
 .../staging/kpc2000/kpc_dma/kpc_dma_driver.c  | 113 +++++-----
 .../staging/kpc2000/kpc_dma/kpc_dma_driver.h  | 156 +++++++-------
 6 files changed, 509 insertions(+), 373 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index b108da4ac633..93fa1858f6b5 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -33,9 +33,9 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@Daktronics.com");
 
 struct i2c_device {
-	unsigned long           smba;
-	struct i2c_adapter      adapter;
-	unsigned int            features;
+	unsigned long		smba;
+	struct i2c_adapter	adapter;
+	unsigned int		features;
 };
 
 /*****************************
@@ -52,9 +52,9 @@ struct i2c_device {
 #define SMBHSTDAT0(p)   ((5  * REG_SIZE) + (p)->smba)
 #define SMBHSTDAT1(p)   ((6  * REG_SIZE) + (p)->smba)
 #define SMBBLKDAT(p)    ((7  * REG_SIZE) + (p)->smba)
-#define SMBPEC(p)       ((8  * REG_SIZE) + (p)->smba)   /* ICH3 and later */
-#define SMBAUXSTS(p)    ((12 * REG_SIZE) + (p)->smba)   /* ICH4 and later */
-#define SMBAUXCTL(p)    ((13 * REG_SIZE) + (p)->smba)   /* ICH4 and later */
+#define SMBPEC(p)       ((8  * REG_SIZE) + (p)->smba)	/* ICH3 and later */
+#define SMBAUXSTS(p)    ((12 * REG_SIZE) + (p)->smba)	/* ICH4 and later */
+#define SMBAUXCTL(p)    ((13 * REG_SIZE) + (p)->smba)	/* ICH4 and later */
 
 /* PCI Address Constants */
 #define SMBBAR      4
@@ -74,20 +74,20 @@ struct i2c_device {
 
 /* Other settings */
 #define MAX_RETRIES         400
-#define ENABLE_INT9         0       /* set to 0x01 to enable - untested */
+#define ENABLE_INT9         0	/* set to 0x01 to enable - untested */
 
 /* I801 command constants */
 #define I801_QUICK              0x00
 #define I801_BYTE               0x04
 #define I801_BYTE_DATA          0x08
 #define I801_WORD_DATA          0x0C
-#define I801_PROC_CALL          0x10    /* unimplemented */
+#define I801_PROC_CALL          0x10	/* unimplemented */
 #define I801_BLOCK_DATA         0x14
-#define I801_I2C_BLOCK_DATA     0x18    /* ICH5 and later */
+#define I801_I2C_BLOCK_DATA     0x18	/* ICH5 and later */
 #define I801_BLOCK_LAST         0x34
-#define I801_I2C_BLOCK_LAST     0x38    /* ICH5 and later */
+#define I801_I2C_BLOCK_LAST     0x38	/* ICH5 and later */
 #define I801_START              0x40
-#define I801_PEC_EN             0x80    /* ICH3 and later */
+#define I801_PEC_EN             0x80	/* ICH3 and later */
 
 /* I801 Hosts Status register bits */
 #define SMBHSTSTS_BYTE_DONE     0x80
@@ -99,7 +99,9 @@ struct i2c_device {
 #define SMBHSTSTS_INTR          0x02
 #define SMBHSTSTS_HOST_BUSY     0x01
 
-#define STATUS_FLAGS        (SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | SMBHSTSTS_INTR)
+#define STATUS_FLAGS \
+	(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
+	 SMBHSTSTS_DEV_ERR | SMBHSTSTS_INTR)
 
 /* Older devices have their ID defined in <linux/pci_ids.h> */
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS       0x1c22
@@ -136,17 +138,21 @@ static int i801_check_pre(struct i2c_device *priv)
 
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_HOST_BUSY) {
-		dev_err(&priv->adapter.dev, "SMBus is busy, can't use it! (status=%x)\n", status);
+		dev_err(&priv->adapter.dev,
+			"SMBus is busy, can't use it! (status=%x)\n", status);
 		return -EBUSY;
 	}
 
 	status &= STATUS_FLAGS;
 	if (status) {
-		//dev_dbg(&priv->adapter.dev, "Clearing status flags (%02x)\n", status);
+		//dev_dbg(&priv->adapter.dev,
+		//"Clearing status flags (%02x)\n", status);
 		outb_p(status, SMBHSTSTS(priv));
 		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status) {
-			dev_err(&priv->adapter.dev, "Failed clearing status flags (%02x)\n", status);
+			dev_err(&priv->adapter.dev,
+				"Failed clearing status flags (%02x)\n",
+				status);
 			return -EBUSY;
 		}
 	}
@@ -162,15 +168,20 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 	if (timeout) {
 		dev_err(&priv->adapter.dev, "Transaction timeout\n");
 		/* try to stop the current command */
-		dev_dbg(&priv->adapter.dev, "Terminating the current operation\n");
-		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL, SMBHSTCNT(priv));
+		dev_dbg(&priv->adapter.dev,
+			"Terminating the current operation\n");
+		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL,
+		       SMBHSTCNT(priv));
 		usleep_range(1000, 2000);
-		outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL), SMBHSTCNT(priv));
+		outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL),
+		       SMBHSTCNT(priv));
 
 		/* Check if it worked */
 		status = inb_p(SMBHSTSTS(priv));
-		if ((status & SMBHSTSTS_HOST_BUSY) || !(status & SMBHSTSTS_FAILED))
-			dev_err(&priv->adapter.dev, "Failed terminating the transaction\n");
+		if ((status & SMBHSTSTS_HOST_BUSY)
+		    || !(status & SMBHSTSTS_FAILED))
+			dev_err(&priv->adapter.dev,
+				"Failed terminating the transaction\n");
 		outb_p(STATUS_FLAGS, SMBHSTSTS(priv));
 		return -ETIMEDOUT;
 	}
@@ -193,7 +204,9 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
 		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status)
-			dev_warn(&priv->adapter.dev, "Failed clearing status flags at end of transaction (%02x)\n", status);
+			dev_warn(&priv->adapter.dev,
+				 "Failed clearing status flags at end of transaction (%02x)\n",
+				 status);
 	}
 
 	return result;
@@ -244,12 +257,14 @@ static void i801_wait_hwpec(struct i2c_device *priv)
 	outb_p(status, SMBHSTSTS(priv));
 }
 
-static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_smbus_data *data, char read_write, int hwpec)
+static int i801_block_transaction_by_block(struct i2c_device *priv,
+					   union i2c_smbus_data *data,
+					   char read_write, int hwpec)
 {
 	int i, len;
 	int status;
 
-	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
+	inb_p(SMBHSTCNT(priv));	/* reset the data buffer index */
 
 	/* Use 32-byte buffer to process this transaction */
 	if (read_write == I2C_SMBUS_WRITE) {
@@ -259,7 +274,10 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
 			outb_p(data->block[i + 1], SMBBLKDAT(priv));
 	}
 
-	status = i801_transaction(priv, I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
+	status =
+	    i801_transaction(priv,
+			     I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN *
+			     hwpec);
 	if (status)
 		return status;
 
@@ -275,7 +293,10 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
 	return 0;
 }
 
-static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2c_smbus_data *data, char read_write, int command, int hwpec)
+static int i801_block_transaction_byte_by_byte(struct i2c_device *priv,
+					       union i2c_smbus_data *data,
+					       char read_write, int command,
+					       int hwpec)
 {
 	int i, len;
 	int smbcmd;
@@ -301,7 +322,8 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 			else
 				smbcmd = I801_BLOCK_LAST;
 		} else {
-			if (command == I2C_SMBUS_I2C_BLOCK_DATA && read_write == I2C_SMBUS_READ)
+			if (command == I2C_SMBUS_I2C_BLOCK_DATA
+			    && read_write == I2C_SMBUS_READ)
 				smbcmd = I801_I2C_BLOCK_DATA;
 			else
 				smbcmd = I801_BLOCK_DATA;
@@ -309,24 +331,30 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT(priv));
 
 		if (i == 1)
-			outb_p(inb(SMBHSTCNT(priv)) | I801_START, SMBHSTCNT(priv));
+			outb_p(inb(SMBHSTCNT(priv)) | I801_START,
+			       SMBHSTCNT(priv));
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
 		do {
 			usleep_range(250, 500);
 			status = inb_p(SMBHSTSTS(priv));
-		} while ((!(status & SMBHSTSTS_BYTE_DONE)) && (timeout++ < MAX_RETRIES));
+		} while ((!(status & SMBHSTSTS_BYTE_DONE))
+			 && (timeout++ < MAX_RETRIES));
 
 		result = i801_check_post(priv, status, timeout > MAX_RETRIES);
 		if (result < 0)
 			return result;
-		if (i == 1 && read_write == I2C_SMBUS_READ && command != I2C_SMBUS_I2C_BLOCK_DATA) {
+		if (i == 1 && read_write == I2C_SMBUS_READ
+		    && command != I2C_SMBUS_I2C_BLOCK_DATA) {
 			len = inb_p(SMBHSTDAT0(priv));
 			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
-				dev_err(&priv->adapter.dev, "Illegal SMBus block read size %d\n", len);
+				dev_err(&priv->adapter.dev,
+					"Illegal SMBus block read size %d\n",
+					len);
 				/* Recover */
 				while (inb_p(SMBHSTSTS(priv)) & SMBHSTSTS_HOST_BUSY)
-					outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
+					outb_p(SMBHSTSTS_BYTE_DONE,
+					       SMBHSTSTS(priv));
 				outb_p(SMBHSTSTS_INTR, SMBHSTSTS(priv));
 				return -EPROTO;
 			}
@@ -354,7 +382,9 @@ static int i801_set_block_buffer_mode(struct i2c_device *priv)
 }
 
 /* Block transaction function */
-static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data *data, char read_write, int command, int hwpec)
+static int i801_block_transaction(struct i2c_device *priv,
+				  union i2c_smbus_data *data, char read_write,
+				  int command, int hwpec)
 {
 	int result = 0;
 	//unsigned char hostc;
@@ -363,15 +393,19 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 		if (read_write == I2C_SMBUS_WRITE) {
 			/* set I2C_EN bit in configuration register */
 			//TODO: Figure out the right thing to do here...
-			//pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &hostc);
-			//pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc | SMBHSTCFG_I2C_EN);
+			//pci_read_config_byte(priv->pci_dev,
+			//                     SMBHSTCFG, &hostc);
+			//    pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
+			//    hostc | SMBHSTCFG_I2C_EN);
 		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
-			dev_err(&priv->adapter.dev, "I2C block read is unsupported!\n");
+			dev_err(&priv->adapter.dev,
+				"I2C block read is unsupported!\n");
 			return -EOPNOTSUPP;
 		}
 	}
 
-	if (read_write == I2C_SMBUS_WRITE || command == I2C_SMBUS_I2C_BLOCK_DATA) {
+	if (read_write == I2C_SMBUS_WRITE
+	    || command == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (data->block[0] < 1)
 			data->block[0] = 1;
 		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
@@ -384,13 +418,20 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 	 * SMBus (not I2C) block transactions, even though the datasheet
 	 * doesn't mention this limitation.
 	 */
-	if ((priv->features & FEATURE_BLOCK_BUFFER) && command != I2C_SMBUS_I2C_BLOCK_DATA && i801_set_block_buffer_mode(priv) == 0)
-		result = i801_block_transaction_by_block(priv, data, read_write, hwpec);
+	if ((priv->features & FEATURE_BLOCK_BUFFER)
+	    && command != I2C_SMBUS_I2C_BLOCK_DATA
+	    && i801_set_block_buffer_mode(priv) == 0)
+		result =
+		    i801_block_transaction_by_block(priv, data, read_write,
+						    hwpec);
 	else
-		result = i801_block_transaction_byte_by_byte(priv, data, read_write, command, hwpec);
+		result =
+		    i801_block_transaction_byte_by_byte(priv, data, read_write,
+							command, hwpec);
 	if (result == 0 && hwpec)
 		i801_wait_hwpec(priv);
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA && read_write == I2C_SMBUS_WRITE) {
+	if (command == I2C_SMBUS_I2C_BLOCK_DATA
+	    && read_write == I2C_SMBUS_WRITE) {
 		/* restore saved configuration register value */
 		//TODO: Figure out the right thing to do here...
 		//pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
@@ -399,32 +440,38 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 }
 
 /* Return negative errno on error. */
-static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags, char read_write, u8 command, int size, union i2c_smbus_data *data)
+static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
+		       char read_write, u8 command, int size,
+		       union i2c_smbus_data *data)
 {
 	int hwpec;
 	int block = 0;
 	int ret, xact = 0;
 	struct i2c_device *priv = i2c_get_adapdata(adap);
 
-	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
+	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
+	    && size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_QUICK\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD(priv));
 		xact = I801_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BYTE\n");
 
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD(priv));
 		if (read_write == I2C_SMBUS_WRITE)
 			outb_p(command, SMBHSTCMD(priv));
 		xact = I801_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BYTE_DATA\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
 		if (read_write == I2C_SMBUS_WRITE)
 			outb_p(data->byte, SMBHSTDAT0(priv));
@@ -432,7 +479,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		break;
 	case I2C_SMBUS_WORD_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_WORD_DATA\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
 		if (read_write == I2C_SMBUS_WRITE) {
 			outb_p(data->word & 0xff, SMBHSTDAT0(priv));
@@ -442,7 +490,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BLOCK_DATA\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
 		block = 1;
 		break;
@@ -463,22 +512,25 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		block = 1;
 		break;
 	default:
-		dev_dbg(&priv->adapter.dev, "  [acc] Unsupported transaction %d\n", size);
+		dev_dbg(&priv->adapter.dev,
+			"  [acc] Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
-	if (hwpec) { /* enable/disable hardware PEC */
+	if (hwpec) {		/* enable/disable hardware PEC */
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec: yes\n");
 		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
 	} else {
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec: no\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC), SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
+		       SMBAUXCTL(priv));
 	}
 
 	if (block) {
 		//ret = 0;
 		dev_dbg(&priv->adapter.dev, "  [acc] block: yes\n");
-		ret = i801_block_transaction(priv, data, read_write, size, hwpec);
+		ret =
+		    i801_block_transaction(priv, data, read_write, size, hwpec);
 	} else {
 		dev_dbg(&priv->adapter.dev, "  [acc] block: no\n");
 		ret = i801_transaction(priv, xact | ENABLE_INT9);
@@ -490,7 +542,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	 */
 	if (hwpec || block) {
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec || block\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) &
+		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 	}
 	if (block) {
 		dev_dbg(&priv->adapter.dev, "  [acc] block\n");
@@ -501,19 +554,22 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		return ret;
 	}
 	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK)) {
-		dev_dbg(&priv->adapter.dev, "  [acc] I2C_SMBUS_WRITE || I801_QUICK  -> ret 0\n");
+		dev_dbg(&priv->adapter.dev,
+			"  [acc] I2C_SMBUS_WRITE || I801_QUICK  -> ret 0\n");
 		return 0;
 	}
 
 	switch (xact & 0x7f) {
-	case I801_BYTE:  /* Result put in SMBHSTDAT0 */
+	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
 	case I801_BYTE_DATA:
-		dev_dbg(&priv->adapter.dev, "  [acc] I801_BYTE or I801_BYTE_DATA\n");
+		dev_dbg(&priv->adapter.dev,
+			"  [acc] I801_BYTE or I801_BYTE_DATA\n");
 		data->byte = inb_p(SMBHSTDAT0(priv));
 		break;
 	case I801_WORD_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] I801_WORD_DATA\n");
-		data->word = inb_p(SMBHSTDAT0(priv)) + (inb_p(SMBHSTDAT1(priv)) << 8);
+		data->word =
+		    inb_p(SMBHSTDAT0(priv)) + (inb_p(SMBHSTDAT1(priv)) << 8);
 		break;
 	}
 	return 0;
@@ -558,13 +614,14 @@ static u32 i801_func(struct i2c_adapter *adapter)
 		I2C_FUNC_SMBUS_WORD_DATA         | /* _READ_WORD_DATA  _WRITE_WORD_DATA */
 		I2C_FUNC_SMBUS_BLOCK_DATA        | /* _READ_BLOCK_DATA  _WRITE_BLOCK_DATA */
 		!I2C_FUNC_SMBUS_I2C_BLOCK        | /* _READ_I2C_BLOCK  _WRITE_I2C_BLOCK */
-		!I2C_FUNC_SMBUS_EMUL;              /* _QUICK  _BYTE  _BYTE_DATA  _WORD_DATA  _PROC_CALL  _WRITE_BLOCK_DATA  _I2C_BLOCK _PEC */
+		/* _QUICK  _BYTE  _BYTE_DATA  _WORD_DATA  _PROC_CALL  _WRITE_BLOCK_DATA  _I2C_BLOCK _PEC : */
+		!I2C_FUNC_SMBUS_EMUL;
 	return f;
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
-	.smbus_xfer     = i801_access,
-	.functionality  = i801_func,
+	.smbus_xfer = i801_access,
+	.functionality = i801_func,
 };
 
 /********************************
@@ -610,8 +667,10 @@ static int pi2c_probe(struct platform_device *pldev)
 	/* Retry up to 3 times on lost arbitration */
 	priv->adapter.retries = 3;
 
-	//snprintf(priv->adapter.name, sizeof(priv->adapter.name), "Fake SMBus I801 adapter at %04lx", priv->smba);
-	snprintf(priv->adapter.name, sizeof(priv->adapter.name), "Fake SMBus I801 adapter");
+	//snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+	//        "Fake SMBus I801 adapter at %04lx", priv->smba);
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+		 "Fake SMBus I801 adapter");
 
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
@@ -641,10 +700,10 @@ static int pi2c_remove(struct platform_device *pldev)
 }
 
 static struct platform_driver i2c_plat_driver_i = {
-	.probe      = pi2c_probe,
-	.remove     = pi2c_remove,
-	.driver     = {
-		.name   = KP_DRIVER_NAME_I2C,
+	.probe = pi2c_probe,
+	.remove = pi2c_remove,
+	.driver = {
+		.name = KP_DRIVER_NAME_I2C,
 	},
 };
 
diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 35ac1d7070b3..543a32e8b7ef 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -30,19 +30,19 @@
 #include "kpc.h"
 
 static struct mtd_partition p2kr0_spi0_parts[] = {
-	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_0",	.size = 7798784,          .offset = 0,                },
+	{ .name = "SLOT_1",	.size = 7798784,          .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_2",	.size = 7798784,          .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_3",	.size = 7798784,          .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
 };
 
 static struct mtd_partition p2kr0_spi1_parts[] = {
-	{ .name = "SLOT_4",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_5",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_6",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_7",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_4",	.size = 7798784,	  .offset = 0,                },
+	{ .name = "SLOT_5",	.size = 7798784,	  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_6",	.size = 7798784,	  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_7",	.size = 7798784,	  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
 };
 
 static struct flash_platform_data p2kr0_spi0_pdata = {
@@ -50,6 +50,7 @@ static struct flash_platform_data p2kr0_spi0_pdata = {
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi0_parts),
 	.parts =	p2kr0_spi0_parts,
 };
+
 static struct flash_platform_data p2kr0_spi1_pdata = {
 	.name =		"SPI1",
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
@@ -76,11 +77,11 @@ static struct spi_board_info p2kr0_board_info[] = {
 /***************
  * SPI Defines *
  ***************/
-#define KP_SPI_REG_CONFIG 0x0 /* 0x00 */
-#define KP_SPI_REG_STATUS 0x1 /* 0x08 */
-#define KP_SPI_REG_FFCTRL 0x2 /* 0x10 */
-#define KP_SPI_REG_TXDATA 0x3 /* 0x18 */
-#define KP_SPI_REG_RXDATA 0x4 /* 0x20 */
+#define KP_SPI_REG_CONFIG 0x0	/* 0x00 */
+#define KP_SPI_REG_STATUS 0x1	/* 0x08 */
+#define KP_SPI_REG_FFCTRL 0x2	/* 0x10 */
+#define KP_SPI_REG_TXDATA 0x3	/* 0x18 */
+#define KP_SPI_REG_RXDATA 0x4	/* 0x20 */
 
 #define KP_SPI_CLK           48000000
 #define KP_SPI_MAX_FIFODEPTH 64
@@ -102,14 +103,14 @@ static struct spi_board_info p2kr0_board_info[] = {
  * SPI Structures *
  ******************/
 struct kp_spi {
-	struct spi_master  *master;
-	u64 __iomem        *base;
-	struct device      *dev;
+	struct spi_master *master;
+	u64 __iomem *base;
+	struct device *dev;
 };
 
 struct kp_spi_controller_state {
-	void __iomem   *base;
-	s64             conf_cache;
+	void __iomem *base;
+	s64 conf_cache;
 };
 
 union kp_spi_config {
@@ -158,8 +159,7 @@ union kp_spi_ffctrl {
 /***************
  * SPI Helpers *
  ***************/
-	static inline u64
-kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
+static inline u64 kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 {
 	u64 __iomem *addr = cs->base;
 	u64 val;
@@ -172,7 +172,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	return val;
 }
 
-	static inline void
+static inline void
 kp_spi_write_reg(struct kp_spi_controller_state *cs, int idx, u64 val)
 {
 	u64 __iomem *addr = cs->base;
@@ -183,7 +183,7 @@ kp_spi_write_reg(struct kp_spi_controller_state *cs, int idx, u64 val)
 		cs->conf_cache = val;
 }
 
-	static int
+static int
 kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
 			unsigned long bit)
 {
@@ -202,7 +202,7 @@ kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
 	return 0;
 }
 
-	static unsigned
+static unsigned
 kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
@@ -211,12 +211,12 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 
 	int i;
 	int res;
-	u8 *rx       = transfer->rx_buf;
+	u8 *rx = transfer->rx_buf;
 	const u8 *tx = transfer->tx_buf;
 	int processed = 0;
 
 	if (tx) {
-		for (i = 0 ; i < c ; i++) {
+		for (i = 0; i < c; i++) {
 			char val = *tx++;
 
 			res = kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
@@ -227,9 +227,8 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
-		for (i = 0 ; i < c ; i++) {
+	} else if (rx) {
+		for (i = 0; i < c; i++) {
 			char test = 0;
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, 0x00);
@@ -250,15 +249,14 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 		//Ths has never happened in practice though...
 	}
 
-out:
+ out:
 	return processed;
 }
 
 /*****************
  * SPI Functions *
  *****************/
-	static int
-kp_spi_setup(struct spi_device *spidev)
+static int kp_spi_setup(struct spi_device *spidev)
 {
 	union kp_spi_config sc;
 	struct kp_spi *kpspi = spi_master_get_devdata(spidev->master);
@@ -285,12 +283,12 @@ kp_spi_setup(struct spi_device *spidev)
 	return 0;
 }
 
-	static int
+static int
 kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 {
 	struct kp_spi_controller_state *cs;
-	struct spi_device   *spidev;
-	struct kp_spi       *kpspi;
+	struct spi_device *spidev;
+	struct kp_spi *kpspi;
 	struct spi_transfer *transfer;
 	union kp_spi_config sc;
 	int status = 0;
@@ -309,31 +307,28 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	/* validate input */
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
 		const void *tx_buf = transfer->tx_buf;
-		void       *rx_buf = transfer->rx_buf;
+		void *rx_buf = transfer->rx_buf;
 		unsigned int len = transfer->len;
 
 		if (transfer->speed_hz > KP_SPI_CLK ||
 		    (len && !(rx_buf || tx_buf))) {
-			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
-					transfer->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					transfer->bits_per_word);
+			dev_dbg(kpspi->dev,
+				"  transfer: %d Hz, %d %s%s, %d bpw\n",
+				transfer->speed_hz, len, tx_buf ? "tx" : "",
+				rx_buf ? "rx" : "", transfer->bits_per_word);
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
 		if (transfer->speed_hz &&
 		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
-					transfer->speed_hz,
-					KP_SPI_CLK >> 15);
+				transfer->speed_hz, KP_SPI_CLK >> 15);
 			dev_dbg(kpspi->dev, "  speed_hz -EINVAL\n");
 			return -EINVAL;
 		}
 	}
 
-	/* assert chip select to start the sequence*/
+	/* assert chip select to start the sequence */
 	sc.reg = kp_spi_read_reg(cs, KP_SPI_REG_CONFIG);
 	sc.bitfield.spi_en = 1;
 	kp_spi_write_reg(cs, KP_SPI_REG_CONFIG, sc.reg);
@@ -347,8 +342,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 
 	/* do the transfers for this message */
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
-		if (!transfer->tx_buf && !transfer->rx_buf &&
-		    transfer->len) {
+		if (!transfer->tx_buf && !transfer->rx_buf && transfer->len) {
 			status = -EINVAL;
 			goto error;
 		}
@@ -397,18 +391,17 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	sc.bitfield.spi_en = 0;
 	kp_spi_write_reg(cs, KP_SPI_REG_CONFIG, sc.reg);
 
-out:
+ out:
 	/* done work */
 	spi_finalize_current_message(master);
 	return 0;
 
-error:
+ error:
 	m->status = status;
 	return status;
 }
 
-	static void
-kp_spi_cleanup(struct spi_device *spidev)
+static void kp_spi_cleanup(struct spi_device *spidev)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
 
@@ -419,8 +412,7 @@ kp_spi_cleanup(struct spi_device *spidev)
 /******************
  * Probe / Remove *
  ******************/
-	static int
-kp_spi_probe(struct platform_device *pldev)
+static int kp_spi_probe(struct platform_device *pldev)
 {
 	struct kpc_core_device_platdata *drvdata;
 	struct spi_master *master;
@@ -487,19 +479,19 @@ kp_spi_probe(struct platform_device *pldev)
 		NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(p2kr0_board_info);
 		break;
 	default:
-		dev_err(&pldev->dev, "Unknown hardware, cant know what partition table to use!\n");
+		dev_err(&pldev->dev,
+			"Unknown hardware, cant know what partition table to use!\n");
 		goto free_master;
 	}
 
 	return status;
 
-free_master:
+ free_master:
 	spi_master_put(master);
 	return status;
 }
 
-	static int
-kp_spi_remove(struct platform_device *pldev)
+static int kp_spi_remove(struct platform_device *pldev)
 {
 	struct spi_master *master = platform_get_drvdata(pldev);
 
@@ -509,10 +501,10 @@ kp_spi_remove(struct platform_device *pldev)
 
 static struct platform_driver kp_spi_driver = {
 	.driver = {
-		.name =     KP_DRIVER_NAME_SPI,
-	},
-	.probe =    kp_spi_probe,
-	.remove =   kp_spi_remove,
+		   .name = KP_DRIVER_NAME_SPI,
+		   },
+	.probe = kp_spi_probe,
+	.remove = kp_spi_remove,
 };
 
 module_platform_driver(kp_spi_driver);
diff --git a/drivers/staging/kpc2000/kpc_dma/dma.c b/drivers/staging/kpc2000/kpc_dma/dma.c
index 51a4dd534a0d..bcb3097e41a5 100644
--- a/drivers/staging/kpc2000/kpc_dma/dma.c
+++ b/drivers/staging/kpc2000/kpc_dma/dma.c
@@ -12,21 +12,23 @@
 
 /**********  IRQ Handlers  **********/
 static
-irqreturn_t  ndd_irq_handler(int irq, void *dev_id)
+irqreturn_t ndd_irq_handler(int irq, void *dev_id)
 {
 	struct kpc_dma_device *ldev = (struct kpc_dma_device *)dev_id;
 
-	if ((GetEngineControl(ldev) & ENG_CTL_IRQ_ACTIVE) || (ldev->desc_completed->MyDMAAddr != GetEngineCompletePtr(ldev)))
+	if ((GetEngineControl(ldev) & ENG_CTL_IRQ_ACTIVE)
+	    || (ldev->desc_completed->MyDMAAddr != GetEngineCompletePtr(ldev)))
 		schedule_work(&ldev->irq_work);
 
 	return IRQ_HANDLED;
 }
 
 static
-void  ndd_irq_worker(struct work_struct *ws)
+void ndd_irq_worker(struct work_struct *ws)
 {
 	struct kpc_dma_descriptor *cur;
-	struct kpc_dma_device *eng = container_of(ws, struct kpc_dma_device, irq_work);
+	struct kpc_dma_device *eng =
+	    container_of(ws, struct kpc_dma_device, irq_work);
 
 	lock_engine(eng);
 
@@ -39,8 +41,10 @@ void  ndd_irq_worker(struct work_struct *ws)
 	cur = eng->desc_completed;
 	do {
 		cur = cur->Next;
-		dev_dbg(&eng->pldev->dev, "Handling completed descriptor %p (acd = %p)\n", cur, cur->acd);
-		BUG_ON(cur == eng->desc_next); // Ordering failure.
+		dev_dbg(&eng->pldev->dev,
+			"Handling completed descriptor %p (acd = %p)\n", cur,
+			cur->acd);
+		BUG_ON(cur == eng->desc_next);	// Ordering failure.
 
 		if (cur->DescControlFlags & DMA_DESC_CTL_SOP) {
 			eng->accumulated_bytes = 0;
@@ -56,7 +60,11 @@ void  ndd_irq_worker(struct work_struct *ws)
 
 		if (cur->DescControlFlags & DMA_DESC_CTL_EOP) {
 			if (cur->acd)
-				transfer_complete_cb(cur->acd, eng->accumulated_bytes, eng->accumulated_flags | ACD_FLAG_DONE);
+				transfer_complete_cb(cur->acd,
+						     eng->accumulated_bytes,
+						     eng->
+						     accumulated_flags |
+						     ACD_FLAG_DONE);
 		}
 
 		eng->desc_completed = cur;
@@ -69,10 +77,10 @@ void  ndd_irq_worker(struct work_struct *ws)
 }
 
 /**********  DMA Engine Init/Teardown  **********/
-void  start_dma_engine(struct kpc_dma_device *eng)
+void start_dma_engine(struct kpc_dma_device *eng)
 {
-	eng->desc_next       = eng->desc_pool_first;
-	eng->desc_completed  = eng->desc_pool_last;
+	eng->desc_next = eng->desc_pool_first;
+	eng->desc_completed = eng->desc_pool_last;
 
 	// Setup the engine pointer registers
 	SetEngineNextPtr(eng, eng->desc_pool_first);
@@ -82,7 +90,7 @@ void  start_dma_engine(struct kpc_dma_device *eng)
 	WriteEngineControl(eng, ENG_CTL_DMA_ENABLE | ENG_CTL_IRQ_ENABLE);
 }
 
-int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
+int setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 {
 	u32 caps;
 	struct kpc_dma_descriptor *cur;
@@ -94,7 +102,10 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 
 	caps = GetEngineCapabilities(eng);
 
-	if (WARN(!(caps & ENG_CAP_PRESENT), "%s() called for DMA Engine at %p which isn't present in hardware!\n", __func__, eng))
+	if (WARN
+	    (!(caps & ENG_CAP_PRESENT),
+	     "%s() called for DMA Engine at %p which isn't present in hardware!\n",
+	     __func__, eng))
 		return -ENXIO;
 
 	if (caps & ENG_CAP_DIRECTION) {
@@ -104,11 +115,16 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	}
 
 	eng->desc_pool_cnt = desc_cnt;
-	eng->desc_pool = dma_pool_create("KPC DMA Descriptors", &eng->pldev->dev, sizeof(struct kpc_dma_descriptor), DMA_DESC_ALIGNMENT, 4096);
+	eng->desc_pool =
+	    dma_pool_create("KPC DMA Descriptors", &eng->pldev->dev,
+			    sizeof(struct kpc_dma_descriptor),
+			    DMA_DESC_ALIGNMENT, 4096);
 
-	eng->desc_pool_first = dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA, &head_handle);
+	eng->desc_pool_first =
+	    dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA, &head_handle);
 	if (!eng->desc_pool_first) {
-		dev_err(&eng->pldev->dev, "%s: couldn't allocate desc_pool_first!\n", __func__);
+		dev_err(&eng->pldev->dev,
+			"%s: couldn't allocate desc_pool_first!\n", __func__);
 		dma_pool_destroy(eng->desc_pool);
 		return -ENOMEM;
 	}
@@ -117,8 +133,10 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	clear_desc(eng->desc_pool_first);
 
 	cur = eng->desc_pool_first;
-	for (i = 1 ; i < eng->desc_pool_cnt ; i++) {
-		next = dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA, &next_handle);
+	for (i = 1; i < eng->desc_pool_cnt; i++) {
+		next =
+		    dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA,
+				   &next_handle);
 		if (!next)
 			goto done_alloc;
 
@@ -142,12 +160,13 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	INIT_WORK(&eng->irq_work, ndd_irq_worker);
 
 	// Grab IRQ line
-	rv = request_irq(eng->irq, ndd_irq_handler, IRQF_SHARED, KP_DRIVER_NAME_DMA_CONTROLLER, eng);
+	rv = request_irq(eng->irq, ndd_irq_handler, IRQF_SHARED,
+			 KP_DRIVER_NAME_DMA_CONTROLLER, eng);
 	if (rv) {
-		dev_err(&eng->pldev->dev, "%s: failed to request_irq: %d\n", __func__, rv);
+		dev_err(&eng->pldev->dev, "%s: failed to request_irq: %d\n",
+			__func__, rv);
 		return rv;
 	}
-
 	// Turn on the engine!
 	start_dma_engine(eng);
 	unlock_engine(eng);
@@ -155,7 +174,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	return 0;
 }
 
-void  stop_dma_engine(struct kpc_dma_device *eng)
+void stop_dma_engine(struct kpc_dma_device *eng)
 {
 	unsigned long timeout;
 
@@ -166,7 +185,8 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 	timeout = jiffies + (HZ / 2);
 	while (GetEngineControl(eng) & ENG_CTL_DMA_RUNNING) {
 		if (time_after(jiffies, timeout)) {
-			dev_crit(&eng->pldev->dev, "DMA_RUNNING still asserted!\n");
+			dev_crit(&eng->pldev->dev,
+				 "DMA_RUNNING still asserted!\n");
 			break;
 		}
 	}
@@ -176,9 +196,11 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 
 	// Wait for reset request to be processed
 	timeout = jiffies + (HZ / 2);
-	while (GetEngineControl(eng) & (ENG_CTL_DMA_RUNNING | ENG_CTL_DMA_RESET_REQUEST)) {
+	while (GetEngineControl(eng) &
+	       (ENG_CTL_DMA_RUNNING | ENG_CTL_DMA_RESET_REQUEST)) {
 		if (time_after(jiffies, timeout)) {
-			dev_crit(&eng->pldev->dev, "ENG_CTL_DMA_RESET_REQUEST still asserted!\n");
+			dev_crit(&eng->pldev->dev,
+				 "ENG_CTL_DMA_RESET_REQUEST still asserted!\n");
 			break;
 		}
 	}
@@ -190,13 +212,18 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 	timeout = jiffies + (HZ / 2);
 	while (GetEngineControl(eng) & ENG_CTL_DMA_RESET) {
 		if (time_after(jiffies, timeout)) {
-			dev_crit(&eng->pldev->dev, "DMA_RESET still asserted!\n");
+			dev_crit(&eng->pldev->dev,
+				 "DMA_RESET still asserted!\n");
 			break;
 		}
 	}
 
 	// Clear any persistent bits just to make sure there is no residue from the reset
-	SetClearEngineControl(eng, (ENG_CTL_IRQ_ACTIVE | ENG_CTL_DESC_COMPLETE | ENG_CTL_DESC_ALIGN_ERR | ENG_CTL_DESC_FETCH_ERR | ENG_CTL_SW_ABORT_ERR | ENG_CTL_DESC_CHAIN_END | ENG_CTL_DMA_WAITING_PERSIST), 0);
+	SetClearEngineControl(eng,
+			      (ENG_CTL_IRQ_ACTIVE | ENG_CTL_DESC_COMPLETE |
+			       ENG_CTL_DESC_ALIGN_ERR | ENG_CTL_DESC_FETCH_ERR |
+			       ENG_CTL_SW_ABORT_ERR | ENG_CTL_DESC_CHAIN_END |
+			       ENG_CTL_DMA_WAITING_PERSIST), 0);
 
 	// Reset performance counters
 
@@ -204,7 +231,7 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 	WriteEngineControl(eng, 0);
 }
 
-void  destroy_dma_engine(struct kpc_dma_device *eng)
+void destroy_dma_engine(struct kpc_dma_device *eng)
 {
 	struct kpc_dma_descriptor *cur;
 	dma_addr_t cur_handle;
@@ -215,7 +242,7 @@ void  destroy_dma_engine(struct kpc_dma_device *eng)
 	cur = eng->desc_pool_first;
 	cur_handle = eng->desc_pool_first->MyDMAAddr;
 
-	for (i = 0 ; i < eng->desc_pool_cnt ; i++) {
+	for (i = 0; i < eng->desc_pool_cnt; i++) {
 		struct kpc_dma_descriptor *next = cur->Next;
 		dma_addr_t next_handle = cur->DescNextDescPtr;
 
@@ -230,7 +257,7 @@ void  destroy_dma_engine(struct kpc_dma_device *eng)
 }
 
 /**********  Helper Functions  **********/
-int  count_descriptors_available(struct kpc_dma_device *eng)
+int count_descriptors_available(struct kpc_dma_device *eng)
 {
 	u32 count = 0;
 	struct kpc_dma_descriptor *cur = eng->desc_next;
@@ -243,20 +270,20 @@ int  count_descriptors_available(struct kpc_dma_device *eng)
 	return count;
 }
 
-void  clear_desc(struct kpc_dma_descriptor *desc)
+void clear_desc(struct kpc_dma_descriptor *desc)
 {
 	if (!desc)
 		return;
-	desc->DescByteCount         = 0;
-	desc->DescStatusErrorFlags  = 0;
-	desc->DescStatusFlags       = 0;
-	desc->DescUserControlLS     = 0;
-	desc->DescUserControlMS     = 0;
-	desc->DescCardAddrLS        = 0;
-	desc->DescBufferByteCount   = 0;
-	desc->DescCardAddrMS        = 0;
-	desc->DescControlFlags      = 0;
-	desc->DescSystemAddrLS      = 0;
-	desc->DescSystemAddrMS      = 0;
+	desc->DescByteCount = 0;
+	desc->DescStatusErrorFlags = 0;
+	desc->DescStatusFlags = 0;
+	desc->DescUserControlLS = 0;
+	desc->DescUserControlMS = 0;
+	desc->DescCardAddrLS = 0;
+	desc->DescBufferByteCount = 0;
+	desc->DescCardAddrMS = 0;
+	desc->DescControlFlags = 0;
+	desc->DescSystemAddrLS = 0;
+	desc->DescSystemAddrMS = 0;
 	desc->acd = NULL;
 }
diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 48ca88bc6b0b..b5f37440cbbb 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -2,30 +2,29 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/kernel.h>   /* printk() */
-#include <linux/slab.h>     /* kmalloc() */
-#include <linux/fs.h>       /* everything... */
-#include <linux/errno.h>    /* error codes */
-#include <linux/types.h>    /* size_t */
+#include <linux/kernel.h>	/* printk() */
+#include <linux/slab.h>		/* kmalloc() */
+#include <linux/fs.h>		/* everything... */
+#include <linux/errno.h>	/* error codes */
+#include <linux/types.h>	/* size_t */
 #include <linux/cdev.h>
-#include <linux/uaccess.h>  /* copy_*_user */
+#include <linux/uaccess.h>	/* copy_*_user */
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include "kpc_dma_driver.h"
 #include "uapi.h"
 
 /**********  Helper Functions  **********/
-static inline
-unsigned int  count_pages(unsigned long iov_base, size_t iov_len)
+static inline unsigned int count_pages(unsigned long iov_base, size_t iov_len)
 {
-	unsigned long first = (iov_base             & PAGE_MASK) >> PAGE_SHIFT;
-	unsigned long last  = ((iov_base+iov_len-1) & PAGE_MASK) >> PAGE_SHIFT;
+	unsigned long first = (iov_base & PAGE_MASK) >> PAGE_SHIFT;
+	unsigned long last =
+	    ((iov_base + iov_len - 1) & PAGE_MASK) >> PAGE_SHIFT;
 
 	return last - first + 1;
 }
 
-static inline
-unsigned int  count_parts_for_sge(struct scatterlist *sg)
+static inline unsigned int count_parts_for_sge(struct scatterlist *sg)
 {
 	return DIV_ROUND_UP(sg_dma_len(sg), 0x80000);
 }
@@ -55,7 +54,8 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
 	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
 	if (!acd) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
+		dev_err(&priv->ldev->pldev->dev,
+			"Couldn't kmalloc space for for the aio data\n");
 		return -ENOMEM;
 	}
 	memset(acd, 0x66, sizeof(struct aio_cb_data));
@@ -68,36 +68,45 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	acd->page_count = count_pages(iov_base, iov_len);
 
 	// Allocate an array of page pointers
-	acd->user_pages = kzalloc(sizeof(struct page *) * acd->page_count, GFP_KERNEL);
+	acd->user_pages =
+	    kzalloc(sizeof(struct page *) * acd->page_count, GFP_KERNEL);
 	if (!acd->user_pages) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the page pointers\n");
+		dev_err(&priv->ldev->pldev->dev,
+			"Couldn't kmalloc space for for the page pointers\n");
 		rv = -ENOMEM;
 		goto err_alloc_userpages;
 	}
-
-	// Lock the user buffer pages in memory, and hold on to the page pointers (for the sglist)
-	down_read(&current->mm->mmap_sem);      /*  get memory map semaphore */
-	rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
-	up_read(&current->mm->mmap_sem);        /*  release the semaphore */
+	// Lock the user buffer pages in memory, and hold on to the page
+	// pointers (for the sglist)
+	down_read(&current->mm->mmap_sem);
+	rv = get_user_pages(iov_base, acd->page_count,
+			    FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages,
+			    NULL);
+	up_read(&current->mm->mmap_sem);
 	if (rv != acd->page_count) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%ld)\n", rv);
+		dev_err(&priv->ldev->pldev->dev,
+			"Couldn't get_user_pages (%ld)\n", rv);
 		goto err_get_user_pages;
 	}
-
 	// Allocate and setup the sg_table (scatterlist entries)
-	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE-1), iov_len, GFP_KERNEL);
+	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages,
+				       acd->page_count,
+				       iov_base & (PAGE_SIZE - 1), iov_len,
+				       GFP_KERNEL);
 	if (rv) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't alloc sg_table (%ld)\n", rv);
+		dev_err(&priv->ldev->pldev->dev,
+			"Couldn't alloc sg_table (%ld)\n", rv);
 		goto err_alloc_sg_table;
 	}
-
 	// Setup the DMA mapping for all the sg entries
-	acd->mapped_entry_count = dma_map_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
+	acd->mapped_entry_count =
+	    dma_map_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents,
+		       ldev->dir);
 	if (acd->mapped_entry_count <= 0) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't dma_map_sg (%d)\n", acd->mapped_entry_count);
+		dev_err(&priv->ldev->pldev->dev, "Couldn't dma_map_sg (%d)\n",
+			acd->mapped_entry_count);
 		goto err_dma_map_sg;
 	}
-
 	// Calculate how many descriptors are actually needed for this transfer.
 	for_each_sg(acd->sgt.sgl, sg, acd->mapped_entry_count, i) {
 		desc_needed += count_parts_for_sge(sg);
@@ -105,61 +114,83 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
 	lock_engine(ldev);
 
-	// Figoure out how many descriptors are available and return an error if there aren't enough
+	// Figure out how many descriptors are available and return an error if
+	// there aren't enough
 	num_descrs_avail = count_descriptors_available(ldev);
-	dev_dbg(&priv->ldev->pldev->dev, "    mapped_entry_count = %d    num_descrs_needed = %d    num_descrs_avail = %d\n", acd->mapped_entry_count, desc_needed, num_descrs_avail);
+	dev_dbg(&priv->ldev->pldev->dev,
+		"    mapped_entry_count = %d    num_descrs_needed = %d"
+		"    num_descrs_avail = %d\n",
+		acd->mapped_entry_count, desc_needed, num_descrs_avail);
 	if (desc_needed >= ldev->desc_pool_cnt) {
-		dev_warn(&priv->ldev->pldev->dev, "    mapped_entry_count = %d    num_descrs_needed = %d    num_descrs_avail = %d    TOO MANY to ever complete!\n", acd->mapped_entry_count, desc_needed, num_descrs_avail);
+		dev_warn(&priv->ldev->pldev->dev,
+			 "    mapped_entry_count = %d    num_descrs_needed = %d"
+			 "    num_descrs_avail = %d"
+			 "    TOO MANY to ever complete!\n",
+			 acd->mapped_entry_count, desc_needed,
+			 num_descrs_avail);
 		rv = -EAGAIN;
 		goto err_descr_too_many;
 	}
 	if (desc_needed > num_descrs_avail) {
-		dev_warn(&priv->ldev->pldev->dev, "    mapped_entry_count = %d    num_descrs_needed = %d    num_descrs_avail = %d    Too many to complete right now.\n", acd->mapped_entry_count, desc_needed, num_descrs_avail);
+		dev_warn(&priv->ldev->pldev->dev,
+			 "    mapped_entry_count = %d    num_descrs_needed = %d"
+			 "    num_descrs_avail = %d"
+			 "    Too many to complete right now.\n",
+			 acd->mapped_entry_count, desc_needed,
+			 num_descrs_avail);
 		rv = -EMSGSIZE;
 		goto err_descr_too_many;
 	}
-
-	// Loop through all the sg table entries and fill out a descriptor for each one.
+	// Loop through all the sg table entries and fill out a descriptor for
+	// each one.
 	desc = ldev->desc_next;
 	card_addr = acd->priv->card_addr;
 	for_each_sg(acd->sgt.sgl, sg, acd->mapped_entry_count, i) {
 		pcnt = count_parts_for_sge(sg);
-		for (p = 0 ; p < pcnt ; p++) {
+		for (p = 0; p < pcnt; p++) {
 			// Fill out the descriptor
 			BUG_ON(desc == NULL);
 			clear_desc(desc);
-			if (p != pcnt-1) {
+			if (p != pcnt - 1) {
 				desc->DescByteCount = 0x80000;
 			} else {
-				desc->DescByteCount = sg_dma_len(sg) - (p * 0x80000);
+				desc->DescByteCount =
+				    sg_dma_len(sg) - (p * 0x80000);
 			}
 			desc->DescBufferByteCount = desc->DescByteCount;
 
 			desc->DescControlFlags |= DMA_DESC_CTL_IRQONERR;
 			if (i == 0 && p == 0)
 				desc->DescControlFlags |= DMA_DESC_CTL_SOP;
-			if (i == acd->mapped_entry_count-1 && p == pcnt-1)
-				desc->DescControlFlags |= DMA_DESC_CTL_EOP | DMA_DESC_CTL_IRQONDONE;
+			if (i == acd->mapped_entry_count - 1 && p == pcnt - 1)
+				desc->DescControlFlags |=
+				    DMA_DESC_CTL_EOP | DMA_DESC_CTL_IRQONDONE;
 
 			desc->DescCardAddrLS = (card_addr & 0xFFFFFFFF);
 			desc->DescCardAddrMS = (card_addr >> 32) & 0xF;
 			card_addr += desc->DescByteCount;
 
-			dma_addr  = sg_dma_address(sg) + (p * 0x80000);
-			desc->DescSystemAddrLS = (dma_addr & 0x00000000FFFFFFFF) >>  0;
-			desc->DescSystemAddrMS = (dma_addr & 0xFFFFFFFF00000000) >> 32;
+			dma_addr = sg_dma_address(sg) + (p * 0x80000);
+			desc->DescSystemAddrLS =
+			    (dma_addr & 0x00000000FFFFFFFF) >> 0;
+			desc->DescSystemAddrMS =
+			    (dma_addr & 0xFFFFFFFF00000000) >> 32;
 
 			user_ctl = acd->priv->user_ctl;
-			if (i == acd->mapped_entry_count-1 && p == pcnt-1) {
+			if (i == acd->mapped_entry_count - 1 && p == pcnt - 1) {
 				user_ctl = acd->priv->user_ctl_last;
 			}
-			desc->DescUserControlLS = (user_ctl & 0x00000000FFFFFFFF) >>  0;
-			desc->DescUserControlMS = (user_ctl & 0xFFFFFFFF00000000) >> 32;
+			desc->DescUserControlLS =
+			    (user_ctl & 0x00000000FFFFFFFF) >> 0;
+			desc->DescUserControlMS =
+			    (user_ctl & 0xFFFFFFFF00000000) >> 32;
 
-			if (i == acd->mapped_entry_count-1 && p == pcnt-1)
+			if (i == acd->mapped_entry_count - 1 && p == pcnt - 1)
 				desc->acd = acd;
 
-			dev_dbg(&priv->ldev->pldev->dev, "  Filled descriptor %p (acd = %p)\n", desc, desc->acd);
+			dev_dbg(&priv->ldev->pldev->dev,
+				"  Filled descriptor %p (acd = %p)\n", desc,
+				desc->acd);
 
 			ldev->desc_next = desc->Next;
 			desc = desc->Next;
@@ -186,22 +217,24 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
  err_descr_too_many:
 	unlock_engine(ldev);
-	dma_unmap_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
+	dma_unmap_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents,
+		     ldev->dir);
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++) {
+	for (i = 0; i < acd->page_count; i++) {
 		put_page(acd->user_pages[i]);
 	}
  err_get_user_pages:
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
-	dev_dbg(&priv->ldev->pldev->dev, "%s returning with error %ld\n", __func__, rv);
+	dev_dbg(&priv->ldev->pldev->dev, "%s returning with error %ld\n",
+		__func__, rv);
 	return rv;
 }
 
-void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
+void transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 {
 	unsigned int i;
 
@@ -211,15 +244,16 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	BUG_ON(acd->ldev == NULL);
 	BUG_ON(acd->ldev->pldev == NULL);
 
-	for (i = 0 ; i < acd->page_count ; i++) {
+	for (i = 0; i < acd->page_count; i++) {
 		if (!PageReserved(acd->user_pages[i])) {
 			set_page_dirty(acd->user_pages[i]);
 		}
 	}
 
-	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
+	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents,
+		     acd->ldev->dir);
 
-	for (i = 0 ; i < acd->page_count ; i++) {
+	for (i = 0; i < acd->page_count; i++) {
 		put_page(acd->user_pages[i]);
 	}
 
@@ -242,7 +276,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 
 /**********  Fileops  **********/
 static
-int  kpc_dma_open(struct inode *inode, struct file *filp)
+int kpc_dma_open(struct inode *inode, struct file *filp)
 {
 	struct dev_private_data *priv;
 	struct kpc_dma_device *ldev = kpc_dma_lookup_device(iminor(inode));
@@ -252,7 +286,7 @@ int  kpc_dma_open(struct inode *inode, struct file *filp)
 
 	if (!atomic_dec_and_test(&ldev->open_count)) {
 		atomic_inc(&ldev->open_count);
-		return -EBUSY; /* already open */
+		return -EBUSY;	/* already open */
 	}
 
 	priv = kzalloc(sizeof(struct dev_private_data), GFP_KERNEL);
@@ -266,10 +300,11 @@ int  kpc_dma_open(struct inode *inode, struct file *filp)
 }
 
 static
-int  kpc_dma_close(struct inode *inode, struct file *filp)
+int kpc_dma_close(struct inode *inode, struct file *filp)
 {
 	struct kpc_dma_descriptor *cur;
-	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+	struct dev_private_data *priv =
+	    (struct dev_private_data *)filp->private_data;
 	struct kpc_dma_device *eng = priv->ldev;
 
 	lock_engine(eng);
@@ -278,10 +313,12 @@ int  kpc_dma_close(struct inode *inode, struct file *filp)
 
 	cur = eng->desc_completed->Next;
 	while (cur != eng->desc_next) {
-		dev_dbg(&eng->pldev->dev, "Aborting descriptor %p (acd = %p)\n", cur, cur->acd);
+		dev_dbg(&eng->pldev->dev, "Aborting descriptor %p (acd = %p)\n",
+			cur, cur->acd);
 		if (cur->DescControlFlags & DMA_DESC_CTL_EOP) {
 			if (cur->acd)
-				transfer_complete_cb(cur->acd, 0, ACD_FLAG_ABORT);
+				transfer_complete_cb(cur->acd, 0,
+						     ACD_FLAG_ABORT);
 		}
 
 		clear_desc(cur);
@@ -294,15 +331,17 @@ int  kpc_dma_close(struct inode *inode, struct file *filp)
 
 	unlock_engine(eng);
 
-	atomic_inc(&priv->ldev->open_count); /* release the device */
+	atomic_inc(&priv->ldev->open_count);	/* release the device */
 	kfree(priv);
 	return 0;
 }
 
 static
-ssize_t  kpc_dma_read(struct file *filp,       char __user *user_buf, size_t count, loff_t *ppos)
+ssize_t kpc_dma_read(struct file *filp, char __user *user_buf,
+		     size_t count, loff_t *ppos)
 {
-	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+	struct dev_private_data *priv =
+	    (struct dev_private_data *)filp->private_data;
 
 	if (priv->ldev->dir != DMA_FROM_DEVICE)
 		return -EMEDIUMTYPE;
@@ -311,9 +350,11 @@ ssize_t  kpc_dma_read(struct file *filp,       char __user *user_buf, size_t cou
 }
 
 static
-ssize_t  kpc_dma_write(struct file *filp, const char __user *user_buf, size_t count, loff_t *ppos)
+ssize_t kpc_dma_write(struct file *filp, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
 {
-	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+	struct dev_private_data *priv =
+	    (struct dev_private_data *)filp->private_data;
 
 	if (priv->ldev->dir != DMA_TO_DEVICE)
 		return -EMEDIUMTYPE;
@@ -322,17 +363,22 @@ ssize_t  kpc_dma_write(struct file *filp, const char __user *user_buf, size_t co
 }
 
 static
-long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioctl_param)
+long kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num,
+		   unsigned long ioctl_param)
 {
-	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+	struct dev_private_data *priv =
+	    (struct dev_private_data *)filp->private_data;
 
 	switch (ioctl_num) {
 	case KND_IOCTL_SET_CARD_ADDR:
-		priv->card_addr  = ioctl_param; return priv->card_addr;
+		priv->card_addr = ioctl_param;
+		return priv->card_addr;
 	case KND_IOCTL_SET_USER_CTL:
-		priv->user_ctl   = ioctl_param; return priv->user_ctl;
+		priv->user_ctl = ioctl_param;
+		return priv->user_ctl;
 	case KND_IOCTL_SET_USER_CTL_LAST:
-		priv->user_ctl_last = ioctl_param; return priv->user_ctl_last;
+		priv->user_ctl_last = ioctl_param;
+		return priv->user_ctl_last;
 	case KND_IOCTL_GET_USER_STS:
 		return priv->user_sts;
 	}
@@ -341,11 +387,10 @@ long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioc
 }
 
 const struct file_operations  kpc_dma_fops = {
-	.owner      = THIS_MODULE,
-	.open           = kpc_dma_open,
-	.release        = kpc_dma_close,
-	.read           = kpc_dma_read,
-	.write          = kpc_dma_write,
-	.unlocked_ioctl = kpc_dma_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= kpc_dma_open,
+	.release	= kpc_dma_close,
+	.read		= kpc_dma_read,
+	.write		= kpc_dma_write,
+	.unlocked_ioctl	= kpc_dma_ioctl,
 };
-
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index a05ae6d40db9..29a84fa0fd36 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -30,8 +30,8 @@ struct kpc_dma_device *kpc_dma_lookup_device(int minor)
 			goto out;
 		}
 	}
-	c = NULL; // not-found case
-out:
+	c = NULL;		// not-found case
+ out:
 	mutex_unlock(&kpc_dma_mtx);
 	return c;
 }
@@ -51,7 +51,8 @@ static void kpc_dma_del_device(struct kpc_dma_device *ldev)
 }
 
 /**********  SysFS Attributes **********/
-static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_engine_regs(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct kpc_dma_device *ldev;
 	struct platform_device *pldev = to_platform_device(dev);
@@ -63,24 +64,24 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 		return 0;
 
 	return scnprintf(buf, PAGE_SIZE,
-		"EngineControlStatus      = 0x%08x\n"
-		"RegNextDescPtr           = 0x%08x\n"
-		"RegSWDescPtr             = 0x%08x\n"
-		"RegCompletedDescPtr      = 0x%08x\n"
-		"desc_pool_first          = %p\n"
-		"desc_pool_last           = %p\n"
-		"desc_next                = %p\n"
-		"desc_completed           = %p\n",
-		readl(ldev->eng_regs + 1),
-		readl(ldev->eng_regs + 2),
-		readl(ldev->eng_regs + 3),
-		readl(ldev->eng_regs + 4),
-		ldev->desc_pool_first,
-		ldev->desc_pool_last,
-		ldev->desc_next,
-		ldev->desc_completed
-	);
+			 "EngineControlStatus      = 0x%08x\n"
+			 "RegNextDescPtr           = 0x%08x\n"
+			 "RegSWDescPtr             = 0x%08x\n"
+			 "RegCompletedDescPtr      = 0x%08x\n"
+			 "desc_pool_first          = %p\n"
+			 "desc_pool_last           = %p\n"
+			 "desc_next                = %p\n"
+			 "desc_completed           = %p\n",
+			 readl(ldev->eng_regs + 1),
+			 readl(ldev->eng_regs + 2),
+			 readl(ldev->eng_regs + 3),
+			 readl(ldev->eng_regs + 4),
+			 ldev->desc_pool_first,
+			 ldev->desc_pool_last,
+			 ldev->desc_next,
+			 ldev->desc_completed);
 }
+
 static DEVICE_ATTR(engine_regs, 0444, show_engine_regs, NULL);
 
 static const struct attribute *ndd_attr_list[] = {
@@ -91,17 +92,19 @@ static const struct attribute *ndd_attr_list[] = {
 static struct class *kpc_dma_class;
 
 /**********  Platform Driver Functions  **********/
-static
-int  kpc_dma_probe(struct platform_device *pldev)
+static int kpc_dma_probe(struct platform_device *pldev)
 {
 	struct resource *r = NULL;
 	int rv = 0;
 	dev_t dev;
 
-	struct kpc_dma_device *ldev = kzalloc(sizeof(struct kpc_dma_device), GFP_KERNEL);
+	struct kpc_dma_device *ldev =
+	    kzalloc(sizeof(struct kpc_dma_device), GFP_KERNEL);
 
 	if (!ldev) {
-		dev_err(&pldev->dev, "%s: unable to kzalloc space for kpc_dma_device\n", __func__);
+		dev_err(&pldev->dev,
+			"%s: unable to kzalloc space for kpc_dma_device\n",
+			__func__);
 		rv = -ENOMEM;
 		goto err_rv;
 	}
@@ -118,20 +121,23 @@ int  kpc_dma_probe(struct platform_device *pldev)
 	// Get Engine regs resource
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (!r) {
-		dev_err(&ldev->pldev->dev, "%s: didn't get the engine regs resource!\n", __func__);
+		dev_err(&ldev->pldev->dev,
+			"%s: didn't get the engine regs resource!\n", __func__);
 		rv = -ENXIO;
 		goto err_kfree;
 	}
 	ldev->eng_regs = ioremap_nocache(r->start, resource_size(r));
 	if (!ldev->eng_regs) {
-		dev_err(&ldev->pldev->dev, "%s: failed to ioremap engine regs!\n", __func__);
+		dev_err(&ldev->pldev->dev,
+			"%s: failed to ioremap engine regs!\n", __func__);
 		rv = -ENXIO;
 		goto err_kfree;
 	}
 
 	r = platform_get_resource(pldev, IORESOURCE_IRQ, 0);
 	if (!r) {
-		dev_err(&ldev->pldev->dev, "%s: didn't get the IRQ resource!\n", __func__);
+		dev_err(&ldev->pldev->dev, "%s: didn't get the IRQ resource!\n",
+			__func__);
 		rv = -ENXIO;
 		goto err_kfree;
 	}
@@ -139,23 +145,26 @@ int  kpc_dma_probe(struct platform_device *pldev)
 
 	// Setup miscdev struct
 	dev = MKDEV(assigned_major_num, pldev->id);
-	ldev->kpc_dma_dev = device_create(kpc_dma_class, &pldev->dev, dev, ldev, "kpc_dma%d", pldev->id);
+	ldev->kpc_dma_dev =
+	    device_create(kpc_dma_class, &pldev->dev, dev, ldev, "kpc_dma%d",
+			  pldev->id);
 	if (IS_ERR(ldev->kpc_dma_dev)) {
-		dev_err(&ldev->pldev->dev, "%s: device_create failed: %d\n", __func__, rv);
+		dev_err(&ldev->pldev->dev, "%s: device_create failed: %d\n",
+			__func__, rv);
 		goto err_kfree;
 	}
-
 	// Setup the DMA engine
 	rv = setup_dma_engine(ldev, 30);
 	if (rv) {
-		dev_err(&ldev->pldev->dev, "%s: failed to setup_dma_engine: %d\n", __func__, rv);
+		dev_err(&ldev->pldev->dev,
+			"%s: failed to setup_dma_engine: %d\n", __func__, rv);
 		goto err_misc_dereg;
 	}
-
 	// Setup the sysfs files
 	rv = sysfs_create_files(&(ldev->pldev->dev.kobj), ndd_attr_list);
 	if (rv) {
-		dev_err(&ldev->pldev->dev, "%s: Failed to add sysfs files: %d\n", __func__, rv);
+		dev_err(&ldev->pldev->dev,
+			"%s: Failed to add sysfs files: %d\n", __func__, rv);
 		goto err_destroy_eng;
 	}
 
@@ -173,8 +182,7 @@ int  kpc_dma_probe(struct platform_device *pldev)
 	return rv;
 }
 
-static
-int  kpc_dma_remove(struct platform_device *pldev)
+static int kpc_dma_remove(struct platform_device *pldev)
 {
 	struct kpc_dma_device *ldev = platform_get_drvdata(pldev);
 
@@ -185,7 +193,8 @@ int  kpc_dma_remove(struct platform_device *pldev)
 	sysfs_remove_files(&(ldev->pldev->dev.kobj), ndd_attr_list);
 	destroy_dma_engine(ldev);
 	kpc_dma_del_device(ldev);
-	device_destroy(kpc_dma_class, MKDEV(assigned_major_num, ldev->pldev->id));
+	device_destroy(kpc_dma_class,
+		       MKDEV(assigned_major_num, ldev->pldev->id));
 	kfree(ldev);
 
 	return 0;
@@ -193,10 +202,10 @@ int  kpc_dma_remove(struct platform_device *pldev)
 
 /**********  Driver Functions  **********/
 static struct platform_driver kpc_dma_plat_driver_i = {
-	.probe        = kpc_dma_probe,
-	.remove       = kpc_dma_remove,
+	.probe = kpc_dma_probe,
+	.remove = kpc_dma_remove,
 	.driver = {
-		.name   = KP_DRIVER_NAME_DMA_CONTROLLER,
+		.name = KP_DRIVER_NAME_DMA_CONTROLLER,
 	},
 };
 
@@ -205,9 +214,13 @@ int __init kpc_dma_driver_init(void)
 {
 	int err;
 
-	err = __register_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS, "kpc_dma", &kpc_dma_fops);
+	err =
+	    __register_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS,
+			      "kpc_dma", &kpc_dma_fops);
 	if (err < 0) {
-		pr_err("Can't allocate a major number (%d) for kpc_dma (err = %d)\n", KPC_DMA_CHAR_MAJOR, err);
+		pr_err
+		    ("Can't allocate a major number (%d) for kpc_dma (err = %d)\n",
+		     KPC_DMA_CHAR_MAJOR, err);
 		goto fail_chrdev_register;
 	}
 	assigned_major_num = err;
@@ -221,19 +234,23 @@ int __init kpc_dma_driver_init(void)
 
 	err = platform_driver_register(&kpc_dma_plat_driver_i);
 	if (err) {
-		pr_err("Can't register platform driver for kpc_dma (err = %d)\n", err);
+		pr_err
+		    ("Can't register platform driver for kpc_dma (err = %d)\n",
+		     err);
 		goto fail_platdriver_register;
 	}
 
 	return err;
 
-fail_platdriver_register:
+ fail_platdriver_register:
 	class_destroy(kpc_dma_class);
-fail_class_create:
-	__unregister_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS, "kpc_dma");
-fail_chrdev_register:
+ fail_class_create:
+	__unregister_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS,
+			    "kpc_dma");
+ fail_chrdev_register:
 	return err;
 }
+
 module_init(kpc_dma_driver_init);
 
 static
@@ -241,6 +258,8 @@ void __exit kpc_dma_driver_exit(void)
 {
 	platform_driver_unregister(&kpc_dma_plat_driver_i);
 	class_destroy(kpc_dma_class);
-	__unregister_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS, "kpc_dma");
+	__unregister_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS,
+			    "kpc_dma");
 }
+
 module_exit(kpc_dma_driver_exit);
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
index 4c8cc866b826..138875e85e54 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
@@ -19,44 +19,44 @@
 
 struct kp2000_device;
 struct kpc_dma_device {
-	struct list_head            list;
-	struct platform_device     *pldev;
-	u32 __iomem                *eng_regs;
-	struct device              *kpc_dma_dev;
-	struct kobject              kobj;
-	char                        name[16];
+	struct list_head list;
+	struct platform_device *pldev;
+	u32 __iomem *eng_regs;
+	struct device *kpc_dma_dev;
+	struct kobject kobj;
+	char name[16];
 
-	int                         dir; // DMA_FROM_DEVICE || DMA_TO_DEVICE
-	struct mutex                sem;
-	unsigned int                irq;
-	struct work_struct          irq_work;
+	int dir;		// DMA_FROM_DEVICE || DMA_TO_DEVICE
+	struct mutex sem;
+	unsigned int irq;
+	struct work_struct irq_work;
 
-	atomic_t                    open_count;
+	atomic_t open_count;
 
-	size_t                      accumulated_bytes;
-	u32                         accumulated_flags;
+	size_t accumulated_bytes;
+	u32 accumulated_flags;
 
 	// Descriptor "Pool" housekeeping
-	u32                         desc_pool_cnt;
-	struct dma_pool            *desc_pool;
-	struct kpc_dma_descriptor  *desc_pool_first;
-	struct kpc_dma_descriptor  *desc_pool_last;
+	u32 desc_pool_cnt;
+	struct dma_pool *desc_pool;
+	struct kpc_dma_descriptor *desc_pool_first;
+	struct kpc_dma_descriptor *desc_pool_last;
 
-	struct kpc_dma_descriptor  *desc_next;
-	struct kpc_dma_descriptor  *desc_completed;
+	struct kpc_dma_descriptor *desc_next;
+	struct kpc_dma_descriptor *desc_completed;
 };
 
 struct dev_private_data {
-	struct kpc_dma_device      *ldev;
-	u64                         card_addr;
-	u64                         user_ctl;
-	u64                         user_ctl_last;
-	u64                         user_sts;
+	struct kpc_dma_device *ldev;
+	u64 card_addr;
+	u64 user_ctl;
+	u64 user_ctl_last;
+	u64 user_sts;
 };
 
 struct kpc_dma_device *kpc_dma_lookup_device(int minor);
 
-extern const struct file_operations  kpc_dma_fops;
+extern const struct file_operations kpc_dma_fops;
 
 #define ENG_CAP_PRESENT                 0x00000001
 #define ENG_CAP_DIRECTION               0x00000002
@@ -82,16 +82,16 @@ extern const struct file_operations  kpc_dma_fops;
 #define ENG_CTL_DESC_FETCH_ERR_CLASS_MASK   0x700000
 
 struct aio_cb_data {
-	struct dev_private_data    *priv;
-	struct kpc_dma_device      *ldev;
-	struct completion  *cpl;
-	unsigned char       flags;
-	size_t              len;
-
-	unsigned int        page_count;
-	struct page       **user_pages;
-	struct sg_table     sgt;
-	int                 mapped_entry_count;
+	struct dev_private_data *priv;
+	struct kpc_dma_device *ldev;
+	struct completion *cpl;
+	unsigned char flags;
+	size_t len;
+
+	unsigned int page_count;
+	struct page **user_pages;
+	struct sg_table sgt;
+	int mapped_entry_count;
 };
 
 #define ACD_FLAG_DONE               0
@@ -101,27 +101,27 @@ struct aio_cb_data {
 
 struct kpc_dma_descriptor {
 	struct {
-		volatile u32  DescByteCount              :20;
-		volatile u32  DescStatusErrorFlags       :4;
-		volatile u32  DescStatusFlags            :8;
+		volatile u32 DescByteCount:20;
+		volatile u32 DescStatusErrorFlags:4;
+		volatile u32 DescStatusFlags:8;
 	};
-		volatile u32  DescUserControlLS;
-		volatile u32  DescUserControlMS;
-		volatile u32  DescCardAddrLS;
+	volatile u32 DescUserControlLS;
+	volatile u32 DescUserControlMS;
+	volatile u32 DescCardAddrLS;
 	struct {
-		volatile u32  DescBufferByteCount        :20;
-		volatile u32  DescCardAddrMS             :4;
-		volatile u32  DescControlFlags           :8;
+		volatile u32 DescBufferByteCount:20;
+		volatile u32 DescCardAddrMS:4;
+		volatile u32 DescControlFlags:8;
 	};
-		volatile u32  DescSystemAddrLS;
-		volatile u32  DescSystemAddrMS;
-		volatile u32  DescNextDescPtr;
+	volatile u32 DescSystemAddrLS;
+	volatile u32 DescSystemAddrMS;
+	volatile u32 DescNextDescPtr;
 
-		dma_addr_t    MyDMAAddr;
-		struct kpc_dma_descriptor   *Next;
+	dma_addr_t MyDMAAddr;
+	struct kpc_dma_descriptor *Next;
 
-		struct aio_cb_data  *acd;
-} __attribute__((packed));
+	struct aio_cb_data *acd;
+} __attribute__ ((packed));
 // DescControlFlags:
 #define DMA_DESC_CTL_SOP            BIT(7)
 #define DMA_DESC_CTL_EOP            BIT(6)
@@ -143,26 +143,24 @@ struct kpc_dma_descriptor {
 
 #define DMA_DESC_ALIGNMENT          0x20
 
-static inline
-u32  GetEngineCapabilities(struct kpc_dma_device *eng)
+static inline u32 GetEngineCapabilities(struct kpc_dma_device *eng)
 {
 	return readl(eng->eng_regs + 0);
 }
 
-static inline
-void  WriteEngineControl(struct kpc_dma_device *eng, u32 value)
+static inline void WriteEngineControl(struct kpc_dma_device *eng,
+				      u32 value)
 {
 	writel(value, eng->eng_regs + 1);
 }
 
-static inline
-u32  GetEngineControl(struct kpc_dma_device *eng)
+static inline u32 GetEngineControl(struct kpc_dma_device *eng)
 {
 	return readl(eng->eng_regs + 1);
 }
 
-static inline
-void  SetClearEngineControl(struct kpc_dma_device *eng, u32 set_bits, u32 clear_bits)
+static inline void SetClearEngineControl(struct kpc_dma_device *eng,
+					 u32 set_bits, u32 clear_bits)
 {
 	u32 val = GetEngineControl(eng);
 
@@ -171,52 +169,48 @@ void  SetClearEngineControl(struct kpc_dma_device *eng, u32 set_bits, u32 clear_
 	WriteEngineControl(eng, val);
 }
 
-static inline
-void  SetEngineNextPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor *desc)
+static inline void SetEngineNextPtr(struct kpc_dma_device *eng,
+				    struct kpc_dma_descriptor *desc)
 {
 	writel(desc->MyDMAAddr, eng->eng_regs + 2);
 }
 
-static inline
-void  SetEngineSWPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor *desc)
+static inline void SetEngineSWPtr(struct kpc_dma_device *eng,
+				  struct kpc_dma_descriptor *desc)
 {
 	writel(desc->MyDMAAddr, eng->eng_regs + 3);
 }
 
-static inline
-void  ClearEngineCompletePtr(struct kpc_dma_device *eng)
+static inline void ClearEngineCompletePtr(struct kpc_dma_device *eng)
 {
 	writel(0, eng->eng_regs + 4);
 }
 
-static inline
-u32  GetEngineCompletePtr(struct kpc_dma_device *eng)
+static inline u32 GetEngineCompletePtr(struct kpc_dma_device *eng)
 {
 	return readl(eng->eng_regs + 4);
 }
 
-static inline
-void  lock_engine(struct kpc_dma_device *eng)
+static inline void lock_engine(struct kpc_dma_device *eng)
 {
 	BUG_ON(eng == NULL);
 	mutex_lock(&eng->sem);
 }
 
-static inline
-void  unlock_engine(struct kpc_dma_device *eng)
+static inline void unlock_engine(struct kpc_dma_device *eng)
 {
 	BUG_ON(eng == NULL);
 	mutex_unlock(&eng->sem);
 }
 
 /// Shared Functions
-void  start_dma_engine(struct kpc_dma_device *eng);
-int   setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt);
-void  stop_dma_engine(struct kpc_dma_device *eng);
-void  destroy_dma_engine(struct kpc_dma_device *eng);
-void  clear_desc(struct kpc_dma_descriptor *desc);
-int   count_descriptors_available(struct kpc_dma_device *eng);
-void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags);
-
-#endif /* KPC_DMA_DRIVER_H */
-
+void start_dma_engine(struct kpc_dma_device *eng);
+int setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt);
+void stop_dma_engine(struct kpc_dma_device *eng);
+void destroy_dma_engine(struct kpc_dma_device *eng);
+void clear_desc(struct kpc_dma_descriptor *desc);
+int count_descriptors_available(struct kpc_dma_device *eng);
+void transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count,
+			  u32 flags);
+
+#endif				/* KPC_DMA_DRIVER_H */
-- 
2.22.0

