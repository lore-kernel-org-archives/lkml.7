Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B082075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="DKbnsujQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfECFiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:38:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44465 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfECFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:38:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so2165869pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrG4adbzm8rhl9lzQwwsT4j7/8ZM9jWT4N4b6uIeZ/g=;
        b=DKbnsujQw9KJl/xO9yZs1Lw5sU+M2YYirQBtAixmM04Au9F0p/4ddnNvUVYOLcoLC7
         tlabpId5CR354lGHRl5RlQcs9hZgf01oryA/ApSpQHiES72O7D23mCjwgPNlmlOZ6RJy
         3ZkMzXtL0cIQPX/0d2DZ2Uhc7BIx2AZJs9eAxx4JmhiRSwMePZIU8ndXw+nH92+QVCky
         T84LHE30jLlepQ1GsGsbo1zBBC0QfZvJn62fKxtxSX4PsTd4wJT1y9DRrJFeEnL/6y5b
         ecm8fEAjsE7ZO6aOopKkQAvVHTANPAx7CSv0CJGNijqaySL0mqyPB80MMpejwAcTrTJH
         qh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrG4adbzm8rhl9lzQwwsT4j7/8ZM9jWT4N4b6uIeZ/g=;
        b=eMDsvrZJZiVuxVZxjVqfYXphQ+E+S/JKpx3c5nfXR/6nazcrHex/RUxn+mvbgIyJ3L
         4t36N5bWCx02pnRqvB3ldLHLfsvVTtkdP9OaZmfy7TJGBhbRxPQ2cJBSgur1LoFCNsrl
         2oi21U1pW/hTqYnbmAI2YmKxFlj+R7M+SjaREPusK6Q9ZMengnD3sYqT4Y7XYTvBP65p
         ae+xnqB5ZIubsQiJxNT/W0Ng1FmKxSpO7TVksuXfKxWswQoajOnfRnygIsbsf//3w2aX
         JEpmExsMrGcCKRH7Xq8DO88SbDSO0Gt2pnGhvKjvUhEQEdMivJCTVPQCnQIfS/3buzE/
         UmNg==
X-Gm-Message-State: APjAAAVVR0HMtUG/mrA214MI6v76/XxLTCCk7k/5+ijjwMo7h+g1SJyf
        z+qyy23sAH7Ue8BJhdWGTdwZsw==
X-Google-Smtp-Source: APXvYqxDEnoulNA7Pe3HqpZkLlOeHvutxvBthd4KPKFEAsiFJt6CRTvDZoyXTeiTw1hTIWqW6hZ11w==
X-Received: by 2002:a65:5086:: with SMTP id r6mr8219353pgp.301.1556861898319;
        Thu, 02 May 2019 22:38:18 -0700 (PDT)
Received: from localhost.localdomain (36-239-225-241.dynamic-ip.hinet.net. [36.239.225.241])
        by smtp.gmail.com with ESMTPSA id s6sm1191627pfb.128.2019.05.02.22.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 22:38:17 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9xxx: Switch to SPDX identifier
Date:   Fri,  3 May 2019 13:36:37 +0800
Message-Id: <20190503053637.25911-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503053637.25911-1-axel.lin@ingics.com>
References: <20190503053637.25911-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Dialog Semiconductor DA9xxx regulator drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da903x.c           | 16 ++++++----------
 drivers/regulator/da9052-regulator.c | 20 +++++++-------------
 drivers/regulator/da9055-regulator.c | 20 +++++++-------------
 drivers/regulator/da9062-regulator.c | 19 +++++--------------
 drivers/regulator/da9210-regulator.c | 23 ++++-------------------
 drivers/regulator/da9210-regulator.h | 17 +----------------
 drivers/regulator/da9211-regulator.c | 20 +++++---------------
 drivers/regulator/da9211-regulator.h | 11 +----------
 8 files changed, 36 insertions(+), 110 deletions(-)

diff --git a/drivers/regulator/da903x.c b/drivers/regulator/da903x.c
index 33e8f3b8d2bd..5493c3a86426 100644
--- a/drivers/regulator/da903x.c
+++ b/drivers/regulator/da903x.c
@@ -1,13 +1,9 @@
-/*
- * Regulators driver for Dialog Semiconductor DA903x
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- * Copyright (C) 2008 Compulab Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulators driver for Dialog Semiconductor DA903x
+//
+// Copyright (C) 2006-2008 Marvell International Ltd.
+// Copyright (C) 2008 Compulab Ltd.
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index b90a7ac3f3de..e18d291c7f21 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -1,16 +1,10 @@
-/*
-* da9052-regulator.c: Regulator driver for DA9052
-*
-* Copyright(c) 2011 Dialog Semiconductor Ltd.
-*
-* Author: David Dajun Chen <dchen@diasemi.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9052-regulator.c: Regulator driver for DA9052
+//
+// Copyright(c) 2011 Dialog Semiconductor Ltd.
+//
+// Author: David Dajun Chen <dchen@diasemi.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index bcbc2fbd7fea..c025ccb1a30a 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -1,16 +1,10 @@
-/*
-* Regulator driver for DA9055 PMIC
-*
-* Copyright(c) 2012 Dialog Semiconductor Ltd.
-*
-* Author: David Dajun Chen <dchen@diasemi.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator driver for DA9055 PMIC
+//
+// Copyright(c) 2012 Dialog Semiconductor Ltd.
+//
+// Author: David Dajun Chen <dchen@diasemi.com>
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index a7d929b7776a..a02e0488410f 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1,17 +1,8 @@
-/*
- * Regulator device driver for DA9061 and DA9062.
- * Copyright (C) 2015-2017  Dialog Semiconductor
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator device driver for DA9061 and DA9062.
+// Copyright (C) 2015-2017  Dialog Semiconductor
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 528303771723..f9448ed50e05 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -1,22 +1,7 @@
-/*
- * da9210-regulator.c - Regulator device driver for DA9210
- * Copyright (C) 2013  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9210-regulator.c - Regulator device driver for DA9210
+// Copyright (C) 2013  Dialog Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/da9210-regulator.h b/drivers/regulator/da9210-regulator.h
index 749c550808b6..b1f1a607c208 100644
--- a/drivers/regulator/da9210-regulator.h
+++ b/drivers/regulator/da9210-regulator.h
@@ -1,22 +1,7 @@
-
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * da9210-regulator.h - Regulator definitions for DA9210
  * Copyright (C) 2013  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
- * Boston, MA  02110-1301, USA.
  */
 
 #ifndef __DA9210_REGISTERS_H__
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 4d7fe4819c1c..da37b4ccd834 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -1,18 +1,8 @@
-/*
- * da9211-regulator.c - Regulator device driver for DA9211/DA9212
- * /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
- * Copyright (C) 2015  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9211-regulator.c - Regulator device driver for DA9211/DA9212
+// /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
+// Copyright (C) 2015  Dialog Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/da9211-regulator.h b/drivers/regulator/da9211-regulator.h
index 2cb32aab4f82..1201e7cc056c 100644
--- a/drivers/regulator/da9211-regulator.h
+++ b/drivers/regulator/da9211-regulator.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * da9211-regulator.h - Regulator definitions for DA9211/DA9212
  * /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DA9211_REGISTERS_H__
-- 
2.20.1

