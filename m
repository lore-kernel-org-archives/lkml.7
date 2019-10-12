Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA93C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8938A214E0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P11949Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfJLBUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 21:20:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44326 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfJLBUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 21:20:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so10582300qkk.11;
        Fri, 11 Oct 2019 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f59g/RciVZKoxqNX9kC3w6U69tnmtVV5CNkXdY+evAk=;
        b=P11949MuCzHOh2ktsdskijdbH2ZXJyKxKKUW/6KRGBL6qDtFcdJHhF0jU5hzJmhAWW
         CoAD6Xa7ht7fUA45ULBTLVL04HSQY7fUJSlj+u6OSBMko7xISTmXSj7yLNbBbUrFetMd
         Vixjq+gleE4IfUjyh3X/eftr807SM87bd7p1hmxUTKZMcXMITjly2RM5KYJTKezf3IKD
         bQXve2sj9+3Eb+1Gwsf2snBOWF742XpGGGjlR9+o5+JnZJL58wTAA0yTleClYOf0D6ta
         7+IeKvw4jfjTi7HcyKZds7krit1/Hm3hCtIx6A1qmkwDIhPZCGHPkgUiS0ZG5zBfXxBv
         kwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f59g/RciVZKoxqNX9kC3w6U69tnmtVV5CNkXdY+evAk=;
        b=gv7ckZ9DXbWFD4qhaCW07g/3bQJ/5AZ8eslQwuH/cm+TZVCZjb7jqAjS2zo9n9SLtY
         j7k3y7TJd/BSP7JCDRmu8mX26gqtIhY8h5tDy8EimU5vU8r4W3WVeFMCniXUThA8yhXi
         DEls93qNq+S79EtU9ndMil1g8luZpuNqSvNSjIUn67Kf7im6NuT6Cftj2ZQ/eZF4Fmz1
         wHsV1RYb4ZJ293gaCSQUXVY0cT4ZEytf/t08Ns/GTdIRv4DCgubwRcAGe5+6oNExB7pC
         W+8BYIk60bXBAego0yTDXyjQcc3tov7o7Mx0Ju8nnjAwFXBjGV8L3q+bSL3p3RqQidwu
         m2Ug==
X-Gm-Message-State: APjAAAVV2k1llQtJ/9Bq22NF+vq7YhtDGmMYpTVSai6gKlCVBZ9NhPL4
        Ha7udNLxnuZwxPqTLcnxk+Staq3KfO0=
X-Google-Smtp-Source: APXvYqyhRYp+eePH4KkaE8rNlbcmiPdJZXbACZ4JIREHfbvDJmMdzvUQuhbl/UICNaCvmBjt0hhVcQ==
X-Received: by 2002:a37:9d10:: with SMTP id g16mr18836248qke.29.1570843209314;
        Fri, 11 Oct 2019 18:20:09 -0700 (PDT)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id s17sm4618393qkg.79.2019.10.11.18.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 18:20:08 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: sm750fb: align arguments with open parenthesis
Date:   Fri, 11 Oct 2019 22:19:56 -0300
Message-Id: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis" in tree sm750fb

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c |  2 +-
 drivers/staging/sm750fb/sm750_accel.c    |  2 +-
 drivers/staging/sm750fb/sm750_accel.h    |  8 ++++----
 drivers/staging/sm750fb/sm750_cursor.h   | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 887ea8aef43f..8be98a1058d6 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -148,7 +148,7 @@ void ddk750_set_logical_disp_out(enum disp_output output)
 	if (output & PNL_SEQ_USAGE) {
 		/* set  panel sequence */
 		sw_panel_power_sequence((output & PNL_SEQ_MASK) >> PNL_SEQ_OFFSET,
-		4);
+					4);
 	}
 
 	if (output & DAC_USAGE)
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index dbcbbd1055da..1a9555bb9edd 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -289,7 +289,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 }
 
 int sm750_hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
+		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
 		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
 		 u32 dBase,    /* Address of destination: offset in frame buffer */
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index c4f42002a50f..8fb79b09fdd0 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,9 +190,9 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-				u32 base, u32 pitch, u32 Bpp,
-				u32 x, u32 y, u32 width, u32 height,
-				u32 color, u32 rop);
+		      u32 base, u32 pitch, u32 Bpp,
+		      u32 x, u32 y, u32 width, u32 height,
+		      u32 color, u32 rop);
 
 int sm750_hw_copyarea(
 struct lynx_accel *accel,
@@ -210,7 +210,7 @@ unsigned int height, /* width and height of rectangle in pixel value */
 unsigned int rop2);
 
 int sm750_hw_imageblit(struct lynx_accel *accel,
-		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
+		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
 		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
 		 u32 dBase,    /* Address of destination: offset in frame buffer */
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 16ac07eb58d6..039ebfdf0bd9 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -6,13 +6,13 @@
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
-						int w, int h);
+			     int w, int h);
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
-						int x, int y);
+			    int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
-						u32 fg, u32 bg);
+			      u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
+			     u16 rop, const u8 *data, const u8 *mask);
 void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
+			      u16 rop, const u8 *data, const u8 *mask);
 #endif
-- 
2.20.1

