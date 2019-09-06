Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267DAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0559C2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392617AbfIFPa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:30:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49954 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfIFPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:30:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6GCL-0003KH-3u; Fri, 06 Sep 2019 15:30:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: make several arrays static const, makes object smaller
Date:   Fri,  6 Sep 2019 16:30:52 +0100
Message-Id: <20190906153052.31846-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays on the stack but instead make them
static const. Makes the object code smaller by 1329 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
   5581	   1488	     64	   7133	   1bdd	drivers/staging/fbtft/fb_hx8340bn.o
   5444	   1264	      0	   6708	   1a34	drivers/staging/fbtft/fb_hx8347d.o
   3581	   1360	      0	   4941	   134d	drivers/staging/fbtft/fb_ili9163.o
   7154	   1552	      0	   8706	   2202	drivers/staging/fbtft/fb_ili9320.o
   7478	   2544	      0	  10022	   2726	drivers/staging/fbtft/fb_ili9325.o
   6327	   1424	      0	   7751	   1e47	drivers/staging/fbtft/fb_s6d1121.o
   6498	   1776	      0	   8274	   2052	drivers/staging/fbtft/fb_ssd1289.o

After:
   text	   data	    bss	    dec	    hex	filename
   5376	   1584	     64	   7024	   1b70	drivers/staging/fbtft/fb_hx8340bn.o
   5276	   1328	      0	   6604	   19cc	drivers/staging/fbtft/fb_hx8347d.o
   3581	   1360	      0	   4941	   134d	drivers/staging/fbtft/fb_ili9163.o
   6905	   1616	      0	   8521	   2149	drivers/staging/fbtft/fb_ili9320.o
   7229	   2608	      0	   9837	   266d	drivers/staging/fbtft/fb_ili9325.o
   6030	   1488	      0	   7518	   1d5e	drivers/staging/fbtft/fb_s6d1121.o
   6249	   1872	      0	   8121	   1fb9	drivers/staging/fbtft/fb_ssd1289.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/fbtft/fb_hx8340bn.c | 2 +-
 drivers/staging/fbtft/fb_hx8347d.c  | 2 +-
 drivers/staging/fbtft/fb_ili9163.c  | 2 +-
 drivers/staging/fbtft/fb_ili9320.c  | 2 +-
 drivers/staging/fbtft/fb_ili9325.c  | 2 +-
 drivers/staging/fbtft/fb_s6d1121.c  | 2 +-
 drivers/staging/fbtft/fb_ssd1289.c  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fbtft/fb_hx8340bn.c b/drivers/staging/fbtft/fb_hx8340bn.c
index d47dcf31fffb..2fd7b87ea0ce 100644
--- a/drivers/staging/fbtft/fb_hx8340bn.c
+++ b/drivers/staging/fbtft/fb_hx8340bn.c
@@ -151,7 +151,7 @@ static int set_var(struct fbtft_par *par)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x0f, 0x0f, 0x1f, 0x0f, 0x0f, 0x0f, 0x1f, 0x07, 0x07, 0x07,
 		0x07, 0x07, 0x07, 0x03, 0x03, 0x0f, 0x0f, 0x1f, 0x0f, 0x0f,
 		0x0f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00,
diff --git a/drivers/staging/fbtft/fb_hx8347d.c b/drivers/staging/fbtft/fb_hx8347d.c
index 3427a858d17c..37eaf0862c5b 100644
--- a/drivers/staging/fbtft/fb_hx8347d.c
+++ b/drivers/staging/fbtft/fb_hx8347d.c
@@ -95,7 +95,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x7f, 0x7f, 0x1f, 0x1f,
 		0x1f, 0x1f, 0x1f, 0x0f,
 	};
diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_ili9163.c
index fd32376700e2..05648c3ffe47 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -195,7 +195,7 @@ static int set_var(struct fbtft_par *par)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int gamma_adj(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
 		0x1f, 0x3f, 0x0f, 0x0f, 0x7f, 0x1f,
 		0x3F, 0x3F, 0x3F, 0x3F, 0x3F};
diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index ea6e001288ce..f2e72d14431d 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -214,7 +214,7 @@ static int set_var(struct fbtft_par *par)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x1f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 		0x1f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 	};
diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_ili9325.c
index 85e54a10ed72..c9aa4cb43123 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -208,7 +208,7 @@ static int set_var(struct fbtft_par *par)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x1f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 		0x1f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 	};
diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index 5a129b1352cc..8c7de3290343 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -123,7 +123,7 @@ static int set_var(struct fbtft_par *par)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f,
 		0x3f, 0x3f, 0x1f, 0x1f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f,
 		0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x1f, 0x1f,
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index 88a5b6925901..7a3fe022cc69 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -129,7 +129,7 @@ static int set_var(struct fbtft_par *par)
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long mask[] = {
+	static const unsigned long mask[] = {
 		0x1f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 		0x1f, 0x1f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 	};
-- 
2.20.1

