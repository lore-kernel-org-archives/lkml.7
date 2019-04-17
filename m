Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E19AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF8B2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="wqSBnggG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbfDQORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41277 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbfDQOQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:16:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so12073052pgs.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTfqGR5tJxhpVPCop1U/bt3KZGcWib0N8iwOYtFGzOw=;
        b=wqSBnggG69knsyuaLi+PbJLnnEuXIu+sf5UBUDUybUGwKYSCiFbucBvYNYK3QtN93M
         6iZIPx7JeWa70Jkc8LijJVh4CppcsRNOCubK+Cgy6usNIyuQWaXF6xsH8hbJpXI+FYB+
         kJaaUTdaJIsmr3QooR2LcvpYIc3xlbbFgNCipBeZ2y6r2vaOsrnaLVf5I9iCnM+paNRc
         zAoi1/IyAICRT/fV3lGwgjCD1RXq28C5J4RYNOt7H0GNfVkxEp0XWEwXP4p+StQcyXsb
         ohp7s8N5xuTzmdnTstzPW0ervxaZvpLc/y5z33sSHr176B3aVlmtqzw5DhaR/Jw9RzG1
         QSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTfqGR5tJxhpVPCop1U/bt3KZGcWib0N8iwOYtFGzOw=;
        b=DQdgJTV1KR/9xEiwNJgKIJZsi2fsL8CYoynSxYOLYtEn8UQhUMlbIw0v3HK92BuEHs
         k1U/RY5rJoeLGibT34Ih0nJXwny3Z1EoV2JM9cvpcHijFJpm25sTVOJDe0uHQaId4u7p
         dJhFQgTsWbX5OvsNHscLERWNuxWf0SvnmqikKGyHZFeXWtrtFnpgXxtqO6jwJGbvoT6m
         mvr0PRp66QnJxgKLou6NA2njZnjPvUlCD7l3ho/j5JbE0FUo40rQnwnb+DZIxomv2TCT
         w+Pn1S8CZvwU1wkAq3YdgVIeMnu67uGgA+E/mqGmnL2b1+3fFJQLk/qxngdkaYYdkeHe
         313A==
X-Gm-Message-State: APjAAAXNfosRVSKBCBKiUucd8K6Ed2k7OtOWc4b+Vy4O+8z5XbkGh7Ev
        nhtlMD2NuS74ScRvBcRDW6P6sQ==
X-Google-Smtp-Source: APXvYqznfwyPlqThwCH9H2i1GPeJt7y7DQDl0Mwc5MaxEcO0DFc7ajD9w6Ml0qU8HJhg7KxMtUz96w==
X-Received: by 2002:aa7:9888:: with SMTP id r8mr35829649pfl.116.1555510618362;
        Wed, 17 Apr 2019 07:16:58 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id y191sm30126832pgd.78.2019.04.17.07.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:16:57 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/5] regulator: wm831x: Switch to SPDX identifier
Date:   Wed, 17 Apr 2019 22:16:30 +0800
Message-Id: <20190417141633.4730-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417141633.4730-1-axel.lin@ingics.com>
References: <20190417141633.4730-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm831x-dcdc.c  | 19 +++++++------------
 drivers/regulator/wm831x-isink.c | 19 +++++++------------
 drivers/regulator/wm831x-ldo.c   | 19 +++++++------------
 3 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index d1873f94bca7..8b607e21fc86 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -1,15 +1,10 @@
-/*
- * wm831x-dcdc.c  --  DC-DC buck convertor driver for the WM831x series
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
+// wm831x-dcdc.c  --  DC-DC buck converter driver for the WM831x series
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index bdc521a6f048..ff3d2bf50410 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -1,15 +1,10 @@
-/*
- * wm831x-isink.c  --  Current sink driver for the WM831x series
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
+// wm831x-isink.c  --  Current sink driver for the WM831x series
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index fcd038e7cd80..56754686c982 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -1,15 +1,10 @@
-/*
- * wm831x-ldo.c  --  LDO driver for the WM831x series
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
+// wm831x-ldo.c  --  LDO driver for the WM831x series
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.17.1

