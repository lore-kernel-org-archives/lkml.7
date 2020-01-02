Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31DC2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D22A215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="RrM2ZGKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgABCf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:35:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34255 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgABCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:35:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id x17so17277663pln.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 18:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=famkZXGEeQgX6kTt3zfP2CBx94A2ZSijyfq87h1/O/k=;
        b=RrM2ZGKuFtlYa8euPTgXeh7EXT/63AdrQ0DWa90gJFC2TbgZxB0sAGRucp5apOQqYX
         rAKVim7RsUG2gggZUweJwKnL/SqYAiFVb7yO9uyIerfDOnZBjiGTDnHIrQlyGZQgAZiX
         X8FEYWhc8BE57wtup/5MX1eWp2bRjQVVne+ukFbJdLaPqcBSTULoAvcMLz6RkQBQi6TK
         oMGpbwNuHHPQCx81qt8Ev9TY0BO0bPGRvDt8UEbDA19AqSSLw8/YYVd2khV2DVMcFqun
         l4dj07ixwBTM0mqGdqaZdYs59T9tQqXEgnwhr7oUXk0mDJ3fQ3RYW9/bn9t2mk0U57se
         7oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=famkZXGEeQgX6kTt3zfP2CBx94A2ZSijyfq87h1/O/k=;
        b=Qu37xKJCJiLBoQznI5ZiwcdLNnjNcC90TKggmA0Hd/n7cDotmzE/LAGfIsr1ZfsiaO
         H25qSBvDhDwFih61PkOZoeSqt0FbxiNFZ/vPXpWf0toe8V1Im2DFpoLjeiAa0wpuy3o5
         qNhpWPyYz/R31A+7cBK7LhqZF5ZnzNTNckVvwp1qsflyxZ8FWfR2QYg3bLHf7UhnHd3g
         q5pxniFShLXzhnZwrtiGuOm5X/Fg6eFO5yCz1I4O72foYWLMNbYJMiiO68tqqb4JVAcT
         b3/ge6uUYp4OTWrYjooJ5M/zeTsLSnbpCegtT0R2vPwcvQLTi1U13qbksw+R4UYQCNDt
         f5fg==
X-Gm-Message-State: APjAAAX6ze67VRM0itPbXwU1QRGpEkEdwr2wRpsJuPgbMNkjouTj7P+e
        9u1pq/mQ913yBqVcfhpniSXLLA==
X-Google-Smtp-Source: APXvYqzPJGbJEhOV2liVhyCEtCAsbfPBxBSVZ5nd1mymfYEm8FcuDEEl57l/uWEMhSeK1otd1KYXJg==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr16624307pjg.98.1577932525255;
        Wed, 01 Jan 2020 18:35:25 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id s18sm56572809pfh.179.2020.01.01.18.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jan 2020 18:35:24 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH v2 1/2] misc: pvpanic: move bit definition to uapi header file
Date:   Thu,  2 Jan 2020 10:35:12 +0800
Message-Id: <20200102023513.318836-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200102023513.318836-1-pizhenwei@bytedance.com>
References: <20200102023513.318836-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processes outside of the kernel(Ex, QEMU) should know what the
value really is for, so move the bit definition to a uapi file.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c      | 3 +--
 include/uapi/misc/pvpanic.h | 8 ++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/misc/pvpanic.h

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 95ff7c5a1dfb..3f0de3be0a19 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -15,11 +15,10 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
 
-#define PVPANIC_PANICKED        (1 << 0)
-
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
new file mode 100644
index 000000000000..cae69a822b25
--- /dev/null
+++ b/include/uapi/misc/pvpanic.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __PVPANIC_H__
+#define __PVPANIC_H__
+
+#define PVPANIC_PANICKED	(1 << 0)
+
+#endif /* __PVPANIC_H__ */
-- 
2.11.0

