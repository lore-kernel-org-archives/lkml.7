Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714CC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36821773
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhEakHBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfERCbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:31:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36041 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfERCbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:31:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so5669922qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 19:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NZaB6D1v98BSotvfZL2UYvLWY18MGsNTAI6RIeVlR9A=;
        b=mhEakHBCsSo1vVLiZzDZ24I9vPAulkvQqO9q3eJQWCDmrjVmDQ1TGGoOXp/4rHREdC
         t8i/LLizPaikksaU7F7jiyPkYgwKagRwUyebTPft8eqtXD0FfoFtnkq+7MfUddkIf7Bv
         LvMyh5Bm9VJ5xKpfoQPNr7S7Kt+gs0xu7ZhJekfIs76iTX509aKPjO6L8lTmtC1anWT0
         y9gso/Tsj84CsNkUAnNhLUpFnaHLK4vwpiJDKB2GWY4dCwrIOH7v/oWv34eF9H6kuOWg
         7VaRPmSIW4ogTPqxz1W+r66PwmUhiSfN1OakzM4oh1uIc0IikVGrVUT+bQTmgVwayUN/
         JjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZaB6D1v98BSotvfZL2UYvLWY18MGsNTAI6RIeVlR9A=;
        b=nSS83H2/QEQ5jwrz3h6XJ7dO4ZKFWY5i7BSXsjET2FDsJ4Jf+q/HggOSc9pDYwFFqd
         AzO17qxhyTAuCPQZgkVkJxYb0HWtXhB3bji1qHxvYHTmYv+a0kVRbXdAAThnS13gRjr7
         Oe4UkqRlWNHg3c5EY0pPhgfq9wh+fb5n5e4JVqFEqDL+lrGJMPq5UlGgZKBLoIxpRcfv
         fPdYy1ltKnfHWfHTgUpydEmmoTpR3cx312WJj72QQPTkXYuotvN5Ikg+QCcEHXhXJKRX
         CjP9Q5sztxmnSQd3UZKxPnLm67GOyhPy+xzF5T/pqrM57JO8xhsXQxlRCx5eBwbAnRAX
         lukA==
X-Gm-Message-State: APjAAAVTHQXBTin9/OwypVlgQCtW7COiIB6YSGMQiH48IRb4GWmhIeuw
        RuaBcISQw6El2ycKBeYPIM0=
X-Google-Smtp-Source: APXvYqzHiOWZ0xPRM7wHEPEZLPiw5BWmrmcqxL+OCBwewQIJF14vonB6BWTQPXTRHNneEj5WIvjZ+w==
X-Received: by 2002:a05:620a:15ac:: with SMTP id f12mr37585531qkk.311.1558146670637;
        Fri, 17 May 2019 19:31:10 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n66sm5210322qke.6.2019.05.17.19.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 19:31:10 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     gneukum1@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: kpc2000: kpc_i2c: use %s with __func__ identifier in log messages
Date:   Sat, 18 May 2019 02:29:59 +0000
Message-Id: <ffd66b415e67f6b03483a6ee57b7b3dc0bab388f.1558146549.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558146549.git.gneukum1@gmail.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throughout i2c_driver.c, there are instances where the log strings
contain the function's name hardcoded into the string. Instead, use the
printk conversion specifier '%s' with the __func__ preprocessor
identifier to more maintainably print the function's name.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 27 +++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 9b9de81c8548..03e401322a18 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -142,7 +142,7 @@ static int i801_check_pre(struct i2c_device *priv)
 {
 	int status;
 
-	dev_dbg(&priv->adapter.dev, "i801_check_pre\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_HOST_BUSY) {
@@ -168,7 +168,7 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 {
 	int result = 0;
 
-	dev_dbg(&priv->adapter.dev, "i801_check_post\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout) {
@@ -219,7 +219,7 @@ static int i801_transaction(struct i2c_device *priv, int xact)
 	int result;
 	int timeout = 0;
 
-	dev_dbg(&priv->adapter.dev, "i801_transaction\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	result = i801_check_pre(priv);
 	if (result < 0) {
@@ -250,7 +250,7 @@ static void i801_wait_hwpec(struct i2c_device *priv)
 	int timeout = 0;
 	int status;
 
-	dev_dbg(&priv->adapter.dev, "i801_wait_hwpec\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	do {
 		usleep_range(250, 500);
@@ -269,7 +269,7 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
 	int i, len;
 	int status;
 
-	dev_dbg(&priv->adapter.dev, "i801_block_transaction_by_block\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
 
@@ -309,7 +309,7 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 	int result;
 	int timeout;
 
-	dev_dbg(&priv->adapter.dev, "i801_block_transaction_byte_by_byte\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	result = i801_check_pre(priv);
 	if (result < 0) {
@@ -383,7 +383,7 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 
 static int i801_set_block_buffer_mode(struct i2c_device *priv)
 {
-	dev_dbg(&priv->adapter.dev, "i801_set_block_buffer_mode\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
 	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) == 0) {
@@ -398,7 +398,7 @@ static int i801_block_transaction(struct i2c_device *priv, union i2c_smbus_data
 	int result = 0;
 	//unsigned char hostc;
 
-	dev_dbg(&priv->adapter.dev, "i801_block_transaction\n");
+	dev_dbg(&priv->adapter.dev, "%s\n", __func__);
 
 	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (read_write == I2C_SMBUS_WRITE) {
@@ -450,8 +450,9 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	int ret, xact = 0;
 	struct i2c_device *priv = i2c_get_adapdata(adap);
 
-	dev_dbg(&priv->adapter.dev, "i801_access (addr=%0d)  flags=%x  read_write=%x  command=%x  size=%x",
-			addr, flags, read_write, command, size );
+	dev_dbg(&priv->adapter.dev,
+		"%s (addr=%0d)  flags=%x  read_write=%x  command=%x  size=%x",
+		__func__, addr, flags, read_write, command, size);
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
 
@@ -626,7 +627,8 @@ int pi2c_probe(struct platform_device *pldev)
 	struct i2c_device *priv;
 	struct resource *res;
 
-	dev_dbg(&pldev->dev, "pi2c_probe(pldev = %p '%s')\n", pldev, pldev->name);
+	dev_dbg(&pldev->dev, "%s(pldev = %p '%s')\n", __func__, pldev,
+		pldev->name);
 
 	priv = devm_kzalloc(&pldev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -673,7 +675,8 @@ int pi2c_probe(struct platform_device *pldev)
 int pi2c_remove(struct platform_device *pldev)
 {
 	struct i2c_device *lddev;
-	dev_dbg(&pldev->dev, "pi2c_remove(pldev = %p '%s')\n", pldev, pldev->name);
+	dev_dbg(&pldev->dev, "%s(pldev = %p '%s')\n", __func__, pldev,
+		pldev->name);
 
 	lddev = (struct i2c_device *)pldev->dev.platform_data;
 
-- 
2.21.0

