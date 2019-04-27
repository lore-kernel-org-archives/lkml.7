Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B89DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055312087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfD0MxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfD0MxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:12 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mdvyo-1gklM610Mw-00b6vt; Sat, 27 Apr 2019 14:52:48 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 17/41] drivers: tty: serial: apbuart: fix logging calls
Date:   Sat, 27 Apr 2019 14:51:58 +0200
Message-Id: <1556369542-13247-18-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:74q7QZbgRgRsAUkPp9HoIcby/AiA8t4Mu2TUa7cvirQmdem+3Am
 8EQGnLshuK8zT/JT/rXJ1jMsYvUFcIBhmVWtNocXE1OdQlrcN6zxnc0lOKUkbKlCtWRyBOs
 SfDclKxIBbTDIEFobqRgxh4RYW3wCVdlAW+GkkAV2vRB5P9CXtzp+iTfXlW2e2cAPKtq+p3
 x9rgoBVikwGuHrHXLrrgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eYy4U1g0WLc=:NNFGO3HSiL3iJ9KcFjVqxr
 L5C8Q9zl9SvmSbmk/WXj0EtqOWebYE+T7FuU8NbONX8KrKJZIyetKuuIZvT8JMDBFYYByMJZS
 ZsFYAvVpW3OFJvRwTYlig7Z7pR26iD35iZ9qIWBGrEIbU0eFvBZQ71UaNgyABlpQP25ws5FXx
 zrLsNqdWLdTYHD+VbjQ2gcBFD+6RdC1lVS7GjBn6O6RXVwO/iyuYzHrqd5SEOWYe1mDV/xpcT
 firFlNyM/Y3UYi3z9yFwOZm/mLwOjrKLozqyAUIs5Ee1Dmld6FQR8HBR0gglIETNeESeoBwlk
 j+oqvl9LqtcoRzBeZIaDULJqLJ4PYBQl+ouSd6ruS0W1erDls6LCPPf+9fmou3wGiubPjT5zT
 ZbgpAa+a1FPjCO83yXjVKgwftQDqhNYdtBRkumaxJv167CNq/8HacT+etLB6xjbv0OqTHED+j
 UvHg77KbgPh+lW5z+3aUS+YSda3oF0cX02uC6pzmIguLQ6peLHzvjrLLNo+veCHi5xqdsuTc3
 1tIcr/FtqrUmGyJUAz09ZrsHVYJ13qXd7jVIIkZlpH+9sVbqBaFk0ImoQJTKOflNY7Mfb14LT
 WYOkAkc2qSUAf3D4KAVdI2JRi0lez/a/5/g0MNrh/HEtZiDvSBJaDosnHksn31H+JuOZRTpBV
 XhT4gdKHIwiv+Itmb2O00YCnnIBT4FoF90IGJGwKRMu7AvSI5rBVKeCNSHQbXqFGnfcMvGqVG
 qH3e6Ibc4dkf9y2PyMnfIib4diOFSWqdZxE4aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

    WARNING: Prefer using '"%s...", __func__' to using 'apbuart_console_setup', this function's name, in a string
    #491: FILE: drivers/tty/serial/apbuart.c:491:
    +	pr_debug("apbuart_console_setup co=%p, co->index=%i, options=%s\n",

    WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
    #661: FILE: drivers/tty/serial/apbuart.c:661:
    +	printk(KERN_INFO "Serial: GRLIB APBUART driver\n");

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
    #666: FILE: drivers/tty/serial/apbuart.c:666:
    +		printk(KERN_ERR "%s: uart_register_driver failed (%i)\n",

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
    #673: FILE: drivers/tty/serial/apbuart.c:673:
    +		printk(KERN_ERR

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/apbuart.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133..d2b86f7 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -482,8 +482,8 @@ static int __init apbuart_console_setup(struct console *co, char *options)
 	int parity = 'n';
 	int flow = 'n';
 
-	pr_debug("apbuart_console_setup co=%p, co->index=%i, options=%s\n",
-		 co, co->index, options);
+	pr_debug("%s() co=%p, co->index=%i, options=%s\n",
+		 __func__, co, co->index, options);
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -650,21 +650,20 @@ static int __init grlib_apbuart_init(void)
 	if (ret)
 		return ret;
 
-	printk(KERN_INFO "Serial: GRLIB APBUART driver\n");
+	pr_info("Serial: GRLIB APBUART driver\n");
 
 	ret = uart_register_driver(&grlib_apbuart_driver);
 
 	if (ret) {
-		printk(KERN_ERR "%s: uart_register_driver failed (%i)\n",
-		       __FILE__, ret);
+		pr_err("%s: uart_register_driver failed (%i)\n",
+		       __func__, ret);
 		return ret;
 	}
 
 	ret = platform_driver_register(&grlib_apbuart_of_driver);
 	if (ret) {
-		printk(KERN_ERR
-		       "%s: platform_driver_register failed (%i)\n",
-		       __FILE__, ret);
+		pr_err("%s: platform_driver_register failed (%i)\n",
+		       __func__, ret);
 		uart_unregister_driver(&grlib_apbuart_driver);
 		return ret;
 	}
-- 
1.9.1

