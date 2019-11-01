Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB6CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B3E21906
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oC92Xyk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfKAWMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:23 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43649 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfKAWMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:21 -0400
Received: by mail-pl1-f202.google.com with SMTP id a3so7160581pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YuceP/m4Sv7I7vrWsOPJ1pSb3CxvhwOwQ1OQoGSTS4o=;
        b=oC92Xyk4xx4OFjCywUW0xRGLKJPopJyks6H3DIWfvMcqM41QRHY8A6HpLSO2oO1inw
         7nVZsYb0ejRziH+5dLCL9D9wKeQQKeMEb1VUrkYc1cMPvyFcm3It+tNXG+Hwcj7gshxb
         6nHSjR+gi4hodQFSJLJDhZIR1+Kzve8eUQ6q7dVUcbIISZ2N2+mSkGwMJQvydH28gjMd
         oRMh4SmcetuL5E9614gPeg7eJPENTgrxaRMgcD0aWe9YQNHjd9wnZeZVxQ0kRl59z7of
         8623sjz/SPs/pQv7SS4ugqqYKNBb1daNI8KHgf/+dBsRhEhkLc4Q35KQzw9rmfiSpNPD
         e0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YuceP/m4Sv7I7vrWsOPJ1pSb3CxvhwOwQ1OQoGSTS4o=;
        b=mCZgZLUQpKNFZ1eC7nHlSGME0sXFjTMYY/ZxLyB4fpyVt+a4qw/DULLoHULk0bYwsL
         i9y/vMLsnUYMk6iEQIA6wqwGKCOlipmHgEXbVMMoM4abPuQFGnZGHh+GShXc6KIfgURD
         hSUmy39wW9LAB5Fcn7uc/u3FxVD39+z9x5bYacGJVt5jtQnqzOVqUJ0aiyeN8cR3DtIu
         dhIJvSSWThDMC7VEf/5ITc4wRg4/IjHZVQzn+XLX1RAy1zCmLohTYnmf5CXyYW5Ra3s0
         fPeGDo7KX+Q7RPlBnRGhSyS3eNqkh9sKadh6XWfqVbLbK72DtbD05DEWyzZb0ki+OA0Q
         f5iA==
X-Gm-Message-State: APjAAAVYLMprcjqfQtYtgaCSaq1rGd0n2Msk08KOP8+p4oBDcxArx3Z1
        PYA6OcKlyc9l4YpjfoHl5iAdmhXLkrKbSkdlE3g=
X-Google-Smtp-Source: APXvYqyESI1nj79EQYAfPNp7QT9azRRC93peb8wyxMPp245spxyPTFrWPJ4dhblj2gZ8cJDr8g3hFVKQrrU1shqGWxs=
X-Received: by 2002:a63:2b8e:: with SMTP id r136mr2674046pgr.103.1572646338730;
 Fri, 01 Nov 2019 15:12:18 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:42 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 09/17] arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

This allows CONFIG_KRETPROBES to be disabled without disabling
kprobes entirely.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/probes/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c4452827419b..98230ae979ca 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -551,6 +551,7 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 	return (void *)orig_ret_address;
 }
 
+#ifdef CONFIG_KRETPROBES
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
@@ -564,6 +565,7 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
+#endif
 
 int __init arch_init_kprobes(void)
 {
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

