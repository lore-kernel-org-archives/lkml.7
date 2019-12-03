Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D84AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D218420661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMtevZOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLCU64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:58:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37896 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfLCU64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:58:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so2204034pgl.5;
        Tue, 03 Dec 2019 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zNJ76pkzPMxidfNvZVb2qLDA1WJgDdXvT5gi9V9xD4c=;
        b=kMtevZOYLJyRRRiki59q8fZ8xfRi/XxUkjwXqM2zAusTJMgzolvOQ/OkvBrix7+sRY
         5llOHxqyeTm3RgUGP1cxd9eTWOavGcdCwjFQ2qloIoGrRHN2VH/A6sV/eyDQiaEDTKDA
         NwPWeYgV17ZypiiyuOvoa4RqcxJMtTPk1hTd7jZ3+9C3P2VqPX7WrfUSbdkzzvE02eSg
         L4zTu5Qq3IPknh8slAAzXq66tp2UXbBzrS4JIEmVMO+91iyJn697ZdtTLvkD7obMo+2P
         VsfYOaB6VP1AvJGgCbkDOkYw7kVQWfBU4GEPIbYYtAod/I9lr6nHMHPwwcDy4eriXHLY
         WgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zNJ76pkzPMxidfNvZVb2qLDA1WJgDdXvT5gi9V9xD4c=;
        b=mTMaJD3Np3R4AIJuhhGnE6CYcvXJUU5gyFlv3hNZ8SKFe0DpSQZg4mWx/beKgb/Pkm
         6hFRNRxWYonPQKc/cJU0RaFHo3Gg1gev/BJKeWjVS4rZHRLitsJHmzQ7ROgpHLVtacQx
         AUF1jzaGwgsPzcx8jazJWfxKZiA/bzTN+DPXI9Na9jAEiQPA4wDts9s1l1waDjTGvzfd
         klUD2uq1+czSmOl5ONpMeA/2fmX0RWJYZ74ISS/QS/CUeQxhcf+djLExfporuMtcvlOA
         pCfG7ebIQw8encxKuTelkx82m704mWlO7L/6HE64kIIQsccyZZtue/yQTix7B4okTaWO
         WICw==
X-Gm-Message-State: APjAAAXLBIVf/r/x/Wlm2Ixjves3A53oIYZNjx/C1Kq5D91Ci+lkMdbG
        77Ro2o8ppshFS/IFuZStzig=
X-Google-Smtp-Source: APXvYqyxQgIhoj2UaRTi1Qnm6VZkoGEo2ToSTbIZuCHwGWBvGX6QSpRMi/wNKjBadhmvSVefwgkEEw==
X-Received: by 2002:a63:da4d:: with SMTP id l13mr7854866pgj.106.1575406735472;
        Tue, 03 Dec 2019 12:58:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y17sm4599175pfn.86.2019.12.03.12.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Dec 2019 12:58:54 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2] drivers: Fix boot problem on SuperH
Date:   Tue,  3 Dec 2019 12:58:52 -0800
Message-Id: <20191203205852.15659-1-linux@roeck-us.net>
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
v2: Use __init annotation for early_platform_cleanup()

 arch/sh/drivers/platform_early.c | 11 ++---------
 drivers/base/platform.c          |  4 ++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index f6d148451dfc..f3dc3f25b3ff 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -325,9 +325,9 @@ int __init sh_early_platform_driver_probe(char *class_str,
 }
 
 /**
- * sh_early_platform_cleanup - clean up early platform code
+ * early_platform_cleanup - clean up early platform code
  */
-static int __init sh_early_platform_cleanup(void)
+void __init early_platform_cleanup(void)
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
index 7c532548b0a6..cf6b6b722e5c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1325,10 +1325,14 @@ struct device *platform_find_device_by_driver(struct device *start,
 }
 EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
 
+void __weak __init early_platform_cleanup(void) { }
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

