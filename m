Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560C6CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF5220650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmuAMC8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436531AbfJWQas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:30:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36294 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436511AbfJWQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:30:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so18565296qto.3;
        Wed, 23 Oct 2019 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/gGINuO4rZ1Q1b4siMstjOWEKgW2+OR5xi6Uu2Zpfw=;
        b=fmuAMC8IrJunvfr9s/spVdumHPvY5Okfcj+sisnh2+hJJ9W2PmFVq+5LO4w4TOVLm3
         q8xSTIWiOnC8qERJV9iDQLiGWQCfiM3bLPn+VrtIJlfMhvHM001dyEbyDrUuIHQoMP8x
         h2xhFWEGgRw/n60NmANQ0lmC9WvLvu6gJk7ahLzu//T8rpKagvcri924bKLZBOzTXL02
         MJcCglKoBR2RkZUrl7jDVWV/N73AodzhZaNfST6MvX7W0PfZdwIoyl1LQRV/yJmgdY2s
         tlB7gUHOHt3fH25WYLHJBP+Lte2mR9v9kJokjpZEeqVZAtuumCCW+YYi3w7NIxzWtClO
         H/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/gGINuO4rZ1Q1b4siMstjOWEKgW2+OR5xi6Uu2Zpfw=;
        b=t0+DzdN30VcAAmZuMIjMvfaCIGRGE4ouvTpPf9OMfbPmekBivioSp4Op4aMeMgcO/V
         BRoprFAyrLcVzcPLQUbi43n0nQcv5kJ5z7BkN+U3K35Ox1Xw1l0F4c2XKCOmXJ/oa1B4
         XClLTPhYnWH5YXVChNRT3l1rmDeZZusmZM9c6u2OHT6dESol5WYVmBtE9bxUDsfsKvdZ
         YnC/+Lg2Bb0Nd5PIozikq0iMuIP3NIlnQaJY8jTNMXNjJHDN0IwcSVJ6LVmezHZHirjA
         d+TQlDjYHgJFhUUlWG4zimVNv33N2nWlZE9b5ENekN44Rd2hKeS53h5WyeAJH4dKGChv
         fm1g==
X-Gm-Message-State: APjAAAXYnUL2sd2qpOxckHX+3JU34WQ4m8K/bBc/8q55rJnWDoMnafBy
        vq/MorsO6WdhwdAcxRH2sUnxzYx38gY=
X-Google-Smtp-Source: APXvYqzTTBzPrgQGJRaI/V1zt4W2mqFdSyI1aqGpEPuBzCvlKtC3nDqkRA0E460FN6hc7FqUghggDw==
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr9955825qtp.391.1571848245230;
        Wed, 23 Oct 2019 09:30:45 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id t13sm8349067qtn.18.2019.10.23.09.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:30:44 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v3 1/2] staging: sm750fb: format description of parameters in accel.c
Date:   Wed, 23 Oct 2019 13:30:13 -0300
Message-Id: <20191023163016.30217-2-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163016.30217-1-gabrielabittencourt00@gmail.com>
References: <20191023163016.30217-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting comments in file drivers/staging/sm750fb/sm750_accel.c.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

Changes v2:
 - Add name of function at the begining of comment
 - Separate each parameter in individuals lines

Here are the commands that I used to test my documentation and the
respective outputs:

$ kdoc_function sm750_accel.c sm750_hw_imageblit man
In NAME:
 there is the name of the function, but it's without a brief description
In ARGUMENTS:
 argument 'accel' is presented as '-- undescribed --'

$ kdoc_function sm750_accel.c sm750_hw_copyarea man
In NAME:
 there is the name of the function, but it's without a brief description
In ARGUMENTS:
 argument 'accel' is presented as '-- undescribed --'

$ kernel-doc -none sm750_accel.c
2 Warnings:
sm750_accel.c:155: warning: Function parameter or member 'accel'
			    not described in 'sm750_hw_copyarea'
sm750_accel.c:321: warning: Function parameter or member 'accel'
			    not described in 'sm750_hw_imageblit'

I appreciate Randy's explanation about how to test documentation.
Thank you very much.

Changes v3:
 - Transforming patch into a patch serie
 - Apply similar changes in accel.h
---
 drivers/staging/sm750fb/sm750_accel.c | 72 ++++++++++++++++-----------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index dbcbbd1055da..645813a87490 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -130,20 +130,28 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
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
+ * sm750_hm_copyarea
+ * @sBase: Address of source: offset in frame buffer
+ * @sPitch: Pitch value of source surface in BYTE
+ * @sx: Starting x coordinate of source surface
+ * @sy: Starting y coordinate of source surface
+ * @dBase: Address of destination: offset in frame buffer
+ * @dPitch: Pitch value of destination surface in BYTE
+ * @Bpp: Color depth of destination surface
+ * @dx: Starting x coordinate of destination surface
+ * @dy: Starting y coordinate of destination surface
+ * @width: width of rectangle in pixel value
+ * @height: height of rectangle in pixel value
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
 
@@ -288,20 +296,28 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
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
+ * sm750_hw_imageblit
+ * @pSrcbuf: pointer to start of source buffer in system memory
+ * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ *	      and -ive mean button up
+ * @startBit: Mono data can start at any bit in a byte, this value should be
+ *	      0 to 7
+ * @dBase: Address of destination: offset in frame buffer
+ * @dPitch: Pitch value of destination surface in BYTE
+ * @bytePerPixel: Color depth of destination surface
+ * @dx: Starting x coordinate of destination surface
+ * @dy: Starting y coordinate of destination surface
+ * @width: width of rectangle in pixel value
+ * @height: height of rectangle in pixel value
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

