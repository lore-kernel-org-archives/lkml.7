Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E2DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A245A208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmDtkWHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfEJSB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:01:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40914 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfEJSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:01:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so3173121plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVXqcCtx7KdgAdCFRkzwpX3QUOeRz5ft8jL7Rs27omc=;
        b=UmDtkWHRk/KZ4TbTh4Fff+kOGt/9m6PnGGIXmmkgge6lqUwmPu4UWhaPVXGjTQnD+i
         eBuRhaS4WG4ZeQGWIazEl30ouXVmcMUyr6D3f8OqARwI9vGQ+7gIPf1NeRhWZmEd732P
         WOuBZ7LiyE++PlZV8Owu4kPNM7EsLHf+oVD4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVXqcCtx7KdgAdCFRkzwpX3QUOeRz5ft8jL7Rs27omc=;
        b=YE9skvbJIqmvSj+0mfZSCLi/mriz+4Ki8M93rc2lh3GGxhEm6tfZFCG/De/pnT74oY
         Cv2qfQN64YLutlOIEpW6OZJRy4Bu1+z1IPE5Ksoo5HzuLNgCdsZ89w3MFci+G1leFzs0
         IIL1DWmbDhbafJtBHF2138T7MKSrREtn/6BeIk7EbfbKCcEa0NR7ky+ulMsowkJPz6q9
         6OyRVsac2xQ/XgVeflR5HC8hMpslLMqWTSMzVf9ki6mbpLAPxbx7xHguivihht5QRIvR
         OkiQ0Ck3M1E8zuTNj7KuHzklcqezOtj07hc/de/XZoux8f7rpXAd/sdSkXXfP8dkufoU
         NXqA==
X-Gm-Message-State: APjAAAWcAdwLGaXHS1qW6qbXuiFQamnT3X7Zq/3D5AeaLgr7IOHLzZoU
        f3bW4WN2IhXVybsxIT+G6KyZyg==
X-Google-Smtp-Source: APXvYqy9Yg02HxkOFrz70/xXzJnBrRVokKQ4jABcm4Pb38mNmctqOLHcHsB8vAmx0Aok7/k6NDSTBw==
X-Received: by 2002:a17:902:b092:: with SMTP id p18mr14824374plr.323.1557511314523;
        Fri, 10 May 2019 11:01:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm7556740pfe.74.2019.05.10.11.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:01:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/5] firmware: google: Add a module_coreboot_driver() macro and use it
Date:   Fri, 10 May 2019 11:01:47 -0700
Message-Id: <20190510180151.115254-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some boiler plate code we have in three drivers with a single
line each time. This also gets us a free assignment of the driver .owner
field, making these drivers work better as modules.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.h       | 10 ++++++++++
 drivers/firmware/google/framebuffer-coreboot.c | 14 +-------------
 drivers/firmware/google/memconsole-coreboot.c  | 14 +-------------
 drivers/firmware/google/vpd.c                  | 14 +-------------
 4 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 71a9de6b15fa..054fa9374c59 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -20,6 +20,7 @@
 #ifndef __COREBOOT_TABLE_H
 #define __COREBOOT_TABLE_H
 
+#include <linux/device.h>
 #include <linux/io.h>
 
 /* Coreboot table header structure */
@@ -91,4 +92,13 @@ int coreboot_driver_register(struct coreboot_driver *driver);
 /* Unregister a driver that uses the data from a coreboot table. */
 void coreboot_driver_unregister(struct coreboot_driver *driver);
 
+/* module_coreboot_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_coreboot_driver(__coreboot_driver) \
+	module_driver(__coreboot_driver, coreboot_driver_register, \
+			coreboot_driver_unregister)
+
 #endif /* __COREBOOT_TABLE_H */
diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index b8b49c067157..69a43116211c 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -97,19 +97,7 @@ static struct coreboot_driver framebuffer_driver = {
 	},
 	.tag = CB_TAG_FRAMEBUFFER,
 };
-
-static int __init coreboot_framebuffer_init(void)
-{
-	return coreboot_driver_register(&framebuffer_driver);
-}
-
-static void coreboot_framebuffer_exit(void)
-{
-	coreboot_driver_unregister(&framebuffer_driver);
-}
-
-module_init(coreboot_framebuffer_init);
-module_exit(coreboot_framebuffer_exit);
+module_coreboot_driver(framebuffer_driver);
 
 MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index b29e10757bfb..86331807f1d5 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -116,19 +116,7 @@ static struct coreboot_driver memconsole_driver = {
 	},
 	.tag = CB_TAG_CBMEM_CONSOLE,
 };
-
-static void coreboot_memconsole_exit(void)
-{
-	coreboot_driver_unregister(&memconsole_driver);
-}
-
-static int __init coreboot_memconsole_init(void)
-{
-	return coreboot_driver_register(&memconsole_driver);
-}
-
-module_exit(coreboot_memconsole_exit);
-module_init(coreboot_memconsole_init);
+module_coreboot_driver(memconsole_driver);
 
 MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index c0c0b4e4e281..4e978f4914ee 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -324,19 +324,7 @@ static struct coreboot_driver vpd_driver = {
 	},
 	.tag = CB_TAG_VPD,
 };
-
-static int __init coreboot_vpd_init(void)
-{
-	return coreboot_driver_register(&vpd_driver);
-}
-
-static void __exit coreboot_vpd_exit(void)
-{
-	coreboot_driver_unregister(&vpd_driver);
-}
-
-module_init(coreboot_vpd_init);
-module_exit(coreboot_vpd_exit);
+module_coreboot_driver(vpd_driver);
 
 MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL");
-- 
Sent by a computer through tubes

