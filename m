Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBE8C04E87
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5021783
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyAG7rMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfERCbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:31:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41261 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfERCbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:31:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id y22so10229792qtn.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Jx7wOgjO71cyvryJW/ALg7Y34849UqscRe/zdQWObUQ=;
        b=HyAG7rMv3BEUuyj9kZ97Pyx3nP2G+He64Vc/T+z5iEq6S7vbPpTTEJ5CsyefdAkMXP
         OFEmK7e4xWR6nL4IHQNz6aOXhCFeTuWgC0GieX63aTM5rQjg+egveUFW5em71vAJRbt7
         B+MZtKenHp7mGKN1YzIG4mmDz7uwzQQHOmRVAtuNgDw8wTPsdDA0BzXRvl238WdzF2ib
         jZHM1y4Cm3WqdHFOJUyoBBzcrZVSJCGdHZuuvwulX7VdSBeZVAEVPkcnvx4fzLoFbxH7
         Qzhx+r+qud5zk7vQwuei270GYm+yc5/rCB1Nt2/xPT+zpJgLg8/zRlUnxQZZ+0hcysrb
         xU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jx7wOgjO71cyvryJW/ALg7Y34849UqscRe/zdQWObUQ=;
        b=joifbC2oT1zLJCP/Xs7+gv48PL1l3Qhmz+bimwZubogrpRZqSvz6WvIsG+SshzWtyw
         b4l9PB2K28YOhwRubm2nBX8jxv2gwYBs01By1EqAFfKzJb1LI8E7vRIICCb9Ha4tdAHs
         76Si6TNu3VY9xIUolmlujeIenHNHbN/qYn/oZX1cqLxrbM7h4tfDA/vK3k+GkLRjT6Ru
         l+tD3oNd6MNtb93syTB7TPWkmSjiGB0pGbRKmjdmummNCRQshFvzhiRAQmtvS0XoqlAS
         jId43xK2BtHIY2OGlE3TKQx9BuRvV/SQeNbCPOqT8BIlsiV06cFWBURhCi70w4Opu8yg
         lxGw==
X-Gm-Message-State: APjAAAXmLwFe5N9G3Hn5Lsb5ZqrO1Lr+SXd7qHIb6Q2noIl9ZP8M2FKt
        IkVepm/tZj2dohSJri06z9o=
X-Google-Smtp-Source: APXvYqzV3iF+9yyRJp56As3DgJ4K6qFxCx3cRrp3JFL7fXnyUl0tb1yWsiDUqRCBe0D02GZmC5TdzA==
X-Received: by 2002:aed:354c:: with SMTP id b12mr53038932qte.251.1558146671624;
        Fri, 17 May 2019 19:31:11 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n66sm5210322qke.6.2019.05.17.19.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 19:31:11 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     gneukum1@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: kpc2000: kpc_i2c: fixup block comment style in i2c_driver.c
Date:   Sat, 18 May 2019 02:30:00 +0000
Message-Id: <1103bc883e10f356a4eb6f78ec3c52ebe1f9b043.1558146549.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558146549.git.gneukum1@gmail.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throughout i2c_driver.c, there are numerous deviations from the two
standards of:
	- placing a '*' at the beginning of every line containing a
	  block comment.
	- placing the closing comment marker '*/' on a new line.

Instead, use a block comment style that is more consistent with the
prescribed guidelines.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 36 ++++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 03e401322a18..986148c72185 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -137,7 +137,8 @@ MODULE_PARM_DESC(disable_features, "Disable selected driver features");
 #define outb_p(d,a) writeq(d,(void*)a)
 
 /* Make sure the SMBus host is ready to start transmitting.
-   Return 0 if it is, -EBUSY if it is not. */
+ * Return 0 if it is, -EBUSY if it is not.
+ */
 static int i801_check_pre(struct i2c_device *priv)
 {
 	int status;
@@ -226,7 +227,8 @@ static int i801_transaction(struct i2c_device *priv, int xact)
 		return result;
 	}
 	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
-	 * INTREN, SMBSCMD are passed in xact */
+	 * INTREN, SMBSCMD are passed in xact
+	 */
 	outb_p(xact | I801_START, SMBHSTCNT(priv));
 
 	/* We will always wait for a fraction of a second! */
@@ -424,8 +426,9 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 	}
 
 	/* Experience has shown that the block buffer can only be used for
-	   SMBus (not I2C) block transactions, even though the datasheet
-	   doesn't mention this limitation. */
+	 * SMBus (not I2C) block transactions, even though the datasheet
+	 * doesn't mention this limitation.
+	 */
 	if ((priv->features & FEATURE_BLOCK_BUFFER) && command != I2C_SMBUS_I2C_BLOCK_DATA && i801_set_block_buffer_mode(priv) == 0) {
 		result = i801_block_transaction_by_block(priv, data, read_write, hwpec);
 	} else {
@@ -499,11 +502,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	case I2C_SMBUS_I2C_BLOCK_DATA:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_I2C_BLOCK_DATA\n");
 		/* NB: page 240 of ICH5 datasheet shows that the R/#W
-		 * bit should be cleared here, even when reading */
+		 * bit should be cleared here, even when reading
+		 */
 		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
 		if (read_write == I2C_SMBUS_READ) {
 			/* NB: page 240 of ICH5 datasheet also shows
-			 * that DATA1 is the cmd field when reading */
+			 * that DATA1 is the cmd field when reading
+			 */
 			outb_p(command, SMBHSTDAT1(priv));
 		} else {
 			outb_p(command, SMBHSTCMD(priv));
@@ -533,8 +538,9 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	}
 
 	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
-	   time, so we forcibly disable it after every transaction. Turn off
-	   E32B for the same reason. */
+	 * time, so we forcibly disable it after every transaction. Turn off
+	 * E32B for the same reason.
+	 */
 	if (hwpec || block) {
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec || block\n");
 		outb_p(inb_p(SMBAUXCTL(priv)) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
@@ -573,13 +579,13 @@ static u32 i801_func(struct i2c_adapter *adapter)
 	struct i2c_device *priv = i2c_get_adapdata(adapter);
 
 	/* original settings
-	   u32 f = I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	   I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	   I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
-	   ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
-	   ((priv->features & FEATURE_I2C_BLOCK_READ) ?
-	   I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
-	*/
+	 * u32 f = I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	 * I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	 * I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
+	 * ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
+	 * ((priv->features & FEATURE_I2C_BLOCK_READ) ?
+	 * I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
+	 */
 
 	// http://lxr.free-electrons.com/source/include/uapi/linux/i2c.h#L85
 
-- 
2.21.0

