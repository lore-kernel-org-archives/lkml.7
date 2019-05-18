Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D61FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE77621773
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaeXQCcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfERCbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:31:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45482 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfERCbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:31:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id t1so10192571qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DsUkVcae2RsRvb3bRT2zxZgb7HZZ1Z3HUnMLGy87n3k=;
        b=MaeXQCcZIthglzTzpOrX0vdozgqojoNEkFoNTaWkExVeKmSShoOh6YvQdYHrDrKnU0
         7tGiJjC1RlOMcjYRIBbDVSG+75kkPMJc+t5NB5b/Ake5Q3j4edib1JmCFtKDctMW4eRO
         KLfLKxYR9UlE59bVskIcILohbxlZSahtoLXJlWw1xG3wg6yTCdWsZz6+LexXKXEZL6M+
         prhu8is2gy5qs2b6ZNpNYbpbrBWNjisgzvCR0c53N05x99DYJ8qo0QABlnS5mxMgJyov
         cMdyvZk3OP0HSUNhC+PdsLg2OO/otsdsb1s9Q1pb6S6w0q3Z7ejxe+6vhStw+i3IVK9K
         mSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DsUkVcae2RsRvb3bRT2zxZgb7HZZ1Z3HUnMLGy87n3k=;
        b=aVZ6gQ9BtpxZ2dW6NeAEA/Mb9UfvcZFvSSCvutiVAWC9kN9XU4QHRxzIuB0xlCdFjq
         HafJDqZfFHZpRvSEbmIwfz6+sZXWQl0BpBBonK07FQBr4PVSMOq7w6uBsObKX83hLQD5
         T/w/XV1qSReF8QnHX0hCLWk0+Ey/5mbqbogS8oydnprAhx2wpD/tDhrU8crfajLzq8aZ
         GDmJkhBkLDivKdNvUJ6tGOC2C+/AMpfyS0PXNO5EOqHmGeby9+RlPjbK6wyq6Rm7yN4s
         FMoat5RQ/4hY2qbr5t9jGFvdZGiTKQwuNayXAZh1/hHJDUDx9d3KPartr269B3RPwIFQ
         bhcg==
X-Gm-Message-State: APjAAAXrb0GuTxel+Meo7y79xj5IhHkTQTTKW3O1Hf5nTy8VOqQLd+L0
        aNj7WCPaWPbJvK2k5DmdAjjMX9xuU+Y=
X-Google-Smtp-Source: APXvYqzXEzHdDlkpBPU2r+loVj3VZp160Lf037DSAmyoX9hBoHyrhr7CmpLpsrrZu+sUPXp3Neoi7w==
X-Received: by 2002:a0c:c923:: with SMTP id r32mr40169865qvj.30.1558146668728;
        Fri, 17 May 2019 19:31:08 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n66sm5210322qke.6.2019.05.17.19.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 19:31:08 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     gneukum1@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: kpc2000: kpc_i2c: reformat copyright for better readability
Date:   Sat, 18 May 2019 02:29:57 +0000
Message-Id: <bc7e518cb6294c7eb1bb4683079ed4b65277c2d5.1558146549.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558146549.git.gneukum1@gmail.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copyright header in i2c_driver.c is difficult to read and not
chronologically ordered. Reformat and reorganize the copyright header
to be similar to other drivers in the i2c subsystem.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 6dda4eb6de75..6cb63d20b00f 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -1,15 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
-/*  Copyright (c) 2014-2018  Daktronics,
-			      Matt Sickler <matt.sickler@daktronics.com>,
-			      Jordon Hofer <jordon.hofer@daktronics.com>
-    Adapted i2c-i801.c for use with Kadoka hardware.
-    Copyright (c) 1998 - 2002  Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker
-    <mdsxyz123@yahoo.com>
-    Copyright (C) 2007 - 2012  Jean Delvare <khali@linux-fr.org>
-    Copyright (C) 2010         Intel Corporation,
-				David Woodhouse <dwmw2@infradead.org>
-*/
+/*
+ * KPC2000 i2c driver
+ *
+ * Adapted i2c-i801.c for use with Kadoka hardware.
+ *
+ * Copyright (C) 1998 - 2002
+ *	Frodo Looijaard <frodol@dds.nl>,
+ *	Philip Edelbrock <phil@netroedge.com>,
+ *	Mark D. Studebaker <mdsxyz123@yahoo.com>
+ * Copyright (C) 2007 - 2012
+ *	Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2010 Intel Corporation
+ *	David Woodhouse <dwmw2@infradead.org>
+ * Copyright (C) 2014-2018 Daktronics
+ *	Matt Sickler <matt.sickler@daktronics.com>,
+ *	Jordon Hofer <jordon.hofer@daktronics.com>
+ */
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -445,7 +451,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	struct i2c_device *priv = i2c_get_adapdata(adap);
 
 	dev_dbg(&priv->adapter.dev, "i801_access (addr=%0d)  flags=%x  read_write=%x  command=%x  size=%x",
-		addr, flags, read_write, command, size );
+			addr, flags, read_write, command, size );
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
 
-- 
2.21.0

