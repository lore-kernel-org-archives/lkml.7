Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B98ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A812082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ7Cx4ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393107AbfJQBTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:19:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46441 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390047AbfJQBTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:19:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so1063844qtq.13;
        Wed, 16 Oct 2019 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/aa8wHXCxV3tmXbr+VMzZQ5IcQ3POWlrtZSRfFXe4U=;
        b=FJ7Cx4okQv21cjqq5YL4ofsxJpaiekvZBcfdJ7bUCEG/x5mqYU4yhbJPlGZ5EMoqCV
         Rr4J7NHIymCg9kxlE/b7KwyW85qj5XEKEZ2zxaZrI9QoNJqea0fZy7JQ69yJwlA/5lVD
         +wpgld+msBPX1ogIOVnPCwIypZBk2P38h9324ayHnCT4ruoAsYX2nRKVdvC6hAMAE/MM
         c6MrgrhT2J8V6lbQgoyngUkfTanQ6Hs259l1lvhTsoQDVhJav2Innl9gS6c9Cb6yw7UR
         8FDqaISP4JzjUrKJgUFw0qIlX49KI/Cq9h1EgbyO61GyVeaVpSYml2GIRXpGVsjrFWfx
         EqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/aa8wHXCxV3tmXbr+VMzZQ5IcQ3POWlrtZSRfFXe4U=;
        b=TgjC7MMbdRk3Dw9XBMmKPph8TjomJghQdGclKptiW7a50CtFwp5VMmu5RjvBuQpRV6
         eBL6FbpPnfTUe9yBuHx8lokwtu8Jdcndq8Kcr3fzLGaUQkC/ApeQxqylvmrUPK4aucLt
         4ub0oKEJsda+/RFkb9aNUBiBKKcs15eb3q5RlEUHMuPrDY03kRjKsE1L7kuPeYh74/S4
         Y55SyFUZRhr3xReIG4Nj736KKiCasgRMsFQv/Ic4FMv2t0bgKNtmViadFi8zdPmXkeDD
         WPbDKzsKi/VyUib1Jk9yzwC5yCvFEjgTSf43xyaZFKYR3y99gA5u00kQClIw3qxYEedi
         Qeug==
X-Gm-Message-State: APjAAAUp4QKqt46dwUXMaBpz73hL3Xd1LkezO8rpXaLIlQQvWXJmCtug
        lpPWtJDwfvYsb2L7NmlMAoA=
X-Google-Smtp-Source: APXvYqxoIdiNy2IByAPfJ9y7fcryTSpguig8XZ62D2TJBAdSQUI8qaExu06MD7B60mVtCn7kdQgQaQ==
X-Received: by 2002:a0c:8867:: with SMTP id 36mr1175545qvm.177.1571275158353;
        Wed, 16 Oct 2019 18:19:18 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id v68sm375528qkd.109.2019.10.16.18.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 18:19:17 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: sm750fb: format description of parameters the to kernel doc format
Date:   Wed, 16 Oct 2019 22:18:49 -0300
Message-Id: <20191017011849.6081-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cluster comments that describes parameters of functions and create one
single comment before the function in kernel doc format.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 65 +++++++++++++++------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index dbcbbd1055da..d5564cd60f3b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -130,20 +130,24 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 	return 0;
 }
 
-int sm750_hw_copyarea(
-struct lynx_accel *accel,
-unsigned int sBase,  /* Address of source: offset in frame buffer */
-unsigned int sPitch, /* Pitch value of source surface in BYTE */
-unsigned int sx,
-unsigned int sy,     /* Starting coordinate of source surface */
-unsigned int dBase,  /* Address of destination: offset in frame buffer */
-unsigned int dPitch, /* Pitch value of destination surface in BYTE */
-unsigned int Bpp,    /* Color depth of destination surface */
-unsigned int dx,
-unsigned int dy,     /* Starting coordinate of destination surface */
-unsigned int width,
-unsigned int height, /* width and height of rectangle in pixel value */
-unsigned int rop2)   /* ROP value */
+/**
+ * @sBase: Address of source: offset in frame buffer
+ * @sPitch: Pitch value of source surface in BYTE
+ * @sx, @sy: Starting coordinate of source surface
+ * @dBase: Address of destination: offset in frame buffer
+ * @dPitch: Pitch value of destination surface in BYTE
+ * @Bpp: Color depth of destination surface
+ * @dx, @dy: Starting coordinate of destination surface
+ * @width, @height: width and height of rectangle in pixel value
+ * @rop2: ROP value
+ */
+int sm750_hw_copyarea(struct lynx_accel *accel,
+		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int sx, unsigned int sy,
+		      unsigned int dBase, unsigned int dPitch,
+		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int width, unsigned int height,
+		      unsigned int rop2)
 {
 	unsigned int nDirection, de_ctrl;
 
@@ -288,20 +292,25 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 	return de_ctrl;
 }
 
-int sm750_hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
-		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
-		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
-		 u32 dBase,    /* Address of destination: offset in frame buffer */
-		 u32 dPitch,   /* Pitch value of destination surface in BYTE */
-		 u32 bytePerPixel,      /* Color depth of destination surface */
-		 u32 dx,
-		 u32 dy,       /* Starting coordinate of destination surface */
-		 u32 width,
-		 u32 height,   /* width and height of rectangle in pixel value */
-		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
-		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
-		 u32 rop2)     /* ROP value */
+/**
+ * @pSrcbuf: pointer to start of source buffer in system memory
+ * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * and -ive mean button up
+ * @startBit: Mono data can start at any bit in a byte, this value should be
+ * 0 to 7
+ * @dBase: Address of destination: offset in frame buffer
+ * @dPitch: Pitch value of destination surface in BYTE
+ * @bytePerPixel: Color depth of destination surface
+ * @dx, @dy: Starting coordinate of destination surface
+ * @width, @height: width and height of rectangle in pixel value
+ * @fColor: Foreground color (corresponding to a 1 in the monochrome data
+ * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @rop2: ROP value
+ */
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
+		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 fColor, u32 bColor, u32 rop2)
 {
 	unsigned int ulBytesPerScan;
 	unsigned int ul4BytesPerScan;
-- 
2.20.1

