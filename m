Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07800C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2362206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo80zv8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbfIFBGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:06:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33228 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbfIFBGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:06:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id t11so2266519plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w+FvHkszadqnPhCJiTI3e+ARFLAAJFBRpIB5600vgxI=;
        b=Mo80zv8LUyWmF/cmilFPf4umb29yDB1VgUIJTIGUM6yqyGLzsOywU//UH/2/V1wUrH
         XevN2P21DKppx4lwWGikdiA+agV8lUeQ0Aqx358FEZlKL2dqq1EZP/+IsfW1ZGpzdnol
         VKFWMBkm3SnfrRP3Ze9wi7uw7IE2FXP2YbkoCBpB+qxwuLSZwnaqeuGjWwnswZrAFlqr
         ZbTcCpYBvuxtCS7J7BWiQopZJ2IG8UpKdybERjz5UUdW9UdhTJal13hKHW8DVaTdzTkF
         Xk/DNmP0KkIEZdq9i3pL1jRsPf44FtaBD2rtSzxaLKA+nfkJ4zTaXcQ9a4MHLniBR+B9
         x2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w+FvHkszadqnPhCJiTI3e+ARFLAAJFBRpIB5600vgxI=;
        b=R7ViNvDnikuoK0Z2ZygtJXOyYvKzp+XdTfbTnwNaZWBlRzZHEtCHqZInNB4THwpbI4
         mWY4ivBfUhQDE8gNFqR+32PcuHeD1juPxNh5P6rIUaulVcWOv9G95JHe60PbYJeB2O7b
         GEPjGFxXws7uz8vHUGHfpFuTLg/H+L2NTnGIeWWPeT6OKq+yMXPPY+AwZiDEXs6svrUK
         W8EDwNl4NAUeOWYLaP0NyRTrhSGi7dz6sYdehKGvmTxP8fTAHotxG8FfdrdXzXDRqQpe
         DSA6RCdkZ5gd+cS4TOMbmTniDw+XSqTT/oMl6k6SuWhMPuDjpFJi5PtGaHybJsfxiiOB
         vwDw==
X-Gm-Message-State: APjAAAXtZ1kgzkvPw8NY620r6pwnM/An4XYzR5i+agMQ/Qe3bDOq3pVo
        x0EQaXY3cfYX+jHaGx/1H5k=
X-Google-Smtp-Source: APXvYqw70LKRdLCGS8WTkzyh4gK0ER068jBJutiFV8ajNvDvgKT+Og7n25EhE1q87uxti8iMB/5Bzg==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr6519128pls.204.1567731978382;
        Thu, 05 Sep 2019 18:06:18 -0700 (PDT)
Received: from compute1 ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id g11sm3309034pgu.11.2019.09.05.18.06.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 18:06:17 -0700 (PDT)
Date:   Fri, 6 Sep 2019 09:06:14 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jerry Lin <wahahab11@gmail.com>
Subject: [PATCH] staging: olpc_dcon: allow simultaneous XO-1 and XO-1.5
 support
Message-ID: <20190906010613.GA562@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove model related configuration.
Since the module can decide which platform data to use itself base on
current running olpc board.

Also change module dependency from (GPIO_CS5535 || GPIO_CS5535=n)
to (GPIO_CS5535 || ACPI) because original one does not make any sense
and module only doing real work when GPIO_CS5535 or ACPI is setted.

Remove kernel configurations:
- FB_OLPC_DCON_1
- FB_OLPC_DCON_1_5

Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/olpc_dcon/Kconfig     | 21 +--------------------
 drivers/staging/olpc_dcon/Makefile    |  4 +---
 drivers/staging/olpc_dcon/TODO        |  1 -
 drivers/staging/olpc_dcon/olpc_dcon.c |  6 +-----
 drivers/staging/olpc_dcon/olpc_dcon.h |  5 -----
 5 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index f5c716b..4ae271f 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -3,7 +3,7 @@ config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
 	depends on I2C
