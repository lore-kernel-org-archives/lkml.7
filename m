Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C748CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A042084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ghul3xFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfJXWwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:09 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56025 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbfJXWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:03 -0400
Received: by mail-qk1-f202.google.com with SMTP id h18so336631qkj.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+pC1wUGnAfIzdtPt9JYqx48tH0ZogjxIc75X2woCblw=;
        b=Ghul3xFEQaQM5xzVBFQoG8U8HNwG42e7GeQtV27MTWSZRuGptIXTiXUGIjDHp/YIpT
         hClIyJ8yLd1+EE9qsR9Oss13EFC0aEBed0i7vXbPLw7n7Cz1HrHzSiWsA4EcykXlitoW
         K5h6f2Q+00V9aJmmUnI7P9/MLwLZ35DTumdhIT4mQ4ce7/IwgipCUWdP7+q+I8zT5OhO
         a+NHytq0v/YolBdJAa7n+PY0/a9IGtPsdaAIdeA5LZmh6S0ZyAYyOYEOeyhxqrKOFMvM
         QncsL/qfcrw8l2wQdAQW3JMAY3o7KpY74274D2H4sRGOglWCZipnGdOSYkKm6qs+y5EC
         TkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+pC1wUGnAfIzdtPt9JYqx48tH0ZogjxIc75X2woCblw=;
        b=g9JQH6xyf8w722+dLo0FYFEJVV9yxv3CbCIhr0t/auoDZW3GgmfmVfWYOA90yg3I/N
         sqO1GxsGBqnbGYsAA5XBS/0D61TbuaMqLiD/ma6iNxKGfyBe6NTzQL23vVgcPA7ZHgsP
         y6Lcwiw/l0svaobH8VyiDg4NhxdjHC1wa78UsXmmN9HwvPahItW8z3ZUgEtV60Q2XKwX
         VONSb/dEqITxsYxQrLqsCLyh/c1AzJOKcYwi7/3/hoahuEXdClcQXF3R+Rg6/t7GYVhH
         uYbqd/hZpAMFHQsCMLRvPhT5+ni+RUCi8O395C56iZt90feMk5c6WUPo6IXxYqR8idoI
         o4HQ==
X-Gm-Message-State: APjAAAVTE5CdfvR65X0AB6+SBvrC5V7AkVu6dnlb4Z+HvRIIXONJyhDE
        fQqio6HduqojgmU6RT1s1MIgg9so8s97b7Zl36s=
X-Google-Smtp-Source: APXvYqzM3I26bKb3wrnFe0tgT6a7QNS7VGM2eEEUUuU2H4VKLgtcE0Bg1aj8IG0janwPGy/Kg+c3iOCkFYjR2Y2rhpw=
X-Received: by 2002:a0c:e6e5:: with SMTP id m5mr375068qvn.170.1571957522490;
 Thu, 24 Oct 2019 15:52:02 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:22 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 07/17] scs: add support for stack usage debugging
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index b9e6e225254f..a5bf7d12dc13 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -154,6 +154,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(tsk);
+	uintptr_t s = (uintptr_t)p;
+
+	while (p < end && *p)
+		p++;
+
+	return (uintptr_t)p - s;
+}
+
+static void scs_check_usage(struct task_struct *tsk)
+{
+	static DEFINE_SPINLOCK(lock);
+	static unsigned long highest;
+	unsigned long used = scs_used(tsk);
+
+	if (used <= highest)
+		return;
+
+	spin_lock(&lock);
+
+	if (used > highest) {
+		pr_info("%s: highest shadow stack usage %lu bytes\n",
+			__func__, used);
+		highest = used;
+	}
+
+	spin_unlock(&lock);
+}
+#else
+static inline void scs_check_usage(struct task_struct *tsk)
+{
+}
+#endif
+
 bool scs_corrupted(struct task_struct *tsk)
 {
 	return *scs_magic(tsk) != SCS_END_MAGIC;
@@ -168,6 +206,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	scs_task_init(tsk);
-- 
2.24.0.rc0.303.g954a862665-goog

