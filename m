Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98BF20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fluc7UHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfFMQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38810 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFMQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:53:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so8414639plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2HSyqLuA62fmX26BujT/9wqw7NfTPaJ58H9IBnHqPR8=;
        b=Fluc7UHZgtrOSv48l3jODB7SJVkjZk5yCoE+1wfUSMQimt3UMruLylStkmXn4JtV/D
         VkWSX4zWn820Xuc9juOV3UG5yEyX5E0GTTloV7TdeyhJWYKCXRBQIXyVDJ2zyDQ5rwdd
         dSxVKQxrZjW7JsjWPwGCeIW3pKpFttvkTQgsi4KBjPun3xyzWYzSjbHVc1PZbGhlg5Ix
         JkGdyKUj2hB3aG6mzCYa9p+of1y7m4SuR9GFj5cQ7kiY4TXJR0x7Q1LHMBQKjN8h23Xn
         9ww0GexfFjqpFR43m/6seVS1p53rGZ2WJPNy7RMxiYErT8kl3xWlVpTkhS7Y266vnH7r
         qnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2HSyqLuA62fmX26BujT/9wqw7NfTPaJ58H9IBnHqPR8=;
        b=qfBtBMV1qpYIbQRdVRR9elKy3MDyviAtPXea5aDjMW7oydzHAhiLYDbzN8lwIdwnvQ
         SD3nXFrsaN5i5/gDsNFFvOFm1mbAG5nCoNhETXaJgl2cEqgh41C/YTVLygc1AMPuvrjn
         icvf2MlFLfTXZlaN/xau8accMxB2bjeYMm2bgFgNMOyYUuhn2uUCr+oouM1UWP5p8CXT
         hostBFm6m5c1VLhsbXmOiT2JHup6NJRe3ly5+Nsj1S7q9t5+Qhvv4SZeMYAWCQy3F8hj
         AeW9lLFNZSURKezq6SLniyNHrPHDKLagDi/JMWOjEPdL7wCMd3tpmKdKsayJGamXulFd
         JMww==
X-Gm-Message-State: APjAAAWtSxXBJKXImgsZm8KhLsIpN+Xzd9ySrI3tbEuFtAqIlbEyy/Uj
        ng13djxkHz7UetnVNATqaBI=
X-Google-Smtp-Source: APXvYqxGJS5iyGw3xreG2M23XcLYW2TbjhbEYU/AXfDGmkWeX5kocrJKp1hcZcn6qQNw0CB5X1EJvA==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr88073076plp.287.1560444790802;
        Thu, 13 Jun 2019 09:53:10 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c12sm197500pfn.104.2019.06.13.09.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 09:53:10 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     joro@8bytes.org, s-anna@ti.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] iommu/omap: convert to SPDX license tags
Date:   Thu, 13 Jun 2019 12:53:03 -0400
Message-Id: <20190613165303.1219-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
v2:
-add include/linux/platform_data/iommu-omap.h
---
 drivers/iommu/omap-iommu-debug.c         | 5 +----
 drivers/iommu/omap-iommu.c               | 5 +----
 drivers/iommu/omap-iommu.h               | 5 +----
 drivers/iommu/omap-iopgtable.h           | 5 +----
 include/linux/platform_data/iommu-omap.h | 5 +----
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 4abc0ef522a8..55ec67a45101 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * omap iommu: debugfs interface
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d2fb347aa4ff..e6442876913f 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * omap iommu: tlb and pagetable primitives
  *
@@ -6,10 +7,6 @@
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
  *		Paul Mundt and Toshihiro Kobayashi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/dma-mapping.h>
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 1703159ef5af..5256e17d86a7 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap iommu: main structures
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _OMAP_IOMMU_H
diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
index 01a315227bf0..871c2a38f453 100644
--- a/drivers/iommu/omap-iopgtable.h
+++ b/drivers/iommu/omap-iopgtable.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap iommu: pagetable definitions
  *
  * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _OMAP_IOPGTABLE_H
diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index e8b12dbf6170..a6cbca5406e0 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap iommu: main structures
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/platform_device.h>
-- 
2.17.0

