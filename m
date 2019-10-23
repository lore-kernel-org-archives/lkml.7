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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2430FCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8FC21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaqaR1qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbfJWNNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:13:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38635 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbfJWNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:13:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id o25so18783404qtr.5;
        Wed, 23 Oct 2019 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ohRiKoQhkRpaqt9hJhdQvzQzR+t9Fsg+JL8RFCA1XEE=;
        b=QaqaR1qOT89rUu8StdHeaRI2FrFjxRCrlbXfhbbHR9vZnzKThIdbKrmyRWSBN2bdba
         sE46IsgHzgT9XYWG4UdfQyRWXTMVeJ7VpFPmkCa9vj/+DpX1g7evROqCXHGhIcJN2JNO
         8aErTqkuxElpgoSh8cNYzAjW33boa8eGOwYgwdUEbdfsQ+wnAj2GDUUzHJv5i5C5bJ21
         6rjUKT54WjEeNI+v4/pfTwYinBFUPFIKHYhC2u8idnVI7ulG4Ascu6dmTCtCPgYNMjnl
         uxM6Kw22wp3J3MMxVWzjjjcXHrCafX3kkVC13+EaGqgJzpbeLwjb3HKn79iWQORVb1PJ
         wXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ohRiKoQhkRpaqt9hJhdQvzQzR+t9Fsg+JL8RFCA1XEE=;
        b=G4CE40quRY1n2fjnK10OZemsH/z4zkpPZjon/PO2dyqaxc/9HG0UBnTP28ELO6Cnga
         l5FHhsT5TrMQQrO6SgY2mUDarWuRsn8iyiVmC78hBtE5dVMKwPNoxOG9NwefbfjVjtnH
         TbHOBxwoetf0IBSX67cuTeYNO8O5+WJR+fFe34WETv86xBrhNYj1v3XdEXUzOXf/Z0WE
         fNDEcYnJswvQOemCiIuCAW2XmC+qY8inzNcn64mfS6nNTpPYhZRDZWPsSMCtNQrsMROy
         atus4M2gC37OzJ1Olhpi3usG0OXD5+x8gBQdN2pyST5cuG0u2pJiEVQ89DeqDLrxAxW9
         sBUQ==
X-Gm-Message-State: APjAAAWtaG77piT8jL3L3z5UXT8vQui022p4Vk4czrWr/LwfYvn58bxu
        PpQs6OauUhai+91kDlfwKVw=
X-Google-Smtp-Source: APXvYqxGnTnLSmtjHmmtUd6SAIDMk96N1A+bQlwUdf8F7JNwJM03WvMYsFIuKtRsNHcSlyvJbnvIsQ==
X-Received: by 2002:ac8:76d9:: with SMTP id q25mr9148063qtr.23.1571836382491;
        Wed, 23 Oct 2019 06:13:02 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id p22sm9863919qkk.92.2019.10.23.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:13:01 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2] staging: sm750fb: format description of parameters the to kernel doc format
Date:   Wed, 23 Oct 2019 10:12:52 -0300
Message-Id: <20191023131253.20819-1-gabrielabittencourt00@gmail.com>
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

Changes v2:
 - Add name of function at the begining of comment
 - Separate each parameter in individuals lines

Here are the commands that I used to test my documentation and the
respective outputs:

$ kdoc_function sm750_acc.c sm750_hw_imageblit man
In NAME:
 there is the name of the function, but it's without a brief description
In ARGUMENTS:
 argument 'accel' is presented as '-- undescribed --'

$ kdoc_function sm750_acc.c sm750_hw_copyarea man
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

