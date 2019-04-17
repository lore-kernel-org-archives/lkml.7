Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB016C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3382177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="HGLxhPZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfDQORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33526 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbfDQORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:17:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so12115756plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fNHVBYSG1LQzeLv+ipI8X5v7TBJvF0lfFmPBXka6QU=;
        b=HGLxhPZbZ0XEasKOgFCl9LCyuOmeQvHDbT/iE6K+1bFYvHHTfyVX+Bwo2kSv0wnjbf
         wTEzcgOs4/aYMqY3+2e/JzTGdodvzn/aVBSNqUOVdA2sfiUNEaWGe6xo8Sqs1Q5dKKrd
         tEzGhUsT1rPXyCADRv6n+HYy6OIWJmj1PZIWB3UGp1/K/DfV7D5T0zlcL3DIt/RK8tGg
         OonE/7Qwf6eoRI8qfB8qgg6qDcOI1oP/wN1miNk64xhyogq+zDtLGddw0sAGBelJUWDP
         2Zs8ztGiGw4coi1JfLd5/eoaBUdnCTpeDf4vOobyVyiOJxvyMSHJkctX0jhzyEKC1br4
         yBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fNHVBYSG1LQzeLv+ipI8X5v7TBJvF0lfFmPBXka6QU=;
        b=Lx2M5QZke96dti7eSxJd+UKgAAJChzqvg9ARtwIOFi0l/z8dvK2BzY8UgBvqwA7JVh
         WYBS/JZBJ6iOEW1yOL66Gm5HDCT9jiu77cxZQL4zxrAlg5NLv9dD/+B8vR0TJ/HycqS7
         wbot2tcbIHBw33hjuBag7LlM+pP1oD9pfaPi1imuNqVRRQP9uU6vcgHwKBE9iHNOCln0
         nYM/M0ykiqn3VVO8jOQWpCmOjguleMZrglekCKuO7wiD5nhzIpTcChyrZjyTAWLM7j0A
         rx15JhfEWQywPaqCrPWEWVHpOoy1PyYUl2RR46qQEjyG3xOhjgTiUUimfB+qhgJ65qFV
         331g==
X-Gm-Message-State: APjAAAUsEroRS85DeQ/ZOZkKdwk3rX/6tGnNh4v4/bQEJtIdQgoegVIt
        7yarY2ueOx2FMhSqjv5vvthEQg==
X-Google-Smtp-Source: APXvYqyuZhzdfzrDDFPSiILKSRrMGdB6IgEYkjVOIhfW7PAcRkwlUxETKpv+wgsTP5GQRvf7NsLw4w==
X-Received: by 2002:a17:902:47c2:: with SMTP id d2mr88809581plh.277.1555510626765;
        Wed, 17 Apr 2019 07:17:06 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id y191sm30126832pgd.78.2019.04.17.07.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:17:06 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 5/5] regulator: wm8994: Switch to SPDX identifier
Date:   Wed, 17 Apr 2019 22:16:33 +0800
Message-Id: <20190417141633.4730-5-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417141633.4730-1-axel.lin@ingics.com>
References: <20190417141633.4730-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm8994-regulator.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 38928cdcb6e6..cadea0344486 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -1,15 +1,10 @@
-/*
- * wm8994-regulator.c  --  Regulator driver for the WM8994
- *
- * Copyright 2009 Wolfson Microelectronics PLC.
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
+// wm8994-regulator.c  --  Regulator driver for the WM8994
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.17.1

