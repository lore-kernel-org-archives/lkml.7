Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918CAC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AE8206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXuPCZw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLFWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:18 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39747 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLFWOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:14 -0500
Received: by mail-pg1-f201.google.com with SMTP id v2so1343676pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dSkqIg9MhTEqSRuUPD+wLwf3dmJwcSH5rhdG+lQGY0Y=;
        b=SXuPCZw5St6pvwTst8kmf5KElVFLKMFMp+CAkmkUaQLus5cyU/8kqr6V5JxAIwmDV8
         RWdDAn+WZ18vV4T9eqQoonAjHW3Rzl/rq+nVdoOiKpP2KO897WS7qgb0uHjTrgJkEo1F
         0w2fuPU7iE//Mhmc1AStldjXFL0gQujdjqFyhIQqo0PX3BYn+fe6w0aILNtXks9GiWbX
         y15Zqo4dF7akKdP8o3QHjsZgpRBi+Vh9QT2pwFLxPBRKjS+x9TmrUCopcszBpJQvv4wL
         EQLbAdHZz6TZ6uqyOto/Ft9UcaQoXc6w3u8Hni2mOOXu4O7zVJWi0IlEALO+ifSUBL0a
         F4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dSkqIg9MhTEqSRuUPD+wLwf3dmJwcSH5rhdG+lQGY0Y=;
        b=ag/OkMXhRR4JLbQ9m1ef2TtPuwk0iupZTBo/Ta/7ICD55ui3E9A/3EJ1TFueObSNi+
         7nUrCNabp56wkO7alaZu8WUx7n72OPG+THhlxP+hW7e+q7+91OVplcwwZhTc5wi2d+EY
         dxN9R0cngWL97XmoQUXJgJJkn894KIGBsOoGBXbbY8i7GdskeVXNUvDdehZSlO3Wus+A
         ovkkRnEb/6UTTiH2yFLnqOl94V8zIfp/0TrCav7rLwjhBNDgigWhv7Hvjret51ZZFaVm
         moec5oABRpcvrpzGDDqWzSC5RzVJ0kiE7jtjqYxO8P8uy93TRZyzQykWxj7x0NxY92pB
         Y/DA==
X-Gm-Message-State: APjAAAUzOHsxCb9V6kEOWakBMIaXrVt83e3hkdwTgDXPzQeDWU+UlKnd
        2zqtrJ1GP9tqcJdJVCoNF64FYta0mICccNTbmwE=
X-Google-Smtp-Source: APXvYqwr9gV3C2U9Vw8KNYzBqn9JcBiVcajDSJ2lm7uPyamXFOot36lh81Wh0+CfZKTc60xlWZW4gj6RW7XavjkgTmE=
X-Received: by 2002:a63:4b52:: with SMTP id k18mr5960727pgl.371.1575670454000;
 Fri, 06 Dec 2019 14:14:14 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:43 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 07/15] scs: add support for stack usage debugging
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
also prints out the highest shadow stack usage per process.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 5245e992c692..ad74d13f2c0f 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -184,6 +184,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(p);
+	unsigned long s = (unsigned long)p;
+
+	while (p < end && READ_ONCE_NOCHECK(*p))
+		p++;
+
+	return (unsigned long)p - s;
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
+		pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
+			tsk->comm, task_pid_nr(tsk), used);
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
 	unsigned long *magic = scs_magic(__scs_base(tsk));
@@ -200,6 +238,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	task_set_scs(tsk, NULL);
-- 
2.24.0.393.g34dc348eaf-goog

