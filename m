Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F21C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E072B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfFRMi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:38:59 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50106 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfFRMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:38:59 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2019 08:38:57 EDT
Received: from faui01d.informatik.uni-erlangen.de (faui01d.informatik.uni-erlangen.de [131.188.60.130])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 4A91E24162B;
        Tue, 18 Jun 2019 14:29:43 +0200 (CEST)
Received: by faui01d.informatik.uni-erlangen.de (Postfix, from userid 305940)
        id 3DC9C15C12A5; Tue, 18 Jun 2019 14:29:43 +0200 (CEST)
From:   Fabian Krueger <fabian.krueger@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Fabian Krueger <fabian.krueger@fau.de>, linux-kernel@i4.cs.fau.de,
        Michael Scheiderer <michael.scheiderer@fau.de>
Subject: [PATCH] staging: kpc2000: added linebreaks
Date:   Tue, 18 Jun 2019 14:29:41 +0200
Message-Id: <20190618122941.5583-1-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix some checkpatch-warnings some lines of this module had to be
shortened so that they do not exceed 80 characters per line.
This refractoring makes the code more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 153 ++++++++++++++++++--------
 1 file changed, 105 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 69e8773c1ef8..4340a988523c 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -100,7 +100,8 @@ struct i2c_device {
 #define SMBHSTSTS_INTR          0x02
 #define SMBHSTSTS_HOST_BUSY     0x01
 
-#define STATUS_FLAGS        (SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | SMBHSTSTS_INTR)
+#define STATUS_FLAGS        (SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | \
+		SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | SMBHSTSTS_INTR)
 
 /* Older devices have their ID defined in <linux/pci_ids.h> */
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS       0x1c22
@@ -137,17 +138,19 @@ static int i801_check_pre(struct i2c_device *priv)
 
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
@@ -163,15 +166,20 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 	if (timeout) {
 		dev_err(&priv->adapter.dev, "Transaction timeout\n");
 		/* try to stop the current command */
-		dev_dbg(&priv->adapter.dev, "Terminating the current operation\n");
-		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL, SMBHSTCNT(priv));
+		dev_dbg(&priv->adapter.dev,
+			"Terminating the current operation\n");
+		outb_p(inb_p(SMBHSTCNT(priv))
+			| SMBHSTCNT_KILL, SMBHSTCNT(priv));
 		usleep_range(1000, 2000);
-		outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL), SMBHSTCNT(priv));
+		outb_p(inb_p(SMBHSTCNT(priv)) &
+				(~SMBHSTCNT_KILL), SMBHSTCNT(priv));
 
 		/* Check if it worked */
 		status = inb_p(SMBHSTSTS(priv));
-		if ((status & SMBHSTSTS_HOST_BUSY) || !(status & SMBHSTSTS_FAILED))
-			dev_err(&priv->adapter.dev, "Failed terminating the transaction\n");
+		if ((status & SMBHSTSTS_HOST_BUSY) ||
+		    !(status & SMBHSTSTS_FAILED))
+			dev_err(&priv->adapter.dev,
+				"Failed terminating the transaction\n");
 		outb_p(STATUS_FLAGS, SMBHSTSTS(priv));
 		return -ETIMEDOUT;
 	}
@@ -194,7 +202,9 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
 		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status)
-			dev_warn(&priv->adapter.dev, "Failed clearing status flags at end of transaction (%02x)\n", status);
+			dev_warn(&priv->adapter.dev,
+				 "Failed clearing status flags at end of transaction (%02x)\n",
+				 status);
 	}
 
 	return result;
@@ -245,7 +255,9 @@ static void i801_wait_hwpec(struct i2c_device *priv)
 	outb_p(status, SMBHSTSTS(priv));
 }
 
-static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_smbus_data *data, char read_write, int hwpec)
+static int i801_block_transaction_by_block(struct i2c_device *priv,
+					   union i2c_smbus_data *data,
+					   char read_write, int hwpec)
 {
 	int i, len;
 	int status;
@@ -260,7 +272,8 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 	}
 