-	depends on (GPIO_CS5535 || GPIO_CS5535=n)
+	depends on (GPIO_CS5535 || ACPI)
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  In order to support very low power operation, the XO laptop uses a
@@ -15,22 +15,3 @@ config FB_OLPC_DCON
 	  This controller is only available on OLPC platforms.  Unless you have
 	  one of these platforms, you will want to say 'N'.
 
-config FB_OLPC_DCON_1
-	bool "OLPC XO-1 DCON support"
-	depends on FB_OLPC_DCON && GPIO_CS5535
-	default y
-	help
-	  Enable support for the DCON in XO-1 model laptops.  The kernel
-	  communicates with the DCON using model-specific code.  If you
-	  have an XO-1 (or if you're unsure what model you have), you should
-	  say 'Y'.
-
-config FB_OLPC_DCON_1_5
-	bool "OLPC XO-1.5 DCON support"
-	depends on FB_OLPC_DCON && ACPI
-	default y
-	help
-	  Enable support for the DCON in XO-1.5 model laptops.  The kernel
-	  communicates with the DCON using model-specific code.  If you
-	  have an XO-1.5 (or if you're unsure what model you have), you
-	  should say 'Y'.
diff --git a/drivers/staging/olpc_dcon/Makefile b/drivers/staging/olpc_dcon/Makefile
index cb1248c..734b2ce 100644
--- a/drivers/staging/olpc_dcon/Makefile
+++ b/drivers/staging/olpc_dcon/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-olpc-dcon-objs += olpc_dcon.o
-olpc-dcon-$(CONFIG_FB_OLPC_DCON_1)	+= olpc_dcon_xo_1.o
-olpc-dcon-$(CONFIG_FB_OLPC_DCON_1_5)	+= olpc_dcon_xo_1_5.o
+olpc-dcon-objs += olpc_dcon.o olpc_dcon_xo_1.o olpc_dcon_xo_1_5.o
 obj-$(CONFIG_FB_OLPC_DCON)	+= olpc-dcon.o
 
 
diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
index d8296f2..7c26335 100644
--- a/drivers/staging/olpc_dcon/TODO
+++ b/drivers/staging/olpc_dcon/TODO
@@ -8,7 +8,6 @@ TODO:
 	  internals, but isn't properly integrated, is not the correct solution.
 	- see if vx855 gpio API can be made similar enough to cs5535 so we can
 	  share more code
-	- allow simultaneous XO-1 and XO-1.5 support
 
 Please send patches to Greg Kroah-Hartman <greg@kroah.com> and
 copy:
diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index a254238..a0d6d90 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -790,15 +790,11 @@ static struct i2c_driver dcon_driver = {
 
 static int __init olpc_dcon_init(void)
 {
-#ifdef CONFIG_FB_OLPC_DCON_1_5
 	/* XO-1.5 */
 	if (olpc_board_at_least(olpc_board(0xd0)))
 		pdata = &dcon_pdata_xo_1_5;
-#endif
-#ifdef CONFIG_FB_OLPC_DCON_1
-	if (!pdata)
+	else
 		pdata = &dcon_pdata_xo_1;
-#endif
 
 	return i2c_add_driver(&dcon_driver);
 }
diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
index 22d976a..41bd136 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ b/drivers/staging/olpc_dcon/olpc_dcon.h
@@ -106,12 +106,7 @@ struct dcon_gpio {
 
 irqreturn_t dcon_interrupt(int irq, void *id);
 
-#ifdef CONFIG_FB_OLPC_DCON_1
 extern struct dcon_platform_data dcon_pdata_xo_1;
-#endif
-
-#ifdef CONFIG_FB_OLPC_DCON_1_5
 extern struct dcon_platform_data dcon_pdata_xo_1_5;
-#endif
 
 #endif
-- 
2.7.4

