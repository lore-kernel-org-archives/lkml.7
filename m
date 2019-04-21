Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B04C282DD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 02:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E313020850
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 02:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="lIcIpYJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDUC10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 22:27:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDUC1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 22:27:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so4276573pgu.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+he5uOC0TV1I9Vftp/Q5mAs97mJwaCvpxiFwD6rTT3A=;
        b=lIcIpYJSKffZx/ncg8LybC636IPkYaFDq1OFr4bdGyPcTVCy3eMMiBwQvWQg6p5zAX
         7lmizjJAP8fsykhPOyYkAcpy0oDbJGwkEIB9itukWLvRNN30UNJ5hQ9HKNp7ojAckKYn
         drChe7KyaQTBUzDmZfxN7HCInhqlWSH45YKIXWkVB2H3oeI6QXYbPAjh/O9AjPH0mjec
         Ol6n2n6WHLoKGe1Rt9aN+Awb0+VnMLUHYkoxeN1zcB4Ba8YAUFoN75XWuSiDhv31aZSw
         Oz1QrerFbC0CfxM8sc2QJEWlE7XkuEOR7YOhHGYWj9jWeHTnTCLI2/QalLPRoyWr2Cc/
         S5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+he5uOC0TV1I9Vftp/Q5mAs97mJwaCvpxiFwD6rTT3A=;
        b=eyoOaYKL5rjk9v1O0hIgi6Df7RQ9PzVmM5v1dwAV27Nt/It2W243RoCk8iSut2ACXu
         pwP4elVTet3o2OtwJ3rpQIK4oZdNHHgHJM2hvk9ogSbuh6H8s+Jp6DASUZsFgd44+lIP
         RWC4dusB8jgOHRmIXhF8T/F1OFSJfYOLB+W89px70+jEf475PXrqOhvNtxvf3yAmhyl3
         RtDZ8D0Jmwg1RWsV+tHrRBrzvKmwSVyIg/sklnLm9gleenN9Xj36T+xJCePWCvb/n0um
         0tAMYB+UT37TvplbF89hfWfOj5vzAlGKnld475r/YMC+1XNyDvxysdxodN/vCYSEd9np
         uY/Q==
X-Gm-Message-State: APjAAAVg7yV7VUI8c4DLMbHsQk3DWEQIYfL9lAkmOaZNW+rCVqcN77ps
        5ma2Ikr+MGjFHesL59ygnbqWVEi9WJM=
X-Google-Smtp-Source: APXvYqzMJnGPfEaz+m3KSpkIg9vlvlOp92TD9BUbKIcq4onBTuDn12viJF7IeW0SyVZoULXukMWV/A==
X-Received: by 2002:a63:cc0b:: with SMTP id x11mr11756917pgf.35.1555813644443;
        Sat, 20 Apr 2019 19:27:24 -0700 (PDT)
Received: from localhost.localdomain (118-171-134-240.dynamic-ip.hinet.net. [118.171.134.240])
        by smtp.gmail.com with ESMTPSA id u20sm12200196pfh.112.2019.04.20.19.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 19:27:23 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Henry Chen <henryc.chen@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt63xx: Switch to SPDX identifier
Date:   Sun, 21 Apr 2019 10:26:56 +0800
Message-Id: <20190421022656.5838-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MediaTek mt63xx PMIC drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6311-regulator.c | 17 ++++-------------
 drivers/regulator/mt6311-regulator.h | 10 +---------
 drivers/regulator/mt6323-regulator.c | 12 ++++--------
 drivers/regulator/mt6380-regulator.c | 17 ++++-------------
 drivers/regulator/mt6397-regulator.c | 17 ++++-------------
 5 files changed, 17 insertions(+), 56 deletions(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 01d69f43d2b0..af95449d3590 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (c) 2015 MediaTek Inc.
- * Author: Henry Chen <henryc.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2015 MediaTek Inc.
+// Author: Henry Chen <henryc.chen@mediatek.com>
 
 #include <linux/err.h>
 #include <linux/gpio.h>
diff --git a/drivers/regulator/mt6311-regulator.h b/drivers/regulator/mt6311-regulator.h
index 5218db46a798..4904d6751714 100644
--- a/drivers/regulator/mt6311-regulator.h
+++ b/drivers/regulator/mt6311-regulator.h
@@ -1,15 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Henry Chen <henryc.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __MT6311_REGULATOR_H__
diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index 25b002328910..893ea190788a 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -1,11 +1,7 @@
-/*
- * Copyright (c) 2016 MediaTek Inc.
- * Author: Chen Zhong <chen.zhong@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2016 MediaTek Inc.
+// Author: Chen Zhong <chen.zhong@mediatek.com>
 
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index 86bc332df3f2..b6aed090b5e0 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (c) 2017 MediaTek Inc.
- * Author: Chenglin Xu <chenglin.xu@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2017 MediaTek Inc.
+// Author: Chenglin Xu <chenglin.xu@mediatek.com>
 
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 3e6c8d99ec0f..fd9ed864a0c1 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (c) 2014 MediaTek Inc.
- * Author: Flora Fu <flora.fu@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2014 MediaTek Inc.
+// Author: Flora Fu <flora.fu@mediatek.com>
 
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.17.1

