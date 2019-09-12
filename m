Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEAC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31C2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="x5wkxZMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfILR4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:56:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46298 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfILR4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:56:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id v11so30571231qto.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=J37rlASg3lZdVjcZomd5figEoaA/6olsHjrhuywt2N8=;
        b=x5wkxZMaoDntw7GnrsXPkdcRF03876+CDbtR4MVKIgm09PcP/0KmUbxwBfm9t7AiRH
         4442k24rSJpV3x8MuNhD663TZuCL/A0P7suGkzqjkTgi25gnRB84vApSvCxE07sOyncl
         PRQjM/4uqEJW3xkEwM7ex/sRHFybNgV77qrnqKeUSlnHlT4lPfUpnmUQtzobt9zA+a7d
         Poicm7A/kFpg5wfnVJceE2PXKCNJ8jBhbUqt/Je/ZOHsEPYSO9oeGqO3q+G2efIM8YV5
         Y0WPsqZ1wKwxoTkDKpyls9ic4zhlif9hPE302cXQ/hYogay6Npmy9Ab0jOnIpNs4HTb/
         7fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J37rlASg3lZdVjcZomd5figEoaA/6olsHjrhuywt2N8=;
        b=fba6U0fTaZzowhmJcpSos4OY1SVsUw1E37QK79ZFDx8X1A9MfwQmEi1A3ws77kc8/j
         rXChMx6anVVBJH22cgmilUTWEDd88wdikeLez8Bp1szI4ebac0Xl0SxSk7VgS0exDCgk
         +XRFUYOOngqJjGdg1tABLo/Kn76dTr44nSR4OKFKKtF15Mvjq9YNv0hJZ7eeLQUKuypM
         bQTFNOHd6KBeob8Im1pLpR9qkjodRSBm/FSm8fzk5IG2mWMgBYSA2EizwK6R2VN9tzno
         /N6NkYlsrdrNeKz6XymfEqCy/bodhYujEfVxOtkajeKsyBgMvn8h1U3YclYo7ffP+jgR
         UKeA==
X-Gm-Message-State: APjAAAU4hDftSFCx6n6FUWxsLdo6TZQaMDasHk9qyJPRVcvuqUaJXVLY
        HymIHxOKKQBcQDNvWdzTGxsTVE6q/oKXFw==
X-Google-Smtp-Source: APXvYqw2o+8LO5CTOixUBK2eKEnS33v6CZLqWyfm2E/LKM95DYIZxH1VGjFmXYoh+TuMZkpvs6nODw==
X-Received: by 2002:ac8:185d:: with SMTP id n29mr28988454qtk.237.1568311005197;
        Thu, 12 Sep 2019 10:56:45 -0700 (PDT)
Received: from nidhoggr.timesys.com (96-94-100-129-static.hfc.comcastbusiness.net. [96.94.100.129])
        by smtp.googlemail.com with ESMTPSA id a4sm11851294qkf.91.2019.09.12.10.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 10:56:44 -0700 (PDT)
From:   Jaret Cantu <jaret.cantu@timesys.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: f71808e_wdt: Add F81803 support
Date:   Thu, 12 Sep 2019 13:55:50 -0400
Message-Id: <20190912175550.9340-1-jaret.cantu@timesys.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds watchdog support for the Fintek F81803 Super I/O chip.

Testing was done on the Seneca XK-QUAD.

Signed-off-by: Jaret Cantu <jaret.cantu@timesys.com>
---
 drivers/watchdog/Kconfig       |  4 ++--
 drivers/watchdog/f71808e_wdt.c | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8188963a405b..781ff835f2a4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1046,8 +1046,8 @@ config F71808E_WDT
 	depends on X86
 	help
 	  This is the driver for the hardware watchdog on the Fintek F71808E,
-	  F71862FG, F71868, F71869, F71882FG, F71889FG, F81865 and F81866
-	  Super I/O controllers.
+	  F71862FG, F71868, F71869, F71882FG, F71889FG, F81803, F81865, and
+	  F81866 Super I/O controllers.
 
 	  You can compile this driver directly into the kernel, or use
 	  it as a module.  The module will be called f71808e_wdt.
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index ff5cf1b48a4d..e46104c2fd94 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -31,8 +31,10 @@
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
 #define SIO_REG_DEVREV		0x22	/* Device revision */
 #define SIO_REG_MANID		0x23	/* Fintek ID (2 bytes) */
+#define SIO_REG_CLOCK_SEL	0x26	/* Clock select */
 #define SIO_REG_ROM_ADDR_SEL	0x27	/* ROM address select */
 #define SIO_F81866_REG_PORT_SEL	0x27	/* F81866 Multi-Function Register */
+#define SIO_REG_TSI_LEVEL_SEL	0x28	/* TSI Level select */
 #define SIO_REG_MFUNCT1		0x29	/* Multi function select 1 */
 #define SIO_REG_MFUNCT2		0x2a	/* Multi function select 2 */
 #define SIO_REG_MFUNCT3		0x2b	/* Multi function select 3 */
@@ -49,6 +51,7 @@
 #define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
+#define SIO_F81803_ID		0x1210	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
 #define SIO_F81866_ID		0x1010	/* Chipset ID */
 
@@ -108,7 +111,7 @@ MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
 	" given initial timeout. Zero (default) disables this feature.");
 
 enum chips { f71808fg, f71858fg, f71862fg, f71868, f71869, f71882fg, f71889fg,
-	     f81865, f81866};
+	     f81803, f81865, f81866};
 
 static const char *f71808e_names[] = {
 	"f71808fg",
@@ -118,6 +121,7 @@ static const char *f71808e_names[] = {
 	"f71869",
 	"f71882fg",
 	"f71889fg",
+	"f81803",
 	"f81865",
 	"f81866",
 };
@@ -370,6 +374,14 @@ static int watchdog_start(void)
 			superio_inb(watchdog.sioaddr, SIO_REG_MFUNCT3) & 0xcf);
 		break;
 
+	case f81803:
+		/* Enable TSI Level register bank */
+		superio_clear_bit(watchdog.sioaddr, SIO_REG_CLOCK_SEL, 3);
+		/* Set pin 27 to WDTRST# */
+		superio_outb(watchdog.sioaddr, SIO_REG_TSI_LEVEL_SEL, 0x5f &
+			superio_inb(watchdog.sioaddr, SIO_REG_TSI_LEVEL_SEL));
+		break;
+
 	case f81865:
 		/* Set pin 70 to WDTRST# */
 		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
@@ -809,6 +821,9 @@ static int __init f71808e_find(int sioaddr)
 		/* Confirmed (by datasheet) not to have a watchdog. */
 		err = -ENODEV;
 		goto exit;
+	case SIO_F81803_ID:
+		watchdog.type = f81803;
+		break;
 	case SIO_F81865_ID:
 		watchdog.type = f81865;
 		break;
-- 
2.11.0

