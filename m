Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C368C20675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHplIj21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfEVMO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:14:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41854 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfEVMOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:14:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id m18so1265470qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrrFf5jPyFl/413hkwocQVvbRFpG3X2ac3ZXAgGL0fk=;
        b=BHplIj21ouH1CPEeBdRJET6uPmvNfutmVv3Q/qYh61PSD48ja48H0btCCwbHETZ4ln
         PgIS/XJf/9f/8o7l1QSJN+JLK8gfkH9zf/RiNnl3bpMKUJ9++Ng0V1J+OzDqjehbp6Sv
         SZ7vKRYQfh8QXsXr8ZxxR2Yr4Oupnkz2UeqvsiinISRSAtcldtcFaGGH8KOL5aevo3CF
         G9cLWfn8u10UVRbywhVNLSSLnGlTnWDuCsSfQZ26ocvcYZTP7CA1gP7AYhmUuN6GxHzY
         CDkdCIG7IA9Gk5KwIjpYu7SVDFKFFKYxCMtUe6ROgscIghzI6pmWjhhlDTp50Degh+6O
         O4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrrFf5jPyFl/413hkwocQVvbRFpG3X2ac3ZXAgGL0fk=;
        b=dGSilaoshnsx0x+JwUUwhz/nU9l1N0998sQ6wskJJSxxPS3CECVAENO8KHHSkLXWaD
         dNJCkGIpc1dh1f4QRgUJ3REu1lqMED5CLvjvLBiziiz4iAxxY7NbDOp9TTTz1dnUK23C
         7vRRhTbzcqApB6Iq2nuHocinkSMwpxke0TyJuBfSqwaSa/FLErc280b+WtCUuM56iLOc
         NHXGk4FtAXINdt7wA2jQgsfcp1y3njvD+IRdL7Xk3vtSc6SPlh38e0Xx0Kdla70n3pn3
         7P2mLSOmdpKklP84AOhXICy+Y7uynFfInGWUeMXChc+djx+EcSEtxz5t+m5FT/Vj2ZJp
         8YMA==
X-Gm-Message-State: APjAAAUV5jcGMmPF4eSjc7HaAkIuwXOkThRMPYdh9fU+i7EXdsXrUztR
        yBln3ra3EKrhRnvzzDyihKs=
X-Google-Smtp-Source: APXvYqzTsLVHeGnRIcM/Sdgvrh+ueNPL72MIEPFklGrdTHoMOwTKEnlODCixsbJFa/VgTf/JWeup6g==
X-Received: by 2002:a05:620a:1641:: with SMTP id c1mr68784078qko.103.1558527293814;
        Wed, 22 May 2019 05:14:53 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id w2sm8742070qto.19.2019.05.22.05.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:14:53 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 5/6] staging: kpc2000: kpc_i2c: Remove unnecessary function tracing prints
Date:   Wed, 22 May 2019 12:14:01 +0000
Message-Id: <47d7da2db4c4cbb40476fb80383184525919c65b.1558526487.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558526487.git.gneukum1@gmail.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the functions in kpc_i2c log debug-level messages to the
kernel log message buffer upon invocation. This is unnecessary, as
debugging tools like kgdb, kdb, etc. or the tracing tool ftrace
should be able to provide this same information. Therefore, remove
these print statements.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 5d98ed54c05c..f9259c06b605 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -139,8 +139,6 @@ static int i801_check_pre(struct i2c_device *priv)
 {
 	int status;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_HOST_BUSY) {
 		dev_err(&priv->adapter.dev, "SMBus is busy, can't use it! (status=%x)\n", status);
@@ -165,8 +163,6 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 {
 	int result = 0;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	/* If the SMBus is still busy, we give up */
 	if (timeout) {
 		dev_err(&priv->adapter.dev, "Transaction timeout\n");
@@ -214,8 +210,6 @@ static int i801_transaction(struct i2c_device *priv, int xact)
 	int result;
 	int timeout = 0;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	result = i801_check_pre(priv);
 	if (result < 0)
 		return result;
@@ -244,8 +238,6 @@ static void i801_wait_hwpec(struct i2c_device *priv)
 	int timeout = 0;
 	int status;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	do {
 		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
@@ -262,8 +254,6 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
 	int i, len;
 	int status;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
 
 	/* Use 32-byte buffer to process this transaction */
@@ -298,8 +288,6 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 	int result;
 	int timeout;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	result = i801_check_pre(priv);
 	if (result < 0)
 		return result;
@@ -364,8 +352,6 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 
 static int i801_set_block_buffer_mode(struct i2c_device *priv)
 {
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
 	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) == 0)
 		return -EIO;
@@ -378,8 +364,6 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 	int result = 0;
 	//unsigned char hostc;
 
-	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
-
 	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (read_write == I2C_SMBUS_WRITE) {
 			/* set I2C_EN bit in configuration register */
@@ -427,10 +411,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	int ret, xact = 0;
 	struct i2c_device *priv = i2c_get_adapdata(adap);
 
-	dev_dbg(&priv->adapter.dev,
-		"%s (addr=%0d)  flags=%x  read_write=%x  command=%x  size=%x",
-		__func__, addr, flags, read_write, command, size);
-
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
 
 	switch (size) {
@@ -605,9 +585,6 @@ int pi2c_probe(struct platform_device *pldev)
 	struct i2c_device *priv;
 	struct resource *res;
 
-	dev_dbg(&pldev->dev, "%s(pldev = %p '%s')\n", __func__, pldev,
-		pldev->name);
-
 	priv = devm_kzalloc(&pldev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -653,9 +630,6 @@ int pi2c_remove(struct platform_device *pldev)
 {
 	struct i2c_device *lddev;
 
-	dev_dbg(&pldev->dev, "%s(pldev = %p '%s')\n", __func__, pldev,
-		pldev->name);
-
 	lddev = (struct i2c_device *)pldev->dev.platform_data;
 
 	i2c_del_adapter(&lddev->adapter);
-- 
2.21.0

