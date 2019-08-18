Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28DC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE122146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4kUKngo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfHRGGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 02:06:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44651 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfHRGGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 02:06:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so5052186pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CvRIDTT/VqqZOpPgct50n3Df36edF9IHOhVZeXIBeL0=;
        b=V4kUKngo5//gfBGSmtrIuRGZ7Cvvn20Q102KVvc0Tmd+w6TC9ejNFvWVnu/YkEf1qK
         CZwYuXHnAEzNMy8lbUIieyMDn7J9bX/2m5IagowZjoWWxxdroqWNgOltklPQacCnioJB
         qqDGMKAbZbRext2LA0g9UJiEjnx5zMHfNbHZoLlam5+1LEp2TN5i7Dsc3PsBIRL6AiVE
         KPGJDWsbgOsSvBm7WiymakfhgF5aiaC8GdtEsY2IAO6OnIXpPZaw8/nlbwGC8k9qTtNt
         BNgNzNSrLdXbbewbd9vFUr4X1+8TYCaOkEk3zgLff21fdGUGuKxwY/E1xFgt/R+ws4o1
         MMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CvRIDTT/VqqZOpPgct50n3Df36edF9IHOhVZeXIBeL0=;
        b=eq8s0Qqzz3S7gPbiz8ban9Me8muttbnFe3I2nSSh633Ch1JuL4OTqRl1Dm+lqKavqJ
         PO7gfL2fch+BATxn/SWHUMCi1Mcs+u17d7o95YUtcS5mUDZEo9B1wT8tvG1lc085NaCY
         POmtC5k2cBLJ+XJFEkjlBAXroHIQFvow7uWtfhqLv8zclyJrPU/SAl4Wy9UMYRkFdNe9
         slJ4n4bwOlDFIDpuxnVEShT0BMgEicpuW5eGTlLfCavVbM4PK28c39Iu4C9lfbP6olav
         y6YqNo3kbgaJhMtgdjHEfj8nA1mv6HCa1E0AtpYsESqvNXxO0K+Z0pvvkUTH29OKz1fC
         jBpg==
X-Gm-Message-State: APjAAAVYUeJ15Ef12/xXGwVMFNzsVsxHas/Yaqn5XRVgLlT0v1uRbBoP
        VEtQFJNP+8BwWtuEjEHX8c8=
X-Google-Smtp-Source: APXvYqx10WUxCnkO9WwfmgDKgcXDLcZ6VFYlFxHcxbC5diPi+a9X2ff9GIOTYI90K/9ohDsoicjQOw==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr18794284pfg.112.1566108379575;
        Sat, 17 Aug 2019 23:06:19 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.255])
        by smtp.gmail.com with ESMTPSA id g10sm11575611pfb.95.2019.08.17.23.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 23:06:18 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     linux@armlinux.org.uk
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] ARM: amba: Move EXPORT_SYMBOL immediately next to the exported function
Date:   Sun, 18 Aug 2019 11:36:08 +0530
Message-Id: <1566108368-23782-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL should appear next to the function as it improves
code maintenance. This commit fixes this issue as identified by
checkpatch script.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/amba/bus.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 100e798..39e5235 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -340,6 +340,7 @@ int amba_driver_register(struct amba_driver *drv)
 
 	return driver_register(&drv->drv);
 }
+EXPORT_SYMBOL(amba_driver_register);
 
 /**
  *	amba_driver_unregister - remove an AMBA device driver
@@ -353,7 +354,7 @@ void amba_driver_unregister(struct amba_driver *drv)
 {
 	driver_unregister(&drv->drv);
 }
-
+EXPORT_SYMBOL(amba_driver_unregister);
 
 static void amba_device_release(struct device *dev)
 {
@@ -668,6 +669,7 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 
 	return amba_device_add(dev, parent);
 }
+EXPORT_SYMBOL(amba_device_register);
 
 /**
  *	amba_device_put - put an AMBA device
@@ -694,7 +696,7 @@ void amba_device_unregister(struct amba_device *dev)
 {
 	device_unregister(&dev->dev);
 }
-
+EXPORT_SYMBOL(amba_device_unregister);
 
 struct find_data {
 	struct amba_device *dev;
@@ -754,6 +756,7 @@ amba_find_device(const char *busid, struct device *parent, unsigned int id,
 
 	return data.dev;
 }
+EXPORT_SYMBOL(amba_find_device);
 
 /**
  *	amba_request_regions - request all mem regions associated with device
@@ -775,6 +778,7 @@ int amba_request_regions(struct amba_device *dev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(amba_request_regions);
 
 /**
  *	amba_release_regions - release mem regions associated with device
@@ -789,11 +793,4 @@ void amba_release_regions(struct amba_device *dev)
 	size = resource_size(&dev->res);
 	release_mem_region(dev->res.start, size);
 }
-
-EXPORT_SYMBOL(amba_driver_register);
-EXPORT_SYMBOL(amba_driver_unregister);
-EXPORT_SYMBOL(amba_device_register);
-EXPORT_SYMBOL(amba_device_unregister);
-EXPORT_SYMBOL(amba_find_device);
-EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
-- 
2.7.4

