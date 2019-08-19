Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFBC20644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="boYXQgUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfHSXlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:41:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfHSXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:41:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so2125320pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HvtOVzdzU3wFN+jfOqC7eykX14KYjG+c7qizRM/FE08=;
        b=boYXQgUkeWXfwExOs7D3W8lXej3rIi85Yhrp20e41WcqqhulPHYLmlA1xiL3ZUZOSM
         opS2VpxxJHEjwDaZwnaq5iUWNYHEGjCdOB/cshRQ3ZZOdKuMGHJuy0AD5nRC47txa08N
         bQXjgKE01+Z/6haEQ9wRPGh8AFtVS6oUEoAcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HvtOVzdzU3wFN+jfOqC7eykX14KYjG+c7qizRM/FE08=;
        b=ZhM44ZedKD6DitpZtrvZrMdkLCV5AqVWKtML2WbWLBN+ROpCPG+ewkDUyrxrcxNAj9
         Hzb3RBrB3GkSbc+RgNPpNXRNEGKGHdTagf32ZYGLRKi66Gz7PO7EJgdk36Q2sCGWHrCJ
         nyh4bfoi/O9sG7MhDKwjEWwzqRUR77hwrQ8f5g4JX5gJMiTi2PzUX/Fc0eBEdBfKKlJf
         6703tojSMKtDBioFZLpucWW57phHEkVeQQQSla4/lnaMs8vFdviws1FMCRTG6Nsj2DdD
         zf5gZaTGXp2Hf1V62nY0KBH8p+BF/kuWp+Vfnufk3rOtoM5V8JbTpvLJ+a9rQh9XcrIQ
         Ld1w==
X-Gm-Message-State: APjAAAXkVXywx3DF1MikjWrnpTfQHHTOtZt3ZgRj4lJF3bxQNM1Vy07S
        JEejtr6bQmvn90Zcejcrzh7+aQ==
X-Google-Smtp-Source: APXvYqzZ0bFDie1zp2Bmz5Lz7TS6xiAcc+pOh8XgfkghW2Jb3yJUuG+ovrvL3KiOjQHKVsan+tNDbg==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr22753827pjb.35.1566258077690;
        Mon, 19 Aug 2019 16:41:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm32073025pfq.85.2019.08.19.16.41.16
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
Subject: [PATCH 2/7] bug: Rename __WARN_printf_taint() to __WARN_printf()
Date:   Mon, 19 Aug 2019 16:41:06 -0700
Message-Id: <20190819234111.9019-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just renames the helper to improve readability.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index ce466432ac3e..e9166a24b336 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -96,14 +96,14 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
 #define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
-#define __WARN_printf_taint(taint, arg...)				\
+#define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN() do { \
 	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
 } while (0)
-#define __WARN_printf_taint(taint, arg...)				\
+#define __WARN_printf(taint, arg...)					\
 	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
 #endif
 
@@ -127,7 +127,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf_taint(TAINT_WARN, format);		\
+		__WARN_printf(TAINT_WARN, format);			\
 	unlikely(__ret_warn_on);					\
 })
 #endif
@@ -135,7 +135,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN_TAINT(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf_taint(taint, format);			\
+		__WARN_printf(taint, format);				\
 	unlikely(__ret_warn_on);					\
 })
 
-- 
2.17.1

