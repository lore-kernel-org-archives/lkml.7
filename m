Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7897C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87A2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+q5uqkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLCOqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:46:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45914 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:46:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so1758381pgg.12;
        Tue, 03 Dec 2019 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wxiPeBgUd1a9onz26dY7+dYP7fNCqz8jpBXJLUxOt48=;
        b=a+q5uqkV7Tc4V6707uPZPspzJ3zFW3Y2T8qbchA7q+XYLXEDtvMeP8QrEzDiexYymt
         c4XUQSXRpSZK9NBCbiazLfwr/y430tDB7Kdy2EYIS2roYDjUdJUJTyqfka6AtsrsMZd+
         SXJ57O2P9URw+aBfarXClxM1Z8y6W7Uq6OQ/2fhhLCJFrhS33Xvd27uw+BGlEbhkeAbp
         7+1T3Psk2AXDj/CRxXLF+wsVcY7FJuzr7l+N+CxSEMeU2/vM//jWJjZpoKBEG4TOUtor
         bylrl7pKcaDWOy3eXxoXAPu1Zn78c/6TERzpBCBmWmQxvajJkaBoFquN6ddK3Ed2WMjm
         hHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wxiPeBgUd1a9onz26dY7+dYP7fNCqz8jpBXJLUxOt48=;
        b=ESxgtMAFO1QjQ6Ydzv5l4KieA8ZWHT6hvzo3QrrW8Ir3SW1zsdU2BuVWE1lJpjQlNc
         F5uX9Xq9nXCxtdk1X4fvouB+YNKSKi6tQrUaM53bHy/SHO5GqjRYUmK7SkY0MYzE4s9W
         4wAulQF5o8x+WKbjsqeFibKs6zQ1Ihl2GWrMabQAgRkFRFmxp5G/JV+1H99PGII9zJo3
         3EJWOyUYvnWWv8FtQcAqTFYir+VXgLBL0E6cgQs52vHb6i0jjQIzFfcXYkTpQC/IgXaX
         RoY9E4egP9odlFGI21lHx0dOwSC0Zgt11k95HB0nKtG195GO6O7sPCDGpAmogASeZGkO
         RN8w==
X-Gm-Message-State: APjAAAW8rR0i8Ciot3JSM0u3cIMm+KL5FBD+oMKbWxMT3BWk9NJ2Joyt
        ptYBkZEWwv0vVFgRlsr3s80=
X-Google-Smtp-Source: APXvYqypuHdbhGfc4qW1ugmTW1S90u7fGNkdqBARrRaFLT43vp+P03iwjEFFe/MEsx4z/LNrYp3jLg==
X-Received: by 2002:aa7:95a9:: with SMTP id a9mr5066805pfk.15.1575384394558;
        Tue, 03 Dec 2019 06:46:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b23sm3019156pfo.62.2019.12.03.06.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Dec 2019 06:46:33 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] drivers: Fix boot problem on SuperH
Date:   Tue,  3 Dec 2019 06:46:31 -0800
Message-Id: <20191203144631.6629-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SuperH images crash too eearly to display any console output. Bisect
points to commit 507fd01d5333 ("drivers: move the early platform device
support to arch/sh"). An analysis of that patch suggests that
early_platform_cleanup() is now called at the wrong time. Restoring its
call point fixes the problem.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/drivers/platform_early.c | 11 ++---------
 drivers/base/platform.c          |  4 ++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index f6d148451dfc..16f33bffd8fc 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -325,9 +325,9 @@ int __init sh_early_platform_driver_probe(char *class_str,
 }
 
 /**
- * sh_early_platform_cleanup - clean up early platform code
+ * early_platform_cleanup - clean up early platform code
  */
-static int __init sh_early_platform_cleanup(void)
+void early_platform_cleanup(void)
 {
 	struct platform_device *pd, *pd2;
 
@@ -337,11 +337,4 @@ static int __init sh_early_platform_cleanup(void)
 		list_del(&pd->dev.devres_head);
 		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
 	}
-
-	return 0;
 }
-/*
- * This must happen once after all early devices are probed but before probing
- * real platform devices.
- */
-subsys_initcall(sh_early_platform_cleanup);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7c532548b0a6..3ba153e356ee 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1325,10 +1325,14 @@ struct device *platform_find_device_by_driver(struct device *start,
 }
 EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
 
+void __weak early_platform_cleanup(void) { }
+
 int __init platform_bus_init(void)
 {
 	int error;
 
+	early_platform_cleanup();
+
 	error = device_register(&platform_bus);
 	if (error) {
 		put_device(&platform_bus);
-- 
2.17.1