-	status = i801_transaction(priv, I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
+	status = i801_transaction(priv, I801_BLOCK_DATA | ENABLE_INT9 |
+			I801_PEC_EN * hwpec);
 	if (status)
 		return status;
 
@@ -276,7 +289,10 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
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
@@ -302,7 +318,8 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 			else
 				smbcmd = I801_BLOCK_LAST;
 		} else {
-			if (command == I2C_SMBUS_I2C_BLOCK_DATA && read_write == I2C_SMBUS_READ)
+			if (command == I2C_SMBUS_I2C_BLOCK_DATA &&
+			    read_write == I2C_SMBUS_READ)
 				smbcmd = I801_I2C_BLOCK_DATA;
 			else
 				smbcmd = I801_BLOCK_DATA;
@@ -310,24 +327,31 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT(priv));
 
 		if (i == 1)
-			outb_p(inb(SMBHSTCNT(priv)) | I801_START, SMBHSTCNT(priv));
+			outb_p(inb(SMBHSTCNT(priv)) |
+					I801_START, SMBHSTCNT(priv));
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
 		do {
 			usleep_range(250, 500);
 			status = inb_p(SMBHSTSTS(priv));
-		} while ((!(status & SMBHSTSTS_BYTE_DONE)) && (timeout++ < MAX_RETRIES));
+		} while ((!(status & SMBHSTSTS_BYTE_DONE)) &&
+				(timeout++ < MAX_RETRIES));
 
 		result = i801_check_post(priv, status, timeout > MAX_RETRIES);
 		if (result < 0)
 			return result;
-		if (i == 1 && read_write == I2C_SMBUS_READ && command != I2C_SMBUS_I2C_BLOCK_DATA) {
+		if (i == 1 && read_write == I2C_SMBUS_READ &&
+		    command != I2C_SMBUS_I2C_BLOCK_DATA) {
 			len = inb_p(SMBHSTDAT0(priv));
 			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
-				dev_err(&priv->adapter.dev, "Illegal SMBus block read size %d\n", len);
+				dev_err(&priv->adapter.dev,
+					"Illegal SMBus block read size %d\n",
+					len);
 				/* Recover */
-				while (inb_p(SMBHSTSTS(priv)) & SMBHSTSTS_HOST_BUSY)
-					outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
+				while (inb_p(SMBHSTSTS(priv)) &
+					SMBHSTSTS_HOST_BUSY)
+					outb_p(SMBHSTSTS_BYTE_DONE,
+					       SMBHSTSTS(priv));
 				outb_p(SMBHSTSTS_INTR, SMBHSTSTS(priv));
 				return -EPROTO;
 			}
@@ -355,7 +379,9 @@ static int i801_set_block_buffer_mode(struct i2c_device *priv)
 }
 
 /* Block transaction function */
-static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data *data, char read_write, int command, int hwpec)
+static int i801_block_transaction(struct i2c_device *priv,
+				  union i2c_smbus_data *data, char read_write,
+				  int command, int hwpec)
 {
 	int result = 0;
 	//unsigned char hostc;
@@ -364,15 +390,19 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 		if (read_write == I2C_SMBUS_WRITE) {
 			/* set I2C_EN bit in configuration register */
 			//TODO: Figure out the right thing to do here...
-			//pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &hostc);
-			//pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc | SMBHSTCFG_I2C_EN);
+			//pci_read_config_byte(priv->pci_dev, SMBHSTCFG,
+			//		       &hostc);
+			//pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
+			//			hostc | SMBHSTCFG_I2C_EN);
 		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
-			dev_err(&priv->adapter.dev, "I2C block read is unsupported!\n");
+			dev_err(&priv->adapter.dev,
+				"I2C block read is unsupported!\n");
 			return -EOPNOTSUPP;
 		}
 	}
 
