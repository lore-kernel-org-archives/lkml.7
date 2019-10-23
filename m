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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D16CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AD20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhyKubbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436542AbfJWQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:30:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43409 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436533AbfJWQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:30:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so33155264qtr.10;
        Wed, 23 Oct 2019 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SucdjKTGQcanI63L94XU0ndX+0QHtlZGsavJY3p6BqA=;
        b=NhyKubbIifRt3AhK5Egtx9QnOPj1v//tXutsSnBwRmGH1pPaeiFJm04d/udCUcFHVA
         2pgEq3W3mODPiR3aXH2hqyK87JAc/WoFuGI9Nrs6pj9lwRnZZ+n3e+OgoLVqH5EICScL
         tRfVk7Em36cn5n/p+w2+VimZLKyjzoAm6huuRee3vgPld5M30vipDo3yQnLzRXDwOgZe
         6zemSjktm3iZEQpJgVb4BcV4FkAajvF1iEKmUWeyApUatAR9iBtJrN6k8ia+kFRUxzRp
         DYhpm2kFg4eNwlHTL/MKF6//+R6djzAY5zCucG9n+hV/gqhRMyINYIv05502j1RxHv3h
         KRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SucdjKTGQcanI63L94XU0ndX+0QHtlZGsavJY3p6BqA=;
        b=RyDuK2EKbJ4MGKpsCfdnM342lHpH+h4SGw+8/PSgwd7VfCOL7kHdlkC4R0JixbsvBB
         OwFb+pW0lgVkio7+dfJF0KceKbIP5zAjsJ9oqIhi2Pjlp99pXHMRPdSVbi4QCfed1erD
         wpMAijxPHG/haEhoVSqKk/TV6LxXQd3jKecXQ9DE/lF4D7NSXxDQGNHj2Ae0BXlSc38L
         HaSkxxvLVsS/ZbIHyyHlEZYtU41cTvnMWPr15wQuedflTmTelKl+/To5OkvufEmW4MdD
         6CE/qkJoyD/5mGEpe1gBBV2nDaJcay2hGxwXBUMGgedosIWtX8HjIq+bb2a5Qyqj+SSu
         7LFQ==
X-Gm-Message-State: APjAAAV75Mi/73/0Mrc4JW+cvHeyvk1zI3BatRZcG2mxZuliNUUYdBpv
        mjEUvaHit/ew5Lbsxz3zbP75Ls0L0pU=
X-Google-Smtp-Source: APXvYqyG2V4NiZpZM4P1guHPLXEeKEO2Xp95ekklTvi1Lr7qsHknOkOqzKB3ugzL0sKKYdXh7EYSgg==
X-Received: by 2002:ac8:fda:: with SMTP id f26mr10287344qtk.34.1571848251776;
        Wed, 23 Oct 2019 09:30:51 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id t13sm8349067qtn.18.2019.10.23.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:30:51 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v3 2/2] staging: sm750fb: format description of parameters in accel.h
Date:   Wed, 23 Oct 2019 13:30:14 -0300
Message-Id: <20191023163016.30217-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163016.30217-1-gabrielabittencourt00@gmail.com>
References: <20191023163016.30217-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting comments in file drivers/staging/sm750fb/sm750_accel.h.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

Changes v3:
 - Apply changes in file accel.h
---
 drivers/staging/sm750fb/sm750_accel.h | 75 ++++++++++++++++-----------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index c4f42002a50f..c16350b5a310 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -194,33 +194,50 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 				u32 x, u32 y, u32 width, u32 height,
 				u32 color, u32 rop);
 
-int sm750_hw_copyarea(
-struct lynx_accel *accel,
-unsigned int sBase,  /* Address of source: offset in frame buffer */
-unsigned int sPitch, /* Pitch value of source surface in BYTE */
-unsigned int sx,
-unsigned int sy,     /* Starting coordinate of source surface */
-unsigned int dBase,  /* Address of destination: offset in frame buffer */
-unsigned int dPitch, /* Pitch value of destination surface in BYTE */
-unsigned int bpp,    /* Color depth of destination surface */
-unsigned int dx,
-unsigned int dy,     /* Starting coordinate of destination surface */
-unsigned int width,
-unsigned int height, /* width and height of rectangle in pixel value */
-unsigned int rop2);
-
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
-		 u32 rop2);
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
+		      unsigned int rop2);
+
+/**
+ * sm750_hw_imageblit
+ * @pSrcbuf: pointer to start of source buffer in system memory
+ * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ *>-----      and -ive mean button up
+ * @startBit: Mono data can start at any bit in a byte, this value should be
+ *>-----      0 to 7
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
+		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+
 #endif
-- 
2.20.1

