Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5227AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B42075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="lLbHXMkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfECFiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:38:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38262 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfECFiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:38:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so2165495pla.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 22:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYHBVZuWGvhY42WlCyICPcJk8P9hdkt8ebAaK16otPU=;
        b=lLbHXMkLadzpkMsD+TsFNDR46pUzb+CFzxbkK0dAIM1AxQxiNH91RPvf+gDFk/mTTr
         83rlHkqjgyGBM61502KwOJ/8Vl54hPM94HYt5u3393NwD4lobVK4Z5Cct/daeFsQ6nuR
         5OCTRAtoo5b20LweqGbAw8xke/2CHNZA8c0tbbIzhVFjqTvsra8gwSS4YH4w1RtlTJWP
         Y37H8ZnqD4KZzw8DUnbAM15EkjsiT2NH2KLMnqRbmRjAIS7UjX+yxjsDjHhU9Hf+grtN
         j5PPmfzKTBl3y7VfWdDrJBF/A+z0TAbMUL9+Bnxqn3cHsHlWhMgXNDpwBX6bM3woerBZ
         UNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYHBVZuWGvhY42WlCyICPcJk8P9hdkt8ebAaK16otPU=;
        b=qalB3NqUjW+U7z0zcx+UqRZsdlGvRd/Xr1/7J97tFlR3ke/3AKRxvXTIFmvIxKJxez
         Wagw4y3KO4SS6TeEWSEqOgS4JOZQVLnmwdiH5epis6xpBvLbeU0nANn1B3t4HDae8ZMc
         AW/E7llxA3m3SQwVff38IbbrxDcBjAZ6K/rLV1rHYKfaConxvCZSg3l0G+tEguYB0smu
         g2DCrKM8LCnSrDdXbcX9uI7R4dzxU4dGvyuUpO5oAw5c2upP5ZzqhLqJevZV9kCacbzc
         Gu5j9UgzOobVc55xTck3BKub9drTJez4xzLWv1R9/3hRNXUZI3QqJmP6geGptM5MXxzx
         aHwA==
X-Gm-Message-State: APjAAAWxRNblrnanKoF9Selmt1mIwZNASle15fbbOzieDZyXNbD87SI0
        gmCbOJovarCaqaI3/NaMqqZl1g==
X-Google-Smtp-Source: APXvYqxfu2ed7ADvOir3JmPuykKo6PZp3zZq2HdCL0jNui4BKve/eZrlUfC06N0WNiBGSFF6VL1FUQ==
X-Received: by 2002:a17:902:2ba6:: with SMTP id l35mr8002481plb.56.1556861895470;
        Thu, 02 May 2019 22:38:15 -0700 (PDT)
Received: from localhost.localdomain (36-239-225-241.dynamic-ip.hinet.net. [36.239.225.241])
        by smtp.gmail.com with ESMTPSA id s6sm1191627pfb.128.2019.05.02.22.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 22:38:14 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: pv880x0: Switch to SPDX identifier
Date:   Fri,  3 May 2019 13:36:36 +0800
Message-Id: <20190503053637.25911-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Powerventure Semiconductor PV88060/PV88080/PV88090 regulator
drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pv88060-regulator.c | 18 ++++--------------
 drivers/regulator/pv88060-regulator.h | 11 +----------
 drivers/regulator/pv88080-regulator.c | 18 ++++--------------
 drivers/regulator/pv88080-regulator.h | 11 +----------
 drivers/regulator/pv88090-regulator.c | 18 ++++--------------
 drivers/regulator/pv88090-regulator.h | 11 +----------
 6 files changed, 15 insertions(+), 72 deletions(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 810816e9df5d..3d3415839ba2 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -1,17 +1,7 @@
-/*
- * pv88060-regulator.c - Regulator device driver for PV88060
- * Copyright (C) 2015  Powerventure Semiconductor Ltd.
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
+// pv88060-regulator.c - Regulator device driver for PV88060
+// Copyright (C) 2015  Powerventure Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/pv88060-regulator.h b/drivers/regulator/pv88060-regulator.h
index 02ca9203a172..d333dbf3be94 100644
--- a/drivers/regulator/pv88060-regulator.h
+++ b/drivers/regulator/pv88060-regulator.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pv88060-regulator.h - Regulator definitions for PV88060
  * Copyright (C) 2015 Powerventure Semiconductor Ltd.
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
 
 #ifndef __PV88060_REGISTERS_H__
diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 6279216fb254..a444f68af1a8 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -1,17 +1,7 @@
-/*
- * pv88080-regulator.c - Regulator device driver for PV88080
- * Copyright (C) 2016  Powerventure Semiconductor Ltd.
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
+// pv88080-regulator.c - Regulator device driver for PV88080
+// Copyright (C) 2016  Powerventure Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/pv88080-regulator.h b/drivers/regulator/pv88080-regulator.h
index ae25ff360e3d..7d7f8f11a75a 100644
--- a/drivers/regulator/pv88080-regulator.h
+++ b/drivers/regulator/pv88080-regulator.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pv88080-regulator.h - Regulator definitions for PV88080
  * Copyright (C) 2016 Powerventure Semiconductor Ltd.
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
 
 #ifndef __PV88080_REGISTERS_H__
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 90f4f907fb3f..b1d0d97ae935 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -1,17 +1,7 @@
-/*
- * pv88090-regulator.c - Regulator device driver for PV88090
- * Copyright (C) 2015  Powerventure Semiconductor Ltd.
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
+// pv88090-regulator.c - Regulator device driver for PV88090
+// Copyright (C) 2015  Powerventure Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/pv88090-regulator.h b/drivers/regulator/pv88090-regulator.h
index 62d9029277f4..f814ee52cff3 100644
--- a/drivers/regulator/pv88090-regulator.h
+++ b/drivers/regulator/pv88090-regulator.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pv88090-regulator.h - Regulator definitions for PV88090
  * Copyright (C) 2015 Powerventure Semiconductor Ltd.
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
 
 #ifndef __PV88090_REGISTERS_H__
-- 
2.20.1

