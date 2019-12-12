Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C71205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfXWPnMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfLLAHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:07:42 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:39338 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfLLAHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:07:40 -0500
Received: by mail-wr1-f73.google.com with SMTP id 90so286152wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tqxzx3Ju5IffICSGxw8fWf7dGguiPyd/gZ03a4SjbqI=;
        b=XfXWPnMa5C9owrCf/+ji/xMeTE8wXtHYUTdluQHNxwxu1kNLVP4Usmfz1rO3gCpCqy
         1Y4iw4ANp7BcDigb936glzSvlGiVWf2wSEXIAHjJhBhHpem9rHOxnxRLVqi5AQTe84Bl
         QLSFpqDTEUCY8tcQdMX2nS3zXP/ulwACZzb5dNDnXKg5yjL4ubnzTO7OK5Z8k+Bc2YJn
         U4ZdkD2Ji8v2Vc0nkpuh73BuHmjov3jpacvuA4T0a83v7iKy2WTJolZI0rYn1CBJ/ulq
         LTPHHiZnr5lyZ87WNs+jWae6FVjlxJTf3RS/aYTNgYzZuUUre/Y196fLP/RrVBNjIkoS
         +0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tqxzx3Ju5IffICSGxw8fWf7dGguiPyd/gZ03a4SjbqI=;
        b=X1L93fvQGK4xg06GfnlzIh7LkfJd/fQRlEyhzJ63qhclp5t6mnAK1J06DnV+PgF+ts
         F25uTQoU84t4TL45Hr8+VqeuP3MIbDvScuNt050DSF+7w/ZAt8HNz3TGLWXRYgpwpTfC
         elBQ76KQIY+wM+gx19cEMlda84Suh3RpwDITVNKcscUJaCYDwfJsUl4BM4K6HqvES2v3
         JRpfyDzwOtDOPCRDqG0Oyjnp4p72Rpd/J/Q/uDn8Lt8hpme2e0MeII8FVpoA3dJG7ovZ
         IfeAdLwv71h+K+N2zQvvMRD5sQCLHppylJ8pUqj8RoqkAFmNghogMZE/HWHKKIRR4aHN
         H9KA==
X-Gm-Message-State: APjAAAWFYKHmceGuXhIvW5gzx8Hdk3uqxAR5EjOeaULSZI6LuuJ5gxoH
        5DGJwlQLrUWt9ie6tTK58GYE7m7Btg==
X-Google-Smtp-Source: APXvYqxHsDRHohoVn3rn1JK7XS/6MbnhgdNntqQ/XqwtvzLlREaWFG236xbibKPak1cqL4C6Fh4OggzePA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr2678183wrs.159.1576109257933;
 Wed, 11 Dec 2019 16:07:37 -0800 (PST)
Date:   Thu, 12 Dec 2019 01:07:09 +0100
In-Reply-To: <20191212000709.166889-1-elver@google.com>
Message-Id: <20191212000709.166889-2-elver@google.com>
Mime-Version: 1.0
References: <20191212000709.166889-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH -rcu/kcsan 2/2] kcsan: Add __no_kcsan function attribute
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     torvalds@linux-foundation.org, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, akpm@linux-foundation.org,
        stern@rowland.harvard.edu, dvyukov@google.com,
        mark.rutland@arm.com, parri.andrea@gmail.com, edumazet@google.com,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the use of -fsanitize=thread is an implementation detail of KCSAN,
the name __no_sanitize_thread could be misleading if used widely.
Instead, we introduce the __no_kcsan attribute which is shorter and more
accurate in the context of KCSAN.

This matches the attribute name __no_kcsan_or_inline. The use of
__kcsan_or_inline itself is still required for __always_inline functions
to retain compatibility with older compilers.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler-gcc.h | 3 +--
 include/linux/compiler.h     | 7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0eb2a1cc411d..cf294faec2f8 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -146,8 +146,7 @@
 #endif
 
 #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
-#define __no_sanitize_thread                                                   \
-	__attribute__((__noinline__)) __attribute__((no_sanitize_thread))
+#define __no_sanitize_thread __attribute__((no_sanitize_thread))
 #else
 #define __no_sanitize_thread
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7d3e77781578..a35d5493eeaa 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -207,12 +207,15 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define __no_kasan_or_inline __always_inline
 #endif
 
+#define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
 /*
  * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled.
+ * compilation units where instrumentation is disabled. The attribute 'noinline'
+ * is required for older compilers, where implicit inlining of very small
+ * functions renders __no_sanitize_thread ineffective.
  */
-# define __no_kcsan_or_inline __no_sanitize_thread notrace __maybe_unused
+# define __no_kcsan_or_inline __no_kcsan noinline notrace __maybe_unused
 # define __no_sanitize_or_inline __no_kcsan_or_inline
 #else
 # define __no_kcsan_or_inline __always_inline
-- 
2.24.0.525.g8f36a354ae-goog

