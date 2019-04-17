Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AB3C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630ED21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="yzVHB1D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfDQORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfDQORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:17:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so12111487ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/655OZLWorey6ilKlJldpTvF4n+kUyacLjH+gM3xYXI=;
        b=yzVHB1D0F976I2OJFeeX1tpan9nTa7344B2jsxDmxEGU9lHKUYjZUEFY+gGyqPNJSj
         l4Xzl2wqVwfZhDPHjrWGX7bkrV03zoXJJU6wCO+xjb/Z2a3adc4A0rylQq4qiKIo9v0i
         FXdRtbnWobWOBZ9DA7HILRk9Rp3R0+b5TeJVdf+OzgKDz9u4cdU0oIdGFMFsD7f1AJyT
         z4AihAwwo38ieI+dgMLPpUPq2XCqD0QPOiOGLMf7EGb6zLXNqT1eevEyvUdSePDcKTma
         BSPt8r+hNscwyAM0u1vs9FjJC86bnbCbg+d5M+pG6zPq4o4PEQdUT2YraAa75mUefDXF
         6Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/655OZLWorey6ilKlJldpTvF4n+kUyacLjH+gM3xYXI=;
        b=HAariBtSP13g41+cWcngFS7x0VFzeq1mWLB0Rem1YuXQh/JNwti7Vpuo/V/MzWYczl
         e88OJMYmFfaeHbnuKt+duyXBVZp3dhf8o90sjZOiDIkJW4YWYc/UD1e0avVT9QvPEEo5
         BC61MRFUNGgl2aRzuydcXTH589UTV9ykIqmKAR79Izx/99SarJIyg2mlYWG+wKSP6CVI
         bTYXCIse4f8gRDW/CjPivsvMcPZIlUFjfItxy1ch8rf1dQjmCdlFAIy5Dg9q0ECAu1Mf
         aXlcI+oFF7bLMqUnB2flh2q8xNEz/gJCoUuSgj0+GvL0PCYZc91YgbLoxu5jy0+t6orH
         5DoA==
X-Gm-Message-State: APjAAAXb6XHwKJYQl/asf9Yi6E+NbKJHFn84ibUqsjAbcuXLE6iEt/AC
        3zk+N+/eEYag7o9Nyay+CgW4vA==
X-Google-Smtp-Source: APXvYqxqlY0EzKunJydinI3fDBntv5BRiAGSJJLyjQ75v13VjsgKc7k/wm9Cn04gW4sv9h1aEXVY1g==
X-Received: by 2002:a17:902:e20e:: with SMTP id ce14mr90272554plb.193.1555510623962;
        Wed, 17 Apr 2019 07:17:03 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id y191sm30126832pgd.78.2019.04.17.07.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:17:03 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 4/5] regulator: wm8400: Switch to SPDX identifier
Date:   Wed, 17 Apr 2019 22:16:32 +0800
Message-Id: <20190417141633.4730-4-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417141633.4730-1-axel.lin@ingics.com>
References: <20190417141633.4730-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm8400-regulator.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index 5ce86b92851b..6f331b51e479 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -1,16 +1,10 @@
-/*
- * Regulator support for WM8400
- *
- * Copyright 2008 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator support for WM8400
+//
+// Copyright 2008 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/bug.h>
 #include <linux/err.h>
-- 
2.17.1

