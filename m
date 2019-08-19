Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1072C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E7320644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QnrNmbkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfHSXll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:41:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40748 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHSXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:41:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so1725149pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KrfPYPW7hHpyGdKfhM0Fbj+aqAYec03XNpT7CUlwk48=;
        b=QnrNmbkOAfu8bxBlGCuJMiF5SR6TGcun3cWqx/xhCswSSSrYf3m83zf7ILnxVROdPw
         XMcb4j6OAOjtQ9zgwEeaIgrhH8x1wiEGw1ASR2J6zMoeBqqoTljvEV8/PiLUhD0Eu/nh
         lNkfB0rbkhO91GROHRzAkXN7hjKYzdIGYZ3MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KrfPYPW7hHpyGdKfhM0Fbj+aqAYec03XNpT7CUlwk48=;
        b=MH0U4HpH56KiXBPghEUfkbjs+++v9V9gvNyQ9ZdWVLgyBoHgcl2Tijb5j2CDkPkXv+
         gCvHJnYjTL29dRyIxwRwiXVKqA3ZO9jvjIpjtwND33429Uke5nA5Rsk8zIOZVNlNhU/X
         HU9g1nHns4F9bxrbVAjw8S4iC+dxgudD3uX3w6PNyeTXbCqiW31kyeD+VHqrkpzRneQY
         1UUcLEvHvD9sdhTjAERDOOqsRwZ6CvETWLV/WfsGcVF/pjBVo01m8Gc2ABG/rensMrbm
         wtuc9KtegZ08PcvOHjnAb9g1vURCadORB0Kl2Bg+SiNBaZsxxgP1FSy2s7jhJtRY2fgR
         6f1g==
X-Gm-Message-State: APjAAAVW+vH4/03W933HRt7umNYHATiNr4U7sLsG5+ieCs28tseOzCkk
        n/J73L+k3Sx9Tm1khighi4cSuQ==
X-Google-Smtp-Source: APXvYqygsG7Fmp4twlPCBffxDxd1vDdewld+4/vgBMugHA0mY4ldJc3AQlhlyLfHr+Y64lj9tD0b4Q==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr25019254pld.101.1566258079631;
        Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3sm13378834pjo.3.2019.08.19.16.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Drew Davenport <ddavenport@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] bug: Consolidate warn_slowpath_fmt() usage
Date:   Mon, 19 Aug 2019 16:41:07 -0700
Message-Id: <20190819234111.9019-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a separate helper for no printk output, just
consolidate the logic into warn_slowpath_fmt().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h |  3 +--
 kernel/panic.c            | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index e9166a24b336..f76efbcbe3b5 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -93,9 +93,8 @@ struct bug_entry {
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
-extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
-#define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
+#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d8b7577c82c..51efdeb2558e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -597,19 +597,19 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 {
 	struct warn_args args;
 
+	if (!fmt) {
+		pr_warn(CUT_HERE);
+		__warn(file, line, __builtin_return_address(0), taint,
+		       NULL, NULL);
+		return;
+	}
+
 	args.fmt = fmt;
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
 }
 EXPORT_SYMBOL(warn_slowpath_fmt);
-
-void warn_slowpath_null(const char *file, int line)
-{
-	pr_warn(CUT_HERE);
-	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL, NULL);
-}
-EXPORT_SYMBOL(warn_slowpath_null);
 #else
 void __warn_printk(const char *fmt, ...)
 {
-- 
2.17.1