-	if (read_write == I2C_SMBUS_WRITE || command == I2C_SMBUS_I2C_BLOCK_DATA) {
+	if (read_write == I2C_SMBUS_WRITE ||
+	    command == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (data->block[0] < 1)
 			data->block[0] = 1;
 		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
@@ -385,13 +415,19 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 	 * SMBus (not I2C) block transactions, even though the datasheet
 	 * doesn't mention this limitation.
 	 */
-	if ((priv->features & FEATURE_BLOCK_BUFFER) && command != I2C_SMBUS_I2C_BLOCK_DATA && i801_set_block_buffer_mode(priv) == 0)
-		result = i801_block_transaction_by_block(priv, data, read_write, hwpec);
+	if ((priv->features & FEATURE_BLOCK_BUFFER) &&
+	    command != I2C_SMBUS_I2C_BLOCK_DATA &&
+	    i801_set_block_buffer_mode(priv) == 0)
+		result = i801_block_transaction_by_block(priv, data,
+							 read_write, hwpec);
 	else
-		result = i801_block_transaction_byte_by_byte(priv, data, read_write, command, hwpec);
+		result = i801_block_transaction_byte_by_byte(priv, data,
+							     read_write,
+							     command, hwpec);
 	if (result == 0 && hwpec)
 		i801_wait_hwpec(priv);
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA && read_write == I2C_SMBUS_WRITE) {
+	if (command == I2C_SMBUS_I2C_BLOCK_DATA &&
+	    read_write == I2C_SMBUS_WRITE) {
 		/* restore saved configuration register value */
 		//TODO: Figure out the right thing to do here...
 		//pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
@@ -400,32 +436,39 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 }
 
 /* Return negative errno on error. */
-static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags, char read_write, u8 command, int size, union i2c_smbus_data *data)
+static s32 i801_access(struct i2c_adapter *adap, u16 addr,
+		       unsigned short flags, char read_write, u8 command,
+		       int size, union i2c_smbus_data *data)
 {
 	int hwpec;
 	int block = 0;
 	int ret, xact = 0;
 	struct i2c_device *priv = i2c_get_adapdata(adap);
 
-	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
+	hwpec = (priv->features & FEATURE_SMBUS_PEC) &&
+		(flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK &&
+		size != I2C_SMBUS_I2C_BLOCK_DATA;
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_QUICK\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) |
+		       (read_write & 0x01), SMBHSTADD(priv));
 		xact = I801_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BYTE\n");
 
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) |
+		       (read_write & 0x01), SMBHSTADD(priv));
 		if (read_write == I2C_SMBUS_WRITE)
 			outb_p(command, SMBHSTCMD(priv));
 		xact = I801_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BYTE_DATA\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) |
+		       (read_write & 0x01), SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
 		if (read_write == I2C_SMBUS_WRITE)
 			outb_p(data->byte, SMBHSTDAT0(priv));
@@ -433,7 +476,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		break;
 	case I2C_SMBUS_WORD_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_WORD_DATA\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) |
