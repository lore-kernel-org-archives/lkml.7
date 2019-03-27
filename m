Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C87C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834D9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soKNkdjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfC0QVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:21:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39728 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfC0QVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:21:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id b65so3547680plb.6;
        Wed, 27 Mar 2019 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U/9jRmdo4t+mthWLkD+v8SrxVZzn2m3THYoN0qUy4SQ=;
        b=soKNkdjPxPxylTavqSlN5O1IWCvLbC9+4Gi/SSXt8216tn5g7STQV1+tqG9iWI3f/j
         8l/vNCEe2Y6OvAliTq4k+7flxk8xb8YUHTbg08jVA5FNwE0gwqGrRAm2+PsRYaq7kDy6
         KB1snQ6EE+uP1pdZXUicxVhbK/WH0pMr6VdijCgI9iqwtXlXfAGJ9Bs6cN/JNLS+wR6Y
         V/aU6qir6Vk+N5DmIX6D7dr7/5Tz4olaOU7DGO/v2XN0KhHevwqx18fyD52mgZPVPGZW
         7RfrK/Df10vQ8XbrXsHvVJOxtCN8HUCGEuLOi/UGCnyRdiMSmg3ik54ktr5DlDFNGkmA
         etqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U/9jRmdo4t+mthWLkD+v8SrxVZzn2m3THYoN0qUy4SQ=;
        b=aURnD1sT4jojE+8sqzTQHYIYAGW8wo5zVWxNNlk6H8BsnW4GRaOXD5joka9nI3/7VA
         a2vcH3kIDiOckvRlwBM8niSF6Ypjy/0zxnlXtXeu5CjJ/IChOBd31oeaJm09mj0QsDpe
         EB2DB61YgdLd9mlzSqJce5/E07LNmYuMyd50j/yvDslL2CPH0BcDFoCd4GjX5XS5qVz0
         gyjogiBwZjV7eipS8Lo8PVZn6IGbuRNEllAXuCmffJ4Q4v2eYxhfYgNNmNS99StevCJ6
         magy4G0FwNw3Sdfbey1epcpz+CzGcamPdgAJXPRnqk6t8rUE5VsOIgTsRzcfAwC2fJsl
         43TA==
X-Gm-Message-State: APjAAAWzNH8B7mtOAmXbmUn52waMr4FjLT+Z8rQn8JRgYHyHdE47nY4W
        zpmmwEIB0YSt/ra60TI3Orm3l41a
X-Google-Smtp-Source: APXvYqzuqplRhQBpmb7LQIO1w+pO7cINVYBTYrwDZ98dsoX2I35O+kh0OprJh/WEBwfWP+GaZJYq2g==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr38596312plk.282.1553703664042;
        Wed, 27 Mar 2019 09:21:04 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id h19sm40306448pfd.130.2019.03.27.09.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:21:03 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     ysato@users.sourceforge.jp, dalias@libc.org, paul.burton@mips.com,
        arnd@arndb.de
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] arch:sh:mach-sh03/rtc.c : Remove duplicate header
Date:   Thu, 28 Mar 2019 02:50:42 +0530
Message-Id: <1553721642-38293-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/sh/boards/mach-sh03/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 8b23ed7..165e2cc 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -14,7 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#include <linux/rtc.h>
 #include <linux/platform_device.h>
 
 #define RTC_BASE	0xb0000000
-- 
1.8.3.1

