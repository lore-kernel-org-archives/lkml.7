Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E8C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D4D2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bjzoL3Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfFQWUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:20:51 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33128 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfFQWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:47 -0400
Received: by mail-ed1-f50.google.com with SMTP id i11so18472601edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4X7F8q7eT9lTbwwuGST215m/GlU5pARTn7q/Pg4Vos=;
        b=bjzoL3CjhKbyuTWrEBG2PRgwvp0EB6W1c1NsR59J79xw0G1RdUw5tlt6L9S9FMv98O
         YLmlFdXZiN+ZNyE9ip3lqG/oZ1EEH9f4l8ki0WNXhTTd3poSJa7CJprcxLQhgXT7V/9n
         qpbFiHNSuszy/5xdkuhjLhnQxtzqYzkuqnxOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4X7F8q7eT9lTbwwuGST215m/GlU5pARTn7q/Pg4Vos=;
        b=d+wJhd3FpuYuuy4kxq9q5cnpdQzOwh17tr+tJlnczShBtopSMrLr5TRO6EWn5LLLEF
         b27LVjMBqGFuBliWUyBXlJgojmPhc3YpGNwpWp2uuiyTWvVarqIntXrQJFSFA5d+EEdX
         i7zhc5kGJa0hmP0QbV0UMjILsU3ZznZLPzG1VBN9CcJ+5BxiFfWBkvYiKsd3AiN8xalE
         4x/pgayf/tM+MAIN8QgbN24AiKu22M2/g+31HIJNBdx4Z0pmh9nu35lQB5YOuQYFJrHk
         PGdHjlN1QXyHUvRxkCA+uKPI//Tr5yHIswESI+2WstzUwQhKIi2Wfn9ABBp6aS8b6K9R
         Kx7Q==
X-Gm-Message-State: APjAAAW8AKg9BgEL+vMdTTUPK0V9IOG0hgP5nSGDqsevxfq2HpEna8u/
        YCuTFoelAms5rFWomQ1qEy7fOw==
X-Google-Smtp-Source: APXvYqxXobFMiwdnqnbuzTK2YoFCVT+c4EDoKVsVdnW7KJHbIYB1WcHaOMH+gtPstWAyIS3zOr8b9Q==
X-Received: by 2002:a50:94d9:: with SMTP id t25mr86885694eda.32.1560810045932;
        Mon, 17 Jun 2019 15:20:45 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v6 3/8] linux/printk.h: use unique identifier for each struct _ddebug
Date:   Tue, 18 Jun 2019 00:20:29 +0200
Message-Id: <20190617222034.10799-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for pr_debug_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374c47b1..54499c1a74fd 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -456,7 +456,7 @@ extern int kptr_restrict;
 /* If you are writing a driver, please use dev_dbg instead */
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define pr_debug_ratelimited(fmt, ...)					\
+#define _pr_debug_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -466,6 +466,8 @@ do {									\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
+#define pr_debug_ratelimited(fmt, ...)		\
+	_pr_debug_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug_ratelimited(fmt, ...)					\
 	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.20.1

