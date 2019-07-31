Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAAEC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19C2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVJ4kuvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfGaSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:36:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36895 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfGaSgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:36:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so32345351pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CDz+d68kK243TDqiK1NIHv51qZyJgsAbmVMIQB4C8hA=;
        b=uVJ4kuvizTFMl0PZZfBRuMnaeJnygWvwTvlBnQWHCYFjp2qWosEZ2sdvgNNW/JTj97
         i8YrnN4IXGmWGPg1Ul+XABKjMvZDXiP4X/h8LMdRejyiQeNDPMZQdOYtkvj/nctz3rOp
         nBsGFD3Ks6OwSD6X2hNvQFBEOTmul2dmx+bm6Y1ZwupyzP4X6/FBdMFXXuwOa0jnR9BD
         mG3ooqmf9Wa3MRvq7bI1adrevwTdQ2dDL3Q6LWaLJMDOOavQ3gPxKNxgAEfbgs5zzzUW
         rslv7djoSK1Va99wkPMsF41urYs2Z+usZ5aLnKNt9by0t399bTqje9qSr4I/satSCxYt
         WL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CDz+d68kK243TDqiK1NIHv51qZyJgsAbmVMIQB4C8hA=;
        b=ijFC5IwU6gfsOS6Kv/UNdUT78HsJIotBZ1UDIWc+szPx87DUQjEn1dmIfiJk4ctPzq
         QYWu+KY9SLdlMTQPsuN0WdvnLpgBMa/5rHz+FSM6+eVhkugz11wBhhI4hmBJ4aLOg9po
         osRHdvCwM2cHQ6Dk3sfH13KkjXQWC6Kr8Vf30Vsla6MGZr1zn98UAf74nkd1vLLpxm8u
         FluhkgJ9L4japdlUNe4GfoKIGO3p6lx9REwtTc2sPOIXEBJuXcjhvR/fdo+SGJAyxWRL
         xe7SxNqOQ8RwHTXcBodLbmDuNzyvHK8VD/Ylnvrg45D8WJ73ib4eXo6LzpthetuCzC3m
         f+6w==
X-Gm-Message-State: APjAAAVr4Exu9QtOQuprErC6DwH/kPVqH6KSPs/8dWshTbBTk4v07jaZ
        d39KOUjI8I81mz4trv2ASuY=
X-Google-Smtp-Source: APXvYqxt778NrcDU6VEz3IsXTgcrNE1lZ37D3/J/5XP2DykdutWw96vKy1J0UYLYfRz6P6Ji/0MArg==
X-Received: by 2002:a63:6bc5:: with SMTP id g188mr85059063pgc.225.1564598192338;
        Wed, 31 Jul 2019 11:36:32 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id y14sm19780610pge.7.2019.07.31.11.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:36:31 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     harshjain32@gmail.com
Subject: [PATCH] staging:kpc2000:Fix dubious x | !y sparse warning
Date:   Thu,  1 Aug 2019 00:06:06 +0530
Message-Id: <20190731183606.2513-1-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitwise OR(|) operation with 0 always yield same result.
It fixes dubious x | !y sparse warning.

Signed-off-by: Harsh Jain <harshjain32@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index b108da4..5f027d7c 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -536,29 +536,15 @@ static u32 i801_func(struct i2c_adapter *adapter)
 
 	u32 f =
 		I2C_FUNC_I2C                     | /* 0x00000001 (I enabled this one) */
-		!I2C_FUNC_10BIT_ADDR             | /* 0x00000002 */
-		!I2C_FUNC_PROTOCOL_MANGLING      | /* 0x00000004 */
 		((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) | /* 0x00000008 */
-		!I2C_FUNC_SMBUS_BLOCK_PROC_CALL  | /* 0x00008000 */
 		I2C_FUNC_SMBUS_QUICK             | /* 0x00010000 */
-		!I2C_FUNC_SMBUS_READ_BYTE        | /* 0x00020000 */
-		!I2C_FUNC_SMBUS_WRITE_BYTE       | /* 0x00040000 */
-		!I2C_FUNC_SMBUS_READ_BYTE_DATA   | /* 0x00080000 */
-		!I2C_FUNC_SMBUS_WRITE_BYTE_DATA  | /* 0x00100000 */
-		!I2C_FUNC_SMBUS_READ_WORD_DATA   | /* 0x00200000 */
-		!I2C_FUNC_SMBUS_WRITE_WORD_DATA  | /* 0x00400000 */
-		!I2C_FUNC_SMBUS_PROC_CALL        | /* 0x00800000 */
-		!I2C_FUNC_SMBUS_READ_BLOCK_DATA  | /* 0x01000000 */
-		!I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | /* 0x02000000 */
 		((priv->features & FEATURE_I2C_BLOCK_READ) ? I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) | /* 0x04000000 */
 		I2C_FUNC_SMBUS_WRITE_I2C_BLOCK   | /* 0x08000000 */
 
 		I2C_FUNC_SMBUS_BYTE              | /* _READ_BYTE  _WRITE_BYTE */
 		I2C_FUNC_SMBUS_BYTE_DATA         | /* _READ_BYTE_DATA  _WRITE_BYTE_DATA */
 		I2C_FUNC_SMBUS_WORD_DATA         | /* _READ_WORD_DATA  _WRITE_WORD_DATA */
-		I2C_FUNC_SMBUS_BLOCK_DATA        | /* _READ_BLOCK_DATA  _WRITE_BLOCK_DATA */
-		!I2C_FUNC_SMBUS_I2C_BLOCK        | /* _READ_I2C_BLOCK  _WRITE_I2C_BLOCK */
-		!I2C_FUNC_SMBUS_EMUL;              /* _QUICK  _BYTE  _BYTE_DATA  _WORD_DATA  _PROC_CALL  _WRITE_BLOCK_DATA  _I2C_BLOCK _PEC */
+		I2C_FUNC_SMBUS_BLOCK_DATA;	   /* _READ_BLOCK_DATA  _WRITE_BLOCK_DATA */
 	return f;
 }
 
-- 
2.7.4