+		       (read_write & 0x01), SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
 		if (read_write == I2C_SMBUS_WRITE) {
 			outb_p(data->word & 0xff, SMBHSTDAT0(priv));
@@ -443,7 +487,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BLOCK_DATA\n");
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01), SMBHSTADD(priv));
+		outb_p(((addr & 0x7f) << 1) |
+		       (read_write & 0x01), SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
 		block = 1;
 		break;
@@ -464,22 +509,26 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		block = 1;
 		break;
 	default:
-		dev_dbg(&priv->adapter.dev, "  [acc] Unsupported transaction %d\n", size);
+		dev_dbg(&priv->adapter.dev,
+			"  [acc] Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
 	if (hwpec) { /* enable/disable hardware PEC */
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec: yes\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) |
+		       SMBAUXCTL_CRC, SMBAUXCTL(priv));
 	} else {
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec: no\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC), SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) &
+		       (~SMBAUXCTL_CRC), SMBAUXCTL(priv));
 	}
 
 	if (block) {
 		//ret = 0;
 		dev_dbg(&priv->adapter.dev, "  [acc] block: yes\n");
-		ret = i801_block_transaction(priv, data, read_write, size, hwpec);
+		ret = i801_block_transaction(priv, data, read_write, size,
+					     hwpec);
 	} else {
 		dev_dbg(&priv->adapter.dev, "  [acc] block: no\n");
 		ret = i801_transaction(priv, xact | ENABLE_INT9);
@@ -491,7 +540,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	 */
 	if (hwpec || block) {
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec || block\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) &
+		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 	}
 	if (block) {
 		dev_dbg(&priv->adapter.dev, "  [acc] block\n");
@@ -502,19 +552,22 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		return ret;
 	}
 	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK)) {
-		dev_dbg(&priv->adapter.dev, "  [acc] I2C_SMBUS_WRITE || I801_QUICK  -> ret 0\n");
+		dev_dbg(&priv->adapter.dev,
+			"  [acc] I2C_SMBUS_WRITE || I801_QUICK  -> ret 0\n");
 		return 0;
 	}
 
 	switch (xact & 0x7f) {
 	case I801_BYTE:  /* Result put in SMBHSTDAT0 */
 	case I801_BYTE_DATA:
-		dev_dbg(&priv->adapter.dev, "  [acc] I801_BYTE or I801_BYTE_DATA\n");
+		dev_dbg(&priv->adapter.dev,
+			"  [acc] I801_BYTE or I801_BYTE_DATA\n");
 		data->byte = inb_p(SMBHSTDAT0(priv));
 		break;
 	case I801_WORD_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] I801_WORD_DATA\n");
-		data->word = inb_p(SMBHSTDAT0(priv)) + (inb_p(SMBHSTDAT1(priv)) << 8);
+		data->word = inb_p(SMBHSTDAT0(priv)) +
+			     (inb_p(SMBHSTDAT1(priv)) << 8);
 		break;
 	}
 	return 0;
@@ -539,7 +592,8 @@ static u32 i801_func(struct i2c_adapter *adapter)
 		I2C_FUNC_I2C                     | /* 0x00000001 (I enabled this one) */
 		!I2C_FUNC_10BIT_ADDR             | /* 0x00000002 */
 		!I2C_FUNC_PROTOCOL_MANGLING      | /* 0x00000004 */
-		((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) | /* 0x00000008 */
+		((priv->features & FEATURE_SMBUS_PEC) ?
+			 I2C_FUNC_SMBUS_PEC : 0) | /* 0x00000008 */
 		!I2C_FUNC_SMBUS_BLOCK_PROC_CALL  | /* 0x00008000 */
 		I2C_FUNC_SMBUS_QUICK             | /* 0x00010000 */
 		!I2C_FUNC_SMBUS_READ_BYTE        | /* 0x00020000 */
@@ -551,7 +605,8 @@ static u32 i801_func(struct i2c_adapter *adapter)
 		!I2C_FUNC_SMBUS_PROC_CALL        | /* 0x00800000 */
 		!I2C_FUNC_SMBUS_READ_BLOCK_DATA  | /* 0x01000000 */
 		!I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | /* 0x02000000 */
-		((priv->features & FEATURE_I2C_BLOCK_READ) ? I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) | /* 0x04000000 */
+		((priv->features & FEATURE_I2C_BLOCK_READ) ?
+			 I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) | /* 0x04000000 */
 		I2C_FUNC_SMBUS_WRITE_I2C_BLOCK   | /* 0x08000000 */
 
 		I2C_FUNC_SMBUS_BYTE              | /* _READ_BYTE  _WRITE_BYTE */
@@ -611,8 +666,10 @@ static int pi2c_probe(struct platform_device *pldev)
 	/* Retry up to 3 times on lost arbitration */
 	priv->adapter.retries = 3;
 
-	//snprintf(priv->adapter.name, sizeof(priv->adapter.name), "Fake SMBus I801 adapter at %04lx", priv->smba);
-	snprintf(priv->adapter.name, sizeof(priv->adapter.name), "Fake SMBus I801 adapter");
+	//snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+	//	   "Fake SMBus I801 adapter at %04lx", priv->smba);
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+		 "Fake SMBus I801 adapter");
 
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
-- 
2.19.1

