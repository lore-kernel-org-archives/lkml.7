Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0351C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AF622DA9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayztbxcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfHSXlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:41:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42947 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfHSXlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:41:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so2124620pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndCaMtJVRFCFpuEAuYUAm3sbqaCuhfpOV0yimySsF9c=;
        b=ayztbxcgRt6M2/mj99/k+Bod1keHWx323G5KA79M3xmiIvq6hUALeUleEP4NMdsOkv
         EhpbaiK3AUQptjg71XNwz02I5jz4cPaJEABnQbCMw/6qQ607Uin/Fd/6FWFm8jFR9eyl
         sNMC6QNWNzjozycodonQUWxbZmx5M/kNGJlmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndCaMtJVRFCFpuEAuYUAm3sbqaCuhfpOV0yimySsF9c=;
        b=UFgFf34VrG+5ohAllSWdxVCGALEOhCJ3WEWDbtpEOtTnMPEVXm6Tht2iXtba6eHsqX
         NEaZQbYa5gN236A5d/PjmmhhdDpVebg7Gzssx9tiWPtBn3U2HzSRP13ryhn3CIZGy+dl
         ic1cBZpdIokkZiVVWdwzSNdyNgwDyDd5LXuLr/1m1Lzuv+O89h6QM2gvPtYuWW2saYGA
         w+FzJlkvFi6VhvRCrjiC+sy/zd3v3CcmqzjqMY2oUtbckrmSpr8pQUNM46Zeqy9phtn1
         f5Z4q5nVezLahnJLB88mu7xVtH7ed5nt+2DIUQ8MK5zhFvPk/vgh3p3mAnLhvlZ2Mmju
         1tLQ==
X-Gm-Message-State: APjAAAU4dRzwp9coYB+7cdXnbB3ZN9eHPBAOuuEXB9dSbkf4OUmO47rs
        vHlz4wb6A88k+8QAhlCC9PBfLQ==
X-Google-Smtp-Source: APXvYqyPjSnicM/lgIC6fOw9Ktv3xAyr8RBLemy9cm+wQjoj4kzaWdHMetN644yt5LoBEcRId7+IEw==
X-Received: by 2002:a17:90a:de02:: with SMTP id m2mr23331561pjv.18.1566258081698;
        Mon, 19 Aug 2019 16:41:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c70sm23442423pfb.163.2019.08.19.16.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:20 -0700 (PDT)
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
Subject: [PATCH 6/7] bug: Consolidate __WARN_FLAGS usage
Date:   Mon, 19 Aug 2019 16:41:10 -0700
Message-Id: <20190819234111.9019-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having separate tests for __WARN_FLAGS, merge the two #ifdef
blocks and replace the synonym WANT_WARN_ON_SLOWPATH macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 18 +++++++-----------
 kernel/panic.c            |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6ea8d258cb96..588dd59a5b72 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -61,16 +61,6 @@ struct bug_entry {
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
 
-#ifdef __WARN_FLAGS
-#define WARN_ON_ONCE(condition) ({				\
-	int __ret_warn_on = !!(condition);			\
-	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS(BUGFLAG_ONCE |			\
-			     BUGFLAG_TAINT(TAINT_WARN));	\
-	unlikely(__ret_warn_on);				\
-})
-#endif
-
 /*
  * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
  * significant kernel issues that need prompt attention if they should ever
@@ -91,7 +81,6 @@ struct bug_entry {
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
-#define WANT_WARN_ON_SLOWPATH
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
@@ -105,6 +94,13 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
 	} while (0)
+#define WARN_ON_ONCE(condition) ({				\
+	int __ret_warn_on = !!(condition);			\
+	if (unlikely(__ret_warn_on))				\
+		__WARN_FLAGS(BUGFLAG_ONCE |			\
+			     BUGFLAG_TAINT(TAINT_WARN));	\
+	unlikely(__ret_warn_on);				\
+})
 #endif
 
 /* used internally by panic.c */
diff --git a/kernel/panic.c b/kernel/panic.c
index dc2243429903..233219b3fb34 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -588,7 +588,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	add_taint(taint, LOCKDEP_STILL_OK);
 }
 
-#ifdef WANT_WARN_ON_SLOWPATH
+#ifndef __WARN_FLAGS
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
-- 
2.17.1

