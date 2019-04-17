Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BAFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DC32177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="gj1eHrtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfDQOQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:16:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45219 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbfDQOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:16:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so12061814pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2n/4frWh5OiXH/UDWVL3+5y3+8UTBKb2DDmNS1SHOaM=;
        b=gj1eHrtjPd+VBMf7o6+2ppB0zdnVEdu5iUa+yOC03ATtPme/D/qLmBSSYTiCBzmOW5
         ZhAZoG6hDikVPSvpwMdS2bnoNhUW5WeXcKmXZUihgax/HvKfQ5Qrf9mjPmeTY90xogrT
         LCaIndahg3ffQkxFq/WxoeJeYUItYHJAOqz9afTN8YWnTsd4f1QH6U8rEry64HRPRLHz
         PyxC6B9rDeAKNdFc74JTTOdYME5ff/qUlh3+3MXxKCnH2EAp8iT+x1c92Al/7va4nu33
         fK99mC36U82hFCkPZDsGbtdQHD37ZHHjW/ByPnRT0yJ0t1gSbICGhkZuOl7c0yxhWNHq
         6xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2n/4frWh5OiXH/UDWVL3+5y3+8UTBKb2DDmNS1SHOaM=;
        b=ZKV91/4GmeyE+Jz39JFQqOq7bZea1CQGcT42HctR8Jmld5uJwgkg8G5E8kfTsA5JIi
         Xagvy7wS2/eLSb1SXKcKqrwwQSSaSsq1CmhKFYKPJB8zVZRpHx8lYx17GuyqkNF3h/lq
         Lphk8L6lcNMoqs98YNemEQst0HfOzzjyUsyfgc3CrqyHUA7aLqeSC6pZ44/cXU2vcem6
         y39ujCUEHT3OLwkwnvqsNth+22fqc4u4KQR+8xijrETwYeoWUNyK5a4a9RCBI/UJthU4
         9gos/oAUjimnWJ9wHtb9sHFdVhhisEyl0wATDWfeZrH/RWHZYH5KukrZuOMI5X6hWqfc
         fZcw==
X-Gm-Message-State: APjAAAVFHbXdfofOerH71OziRXZevCSL6EuvZJ/WSgrzsm9nWjt5ND0+
        JUyDj4jQl2OywPPMJR0UdYM4xw==
X-Google-Smtp-Source: APXvYqwaX4t07Ea+x3qpuBJxFCfwN0Lh4pVqdMM9n730NzVCBEBL96T1ZUFTUNUYEJmVHG4yKpIZuQ==
X-Received: by 2002:a63:170d:: with SMTP id x13mr83814678pgl.169.1555510615349;
        Wed, 17 Apr 2019 07:16:55 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id y191sm30126832pgd.78.2019.04.17.07.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:16:54 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/5] regulator: arizona: Switch to SPDX identifier
Date:   Wed, 17 Apr 2019 22:16:29 +0800
Message-Id: <20190417141633.4730-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/arizona-ldo1.c    | 19 +++++++------------
 drivers/regulator/arizona-micsupp.c | 19 +++++++------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index bf3ab405eed1..e4bc7b1e5ccd 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -1,15 +1,10 @@
-/*
- * arizona-ldo1.c  --  LDO1 supply for Arizona devices
- *
- * Copyright 2012 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// arizona-ldo1.c  --  LDO1 supply for Arizona devices
+//
+// Copyright 2012 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 120de94caf02..be0d46da51a1 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -1,15 +1,10 @@
-/*
- * arizona-micsupp.c  --  Microphone supply for Arizona devices
- *
- * Copyright 2012 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// arizona-micsupp.c  --  Microphone supply for Arizona devices
+//
+// Copyright 2012 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.17.1

